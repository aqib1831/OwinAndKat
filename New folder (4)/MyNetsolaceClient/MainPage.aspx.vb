
Partial Class MyNetsolace_MainPage
    Inherits System.Web.UI.Page

    Protected intStoreCount As Integer = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        hdnClientId.Value = Session("MyNetsolace_ClientID")

        Me.Page.Title = "Netsolace Portal - My Netsolace"
        If Request.QueryString("Module") = "1" Or Request.QueryString("Module") = "" Then
            Me.Master.SelectedIcon = 1 'help desk
            Me.lftforhelpDesk.Visible = True
            Me.lftforLicence.Visible = False
            If (Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.NewPoint Or Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.TintWorld Or Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.SaladCreation Or Context.Session("MyNetsolace_ClientID") = 11 Or Context.Session("MyNetsolace_ClientID") = 12 ) And Request.QueryString("Module") = "" Then
                Me.lftforhelpDesk.Visible = False
                Me.lftforLicence.Visible = False
                Me.Master.SelectedIcon = 4 'Portal PM
                Response.Redirect("~/MyNetsolaceClient/PM/PMMain.aspx")
                Return
            End If
        End If
        If Request.QueryString("Module") = "1" Then
            iframeMain.Attributes.Add("src", "FranchisorInbox.aspx?ClientID=" & hdnClientId.Value)
        ElseIf Request.QueryString("Module") = "2" Then
            Me.Master.SelectedIcon = 2 'licence manageent
            Me.lftforhelpDesk.Visible = False
            Me.lftforLicence.Visible = True
            iframeMain.Attributes.Add("src", "../LM/LicenseManagement.aspx?PrevPage=MyNetsolace&ddlClient=" & Session("MyNetsolace_ClientID"))
        ElseIf Request.QueryString("Module") = "4" Then
            Me.lftforhelpDesk.Visible = False
            Me.lftforLicence.Visible = False
            Me.Master.SelectedIcon = 4 'Portal PM
            iframeMain.Attributes.Add("src", "/PMMain.aspx")
	Else
	    iframeMain.Attributes.Add("src", "FranchisorInbox.aspx?ClientID=" & hdnClientId.Value)
        End If
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        If txtSearch.Text <> String.Empty Or CInt(ddlStates.SelectedValue) > 0 Then
            divStores.Attributes.Add("Style", "display:inline;")
        Else
            divStores.Attributes.Add("Style", "display:none;")
        End If
    End Sub

    Protected Sub rptStores_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptStores.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            intStoreCount = 0
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            intStoreCount += 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If intStoreCount > 0 Then
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = False
            Else
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = True
            End If
        End If
    End Sub

    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlStates_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.SelectedIndexChanged
        If CInt(ddlStates.SelectedValue) > 0 Or txtSearch.Text <> String.Empty Then
            divStores.Attributes.Add("Style", "display:inline;")
        Else
            divStores.Attributes.Add("Style", "display:none;")
        End If
    End Sub

End Class
