<%@ LANGUAGE=VBScript %>
<% Option Explicit %>
<% Response.Expires = 0 %>

<% if Session("FONTSIZE") = "" then %>
	<!--#include file="iito.inc"-->
<% else %>


<% 
'	strings for localization
Const L_ACCESSDENIED_TEXT="Access Denied" 
Const L_ENTERINT_ERRORMESSAGE="Please enter an integer."
Const L_UNSAVEDCHANGES_ERRORMESSAGE="You have unsaved changes. Save now?"
Const L_VIRTUALSERVERID_TEXT="Web Site Identification"
Const L_WORKINGSERVER_TEXT="Warning! You are changing a property on the site you are currently connected to, and may disable your remote session."
Const L_MULTIBINDING_TEXT="This resource has multiple bindings"
Const L_HOSTHEADER_TEXT="Host header name:"
Const L_DESCRIPTION_TEXT="Description:"
Const L_IPADDRESS_TEXT="IP address:"
Const L_TCPPORT_TEXT="TCP port:"
Const L_SSLPORT_TEXT="SSL port:"
Const L_UNLIMITED_TEXT="Unlimited"
Const L_LIMITTO_TEXT="Limit to:"
Const L_CONNPARAMS_TEXT="Connection"
Const L_MAXCON_TEXT="Maximum connections:"
Const L_CONNTIMEOUT_TEXT="Connection timeout:"
Const L_SECONDS_TEXT="seconds"
Const L_ADVANCED_TEXT="Advanced..."
Const L_ALLUNASSIGNED_TEXT="(All Unassigned)"
Const L_CONNECTIONS_TEXT="connections"
Const L_LOGGING_TEXT="Enable Logging"
Const L_LOGFORMAT_TEXT="Active log format:"
Const L_NONEINSTALLED_TEXT = " [No logging modules are currently installed] "
Const L_EDIT_TEXT = "Properties..."

Const DEFAULTPORT = 80
Const L_DEFAULTMAXCONNECTIONS_NUM = 1000

Const L_CHGBINDING_TEXT="WARNING!\r\rYou are modifying the bindings of the server you are currently connected to. Changing these bindings will result In you loosing connection to this site.\r\rAre you sure you want to continue?"
Const L_SAVING_TEXT="Saving..."

'On Error Resume Next 

Dim blanks,path,currentobj, ipport, ipaddress, readonly,i, multibind, oWebService

path=Session("spath")
Session("path")=path
Session("SpecObj")=path
Session("SpecProps")="ServerBindings"

Set currentobj=GetObject(path)

blanks="" 
for i=0 to 23
	blanks=blanks & "&nbsp;"
Next


%>

<!--#include file="iiset.inc"-->
<!--#include file="iibind.inc"-->

<% 


function writeBinding(fieldname,fieldsize,onchangeproc,onfocusproc, onblurproc,hidden,adminonly)

	On Error Resume Next 
	
	Dim aBinding, aSecBinding
	Dim Binding
	Dim SecBinding
	
	Dim host,ipport, ipaddress, secport, j

	aBinding=currentobj.ServerBindings

	if Session("vtype") = "svc" then
		multibind = false
		readonly = true
		Binding=getBinding(aBinding(0))		
	else
	
		if aBinding(0) <> "" then
			'global readonly variable...
			multibind=(UBound(aBinding)>0)
			readonly = multibind
			Binding=getBinding(aBinding(0))
		else
			readonly=false
			aBinding(0)=":" & DEFAULTPORT & ":"
			Binding=getBinding(aBinding(0))
		end if
	end if
	
		if fieldname="Host" then
			host=Binding(2)
			if readonly then
				if host="" then
					host="(none)"
				end if
				writeBinding=host 
			else

				writeBinding=inputbox(err,"hidden","hdnHost",host,fieldsize,onchangeproc,onfocusproc, onblurproc,hidden,adminonly,False)
			end if
	
		elseif fieldname="IPPort" then
			ipport=Binding(1)
			if readonly then
				if ipport="" then
					ipport=DEFAULTPORT
				end if			
				
				writeBinding=ipport
			else			
				writeBinding=inputbox(err,"TEXT","hdnPort",ipport,fieldsize,onchangeproc,onfocusproc, onblurproc,hidden,adminonly,False)
			end if
	
		elseif fieldname="IPAddress" then
			ipaddress=Binding(0)
			if ipaddress="" then
				ipaddress=L_ALLUNASSIGNED_TEXT
			end if			
			if readonly then								
				writeBinding=ipaddress
			else
				writeBinding=inputbox(err,"TEXT","hdnIPA",ipaddress,fieldsize,onchangeproc,onfocusproc, onblurproc,True,adminonly,False)
			end if
	
		elseif fieldname="SecureBinding" then
			secPort=""
			aSecBinding=currentobj.SecureBindings
			if aSecBinding(0) <> "" then 
			arraybound=UBound(aSecBinding)			
			for j=0 to arraybound
				SecBinding=getBinding(aSecBinding(0))
				if SecBinding(0)=Binding(0) then
					secPort=SecBinding(1)
					exit for
				end if
			Next
			end if 

			if readonly then
				writeBinding=secPort 

			else
				writeBinding=inputbox(err,"TEXT","hdnSecBinding",secPort,fieldsize,onchangeproc,onfocusproc, onblurproc,hidden,adminonly,False)
			end if 
	
		end if


end function


function allBindings()
	dim sBinding,sBindingList
	for each sBinding in currentobj.ServerBindings
		sBindingList = sBindingList & sBinding & ","
	next
	allBindings = sBindingList
end function

function writeLogTypes(fieldname,value, id, adminonly)
	On Error Resume Next 

	if id = currentobj.Get("LogPluginClsid") then
		writeLogTypes="<OPTION SELECTED VALUE='" & id & "'>" & value
	else
		writeLogTypes="<OPTION VALUE='" & id & "'>" & value	
	end if
end function


 %>



<html>

<head>
<title></title>
<script language="JavaScript">

	var Global=top.title.Global;

	Global.helpFileName="iipy";
	Global.siteProperties = true;

	function warnWrkingSite()
	{
		if (top.title.nodeList[Global.selId].isWorkingServer)
		{
			alert("<%= L_WORKINGSERVER_TEXT %>");
		}
	}
	
	function SetBinding(){
		
		if (top.title.nodeList[top.title.Global.selId].isWorkingServer){
			if (!confirm("<%= L_CHGBINDING_TEXT %>")){
				document.userform.hdnIPA.value=document.userform.hdnhdnIPA.value
				document.userform.hdnPort.value=document.userform.hdnhdnPort.value
				return;
			}
		}
		if (document.userform.hdnIPA.value == "<%= L_ALLUNASSIGNED_TEXT%>"){
			hdnIPA = "";
		}
		else{
			hdnIPA = document.userform.hdnIPA.value;
		}		
		
		document.userform.ServerBindings.value=hdnIPA + ":" + document.userform.hdnPort.value + ":" + document.userform.hdnHost.value; 
		document.userform.hdnhdnIPA.value=hdnIPA;
		document.userform.hdnhdnPort.value=document.userform.hdnPort.value;			
		
		if (hdnIPA == "")
		{
			document.userform.hdnIPA.value = "<%= L_ALLUNASSIGNED_TEXT%>";
		}
	}

	function isNum(txtcntrl,min,max) {
		str=txtcntrl.value;
	
		for (var i=0; i < str.length; i++) {
  			num = parseInt(str.substring(i,i+1));
			if (isNaN(num)){
			   alert("Please enter an integer.");
				return false;
  			}			
	 	}
		num = str;
		
		if (min != ""){	
			if (num < min) {
				alert("Please enter an integer greater than " + (min-1) + ".");
				return false;
			}
		}
		
		if (max != ""){
			if (num > max) {
				alert("Please enter an integer less than " + (max + 1) + ".");
				return false;
			}		
		}
		return true;
	}

	function SetMaxConn(){
		curval=parseInt(document.userform.hdnMaxConnections.value);
		if (document.userform.rdoMaxConnections[0].checked){
			document.userform.MaxConnections.value=2000000000;	
		}
		else{	
			document.userform.MaxConnections.value=document.userform.hdnMaxConnections.value;
		}
	}
	
	function setState(mState,mControl){
		<% if Session("Browser") = "IE4" then %>
			mControl.disabled = ! mState;
		<% end if %>
	}
	
	function setLogType(logCntrl,hdncntrl){
		if (logCntrl.checked){
			hdncntrl.value = 1;
		}
		else{
			hdncntrl.value = 0;
		}
	}
	
	function setLogUIType(logCntrl){
		
		var logName = logCntrl.options[logCntrl.selectedIndex].text;

		var logType = "";
		
		if (logName.indexOf("Ext") > -1){
			logType = "EXT";
		}
		if (logName.indexOf("ODBC") > -1) {
			logType = "ODBC";
		}

		top.connect.location.href = "iisess.asp?setLogUI=" + logType;		
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

	

</script>
</head>

<body bgcolor="#CCCCCC" topmargin="5" text="#000000" STYLE="font-face: Helv,Arial; font-size:10pt;">

<FONT FACE="Helv,Arial" SIZE=1>
<form name="userform">
<b><%= L_VIRTUALSERVERID_TEXT %></b>
<blockquote>

<table border="0" cellpadding="0">
<tr>
	<td valign="bottom">
		<FONT FACE="Helv,Arial" SIZE=1>
			<%= L_DESCRIPTION_TEXT %>
		</font>
	</td>
	<td valign="bottom" colspan="2">
		<FONT FACE="Helv,Arial" SIZE=1>
			<%= text("ServerComment",25,"","","",false,false) %>
		</font>
	</td>
</tr>

<tr>
	<td valign="bottom"><FONT FACE="Helv,Arial" SIZE=1><%= L_IPADDRESS_TEXT %></font></td>
	<td valign="bottom">
		<FONT FACE="Helv,Arial" SIZE=1>
			<%= writeBinding("IPAddress",15,"","","warnWrkingSite();SetBinding();",true,true) %>
			<input type="hidden" name="ServerBindings" value="<%= allBindings() %>">
		</font>
	</td>
		<td align="right" valign="bottom"><FONT FACE="Helv,Arial" SIZE=1>&nbsp;&nbsp;
			<% if Session("vtype") <> "svc" then %>
			<% if Session("isAdmin") then %>
				<% if Session("FONTSIZE")="LARGE" then %>
					<input type="button" name="hdnAdvanced" value="<%= L_ADVANCED_TEXT %>" onclick="popBox('Advanced',595,375,'iimlti');">
				<% else %>
					<input type="button" name="hdnAdvanced" value="<%= L_ADVANCED_TEXT %>" onclick="popBox('Advanced',470,325,'iimlti');">
				<% end if %>				
			<% end if %>
			<% end if %>			
		</font>
	</td>
</tr>

<tr>
	<td valign="bottom"><FONT FACE="Helv,Arial" SIZE=1><%= L_TCPPORT_TEXT %></font></td>
	<td valign="bottom">		
		<FONT FACE="Helv,Arial" SIZE=1>
			<%= writeBinding("IPPort",5,"","","warnWrkingSite();isNum(this,0,9999);SetBinding();",true,true) %>
			<%= writeBinding("Host",5,"","","warnWrkingSite();SetBinding();",true,true) %>		
		</font>
	</td>

</tr>

<% if Session("isAdmin") then %>
	<% if multibind then %>
	<tr>
		<td valign="bottom" colspan="4">
		<FONT FACE="Helv,Arial" SIZE=1>
		(<%= L_MULTIBINDING_TEXT %>)
		</font>
		</td>
	</tr>
	<% end if %>
<% end if %>

</table>

</blockquote>

<hr>
<FONT FACE="Helv,Arial" SIZE=1>
<b><%= L_CONNPARAMS_TEXT %></b>
<blockquote>

<table border="0" cellpadding="0">
<tr>
	<td colspan="2">
		<FONT FACE="Helv,Arial" SIZE=1>
			<%= printradio("MaxConnections", (currentobj.MaxConnections >=2000000000), "SetMaxConn();setState(!this.checked,document.userform.hdnMaxConnections);",true) %>
			<%= L_UNLIMITED_TEXT %>
		</font>
	</td>
</tr>


<tr>	
	<td valign="middle">
		<FONT FACE="Helv,Arial" SIZE=1>
			<%= printradio("MaxConnections", (currentobj.MaxConnections < 2000000000), "SetMaxConn();setState(this.checked,document.userform.hdnMaxConnections);",true) %>
			<%= L_LIMITTO_TEXT %>
			<input type="hidden" name="MaxConnections" value="<%= currentobj.MaxConnections %>">			

		</font>
	</td>
	<td valign="bottom">
		<FONT FACE="Helv,Arial" SIZE=1>
			<% if (currentobj.MaxConnections < 2000000000) then %>	
				<%= inputbox(0,"TEXT","hdnMaxConnections",currentobj.MaxConnections,10,"","", "isNum(this,1,2000000001);SetMaxConn();",false,True,False) %>
			<% else %>

				<%= inputbox(0,"TEXT","hdnMaxConnections",L_DEFAULTMAXCONNECTIONS_NUM,10,"","", "isNum(this,1,2000000001);SetMaxConn();",false,True,False) %>
			<% end if %>								
	</td>
	<td valign="middle">
		<FONT FACE="Helv,Arial" SIZE=1>		
				&nbsp;<%= L_CONNECTIONS_TEXT %>
		</font>	
	</td>
</tr>
<tr>
	<td> &nbsp;</td>
</tr>

<tr>
	<td valign="middle"><FONT FACE="Helv,Arial" SIZE=1><%= L_CONNTIMEOUT_TEXT %>&nbsp;&nbsp;</font></td>
	<td valign="bottom">
			<%= text("ConnectionTimeout",10,"","", "isNum(this,1,2147483646);",True,True) %>
	</td>
	<td valign="middle">
		<FONT FACE="Helv,Arial" SIZE=1>
		&nbsp;<%= L_SECONDS_TEXT %>
		</font>
	</td>
</tr>

<tr>
	<td colspan="2" height="4"></td>
</tr>

</table>

</blockquote>
</font>


<hr>
<FONT FACE="Helv,Arial" SIZE=1>

<%
On Error Resume Next
Dim LoggingModules,noLogging, Module, InfoNode, AvailMods

Set LoggingModules = GetObject("IIS://localhost/logging")
Set InfoNode = GetObject("IIS://localhost/W3SVC/Info")
AvailMods = InfoNode.LogModuleList
if err <> 0 then
	noLogging = True
end if
				
%>
<% if noLogging then %>
	<img align="top" src="images/checkoff.gif" width="13" height="13">
<% else %>
	<% if currentobj.LogType = 1 then %>
		<INPUT TYPE="checkbox" NAME="hdnLogType" checked OnClick = "setLogType(this,document.userform.LogType);setState(this.checked,document.userform.hdnBtnLogProps);setState(this.checked,document.userform.LogPlugInClsid);top.title.Global.updated=true;">
	<% else %>
		<INPUT TYPE="checkbox" NAME="hdnLogType" OnClick = "setLogType(this,document.userform.LogType);setState(this.checked,document.userform.hdnBtnLogProps);setState(this.checked,document.userform.LogPlugInClsid);top.title.Global.updated=true;">	
	<% end if %>
	<INPUT TYPE="hidden" NAME="LogType" VALUE="<%= currentobj.LogType %>">
<% end if %>
<%= L_LOGGING_TEXT %>

<blockquote>

<table border="0" cellpadding="0">
<tr>
	<td colspan="1">
		<FONT FACE="Helv,Arial" SIZE=1>		
			<%= L_LOGFORMAT_TEXT %>
			<select size="1" name="LogPlugInClsid" onchange="setLogUIType(this);">			
				<%
				
					if noLogging then
						Response.write "<OPTION>" & L_NONEINSTALLED_TEXT & "</OPTION>"							
					else
						For Each Module in LoggingModules
							If InStr(AvailMods, Module.Name) Then
								Response.write writeLogTypes("LogPluginClsid", Module.Name, Module.LogModuleId,false) 						
							End If
						Next
					end if
				%>
			</select>
		</font>
	</td>
	<td><FONT FACE="Helv,Arial" SIZE=1>
	<% if not noLogging then %>
		<% if Session("FONTSIZE") = "LARGE" then %>
		<input type="button" name="hdnBtnLogProps" value="<%= L_EDIT_TEXT %>" onclick="popBox('LogDetail',450,400,'iilog');">
		<% else %>
		<input type="button" name="hdnBtnLogProps" value="<%= L_EDIT_TEXT %>" onclick="popBox('LogDetail',400,400,'iilog');">		
		<% end if %>
	<% end if %>
	</FONT>
	</td>
</tr>

</table>

</blockquote>
</form>
</font>
<% if not noLogging then %>
<script language="JavaScript">
	setState(document.userform.rdoMaxConnections[1].checked,document.userform.hdnMaxConnections);
	setState(document.userform.hdnLogType.checked,document.userform.LogPlugInClsid);
	setState(document.userform.hdnLogType.checked,document.userform.hdnBtnLogProps)
	setLogUIType(document.userform.LogPlugInClsid)
</script>
<% end if %>
</body>
</html>


<% end if %>
