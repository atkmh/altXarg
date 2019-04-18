<%@ LANGUAGE=VBScript %>
<% Option Explicit %>
<% Response.Expires = 0 %>

<% if Session("FONTSIZE") = "" then %>
	<!--#include file="iito.inc"-->
<% else %>

<% 
Const L_ADDWEBUSERS_TEXT = "Web Site Operators"
Const L_ADDFTPUSERS_TEXT = "FTP Site Operators"
Const L_LISTNAMES_TEXT = "Grant operator privileges on this site only to these Windows NT User Accounts:"
Const L_BUILTIN_TEXT = "BUILTIN\"
Const L_ENTERTRUSTEE_TEXT = "Enter a domain and user name."
Const L_ADMINISTRATORS_TEXT = "Administrators"
Const L_DELERROR_TEXT = "You may not delete local administrator privileges from this site."
Const L_SAMPTRUSTEE_TEXT = "DOMAIN\\username"
Const L_SELECTITEM_TEXT = "You must first choose a user from the list to remove."
Const L_EVERYONE_TEXT = "Everyone"
On Error Resume Next 

Dim path, currentobj

path=Session("spath")
Session("path")=path
Set currentobj=GetObject(path)
Session("SpecObj")="Operators"
Session("SpecProps")="Trustee"
%>

<HTML>
<HEAD>
<TITLE></TITLE>
</HEAD>

<BODY BGCOLOR="#CCCCCC" TOPMARGIN=5 TEXT="#000000" LINK="#FFFFFF" onLoad="loadList();" STYLE="font-face: Helv,Arial; font-size:10pt;">

<FONT SIZE=1 FACE="Helv,Arial">
<% if Session("stype")="www" then %>
	<B><%= L_ADDWEBUSERS_TEXT %></B><P>
<% else %>
	<B><%= L_ADDFTPUSERS_TEXT %></B><P>
<% end if %>
<%= L_LISTNAMES_TEXT %>
</FONT>

<FORM NAME="userform"></FORM>


<SCRIPT LANGUAGE="JavaScript">

	top.title.Global.helpFileName="iipy_29";
	top.title.Global.siteProperties = true;	
	
	function loadList(){	
		<% if Session("IsIE") then %>
			parent.list.location.href = "iiadmls.asp";
		<% else %>
			parent.frames[1].location.href="iiadmls.asp";
		<% end if %>
	}

	function addItem(){
		trustee=prompt("<%= L_ENTERTRUSTEE_TEXT %>","<%= L_SAMPTRUSTEE_TEXT %>");
		if ((trustee != "") && (trustee != null)){	

			top.title.Global.updated=true;			
			i=cachedList.length;	
			cachedList[i]=new listObj(trustee);
			cachedList[i].updated=true;	
			cachedList[i].newitem=true;
			loadList();
		}
	}

	function delItem(){
		ndxnum=parent.list.document.userform.selTrustee.options.selectedIndex;
		if (ndxnum != -1){
		var i=parent.list.document.userform.selTrustee.options[ndxnum].value;
			if (i != ""){
				if (cachedList[i].trustee != "<%= L_ADMINISTRATORS_TEXT %>"){
					cachedList[i].deleted=true;
					cachedList[i].updated=true;	
					top.title.Global.updated=true;					
					loadList();
				}
				else{
					alert("<%= L_DELERROR_TEXT %>");
				}
			}
		}
		else{
			alert("<%= L_SELECTITEM_TEXT %>");
		}
	}

	function buildListForm(){
		numrows=0;
		for (var i=0; i < cachedList.length; i++) {
			if ((!cachedList[i].deleted) && (cachedList[i].header !="")){
				numrows=numrows + 1;
			}
		}
		qstr="numrows="+numrows;
		qstr=qstr+"&cols=Trustee"

		top.body.hlist.location.href="iihdn.asp?"+qstr;
		<% 'the list values will be grabbed by the hiddenlistform script... %>
	}

	function SetListVals(){
		listForm=parent.parent.hlist.document.hiddenlistform;	
		j=0;
		for (var i=0; i < cachedList.length; i++) {
			if ((!cachedList[i].deleted) && (cachedList[i].trustee !="")){
				listForm.elements[j++].value=cachedList[i].trustee;
				//cachedList[i].updated=false;
			}
		}
	}

	function popBox(title, width, height, filename){
		thefile=(filename + ".asp");
		thefile="iipop.asp?pg="+thefile;
		<% if Session("Browser") <> "IE3" then %>
			width=width +25;
			height=height + 50;				
		<% end if %>

		popbox=window.open(thefile,title,"toolbar=no,scrollbars=yes,directories=no,menubar=no,width="+width+",height="+height);
		if(popbox !=null){
			if (popbox.opener==null){
				popbox.opener=self;
			}
		}
	}

	function listFuncs(){
		this.loadList=loadList;
		this.addItem=addItem;
		this.delItem=delItem;
		this.writeList=buildListForm;
		this.popBox=popBox;
		this.SetListVals=SetListVals;
		this.ndx=0;		
	}



	function listObj(trustee){
		this.trustee=trustee;
		this.deleted=false;
		this.updated=false;
		this.newitem=false;
	}

	cachedList=new Array()

listFunc=new listFuncs();

<%  

Dim ACLs, dACLs, i, Ace, User
set ACLs=currentobj.AdminACL
set dACLs = ACLs.DiscretionaryACL

i = 0
For Each Ace in dACLs
	
	User = Ace.Trustee	
	if Ace.Trustee <> L_EVERYONE_TEXT then
		if InStr(Ace.Trustee,L_BUILTIN_TEXT) then
			User = Mid(User,InStr(User,L_BUILTIN_TEXT)+Len(L_BUILTIN_TEXT))
		end if
		User = Replace(User,"\","\\")
		 %>cachedList[<%= i %>]=new listObj("<%= User %>");<% 
		 i = i+1
	end if
Next


%>

</SCRIPT>

</FONT>
</BODY>
</HTML>
<% end if %>
