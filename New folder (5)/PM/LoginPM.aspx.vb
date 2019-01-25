Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Data.SqlClient
Imports System.Web

Partial Class PM_Login
    Inherits System.Web.UI.Page

    Private _strPIN As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        ' Browser Support Check
        Functions.CheckForIE()

        'If IsNumeric(lblKey.Text) Then
        '    _strPIN = Trim(lblKey.Text)
        'End If
        'Randomize()
        'lblKey.Text = Format(Int((9999 * Rnd()) + 0), "0000")

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


        
    End Sub
    'Private Function PageIPAuthentication() As Boolean
    '    Dim strIPs As String = CStr(ConfigurationManager.AppSettings("PortalAllowedIPs"))
    '    Dim strIPArray As String() = strIPs.Split(",")
    '    For i As Integer = 0 To strIPArray.Length - 1
    '        If strIPArray(i).Trim() = HttpContext.Current.Request.UserHostAddress.ToString().Trim() Then
    '            Return True
    '        End If
    '    Next
    '    Return False
    'End Function

    Protected Sub cmdSignIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSignIn.Click
        validateUser(Trim(txtUserName.Text), Trim(txtPassword.Text))
    End Sub

    Sub validateUser(ByVal UserName As String, ByVal Password As String)
        Dim objUser As New Users()
        Dim valStatus As Users.ValidationStatus

        tblConflict.Visible = False
        tblForm.Style.Remove("display")

        'Password = Functions.EncryptData(Password)

        valStatus = objUser.ValidateUserForFransupport(UserName, Password)
        Select Case valStatus
            Case Portal.BLL.Users.ValidationStatus.UserNotFound
                spnError.InnerText = "Invalid Username Or Password!"
                trErrorMessage.Visible = True
            Case Portal.BLL.Users.ValidationStatus.NoClientAccess
                spnError.InnerText = "No Access Rights!"  ' OR No Client module Assinged 
                trErrorMessage.Visible = True
            Case Portal.BLL.Users.ValidationStatus.Validated
                DoLoginProcess()
        End Select
    End Sub

    Protected Sub DoLoginProcess()
        'If CheckIPORLaunchPad() = False Then
        '    Response.Redirect("~/AccessDenied.aspx")
        'End If
        HttpContext.Current.Session.Timeout() = 120
        HttpContext.Current.Response.Cookies("PortalPM").Expires = DateTime.Now.AddDays(-1)
        HttpContext.Current.Response.Cookies.Remove("PortalPM")
        Dim PortalPM As New HttpCookie("PortalPM")
        PortalPM.Values("UserType") = "FransupportUser"
        PortalPM.Expires = DateTime.Now.AddDays(1)
        HttpContext.Current.Response.Cookies.Add(PortalPM)

        InitializeLoginSession()
        AddLoginHistory()
        GetUserModules()
        GetUserSubModules()
        'If (CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ChangePasswordvar Or CBool(Session("Admin_ChangePassword")) = True) Then
        '    Response.Redirect("~/ChangePassword.aspx?Type=Password")
        'End If
        Response.Redirect("~/PM/LaunchPadMainPage.aspx", True)
    End Sub
    Protected Function CheckIPORLaunchPad() As Boolean
        'If PageIPAuthentication() = False Then
        If Request.QueryString("dt") <> String.Empty Then
            Dim tstr As String = Request.QueryString("dt")
            tstr = Functions.DecryptData(tstr)
            If IsDate(tstr) AndAlso CType(tstr, DateTime) > DateTime.Now.AddMinutes(-15) Then
                Return True
            Else
                Return False
            End If
        Else
            Return False
        End If
        'Else
        'Return True
        'End If
    End Function
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
