Partial Class Admin_UsersNew
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub ddlCountry_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    Protected Sub ddlDeparments_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDeparments.DataBound
        ddlDeparments.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    Protected Sub ddlTeams_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTeams.DataBound
        ddlTeams.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    Protected Sub ddlOfficess_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlOfficess.DataBound
        ddlOfficess.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    Protected Sub ddlTimeZone_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTimeZone.DataBound
        ddlTimeZone.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim objMyUser As New Portal.BLL.Users
        Dim MailAccess As Boolean = False
        If Page.IsValid Then

            objMyUser.Firstname = txtFirstName.Text.Trim
            objMyUser.Middlename = txtMiddleName.Text.Trim
            objMyUser.Lastname = txtLastName.Text.Trim
            objMyUser.UserName = txtUserName.Text.Trim
            objMyUser.Password = Functions.GeneratePassword(6, 6)
            objMyUser.JobTitle = txtJobtitle.Text.Trim
            objMyUser.Ssn = Functions.EncryptData(txtSSN.Text.Trim)

            objMyUser.Email = txtEmail.Text.Trim
            objMyUser.Address = txtAddress.Text.Trim
            objMyUser.City = txtCity.Text.Trim
            objMyUser.Region = ""
            objMyUser.Zip = txtZip.Text.Trim
            objMyUser.HomePhone = txtHomePhone.Text.Trim
            objMyUser.WorkPhone = txtWorkPhone.Text.Trim
            objMyUser.CellPhone = txtCellPhone.Text.Trim
            objMyUser.Fax = txtFax.Text.Trim
            objMyUser.CountryID = Me.ddlCountry.SelectedValue
            objMyUser.StateID = Me.ddlStates.SelectedValue
            objMyUser.DOB = Me.txtDOB.Text
            objMyUser.HiringDate = Me.txtHiringDate.Text
            objMyUser.RFID = Me.txtRFID.Text
            objMyUser.PersonalEmail = txtPersonalEmail.Text
            objMyUser.ChangePasswordAccess = chkAllowChangePassword.Checked
            objMyUser.OffSaturdayGroup = Me.ddlOffSaturdayGroup.SelectedValue
            objMyUser.RemoteUser = Me.chkRemoteUser.Checked
            objMyUser.IsEmailWorking = Me.chkIsEmailWorking.Checked
            If Me.chkRemoteUser.Checked = False Then
                objMyUser.IP = txtIP.Text.Trim()
                objMyUser.IP2 = txtIP2.Text.Trim()
            End If

            If chkNewEmailAccount.Checked = True Then
                Dim Password As String = String.Empty
                Password = Functions.GeneratePassword(6, 6)

                If txtEmail.Text.ToString.EndsWith("netsolace.com.pk") Then
                    If objMyUser.CreateDippedFruitAccount(txtEmail.Text, Password, ddlStates.SelectedItem.Text, ddlCountry.SelectedItem.Text) = 1 Then
                        objMyUser.FranMail_UserName = txtEmail.Text
                        objMyUser.FranMail_Password = Password
                        objMyUser.Insert_googleAccount(False)
                        MailAccess = True
                    Else
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "DoFruitUserAlert ", "alert('New Account cannot be created.');EnableCancelButton();", True)
                        Exit Sub
                    End If
                ElseIf txtEmail.Text.ToString.EndsWith("netsolace.com") Then
                    If objMyUser.CreateUser_OnGoogle(txtEmail.Text, Password) = True Then
                        objMyUser.FranMail_UserName = txtEmail.Text
                        objMyUser.FranMail_Password = Password
                        objMyUser.Insert_googleAccount(False)
                        MailAccess = True
                    Else
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "GoogleUserAlert ", "alert('New Account cannot be created.');EnableCancelButton();", True)
                        Exit Sub
                    End If
                End If
            End If
            objMyUser.OfficeTimingProfileID = ddlProfiles.SelectedValue
            objMyUser.Deleted = False
            objMyUser.Inactive = False
            objMyUser.TimeZoneID = Me.ddlTimeZone.SelectedValue
            objMyUser.IsTimeExampted = Me.chkTimeExampted.Checked
            objMyUser.Gender = Me.rbtlstGender.SelectedValue
            objMyUser.DepartmentID = Me.ddlDeparments.SelectedValue
            objMyUser.TeamID = Me.ddlTeams.SelectedValue
            objMyUser.OfficeID = Me.ddlOfficess.SelectedValue
            objMyUser.Type = Portal.BLL.Enumeration.UsersType.Portal
            'Dim Affected As Integer = objMyUser.InsertUser(objMyUser.Firstname, objMyUser.Middlename, objMyUser.Lastname, objMyUser.UserName, objMyUser.Ssn, objMyUser.IP, objMyUser.IP2, objMyUser.JobTitle, _
            '                                objMyUser.Email, objMyUser.Address, objMyUser.City, objMyUser.Zip, objMyUser.CountryID, objMyUser.StateID, objMyUser.HomePhone, _
            '                                objMyUser.WorkPhone, objMyUser.CellPhone, objMyUser.Fax, objMyUser.TimeZoneID, objMyUser.Gender, objMyUser.HiringDate, _
            '                                objMyUser.DOB, objMyUser.DepartmentID, objMyUser.TeamID, objMyUser.OfficeID, objMyUser.RemoteUser, objMyUser.IsTimeExampted, objMyUser.Type, objMyUser.RFID)
            Dim Affected = objMyUser.InsertUser

            If Affected > 1 Then
                Portal.BLL.HR.OffSaturdayGroupsLogs.AddUserToOffSaturdayGroupLogs(Affected, DateTime.Now, objMyUser.OffSaturdayGroup)
                If MailAccess = True Then
                    objMyUser.FranMail_UserAccess(Affected)
                End If
                objMyUser.SendWebMailAccess(txtFirstName.Text, txtUserName.Text.Trim, objMyUser.Password, "Netsolace Portal", txtEmail.Text, txtPersonalEmail.Text)
                Response.Redirect("Users.aspx")
            ElseIf Affected = 1 Then
                lblErrorMessage.Text = "<b>'" & objMyUser.UserName & "'</b> Already Exists. Please Enter Different User Name"
                txtUserName.Focus()
            End If
        End If
    End Sub

    
   
End Class