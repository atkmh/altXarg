<%Response.Expires=0%>
<HTML>
<HEAD>
<TITLE>Certificate Server Enrollment Form</TITLE>
<META HTTP-EQUIV="Cache-Control" CONTENT="no cache">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="Pragma" CONTENT="no cache">
<META HTTP-EQUIV="Expires" CONTENT="0">


<%  Set BrowserCap = Server.CreateObject("MSWC.BrowserType") 

    Dim ControlType, BrowserType, BrowserString, BrowserVersion
    Dim StrIndex, Devisor 

    ControlType = "UNKNOWN"
    BrowserType = "" 
    BrowserString = ""
    R_BrowserVersion = 0
    BrowserVersion = 0
    Devisor = 10
      
    if Request.Form("sBrowser") = "" then 
	BrowserType = UCase(BrowserCap.browser)
	BrowserString = BrowserCap.version        
    else
	if Request.Form("sBrowser") = "IE4" then
	     ControlType = "XENROLL"
        elseif Request.Form("sBrowser") = "IE3" then
	     ControlType = "CERTENR3"
        elseif Request.Form("sBrowser") = "NETSCAPE" then
	     ControlType = "NETSCAPE"
        end if
    end if

    if BrowserType = "IE" and ControlType = "UNKNOWN" then    
         StrIndex = InStr(BrowserString, ".")
         if StrIndex > 0 then
            BrowserVersion = Left(BrowserString, StrIndex-1)     
            
            if (BrowserVersion = 3) then
              StrLength = Len(BrowserString)
              while StrLength >= StrIndex+1
               if mid(BrowserString, StrIndex+1, 1) > 0 then
                  BrowserVersion = BrowserVersion + (mid(BrowserString, StrIndex+1, 1)/Devisor)
                  Devisor = 10
               else 
                  Devisor = Devisor*10
               end if
               StrIndex = StrIndex +1
              wend
            end if
         else
            BrowserVersion = BrowserString
         end if

	 if BrowserVersion < 3 then
	     ControlType = ""
 	 
	 elseif BrowserVersion = 3 and _    
		 Instr(UCase(Request.ServerVariables("HTTP_UA_CPU")), "ALPHA") = 0 then
	      ControlType = "CERTENR3"
	 
         elseif BrowserVersion > (3+(2/100)) then
             ControlType = "XENROLL"
             
	 elseif BrowserVersion = (3+(2/100)) and _
                Instr(UCase(Request.ServerVariables("HTTP_USER_AGENT")), "UPDATE") > 0 then
             ControlType = "XENROLL"

	 elseif BrowserVersion <= 3+(2/100) and _
                Instr(UCase(Request.ServerVariables("HTTP_UA_CPU")), "ALPHA") = 0 then
	     ControlType = "CERTENR3"
             BrowserVersion = 3	 	
 
	 else
             ControlType = ""
             BrowserVersion = 0	 
         end if 

    elseif BrowserType = "NETSCAPE" and ControlType = "UNKNOWN" then
         ControlType = "NETSCAPE"
         BrowserVersion = 1
    end if  
%>


<% if (ControlType = "XENROLL") then %>
      
      <OBJECT
        classid="clsid:43F8F289-7A20-11D0-8F06-00C04FC295E1"
        CODEBASE="/CertControl/xenroll.cab#Version=5,131,1877,1"       
        id=IControl
        >
      </OBJECT>
  

<% elseif ControlType = "CERTENR3" then %>
      
      <OBJECT
        classid="clsid:33BEC9E0-F78F-11cf-B782-00C04FD7BF43"
    	CODEBASE="/CertControl/x86/certenr3.dll#Version=4,70,1143"
        id=IControl
      >
      </OBJECT>

<% end if %>


<% if ControlType <> "NETSCAPE" and ControlType <> "UNKNOWN" then %> 


<SCRIPT LANGUAGE="JAVASCRIPT">
<!--
   function geterror(message, url, value) {

     if (message == "Out of memory") {
       msg = "Xenroll is unable to generate a PKCS10:\n\n Please verify ";
       msg = msg + "that your CSP supports any settings you have made \n";
       msg = msg + "and that your input is valid."; 
       
       alert(msg);
       
       return true;
     }
     else 
       return false;
  }
-->
</SCRIPT>



 <SCRIPT LANGUAGE="JAVASCRIPT">
<!--
   function SubmitRequest() {
  
    CommonName = document.ReqForm.CommonName.value;
    OrgUnit = document.ReqForm.OrgUnit.value;
    Org = document.ReqForm.Org.value;
    Locality = document.ReqForm.Locality.value;
    State = document.ReqForm.State.value;
    Country = document.ReqForm.Country.value;

    szPKCS10 = "";

    DN = "";
    DN = DN + "C=" + Country + ";";
    DN = DN + "S=" + State + ";";
    DN = DN + "L=" + Locality + ";";
    DN = DN + "O=" + Org + ";";
    DN = DN + "OU=" + OrgUnit + ";";
    DN = DN + "CN=" + CommonName + ";";
    
  <% if ControlType <> "CERTENR3" then %>
    Email= document.ReqForm.Email.value;
    DN = DN + "Email=" + Email + ";";
  <% end if %>
     
  <% if ControlType = "XENROLL" then %>
  
    onerror=geterror; 
   
    <% if Request.Form("CertUsage") = "" then %>
        IControl.KeySpec = 1;
        document.ReqData.CertUsage.value = "1.3.6.1.5.5.7.3.2";
    <% else %>
        
      if ("<%=Request.Form("ContainerName")%>" != "") 
        IControl.ContainerName = "<%=Request.Form("ContainerName")%>";

      if ("<%=Request.Form("ProviderName")%>" != "") {
         IControl.ProviderName = "<%=Request.Form("ProviderName")%>";
         IControl.ProviderType =  <%=Request.Form("ProviderType")%>;
       }

      if ("<%=Request.Form("HashAlgorithm")%>" != "")  
         IControl.HashAlgorithm = "<%=Request.Form("HashAlgorithm")%>"
    
      IControl.GenKeyFlags = <%=Request.Form("GenKeyFlag")%>;
      if ("<%=Request.Form("ExportKeys")%>" != "")  
         IControl.PVKFileName = "<%=Request.Form("ExportKeys")%>";
       
      document.ReqData.CertUsage.value = "<%=Request.Form("CertUsage")%>";      
      document.ReqData.WriteCertToCSP.value = "<%=Request.Form("WriteCertToCSP")%>";
      document.ReqData.SaveCert.value = "<%=Request.Form("SaveCert")%>";
      IControl.KeySpec = <%=Request.Form("KeySpec")%>;
      IControl.UseExistingKeySet = <%=Request.Form("UseExistingKeySet")%>;   
          
    <% end if %>

      szPKCS10 = IControl.CreatePKCS10(DN, document.ReqData.CertUsage.value);
      document.ReqData.CertRequest.value = szPKCS10;

  <% elseif ControlType = "CERTENR3" then %>
         
     szSessionID=<%=Session.SessionID%>
     szPKCS10 = IControl.GenerateKeyPair(szSessionID, false, DN, 0, "ClientAuth", false, true, 1);
     document.ReqData.CertRequest.value = szPKCS10;
     document.ReqData.PassThru.value = szSessionID;      

  <% end if %>
  
     if (szPKCS10 != "")
       document.ReqData.submit();
     else {
       Msg = "The data you have entered appears to be invalid.";
       alert(Msg);
       window.navigate ("/certsrv/default.htm")
     }
   }   
-->
   </SCRIPT> 

<% end if %>


<% if ControlType = "XENROLL" then %>
     
     <SCRIPT LANGUAGE="VBSCRIPT"> 
<!--
       function Adv()
       	
         Dim CspList, CspCount, cspIndex, ProviderName
         On Error Resume Next
         
         CspList = ""
         NumOfCsps = 0
         StrSize = 0
         ProviderName = ""
         
         For ProvType = 0 to 1  
           cspIndex = 0
           'ProviderName = ""             
           IControl.ProviderType = ProvType
           ProviderName = IControl.enumProviders(cspIndex,0)
	    
	   while ProviderName <> "" 	     
              CspList = CspList & ProvType & "*" & ProviderName & "*"
              cspIndex = cspIndex +1
              ProviderName = ""
              ProviderName = IControl.enumProviders(cspIndex,0)
	                
           wend
           CspCount = (CspCount +1) + (cspIndex-1) 
         Next
         
         document.CSPFORM.CspList.value = CspList
         document.CSPFORM.CspCount.value = CspCount
 
         document.CSPFORM.CommonName.value = document.ReqForm.CommonName.value
         document.CSPFORM.Org.value = document.ReqForm.Org.value
         document.CSPFORM.OrgUnit.value = document.ReqForm.OrgUnit.value
         document.CSPFORM.Locality.value = document.ReqForm.Locality.value
         document.CSPFORM.State.value = document.ReqForm.State.value
         document.CSPFORM.Country.value = document.ReqForm.Country.value
         document.CSPFORM.Email.value = document.ReqForm.Email.value
	 
	 
         if CspCount = 0 then
		msg = "The enrollment control did not successfully download to"
		msg = msg & " your machine.  These pages require the control and will not"
	 	msg = msg & " work correctly without it."
		
                Button = MsgBox (msg, 21, "Xenroll")
                
                if Button = vbRetry then
		 window.navigate ("ceenroll.asp")
		else
		 window.navigate ("/certsrv/default.htm")
                end if
         else
	  document.CSPFORM.submit() 
	end if
       
       end function
-->
       </SCRIPT>


<% End If %>

</HEAD>

 <BODY Background="csback.gif">
 <BODY BGCOLOR=#FFFFFF>
 <B><A HREF="/CertSrv/default.htm">HOME</A></B>
 <HR>
 <IMG SRC="cslogo.gif" alt="Product Logo"> 


 <% if ControlType = "NETSCAPE" or _
      ControlType = "CERTENR3" or _
      ControlType = "XENROLL" then %>

 <CENTER> 
 
 <FONT SIZE=6><B>Certificate Enrollment Form</B></FONT>
 
 <% if ControlType = "NETSCAPE" then %>
  <FORM NAME="CertForm" ACTION="kgaccept.asp" ENCTYPE=x-www-form-encoded METHOD=POST>
 <% else %>
  <FORM NAME="ReqForm" ENCTYPE=x-www-form-encoded METHOD=POST>
 <% end if%>

   <TABLE BORDER=8>
   <TR>
   <TH ALIGN=LEFT><B>Name:</B></TH>	
   <TD><INPUT TYPE="TEXT" MAXLENGTH="64" SIZE=42 NAME="CommonName" VALUE= "<%=Request.Form("CommonName")%>"></TD>
   <TR>
   <TH ALIGN=LEFT><B>Department:</B></TH>		
   <TD><INPUT TYPE="TEXT" MAXLENGTH="64" SIZE=42 NAME="OrgUnit" VALUE= "<%=Request.Form("OrgUnit")%>"></TD>
   <TR>
   <TH ALIGN=LEFT><B>Organization:</B></TH>	
   <TD><INPUT TYPE="TEXT" MAXLENGTH="64" SIZE=42 NAME="Org" VALUE= "<%=Request.Form("Org")%>"></TD>
   <TR>
   <TH ALIGN=LEFT><B>City:</B></TD>		
   <TD><INPUT TYPE="TEXT" MAXLENGTH="64" SIZE=42 NAME="Locality" VALUE= "<%=Request.Form("Locality")%>"></TD>
   <TR>
   <TH ALIGN=LEFT <B>State:</B></TH>	
   <TD><INPUT TYPE="TEXT" MAXLENGTH="64" SIZE=42 NAME="State" VALUE= "<%=Request.Form("State")%>"></TD>
   <TR>
   <TH ALIGN=LEFT <B>Country:</B></TH>		
   <TD><INPUT TYPE="TEXT" MAXLENGTH="2" SIZE=42 NAME="Country" VALUE= "<%=Request.Form("Country")%>"></TD> 
   <TR>
   <TH ALIGN=LEFT <B>E-Mail:</B></TH>
   <TD><INPUT TYPE="TEXT" MAXLENGTH="64" SIZE=42 NAME="Email" VALUE= "<%=Request.Form("Email")%>"></TD>
    
  <%if ControlType = "NETSCAPE" then %>
 	<TR>
        <TH ALIGN=LEFT <B>Key Strength:</B></TH>	
        <TD><KEYGEN TYPE="hidden" NAME="CertRequest" CHALLENGE="test"></TD>
        </TABLE>
        <BR>
        <INPUT TYPE="Submit" NAME="Request" value="Submit">	
        </FORM>
  <% else %>
   </TABLE>
   </FORM>
   </FONT>

  <TABLE>   
   <TH ALIGN=LEFT>	
   <FORM NAME="ReqData" ACTION="ceaccept.asp" ENCTYPE=x-www-form-encoded METHOD=POST>
      <INPUT TYPE="HIDDEN" NAME="CertRequest">
      <INPUT TYPE="HIDDEN" NAME="CertAttrib" VALUE="">
      <INPUT TYPE="HIDDEN" NAME="SubmitFlag" VALUE=257>
      <INPUT TYPE="HIDDEN" NAME="GetCertFlag" VALUE=257>
      <INPUT TYPE="HIDDEN" NAME="ControlType" VALUE=<%=ControlType%>>
      <INPUT TYPE="HIDDEN" NAME="PassThru" VALUE="ceenroll.asp">       
      <INPUT TYPE="HIDDEN" NAME="CertUsage">
      <INPUT TYPE="HIDDEN" NAME="WriteCertToCSP">
      <INPUT TYPE="HIDDEN" NAME="SaveCert">
      <INPUT TYPE="Submit" NAME="Request" value="Submit Request" onClick="SubmitRequest()">
   </FORM>
   </TH>
 
    <% if CONTROLTYPE = "XENROLL" then %>

      <TD>  
      <FORM NAME="CSPFORM" ACTION="ceadv.asp" ENCTYPE=x-www-form-encoded METHOD=POST>
        <INPUT TYPE="HIDDEN" NAME="CspList" VALUE="">
        <INPUT TYPE="HIDDEN" NAME="CspCount" VALUE=0>
        <INPUT TYPE="HIDDEN" NAME="CommonName">
        <INPUT TYPE="HIDDEN" NAME="Org">
        <INPUT TYPE="HIDDEN" NAME="OrgUnit">
        <INPUT TYPE="HIDDEN" NAME="Locality">
        <INPUT TYPE="HIDDEN" NAME="State">
        <INPUT TYPE="HIDDEN" NAME="Country">
        <INPUT TYPE="HIDDEN" NAME="Email">
        <INPUT TYPE="Submit" NAME="Advanced" value="Advanced" OnClick="Adv()">
      </FORM>    
      </TD>
     <% end if %>
  </TABLE>

 <% end if %>   

 </CENTER>
 

 <% elseif ControlType = "UNKNOWN" then %>
  <CENTER>
  <FONT SIZE=6><B>Please select your browser type.</B></FORM>
  <B>
  <BR><BR>
  <FORM ACTION="ceenroll.asp" METHOD=POST>
    <TABLE BORDER=8 CELLPADDING=20> 
    
    <TD ALIGN=CENTER>
	<FONT SIZE=5>
	  Browser Type
	  <BR>
	  <SELECT NAME="sBrowser"> 
	   <OPTION SELECTED VALUE="IE4"> Microsoft Internet Explorer 4.0
	   <OPTION VALUE="IE4"> Microsoft Internet Explorer 3.02 with Authenticode 2.0
	   <OPTION VALUE="IE3"> Microsoft Internet Explorer 3.0 to 3.02
	   <OPTION VALUE="NETSCAPE"> Netscape
	  </SELECT>
	<BR><BR>		       
	<INPUT TYPE="submit" VALUE="Submit"></TD>
    </B></FONT>
    </TABLE>
  </FORM>
  </CENTER>

 <% else %>

  <CENTER>
  <H1>Error!!!</H1>
  <B>
  <FONT SIZE=5>
  Your browser does not appear to meet the requirments for Certificate Enrollment.
  </FONT>
  <FONT SIZE=5> 
  <BR><BR><BR>
  Please upgrade your browser to latest version of Microsoft Internet Explorer.
  </FONT>
  </B>	
  <BR><BR><BR><BR> 
  </CENTER>

 <% end if %>


  <!--FOOTER START-->
  <HR>
  <HR>
  <i>&#169; 1997 by Microsoft Corporation. All rights reserved.</i>
  <!--FOOTER END-->
 
</BODY>
</HTML>



