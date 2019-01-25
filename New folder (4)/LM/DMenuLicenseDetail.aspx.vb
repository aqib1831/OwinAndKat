
Partial Class DMenu_LicenseDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            If Not IsPostBack Then
                btnBack.PostBackUrl = "DMenuLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                btnEdit.PostBackUrl = "DMenuEditLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                    btnEdit.Visible = False
                    btnBack.PostBackUrl = "DMenuLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                End If
                Dim objLicenseDetail As New Portal.BLL.LM.DMenuLicenseManagement
                objLicenseDetail = objLicenseDetail.GetDMenuLicenseDetail(CInt(Request.QueryString("LicenseID")))
                ltrlStoreNo.Text = objLicenseDetail.StoreNo
                ltrlStoreNick.Text = objLicenseDetail.StoreNick
                ltrlClientName.Text = objLicenseDetail.ClientName
                ltrlCurrentVersion.Text = objLicenseDetail.CurrentVersion
                ltrlRegkey.Text = objLicenseDetail.RegistrationKey
                If objLicenseDetail.Notes <> "" Then
                    ltrlNotes.Text = objLicenseDetail.Notes.Replace(vbCrLf, "<br/>")
                End If
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
                Else
                    ltrlStaticIP.Text = "No"
                End If

                ltrlTrainingActive.Text = objLicenseDetail.NumberOfDisplays

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
					If CInt(Session("AdminID")) = 98 OR  CInt(Session("AdminID")) = 3075 Then ' only for Khurram And Saad
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

            End If
        End If

    End Sub

	Protected Sub btnClearSession_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClearSession.Click
        Dim objLicenseDetail As New Portal.DAL.LM.DBDMenuLicenseManagement
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            objLicenseDetail.DMenu_Users_ClearSession(CInt(Request.QueryString("LicenseID")), CInt(Session("AdminID")), ltrlNotes.Text.ToString.Replace("<br/>", vbCrLf) + vbCrLf + "System ID has been cleared by " & Session("AdminName") & " on: " & DateTime.Now.ToString)
            Response.Redirect("DMenuLicenseDetail.aspx?" & Request.QueryString().ToString)
        End If
    End Sub
End Class
