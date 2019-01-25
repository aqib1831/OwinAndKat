Imports System.Data
Partial Class SMSxOrderedFranchises
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub rptPlArrange_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptPlArrange.ItemCommand

    End Sub

    Protected Sub rptPlArrange_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptPlArrange.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            CType(e.Item.FindControl("lblGeneratedon"), Label).Text = "Report Generated On: " + DateTime.Today.ToString("MMM dd, yyyy")
            CType(e.Item.FindControl("companyName"), Label).Text = "Edible Arrangements International, Inc."
            If Not Request.QueryString("IsExcel") = Nothing AndAlso Request.QueryString("IsExcel") = "1" Then
                CType(e.Item.FindControl("btnPrint"), ImageButton).Attributes.Add("style", "display:none")
                CType(e.Item.FindControl("btnExcel"), ImageButton).Attributes.Add("style", "display:none")
                'Response.Clear()
                'Response.Buffer = True
                'Response.AddHeader("content-disposition", "attachment; filename=Report" & " " & Date.Today.Month & "-" & Date.Today.Day & "-" & Date.Today.Year & ".xls")
                'Response.ContentType = "application/vnd.ms-excel"
                'Response.End()
            End If
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            CType(e.Item.FindControl("lbltotal"), Label).Text = "Total: " + rptPlArrange.Items.Count.ToString()
        End If
    End Sub

    Protected Sub form1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.PreRender
        If Not Request.QueryString("IsExcel") = Nothing AndAlso Request.QueryString("IsExcel") = "1" Then


        End If
    End Sub
End Class
