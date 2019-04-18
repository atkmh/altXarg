<%@ LANGUAGE=VBScript %>
<% Option Explicit %>
<% Response.Expires = 0 %>

<% if Session("FONTSIZE") = "" then %>
	<!--#include file="iito.inc"-->
<% else %>

<% 
Const L_PREVBACKUPS_TEXT = "Previous Backups"
Const L_BACKUPNAME_TEXT = "Name"
Const L_BACKUPDATE_TEXT = "Date"
Const L_NUM_TEXT = "#"
Const L_SAMPLEBACKUP_TEXT = "MyBackup"
Const L_GETNAME_TEXT = "Configuration Backup Name"
Const L_SELECTITEM_TEXT = "Please select a backup to remove."

On Error Resume Next


function heading(width,thestring)
	Dim i
	width=width - len(thestring)
	for i=width to 0 step -1
		thestring=thestring & "&nbsp;"
	Next
	heading=thestring
end function
%>

<HTML>
<HEAD>
	<TITLE></TITLE>
</HEAD>

<BODY BGCOLOR="#CCCCCC" LINK="#000000" VLINK="#000000" TOPMARGIN=10 TEXT="#000000" onLoad="setList();loadHelp();">
<FORM NAME="userform">

<TABLE WIDTH=490 BORDER=0>
	<TR>
		<TD COLSPAN=3 STYLE="font-face: Helv,Arial; font-size:10pt;">
			<FONT SIZE=1 FACE="Helv,ARIAL">
				<%= L_PREVBACKUPS_TEXT %>
				<BR>&nbsp;
			</FONT>
		</TD>
	</TR>
</TABLE>

<TABLE BORDER=1 BORDERCOLORDARK="#CCCCCC" BORDERCOLORLIGHT="#CCCCCC" CELLSPACING=0 CELLPADDING=2>
<TR>
<TD BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#FFFFFF" BORDERCOLORLIGHT="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;"><FONT SIZE=1 FACE="HELV,ARIAL">
	<A HREF="javascript:sortList('blocation','str');">
	<% if Session("FONTSIZE")="LARGE" then %>
		<%= heading(40,L_BACKUPNAME_TEXT) %>
	<% else %>
		<%= heading(49,L_BACKUPNAME_TEXT) %>	
	<% end if %>
	</A>
	</FONT>
</TD>
<TD BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#FFFFFF" BORDERCOLORLIGHT="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;"><FONT SIZE=1 FACE="HELV,ARIAL">
	<A HREF="javascript:sortList('bversion','str');">
	<% if Session("FONTSIZE")="LARGE" then %>
		<%= heading(1,L_NUM_TEXT) %>
	<% else %>
		<%= heading(1,L_NUM_TEXT) %>	
	<% end if %>
	</A>
	</FONT>
</TD>
<TD  BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#FFFFFF" BORDERCOLORLIGHT="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;"><FONT SIZE=1 FACE="Helv,ARIAL">
	<A HREF="javascript:sortList('bdate','str');">
	<% if Session("FONTSIZE")="LARGE" then %>
		<%= heading(25,L_BACKUPDATE_TEXT) %>
	<% else %>
		<%= heading(38,L_BACKUPDATE_TEXT) %>	
	<% end if %>		
	</A>
	</FONT>
</TD>
</TR>
</TABLE>

</FORM>

<FORM name="hiddenform">
	<INPUT TYPE="hidden" NAME="index" VALUE=-1>
</FORM>
</BODY>
<SCRIPT LANGUAGE="JavaScript">

	function loadHelp(){
		top.title.Global.helpFileName="iipx_1";
	}

	function setList(){
		parent.list.location.href="iibkupls.asp?text=Loading...";
		top.hlist.location.href = "iibkupset.asp";
	}

	function loadList(){
		parent.list.location.href="iibkupls.asp";
	}

	function addItem(){
		i=cachedList.length
		blocation = prompt("<%= L_GETNAME_TEXT %>","<%= L_SAMPLEBACKUP_TEXT %>");
		
			if ((blocation != "") && (blocation != null)){	
				top.hlist.location.href = "iiaction.asp?a=Backup&bkupName=" + escape(blocation);		
				listFunc.id =i;
		}

	}

	function delItem(){
		if (listFunc.id  >= 0){
			i=eval(listFunc.id );			
			blocation = escape(cachedList[i].blocation);
			bversion = escape(cachedList[i].bversion);		
			top.hlist.location.href = "iiaction.asp?a=BackupRmv&bkupName=" + blocation + "&bkupVer=" + bversion;		
		}
		else{
			alert("<%= L_SELECTITEM_TEXT %>");
		}

	}
	function setLastSel(id){
		for (var i=0; i < cachedList.length; i++) {
			if (cachedList[i].id == id){
				listFunc.id = i;
				return;
			}
		}
		
	}
	
	function sortList(sortby,sorttype)
		{
		i=eval(listFunc.id);

		if (i != -1)
		{
			lastsel = cachedList[i].id;
		}
		
		if (sortby != listFunc.sortby)
			{
			listFunc.sortby = sortby;
			listFunc.sortAsc = true;
			}
		else
			{
			listFunc.sortAsc = !listFunc.sortAsc;
			}

		if (sorttype == "str")
			{
			cachedList.sort(sortOrder);
			}
		else
			{ 
			cachedList.sort(numOrder);
			}
						
		if (!listFunc.sortAsc)
			{
			cachedList.reverse();
			}
			
		if (i != -1)
		{
			setLastSel(lastsel);			
		}
		loadList();
		}

	function sortOrder(a,b)
		{
		if (a[listFunc.sortby] < b[listFunc.sortby])
			{
			return -1;
			}
		else
			{
			if (a[listFunc.sortby] > b[listFunc.sortby])
				{
				return 1;
				}
			else
				{
				return 0;
				}
			}
		}


	function buildListForm(){
		numrows=0;
		for (var i=0; i < cachedList.length; i++) {
			numrows=numrows + 1;
		}
		qstr="numrows="+numrows;
		qstr=qstr+"&cols=ServerBindings&cols=SecureBindings"

		top.hlist.location.href="iihdn.asp?"+qstr;
		<% 'the list values will be grabbed by the hiddenlistform script... %>
	}

	function SetListVals(){

	}
	

	function SetLocale(datestr){

		thisdate = new Date(datestr);
		thisyear = thisdate.getFullYear();
		if (thisyear < 1980) {
			thisdate.setFullYear(thisyear + 100);
		}
		tzdiff=thisdate.getTimezoneOffset()
		hrsdiff=parseInt(tzdiff/60)
		mindiff=tzdiff%(hrsdiff*60)
		thisdate.setHours(thisdate.getHours() - hrsdiff);
		thisdate.setMinutes(thisdate.getMinutes() - mindiff);
	
		return thisdate.toLocaleString(); 
	}	

	function listFuncs(){
		this.id = -1;
		this.addItem=addItem;
		this.delItem=delItem;
		this.loadList=loadList;
		this.writeList=buildListForm;
		this.SetListVals=SetListVals;
		this.mainframe = top.opener.top;		
	}

	function listObj(i,d,l,v){
		this.id = i;
		this.blocation=l;
		this.bversion=v;		
		this.bdate=SetLocale(d);
		this.deleted=false;
		this.newitem=false;
		this.updated=false;
	}

	cachedList=new Array()

	listFunc=new listFuncs();

</SCRIPT>

</HTML>

<% end if %>
