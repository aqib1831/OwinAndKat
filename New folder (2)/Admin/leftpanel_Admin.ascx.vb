'Imports LMS.BusinessLogicLayer
Imports System.Data.SqlClient
Imports System.Data

Partial Class contacts_leftpanel_Admin
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
    End Sub

    Protected Sub rptSearchUsers_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptSearchUsers.ItemDataBound
        If (rptSearchUsers.Items.Count = 0) Then
            ltrlNoRecord.Visible = True
        Else
            ltrlNoRecord.Visible = False
        End If
    End Sub
End Class
