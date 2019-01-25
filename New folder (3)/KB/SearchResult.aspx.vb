
Partial Class KB_SearchResult
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (IsPostBack = False) Then
            If String.IsNullOrEmpty(Request.QueryString("Search")) = False Then
                hdnSearch.Value = Request.QueryString("Search").ToString().Trim()
            End If
            lblMsg.Text = "no results found for ""<span title='" & Server.HtmlEncode(hdnSearch.Value).Replace("'", "\'") & "'>" & Server.HtmlEncode(Functions.StringTruncate(hdnSearch.Value, 20)) & "</span>"""
        End If
    End Sub
    Protected Sub RepSearchResult_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RepSearchResult.ItemDataBound
        lblMsg.Text = RepSearchResult.Items.Count + 1 & " results found for  ""<span title='" & Server.HtmlEncode(hdnSearch.Value).Replace("'", "\'") & "' style='font-weight:bold'>" & Server.HtmlEncode(Functions.StringTruncate(hdnSearch.Value, 20)) & "</span>"" "
    End Sub
End Class
