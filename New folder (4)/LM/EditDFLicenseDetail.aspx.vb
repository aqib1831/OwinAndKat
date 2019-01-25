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
                btnCacnel.PostBackUrl = "DFLicenseDetails.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                    'btnEdit.Visible = False
                    'btnBack.PostBackUrl = "SMSXLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                End If

                Dim objLicenseDFDetail As New Portal.BLL.DFLicenseManagement
                objLicenseDFDetail = objLicenseDFDetail.GetDFLicenseDetail(CInt(Request.QueryString("LicenseID")))
                ltrlStoreNo.Text = objLicenseDFDetail.StoreNo
                ltrlStoreNick.Text = objLicenseDFDetail.StoreNick
                ltrlClientName.Text = objLicenseDFDetail.ClientName

                ltrlLiveTerminals.Text = "- - -"
                ltrlTerminals.Text = objLicenseDFDetail.NoOfTerminals
                ltrlInvoiceNo.Text = objLicenseDFDetail.InVoiceNo
                txtNotes.Text = objLicenseDFDetail.Notes
                ViewState("SystemIP") = objLicenseDFDetail.SystemIP
                txt_StaticIP.Text = objLicenseDFDetail.SystemIP '
                chkInactive.Checked = objLicenseDFDetail.IsLicenseInActive
                ltrlIssuedBy.Text = objLicenseDFDetail.IssuedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseDFDetail.IssuedOn)
                


                If (objLicenseDFDetail.InstallationDate = Date.MinValue) Then
                    txtInstallationDate.Text = ""
                Else
                    txtInstallationDate.Text = objLicenseDFDetail.InstallationDate.ToShortDateString
                End If
                If (objLicenseDFDetail.UpdatedOn = "12:00:00 AM") Then
                    ltrlUpdatedOn.Text = "- - -"
                Else
                    ltrlUpdatedOn.Text = objLicenseDFDetail.LastUpdatedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseDFDetail.UpdatedOn)
                End If

                If (objLicenseDFDetail.IsDynamicIP = False) Then
                    rdoIP.Items(0).Selected = True
                    txt_StaticIP.Text = objLicenseDFDetail.SystemIP
                    txt_DynimicIP.Text = String.Empty
                Else
                    rdoIP.Items(1).Selected = True
                    txt_DynimicIP.Text = objLicenseDFDetail.DynamicIPEndDate
                End If

                ScriptManager.RegisterStartupScript(Me, Me.GetType, "OnChangeRadio", "OnChangeRadio();", True)
                
                If (objLicenseDFDetail.IsLicenseInActive = True) Then
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
                Dim objDFLicenseDetail As New Portal.BLL.DFLicenseManagement
                Dim LogString As String = ""
                Dim objLicenseDFDetail As New Portal.BLL.DFLicenseManagement
                objLicenseDFDetail = objLicenseDFDetail.GetDFLicenseDetail(LicenseID)



                If (objLicenseDFDetail.IsLicenseInActive <> chkInactive.Checked) Then
                    If chkInactive.Checked = True Then
                        LogString &= " Inactive License ID " & LicenseID & ","
                    Else
                        LogString &= " Active License ID " & LicenseID & ","
                    End If

                End If
                If (objLicenseDFDetail.Notes <> txtNotes.Text.Trim()) Then
                    LogString &= " Notes Change,"
                End If

                If objLicenseDFDetail.SystemIP <> txt_StaticIP.Text.Trim() Then
                    LogString &= " Static IP Change"
                End If
                Dim objLicenseDFLogDetails As New Portal.BLL.DFLicenseManagement

                objLicenseDFLogDetails.Changes = LogString
                objLicenseDFLogDetails.UserID = Session("AdminID")
                objLicenseDFLogDetails.LicenseID = LicenseID
                objLicenseDFLogDetails.AddDFLicenseTerminalLog() 'Maintain the Log


                objDFLicenseDetail.LicenseID = LicenseID

                objDFLicenseDetail.UpdatedByID = Session("AdminID")
                objDFLicenseDetail.Notes = txtNotes.Text
                objDFLicenseDetail.IsLicenseInActive = chkInactive.Checked
                If String.IsNullOrEmpty(Request(txtInstallationDate.UniqueID).Trim()) = True Then
                    objDFLicenseDetail.InstallationDate = Date.MaxValue
                Else
                    objDFLicenseDetail.InstallationDate = Request(txtInstallationDate.UniqueID).Trim()
                End If

                If (rdoIP.Items(0).Selected) Then
                    objDFLicenseDetail.SystemIP = txt_StaticIP.Text.Trim()
                    objDFLicenseDetail.IsDynamicIP = False
                    objDFLicenseDetail.DynamicIPEndDate = Date.MinValue
                Else
                    objDFLicenseDetail.SystemIP = "" ''ViewState("SystemIP").ToString()
                    objDFLicenseDetail.IsDynamicIP = True
                    objDFLicenseDetail.DynamicIPEndDate = Request(txt_DynimicIP.UniqueID).Trim()
                End If

                objDFLicenseDetail.UpdateDFLicenseDetail() 'Update the License Detail



                'Setting up the security code
                'Code Web Services
                Dim securityCode As String = ConfigurationManager.AppSettings("DFServiceAuthCode").ToString()
                Dim dsLicenseDetail As DataSet = Portal.DAL.DFLicenseManagement.GetLicenseDetailForWebService(LicenseID)
                dsLicenseDetail.DataSetName = "DFLicense"
                dsLicenseDetail.Tables(0).TableName = "License"
                dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
                securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("DFEncryptionKey"))

                Try
                    'Update the details in the sms db via webservice.

                    Dim objDFWebservice As New DippedFruit.PortalService
                    objDFWebservice.UpdateModifiedLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail), 1, True)
                Catch ex As Exception
                    ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateDFLicense", String.Empty, String.Empty, String.Empty)
                End Try

                Response.Redirect("DFLicenseDetails.aspx?LicenseID=" & LicenseID & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
            End If
        End If
        
    End Sub

    Protected Sub CV_CheckIPAvailable_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CV_CheckIPAvailable.ServerValidate

        If rdoIP.SelectedValue = 0 Then
            Dim LicenseID As Integer
            If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
                LicenseID = Request.QueryString("LicenseID")
            End If

            Dim objDFLicenseDetail As New Portal.BLL.DFLicenseManagement
            If objDFLicenseDetail.CheckSystemIPAvailabilitybyLicenseID(LicenseID, txt_StaticIP.Text.Trim()) Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If
        
    End Sub

    Protected Sub cvAlreadyExist_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles cvAlreadyExist.ServerValidate
        If chkInactive.Checked = False Then
            Dim LicenseCount As Integer = 0
            LicenseCount = Portal.BLL.DFLicenseManagement.GetActiveStoreLicensesCount(hdnLicienceID.Value)
            If LicenseCount > 0 Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If
    End Sub
End Class