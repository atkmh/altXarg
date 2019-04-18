<%@ LANGUAGE=VBScript %>
<% Option Explicit %>
<% Response.Expires = 0 %>

<%

	' This script adds, deletes, and sets state on adsi objects, as appropriate,
	' based upon the value of the action parameter.
	' It does some error checking...
	' Only instance may be started, stopped, paused or resumed.
	

%>


<% 
Const L_ACCESSDENIED_TEXT="Access Denied"
Const L_OBJEXISTS_ERR="An object with the name you specifed already exists. Specify a different object name." 
Const L_UNKNOWN_ERR="An unknown error occured."
Const L_START_ERR="The service could not be started because it is not correctly configured. Make sure its server bindings do not conflict with other servers running on the same machine."
Const L_NOBINDINGS_ERR = "You must assign a binding to this site before starting."
Const L_STOP_ERR="The site could not be stopped at this time."
Const L_CONT_ERR="The site could not resume at this time."
Const L_PAUSE_ERR="The site could not be paused at this time."
Const L_DELETE_ERR="The object could not be deleted."
Const L_APPCREATE_ERR="The application could not be created."
Const L_APPREMOVE_ERR="The application could not be removed."
Const L_APPUNLOAD_ERR="The application could not be unloaded."
Const L_BACKUP_ERR = "The backup was not successful."
Const L_BACKUPRMV_ERR = "The backup was not deleted."
Const L_DEFAULTAPP_TEXT = "Default Application"



Const CSTART="2"
Const CSTOP="4"
Const CPAUSE="6"
Const CCONT="0"

Const MD_BACKUP_NEXT_VERSION =  &HFFFFFFFF
%>

<HTML>

<%
On Error Resume Next 

Dim action, path, vtype,stype,sel,pos,newADspath, dirname, keytype
Dim dirnamelen, baseobj, svc,key, keyname, newname, vdir, sname
Dim service, inst, nextinst, FileSystem, parenttype, newobj
Dim currentobj, rootobj, adminobj, objerr, delmetanode, bindings
Dim defaultinst, admininst, isolated,a
Dim bkupName,bkupVer, dirpath, delpath


action=Request.QueryString("a")
sel=Request.QueryString("sel")
path = Request.QueryString("path")
'save off our original action...
a = action

Select Case action
Case "add"
	getTypes

	Set FileSystem=CreateObject("Scripting.FileSystemObject")
	
	if vtype="server" then 
		sname=Mid(path, 1, pos) & svc
		Set service=GetObject(sname)
		baseobj=service.ADsPath
		For Each inst In service
			if isNumeric(inst.name) then
				if cint(inst.name) > Nextinst then
					Nextinst=cint(inst.name)
				end if
			end if
		Next
		newname=Nextinst+1
	end if 

	Set currentobj=GetObject(baseobj)
	'if currentobj can't be set due to path not found,
	'we need to set our parenttype var manually
	if err <> 0 then			
		parenttype = ""
	else
		parenttype=currentobj.KeyType
	end if 	


	if Instr(parenttype,"Server") <> 0 then
		baseobj=baseobj & "/Root"
		Set currentobj=GetObject(baseobj)
		parenttype=currentobj.KeyType
	end if
	
	'The physical directory may not currently
	'exist in the metabase, so we have
	'to find the parent vdir associated with
	'the dir and build the path from there.	


	if (vtype="dir") then
		
		Do Until Instr(parenttype, "VirtualDir") <> 0
			'we need clear our path not found error..
			err = 0			
			
			'add our initial whack...
			newname = "/" + newname
			
			'and cyle through the baseobj till we find the next whack,
			'building up the path in new name as we go
			Do Until Right(baseobj,1) = "/"
				newname = Right(baseobj,1) & newname 		
				baseobj = Mid(baseobj,1,Len(baseobj)-1)
			Loop
			
			'once we're out, we need to lop off the last whack...
			baseobj = Mid(baseobj,1,Len(baseobj)-1)
			
			'and try to set the object again...
			Set currentobj=GetObject(baseobj)
			
			if err <> 0 then			
				parenttype = ""
			else
				parenttype=currentobj.KeyType
			end if 							
		Loop	
		
	end if

	Set newobj=currentobj.Create(keytype, newname)

	if err=0 then	
	
		if (vtype="dir") then
			dirpath = currentobj.Path & "\" & Replace(newname,"/","\")
			FileSystem.CreateFolder(dirpath)
			
			'now, we need to reset our newname to the actual title...
			newname = dirname

		elseif (vtype="vdir") then
			if currentobj.Path <> "" then
			 	newobj.Path=currentobj.Path			
			end if

		elseif (vtype="server") then
			Set DefaultInst=GetObject("IIS://localhost/" & svc & "/1/Root")
			Set rootobj=newobj.Create(vdir,"Root")
			rootobj.Path = DefaultInst.Path
			rootobj.AccessRead=True
			if stype = "www" then
				rootobj.AppFriendlyName = L_DEFAULTAPP_TEXT

				rootobj.AccessScript=True			
				rootobj.AppCreate "TRUE"
			end if 
			rootobj.SetInfo			
											
			if stype = "www" then
				Set admininst=GetObject("IIS://localhost/w3svc/" & Request.ServerVariables("INSTANCE_ID") & "/Root/IISADMIN")						
				Set adminobj=rootobj.Create("IIsWebVirtualDir","IISADMIN")
				adminobj.Path=admininst.Path
				adminobj.AuthNTLM=True
				adminobj.AuthAnonymous=False
				adminobj.AccessRead=True
				adminobj.AccessScript=True
				adminobj.SetInfo
			end if 
			
			newobj.ServerComment=newADspath			

		end if
		
		if err=0 then
			newobj.SetInfo
		else
			'unknown error
			objerr=L_UNKNOWN_ERR & "(" & err & "(" & Hex(err) & ") -" & err.description & ")"
		end if

	else		
		' Object exisits error
		if err=-2147024713 then
			err=0
			objerr=L_OBJEXISTS_ERR
		else
			'unknown error
			objerr=L_UNKNOWN_ERR & "(" & err & "-" & err.description & ")"
			err=0
		end if
	end if
	
Case "del"
	path=Request.QueryString("path")
	getTypes
	delmetanode = True
	Set FileSystem=CreateObject("Scripting.FileSystemObject")
	Set currentobj=GetObject(baseobj)
	
	newname = dirname
	
	'The physical directory may not currently
	'exist in the metabase, so we have
	'to find the parent vdir associated with
	'the dir and build the path from there.	
	
	if (vtype="dir") then

	
		'if currentobj can't be set due to path not found,
		'we need to set our parenttype var manually
		if err <> 0 then			
			parenttype = ""
			delmetanode = False
		else
			parenttype=currentobj.KeyType
		end if 	
		

		Do Until Instr(parenttype, "VirtualDir") <> 0
			'we need clear our path not found error..
			err = 0			
			
			'add our initial whack...
			newname = "/" + newname
			
			'and cyle through the baseobj till we find the next whack,
			'building up the path in new name as we go
			Do Until Right(baseobj,1) = "/"
				newname = Right(baseobj,1) & newname 		
				baseobj = Mid(baseobj,1,Len(baseobj)-1)
			Loop
			
			'once we're out, we need to lop off the last whack...
			baseobj = Mid(baseobj,1,Len(baseobj)-1)
			
			'and try to set the object again...
			Set currentobj=GetObject(baseobj)
			
			if err <> 0 then			
				parenttype = ""
			else
				parenttype=currentobj.KeyType
			end if 							
		Loop		
		
		delpath=currentobj.Path & "\" & Replace(newname,"/","\")
		FileSystem.DeleteFolder delpath				
	end if
	
	if Instr(currentobj.KeyType, "Server") <> 0 then
		baseobj=path & "/Root"
		Set currentobj=GetObject(baseobj)
	end if

	if delmetanode then
		currentobj.Delete keytype, newname
		currentobj.SetInfo
	end if
	
	if err.Number <> 0 then
		objerr=L_DELETE_ERR & "(" & err & "-" & err.description & ")"
	end if	

Case CSTART 
	action = "setstate"
	path=Request.QueryString("path")
	Set currentobj=GetObject(path)
	bindings = currentobj.ServerBindings
	if UBound(bindings) < 1 and bindings(0) = "" then
		objerr = L_NOBINDINGS_ERR
	else
		currentobj.Start
		if err.Number <> 0 then
			objerr=L_START_ERR & "(" & err & "-" & err.description & ")"
		end if
	end if
	
Case CSTOP
	action = "setstate"
	path=Request.QueryString("path")
	Set currentobj=GetObject(path)
	currentobj.Stop
	if err.Number <> 0 then
		objerr=L_STOP_ERR & "(" & err & "-" & err.description & ")"
	end if
	
Case CPAUSE
	action = "setstate"
	path=Request.QueryString("path")
	Set currentobj=GetObject(path)
	currentobj.Pause
	if err.Number <> 0 then
		objerr=L_PAUSE_ERR & "(" & err & "-" & err.description & ")"
	end if	
	
Case CCONT
	action = "setstate"
	path=Request.QueryString("path")
	Set currentobj=GetObject(path)
	currentobj.Continue
	if err.Number <> 0 then
		objerr=L_CONT_ERR & "(" & err & "-" & err.description & ")"
	end if	
	
	
Case "CreateApp"
	path=Session("path")
	if Right(path,1) = "/" then
		path = Mid(path,1,Len(path)-1)
	end if
	Set currentobj=GetObject(path)
	Response.write currentobj.KeyType & "<BR>"
	currentobj.AppCreate "TRUE"
	
	if err.Number <> 0 then
		objerr=L_APPCREATE_ERR & "(" & err & "-" & err.description & ")"
	end if		
	currentobj.SetInfo
	Response.write currentobj.Get("AppRoot")
	
Case "RemoveApp"
	path=Session("approot")
	if Right(path,1) = "/" then
		path = Mid(path,1,Len(path)-1)
	end if		
	Set currentobj = GetObject(path)
	currentobj.AppDeleteRecursive
	if err.Number <> 0 then
		objerr=L_APPREMOVE_ERR & "(" & err & "-" & err.description & ")"
	end if

	
Case "UnloadApp"
	path=Session("approot")
	if Right(path,1) = "/" then
		path = Mid(path,1,Len(path)-1)
	end if		
	Set currentobj=GetObject(path)
	if Session("setProcOpts") then
		currentobj.AppUnLoadRecursive
	end if
	if err.Number <> 0 then
		objerr=L_APPUNLOAD_ERR & "(" & err & "-" & err.description & ")"
	end if

Case "Backup"

	dim vVersionOut, vLocationOut, vDateOut, i
	
	bkupName = Request.Querystring("bkupName")
	Set currentobj=GetObject("IIS://localhost")
	
	currentobj.Backup bkupName, MD_BACKUP_NEXT_VERSION, "1"
	if err.Number <> 0 then
		objerr=L_BACKUP_ERR & "(" & err & "-" & err.description & ")"
	end if

Case "BackupRmv"
	
	bkupName = Request.Querystring("bkupName")
	bkupVer = Request.Querystring("bkupVer")	
	if bkupVer = "" then
		bkupVer = "0"
	end if
	Response.Write bkupname & " " & bkupVer
	Set currentobj=GetObject("IIS://localhost")
	
	currentobj.DeleteBackup bkupName, cLng(bkupVer)
	if err.Number <> 0 then
		objerr=L_BACKUPRMV_ERR & "(" & err & "-" & err.description & ")"
	end if									
	
Case Else
	Response.Write "No Action"	
	Response.write Request.Querystring
End Select


Sub getTypes()
	vtype=Request.QueryString("vtype")
	stype=Request.QueryString("stype")
	pos=InStr(7, path, "/")
	newADspath=Mid(path, Pos + 1)
	dirname=newADsPath
	Do While InStr(dirname,"/")
		dirname=Mid(dirname,InStr(dirname,"/")+1)
	Loop
	
	dirnamelen=len(dirname)+1
	baseobj=Mid(path,1,len(path)-dirnamelen)
	
	if stype="www" then
		svc="w3svc"
		key="Web"
	elseif stype="ftp" then
		svc="msftpsvc"
		key="Ftp"	
	end if
	
	Select Case vtype
	 	Case "dir" 
			keytype="IIs" & key & "Directory"
			newname=dirname
		Case "vdir"
			keytype="IIs" & key & "VirtualDir"
			newname=dirname
		Case "server"
			keytype="IIs" & key & "Server"		
	End Select
	
	vdir="IIs" & key & "VirtualDir"

End Sub

Sub print(str)
	Response.Write str
	if err <> 0 and err <> "" then
		Response.Write "<FONT COLOR=red> (" & err & ":" & err.description & ")</FONT>"
	end if 
	Response.Write "<P>"
End Sub

								
 %>

<BODY BGCOLOR="#000000" TEXT="#FFCC00" TOPMARGIN=0 LEFTMARGIN=0>
<SCRIPT LANGUAGE="JavaScript">

	// Now that we've set it in the object, we need to update our client cachedList:
		
	<% if objerr="" then %>
	<% Select Case action %>
		<% Case "add" %>
			if (!top.title.nodeList[<%= sel %>].isCached){
				top.title.nodeList[<%= sel %>].cache(<%= sel %>);
			}
			else{
				top.title.nodeList[<%= sel %>].insertNode("<%= newname %>","<%= dirname %>",<%= sel %>,"<%= vtype %>","<%= stype %>");
			}

		<% Case "del" %>
				top.title.nodeList[<%= sel %>].deleteItem();
								
		<% Case "setstate" %>
				top.title.nodeList[<%= sel %>].displaystate=top.title.Global.displaystate[<%= a %>];				
				top.title.nodeList[<%= sel %>].state=<%= a %>;
				top.body.list.location.href=top.body.list.location.href;
		<% Case "Backup" %>				
				top.main.head.location.href = top.main.head.location.href;
		<% Case "BackupRmv" %>				
				top.main.head.location.href = top.main.head.location.href;								

	<% End Select %>
		
	<% else %>
		alert("<%= objerr%>");
	<% end if %>

	if (top.body != null){
		top.body.iisstatus.location.href="iistat.asp?thisState=";
	}

</SCRIPT>
</BODY>
</HTML>