
Partial Class News_NewsContent
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dt As Data.DataTable = Portal.BLL.News.News.NewsGetByUserID(CType(Session("AdminID"), Integer))
        If dt.Rows.Count > 0 Then
            div.InnerHtml = dt.Rows(0).Item("News")
        End If
    End Sub
End Class
