
Partial Class HR_UsersTimeHistoryReport
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim colHR_Users As New Portal.BLL.Users
            colHR_Users = Portal.BLL.HR.HR_UserTimeHistory.HR_GetTimeZoneOffSetByUserID(Request.QueryString("UserID"))
            If colHR_Users.TimeZoneID <> Nothing Then
                hdnTeamID.Value = colHR_Users.TeamID
            End If
            'hdnTeamID.Value = colHR_Users.TeamID
            If Request.QueryString("UserID") <> String.Empty AndAlso IsNumeric(Request.QueryString("UserID")) Then
                hdnUserID.Value = CInt(Request.QueryString("UserID"))
                hdnStartDate.Value = CDate(Request.QueryString("SDate"))
                hdnEndDate.Value = CDate(Request.QueryString("EDate"))
                hdnNotes.Value = Request.QueryString("usernotes")
                lblFromDate.Text = CDate(Request.QueryString("SDate")).ToString("MMM dd, yyyy")
                lblToDate.Text = CDate(Request.QueryString("EDate")).ToString("MMM dd, yyyy")
                lblPrintDate.Text = DateTime.Now.ToShortDateString()
            End If
        End If
    End Sub
    
End Class
