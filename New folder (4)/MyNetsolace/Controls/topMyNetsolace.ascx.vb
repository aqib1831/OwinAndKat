
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
        Portal.BLL.Client.Client_Contacts.RemoveSessionOfMyNetsolace()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        IconHome.Attributes("onmouseover") = "this.className='TopBarHover';"
        IconHome.Attributes("onmouseout") = "this.className='TopBarSimple';"
        IconLicenceClass.Attributes("onmouseover") = "this.className='TopBarHover';"
        IconLicenceClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
        IconBillingClass.Attributes("onmouseover") = "this.className='TopBarHover';"
        IconBillingClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
        IconPMClass.Attributes("onmouseover") = "this.className='TopBarHover';"
        IconPMClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
        IconCCClass.Attributes("onmouseover") = "this.className='TopBarHover';"
        IconCCClass.Attributes("onmouseout") = "this.className='TopBarSimple';"
        IconNSBSClass.Attributes("onmouseover") = "this.className='TopBarHover';"
        IconNSBSClass.Attributes("onmouseout") = "this.className='TopBarSimple';"

        If _SelectedIcon = 1 Then
            IconHome.Attributes("class") = "TopBarHover"
            IconHome.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconHome.Attributes("onmouseout") = "this.className='TopBarHover';"

        ElseIf _SelectedIcon = 2 Then
            IconLicenceClass.Attributes("class") = "TopBarHover"
            IconLicenceClass.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconLicenceClass.Attributes("onmouseout") = "this.className='TopBarHover';"
            

        ElseIf _SelectedIcon = 3 Then
            IconBillingClass.Attributes("class") = "TopBarHover"
            IconBillingClass.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconBillingClass.Attributes("onmouseout") = "this.className='TopBarHover';"

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
        End If

        Dim str As String = ""
        For i As Integer = 0 To Request.QueryString.Count - 1
            If (Request.QueryString.GetKey(i) <> "Module") Then
                str += Request.QueryString.GetKey(i)
                str += "="
                str += Request.QueryString(i).ToString
                str += "&"
            End If
        Next
        If (str.Length > 0) Then
            str = str.Remove(str.Length - 1, 1)
        Else
            str = str
        End If
        IconHome.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolace/MainPage.aspx?" & str & "&Module=1") & "';")
        IconLicence.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolace/MainPage.aspx?" & str & "&Module=2") & "';")
        IconBilling.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolace/MainPage.aspx?" & str & "&Module=3") & "';")
        IconPM.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolace/PM/PMMain.aspx") & "';")
        IconCC.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolace/ClientContact/ClientContactMainPage.aspx") & "';")
        IconNSBS.Attributes.Add("onclick", "window.location='" & ResolveClientUrl("~/MyNetsolace/NSBS/MainPage.aspx?" & str & "&Module=6") & "';")
        If Not IsPostBack Then
            If Not Context.Session Is Nothing And Context.Session.Count > 0 Then
                If Session("MyNetsolace_ClientContactName") <> "" Then
                    lblUserName.Text = Session("MyNetsolace_ClientContactName")
                Else
                    lblUserName.Text = CType(Context.Session("AdminCurrentobjUser"), Portal.BLL.Users).UserName.ToString()
                End If
            End If
        End If
        IconLicence.Style.Add("display", "None")
        IconLicenceWidth.Style.Add("display", "None")
        IconPM.Style.Add("display", "None")
        IconPMWidth.Style.Add("display", "None")
        IconBilling.Style.Add("display", "None")
        IconBillingWidth.Style.Add("display", "None")
        IconCC.Style.Add("display", "None")
        IconCCWidth.Style.Add("display", "None")
        IconNSBS.Style.Add("display", "none")
        IconNSBSWidth.Style.Add("display", "none")
	spanPassword.Visible = False
        If Context.Session("MyNetsolace_ClientContactID") <> Nothing AndAlso Context.Session("MyNetsolace_ClientContactID") > 0 Then
			If Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.NewPoint OR Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.TintWorld OR Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.SaladCreation OR Context.Session("MyNetsolace_ClientID") = 11  Then
				IconHome.Style.Add("display", "None")
                IconHomeClass.Style.Add("display", "None")
                IconPM.Style.Add("display", "inline")
                IconPMWidth.Style.Add("display", "inline")
				IconCC.Style.Add("display", "None")
                IconCCWidth.Style.Add("display", "None")
		spanPassword.Visible = True
            Else
				IconPM.Style.Add("display", "inline")
				IconPMWidth.Style.Add("display", "inline")
				IconCC.Style.Add("display", "None")
				IconCCWidth.Style.Add("display", "None")
				If Context.Session("MyNetsolace_ClientContactIsAdmin") <> Nothing AndAlso Context.Session("MyNetsolace_ClientContactIsAdmin") = True Then
					IconLicence.Style.Add("display", "inline")
					IconLicenceWidth.Style.Add("display", "inline")
				End If
			End If	
        End If

        If Context.Session("FranchiseID") <> Nothing And Context.Session("FranchiseID") <> 0 Then
            'IconBilling.Style.Add("display", "inline")
            'IconBillingWidth.Style.Add("display", "inline")
			'If Session("FranchiseID") = 2 Then ' For 904 only
				If Portal.BLL.NS.NS_Products_Franchises.NS_Products_Franchises_IsExist(Portal.BLL.Enumeration.NSProductIDs.BackUp, Session("FranchiseID")) Then
					IconNSBS.Style.Add("display", "inline")
					IconNSBSWidth.Style.Add("display", "inline")
				End If
			'End If
        End If
		
    End Sub
End Class
