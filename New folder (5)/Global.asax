<%@ Application Language="VB" %>

<script runat="server">
        
    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
	'Response.Redirect("https://www.fransupport.com/down.asp")       
	'Response.end
        Application.Add("LoggedInAdmins", New Hashtable())
 
    End Sub
    
    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
        Application.Remove("LoggedInAdmins")
    End Sub
    
    'Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
    '    ' Code that runs when an unhandled error occurs
    '    Try
    '        Dim strAdditionalInfo As String
    '        Dim strKey As String
    '        Dim objContext As HttpContext = HttpContext.Current

    '        strAdditionalInfo = "URL" & ControlChars.CrLf & "====" & ControlChars.CrLf & Request.Url.ToString()
    '        If Request.UrlReferrer Is Nothing = False Then
    '            strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & ControlChars.CrLf & "URL Referrer" & ControlChars.CrLf & "===========" & ControlChars.CrLf & Request.UrlReferrer.ToString()
    '        End If

    '        strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & ControlChars.CrLf & "Session Variables" & ControlChars.CrLf & "=============="
    '        If objContext.Session IsNot Nothing Then
    '            For Each strKey In objContext.Session.Keys
    '                strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & strKey & " = " & Session.Item(strKey).ToString
    '            Next
    '        End If

    '        strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & ControlChars.CrLf & "Cookies" & ControlChars.CrLf & "======"
    '        For Each strKey In Request.Cookies.Keys
    '            strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & strKey & " = " & Request.Cookies(strKey).Value
    '        Next

    '        strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & ControlChars.CrLf & "Posted Data" & ControlChars.CrLf & "======"
    '        For Each strKey In Request.Form.Keys
    '            If strKey.ToString().ToLower() <> "__viewstate" Then
    '                strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & strKey & " = " & Request.Form(strKey).ToString()
    '            End If
    '        Next

    '        Dim objErrorLogger As New ErrorLogger
    '        If Server.GetLastError.InnerException Is Nothing Then
    '            ErrorLogger.AddError(Server.GetLastError.ToString(), Server.GetLastError.StackTrace, Server.GetLastError.Source, Server.GetLastError.TargetSite.Name, Request.UserAgent, Request.UserHostAddress, strAdditionalInfo)
    '        Else
    '            ErrorLogger.AddError(Server.GetLastError.InnerException.ToString(), Server.GetLastError.InnerException.StackTrace, Server.GetLastError.InnerException.Source, Server.GetLastError.InnerException.TargetSite.Name, Request.UserAgent, Request.UserHostAddress, strAdditionalInfo)
    '        End If
        
    '    Catch ex As Exception
    '        ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, ex.Message, "Exception in Global.asax", "", "", "")
    '    Finally

            '   If HttpContext.Current.Session Is Nothing  Then
            '       Response.Redirect("~/ExpireSession.aspx")
            '   ElseIf HttpContext.Current.Session.Count = 0 Then
            '       Response.Redirect("~/ExpireSession.aspx")
            '   ElseIf HttpContext.Current.Session("AdminCurrentobjUser") Is Nothing Then
            '       'Response.Redirect("~/ExpireSession.aspx")
            'Response.Redirect("~/BlankPage.aspx")
            '   Else
            '   Response.Redirect("~/BlankPage.aspx")
            '   End If

    'End Try
     
        
        '"http://localhost/Portal/ErrorPage.aspx"
        
        
    'strURL = Request.RawUrl.ToLower()
    ' Redirect the user to friendly Error Page if page belongs to Public area
    'If ConfigurationManager.AppSettings("Debug") <> "True" Then
    '    If strURL.IndexOf("/netcenter/") = -1 AndAlso strURL.IndexOf("/callcenter/") = -1 _
    '    AndAlso strURL.IndexOf("/admin/") = -1 AndAlso strURL.IndexOf("/sms/") = -1 _
    '    AndAlso strURL.IndexOf("/webservice/") = -1 Then
    '        Response.Redirect("/Error.aspx")
    '    End If
    'End If 
    'End Sub
       
</script>