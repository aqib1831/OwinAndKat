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
        Portal.BLL.Client.Client_Contacts.RemoveSessionOfMyNetsolaceClient()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            IconHome.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconHome.Attributes("onmouseout") = "this.className='TopBarSimple';"
            IconLicenceClass.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconLicenceClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
            IconPMClass.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconPMClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
            IconCCClass.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconCCClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
            IconNSBSClass.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconNSBSClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
            IconURLMClass.Attributes("onmouseout") = "this.className='TopBarSimple';"

            If _SelectedIcon = 1 Then
                IconHome.Attributes("class") = "TopBarHover"
                IconHome.Attributes("onmouseover") = "this.className='TopBarHover';"
                IconHome.Attributes("onmouseout") = "this.className='TopBarHover';"

            ElseIf _SelectedIcon = 2 Then
                IconLicenceClass.Attributes("class") = "TopBarHover"
                IconLicenceClass.Attributes("onmouseover") = "this.className='TopBarHover';"
                IconLicenceClass.Attributes("onmouseout") = "this.className='TopBarHover';"

            ElseIf _SelectedIcon = 4 Then
                IconPMClass.Attributes("class") = "TopBarHover"
                IconPMClass.Attributes("onmouseover") = "this.className='TopBarHover';"
                IconPMClass.Attributes("onmouseout") = "this.className='TopBarHover';"

            ElseIf _SelectedIcon = 5 Then
                IconCCClass.Attributes("class") = "TopBarHover"
                IconCCClass.Attributes("onmouseover") = "this.className='TopBarHover';"
                IconCCClass.Attributes("onmouseout") = "this.className='TopBarHover';"
            ElseIf _SelectedIcon = 6 Then
                IconNSBSClass.Attributes("class") = "TopBarHover"
                IconNSBSClass.Attributes("onmouseover") = "this.className='TopBarHover';"
                IconNSBSClass.Attributes("onmouseout") = "this.className='TopBarHover';"
            ElseIf _SelectedIcon = 8 Then
                IconURLMClass.Attributes("class") = "TopBarHover"
                IconURLMClass.Attributes("onmouseover") = "this.className='TopBarHover';"
                IconURLMClass.Attributes("onmouseout") = "this.className='TopBarHover';"
            End If


            IconHome.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/MainPage.aspx?Module=1") & "';")
            IconLicence.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/MainPage.aspx?Module=2") & "';")
            IconPM.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/PM/PMMain.aspx") & "';")
            IconCC.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/ClientContact/ClientContactMainPage.aspx") & "';")
            IconNSBS.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/NSBS/MainPage.aspx?Module=6") & "';")
            IconURLM.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/URLM/urlmmain.aspx") & "';")
            If Session("MyNetsolace_ClientContactName") <> "" Then
                lblUserName.Text = Session("MyNetsolace_ClientContactName")
            End If

            IconLicence.Style.Add("display", "None")
            IconLicenceWidth.Style.Add("display", "None")
            IconPM.Style.Add("display", "None")
            IconPMWidth.Style.Add("display", "None")
            IconCC.Style.Add("display", "None")
            IconCCWidth.Style.Add("display", "None")
            IconNSBS.Style.Add("display", "none")
            IconNSBSWidth.Style.Add("display", "none")
            IconURLMWidth.Style.Add("display", "none")
            spanPassword.Visible = False
            If Context.Session("MyNetsolace_ClientContactID") <> Nothing AndAlso Context.Session("MyNetsolace_ClientContactID") > 0 Then
                If Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.NewPoint Or Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.SaladCreation Or Context.Session("MyNetsolace_ClientID") = 11 Or Context.Session("MyNetsolace_ClientID") = 12 Then
                    IconHome.Style.Add("display", "None")
                    IconHomeClass.Style.Add("display", "None")
                    IconPM.Style.Add("display", "inline")
                    IconPMWidth.Style.Add("display", "inline")
                    IconCC.Style.Add("display", "None")
                    IconCCWidth.Style.Add("display", "None")
                    spanPassword.Visible = True
                ElseIf Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.TintWorld Then
		    IconHome.Style.Add("display", "inline")
                    IconHomeClass.Style.Add("display", "inline")
                    IconPM.Style.Add("display", "inline")
                    IconPMWidth.Style.Add("display", "inline")
                    IconCC.Style.Add("display", "None")
                    IconCCWidth.Style.Add("display", "None")
                    spanPassword.Visible = True					
		ElseIf Context.Session("MyNetsolace_ClientID") = 13 OR Context.Session("MyNetsolace_ClientID") = 14 OR Context.Session("MyNetsolace_ClientID") = 15 Then
		    IconPM.Style.Add("display", "none")
                    IconPMWidth.Style.Add("display", "none")
                Else
                    IconPM.Style.Add("display", "inline")
                    IconPMWidth.Style.Add("display", "inline")
                    If Context.Session("MyNetsolace_ClientContactIsAdmin") <> Nothing AndAlso Context.Session("MyNetsolace_ClientContactIsAdmin") = True Then
                        IconLicence.Style.Add("display", "inline")
                        IconLicenceWidth.Style.Add("display", "inline")
                        IconCC.Style.Add("display", "none")
                        IconCCWidth.Style.Add("display", "none")
                    End If
                End If
            End If
            If Convert.ToBoolean(Context.Session("MyNetsolace_HasURLMAccess")) = True Then
                IconURLM.Style.Add("display", "inline")
            Else
                IconURLM.Style.Add("display", "none")
            End If

            If Context.Session("FranchiseID") <> Nothing And Context.Session("FranchiseID") <> 0 Then
                If Portal.BLL.NS.NS_Products_Franchises.NS_Products_Franchises_IsExist(Portal.BLL.Enumeration.NSProductIDs.BackUp, Session("FranchiseID")) Then
                    IconNSBS.Style.Add("display", "inline")
                    IconNSBSWidth.Style.Add("display", "inline")
                End If
                'End If
            End If
        End If
    End Sub
End Class