Partial Class LM_LicenseDetailDC
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            If Not IsPostBack Then
                btnBack.PostBackUrl = "LicenseManagementDC.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                btnEdit.PostBackUrl = "EditLicenseDetailDC.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                    btnEdit.Visible = False
                    btnBack.PostBackUrl = "LicenseManagementDC.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                End If

                Dim objLicenseDetail As New Portal.BLL.LicenseManagementDC
                objLicenseDetail = objLicenseDetail.GetNextStepLicenseDetail(CInt(Request.QueryString("LicenseID")))
                ltrlStoreNo.Text = objLicenseDetail.StoreNo
                ltrlStoreNick.Text = objLicenseDetail.StoreNick
                ltrlClientName.Text = objLicenseDetail.ClientName
                ltrlCurrentVersion.Text = objLicenseDetail.CurrentVersion
                ltrlRegkey.Text = objLicenseDetail.RegistrationKey
                ltrlNotes.Text = objLicenseDetail.Notes.Replace(vbCrLf, "<br/>")
                If (String.IsNullOrEmpty(objLicenseDetail.IssuedBy) = True) Then
                    ltrlIssuedBy.Text = "- - -"
                Else
                    ltrlIssuedBy.Text = objLicenseDetail.IssuedBy
                End If
                If (String.IsNullOrEmpty(objLicenseDetail.UpdatedBy) = True) Then
                    ltrlUpdatedBy.Text = "- - -"
                Else
                    ltrlUpdatedBy.Text = objLicenseDetail.UpdatedBy
                End If
                If (String.IsNullOrEmpty(objLicenseDetail.SystemIP) = True) Then
                    ltrlSystemIP.Text = "- - -"
                Else
                    ltrlSystemIP.Text = objLicenseDetail.SystemIP
                End If
                If (String.IsNullOrEmpty(objLicenseDetail.CurrentIP) = True) Then
                    ltrlCurrentIP.Text = "- - -"
                Else
                    ltrlCurrentIP.Text = objLicenseDetail.CurrentIP
                End If

                If (objLicenseDetail.IsDynamicIP = False) Then
                    ltrlStaticIP.Text = "Yes"
                    ltrlSystemIP.Text = objLicenseDetail.SystemIP
                    tdsystemIP.InnerText = "System IP:"
                Else
                    ltrlStaticIP.Text = "No"
                    ltrlSystemIP.Text = objLicenseDetail.DynamicIPEndDate
                    tdsystemIP.InnerText = "Dynamic IP Date:"
                End If
                If (objLicenseDetail.IsTrainingActive = True) Then
                    ltrlTrainingActive.Text = "Active"
                Else
                    ltrlTrainingActive.Text = "Inactive"
                End If
                If (String.IsNullOrEmpty(objLicenseDetail.InVoiceNo) = True) Then
                    ltrlInvoiceNo.Text = "- - -"
                Else
                    ltrlInvoiceNo.Text = objLicenseDetail.InVoiceNo
                End If
                If (objLicenseDetail.IsLicenseInActive = True) Then
                    ltrlActive.Text = "Inactive"
                    divltrlActive.Attributes.Add("class", "darkRedColor")
                    btnClearSession.Visible = False
                Else
                    ltrlActive.Text = "Active"
                    divltrlActive.Attributes.Add("class", "darkGreenColor")
                    If CInt(Session("AdminID")) = 98 Or CInt(Session("AdminID")) = 3075 Or CInt(Session("AdminID")) = 3076 Or CInt(Session("AdminID")) = 3800 Then  '-- Only for Khurram and Saad and Ali raza
                        btnClearSession.Visible = True
                    End If
                End If
                If (String.IsNullOrEmpty(objLicenseDetail.LastSyncTime) = True) Then
                    ltrlLastTimeSync.Text = "- - -"
                Else
                    ltrlLastTimeSync.Text = Functions.DateDiffInWordsLong(objLicenseDetail.LastSyncTime)
                    ltrlLastTimeSync.ToolTip = objLicenseDetail.LastSyncTime
                End If

                If (objLicenseDetail.IssuedOn = DateTime.MinValue) Then
                    ltrlIssuedOn.Text = "- - -"
                Else
                    ltrlIssuedOn.Text = Functions.DateDiffInWordsLong(objLicenseDetail.IssuedOn)
                    ltrlIssuedOn.ToolTip = objLicenseDetail.IssuedOn
                End If
                If (objLicenseDetail.UpdatedOn = DateTime.MinValue) Then
                    ltrlUpdateOn.Text = "- - -"
                Else
                    ltrlUpdateOn.Text = Functions.DateDiffInWordsLong(objLicenseDetail.UpdatedOn)
                    ltrlUpdateOn.ToolTip = objLicenseDetail.UpdatedOn
                End If
                If (String.IsNullOrEmpty(objLicenseDetail.SystemID) = True) Then
                    ltrlMACAddress.Text = "- - -"
                Else
                    ltrlMACAddress.Text = Functions.Decryption(Functions.IfNull(objLicenseDetail.SystemID, ""))
                End If
                If (String.IsNullOrEmpty(objLicenseDetail.SystemName) = True) Then
                    ltrlComputerName.Text = "- - -"
                Else
                    ltrlComputerName.Text = objLicenseDetail.SystemName
                End If
                ltrlAppToconnect.Text = objLicenseDetail.ApplicationToConnectName
                ltrlInactiveSMS.Text = IIf(objLicenseDetail.IsSMSAppEnabled, "No", "Yes")
            End If
        End If

    End Sub

    Protected Sub btnClearSession_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClearSession.Click
        Dim objLicenseDetail As New Portal.DAL.LicenseManagementDC
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            objLicenseDetail.SBS_Users_ClearSession(CInt(Request.QueryString("LicenseID")), CInt(Session("AdminID")), ltrlNotes.Text.ToString.Replace("<br/>", vbCrLf) + vbCrLf + "System ID has been cleared by " & Session("AdminName") & " on: " & DateTime.Now.ToString)
            Response.Redirect("LicenseDetailDC.aspx?" & Request.QueryString().ToString)
        End If

    End Sub
End Class
