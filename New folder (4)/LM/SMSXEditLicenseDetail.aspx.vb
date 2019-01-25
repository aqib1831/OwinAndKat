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
        ltrlCurrentVersion.Text = objNS_Products_Franchises.Version
        txtNotes.Text = objNS_Products_Franchises.Notes
        ltrlLiveTerminals.Text = objNS_Products_Franchises.NoOfLiveTerminals
        txtServerName.Text = objNS_Products_Franchises.ServerUserName
        txtServerPassword.Text = objNS_Products_Franchises.ServerPassword
        If objNS_Products_Franchises.OSVersionID <> 0 Then
            ddlOSVersions.SelectedValue = objNS_Products_Franchises.OSVersionID
        End If
        If (objNS_Products_Franchises.InstallationDate = DateTime.MinValue) Then
            txtInstallationDate.Text = ""
        Else
            txtInstallationDate.Text = objNS_Products_Franchises.InstallationDate.ToShortDateString
        End If

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

        ddlSMTPPort.SelectedValue = objNS_Products_Franchises.SMTPPort
    End Sub
    Private Sub LoadProducts_TechnicalInfoForSMS()
        Dim colNS_Products_TechnicalInfo As New System.Collections.Generic.List(Of Portal.BLL.NS.NS_Products_TechnicalInfo)()
        colNS_Products_TechnicalInfo = Portal.BLL.NS.NS_Products_TechnicalInfo.NS_Products_TechnicalInfoGetByProductFranchiseID(CInt(Request.QueryString("ID")))
        If (colNS_Products_TechnicalInfo.Count > 0) Then
            txtISPType.Text = colNS_Products_TechnicalInfo.Item(0).ISPType
            txtFirewallRouter.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouter
            'txtISPPassword.Text = colNS_Products_TechnicalInfo.Item(0).ISPPassword
            txtFirewallRouterLogin.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouterLogin
            'txtISPUserName.Text = colNS_Products_TechnicalInfo.Item(0).ISPUserName
            txtFirewallRouterAccess.Text = colNS_Products_TechnicalInfo.Item(0).FirewallRouterAccess
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
                If String.IsNullOrEmpty(Request(txtInstallationDate.UniqueID).Trim()) = True Then
                    .InstallationDate = Date.MinValue
                Else
                    .InstallationDate = Request(txtInstallationDate.UniqueID).Trim()
                End If

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
                .CCMerchantID = 0 'txtCCLogin.Text
                .CCMerchantPassword = "" 'txtCCPassword.Text
                Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesUpdate(.ID, .IP, .ServerUserName, .ServerPassword, .NoOfLicenses, .Notes, .IsStaticIP, .CCPaymentGateway, .CCMerchantID, .CCMerchantPassword, .InstallationDate, ddlSMTPPort.SelectedValue, CInt(ddlOSVersions.SelectedValue))
            End With
            Dim ProductTechnicalInfoID As Integer = 0
            Dim ProductTechnicalInfo As New Portal.BLL.NS.NS_Products_TechnicalInfo
            With ProductTechnicalInfo
                .ID = 0
                .ProductFranchiseID = CInt(Request.QueryString("ID"))
                .ISPType = txtISPType.Text
                .FirewallRouter = txtFirewallRouter.Text
                .FirewallRouterAccess = txtFirewallRouterAccess.Text
                .FirewallRouterLogin = txtFirewallRouterLogin.Text
                .ContentFiltering = ddlContentFiltering.SelectedValue

                ProductTechnicalInfoID = Portal.BLL.NS.NS_Products_TechnicalInfo.NS_Products_TechnicalInfoAddOrUpdate(.ID, .ProductFranchiseID, .ISPType, .PrimaryDNS, .SecondaryDNS, .ISPPassword, .ISPUserName, .FirewallRouter, .FirewallRouterAccess, .FirewallRouterLogin, .DeliveryCharge, .DeliveryChargeVAT, .MerchantNo, .AuthLogin, .CCLogin, .CCPassword, .TagPrinting, .HouseCharge, .HouseChargeAmount, .SMSAutoDiscount, .TaxRate, .ContentFiltering)
            End With
            If hdnPreviousContentFiltering.Value <> ddlContentFiltering.SelectedValue Then
                Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions.NS_Products_TechnicalInfo_ExtentionsAdd(0, ProductTechnicalInfoID, CInt(Request.QueryString("ID")), hdnPreviousContentFiltering.Value, ddlContentFiltering.SelectedValue, Session("AdminID"), DateTime.Now)
            End If

            Dim authCode As String = ConfigurationManager.AppSettings("PortalServiceAuthCode").Trim
            Try
                srvPortal.Franchisee_SupportInfoUpdate(authCode, hdnFransupportFranchiseID.Value, _
                                       txtServerIP.Text, txtServerName.Text, txtServerPassword.Text, txtISPType.Text, String.Empty, _
                                      String.Empty, txtFirewallRouter.Text, txtFirewallRouterAccess.Text, txtFirewallRouterLogin.Text, _
                                       chkStaticIP.Checked, txtNoLicenses.Text, ddlSMTPPort.SelectedValue)
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "Update SMSXLicense Info from vital information in ncompass", String.Empty, HttpContext.Current.Request.UserHostAddress, String.Empty)
            End Try
            srvPortal = Nothing

            Dim LicenseID As Integer = Portal.BLL.NS.NS_Products_Franchises.GetLicenseID(Request.QueryString("ID"))
            'Setting up the security code 
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dsLicenseDetail As System.Data.DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(LicenseID)
            dsLicenseDetail.DataSetName = "SMSXLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            Try
                'Update the details in the sms db via webservice.
                Dim objSMSWebservice As New se.PortalServices
                Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateSMSXLicense", String.Empty, String.Empty, String.Empty)
            End Try
            If Request.QueryString("Type") <> Nothing AndAlso Request.QueryString("Type") = "HelpDesk" Then
                ClientScript.RegisterClientScriptBlock(Me.GetType(), "hidesms", "parent.hidesms(1);", True)
            Else
                Response.Redirect("SMSLicenseDetail.aspx?ID=" & Request.QueryString("ID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStores=" & Request.QueryString("ddlStores") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
            End If
        End If
    End Sub
    Protected Sub ddlOSVersions_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlOSVersions.DataBound
        If Not ddlOSVersions.Items.Contains(New ListItem("Select", 0)) Then
            ddlOSVersions.Items.Insert(0, New ListItem("Select", 0))
        End If
    End Sub
End Class