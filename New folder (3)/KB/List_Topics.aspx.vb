
Partial Class KB_List_Topics
    Inherits System.Web.UI.Page

    Protected Sub GdChapterDetail_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GdChapterDetail.DataBound
        lblRecCount.Text = GdChapterDetail.Rows.Count
    End Sub

    Protected Sub GdChapterDetail_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GdChapterDetail.RowDataBound
        If e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells.RemoveAt(6)
            e.Row.Cells(5).ColumnSpan = 2
            e.Row.Cells(5).Text = "Actions"
            e.Row.Cells(5).HorizontalAlign = HorizontalAlign.Center
        End If
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "javascript:window.location='Topic_Detail.aspx?TopicID=" & e.Row.DataItem("ID") & "';")
            e.Row.Attributes.Add("title", "Click to View Topic Detail")
            e.Row.Cells(6).Attributes.Add("onclick", "event.cancelBubble=true;javascript:return confirm('Are you sure you want to delete?')")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            e.Row.Cells(6).Attributes.Add("title", "Click here to Delete Topic")
            e.Row.Cells(5).Attributes.Add("title", "Click here to Edit Topic")
            e.Row.Cells(1).Attributes.Add("title", e.Row.DataItem("Name"))
            e.Row.Cells(2).Attributes.Add("title", e.Row.DataItem("CategoryName"))
        End If
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        ddlCategories.Items.Insert(0, New ListItem("Show All...", 0))
    End Sub

    Protected Sub lnkAddTopic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddTopic.Click
        Response.Redirect("Add_Topic.aspx?CategoryID=" & Request.QueryString("CategoryID"))
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (IsPostBack = False) Then
            If String.IsNullOrEmpty(Request.QueryString("CategoryID")) = False AndAlso IsNumeric(Request.QueryString("CategoryID")) = True Then
                hdnCategoryID.Value = Request.QueryString("CategoryID")
                ddlCategories.SelectedValue = Request.QueryString("CategoryID")
            End If
        End If
    End Sub
    Protected Sub sdTopics_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles sdTopics.Selected
        If txtSearch.Text <> "" Or ddlCategories.SelectedValue > 0 Then
            lblFilter.Text = "filtered"
        Else
            lblFilter.Text = "all"
        End If
    End Sub

    Protected Sub ddlCategories_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.SelectedIndexChanged
        Dim objcategory As New Category
        If (ddlCategories.SelectedValue <= 0) Then
            lblCategoryName.Text = "All Topics"
        ElseIf objcategory.LoadCategoryDetail(ddlCategories.SelectedValue) Then
            lblCategoryName.Text = Functions.StringTruncate(Server.HtmlEncode(objcategory.Name), 50)
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If (IsPostBack = False) Then
            Dim objcategory As New Category
            If (ddlCategories.SelectedValue <= 0) Then
                lblCategoryName.Text = "All Topics"
            ElseIf objcategory.LoadCategoryDetail(hdnCategoryID.Value) Then
                lblCategoryName.Text = Functions.StringTruncate(Server.HtmlEncode(objcategory.Name), 50)
            End If
        End If
    End Sub
End Class
