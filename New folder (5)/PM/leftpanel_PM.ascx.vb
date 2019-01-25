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
            tr_Two.Attributes.Add("class", "Calendar_Selected")
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

        If (Portal.BLL.Users.CheckUserSubModulesAccess(Portal.BLL.Enumeration.SubModules.PMFullAccess) = False) Then
            tr_five.Style.Add("display", "none")
            tr_Seven.Style.Add("display", "none")
        End If


	'If CInt(HttpContext.Current.Session("AdminID")) = 3004 Or CInt(HttpContext.Current.Session("AdminID")) = 3165 Or CInt(HttpContext.Current.Session("AdminID")) = 3166 Or CInt(HttpContext.Current.Session("AdminID")) = 3574 Or CInt(HttpContext.Current.Session("AdminID")) = 224 Or CInt(HttpContext.Current.Session("AdminID")) = 98 Or CInt(HttpContext.Current.Session("AdminID")) = 3896 Or CInt(HttpContext.Current.Session("AdminID")) = 249 Then
        'tr_eight.Style.Add("display", "inline")
        'Else
        '    tr_eight.Style.Add("display", "none")
        'End If

    End Sub
End Class
