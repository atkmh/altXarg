<%@ LANGUAGE=VBScript %>
<% Option Explicit %>
<% Response.Expires = 0 %>

<%

Const L_CHANGESSAVED_TEXT="Your changes have been saved."
Const ADS_PROPERTY_CLEAR = 1
Const IIS_DATA_INHERIT = 1
%>

<HTML>
<HEAD>


<% 
On Error Resume Next 

Dim path, lasterr, currentobj, key, sobj, specprops, newval,dirkeyType
Dim changed, objname, thisobj, value, bval, curval,quote, childpath, aSetChildPaths
Dim clearPaths, child, proparray
dirkeyType = "IIsWebDirectory"
quote = chr(34)

lasterr=""
path=Session("path")
Response.write path

if Session("clearPathsOneTime") <> "" then 
	clearPaths = Session("clearPathsOneTime")
else
	clearPaths = (Session("clearPaths") <> "")
end if
Set currentobj=GetObject(path)

%>
<!--#include file="iifixpth.inc"-->
<%

if Session("SpecObj") <> "" then
	if Session("SpecObj")="IPSecurity" then
		Set sobj=currentobj.Get(Session("SpecObj"))
	else
		Set sobj=GetObject(Session("SpecObj"))
	end if
	specprops=UCase(Session("SpecProps"))
end if

changed=false

For Each key In Request.QueryString
	key = UCase(key)
	changed=false
	Response.write key & "<BR>"
	if (key <>"PAGE" ) and (key <> "STATE") and  (key <> "CLEARPATHS")  then
		if inStr(specprops,key) <> 0 then
			err=0
			Set thisobj=sobj		
			value=Request.QueryString(key)
			if UCase(value)="TRUE" then
				bval=True
			else
				bval=False
			end if 

			Select Case UCase(key)
			Case "GRANTBYDEFAULT" 
				if thisobj.GrantbyDefault <> bval then
					changed = true	
					thisobj.GrantbyDefault=bval				
				end if
				currentobj.IPSecurity=thisobj

			Case "FRONTPAGEWEB"
				if thisobj.FrontPageWeb <> bval then			
					changed = true					
					thisobj.FrontPageWeb=bval
				end if
				
			Case "MSDOSDIROUTPUT"
				if thisobj.MSDOSDirOutput <> bval then			
					changed = true					
					thisobj.MSDOSDirOutput=bval

				end if		
				
			Case "HTTPEXPIRES"
				if value = "d,-1" then			
					changed = true					
					thisobj.HttpExpires = ""
				else
					if thisobj.HttpExpires <> value then
						changed = true	
						thisobj.Put key, (value)
					end if
				end if

			Case "SERVERBINDINGS"			
				Dim bindings
				Response.write "ServerBindings:"
				bindings = split(value,",")
				Response.write "Bound:" & UBound(bindings)
				if chkUpdated(thisobj.ServerBindings,bindings) then
					thisobj.Put key, (bindings)
				end if
				
			End Select
			
			thisobj.SetInfo
	
		else
			Set thisobj=currentobj

			newval=Request.QueryString(key)		
			curval=thisobj.Get(key)
					
				if not isArray(curval) then
					Select Case typename(curval)
						Case "Boolean" 
							if UCase(newval)="TRUE" then
								value=True
							else
								value=False
							end if 
						Case "Long"
							value = cLng(newval)
						Case Else
							value = newval
					End Select
					
					if curval <> value then	
						changed = true												
						thisobj.Put key, (value)
					end if	
				else
					ReDim proparray(0)
					proparray(0) = newval
					if chkUpdated(curval,proparray) then
						thisobj.Put key, (proparray)
					end if
				end if			

				thisobj.SetInfo
		end if
	end if

	if changed then

		if clearPaths then
			aSetChildPaths = thisobj.GetDataPaths(key,IIS_DATA_INHERIT) 
			if err = 0 then
				For Each childpath in aSetChildPaths
					childPath = cleanPath(childPath)
				
					Set child = GetObject(childpath)
					if child.ADSPath <> thisobj.ADSPath then
						if (instr(LCase(child.ADSPath), "IIS://localhost/w3svc/info") > 0) OR (instr(LCase(child.ADSPath), "IIS://localhost/msftpsvc/info") > 0) then
						else
							child.PutEx ADS_PROPERTY_CLEAR, key, ""
							child.SetInfo
						end if
					end if
				Next	
			end if
			err = 0
		end if
	end if
Next

currentobj.SetInfo


Function cleanPath(pathstr)
	if Right(pathstr,1) = "/" then
		pathstr = Mid(pathstr, 1,len(pathstr)-1)
	end if
	cleanPath = pathstr
End Function

Function chkUpdated(oldarray,proparray)

	dim proparraybound,arrayWasUpdated, i
	
	if IsArray(oldarray) then
		proparraybound=UBound(proparray)
		if UBound(oldarray) <> proparraybound then
			arrayWasUpdated=true
		else
			for i=0 to proparraybound
				if oldarray(i) <> proparray(i) then					
					arrayWasUpdated=true
				end if
			Next
		end if
	else		
		if proparraybound > 0 then
			arrayWasUpdated=true
		else
			arrayWasUpdated=(proparray(0) <> oldarray)			
		end if
	end if
	
	'set our global changed var
	changed = arrayWasUpdated
	
	chkUpdated = arrayWasUpdated
	
End Function

%>

</HEAD>

<BODY BGCOLOR="#000000" TEXT="#FFCC00" TOPMARGIN=0 LEFTMARGIN=0>
<SCRIPT LANGUAGE="JavaScript">

	<% if Request.QueryString("PAGE") <> "popup" then %>
	top.title.Global.updated=false;
	if (top.body.frames.length > 0){	
		<% if Request("ServerComment") <> "" then %>
		top.title.nodeList[top.title.Global.selId].title="<%= Request("ServerComment") %>";
		if (top.body.menu != null){
			top.body.menu.location.href=top.body.menu.location.href;
		}
		<% end if %>
		

		if (top.body.frames.length > 3){
		<% if Session("IsIE") then %>
			top.body.iisstatus.location.href="iistat.asp?thisState=" + escape("<%= L_CHANGESSAVED_TEXT %>");
		
		<% else %>
			top.body.frames[3].location.href="iistat.asp?thisState=" + escape("<%= L_CHANGESSAVED_TEXT %>");
		<% end if %>			
		}
		else{
			if (top.body.iisstatus != null){	
				top.body.iisstatus.location.href="iistat.asp?thisState=" + escape("<%= L_CHANGESSAVED_TEXT %>");
			}
		}
	}	
	<% end if %>
	
</SCRIPT>

</BODY>
</HTML>


