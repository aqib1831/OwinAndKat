
Partial Class DMenu_EditLicenseDetail_VitalInfo
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("ID") <> Nothing And IsNumeric(Request.QueryString("ID"))) Then
            If Not IsPostBack Then
                btnCacnel.Attributes.Add("onclick", "parent.hidesms(0);")
                LoadProducts_Franchises()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "setIpField", "ToggleIpTextBox();", True)
            End If
        End If

    End Sub
    Private Sub LoadProducts_Franchises()
        Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
        objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetByID(CInt(Request.QueryString("ID")))
        ltrlStoreNo.Text = objNS_Products_Franchises.StoreNick & " - " & objNS_Products_Franchises.StoreNumber & " (" & objNS_Products_Franchises.ClientCode & ")"
        If (String.IsNullOrEmpty(objNS_Products_Franchises.UpdatedByName.Trim()) = True) Then
            'ltrlUpdatedBy.Text = "- - -"
        Else
            'ltrlUpdatedBy.Text = objNS_Products_Franchises.UpdatedByName
        End If

        txtSystemIP.Text = objNS_Products_Franchises.IP
        chkStaticIP.Checked = objNS_Products_Franchises.IsStaticIP

        If (String.IsNullOrEmpty(objNS_Products_Franchises.LastUpdateDate) = True) Then
            'ltrlLastTimeSync.Text = "- - -"
        Else
            'ltrlLastTimeSync.Text = Functions.DateDiffInWords(objNS_Products_Franchises.LastUpdateDate)
            'ltrlLastTimeSync.ToolTip = objNS_Products_Franchises.LastUpdateDate
        End If
    End Sub


    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim result As Integer = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesUpdate_DM(Request.QueryString("ID"), txtSystemIP.Text, chkStaticIP.Checked)
        ClientScript.RegisterClientScriptBlock(Me.GetType(), "hidesms", "parent.hidesms(1);", True)

        'If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
        '    Dim objLicenseDetail As New Portal.BLL.LM.DMenuLicenseManagement
        '    objLicenseDetail.DMenuUserID = CInt(Request.QueryString("LicenseID"))
        '    objLicenseDetail.IsLicenseInActive = chkInActivenXstep.Checked
        '    objLicenseDetail.NumberOfDisplays = ddlNumberOfDisplays.SelectedValue
        '    objLicenseDetail.InVoiceNo = txtInvoiceNo.Text
        '    objLicenseDetail.UpdatedByID = Session("AdminID")
        '    objLicenseDetail.Notes = txtNotes.Text.Trim()
        '    If (chkStaticIP.Checked) Then
        '        objLicenseDetail.IsDynamicIP = False
        '        objLicenseDetail.SystemIP = txtSystemIP.Text.Trim()
        '    Else
        '        objLicenseDetail.IsDynamicIP = True
        '        objLicenseDetail.SystemIP = ViewState("SystemIP").ToString()
        '    End If
        '    objLicenseDetail.UpdateLicenseDetail()
        '    Response.Redirect("DMenuLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters"))
        'End If
    End Sub
End Class
