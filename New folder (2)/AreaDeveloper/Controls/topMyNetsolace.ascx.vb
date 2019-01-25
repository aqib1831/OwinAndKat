Partial Class MyNetsolace_Controls_topMyNetsolace
    Inherits System.Web.UI.UserControl
    Private _SelectedIcon As Integer
    Public Property SelectedIcon() As Integer
        Get
            Return _SelectedIcon
        End Get
        Set(ByVal value As Integer)
            _SelectedIcon = value
        End Set
    End Property

    Protected Sub lnkSingout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkSingout.Click
        'ViewStateHelper.DeleteByClientContactId(Session("MyNetsolace_ClientContactID"))
        Portal.BLL.Client.Client_Contacts.RemoveSessionOfMyNetsolaceMaster()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            IconPMClass.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconPMClass.Attributes("onmouseout") = "this.className='TopBarSimple';"

            If _SelectedIcon = 4 Then
                IconPMClass.Attributes("class") = "TopBarHover"
                IconPMClass.Attributes("onmouseover") = "this.className='TopBarHover';"
                IconPMClass.Attributes("onmouseout") = "this.className='TopBarHover';"
            End If

            IconPM.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/AreaDeveloper/PM/PMMain.aspx") & "';")

            If Session("MyNetsolace_ClientContactName") <> "" Then
                lblUserName.Text = Session("MyNetsolace_ClientContactName")
            End If

            IconPM.Style.Add("display", "none")
            IconPMWidth.Style.Add("display", "none")
            spanPassword.Visible = False
            If Context.Session("MyNetsolace_ClientContactID") <> Nothing AndAlso Context.Session("MyNetsolace_ClientContactID") > 0 Then
                IconPM.Style.Add("display", "")
                IconPMWidth.Style.Add("display", "")
            End If

        End If
    End Sub
End Class