
Partial Class Support_MainPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.BillingSupport
            If (Request.QueryString("From") <> Nothing AndAlso Request.QueryString("From").ToLower = "helpdesk") Then
                'ClientScript.RegisterStartupScript(Me.GetType, "SelectTab", "SetSelected(2);", True)
                iframeMain.Attributes.Add("src", "NsProducts.aspx?" & Request.QueryString.ToString())
            Else
                 ClientScript.RegisterStartupScript(Me.GetType(), "showcount", "showcount(" & Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetAllCountForSupport(Nothing, 0, -1, 0, 0, 0, 1) & ");", True)
            End If
        End If
    End Sub
End Class
