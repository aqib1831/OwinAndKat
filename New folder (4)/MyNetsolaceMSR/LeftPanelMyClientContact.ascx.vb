Imports System.Data.SqlClient
Imports System.Data
Partial Class MyNetsolace_LeftPanelMyClientContact
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

    Protected Sub rptSearchUsers_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptSearchUsers.ItemDataBound
        If Not IsPostBack = True Then
            If (rptSearchUsers.Items.Count = 0) Then
                ltrlNoRecord.Visible = True
                rptSearchUsers.Visible = False
            Else
                ltrlNoRecord.Visible = False
                rptSearchUsers.Visible = True
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack = True Then

        End If
    End Sub
End Class
