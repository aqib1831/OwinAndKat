Imports System.Data
Imports System.Web
Partial Class LM_EditSMSXLicenseDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            hdnLicienceID.Value = Request.QueryString("LicenseID")
            If Not IsPostBack Then
                btnCacnel.PostBackUrl = "SmsxLicenseDetails.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                    'btnEdit.Visible = False
                    'btnBack.PostBackUrl = "SMSXLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                End If

                Dim objLicenseSMXDetail As New Portal.BLL.SMSXLicenseManagement
                objLicenseSMXDetail = objLicenseSMXDetail.GetSMSXLicenseDetail(CInt(Request.QueryString("LicenseID")))
                ltrlStoreNo.Text = objLicenseSMXDetail.StoreNo
                ltrlStoreNick.Text = objLicenseSMXDetail.StoreNick
                ltrlClientName.Text = objLicenseSMXDetail.ClientName
                ltrlLiveTerminals.Text = "- - -"
                ltrlTerminals.Text = objLicenseSMXDetail.NoOfTerminals
                ltrlInvoiceNo.Text = objLicenseSMXDetail.InVoiceNo
                txtNotes.Text = objLicenseSMXDetail.Notes
                ViewState("SystemIP") = objLicenseSMXDetail.SystemIP
                txt_StaticIP.Text = objLicenseSMXDetail.SystemIP '
                chkInactive.Checked = objLicenseSMXDetail.IsLicenseInActive
                ltrlIssuedBy.Text = objLicenseSMXDetail.IssuedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseSMXDetail.IssuedOn)
                


                If (objLicenseSMXDetail.InstallationDate = Date.MinValue) Then
                    txtInstallationDate.Text = ""
                Else
                    txtInstallationDate.Text = objLicenseSMXDetail.InstallationDate.ToShortDateString
                End If
                If (objLicenseSMXDetail.UpdatedOn = "12:00:00 AM") Then
                    ltrlUpdatedOn.Text = "- - -"
                Else
                    ltrlUpdatedOn.Text = objLicenseSMXDetail.LastUpdatedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseSMXDetail.UpdatedOn)
                End If

                If (objLicenseSMXDetail.IsDynamicIP = False) Then
                    rdoIP.Items(0).Selected = True
                    txt_StaticIP.Text = objLicenseSMXDetail.SystemIP
                    txt_DynimicIP.Text = String.Empty
                Else
                    rdoIP.Items(1).Selected = True
                    txt_DynimicIP.Text = objLicenseSMXDetail.DynamicIPEndDate
                End If

                ScriptManager.RegisterStartupScript(Me, Me.GetType, "OnChangeRadio", "OnChangeRadio();", True)
                
                If (objLicenseSMXDetail.IsLicenseInActive = True) Then
                    ltrlActive.Text = "Inactive"
                    divltrlActive.Attributes.Add("class", "darkRedColor")
                Else
                    ltrlActive.Text = "Active"
                    divltrlActive.Attributes.Add("class", "darkGreenColor")
                End If
            End If

        End If
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        If Page.IsValid Then
            Dim LicenseID As Integer
            If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
                LicenseID = Request.QueryString("LicenseID")
                Dim objSMSXLicenseDetail As New Portal.BLL.SMSXLicenseManagement
                Dim LogString As String = ""
                Dim objLicenseSMXDetail As New Portal.BLL.SMSXLicenseManagement
                objLicenseSMXDetail = objLicenseSMXDetail.GetSMSXLicenseDetail(LicenseID)



                If (objLicenseSMXDetail.IsLicenseInActive <> chkInactive.Checked) Then
                    If chkInactive.Checked = True Then
                        LogString &= " Inactive License ID " & LicenseID & ","
                    Else
                        LogString &= " Active License ID " & LicenseID & ","
                    End If

                End If
                If (objLicenseSMXDetail.Notes <> txtNotes.Text.Trim()) Then
                    LogString &= " Notes Change,"
                End If

                If objLicenseSMXDetail.SystemIP <> txt_StaticIP.Text.Trim() Then
                    LogString &= " Static IP Change"
                End If
                Dim objLicenseSMXLogDetails As New Portal.BLL.SMSXLicenseManagement

                objLicenseSMXLogDetails.Changes = LogString
                objLicenseSMXLogDetails.UserID = Session("AdminID")
                objLicenseSMXLogDetails.LicenseID = LicenseID
                objLicenseSMXLogDetails.AddSMSXLicenseTerminalLog() 'Maintain the Log


                objSMSXLicenseDetail.LicenseID = LicenseID

                objSMSXLicenseDetail.UpdatedByID = Session("AdminID")
                objSMSXLicenseDetail.Notes = txtNotes.Text
                objSMSXLicenseDetail.IsLicenseInActive = chkInactive.Checked
                If String.IsNullOrEmpty(Request(txtInstallationDate.UniqueID).Trim()) = True Then
                    objSMSXLicenseDetail.InstallationDate = Date.MinValue
                Else
                    objSMSXLicenseDetail.InstallationDate = Request(txtInstallationDate.UniqueID).Trim()
                End If
                If (rdoIP.Items(0).Selected) Then
                    objSMSXLicenseDetail.SystemIP = txt_StaticIP.Text.Trim()
                    objSMSXLicenseDetail.IsDynamicIP = False
                    objSMSXLicenseDetail.DynamicIPEndDate = Date.MinValue
                Else
                    objSMSXLicenseDetail.SystemIP = ViewState("SystemIP").ToString()
                    objSMSXLicenseDetail.IsDynamicIP = True
                    objSMSXLicenseDetail.DynamicIPEndDate = Request(txt_DynimicIP.UniqueID).Trim()
                End If

                objSMSXLicenseDetail.UpdateSMSXLicenseDetail() 'Update the License Detail



                'Setting up the security code 
                Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
                Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(LicenseID)
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

                Response.Redirect("SmsxLicenseDetails.aspx?LicenseID=" & LicenseID & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
            End If
        End If
        
    End Sub

    Protected Sub CV_CheckIPAvailable_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CV_CheckIPAvailable.ServerValidate

        If rdoIP.SelectedValue = 0 Then
            Dim LicenseID As Integer
            If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
                LicenseID = Request.QueryString("LicenseID")
            End If

            Dim objSMSXLicenseDetail As New Portal.BLL.SMSXLicenseManagement
            If objSMSXLicenseDetail.CheckSystemIPAvailabilitybyLicenseID(LicenseID, txt_StaticIP.Text.Trim()) Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If
        
    End Sub
End Class