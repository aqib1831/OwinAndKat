Imports System.Data
Partial Class SMSxOrderedFranchises
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Clear()
        Response.Buffer = True
        Response.AddHeader("content-disposition", "attachment; filename=Report_" & " " & Date.Now.Ticks() & ".xls")
        Response.ContentType = "application/vnd.ms-excel"

    End Sub



    Protected Sub rptPlArrange_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptPlArrange.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            CType(e.Item.FindControl("lblGeneratedon"), Label).Text = "Report Generated On: " + DateTime.Today.ToString("MMM dd, yyyy")
            CType(e.Item.FindControl("lblCompany"), Label).Text = "Edible Arrangements International, Inc."
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            CType(e.Item.FindControl("lbltotal"), Label).Text = "Total: " + rptPlArrange.Items.Count.ToString()
        End If
    End Sub


End Class
