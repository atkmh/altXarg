<%@ LANGUAGE="VBSCRIPT" %>
<% Option Explicit %>
<% Response.Buffer = True %>

<!--#include file=libAuthenticate.asp-->

<%
  Dim m_Member, m_lngMileage

  ' create a reference to the Member class of the ExAir dll component
  Set m_Member = Server.CreateObject("ExAir.Member")

  ' retrieve the mileage for the current user
  m_lngMileage = m_Member.GetMileage(Application("DSN"), Session("AccountID"))
%>

<!--BEGIN HTML-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<!--META TAGS ARE RECOMMENDED FOR THE SEARCH ENGINE-->
<META NAME="DESCRIPTION" CONTENT="Exploration Air's Book Flights page for members">
<META NAME="KEYWORDS" CONTENT="book, flight, miles, mileage, bonus">
<META NAME="GENERATOR" CONTENT="Microsoft Visual InterDev 1.0">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso8859-1">
<!--END META TAGS-->

<TITLE>Book a Flight using Miles</TITLE>
</HEAD>

<BODY BGCOLOR=#FFFFFF TOPMARGIN=0 LEFTMARGIN=0 ALINK=#23238E VLINK=#228B22 LINK=#23238E>
<BASEFONT FACE="VERDANA, ARIAL, HELVETICA" SIZE=2>

<!--Change link color on mouseover
    Only if running Internet Explorer 4.0 or later -->
<!--#include file=../libHighlight.inc-->
<!--#include file=../libGlobalFuncs.inc-->

<!--COLOR BANNER_START-->
<TABLE WIDTH=100% CELLPADDING=0 CELLSPACING=0 BORDER=0>
	<TR>
	  <TD BGCOLOR="#C71585" WIDTH=100% HEIGHT=20>
	  </TD>
	</TR>
</TABLE>
<!--COLOR BANNER_END-->


<!--BEGIN TABLE CONTAINING LOGO, TITLE, AND NAVIGATIONAL LINK-->
<TABLE WIDTH=100% CELLPADDING=0 CELLSPACING=0 BORDER=0>
	<TR>
	  <TD VALIGN=TOP WIDTH=415 HEIGHT=76>
			<IMG SRC="images/freqflyer.jpg" WIDTH=420 HEIGHT=240 ALT="Exploration Air Frequent Flyer logo">
			<BR>
			<A HREF="<%=HomePage("..")%>"><IMG SRC="../images/barrowy.gif" HEIGHT=8 WIDTH=8 HSPACE=5 ALT="Return to Exploration Air Home Page" BORDER=0></A>&nbsp;
			<FONT FACE="VERDANA, ARIAL, HELVETICA" SIZE=2><STRONG><A HREF="<%=HomePage("..")%>">EXPLORATION AIR HOME PAGE</A></STRONG></FONT>
	  </TD>
	  <TD VALIGN=MIDDLE WIDTH=200><FONT FACE="VERDANA, ARIAL, HELVETICA" COLOR="#0000FF" SIZE=5>Book a Flight using Miles</FONT>
	  </TD>
	</TR>
	<TR>
	  <TD VALIGN=TOP WIDTH=415 HEIGHT=15>
			<A HREF="default.asp"><IMG SRC="../images/barrowy.gif" HEIGHT=8 WIDTH=8 HSPACE=5 ALT="Return to Frequent Flyer Home Page" BORDER=0></A>&nbsp;
			<FONT FACE="VERDANA, ARIAL, HELVETICA" SIZE=2> <STRONG><A HREF="default.asp">FREQUENT FLYER HOME PAGE</A></STRONG></FONT>
	  </TD>
	</TR>
</TABLE>
<!--END TABLE CONTAINING LOGO, TITLE, AND NAVIGATIONAL LINK -->

<BR>
<BR>

<% If Request.Form("FlyFrom") = "" Then %>
<!-- BEGIN TABLE CONTAINING MAIN CONTENT-->
<FORM ACTION="BookFlight.asp" METHOD="POST">
<CENTER>

<FONT SIZE=3>Flights may be booked no more than one year in advance</FONT>
<P>

<TABLE BORDER=1 BORDERCOLOR="#000000" CELLPADDING=0 CELLSPACING=0 HEIGHT=168 WIDTH=455>
	<TR>
		<TD WIDTH=555 VALIGN=TOP HEIGHT=16 COLSPAN=7 BGCOLOR="#000084">
			<FONT SIZE="1" COLOR="#FFFFFF" FACE="MS Sans Serif, Arial, Helv">
			<B>&nbsp;
			Exploration Air Flight Wizard
			</B></FONT>
		</TD>
	</TR>

	<TR>
		<TD WIDTH="450" COLSPAN="7"> 
			<CENTER>
			<TABLE BORDER=0>
				<TR>
					<FONT FACE="MS Sans Serif, Arial, Helv" SIZE="2">
					<STRONG>I&nbsp;wish to:</STRONG>
					</FONT>
				</TR>

				<TR>
					<TD WIDTH=100>
						<FONT FACE="MS Sans Serif, Arial, Helv" SIZE="1">
						<STRONG>Fly from:</STRONG>
						</FONT>
					</TD>
					<TD>
						<SELECT NAME="FlyFrom">
							<% GetCities %>
						</SELECT>
					</TD>
				</TR>

				<TR>
					<TD WIDTH=100>
						<FONT FACE="MS Sans Serif, Arial, Helv" SIZE="1">
						<STRONG>Fly to:</STRONG>
						</FONT>
					</TD>
					<TD>
						<SELECT NAME="FlyTo">
							<% GetCities %>
						</SELECT>
					</TD>
				</TR>

				<TR>
					<TD WIDTH=100>
						<FONT FACE="MS Sans Serif, Arial, Helv" SIZE="1">
						<STRONG>Fly on this date:</STRONG>
						</FONT>
					</TD>
					<TD>
						<SELECT NAME="FlyDateMonth">
							<OPTION>January
							<OPTION>February
							<OPTION>March
							<OPTION>April
							<OPTION>May
							<OPTION>June
							<OPTION>July
							<OPTION>August
							<OPTION>September
							<OPTION>October
							<OPTION>November
							<OPTION>December
						</SELECT>
						<INPUT TYPE=TEXT NAME="FlyDateDay" SIZE=2>
					</TD>
				</TR>

				<TR>
					<TD WIDTH=100>
						<FONT FACE="MS Sans Serif, Arial, Helv" SIZE="1">
						<STRONG>Fly this class:</STRONG>
						</FONT>
					</TD>
					<TD>
						<SELECT NAME="FlyClass">
							<OPTION>Coach
							<OPTION>Business
							<OPTION>First
						</SELECT>
					</TD>
				</TR>
			</TABLE>
			</CENTER>
		</TD>
	</TR>

	<TR>
		<TD WIDTH="450" HEIGHT=40 ALIGN=RIGHT COLSPAN="2">
			<FONT FACE="MS Sans Serif, Arial, Helv" SIZE="1">
			<INPUT TYPE="SUBMIT" NAME="Finish" VALUE="Book Flight!">
			&nbsp;
			<br>
			</FONT>
		</TD>
	</TR>

	<TR>
		<TD WIDTH="555" VALIGN=TOP HEIGHT=16 COLSPAN=7 BGCOLOR="#000084">
			<BR>
		</TD>
	</TR>
</TABLE>
</CENTER>
<% 
  Else
	Dim fFormErr, strFormErr
	fFormErr = False

	Dim strFrom, strTo, strClass, strFlyDateDay, strFlyDateMonth
	strFrom = Request.Form("FlyFrom")
	strTo = Request.Form("FlyTo")
	strClass = Request.Form("FlyClass")
	strFlyDateDay = Request.Form("FlyDateDay")
	strFlyDateMonth = Request.Form("FlyDateMonth")

	If strFrom="" Or strTo="" Or strClass="" Or strFlyDateMonth="" Or strFlyDateDay="" Then
		fFormErr = True
		strFormErr = "You must enter all the form data."
	End If

	If strFrom = strTo Then
		fFormErr = True
		strFormErr = "Origin and destination of flight must be different."
	End If

	Dim iDate, iMonth, strMonth
	iDate = strFlyDateDay
	strMonth = strFlyDateMonth

	If iDate="" Then iDate=0

	Select Case strMonth
		Case "January"
			iMonth = 1
		Case "February"
			iMonth = 2
		Case "March"
			iMonth = 3
		Case "April"
			iMonth = 4
		Case "May"
			iMonth = 5
		Case "June"
			iMonth = 6
		Case "July"
			iMonth = 7
		Case "August"
			iMonth = 8
		Case "September"
			iMonth = 9
		Case "October"
			iMonth = 10
		Case "November"
			iMonth = 11
		Case "December"
			iMonth = 12
		Case Else
			fFormErr = True
			strFormErr = "You have entered an in appropriate month.  Please re-enter."
	End Select

	Select Case strMonth
		Case "January", "March", "May", "July", "August", "October", "December"
			If iDate > 31 Or iDate < 1 Then 
				fFormErr = True
				strFormErr = "You must enter an appropriate day (1-31) for the month of " & strMonth
			End If

		Case "February"
			' HACK! Does not handle leap years yet
			If iDate > 28 Or iDate < 1 Then 
				fFormErr = True
				strFormErr = "You must enter an appropriate day (1-28) for the month of " & strMonth
			End If

		Case Else
			If iDate > 30 Or iDate < 1 Then 
				fFormErr = True
				strFormErr = "You must enter an appropriate day (1-30) for the month of " & strMonth
			End If
	End Select 

	Dim Flights, FlightMiles, FlightNumber
	Set Flights = Server.CreateObject("Flight.Schedule")
	FlightMiles = Flights.CostOfFlightInMiles(Application("DSN"), strFrom,strTo,strClass)
	FlightNumber = Flights.FlightNumber(Application("DSN"), strFrom, strTo)

	If IsNull(m_lngMileage) Then m_lngMileage = 0

	If FlightMiles > m_lngMileage Then
		fFormErr = True
		strFormErr = "You have insufficient frequent flier miles to fly from " & strFrom & " to " & strTo & ". <BR>" & _
					 "You need " & FormatNumber(FlightMiles,0) & " but only have " & FormatNumber(m_lngMileage,0) & "."
	End If
							 
	If fFormErr Then
		Response.Redirect "BookFlightError.asp?ErrorString=" & Server.URLEncode(strFormErr)
	Else
		Dim CheckDate, FlightDate
		CheckDate = CDate(Year(Now) & "/" & iMonth & "/" & iDate)
		If CheckDate > Date Then
			FlightDate = CheckDate
		Else
			FlightDate = CDate(Year(Now)+1 & "/" & iMonth & "/" & iDate)
		End If
	    
		Dim strQueryString
		strQueryString = "From=" & Server.URLEncode(strFrom) & "&" & _
						 "To=" & Server.URLEncode(strTo) & "&" & _ 
						 "AccountID=" & Session("AccountID") & "&" & _
                         "FlightNumber=" & FlightNumber & "&" & _
						 "FlightDate=" & FlightDate & "&" & _
						 "FlightMiles=" & FlightMiles & "&" & _
						 "MilesLeft=" & m_lngMileage - FlightMiles & "&" & _
						 "Class=" & Server.URLEncode(strClass)
		
		Response.Redirect "DoBookFlight.asp?" & strQueryString
	End If
  
  End If


%> 
<!-- END TABLE CONTAINING MAIN CONTENT-->

<P> 
<HR=400>
<P>

<CENTER>
<FONT FACE="VERDANA, ARIAL, HELVETICA" SIZE="1"><A HREF="../legal.htm">&#169;1997 Microsoft Corporation. All rights reserved. Terms of Use.</A></FONT>
</CENTER>

<P>

<!--BEGIN COLOR BANNER-->
<TABLE WIDTH=100% CELLPADDING=0 CELLSPACING=0 BORDER=0>
	<TR>
	  <TD BGCOLOR="#C71585" WIDTH=100% HEIGHT=20>
	  </TD>
	</TR>
</TABLE>
<!--END COLOR BANNER-->

<% Response.Flush %>

</BODY>
</HTML>

<% 
	Sub GetCities
		Dim strDest, Flights, DSN, Dest
		DSN = Application("DSN")
		Set Flights=Server.CreateObject("Flight.Schedule")
		Set Dest = Flights.Destinations(DSN)
		Do While Not Dest.EOF
			strDest = Dest("CityName")
			Response.Write("<OPTION> " & strDest)
			Dest.MoveNext
		Loop
	End Sub
%>
