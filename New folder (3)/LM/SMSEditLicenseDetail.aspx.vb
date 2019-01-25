Partial Class LM_LicenseDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("ID") <> Nothing And IsNumeric(Request.QueryString("ID"))) Then
            If Not IsPostBack Then
                If Request.QueryString("Type") <> Nothing AndAlso Request.QueryString("Type") = "HelpDesk" Then
                    btnCacnel.Attributes.Add("onclick", "parent.hidesms(0);")
                Else
                    btnCacnel.PostBackUrl = "SMSLicenseDetail.aspx?ID=" & Request.QueryString("ID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStores=" & Request.QueryString("ddlStores") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                End If
                LoadProducts_FranchisesForSMS()
                LoadProducts_TechnicalInfoForSMS()
                If Not Functions.CheckModuleAccess(Portal.BLL.Enumeration.Modules.SupportInfo) Then
                    spanServerPasswordHidden.Style.Add("display", "inline")
                    txtServerPassword.Style.Add("display", "none")
                End If
            End If
        End If
    End Sub
    Private Sub LoadProducts_FranchisesForSMS()
        Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
        objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetByID(CInt(Request.QueryString("ID")))

        ltrlStoreNo.Text = objNS_Products_Franchises.StoreNick & " - " & objNS_Products_Franchises.StoreNumber & " (" & objNS_Products_Franchises.ClientCode & ")"
        hdnFransupportFranchiseID.Value = objNS_Products_Franchises.FransupportFranchiseID
        'ltrlStoreNick.Text = 
        'ltrlClientName.Text = objNS_Products_Franchises.ClientCode
        ltrlCurrentVersion.Text = objNS_Products_Franchises.Version
        txtNotes.Text = objNS_Products_Franchises.Notes
        ltrlLiveTerminals.Text = objNS_Products_Franchises.NoOfLiveTerminals
        txtServerName.Text = objNS_Products_Franchises.ServerUserName
        txtServerPassword.Text = objNS_Products_Franchises.ServerPassword
        ddlCCPaymentGateway.SelectedValue = objNS_Products_Franchises.CCPaymentGateway
        'txtCCLogin.Text = objNS_Products_Franchises.CCMerchantID
        'txtCCPassword.Text = objNS_Products_Franchises.CCMerchantPassword

        If Functions.CheckModuleAccess(Portal.BLL.Enumeration.Modules.LM) Then
            lblNoLicenses.Visible = False
            txtNoLicenses.Visible = True
            txtNoLicenses.Text = objNS_Products_Franchises.NoOfLicenses
            lblNoLicenses.Text = objNS_Products_Franchises.NoOfLicenses
        Else
            lblNoLicenses.Visible = True
            txtNoLicenses.Visible = False
            txtNoLicenses.Text = objNS_Products_Franchises.NoOfLicenses
            lblNoLicenses.Text = objNS_Products_Franchises.NoOfLicenses
        End If

        If (String.IsNullOrEmpty(objNS_Products_Franchises.UpdatedByName.Trim()) = True) Then
            ltrlUpdatedBy.Text = "- - -"
        Else
            ltrlUpdatedBy.Text = objNS_Products_Franchises.UpdatedByName
        End If
     
        txtServerIP.Text = objNS_Products_Franchises.IP
        chkStaticIP.Checked = objNS_Products_Franchises.IsStaticIP
     
        
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

            txtDeliveryCharge.Text = FormatNumber(colNS_Products_TechnicalInfo.Item(0).DeliveryCharge, 2)
            txtDeliveryChargeVAT.Text = FormatNumber(colNS_Products_TechnicalInfo.Item(0).DeliveryChargeVAT, 2)
            txtMerchantNo.Text = colNS_Products_TechnicalInfo.Item(0).MerchantNo
            txtAuthLogin.Text = colNS_Products_TechnicalInfo.Item(0).AuthLogin
            txtCCLogin.Text = colNS_Products_TechnicalInfo.Item(0).CCLogin
            txtCCPassword.Text = colNS_Products_TechnicalInfo.Item(0).CCPassword
            chkTagPrinting.Checked = colNS_Products_TechnicalInfo.Item(0).TagPrinting
            chkHouseCharge.Checked = colNS_Products_TechnicalInfo.Item(0).HouseCharge
            txtHouseChargeAmount.Text = Math.Round(colNS_Products_TechnicalInfo.Item(0).HouseChargeAmount, 2)
            txtSMSAutoDiscount.Text = colNS_Products_TechnicalInfo.Item(0).SMSAutoDiscount.ToString & " %"
            txtTaxRate.Text = FormatNumber(colNS_Products_TechnicalInfo.Item(0).TaxRate, 2)
            ddlContentFiltering.SelectedValue = colNS_Products_TechnicalInfo.Item(0).ContentFiltering
            hdnPreviousContentFiltering.Value = colNS_Products_TechnicalInfo.Item(0).ContentFiltering
        End If
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        If (Page.IsValid) Then
            Dim srvPortal As New WS_Fransupport.WS_Portal
            Dim ProductFranchises As New Portal.BLL.NS.NS_Products_Franchises
            With ProductFranchises
                .ID = CInt(Request.QueryString("ID"))
                .ServerUserName = txtServerName.Text
                .ServerPassword = txtServerPassword.Text
                If txtNoLicenses.Visible Then
                    .NoOfLicenses = txtNoLicenses.Text
                ElseIf lblNoLicenses.Visible Then
                    .NoOfLicenses = lblNoLicenses.Text
                End If
                .Notes = txtNotes.Text
                .IsStaticIP = Me.chkStaticIP.Checked
                .IP = txtServerIP.Text
                .CCPaymentGateway = ddlCCPaymentGateway.SelectedValue
                .CCMerchantID = 0 'txtCCLogin.Text
                .CCMerchantPassword = "" 'txtCCPassword.Text
                Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesUpdate(.ID, .IP, .ServerUserName, .ServerPassword, .NoOfLicenses, .Notes, .IsStaticIP, .CCPaymentGateway, .CCMerchantID, .CCMerchantPassword, Date.MinValue, 25, 0)
            End With
            Dim ProductTechnicalInfoID As Integer = 0
            Dim ProductTechnicalInfo As New Portal.BLL.NS.NS_Products_TechnicalInfo
            With ProductTechnicalInfo
                .ID = 0
                .ProductFranchiseID = CInt(Request.QueryString("ID"))
                .ISPType = txtISPType.Text
                .PrimaryDNS = txtPrimaryDNS.Text
                .SecondaryDNS = txtSecondaryDNS.Text
                .ISPPassword = txtISPPassword.Text
                .ISPUserName = txtISPUserName.Text
                .FirewallRouter = txtFirewallRouter.Text
                .FirewallRouterAccess = txtFirewallRouterAccess.Text
                .FirewallRouterLogin = txtFirewallRouterLogin.Text

                .DeliveryCharge = IIf(txtDeliveryCharge.Text = "", "0", txtDeliveryCharge.Text)
                .DeliveryChargeVAT = IIf(txtDeliveryChargeVAT.Text = "", "0", txtDeliveryChargeVAT.Text)
                .MerchantNo = txtMerchantNo.Text
                .AuthLogin = txtAuthLogin.Text
                .CCLogin = txtCCLogin.Text
                .CCPassword = txtCCPassword.Text
                .TagPrinting = chkTagPrinting.Checked
                .HouseCharge = chkHouseCharge.Checked
                .HouseChargeAmount = IIf(txtHouseChargeAmount.Text = "", "0", txtHouseChargeAmount.Text)
                .SMSAutoDiscount = IIf(txtSMSAutoDiscount.Text.Replace("%", "").Trim = "", "0", txtSMSAutoDiscount.Text.Replace("%", "").Trim)
                .TaxRate = IIf(txtTaxRate.Text = "", "0", txtTaxRate.Text)
                .ContentFiltering = ddlContentFiltering.SelectedValue

                ProductTechnicalInfoID = Portal.BLL.NS.NS_Products_TechnicalInfo.NS_Products_TechnicalInfoAddOrUpdate(.ID, .ProductFranchiseID, .ISPType, .PrimaryDNS, .SecondaryDNS, .ISPPassword, .ISPUserName, .FirewallRouter, .FirewallRouterAccess, .FirewallRouterLogin, .DeliveryCharge, .DeliveryChargeVAT, .MerchantNo, .AuthLogin, .CCLogin, .CCPassword, .TagPrinting, .HouseCharge, .HouseChargeAmount, .SMSAutoDiscount, .TaxRate, .ContentFiltering)
            End With
            If hdnPreviousContentFiltering.Value <> ddlContentFiltering.SelectedValue Then
                Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions.NS_Products_TechnicalInfo_ExtentionsAdd(0, ProductTechnicalInfoID, CInt(Request.QueryString("ID")), hdnPreviousContentFiltering.Value, ddlContentFiltering.SelectedValue, Session("AdminID"), DateTime.Now)
            End If

            txtDeliveryCharge.Text = IIf(txtDeliveryCharge.Text = "", "0", txtDeliveryCharge.Text)
            txtDeliveryChargeVAT.Text = IIf(txtDeliveryChargeVAT.Text = "", "0", txtDeliveryChargeVAT.Text)
            txtHouseChargeAmount.Text = IIf(txtHouseChargeAmount.Text = "", "0", txtHouseChargeAmount.Text)
            txtSMSAutoDiscount.Text = IIf(txtSMSAutoDiscount.Text.Replace("%", "").Trim = "", "0", txtSMSAutoDiscount.Text.Replace("%", "").Trim)
            txtTaxRate.Text = IIf(txtTaxRate.Text = "", "0", txtTaxRate.Text)


            Dim authCode As String = ConfigurationManager.AppSettings("PortalServiceAuthCode").Trim
            Dim AffectedFirst As Integer = srvPortal.Franchisee_InfoUpdate(authCode, hdnFransupportFranchiseID.Value, _
            txtTaxRate.Text, txtDeliveryCharge.Text, txtDeliveryChargeVAT.Text, ddlCCPaymentGateway.SelectedValue, _
            txtMerchantNo.Text, txtAuthLogin.Text, txtCCLogin.Text, txtCCPassword.Text, chkTagPrinting.Checked, _
            chkHouseCharge.Checked, txtHouseChargeAmount.Text, txtSMSAutoDiscount.Text, txtTaxRate.Text)

            Dim AffectedSecond As Integer = srvPortal.Franchisee_SupportInfoUpdate(authCode, hdnFransupportFranchiseID.Value, _
            txtServerIP.Text, txtServerName.Text, txtServerPassword.Text, txtISPType.Text, txtPrimaryDNS.Text, _
            txtSecondaryDNS.Text, txtFirewallRouter.Text, txtFirewallRouterAccess.Text, txtFirewallRouterLogin.Text, _
            chkStaticIP.Checked, txtNoLicenses.Text, 25)

            If Request.QueryString("Type") <> Nothing AndAlso Request.QueryString("Type") = "HelpDesk" Then
                ClientScript.RegisterClientScriptBlock(Me.GetType(), "hidesms", "parent.hidesms(1);", True)
            Else
                Response.Redirect("SMSLicenseDetail.aspx?ID=" & Request.QueryString("ID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStores=" & Request.QueryString("ddlStores") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
            End If
        End If
    End Sub
End Class