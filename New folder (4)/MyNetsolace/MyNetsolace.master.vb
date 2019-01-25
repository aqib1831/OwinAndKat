
Partial Class MyNetsolace_MyNetsolace
    Inherits System.Web.UI.MasterPage
    Private _SelectedIcon As Integer
    Public Property SelectedIcon() As Integer
        Get
            Return _SelectedIcon
        End Get
        Set(ByVal value As Integer)
            _SelectedIcon = value
        End Set
    End Property
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Context.Session Is Nothing Or Context.Session.Count < 1 Then
            Response.Redirect("SessionExpired.htm")
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        topMyNetsolace.SelectedIcon = _SelectedIcon
    End Sub
End Class

