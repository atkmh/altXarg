<%@ LANGUAGE=VBScript %>
<% Option Explicit %>
<% Response.Expires = 0 %>

<% 
Const L_BROWSE_TEXT="Browse"
Const L_FILE_TEXT="File"
Const L_URL_TEXT="URL"
Const L_ALLUNASSIGNED_TEXT="All Unassigned"
Const L_NA_TEXT="N/A"
Const L_SECURE_TEXT="Secure Bindings"
Const L_SERVER_TEXT="Server Bindings"
%>

<HTML>
<HEAD>
	<TITLE></TITLE>

	<SCRIPT LANGUAGE="JavaScript">
		function chgStatus(indexnum){
			parent.head.document.hiddenform.index.value=indexnum
			self.location.href="iimltils.asp"
			
		}

	function SetUpdated(){
		if (parent.head.listFunc.noupdate){
			parent.head.listFunc.noupdate = false;
		}
		else{
			if (parent.head.document.hiddenform.index.value != -1){
			if (parent.head.document.hiddenform != null){		
				i=parent.head.document.hiddenform.index.value
				reSort = setVals(parent.head.cachedList[i],"ipaddress",document.listform.editMe);
				reSort = reSort || setVals(parent.head.cachedList[i],"ipport",document.listform.ipport);
				reSort = reSort || setVals(parent.head.cachedList[i],"sslport",document.listform.sslport);
				reSort = reSort || setVals(parent.head.cachedList[i],"host",document.listform.host);
				
				parent.head.cachedList[i].updated=true;
				if (reSort){
					parent.head.listFunc.reSort();
				}
			}
		}
		}
	}
	
	
	function setVals(cachedItem, propName, formCntrl){
		if (cachedItem[propName] != formCntrl.value){
			cachedItem[propName] = formCntrl.value;
			return (parent.head.listFunc.sortby == propName);
		}		
		else{
			return false;
		}
	}
	function SetSecure(item,formCntrl,isSecure)
	{
		if (formCntrl.value != "")
		{
			parent.head.cachedList[item].isSecure = isSecure;
		}
	}
	
	</SCRIPT>
</HEAD>

<BODY BGCOLOR="#FFFFFF" LEFTMARGIN=0 TOPMARGIN=0>

<FORM NAME="listform">

<SCRIPT LANGUAGE="JavaScript">

	editOK=false;
	writeSecHdr = true;
	writeHdr = true;	
	sel=eval(parent.head.document.hiddenform.index.value);	
	list = writeList();
	writeLine(list);

function writeList(){	
	<% if Session("IsIE") then %>
	<% if Session("FONTSIZE") = "LARGE" then %>
		writestr = "<TABLE WIDTH=470 BORDER=0 CELLPADDING=2 CELLSPACING=0>";
	<% else %>
		writestr = "<TABLE BORDER=0 CELLPADDING=2 CELLSPACING=0>";	
	<% end if %>
	<% else %>
	<% if Session("FONTSIZE") = "LARGE" then %>
		writestr = "<TABLE WIDTH=475 BORDER=0 CELLPADDING=2 CELLSPACING=0>";
	<% else %>
		writestr = "<TABLE WIDTH=344 BORDER=0 CELLPADDING=2 CELLSPACING=0>";
	<% end if %>
	<% end if %>	
	

	for (var i=0;i < parent.head.cachedList.length; i++) {
	
		if (parent.head.cachedList[i].sslport != ""){
			if (writeSecHdr){
				writestr += "<TR>"
				writestr += writeCol(4,150,"&nbsp;");
				writestr += "</TR>";					
				writestr += "<TR BGCOLOR=#CCCCCC>"
				writestr += writeCol(4,150,"<B><%= L_SECURE_TEXT %></B>");
				writestr += "</TR>";
				writeSecHdr = false;
			}
		}
		else{
			if (writeHdr){		
				writestr += "<TR BGCOLOR=#CCCCCC>"
				writestr += writeCol(4,150,"<B><%= L_SERVER_TEXT %></B>");
				writestr += "</TR>";
				writeHdr = false;
			}			
		}


		if (parent.head.document.hiddenform.index.value !=i) {
			if (parent.head.cachedList[i].deleted){
			}
			else{
			
				<% if Session("IsIE") then %>
					<% if Session("FONTSIZE") = "LARGE" then %>
						writestr += "<TR>"
						writestr += writeCol(1,150,"<A HREF='javascript:chgStatus("+i+");'>" + displayVal(parent.head.cachedList[i].ipaddress,"<%= L_ALLUNASSIGNED_TEXT %>") + "</A>");
						writestr += writeCol(1,65,displayVal(parent.head.cachedList[i].ipport,"<%= L_NA_TEXT %>"));
						writestr += writeCol(1,65,displayVal(parent.head.cachedList[i].sslport,"<%= L_NA_TEXT %>"));					
						writestr += writeCol(1,190,parent.head.cachedList[i].host);
						writestr += "</TR>";
					<% else %>
					
						writestr += "<TR>"
						writestr += writeCol(1,110,"<A HREF='javascript:chgStatus("+i+");'>" + displayVal(parent.head.cachedList[i].ipaddress,"<%= L_ALLUNASSIGNED_TEXT %>") + "</A>");
						writestr += writeCol(1,50,displayVal(parent.head.cachedList[i].ipport,"<%= L_NA_TEXT %>"));
						writestr += writeCol(1,50,displayVal(parent.head.cachedList[i].sslport,"<%= L_NA_TEXT %>"));					
						writestr += writeCol(1,140,parent.head.cachedList[i].host);
						writestr += "</TR>";
				
					<% end if %>
				<% else %>
					<% if Session("FONTSIZE") = "LARGE" then %>
						writestr += "<TR>"
						writestr += writeCol(1,150,"<A HREF='javascript:chgStatus("+i+");'>" + displayVal(parent.head.cachedList[i].ipaddress,"<%= L_ALLUNASSIGNED_TEXT %>") + "</A>");
						writestr += writeCol(1,60,parent.head.cachedList[i].ipport);
						writestr += writeCol(1,60,displayVal(parent.head.cachedList[i].sslport,"N/A"));					
						writestr += writeCol(1,195,parent.head.cachedList[i].host);
						writestr += "</TR>";
					<% else %>
						writestr += "<TR>"
						writestr += writeCol(1,116,"<A HREF='javascript:chgStatus("+i+");'>" + displayVal(parent.head.cachedList[i].ipaddress,"<%= L_ALLUNASSIGNED_TEXT %>") + "</A>");
						writestr += writeCol(1,43,parent.head.cachedList[i].ipport);
						writestr += writeCol(1,47,displayVal(parent.head.cachedList[i].sslport,"N/A"));					
						writestr += writeCol(1,148,parent.head.cachedList[i].host);
						writestr += "</TR>";
					<% end if %>
				<% end if %>
			}
		}
		else{
			editOK=true;
			<% if Session("IsIE") then %>
			
				writestr += "<TR>"
				writestr += writeCol(1,110,"<INPUT NAME='editMe' VALUE='"+parent.head.cachedList[i].ipaddress +"' SIZE=13 onBlur='SetUpdated();'>");
				writestr += writeCol(1,40,"<INPUT NAME='ipport' VALUE='"+parent.head.cachedList[i].ipport +"' SIZE=5 onBlur='SetSecure(" + i + ",this,false);SetUpdated();'>");
				writestr += writeCol(1,40,"<INPUT NAME='sslport' VALUE='"+parent.head.cachedList[i].sslport +"' SIZE=5 onBlur='SetSecure(" + i + ",this,true);SetUpdated();'>");					
				writestr += writeCol(1,140,"<INPUT NAME='host' VALUE='"+parent.head.cachedList[i].host +"' SIZE=15 onBlur='SetUpdated();'>");
				writestr += "</TR>";		

			<% else %>
				<% if Session("FONTSIZE") = "LARGE" then %>
				
					writestr += "<TR>"
					writestr += writeCol(1,150,"<INPUT NAME='editMe' VALUE='"+parent.head.cachedList[i].ipaddress +"' SIZE=13 onBlur='SetUpdated();'>");
					writestr += writeCol(1,60,"<INPUT NAME='ipport' VALUE='"+parent.head.cachedList[i].ipport +"' SIZE=5 onBlur='SetSecure(" + i + ",this,false);SetUpdated();'>");
					writestr += writeCol(1,60,"<INPUT NAME='sslport' VALUE='"+parent.head.cachedList[i].sslport +"' SIZE=5 onBlur='SetSecure(" + i + ",this,true);SetUpdated();'>");					
					writestr += writeCol(1,195,"<INPUT NAME='host' VALUE='"+parent.head.cachedList[i].host +"' SIZE=25 onBlur='SetUpdated();'>");
					writestr += "</TR>";
				
				<% else %>
				
					writestr += "<TR>"
					writestr += writeCol(1,116,"<INPUT NAME='editMe' VALUE='"+parent.head.cachedList[i].ipaddress +"' SIZE=13 onBlur='SetUpdated();'>");
					writestr += writeCol(1,43,"<INPUT NAME='ipport' VALUE='"+parent.head.cachedList[i].ipport +"' SIZE=5 onBlur='SetSecure(" + i + ",this,false);SetUpdated();'>");
					writestr += writeCol(1,47,"<INPUT NAME='sslport' VALUE='"+parent.head.cachedList[i].sslport +"' SIZE=5 onBlur='SetSecure(" + i + ",this,true);SetUpdated();'>");					
					writestr += writeCol(1,148,"<INPUT NAME='host' VALUE='"+parent.head.cachedList[i].host +"' SIZE=25 onBlur='SetUpdated();'>");
					writestr += "</TR>";

				<% end if %>
			<% end if %>
		}
	}
	writestr += "</TABLE>";
	
	return writestr;
}	
	
function displayVal(dispstr, altstr){
	if (dispstr == ""){
		dispstr = altstr;
	}
	return dispstr;
}

function writeCol(colspan,w,str){
		var writestr = "<TD";
		if (colspan != ""){
			writestr += " COLSPAN = " + colspan
		}
		if (w != ""){
			writestr += " WIDTH = " + w;
		}		
		<% if Session("IsIE") then %>
				writestr += " STYLE = 'font-face: Helv; font-size: 8pt;'";
		<% end if %>		
		writestr += "><FONT FACE='Helv,Arial' SIZE=1>" + str + "</FONT></TD>";

		return writestr;	
}	

function writeLine(str){
	document.write(str);
}
</SCRIPT>

<P>&nbsp;
<P>&nbsp;
</FORM>
<SCRIPT LANGUAGE="JavaScript">
	if (editOK){
		document.listform.editMe.focus();
		document.listform.editMe.select();
	}
</SCRIPT>
</BODY>
</HTML>

