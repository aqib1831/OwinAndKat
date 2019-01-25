
Partial Class LM_EditLicenseDetailDC
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            If Not IsPostBack Then
                btnCacnel.PostBackUrl = "LicenseDetailDC.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                'btnCacnel.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/LM/LicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID")) & "'; return false; ")
                LoadLicenseDetail()
            End If
        End If

    End Sub
    Private Sub LoadLicenseDetail()
        Dim objLicenseDetail As New Portal.BLL.LicenseManagementDC
        objLicenseDetail = objLicenseDetail.GetNextStepLicenseDetail(CInt(Request.QueryString("LicenseID")))
        ltrlStoreNo.Text = objLicenseDetail.StoreNo
        ltrlStoreNick.Text = objLicenseDetail.StoreNick
        ltrlClientName.Text = objLicenseDetail.ClientName
        ltrlCurrentVersion.Text = objLicenseDetail.CurrentVersion
        ltrlRegkey.Text = objLicenseDetail.RegistrationKey
        txtNotes.Text = objLicenseDetail.Notes
        ViewState("SystemIP") = objLicenseDetail.SystemIP
        txt_StaticIP.Text = objLicenseDetail.SystemIP
        If (objLicenseDetail.IsDynamicIP = False) Then
            rdoIP.Items(0).Selected = True
            txt_StaticIP.Text = objLicenseDetail.SystemIP
            txt_DynimicIP.Text = String.Empty
        Else
            rdoIP.Items(1).Selected = True
            txt_DynimicIP.Text = objLicenseDetail.DynamicIPEndDate
        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType, "OnChangeRadio", "OnChangeRadio();", True)
        If (objLicenseDetail.IsTrainingActive = True) Then
            chkTrainingActive.Checked = True
        Else
            chkTrainingActive.Checked = False
        End If
        If (String.IsNullOrEmpty(objLicenseDetail.InVoiceNo) = True) Then
            txtInvoiceNo.Text = String.Empty
        Else
            txtInvoiceNo.Text = objLicenseDetail.InVoiceNo
        End If
        If (objLicenseDetail.IsLicenseInActive = True) Then
            chkInActivenXstep.Checked = True
            ltrlActive.Text = "Inactive"
            divltrlActive.Attributes.Add("class", "darkRedColor")
        Else
            chkInActivenXstep.Checked = False
            ltrlActive.Text = "Active"
            divltrlActive.Attributes.Add("class", "darkGreenColor")
        End If
        If (String.IsNullOrEmpty(objLicenseDetail.LastSyncTime) = True) Then
            ltrlLastTimeSync.Text = "- - -"
        Else
            ltrlLastTimeSync.Text = Functions.DateDiffInWordsLong(objLicenseDetail.LastSyncTime)
        End If
        ddlApptoConnect.DataBind()
        ddlApptoConnect.SelectedValue = objLicenseDetail.ApplicationToConnect
        chkInactiveSMS.Checked = IIf(objLicenseDetail.IsSMSAppEnabled, False, True)
    End Sub
    Protected Sub ddlApptoConnect_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlApptoConnect.DataBound
        ddlApptoConnect.Items.Insert(0, New ListItem("Select..", "0"))
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            Dim objLicenseDetail As New Portal.BLL.LicenseManagementDC
            objLicenseDetail.SBSUserID = CInt(Request.QueryString("LicenseID"))
            objLicenseDetail.IsLicenseInActive = chkInActivenXstep.Checked
            objLicenseDetail.IsTrainingActive = chkTrainingActive.Checked
            objLicenseDetail.InVoiceNo = txtInvoiceNo.Text
            objLicenseDetail.UpdatedByID = Session("AdminID")
            objLicenseDetail.Notes = txtNotes.Text.Trim()
            If (rdoIP.Items(0).Selected) Then
                objLicenseDetail.SystemIP = txt_StaticIP.Text.Trim()
                objLicenseDetail.IsDynamicIP = False
                objLicenseDetail.DynamicIPEndDate = Date.MinValue
            Else
                objLicenseDetail.SystemIP = ViewState("SystemIP").ToString()
                objLicenseDetail.IsDynamicIP = True
                objLicenseDetail.DynamicIPEndDate = txt_DynimicIP.Text.Trim()
            End If
            objLicenseDetail.ApplicationToConnect = ddlApptoConnect.SelectedValue
            objLicenseDetail.IsSMSAppEnabled = IIf(chkInactiveSMS.Checked, False, True)
            objLicenseDetail.UpdateLicenseDetail()
            Response.Redirect("LicenseDetailDC.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
        End If
    End Sub
End Class
