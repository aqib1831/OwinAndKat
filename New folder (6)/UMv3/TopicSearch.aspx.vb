Partial Class UMv3_TopicSearch
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            ' Dim ID As String = Functions.DecryptData(Request.QueryString("CategoryID"))
            Me.hdnSearchQuery.Value = Request.QueryString("query")
            Me.hdnType.Value = Request.QueryString("Type")
        End If
    End Sub
End Class