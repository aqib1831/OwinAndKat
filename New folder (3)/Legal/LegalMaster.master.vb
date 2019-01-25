
Partial Class Research_Research
    Inherits System.Web.UI.MasterPage
   
    Private _RenderWindowFunctions As Boolean = False

    Protected Sub Research_Research_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'If String.IsNullOrEmpty(Session("Admin_AdminID")) = True Then
        '    Response.Redirect("SessionExpire.htm")
        'End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
End Class

