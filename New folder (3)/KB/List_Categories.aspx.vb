
Partial Class KB_List_Categories
    Inherits System.Web.UI.Page
#Region "Page Events"
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
#End Region

#Region "Event Handler"

    Protected Sub lnkAddTopic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddTopic.Click
        Response.Redirect("Add_Category.aspx")
    End Sub

    Protected Sub GdChapterDetail_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GdChapterDetail.DataBound
        lblRecCount.Text = GdChapterDetail.Rows.Count
    End Sub

    Protected Sub GdChapterDetail_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GdChapterDetail.RowCommand
        If (e.CommandName.ToLower() = "delete") Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ChangeIframe", "parent.RefreshMain();", True)
        End If
    End Sub

    Protected Sub GdChapterDetail_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GdChapterDetail.RowDataBound
        If e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells.RemoveAt(4)
            e.Row.Cells(3).ColumnSpan = 2
            e.Row.Cells(3).Text = "Actions"
            e.Row.Cells(3).HorizontalAlign = HorizontalAlign.Center
        End If
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("title", "Click to View Topics")
            e.Row.Attributes.Add("onclick", "javascript:window.location='List_Topics.aspx?CategoryID=" & e.Row.DataItem("ID") & "';")
            e.Row.Cells(4).Attributes.Add("onclick", "event.cancelBubble=true;javascript:return confirm('Are you sure you want to delete?')")
            e.Row.Cells(4).Attributes.Add("title", "Click here to Delete Category")
            e.Row.Cells(3).Attributes.Add("title", "Click here to Edit Category")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            'e.Row.Cells(1).Attributes.Add("title", e.Row.DataItem("Name"))
        End If
    End Sub

    Protected Sub sdCategories_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles sdCategories.Selected
        If txtSearch.Text <> "" Then
            lblFilter.Text = "filtered"
        Else
            lblFilter.Text = "all"
        End If
    End Sub

#End Region

End Class
