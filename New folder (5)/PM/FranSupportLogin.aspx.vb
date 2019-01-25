Imports System.Collections.Generic
Partial Class PM_FranSupportLogin
    Inherits System.Web.UI.Page

    Dim colUsers As New List(Of Portal.BLL.Users)()
    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Not Page.IsPostBack Then
            If Request.QueryString("dt") <> String.Empty Then
                Dim dtstr As String = CStr(Request.QueryString("dt"))
                dtstr = Functions.DecryptData(dtstr)
                Dim dt As DateTime = CType(dtstr, DateTime)
                If dt < DateTime.Now.AddMinutes(10) AndAlso dt > DateTime.Now.AddMinutes(-10) Then
                    Dim FranSupportIDstr As String = Request.QueryString("UserID")
                    FranSupportIDstr = Functions.DecryptData(FranSupportIDstr)
                    If FranSupportIDstr <> String.Empty AndAlso IsNumeric(FranSupportIDstr) Then
                        Dim UserID As Integer = CInt(FranSupportIDstr)
                        LoadUser(UserID)
                    End If
                Else
                    ''Sorry Yo are not Allowed  to access this page 
                    ''Session has Expired
                    ''Responce .Redirect to Frans Support Login Page
                End If
            End If
        End If
    End Sub
    Private Sub LoadUser(ByVal FranSupportID As Integer)
        Dim objUser As Portal.BLL.Users = New Portal.BLL.Users()
        colUsers = Portal.BLL.Users.GetFransupportUsersByID(FranSupportID)
        If colUsers.Count > 0 Then
            objUser.ID = colUsers.Item(0).ID
            objUser.Name = colUsers.Item(0).Firstname & " " & colUsers.Item(0).Lastname
            objUser.JobTitle = colUsers.Item(0).JobTitle
            objUser.Email = colUsers.Item(0).Email
            objUser.DepartmentID = colUsers.Item(0).DepartmentID
            objUser.UserName = colUsers.Item(0).UserName
            objUser.FranSupportID = colUsers.Item(0).FranSupportID
            objUser.FrutationID = colUsers.Item(0).FrutationID
            objUser.RemoteUser = colUsers.Item(0).RemoteUser
            objUser.Type = colUsers.Item(0).Type
            objUser.IP = colUsers.Item(0).IP


            Dim objContext As HttpContext = HttpContext.Current
            objContext.Session.Add("AdminCurrentobjUser", objUser) ' In session, we keep the logged-in User's ID with another key
            ' because it is frequently used and we are saved from creating object                        
            objContext.Session.Add("AdminID", objUser.ID)
            objContext.Session.Add("AdminName", objUser.Name)
            objContext.Session.Add("Email", objUser.Email)
            objContext.Session.Add("RemoteUser", objUser.RemoteUser)
            objContext.Session.Add("IstVisit", False) 'Check if User has logged from this Fransupport Page 
            objContext.Session.Add("Type", objUser.Type)
            InitializeLoginSession()
            Response.Redirect("~/PM/PMMain.aspx", True)
        Else
            ''Sorry Yo are not Allowed  to access this page 
            ''Session has Expired
            ''Responce .Redirect to Frans Support Login Page
            Response.Redirect("~/PM/AccessDenied.htm", True)
        End If
    End Sub
    Protected Sub InitializeLoginSession()
        'Dim AdminID As Integer = CType(Session("AdminID"), Integer)
        'Dim UserSessionID As Integer = 0
        'UserSessionID = LMS.BusinessLogicLayer.User.UpDateLastAccessTimeAndLoginStatus(AdminID, True, HttpContext.Current.Request.UserHostAddress, Nothing)
        'Portal.BLL.Users.LogUsersInApplication(AdminID, UserSessionID)
        Session.Add("Admin_SessionID", CType(Session("AdminID"), Integer)) 'UserSessionID
        GetUserSubModules()
    End Sub
    Protected Sub GetUserSubModules()
        Dim AdminID As Integer = CType(Session("AdminID"), Integer)
        Dim CSVSubModules As String = Portal.BLL.Modules.SubModulesGetByUserID(AdminID)
        HttpContext.Current.Session.Add("UsersSubModulesID", CSVSubModules)
    End Sub
End Class
