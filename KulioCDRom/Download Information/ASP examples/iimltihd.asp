<%@ LANGUAGE=VBScript %>
<%'Option Explicit %>
<% Response.Expires = 0 %>

<% if Session("FONTSIZE") = "" then %>
	<!--#include file="iito.inc"-->
<% else %>

<% 
Const L_MULTIPLE_TEXT="Multiple identities for this web site."
Const L_IPADDRESS_TEXT="IP Address"
Const L_IPPORT_TEXT="TCP Port"
Const L_SSLPORT_TEXT="SSL Port"
Const L_HOST_TEXT="Host Header Name"
Const L_ACCESSDENIED_TEXT="Access Denied"
Const L_SELECTITEM_TEXT="Please select an item to delete."
dim listSort

listSort = Session("ListSort")

function heading(width,thestring,sortstr)
	dim i
	width = width - len(thestring)
	for i = width to 0 step -1
		thestring = thestring & "&nbsp;"
	Next

	if listSort and (sortstr <> "") then
		thestring = "<A HREF = " & quote & "javascript:sortList('"& sortstr & "');" & quote & ">" & thestring & "</A>"
	end if
	
	heading = thestring
end function
%>

<HTML>
<HEAD>
	<TITLE></TITLE>
</HEAD>

<BODY BGCOLOR="#CCCCCC" LINK="#000000" VLINK="#000000" ALINK="navy" TOPMARGIN=10 TEXT="#000000" onLoad="loadList();loadHelp();">
<FORM NAME="userform">

<TABLE WIDTH=490 BORDER=0>
	<TR>
		<TD COLSPAN=3 STYLE="font-face: Helv,Arial; font-size:10pt;">
			<FONT FACE="Helv,Arial" SIZE=1>
				<%= L_MULTIPLE_TEXT %>
				<BR>&nbsp;
			</FONT>
		</TD>
	</TR>
</TABLE>

<TABLE BORDER=1  BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#CCCCCC" BORDERCOLORLIGHT="#CCCCCC" CELLSPACING=0 CELLPADDING=2>
<TR>
<TD BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#FFFFFF" BORDERCOLORLIGHT="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;">
<FONT FACE="Helv,Arial" SIZE=1>
	<% if Session("FONTSIZE")="LARGE" then %>
		<%= heading(36,L_IPADDRESS_TEXT, "ipaddress") %>
	<% else %>
		<%= heading(28,L_IPADDRESS_TEXT, "ipaddress") %>	
	<% end if %>
	</FONT>
</TD>
<TD  BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#FFFFFF" BORDERCOLORLIGHT="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;">
<FONT FACE="Helv,Arial" SIZE=1>
	<% if Session("FONTSIZE")="LARGE" then %>
		<%= heading(8,L_IPPORT_TEXT, "ipport") %>
	<% else %>
		<%= heading(7,L_IPPORT_TEXT, "ipport") %>	
	<% end if %>		
	</FONT>
</TD>
<TD  BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#FFFFFF" BORDERCOLORLIGHT="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;">
<FONT FACE="Helv,Arial" SIZE=1>
	<% if Session("FONTSIZE")="LARGE" then %>
		<%= heading(8,L_SSLPORT_TEXT, "sslport") %>
	<% else %>
		<%= heading(10,L_SSLPORT_TEXT, "sslport") %>	
	<% end if %>
	</FONT>	
</TD>
<TD  BORDERCOLOR="#CCCCCC" BORDERCOLORDARK="#FFFFFF" BORDERCOLORLIGHT="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;">
<FONT FACE="Helv,Arial" SIZE=1>
		<% if Session("FONTSIZE")="LARGE" then %>
			<%= heading(40,L_HOST_TEXT, "host") %>
		<% else %>
			<%= heading(30,L_HOST_TEXT, "host") %>
		<% end if %>
	</FONT>	
</TD>
</TR>
</TABLE>
</FORM>

<FORM name="hiddenform">
	<INPUT TYPE="hidden" NAME="index" VALUE=0>
</FORM>
</BODY>
<SCRIPT LANGUAGE="JavaScript">


	function loadHelp(){
		top.title.Global.helpFileName="iipy_27";
	}

	function loadList(){
		parent.list.location.href="iimltils.asp";
	}

	function addItem(){
		i=cachedList.length
		listFunc.noupdate = true;	
		cachedList[i]=new listObj(i,"","","","");
		cachedList[i].newitem=true;
		cachedList[i].updated=true;
		document.hiddenform.index.value=i;
		loadList();
	}

	function delItem(){

		if (document.hiddenform.index.value >= 0){
			i=eval(document.hiddenform.index.value);
			listFunc.noupdate = true;				
			cachedList[i].deleted=true;
			cachedList[i].updated=true;
			 i=i-1;
			<% 'run through the list to find the Next non-deleted item %>
			for (var j=i; j >=0; j--) {

				if (cachedList[j].deleted){
				}
				else{
					break			
				}
			}	

			document.hiddenform.index.value=j;

			loadList();

		}
		else{
			alert("<%= L_SELECTITEM_TEXT %>");
		}
	}
	
	function setLastSel(id){
		for (var i=0; i < cachedList.length; i++) {
			if (cachedList[i].id == id){
				document.hiddenform.index.value = i;
				return;
			}
		}
		
	}

	function sortList(sortby)
		{
		
		i=eval(document.hiddenform.index.value);
		if ( i != -1)
		{
			lastsel = cachedList[i].id
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
			
		var num = parseFloat(cachedList[sortby]);
		
		if (isNaN(num))
			{
			cachedList.sort(sortOrder);
			}
		else
			{ 
			cachedList.sort(numOrder);
			}
		if ( i != -1)
		{
			setLastSel(lastsel);
		}
		loadList();
		}

	function sortOrder(a,b)
	{

		
		if (listFunc.sortAsc){
			astr = a["isSecure"] + a[listFunc.sortby];
			bstr = b["isSecure"] + b[listFunc.sortby];
			
			if (astr.toLowerCase() < bstr.toLowerCase()){
				return -1;
			}
			else{
				if (astr.toLowerCase() > bstr.toLowerCase()){
					return 1;
				}
				else{
					return 0;
				}
			}			
		}
		else{
			astr = !a["isSecure"] + a[listFunc.sortby];
			bstr = !b["isSecure"] + b[listFunc.sortby];
			
			if (astr.toLowerCase() < bstr.toLowerCase()){
				return 1;
			}
			else{
				if (astr.toLowerCase() > bstr.toLowerCase()){
					return -1;
				}
				else{
					return 0;
				}
			}
		}
	}
	
	function reSort(){
		//set our sortAsc so we aren't just reversing the list...
		listFunc.sortAsc = !listFunc.sortAsc;
		sortList(listFunc.sortby);
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
		listForm=top.hlist.document.hiddenlistform;
		j=0;
		var bindings = "";
		first=true;
		for (var i=0; i < cachedList.length; i++) {
			if (!cachedList[i].deleted){
				if (first)
				{
					top.opener.document.userform.hdnPort.value= cachedList[i].ipport;
					top.opener.document.userform.hdnIPA.value= cachedList[i].ipaddress;
					top.opener.document.userform.hdnHost.value= cachedList[i].host;
					first = false;
				}
				if (cachedList[i].sslport != ""){	
					listForm.elements[j++].value="";
					listForm.elements[j++].value=cachedList[i].ipaddress+":"+cachedList[i].sslport +":"+cachedList[i].host;
				}
				else{
					bindings += (cachedList[i].ipaddress+":"+cachedList[i].ipport+":"+cachedList[i].host + ",");
					listForm.elements[j++].value=cachedList[i].ipaddress+":"+cachedList[i].ipport+":"+cachedList[i].host;
					listForm.elements[j++].value="";
				}
			}
			cachedList[i].updated=false; 
		}
		top.opener.document.userform.ServerBindings.value = bindings

	}

	function listFuncs(){
		this.bHasList = true;
		this.sortList = sortList;
		this.reSort = reSort;		
		this.sortby = "ipaddress";
		this.sortAsc = true;
		this.addItem=addItem;
		this.delItem=delItem;
		this.writeList=buildListForm;
		this.SetListVals=SetListVals;
		this.mainframe = top.opener.top;		
		this.lastSel = 0;
		this.noupdate = false;
	}

	function listObj(id,ia,ip,sp,hn){
		this.id = id;
		this.isSecure = (sp != "");
		this.ipaddress=ia;
		this.ipport=ip;
		this.sslport=sp;
		this.host=hn;
		this.deleted=false;
		this.newitem=false;
		this.updated=false;
	}
	listFunc=new listFuncs();
	cachedList=new Array()

<!--#include file="iibind.inc"-->
		
<%  

	On Error Resume Next 

	Dim path, currentobj
	Dim aBinding, ssl, arraybound, Binding, SecureBinding
	Dim barraysize, added, i, j, nexti
	
	path=Session("spath")
	Session("path")=path
	Session("SpecObj")=path
	Session("SpecProps")="ServerBindings"	
	Set currentobj=GetObject(path)

 
 	Redim aBinding(UBound(currentobj.ServerBindings))
 	Redim ssl(UBound(currentobj.SecureBindings))	
	
	aBinding=currentobj.ServerBindings
	ssl=currentobj.SecureBindings

	if not IsArray(ssl) then
		ssl=Array(1)
		ssl(0)=currentobj.SecureBindings
	end if

	nexti=0
	arraybound=UBound(aBinding)
	if aBinding(0) = "" then
		aBinding(0) = ":80:"
	end if
	for i=0 to arraybound
		Binding=getBinding(aBinding(i))
		 %>cachedList[<%= i %>]=new listObj(<%= i %>,"<%= Binding(0) %>","<%= Binding(1) %>","","<%= Binding(2) %>");<%  		
	Next
	nexti = i

	arraybound=UBound(ssl)
	for each secitem in ssl
		SecureBinding=getBinding(secitem)
		%>cachedList[<%= nexti %>]=new listObj(<%= nexti %>,"<%= SecureBinding(0) %>","","<%= SecureBinding(1) %>","<%= SecureBinding(2) %>");<%  
		nexti=nexti + 1	
	Next
 %>




</SCRIPT>

</HTML>

<% end if %>