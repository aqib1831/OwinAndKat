
Partial Class contacts_leftpanel_Orders
    Inherits System.Web.UI.UserControl
#Region " Private Members "

    Private _Selected As Integer = 0

#End Region

#Region " Public Properties "

    Public Property Selected() As Integer
        Get
            Return _Selected
        End Get
        Set(ByVal value As Integer)
            _Selected = value
        End Set
    End Property
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If _Selected = 1 Then
            tr_One.Attributes.Add("class", "Calendar_Selected")
        End If

    End Sub
End Class
