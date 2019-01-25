Imports System.Collections.Generic
Partial Class PM_TicketsReport
    Inherits System.Web.UI.Page
    Dim colTickets As New List(Of Portal.BLL.PM.PM_Ticket_Features)()
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            tdTitleReport.InnerText = "From Date " & CDate(Request.QueryString("DateFrom")).ToString("MM/dd/yyyy") & "                     To Date " & CDate(Request.QueryString("DateTo")).ToString("MM/dd/yyyy")
            lblPrintDate.Text = "Printed Online On " & System.DateTime.Now.ToString("MM/dd/yyyy")
        End If
    End Sub

End Class
