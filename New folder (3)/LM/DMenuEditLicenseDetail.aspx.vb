
Partial Class DMenu_EditLicenseDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            If Not IsPostBack Then
                btnCacnel.PostBackUrl = "DMenuLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                'btnCacnel.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/LM/LicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID")) & "'; return false; ")
                LoadLicenseDetail()
            End If
        End If

    End Sub
    Private Sub LoadLicenseDetail()
        Dim objLicenseDetail As New Portal.BLL.LM.DMenuLicenseManagement
        objLicenseDetail = objLicenseDetail.GetDMenuLicenseDetail(CInt(Request.QueryString("LicenseID")))
        ltrlStoreNo.Text = objLicenseDetail.StoreNo
        ltrlStoreNick.Text = objLicenseDetail.StoreNick
        ltrlClientName.Text = objLicenseDetail.ClientName
        ltrlCurrentVersion.Text = objLicenseDetail.CurrentVersion
        ltrlRegkey.Text = objLicenseDetail.RegistrationKey
        txtNotes.Text = objLicenseDetail.Notes
        ViewState("SystemIP") = objLicenseDetail.SystemIP
        If (String.IsNullOrEmpty(objLicenseDetail.SystemIP) = True) Then
            txtSystemIP.Text = String.Empty
        Else
            txtSystemIP.Text = objLicenseDetail.SystemIP
        End If
        If (objLicenseDetail.IsDynamicIP = False) Then
            chkStaticIP.Checked = True

        Else
            chkStaticIP.Checked = False
            spanStaticIP.Style.Item("display") = "none"
            txtSystemIP.Style.Item("display") = "none"
        End If
        ddlNumberOfDisplays.SelectedValue = objLicenseDetail.NumberOfDisplays
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
    End Sub


    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            Dim objLicenseDetail As New Portal.BLL.LM.DMenuLicenseManagement
            objLicenseDetail.DMenuUserID = CInt(Request.QueryString("LicenseID"))
            objLicenseDetail.IsLicenseInActive = chkInActivenXstep.Checked
            objLicenseDetail.NumberOfDisplays = ddlNumberOfDisplays.SelectedValue
            objLicenseDetail.InVoiceNo = txtInvoiceNo.Text
            objLicenseDetail.UpdatedByID = Session("AdminID")
            objLicenseDetail.Notes = txtNotes.Text.Trim()
            If (chkStaticIP.Checked) Then
                objLicenseDetail.IsDynamicIP = False
                objLicenseDetail.SystemIP = txtSystemIP.Text.Trim()
            Else
                objLicenseDetail.IsDynamicIP = True
                objLicenseDetail.SystemIP = ViewState("SystemIP").ToString()
            End If
            objLicenseDetail.UpdateLicenseDetail()
            Response.Redirect("DMenuLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
        End If
    End Sub
End Class
