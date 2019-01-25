Imports System.Data
Imports System.Collections.Generic
Partial Class MyNetsolace_ClientContactNewUser
    Inherits System.Web.UI.Page
    Dim Clientsid As Integer
    Dim StateID As Integer

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("UserID")) Then
                txtUserName.ReadOnly = True
            End If

            btnback.Attributes.Add("onclick", "javascript:window.location='ClientContactUser.aspx?" & Request.QueryString().ToString() & "'; return false;")

            hdnHasMarkTicketForApprovalByClientId.Value = Portal.DAL.Client.DBClients.HasMarkTicketForApprovalByClientId(Session("Mynetsolace_ClientId"))

            If String.IsNullOrEmpty(Request.QueryString("UserID")) = False AndAlso IsNumeric(Request.QueryString("UserID")) Then
                hdnUserID.Value = Request.QueryString("UserID") ' Edit Mode Enabled
                lblDisplayHeader.Text = "Edit User"
                LoadClientContact()
                UpdateStatusValues()
            Else
                hdnUserID.Value = 0
                Btnactive.Attributes.Add("style", "display:none;")
                BtnInactive.Attributes.Add("style", "display:none;")
                lblDisplayHeader.Text = "New User"
            End If
            txtFirstName.Focus()
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not IsPostBack AndAlso StateID > 0 Then
            ddlStates.SelectedValue = StateID
        End If
    End Sub

    Protected Sub ddlCountry_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        Dim objMyUser As New Portal.BLL.Client.Client_Contacts

        If Page.IsValid Then
            If hdnUserID.Value = 0 Then   'Add New Client Contact
                objMyUser.ClientID = CInt(HttpContext.Current.Session("MyNetsolace_ClientID"))
                objMyUser.AdminID = CInt(HttpContext.Current.Session("AdminID"))
                objMyUser.AreaDeveloperID = Session("MyNetsolace_AreaDeveloperID")
                objMyUser.ContactID = 0
                objMyUser.FirstName = txtFirstName.Text.Trim
                objMyUser.MiddleName = txtMiddleName.Text.Trim
                objMyUser.LastName = txtLastName.Text.Trim
                objMyUser.Gender = ddlGender.SelectedValue
                objMyUser.UserName = txtUserName.Text.Trim
                objMyUser.JobTitle = txtJobtitle.Text.Trim
                objMyUser.HomePhone = txtHomePhone.Text.Trim
                objMyUser.WorkPhone = txtWorkPhone.Text.Trim
                objMyUser.CellPhone = txtCellPhone.Text.Trim
                objMyUser.Fax = txtFax.Text.Trim
                objMyUser.Email1 = txtEmail.Text.Trim
                objMyUser.Email2 = txtEmail2.Text.Trim
                objMyUser.Address = txtAddress.Text.Trim
                objMyUser.Address2 = txtAddress2.Text.Trim
                objMyUser.City = txtCity.Text.Trim
                objMyUser.Zip = txtZip.Text.Trim
                objMyUser.StateID = Me.ddlStates.SelectedValue
                objMyUser.CountryID = Me.ddlCountry.SelectedValue
                objMyUser.ContactType = Portal.BLL.Enumeration.UsersType.Portal
                objMyUser.Deleted = False
                objMyUser.HasPMFullAccess = chkHasPMFullAccess.Checked
                objMyUser.HasTicketApprovalAccess = chkHasTicketApprovalAccess.Checked
                objMyUser.Inactive = False ' By default Active
                objMyUser.LastUpdatedDate = DateTime.Now
                objMyUser.LastUpdatedBy = CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID"))
                objMyUser.IsAdmin = Me.ddlUserType.SelectedValue
                objMyUser.UserName = txtUserName.Text.Trim
                objMyUser.PassWord = Portal.BLL.Users.GenerateNewPassWord()					
			    objMyUser.HasURLMAccess = False
                Dim Affected As Integer = Portal.DAL.Client.DBClient_Contacts.Add(objMyUser)
                If Affected = -101 Then
                    lblErrorMessage.Text = "User Name <b>'" & objMyUser.UserName & "'</b> Already Exists."
                    txtUserName.Focus()
                Else
                    hdnUserID.Value = Affected
                    SenEmailToClientContact(objMyUser.PassWord)
                    Response.Redirect("ClientContactUser.aspx")
                End If
            ElseIf hdnUserID.Value <> 0 Then   ' Edit Client Contact
                objMyUser.ID = hdnUserID.Value
                'objMyUser.ClientID = Me.ddlUser.SelectedValue
                objMyUser.ClientID = CInt(HttpContext.Current.Session("MyNetsolace_ClientID"))
                objMyUser.AdminID = CInt(HttpContext.Current.Session("AdminID"))
                objMyUser.AreaDeveloperID = Session("MyNetsolace_AreaDeveloperID")
                objMyUser.ContactID = 0
                objMyUser.FirstName = txtFirstName.Text.Trim
                objMyUser.MiddleName = txtMiddleName.Text.Trim
                objMyUser.LastName = txtLastName.Text.Trim
                objMyUser.Gender = ddlGender.SelectedValue
                objMyUser.UserName = txtUserName.Text.Trim
                objMyUser.JobTitle = txtJobtitle.Text.Trim
                objMyUser.HomePhone = txtHomePhone.Text.Trim
                objMyUser.WorkPhone = txtWorkPhone.Text.Trim
                objMyUser.CellPhone = txtCellPhone.Text.Trim
                objMyUser.Fax = txtFax.Text.Trim
                objMyUser.Email1 = txtEmail.Text.Trim
                objMyUser.Email2 = txtEmail2.Text.Trim
                objMyUser.Address = txtAddress.Text.Trim
                objMyUser.Address2 = txtAddress2.Text.Trim
                objMyUser.City = txtCity.Text.Trim
                objMyUser.Zip = txtZip.Text.Trim
                objMyUser.StateID = Me.ddlStates.SelectedValue
                objMyUser.CountryID = Me.ddlCountry.SelectedValue
                objMyUser.ContactType = Portal.BLL.Enumeration.UsersType.Portal
                objMyUser.Deleted = False
                objMyUser.HasPMFullAccess = chkHasPMFullAccess.Checked
                objMyUser.HasTicketApprovalAccess = chkHasTicketApprovalAccess.Checked
                'objMyUser.Inactive = Me.ddlStatus.SelectedValue
                objMyUser.LastUpdatedDate = DateTime.Now
                objMyUser.LastUpdatedBy = CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID"))
                objMyUser.IsAdmin = Me.ddlUserType.SelectedValue
                objMyUser.UserName = txtUserName.Text.Trim
                objMyUser.HasURLMAccess = False
                Dim Affected As Integer = Portal.DAL.Client.DBClient_Contacts.Update(objMyUser)
                If Affected = -101 Then
                    lblErrorMessage.Text = "User Name <b>'" & objMyUser.UserName & "'</b> Already Exists."
                    txtUserName.Focus()
                Else
                    Response.Redirect("ClientContactUser.aspx?" & Request.QueryString().ToString())
                End If
            End If
        End If
    End Sub
    Private Sub SenEmailToClientContact(ByVal Password As String)
        Dim CC As New Portal.BLL.Client.Client_Contacts
        Dim FullName As String = txtFirstName.Text.Trim & " " & txtLastName.Text.Trim
        CC.SendWebMailAccess(FullName, txtUserName.Text.Trim, Password, "Welcome to Mynetsolace", "<br/ > It is a pleasure to welcome you on Mynetsolace.", txtEmail.Text.Trim, txtEmail2.Text.Trim, Session("MyNetsolace_ClientContactEmail"), Session("MyNetsolace_ClientContactName"))

    End Sub
    Private Sub LoadClientContact()
        Dim colClient_Contacts As New List(Of Portal.BLL.Client.Client_Contacts)
        colClient_Contacts = Portal.BLL.Client.Client_Contacts.Client_ContactsGetByID(CType(hdnUserID.Value, Integer))
        If colClient_Contacts.Count > 0 Then
            txtFirstName.Text = colClient_Contacts.Item(0).FirstName
            txtMiddleName.Text = colClient_Contacts.Item(0).MiddleName
            txtLastName.Text = colClient_Contacts.Item(0).LastName
            ddlGender.SelectedValue = colClient_Contacts.Item(0).Gender
            txtJobtitle.Text = colClient_Contacts.Item(0).JobTitle
            txtHomePhone.Text = colClient_Contacts.Item(0).HomePhone
            txtWorkPhone.Text = colClient_Contacts.Item(0).WorkPhone
            txtCellPhone.Text = colClient_Contacts.Item(0).CellPhone
            txtAddress.Text = colClient_Contacts.Item(0).Address
            txtAddress2.Text = colClient_Contacts.Item(0).Address2
            txtFax.Text = colClient_Contacts.Item(0).Fax
            txtEmail.Text = colClient_Contacts.Item(0).Email1
            txtEmail2.Text = colClient_Contacts.Item(0).Email2
            txtCity.Text = colClient_Contacts.Item(0).City
            txtZip.Text = colClient_Contacts.Item(0).Zip
            ddlStatus.SelectedValue = colClient_Contacts.Item(0).Inactive
            ddlUserType.SelectedValue = colClient_Contacts.Item(0).IsAdmin
            ddlCountry.DataBind()
            ddlCountry.SelectedValue = colClient_Contacts.Item(0).CountryID
            ddlStates.DataBind()
            StateID = colClient_Contacts.Item(0).StateID
            txtUserName.Text = colClient_Contacts.Item(0).UserName
            lblUserName.Visible = False
            lblUserName.Text = "(" + colClient_Contacts.Item(0).FirstName + " " + colClient_Contacts.Item(0).LastName + ")"
            LbtnResetPassword.Visible = True
            chkHasPMFullAccess.Checked = colClient_Contacts.Item(0).HasPMFullAccess
            chkHasTicketApprovalAccess.Checked = colClient_Contacts.Item(0).HasTicketApprovalAccess
            'ltrlReason.Text = colClient_Contacts.Item(0).Notes
            'lblStatusChangedBy.Text = colClient_Contacts.Item(0).StatusChangedBy
            'lblStatusChangedDate.Text = colClient_Contacts.Item(0).StatusChangedDate
            'hdnIsInactive.Value = colClient_Contacts.Item(0).Status
        End If
    End Sub

    Protected Sub btnUpdateUserStatus_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpdateUserStatus.Click
        Dim Status As Boolean
        If BtnInactive.Visible = True Then
            Status = False
        Else
            Status = True
        End If
        If Request.QueryString("UserID") Is Nothing = False Then
            Portal.BLL.Client.Client_Contacts.ClientContact_InsertNotes(CInt(Request.QueryString("UserID")), Status, txtUserStatus.Text.ToString())
            Portal.BLL.Client.Client_Contacts.ResetStatus(CInt(Request.QueryString("UserID")), Status)
            UpdateStatusValues()
        End If
    End Sub

    Private Sub UpdateStatusValues()
        If Request.QueryString("UserID") <> String.Empty AndAlso IsNumeric(Request.QueryString("UserID")) Then
            UserID.Value = Request.QueryString("UserID")
            Dim objUsersBll As Portal.BLL.Client.Client_Contacts = New Portal.BLL.Client.Client_Contacts()
            Dim objClientContactNotes As New Portal.BLL.Client.ClientContactNotes
            Dim Status As Boolean
            objClientContactNotes = Portal.BLL.Client.Client_Contacts.ClientsContactsGetNotes(CType(hdnUserID.Value, Integer))

            ltrlReason.Text = objClientContactNotes.Notes
            lblStatusChangedBy.Text = objClientContactNotes.ChangedBy
            lblStatusChangedDate.Text = objClientContactNotes.ChangedDate

            Status = objUsersBll.GetUserStatusByID(UserID.Value)
            If Status = True Then
                BtnInactive.Visible = True
                Btnactive.Visible = False
                txtUserStatus.Text = ""
                trInactiveHold.Visible = True
            Else
                Btnactive.Visible = True
                BtnInactive.Visible = False
                txtUserStatus.Text = ""
                trInactiveHold.Visible = False
            End If
        End If

    End Sub

    Protected Sub LbtnResetPassword_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LbtnResetPassword.Click
        Dim Password As String = Portal.BLL.Users.GenerateNewPassWord()
        Portal.BLL.Client.Client_Contacts.ResetPassword(CInt(Request.QueryString("UserID")), Password)
        Dim CC As New Portal.BLL.Client.Client_Contacts
        Dim FullName As String = txtFirstName.Text.Trim & " " & txtLastName.Text.Trim
        CC.SendWebMailAccess(FullName, txtUserName.Text.Trim, Password, "Request for Password reset.", "As per your request your Mynetsolace password has been reset.", txtEmail.Text.Trim, txtEmail2.Text.Trim, Session("MyNetsolace_ClientContactEmail"), Session("MyNetsolace_ClientContactName"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ResetPassword ", "alert('Password has been reset and mail has been send to user.');", True)
    End Sub
End Class