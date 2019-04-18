Attribute VB_Name = "Settings"
Option Explicit

Global Const APP_PATH As String = "IIS://localhost/w3svc/1/Root/IISSamples"
Global Const APP_NAME As String = "ExAir"


' The main entry into setting all the IIS ExAir options
Public Function IISSettings(strPath As String) As Boolean
    
    On Error GoTo ErrorHandler
    
    NukeApplication
    
    ' For debugging only
    'MsgBox "Nuked"
    
    SetDir strPath, APP_NAME
    SetDir strPath, APP_NAME & "/Catalog"
    SetDir strPath, APP_NAME & "/Benefits"
    SetDir strPath, APP_NAME & "/FreqFlyer"
    SetDir strPath, APP_NAME & "/BusinessPartners"
    SetDir strPath, APP_NAME & "/SiteAdmin"
    
    ' For debugging only
    'MsgBox "Paths set"
    
    SetSecurity strPath
    SetErrorRedirects strPath & "ErrPages"
    
    ' For debugging only
    'MsgBox "About to set applications"
    
    SetApplication APP_NAME, "Exploration Air Sample Site", True
    SetApplication APP_NAME & "/Catalog", "Test Catalog Site", False
    SetApplication APP_NAME & "/Benefits", "Intranet Benefits", True
    
    ' For debugging only
    'MsgBox "Applications set"
    
    SetDebug
    
    IISSettings = True
    
    Exit Function
    
ErrorHandler:
    MsgBox "An error occurred while setting ExAir config details." _
        & " The error is: " & Hex(Err.Number) & " " & Err.Description, _
        vbOKOnly + vbExclamation, "ExAir Config. Error"
    
    IISSettings = False

End Function
' Attempt to delete an existing ExAir application
Private Sub NukeApplication()
    Dim oRoot As Object
    
    On Error Resume Next
        
    Set oRoot = GetObject(APP_PATH)
    If Err <> 0 Then GoTo NoPath
    
    oRoot.Delete "IIsWebDirectory", APP_NAME
    If Err <> 0 Then GoTo NoWebDir
    
    SmallSleep
    
    oRoot.SetInfo
    SmallSleep
    
NoPath:
NoWebDir:
    Set oRoot = Nothing

End Sub

' Set ExAir etc as a directory
Private Sub SetDir(strPath As String, strName As String)

    On Error GoTo ErrorHandler
    
    Dim oRoot As Object
    Dim oDir As Object
    
    Set oRoot = GetObject(APP_PATH)
    
    SmallSleep
    SmallSleep
    Set oDir = oRoot.Create("IIsWebDirectory", strName)
    oDir.SetInfo
    
    Set oDir = Nothing
    Set oRoot = Nothing
    
    Exit Sub
    
ErrorHandler:
    MsgBox "An error occurred while setting ExAir Web Directory details." _
        & " The error is: " & Hex(Err.Number) & " " & Err.Description, _
        vbOKOnly + vbExclamation, "ExAir Config. Error (SetDir)"
End Sub

' Turn on debugging for the IISSamples VDir
Private Sub SetDebug()

    On Error GoTo ErrorHandler
    
    Dim oRoot As Object
    
    Set oRoot = GetObject(APP_PATH)
    oRoot.AppAllowDebugging = True
    Set oRoot = Nothing
    
    Exit Sub
    
ErrorHandler:
    MsgBox "An error occurred while setting ExAir Web Debugging." _
        & " The error is: " & Hex(Err.Number) & " " & Err.Description, _
        vbOKOnly + vbExclamation, "ExAir Config. Error (SetDebug)"
End Sub
' Set the application type...
Private Sub SetApplication(strAppName As String, strFriendlyName As String, fInProc As Boolean)
    
    On Error GoTo ErrorHandler
    
    Dim oRoot As Object
    Dim oDir As Object
    Dim strWhere As String
    
    strWhere = "getting Root"
    Set oRoot = GetObject(APP_PATH)
    
    strWhere = "getting app"
    Set oDir = oRoot.GetObject("IISWebDirectory", strAppName)
    
    SmallSleep
    SmallSleep
    
    strWhere = "creating app"
    oDir.AppCreate fInProc                    ' Run the application in-process/out-of-proc
    
    strWhere = "setting friendly name"
    oDir.AppFriendlyName = strFriendlyName    ' Name of application
    
    strWhere = "setting exception handling"
    oDir.AspExceptionCatchEnable = False      ' We don't want ASP to catch exceptions (makes debugging easier!)
    
    strWhere = "flushing info"
    oDir.SetInfo
    
    Set oDir = Nothing
    Set oRoot = Nothing
    
    Exit Sub
    
ErrorHandler:
    MsgBox "An error occurred setting ExAir Web Applications details while " & strWhere & "." _
        & " The error is: " & Hex(Err.Number) & " " & Err.Description, _
        vbOKOnly + vbExclamation, "ExAir Config. Error (SetApplication - " & strAppName & ")"
End Sub

' Set some of the error pages (403.4, 403.7 & 404)
Private Sub SetErrorRedirects(strDir As String)
    
    On Error GoTo ErrorHandler
    
    Dim oRoot As Object
    Dim oDir As Object
    Set oRoot = GetObject(APP_PATH)
    Set oDir = oRoot.GetObject("IIsWebDirectory", APP_NAME)
    
    Dim strErrs(), strErr
    Dim i As Integer, j As Integer
    Dim strReplace(3) As String
        
    strReplace(0) = "403,4,FILE," & strDir & "\Err403-4.htm"
    strReplace(1) = "403,7,FILE," & strDir & "\Err403-7.htm"
    strReplace(2) = "404,*,FILE," & strDir & "\Err404.htm"
    
    ' First get all the existing errors
    ' Then search for the error message in the collection
    ' If the error exists then replace it with the correct one from strReplace()
    i = 0
    Const SEARCH_SIZE As Integer = 5
    For Each strErr In oDir.HttpErrors
        ReDim Preserve strErrs(i)
        strErrs(i) = strErr
        For j = 0 To 2
            If Left(strErr, SEARCH_SIZE) = Left(strReplace(j), SEARCH_SIZE) Then
                strErrs(i) = strReplace(j)
                Exit For
            End If
        Next j
        
        i = i + 1
    Next
             
    oDir.HttpErrors = strErrs
    oDir.SetInfo

    Set oDir = Nothing
    Set oRoot = Nothing

    Exit Sub
    
ErrorHandler:
    MsgBox "An error occurred while setting ExAir Error details." _
        & " The error is: " & Hex(Err.Number) & " " & Err.Description, _
        vbOKOnly + vbExclamation, "ExAir Config. Error (SetErrorRedirects)"
End Sub

' Set SSL requirements on two directories
' Set Authentication requirements on one
Private Sub SetSecurity(strPath As String)

    On Error GoTo ErrorHandler
    
    Dim oRoot As Object
    Dim oDir As Object
    Set oRoot = GetObject(APP_PATH)
    Set oDir = oRoot.GetObject("IIsWebDirectory", APP_NAME)
    
    ' SSL Constants from IISCnfg.h
    Const ACCESS_SSL As Integer = &H8
    Const ACCESS_SSL_ALLOW_CERT = &H20
    Const ACCESS_SSL_REQUIRE_CERT As Integer = &H40
    
    ' Authentication constants from IISCnfg.h
    Const AUTH_NTLM As Integer = &H4
    
    Dim oFFDir As Object
    Set oFFDir = oDir.GetObject("IIsWebDirectory", "FreqFlyer")
    oFFDir.AccessSSLFlags = 0 ' Use ACCESS_SSL for SSL channel
    oFFDir.SetInfo
    Set oFFDir = Nothing
    
    Dim oBizDir As Object
    Set oBizDir = oDir.GetObject("IIsWebDirectory", "BusinessPartners")
    oBizDir.AccessSSLFlags = 0 ' Use ACCESS_SSL + ACCESS_SSL_REQUIRE_CERT + ACCESS_SSL_ALLOW_CERT for client authentication
    oBizDir.SetInfo
    Set oBizDir = Nothing
    
    Dim oAdminDir As Object
    Set oAdminDir = oDir.GetObject("IIsWebDirectory", "SiteAdmin")
    oAdminDir.AuthFlags = AUTH_NTLM
    oAdminDir.SetInfo
    Set oAdminDir = Nothing
    
    Dim oBenefitsDir As Object
    Set oBenefitsDir = oDir.GetObject("IIsWebDirectory", "Benefits")
    ' oBenefitsDir.AuthFlags = AUTH_NTLM
    oBenefitsDir.SetInfo
    Set oBenefitsDir = Nothing
    
    Set oDir = Nothing
    Set oRoot = Nothing
    
    Exit Sub
    
ErrorHandler:
    MsgBox "An error occurred while setting ExAir Security details." _
        & " The error is: " & Hex(Err.Number) & " " & Err.Description, _
        vbOKOnly + vbExclamation, "ExAir Config. Error (SetSecurity)"
End Sub

Private Sub SmallSleep()
    Sleep 1000
End Sub
