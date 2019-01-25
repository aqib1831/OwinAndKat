Imports LMS.BusinessLogicLayer


Partial Class contacts_leftpanel_PM
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
        ElseIf _Selected = 2 Then
            tr1.Attributes.Add("class", "Calendar_Selected")
        ElseIf _Selected = 3 Then
            tr_Three.Attributes.Add("class", "Calendar_Selected")
        ElseIf _Selected = 4 Then
            tr_four.Attributes.Add("class", "Calendar_Selected")
        ElseIf _Selected = 5 Then
            tr_five.Attributes.Add("class", "Calendar_Selected")
        ElseIf _Selected = 6 Then
            tr_six.Attributes.Add("class", "Calendar_Selected")
        ElseIf _Selected = 7 Then
            tr_Seven.Attributes.Add("class", "Calendar_Selected")
        End If
        'tr_One.Style.Add("display", "none")
        tr_Two.Style.Add("display", "none")
        tr_Seven.Style.Add("display", "none")
        'tr_six.Style.Add("display", "none")


        'If (Portal.BLL.Users.CheckUserSubModulesAccess(Portal.BLL.Enumeration.SubModules.PMFullAccess) = False) Then
        'tr_five.Style.Add("display", "none")        
        'End If

    End Sub
End Class
