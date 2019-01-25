
Partial Class PM_main_pm
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Not Page.IsPostBack Then
        Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.Communication
        If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False Then
            ComLeftPanel.FranchiseID = Request.QueryString("FranchiseID").ToString()
        End If
        'If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False Then
        '    ComLeftPanel.PortalClientID = Request.QueryString("ClientID").ToString()
        'End If
        If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False Then

            If String.IsNullOrEmpty(Request.QueryString("ID")) = False Then
                Iframe.Attributes.Add("src", "ActivityDetail.aspx?FranchiseID=" & Request.QueryString("FranchiseID").ToString() & "&ID=" & Request.QueryString("ID").ToString() & "&PrevPage=" & Request.QueryString("PrevPage").ToString() & "&ClientID=" & Request.QueryString("ClientID").ToString())
                ComLeftPanel.FranchiseID = "0"
            Else
                ComLeftPanel.FranchiseID = Request.QueryString("FranchiseID").ToString()
                Iframe.Attributes.Add("src", "Franchise_Inbox.aspx?FranchiseID=" & Request.QueryString("FranchiseID").ToString() & "&ClientID=" & Request.QueryString("ClientID").ToString())
            End If
        Else
            ComLeftPanel.FranchiseID = "0"
            If String.IsNullOrEmpty(Request.QueryString("ID")) = False Then
                Iframe.Attributes.Add("src", "ActivityDetail.aspx?FranchiseID=" & Request.QueryString("FranchiseID").ToString() & "&ID=" & Request.QueryString("ID").ToString() & "&PrevPage=" & Request.QueryString("PrevPage").ToString() & "&ClientID=" & Request.QueryString("ClientID").ToString())
            Else
                Iframe.Attributes.Add("src", "Admin_Inbox.aspx")
            End If
        End If
        'End If
    End Sub


End Class
