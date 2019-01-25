
Partial Class News_NewsDetail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not String.IsNullOrEmpty(Request.QueryString("NewsID")) AndAlso IsNumeric(Request.QueryString("NewsID")) Then
            hdnNewsID.Value = Request.QueryString("NewsID")
        End If
    End Sub
End Class
