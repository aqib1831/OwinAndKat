Partial Class SSL_NewSSL
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
#Region "ddlCategory_DataBound"

    Protected Sub ddlCategory1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategory1.DataBound
        ddlCategory1.Items.Insert(0, New ListItem("Select Category", "0"))
    End Sub

#End Region

#Region "ddlAccount_DataBound"

    Protected Sub ddlAccount1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAccount1.DataBound
        ddlAccount1.Items.Insert(0, New ListItem("Select Account", "0"))
    End Sub

#End Region

#Region "ddlCountries_DataBound"

    Protected Sub ddlCountries_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.Items.Insert(0, New ListItem("Select Country", "0"))
    End Sub

#End Region


#Region "ddlRegistrar_DataBound"

    Protected Sub ddlRegistrar1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlRegistrar1.DataBound
        ddlRegistrar1.Items.Insert(0, New ListItem("Select Registrar", "0"))
    End Sub

#End Region

#Region "btnSave_Click"

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim objURLm As New SSLM
        Dim rtValue As Integer
        Try
            With objURLm
                .UrlId = CInt(hdnURLID.Value)
                .AccountId = ddlAccount1.SelectedValue
                .RegistrarId = ddlRegistrar1.SelectedValue
                .CategoryId = ddlCategory1.SelectedValue
                .URL = txtURL.Text
                .ExpirationDate = txtExpirydate.Text
                .NameServer1 = txtnameServer1.Text
                .NameServer2 = txtNameServer2.Text
                .ReferralUrl = txtreferralURL.Text
                .WhoisServer = txtWhoisServer.Text
                .ActivationDate = IIf(txtActivationDate.Text = String.Empty, Nothing, txtActivationDate.Text)
                .RegistrationDate = IIf(txtRegistration.Text = String.Empty, Nothing, txtRegistration.Text)
                .CountryID = ddlCountry.SelectedValue
                .Notes = txtNotes.Text
                rtValue = .AddUrl()
            End With
            If rtValue = 0 Then
                Response.Redirect("SSLHome.aspx")
            ElseIf rtValue = 1 Then
                Response.Redirect("SSLHome.aspx")
            ElseIf rtValue = 2 Then
                lblErrorMessage.Text = "URL has already added. Please choose different."
                lblErrorMessage.Visible = True
            End If

        Catch ex As Exception

            'CtrlAlertdiv.HeaderText = "Error Occured"
            'CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
            'l_Errortext = "Unable to add new URL. Following error occured" & vbCrLf & ex.ToString
        End Try
        'CtrlAlertdiv.DetialInfo = l_Errortext
        'CtrlAlertdiv.Visible = True
        'CtrlAlertdiv.Visibility = True

        'grdURLs.DataSourceID = "srcURLs"
        'grdURLs.DataBind()
    End Sub

    Private Sub ClearAllFields()
        ddlAccount1.SelectedValue = "0"
        ddlRegistrar1.SelectedValue = "0"
        ddlCategory1.SelectedValue = "0"
        txtURL.Text = ""
        txtExpirydate.Text = ""
        txtnameServer1.Text = ""
        txtNameServer2.Text = ""
        txtreferralURL.Text = ""
        txtWhoisServer.Text = ""
    End Sub

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Request.QueryString("SSLID")) = False AndAlso IsNumeric(Request.QueryString("SSLID")) Then
                hdnURLID.Value = HttpContext.Current.Request.QueryString("SSLID").ToString()
                lblTitle.Text = " Edit SSL "
                btnSave.Text = "Update"
            Else
                lblTitle.Text = " New SSL "
                btnSave.Text = "Save"
            End If
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not IsPostBack AndAlso CInt(hdnURLID.Value) <> 0 Then
            Dim objURLm As New SSLM
            objURLm = SSLM.GetUrlByID(CInt(hdnURLID.Value))
            txtURL.Text = objURLm.URL
            Dim Item As ListItem = ddlAccount1.Items.FindByValue(objURLm.AccountId)
            If Item Is Nothing Then
                ddlAccount1.SelectedValue = "0"
            Else
                ddlAccount1.SelectedValue = objURLm.AccountId
                Item = Nothing
            End If

            Item = ddlRegistrar1.Items.FindByValue(objURLm.RegistrarId)
            If Item Is Nothing Then
                ddlRegistrar1.SelectedValue = "0"
            Else
                ddlRegistrar1.SelectedValue = objURLm.RegistrarId
                Item = Nothing
            End If

            Item = ddlCategory1.Items.FindByValue(objURLm.CategoryId)
            If Item Is Nothing Then
                ddlCategory1.SelectedValue = "0"
            Else
                ddlCategory1.SelectedValue = objURLm.CategoryId
                Item = Nothing
            End If
            Item = ddlCountry.Items.FindByValue(objURLm.CountryID)
            If Item Is Nothing Then
                ddlCountry.SelectedValue = "0"
            Else
                ddlCountry.SelectedValue = objURLm.CountryID
                Item = Nothing
            End If

            txtExpirydate.Text = objURLm.ExpirationDate
            txtnameServer1.Text = objURLm.NameServer1
            txtNameServer2.Text = objURLm.NameServer2
            txtWhoisServer.Text = objURLm.WhoisServer
            txtreferralURL.Text = objURLm.ReferralUrl
            txtRegistration.Text = IIf(objURLm.RegistrationDate = Date.MinValue, String.Empty, objURLm.RegistrationDate.ToShortDateString())
            txtActivationDate.Text = IIf(objURLm.ActivationDate = Date.MinValue, String.Empty, objURLm.ActivationDate.ToShortDateString())
            txtNotes.Text = objURLm.Notes
        End If
    End Sub
End Class