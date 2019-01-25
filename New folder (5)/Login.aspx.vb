Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Data.SqlClient
Imports System.Web

Partial Class Portal_Login
    Inherits System.Web.UI.Page

    Private _strPIN As String

    Public ticketNo As String = String.Empty
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Browser Support Check
        Functions.CheckForIEAndMac()
        If IsNumeric(lblKey.Text) Then
            _strPIN = Trim(lblKey.Text)
        End If
        Randomize()
        lblKey.Text = Format(Int((9999 * Rnd()) + 0), "0000")

        If String.IsNullOrEmpty(Request.QueryString("TicketNo")) = False Then
            ticketNo = Functions.DecryptData(Request.QueryString("TicketNo"))
        ElseIf String.IsNullOrEmpty(Request.QueryString("GotoTicketNo")) = False Then
            ticketNo = Functions.DecryptData(Request.QueryString("GotoTicketNo"))
        End If
        
        If String.IsNullOrEmpty(ticketNo) = False AndAlso IsNumeric(ticketNo) AndAlso String.IsNullOrEmpty(Request.QueryString("GotoTicketNo")) = True Then
            If CType(HttpContext.Current.Session("AdminID"), Integer) = (CType(HttpContext.Current.Session("Admin_SessionID"), Integer)) AndAlso CType(HttpContext.Current.Session("AdminID"), Integer) <> 0 Then
                DoLoginProcess()
            Else
                Response.Redirect("~/login.aspx?GotoTicketNo=" & Functions.EncryptData(ticketNo), True)
            End If
        End If

        If Not IsPostBack Then
            If String.IsNullOrEmpty(Session("AdminID")) = False Then
                'LMS.BusinessLogicLayer.User.UpDateLastAccessTimeAndLoginStatus(CType(Session("AdminID"), Integer), False, HttpContext.Current.Request.UserHostAddress, CType(Session("Admin_SessionID"), Integer))
                'LMS.BusinessLogicLayer.User.EndUserSessionFromApplication(CType(Session("AdminID"), Integer), CType(Session("Admin_SessionID"), Integer))
            End If
            HttpContext.Current.Session.RemoveAll()
            HttpContext.Current.Response.Cookies("PortalPM").Expires = DateTime.Now.AddDays(-1)
            HttpContext.Current.Response.Cookies.Remove("PortalPM")
            HttpContext.Current.Response.Cookies.Clear()
        End If

        trErrorMessage.Visible = False
        spnError.InnerText = String.Empty


        'Me.txtUserName.Attributes.Add("value", "msaqib")
        'Me.txtPassword.Attributes.Add("value", "0")
        'Dim RevStr As String = lblKey.Text.Chars(3) & lblKey.Text.Chars(2) & lblKey.Text.Chars(1) & lblKey.Text.Chars(0)
        'Me.txtPIN.Attributes.Add("value", RevStr)
    End Sub
    Private Function PageIPAuthentication() As Boolean
        Dim strIPs As String = CStr(ConfigurationManager.AppSettings("PortalAllowedIPs"))
        Dim strIPArray As String() = strIPs.Split(",")
        For i As Integer = 0 To strIPArray.Length - 1
            If strIPArray(i).Trim() = HttpContext.Current.Request.UserHostAddress.ToString().Trim() Then
                Return True
            End If
        Next
		Return False
    End Function

    Protected Sub cmdSignIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSignIn.Click
        If PageIPAuthentication() = False Then
            If Request.QueryString("T") <> String.Empty Then
                Dim tstr As String = Request.QueryString("T")
                tstr = Functions.DecryptData(tstr)
                If IsDate(tstr) AndAlso CType(tstr, DateTime) > DateTime.Now.AddMinutes(-15) Then
                    validateUser(Trim(txtUserName.Text), Trim(txtPassword.Text), Trim(_strPIN), Trim(txtPIN.Text), True, Enumeration.Login_Request.Launchpad)
                Else
                    Response.Redirect("AccessDenied.aspx")
                End If
            Else
                validateUser(Trim(txtUserName.Text), Trim(txtPassword.Text), Trim(_strPIN), Trim(txtPIN.Text), True, Enumeration.Login_Request.Remote)
            End If
        Else
            validateUser(Trim(txtUserName.Text), Trim(txtPassword.Text), Trim(_strPIN), Trim(txtPIN.Text), True, Enumeration.Login_Request.Office)
        End If
        'validateUser(Trim(txtUserName.Text), Trim(txtPassword.Text), Trim(_strPIN), Trim(txtPIN.Text), True)
    End Sub

    Sub validateUser(ByVal UserName As String, ByVal Password As String, ByVal _PIN As String, ByVal PIN As String, ByVal chkPIN As Boolean, ByVal Login_Request As Enumeration.Login_Request)
        Dim objUser As New Users()
        Dim valStatus As Users.ValidationStatus

        tblConflict.Visible = False
        tblForm.Style.Remove("display")

        'Password = Functions.EncryptData(Password)

        valStatus = objUser.ValidateUser(UserName, Password, _PIN, PIN, True, chkPIN, Login_Request)
        Select Case valStatus
            Case Portal.BLL.Users.ValidationStatus.WrongPIN
                spnError.InnerText = "Incorrect Pin!"
                trErrorMessage.Visible = True
            Case Portal.BLL.Users.ValidationStatus.UserNotFound
                spnError.InnerText = "Invalid Username Or Password!"
                trErrorMessage.Visible = True
            Case Portal.BLL.Users.ValidationStatus.UserNotAuthorized
                spnError.InnerText = "Authentication Failed!"  ' OR he is Remote user
                trErrorMessage.Visible = True
            Case Portal.BLL.Users.ValidationStatus.NoClientAccess
                spnError.InnerText = "No Access Rights!"  ' OR No Client module Assinged 
                trErrorMessage.Visible = True
            Case Portal.BLL.Users.ValidationStatus.Validated
                DoLoginProcess()
        End Select
    End Sub

    Protected Sub DoLoginProcess()
        InitializeLoginSession()
        AddLoginHistory()
        GetUserModules()
        GetUserSubModules()
        AddCookies()
        If Session("UserBrowser") = "AppleMAC-Safari" Then
            'Response.Redirect("~/URLM/UrlmMain.aspx", True)
            Response.Redirect("~/PM/PMMain.aspx", True)
        End If
        If (CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ChangePasswordvar) Then
            Response.Redirect("~/ChangePassword.aspx?Temp=TempPassword")
        End If
        If (CBool(Session("Admin_ChangePassword")) = True) Then
            Response.Redirect("~/ChangePassword.aspx?Type=Password")
        End If
        If Portal.BLL.News.News.NewsGetByUserID(CType(Session("AdminID"), Integer)).Rows.Count > 0 Then
            Response.Redirect("~/News/News_Portal.aspx")
        End If
        If Portal.BLL.Communication.WeeklyLetter.WeeeklyLettersGetByUserID(CType(Session("AdminID"), Integer)).Rows.Count > 0 Then
            Response.Redirect("~/Communication/WeeklyLetterHome.aspx")
        End If
        If String.IsNullOrEmpty(ticketNo) = False AndAlso IsNumeric(ticketNo) AndAlso ticketNo <> String.Empty Then
            Response.Redirect("PM/PMMain.aspx?Page=TicketsDetail.aspx?ReleaseID=0&ID=" & ticketNo.Trim() & "&PrevPage=1&ClientID=0", True)
        Else
        Response.Redirect("~/Home.aspx", True)
        End If

    End Sub
    Private Sub AddCookies()
        'Dim PortalPM As New HttpCookie("PortalPM")
        'PortalPM.Values("UserType") = "PortalUser"
        'PortalPM.Expires = DateTime.Now.AddDays(1)
        'HttpContext.Current.Response.Cookies.Add(PortalPM)
    End Sub
    Protected Sub GetUserModules()
        Dim AdminID As Integer = CType(Session("AdminID"), Integer)
        Dim colModules As New System.Collections.Generic.List(Of Portal.BLL.Modules)()
        colModules = Modules.ModulesGetByUserID(AdminID)
        Dim strModuleIDcsv As String = ""
        If colModules.Count > 0 Then
            Dim i As Integer
            For i = 0 To colModules.Count - 1
                strModuleIDcsv = strModuleIDcsv & " ," & colModules.Item(i).ID.ToString()
            Next
            strModuleIDcsv = strModuleIDcsv.Remove(0, 2)
            HttpContext.Current.Session.Add("UsersModulesID", strModuleIDcsv)
        End If
    End Sub
    Protected Sub GetUserSubModules()
        Dim AdminID As Integer = CType(Session("AdminID"), Integer)
        Dim CSVSubModules As String = Modules.SubModulesGetByUserID(AdminID)
        HttpContext.Current.Session.Add("UsersSubModulesID", CSVSubModules)
    End Sub

    Protected Sub AddLoginHistory()
        Dim AdminID As Integer = CType(Session("AdminID"), Integer)
        Dim HR_LoginHistoryID As Integer = Portal.BLL.HR.HR_LoginHistory.LoginHistoryAdd(0, AdminID, HttpContext.Current.Request.UserHostAddress, System.DateTime.Now, Nothing)
        HttpContext.Current.Session.Add("HR_LoginHistoryID", HR_LoginHistoryID)
    End Sub

    Protected Sub InitializeLoginSession()
        'Dim AdminID As Integer = CType(Session("AdminID"), Integer)
        'Dim UserSessionID As Integer = 0
        'UserSessionID = LMS.BusinessLogicLayer.User.UpDateLastAccessTimeAndLoginStatus(AdminID, True, HttpContext.Current.Request.UserHostAddress, Nothing)
        'Users.LogUsersInApplication(AdminID, UserSessionID)
        Session.Add("Admin_SessionID", CType(Session("AdminID"), Integer)) 'UserSessionID
    End Sub
End Class
