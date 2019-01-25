
Partial Class LM_LicenseDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("ID") <> Nothing And IsNumeric(Request.QueryString("ID"))) Then
            If Not IsPostBack Then
                btnEdit.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/LM/SMSEditLicenseDetail.aspx?ID=" & Request.QueryString("ID")) & "'; return false; ")
                LoadProducts_FranchisesForSMS()
                LoadProducts_TechnicalInfoForSMS()
            End If
        End If
    End Sub
    Private Sub LoadProducts_FranchisesForSMS()
        Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
        objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetByID(CInt(Request.QueryString("ID")))

        ltrlStoreNo.Text = objNS_Products_Franchises.StoreNumber
        ltrlStoreNick.Text = objNS_Products_Franchises.StoreNick
        ltrlClientName.Text = objNS_Products_Franchises.ClientCode
        ltrlCurrentVersion.Text = objNS_Products_Franchises.Version
        ltrlNotes.Text = objNS_Products_Franchises.Notes.Replace(vbCrLf, "<br />")
        ltrlNoLicenses.Text = objNS_Products_Franchises.NoOfLicenses
        ltrlLiveTerminals.Text = objNS_Products_Franchises.NoOfLiveTerminals
        ltrlServerName.Text = objNS_Products_Franchises.ServerUserName
        ltrlServerPassword.Text = objNS_Products_Franchises.ServerPassword

        If (String.IsNullOrEmpty(objNS_Products_Franchises.UpdatedByName.Trim()) = True) Then
            ltrlUpdatedBy.Text = "- - -"
        Else
            ltrlUpdatedBy.Text = objNS_Products_Franchises.UpdatedByName
        End If
        If (objNS_Products_Franchises.IsStaticIP = True) Then
            spnserverip.Style.Add("Display", "Inline")
            ltrlServerIP.Text = objNS_Products_Franchises.IP
            ltrlIsStaticIP.Text = "Yes"
        Else
            ltrlServerIP.Text = ""
            ltrlIsStaticIP.Text = "No"
            spnserverip.Style.Add("Display", "None")
        End If
        If (objNS_Products_Franchises.onSupport) Then
            ltrlOnSupport.Text = "Yes"
        Else
            ltrlOnSupport.Text = "No"
        End If
        
        If (objNS_Products_Franchises.Inactive = True) Then
            ltrlActive.Text = "Inactive"
            divltrlActive.Attributes.Add("class", "darkRedColor")
        Else
            ltrlActive.Text = "Active"
            divltrlActive.Attributes.Add("class", "darkGreenColor")
        End If
        If (String.IsNullOrEmpty(objNS_Products_Franchises.LastUpdateDate) = True) Then
            ltrlLastTimeSync.Text = "- - -"
        Else
            ltrlLastTimeSync.Text = Functions.DateDiffInWords(objNS_Products_Franchises.LastUpdateDate)
            ltrlLastTimeSync.ToolTip = objNS_Products_Franchises.LastUpdateDate
        End If

        If (objNS_Products_Franchises.UpdatedOn = "#1/1/1900#") Then
            ltrlUpdateOn.Text = "- - -"
        Else
            ltrlUpdateOn.Text = Functions.DateDiffInWordsLong(objNS_Products_Franchises.UpdatedOn)
            ltrlUpdateOn.ToolTip = objNS_Products_Franchises.UpdatedOn
        End If

    End Sub
    Private Sub LoadProducts_TechnicalInfoForSMS()
        Dim colNS_Products_TechnicalInfo As New System.Collections.Generic.List(Of Portal.BLL.NS.NS_Products_TechnicalInfo)()
        colNS_Products_TechnicalInfo = Portal.BLL.NS.NS_Products_TechnicalInfo.NS_Products_TechnicalInfoGetByProductFranchiseID(CInt(Request.QueryString("ID")))
        If (colNS_Products_TechnicalInfo.Count > 0) Then
            ltrlISPType.Text = colNS_Products_TechnicalInfo.Item(0).ISPType
            ltrlPrimaryDNS.Text = colNS_Products_TechnicalInfo.Item(0).PrimaryDNS
            ltrlSecondaryDNS.Text = colNS_Products_TechnicalInfo.Item(0).SecondaryDNS
            ltrlFirewallRouter.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouter
            ltrlISPPassword.Text = colNS_Products_TechnicalInfo.Item(0).ISPPassword
            ltrlFirewallRouterLogin.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouterLogin
            ltrlISPUserName.Text = colNS_Products_TechnicalInfo.Item(0).ISPUserName
            ltrlFirewallRouterAccess.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouterAccess
        End If
    End Sub

End Class
