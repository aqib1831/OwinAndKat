
Partial Class UMv3_TopicsList
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            ' Dim ID As String = Functions.DecryptData(Request.QueryString("CategoryID"))
            Me.hdnCategoryID.Value = Request.QueryString("CategoryID")
        End If
    End Sub
End Class
