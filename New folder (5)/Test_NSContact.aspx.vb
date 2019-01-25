Partial Class Test_NSContact
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If IsPostBack = False Then
            ' InitPage()
        End If
    End Sub
    'Private Sub InitPage()
    '    Dim browser As String = Request.Browser.Browser
    '    If browser.Equals("IE") Then
    '        ddlCountry.CssClass = "dd_list_ie"
    '        ddlState.CssClass = "dd_list_ie"
    '    Else
    '        ddlCountry.CssClass = "dd_list_others"
    '        ddlState.CssClass = "dd_list_others"
    '    End If
    '    ddlCountry.SelectedValue = 161
    '    txtState.Attributes.Add("style", "display:inline;")
    '    ddlState.Attributes.Add("style", "display:none;")

    '    ddlCountry.DataTextField = "Name"
    '    ddlCountry.DataValueField = "ID"
    '    ddlCountry.DataSource = Netsolace.ContactUs.GetCountries()
    '    ddlCountry.DataBind()
    'End Sub

    Protected Sub FormSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormSubmit.Click
        Dim StateCode As String = String.Empty
        Dim State As String = String.Empty
        Dim showSuccess As String
        Dim strMessage As String = String.Empty
        Dim fullName As String = txtFullName.Text.Trim
        Dim CompanyName As String = String.Empty
        If Not String.IsNullOrEmpty(txtCompanyName.Text.Trim()) Then
            CompanyName = txtCompanyName.Text.Trim()
        End If
        Dim Address As String = String.Empty
        Dim PhoneNumber As String = txtPhoneNumber.Text.Trim
        Dim BestTime As String = txtBestTimeToCall.Text.Trim()
        Dim EmailAddress As String = txtEmailAddress.Text.Trim
        Dim Subject As String = txtMessageSubject.Text.Trim
        Dim Message As String = txtFullMessage.Text.Trim
        Dim CountryCode As String = txtCountryCode.Text
        StateCode = txtStateCode.Text
        State = txtState.Text

        Dim ZipCode As String = txtZipCode.Text.Trim
        Dim City As String = String.Empty
        Dim obj As New NSContactService.NSContact()
        ' calling service method
        Dim response As Integer = obj.NS_AddContactUs(fullName, CompanyName, PhoneNumber, EmailAddress, Subject, Message, Address, BestTime, CountryCode, StateCode, State, ZipCode, City)
        If (response = 1) Then
            showSuccess = "Contact Added Succefully"
            lblSuccess.InnerHtml = showSuccess
        End If

    End Sub
End Class
