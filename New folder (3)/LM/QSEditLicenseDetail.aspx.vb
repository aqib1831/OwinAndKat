
Partial Class LM_QsLicenseDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            hdnLicienceID.Value = Request.QueryString("LicenseID")
            If Not IsPostBack Then
                btnCacnel.PostBackUrl = "QsLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                    'btnEdit.Visible = False
                    'btnBack.PostBackUrl = "SMSXLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                End If

                Dim objLicenseQsDetail As New Portal.BLL.QsLicenseManagment
                objLicenseQsDetail = objLicenseQsDetail.GetQsLicenseDetail(CInt(Request.QueryString("LicenseID")))
                ltrlStoreNo.Text = objLicenseQsDetail.StoreNo
                ltrlStoreNick.Text = objLicenseQsDetail.StoreNick
                hdnClientID.Value = objLicenseQsDetail.ClientID.ToString()
                ltrlClientName.Text = objLicenseQsDetail.ClientName
                ltrlLiveTerminals.Text = "- - -"
                ltrlTerminals.Text = objLicenseQsDetail.NoOfTerminals
                ltrlInvoiceNo.Text = objLicenseQsDetail.InVoiceNo
                txtNotes.Text = objLicenseQsDetail.Notes
                ViewState("SystemIP") = objLicenseQsDetail.SystemIP
                txt_StaticIP.Text = objLicenseQsDetail.SystemIP '
                chkInactive.Checked = objLicenseQsDetail.IsLicenseInActive
                ltrlIssuedBy.Text = objLicenseQsDetail.IssuedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseQsDetail.IssuedOn)


                If (objLicenseQsDetail.UpdatedOn = "12:00:00 AM") Then
                    ltrlUpdatedOn.Text = "- - -"
                Else
                    ltrlUpdatedOn.Text = objLicenseQsDetail.LastUpdatedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseQsDetail.UpdatedOn)
                End If

                If (objLicenseQsDetail.IsDynamicIP = False) Then
                    rdoIP.Items(0).Selected = True
                    txt_StaticIP.Text = objLicenseQsDetail.SystemIP
                    txt_DynimicIP.Text = String.Empty
                Else
                    rdoIP.Items(1).Selected = True
                    txt_DynimicIP.Text = objLicenseQsDetail.DynamicIPEndDate
                End If

                ScriptManager.RegisterStartupScript(Me, Me.GetType, "OnChangeRadio", "OnChangeRadio();", True)

                If (objLicenseQsDetail.IsLicenseInActive = True) Then
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
                Dim objLicenseQsDetail As New Portal.BLL.QsLicenseManagment
                Dim LogString As String = ""
                Dim objLicenseQs1Detail As New Portal.BLL.QsLicenseManagment
                objLicenseQs1Detail = objLicenseQs1Detail.GetQsLicenseDetail(LicenseID)



                If (objLicenseQs1Detail.IsLicenseInActive <> chkInactive.Checked) Then
                    If chkInactive.Checked = True Then
                        LogString &= " Inactive License ID " & LicenseID & ","
                    Else
                        LogString &= " Active License ID " & LicenseID & ","
                    End If

                End If
                If (objLicenseQs1Detail.Notes <> txtNotes.Text.Trim()) Then
                    LogString &= " Notes Change,"
                End If

                If objLicenseQs1Detail.SystemIP <> txt_StaticIP.Text.Trim() Then
                    LogString &= " Static IP Change"
                End If
                Dim objLicenseQsLogDetails As New Portal.BLL.QsLicenseManagment

                objLicenseQsLogDetails.Changes = LogString
                objLicenseQsLogDetails.UserID = Session("AdminID")
                objLicenseQsLogDetails.LicenseID = LicenseID
                objLicenseQsLogDetails.AddQsLicenseTerminalLog() 'Maintain the Log


                objLicenseQsDetail.LicenseID = LicenseID

                objLicenseQsDetail.UpdatedByID = Session("AdminID")
                objLicenseQsDetail.Notes = txtNotes.Text
                objLicenseQsDetail.IsLicenseInActive = chkInactive.Checked
                If (rdoIP.Items(0).Selected) Then
                    objLicenseQsDetail.SystemIP = txt_StaticIP.Text.Trim()
                    objLicenseQsDetail.IsDynamicIP = False
                    objLicenseQsDetail.DynamicIPEndDate = Date.MinValue
                Else
                    objLicenseQsDetail.SystemIP = "" ''ViewState("SystemIP").ToString()
                    objLicenseQsDetail.IsDynamicIP = True
                    objLicenseQsDetail.DynamicIPEndDate = Request(txt_DynimicIP.UniqueID).Trim()
                End If

                objLicenseQsDetail.UpdateQSLicenseDetail() 'Update the License Detail



                'Setting up the security code 
                'Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
                'Dim dsLicenseDetail As Data.DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(LicenseID)
                'dsLicenseDetail.DataSetName = "SMSXLicense"
                'dsLicenseDetail.Tables(0).TableName = "License"
                'dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
                'securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

                Try
                    If CInt(hdnClientID.Value) = Portal.BLL.Enumeration.ClientID.SaladCreation Then
                        Dim NoOfTerminals As Integer = Portal.DAL.QsLicenseManagment.GetTotalNoOfTerminalsByStoreNumber(CInt(ltrlStoreNo.Text.Trim))
                        Dim serSaladCreation As New SaladCreation.Service
                        serSaladCreation.UpdateFranchiseTerminals(CInt(ltrlStoreNo.Text.Trim), NoOfTerminals)
                    End If
                    '    'Update the details in the sms db via webservice.
                    '    Dim objSMSWebservice As New se.PortalServices
                    '    Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                Catch ex As Exception
                    ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateQsLicense", String.Empty, String.Empty, String.Empty)
                End Try

                Response.Redirect("QSLicenseDetail.aspx?LicenseID=" & LicenseID & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
            End If
        End If

    End Sub

    Protected Sub CV_CheckIPAvailable_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CV_CheckIPAvailable.ServerValidate

        If rdoIP.SelectedValue = 0 Then
            Dim LicenseID As Integer
            If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
                LicenseID = Request.QueryString("LicenseID")
            End If

            Dim objQsLicenseDetail As New Portal.BLL.QsLicenseManagment
            If objQsLicenseDetail.CheckSystemIPAvailabilitybyLicenseID(LicenseID, txt_StaticIP.Text.Trim()) Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If

    End Sub

    Protected Sub cvAlreadyExist_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles cvAlreadyExist.ServerValidate
        If chkInactive.Checked = False Then
            Dim LicenseCount As Integer = 0
            LicenseCount = Portal.BLL.QsLicenseManagment.GetActiveStoreLicensesCount(hdnLicienceID.Value)
            If LicenseCount > 0 Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If
    End Sub
End Class
