
Partial Class LM_SMSLicenseDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("ID") <> Nothing And IsNumeric(Request.QueryString("ID"))) Then
            If Not IsPostBack Then
                btnBack.PostBackUrl = "SMSLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStores=" & Request.QueryString("ddlStores") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                btnEdit.PostBackUrl = "SMSEditLicenseDetail.aspx?ID=" & Request.QueryString("ID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStores=" & Request.QueryString("ddlStores") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                LoadProducts_FranchisesForSMS()
                LoadProducts_TechnicalInfoForSMS()
            End If
        End If
    End Sub
    Private Sub LoadProducts_FranchisesForSMS()
        Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
        objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetByID(CInt(Request.QueryString("ID")))

        ltrlStoreNo.Text = objNS_Products_Franchises.StoreNick & " - " & objNS_Products_Franchises.StoreNumber & " (" & objNS_Products_Franchises.ClientCode & ")"
        'ltrlStoreNick.Text = 
        'ltrlClientName.Text = objNS_Products_Franchises.ClientCode
        ltrlCurrentVersion.Text = objNS_Products_Franchises.Version
        txtNotes.Text = objNS_Products_Franchises.Notes
        ltrlLiveTerminals.Text = objNS_Products_Franchises.NoOfLiveTerminals
        txtServerName.Text = objNS_Products_Franchises.ServerUserName
        txtServerPassword.Text = objNS_Products_Franchises.ServerPassword
        ddlCCPaymentGateway.Text = IIf(objNS_Products_Franchises.CCPaymentGateway = "1", "MPS", IIf(objNS_Products_Franchises.CCPaymentGateway = "2", "FD", ""))
        'txtCCLogin.Text = objNS_Products_Franchises.CCMerchantID
        'txtCCPassword.Text = objNS_Products_Franchises.CCMerchantPassword



        txtNoLicenses.Text = objNS_Products_Franchises.NoOfLicenses

        If (String.IsNullOrEmpty(objNS_Products_Franchises.UpdatedByName.Trim()) = True) Then
            ltrlUpdatedBy.Text = "- - -"
        Else
            ltrlUpdatedBy.Text = objNS_Products_Franchises.UpdatedByName
        End If

        txtServerIP.Text = objNS_Products_Franchises.IP
        chkStaticIP.Text = IIf(objNS_Products_Franchises.IsStaticIP, "Yes", "No")


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
            txtISPType.Text = colNS_Products_TechnicalInfo.Item(0).ISPType
            txtPrimaryDNS.Text = colNS_Products_TechnicalInfo.Item(0).PrimaryDNS
            txtSecondaryDNS.Text = colNS_Products_TechnicalInfo.Item(0).SecondaryDNS
            txtFirewallRouter.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouter
            txtISPPassword.Text = colNS_Products_TechnicalInfo.Item(0).ISPPassword
            txtFirewallRouterLogin.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouterLogin
            txtISPUserName.Text = colNS_Products_TechnicalInfo.Item(0).ISPUserName
            txtFirewallRouterAccess.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouterAccess

            txtDeliveryCharge.Text = colNS_Products_TechnicalInfo.Item(0).DeliveryCharge
            txtDeliveryChargeVAT.Text = colNS_Products_TechnicalInfo.Item(0).DeliveryChargeVAT
            txtMerchantNo.Text = colNS_Products_TechnicalInfo.Item(0).MerchantNo
            txtAuthLogin.Text = colNS_Products_TechnicalInfo.Item(0).AuthLogin
            txtCCLogin.Text = colNS_Products_TechnicalInfo.Item(0).CCLogin
            txtCCPassword.Text = colNS_Products_TechnicalInfo.Item(0).CCPassword
            chkTagPrinting.Text = IIf(colNS_Products_TechnicalInfo.Item(0).TagPrinting, "Yes", "No")
            chkHouseCharge.Text = IIf(colNS_Products_TechnicalInfo.Item(0).HouseCharge, "Yes", "No")
            txtHouseChargeAmount.Text = colNS_Products_TechnicalInfo.Item(0).HouseChargeAmount
            txtSMSAutoDiscount.Text = colNS_Products_TechnicalInfo.Item(0).SMSAutoDiscount.ToString & " %"
            txtTaxRate.Text = colNS_Products_TechnicalInfo.Item(0).TaxRate
            lblContentFiltering.Text = IIf(colNS_Products_TechnicalInfo.Item(0).ContentFiltering = 1, "Enabled", IIf(colNS_Products_TechnicalInfo.Item(0).ContentFiltering = 2, "Not Checked", "Refused"))
        End If
    End Sub

End Class
