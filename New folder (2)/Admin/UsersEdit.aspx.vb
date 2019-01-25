Imports System.Collections.Generic
Imports Microsoft.VisualBasic
Imports System.Data
Imports Portal.BLL.Users
Imports System.Data.SqlClient

Partial Class Admin_UsersEdit
    Inherits System.Web.UI.Page
    Dim colUsers As New List(Of Portal.BLL.Users)()
    Private dsMSM As DataSet
    Dim Clientsid As Integer
    Dim ModuleID As Integer
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If HttpContext.Current.Request.QueryString("UserID") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("UserID")) Then
                ShowInActiveValues()
                Me.ddlTimeZone.DataBind()
                LoadUser()
                FillClients()
                FillModulesSubModules()
                tvAccess.CollapseAll()
                ShowHideFranMailAccount()
            End If
            tvAccess.Attributes.Add("onclick", "OnTreeClick(event);")
        End If
    End Sub

    Private Sub ShowInActiveValues()
        If HttpContext.Current.Request.QueryString("UserID") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("UserID")) Then
            UserID.Value = Request.QueryString("UserID")
            Dim objUsersBll As Portal.BLL.Users = New Portal.BLL.Users()
            objUsersBll.GetUserNotesByID(UserID.Value)
            If objUsersBll.StatusChangeBy <> "" Then
                lblStatusChangedBy.Text = Functions.StringTruncate(objUsersBll.StatusChangeBy, 45)
                lblStatusChangedDate.Text = Format(objUsersBll.StatusChangedDate, "MM/dd/yyyy")
                ltrlReason.Text = objUsersBll.StatusNotes.Replace(vbCrLf, "<br/>")
            End If

        End If
    End Sub
    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not IsPostBack Then
            Me.ddlStates.SelectedValue = colUsers.Item(0).StateID
            Me.ddlDeparments.SelectedValue = colUsers.Item(0).DepartmentID
            Me.ddlTeams.SelectedValue = colUsers.Item(0).TeamID
            Me.ddlOfficess.SelectedValue = colUsers.Item(0).OfficeID
        End If
    End Sub
    Private Sub LoadUser()
        Dim objUsersBll As Portal.BLL.Users = New Portal.BLL.Users()
        Dim status As Boolean
        colUsers = Portal.BLL.Users.GetUsersByID(CType(Me.UserID.Value, Integer))
        Me.txtFirstName.Text = colUsers.Item(0).Firstname
        Me.txtMiddleName.Text = colUsers.Item(0).Middlename
        Me.txtLastName.Text = colUsers.Item(0).Lastname
        Me.txtUserName.Text = colUsers.Item(0).UserName
        Me.txtSSN.Text = Functions.DecryptData(colUsers.Item(0).Ssn)
        Me.txtJobtitle.Text = colUsers.Item(0).JobTitle
        Me.txtEmail.Text = colUsers.Item(0).Email
        Me.ddlProfiles.SelectedValue = colUsers.Item(0).OfficeTimingProfileID
        Me.ddlOffSaturdayGroup.SelectedValue = colUsers.Item(0).OffSaturdayGroup
        Me.hdnOffSaturdayGroupType.Value = colUsers.Item(0).OffSaturdayGroup
        Me.txtAddress.Text = colUsers.Item(0).Address
        Me.txtCity.Text = colUsers.Item(0).City
        Me.txtZip.Text = colUsers.Item(0).Zip
        Me.txtJobtitle.Text = colUsers.Item(0).JobTitle
        Me.ddlCountry.SelectedValue = colUsers.Item(0).CountryID
        Me.txtRFID.Text = colUsers.Item(0).RFID

        'Me.ddlStates.SelectedValue = colUsers.Item(0).StateID
        Me.txtHomePhone.Text = colUsers.Item(0).HomePhone
        Me.txtWorkPhone.Text = colUsers.Item(0).WorkPhone
        Me.txtCellPhone.Text = colUsers.Item(0).CellPhone
        Me.txtFax.Text = colUsers.Item(0).Fax

        Me.txtDOB.Text = colUsers.Item(0).DOB
        Me.txtHiringDate.Text = colUsers.Item(0).HiringDate

        Me.chkChangePasswordAccess.Checked = colUsers.Item(0).ChangePasswordAccess
        Me.txtPersonalEmail.Text = colUsers.Item(0).PersonalEmail

        Me.chkRemoteUser.Checked = colUsers.Item(0).RemoteUser
        Me.chkIsEmailWorking.Checked = colUsers.Item(0).IsEmailWorking
        If colUsers.Item(0).RemoteUser = False Then
            Me.trIps.Attributes.Add("Style", "display:inline")
            Me.txtIP.Attributes.Add("Style", "display:inline")
            Me.txtIP2.Attributes.Add("Style", "display:inline")
            Me.lblIP.Attributes.Add("Style", "display:inline")
            Me.lblIP2.Attributes.Add("Style", "display:inline")
            Me.txtIP.Text = colUsers.Item(0).IP
            Me.txtIP2.Text = colUsers.Item(0).IP2
        Else
            Me.trIps.Attributes.Add("Style", "display:none")
            Me.txtIP.Attributes.Add("Style", "display:none")
            Me.txtIP2.Attributes.Add("Style", "display:none")
            Me.lblIP.Attributes.Add("Style", "display:none")
            Me.lblIP2.Attributes.Add("Style", "display:none")
        End If
        Me.ddlTimeZone.SelectedValue = colUsers.Item(0).TimeZoneID
        Me.chkTimeExampted.Checked = colUsers.Item(0).IsTimeExampted
        Me.rbtlstGender.SelectedValue = colUsers.Item(0).Gender

        lblEmailAddress.Text = Portal.BLL.Users.GetUsersEmail_ByID(CType(Me.UserID.Value, Integer))
        If lblEmailAddress.Text <> String.Empty Then
            If lblEmailAddress.Text.EndsWith("@netsolace.com") Then
                Me.ltrlChangePasswordCaption.Visible = True
                Me.spnChangePassword.Attributes.Add("Style", "display:inline")
            End If
        Else
            lblEmailAddress.Text = "N/A"
        End If

        If colUsers.Item(0).Middlename.ToString = "" Then
            lblUserName.Text = colUsers.Item(0).Firstname + " " + colUsers.Item(0).Lastname
            lblUserName2.Text = lblUserName.Text
        Else
            lblUserName.Text = colUsers.Item(0).Firstname + " " + colUsers.Item(0).Middlename.ToString + " " + colUsers.Item(0).Lastname
            lblUserName2.Text = lblUserName.Text
        End If

        status = colUsers.Item(0).Inactive

        If status = True Then
            lnkBtnStatus.InnerText = "Active"
            hdnStatus.Value = "Active"
            trInactiveHold.Visible = True
            spnResetPassword.Disabled = True
            btnSave.Enabled = False
        Else
            hdnStatus.Value = "InActive"
            lnkBtnStatus.InnerText = "InActive"
            trInactiveHold.Visible = False
            spnResetPassword.Disabled = False
            btnSave.Enabled = True
        End If


        'Me.ddlDeparments.SelectedValue = colUsers.Item(0).DepartmentID///
        'Me.ddlTeams.SelectedValue = colUsers.Item(0).TeamID//////////////   Page_PreRenderComplete
        'Me.ddlOfficess.SelectedValue = colUsers.Item(0).OfficeID/////////

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
        If Page.IsValid Then
            objMyUser.ID = UserID.Value
            objMyUser.Firstname = txtFirstName.Text.Trim
            objMyUser.Middlename = txtMiddleName.Text.Trim
            objMyUser.Lastname = txtLastName.Text.Trim
            objMyUser.UserName = txtUserName.Text.Trim
            objMyUser.JobTitle = txtJobtitle.Text.Trim
            objMyUser.Ssn = txtSSN.Text.Trim

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
            objMyUser.RFID = txtRFID.Text
            objMyUser.ChangePasswordAccess = chkChangePasswordAccess.Checked
            objMyUser.PersonalEmail = txtPersonalEmail.text
            objMyUser.RemoteUser = Me.chkRemoteUser.Checked
            If Me.chkRemoteUser.Checked = False Then
                objMyUser.IP = txtIP.Text.Trim()
                objMyUser.IP2 = txtIP2.Text.Trim()
            End If
            objMyUser.Deleted = False
            objMyUser.Inactive = False
            objMyUser.TimeZoneID = Me.ddlTimeZone.SelectedValue
            objMyUser.IsTimeExampted = Me.chkTimeExampted.Checked
            objMyUser.Gender = Me.rbtlstGender.SelectedValue
            objMyUser.DepartmentID = Me.ddlDeparments.SelectedValue
            objMyUser.TeamID = Me.ddlTeams.SelectedValue
            objMyUser.OfficeID = Me.ddlOfficess.SelectedValue
            objMyUser.Type = Portal.BLL.Enumeration.UsersType.Portal
            objMyUser.OfficeTimingProfileID = ddlProfiles.SelectedValue
            objMyUser.OffSaturdayGroup = Me.ddlOffSaturdayGroup.SelectedValue
            objMyUser.IsEmailWorking = Me.chkIsEmailWorking.Checked
            Dim Affected As Integer = Portal.BLL.Users.Update(objMyUser.ID, objMyUser.Firstname, objMyUser.Middlename, objMyUser.Lastname, objMyUser.UserName, objMyUser.Ssn, objMyUser.IP, objMyUser.IP2, objMyUser.JobTitle, _
                                            objMyUser.Email, objMyUser.Address, objMyUser.City, objMyUser.Zip, objMyUser.CountryID, objMyUser.StateID, objMyUser.HomePhone, _
                                            objMyUser.WorkPhone, objMyUser.CellPhone, objMyUser.Fax, objMyUser.TimeZoneID, objMyUser.Gender, objMyUser.HiringDate, _
                                            objMyUser.DOB, objMyUser.DepartmentID, objMyUser.TeamID, objMyUser.OfficeID, objMyUser.RemoteUser, objMyUser.IsTimeExampted, objMyUser.Type, objMyUser.RFID, objMyUser.ChangePasswordAccess, objMyUser.PersonalEmail, objMyUser.OfficeTimingProfileID, objMyUser.OffSaturdayGroup, objMyUser.IsEmailWorking)
            If Affected > 0 Then
                If hdnOffSaturdayGroupType.Value <> objMyUser.OffSaturdayGroup Then
                    Portal.BLL.HR.OffSaturdayGroupsLogs.AddUserToOffSaturdayGroupLogs(objMyUser.ID, DateTime.Now, objMyUser.OffSaturdayGroup)
                End If
                UpdateAccess()
            ElseIf Affected = -101 Then
                lblErrorMessage.Text = "<b>'" & objMyUser.UserName & "'</b>Already Exists. Please Enter Different User Name"
                txtUserName.Focus()
            End If
        End If

    End Sub

    Private Sub UpdateAccess()

        Dim strClientSubModuleID As String = GetClientSubModuleID()
        Dim objUserBll As Portal.BLL.Users = New Portal.BLL.Users
        objUserBll.UsersAccess_Delete(CType(UserID.Value, Integer))

        If strClientSubModuleID <> "" Then
            Dim strSQL As String = " INSERT INTO UserClientSubModule (ClientSubModuleID,UserID) " & _
                                   " ( SELECT ID, " & UserID.Value & " FROM ClientsSubModules WHERE ID IN (" & strClientSubModuleID & ") " & _
                                   GetModulestr() & _
                                    " ) "
            If objUserBll.UsersAccess_Insert(strSQL) > 0 Then
                Response.Redirect("Users.aspx")
            End If
        ElseIf GetModulestr() <> "" Then
            Dim strSQL As String = " INSERT INTO UserClientSubModule (ClientSubModuleID,UserID) " & _
                                   " ( " & _
                                    GetModulestr().Remove(0, 6) & _
                                    " ) "
            If objUserBll.UsersAccess_Insert(strSQL) > 0 Then
                Response.Redirect("Users.aspx")
            End If
        Else
            Response.Redirect("Users.aspx")
        End If
    End Sub
    Private Function GetModuleID(ByVal strclientID As String) As String
        Dim strRetModuleID As String = ""
        For i As Integer = 0 To tvAccess.Nodes.Count - 1 Step 1 'Clients'
            If tvAccess.Nodes(i).Value.ToString() = strclientID Then
                For j As Integer = 0 To tvAccess.Nodes(i).ChildNodes.Count - 1 Step 1 'Modules'
                    If tvAccess.Nodes(i).ChildNodes(j).ChildNodes.Count = 0 Then      'SubModules'
                        If tvAccess.Nodes(i).ChildNodes(j).Checked Then
                            strRetModuleID += " , " & tvAccess.Nodes(i).ChildNodes(j).Value.ToString()
                        End If
                    End If
                Next
            End If
        Next
        If strRetModuleID <> "" Then
            strRetModuleID = strRetModuleID.Remove(0, 2)
        End If

        Return strRetModuleID
    End Function
    Private Function GetModulestr() As String
        Dim strModule As String = ""
        Dim strGetModuleID As String = ""
        For i As Integer = 0 To tvAccess.Nodes.Count - 1 Step 1 'Clients'
            strGetModuleID = GetModuleID(tvAccess.Nodes(i).Value.ToString())
            If strGetModuleID <> "" Then
                strModule += " Union " & _
                            " SELECT ClientsSubModules.[ID] , " & UserID.Value & " " & _
                            " FROM ClientsSubModules " & _
                            " WHERE SubModuleID in ( " & _
                                                " SELECT [ID] AS SubModuleID FROM SubModules WHERE ModuleID IN ( " & strGetModuleID & " ) " & _
                                                " ) " & _
                            " AND ClientID = " & tvAccess.Nodes(i).Value.ToString() & " "
            End If
        Next

        Return strModule
    End Function


    Private Function GetClientSubModuleID() As String
        Dim strClientSubModuleIDs As String = ""
        For i As Integer = 0 To tvAccess.Nodes.Count - 1 Step 1 'Clients'
            For j As Integer = 0 To tvAccess.Nodes(i).ChildNodes.Count - 1 Step 1 'Modules'
                For k As Integer = 0 To tvAccess.Nodes(i).ChildNodes(j).ChildNodes.Count - 1 Step 1 'SubModules'
                    If tvAccess.Nodes(i).ChildNodes(j).ChildNodes(k).Checked Then
                        strClientSubModuleIDs += " , " & tvAccess.Nodes(i).ChildNodes(j).ChildNodes(k).Value.ToString()
                    End If
                Next
            Next
        Next
        If strClientSubModuleIDs <> "" Then
            strClientSubModuleIDs = strClientSubModuleIDs.Remove(0, 2)
        End If

        Return strClientSubModuleIDs
    End Function
    Protected Sub FillClients()
        Dim objUsersBll As Portal.BLL.Users = New Portal.BLL.Users()
        Dim strClinets As String(,) = objUsersBll.GetClients()

        For i As Integer = 0 To strClinets.GetUpperBound(0) - 1 Step 1
            Dim newNode As New TreeNode("<span onclick=""return false;"">" & strClinets(i, 1).ToString() & "</span>", strClinets(i, 0))
            'newNode.ShowCheckBox = True
            tvAccess.Nodes.Add(newNode)
        Next
    End Sub
    Protected Sub FillModulesSubModules()
        Dim objUsersBll As Portal.BLL.Users = New Portal.BLL.Users()

        For i As Integer = 0 To tvAccess.Nodes.Count - 1 Step 1
            Clientsid = tvAccess.Nodes(i).Value
            dsMSM = objUsersBll.GetModules_SubModules(UserID.Value, Clientsid)
            FillModules()
        Next
    End Sub
    Protected Sub FillModules()
        Dim count As Integer = 0

        If dsMSM.Tables.Count > 0 Then
            For i As Integer = 0 To tvAccess.Nodes.Count - 1 Step 1
                If tvAccess.Nodes(i).Value = Clientsid Then
                    For Each row As DataRow In dsMSM.Tables(0).Rows
                        count = GetCountID(row("ID").ToString())
                        If count >= 1 Then
                            Dim newNode As New TreeNode("<span onclick=""return false;"">" & row("Name").ToString() & "</span>", row("ID").ToString())
                            ModuleID = row("ID").ToString()
                            newNode.ShowCheckBox = True
                            newNode.Checked = CType(row("Checked"), Boolean)
                            'If Portal.BLL.Enumeration.Modules.LM = ModuleID Or _
                            'Portal.BLL.Enumeration.Modules.HumanResourceManagment = ModuleID Then
                            '    If Portal.BLL.Enumeration.Users.Khurram_Ali = CInt(Session("AdminID")) Then
                            '        tvAccess.Nodes(i).ChildNodes.Add(newNode)
                            '        If count > 1 Then FillSubModules()
                            '    End If
                            'Else
                            '    tvAccess.Nodes(i).ChildNodes.Add(newNode)
                            '    If count > 1 Then FillSubModules()
                            'End If
                            If Portal.BLL.Enumeration.Modules.LM = ModuleID Or _
                            Portal.BLL.Enumeration.Modules.HumanResourceManagment = ModuleID Then
                                If Portal.BLL.Enumeration.Users.Khurram_Ali <> CInt(Session("AdminID")) And CInt(Session("AdminID")) <> 3004 And CInt(Session("AdminID")) <> 3851 And CInt(Session("AdminID")) <> 3551 Then
                                    newNode.Text = "<span onclick=""return false;"" class=""HideTreeNode"">" & row("Name").ToString() & "</span>"
                                End If
                            End If
                            tvAccess.Nodes(i).ChildNodes.Add(newNode)
                            If count > 1 Then FillSubModules()

                        End If
                    Next
                End If

            Next
        End If

    End Sub
    Protected Function GetCountID(ByVal idmodule As String) As Integer
        Dim count As Integer = 0
        For Each row As DataRow In dsMSM.Tables(1).Rows
            If row("MainModuleID").ToString() = idmodule Then
                count = count + 1
            End If
        Next
        Return count
    End Function

    Protected Sub FillSubModules()
        For Each row As DataRow In dsMSM.Tables(1).Rows
            For i As Integer = 0 To tvAccess.Nodes.Count - 1 Step 1
                If tvAccess.Nodes(i).Value = Clientsid Then
                    For j As Integer = 0 To tvAccess.Nodes(i).ChildNodes.Count - 1 Step 1
                        If tvAccess.Nodes(i).ChildNodes(j).Value = row("MainModuleID").ToString() And _
                           tvAccess.Nodes(i).ChildNodes(j).Value = ModuleID Then

                            Dim newNode As New TreeNode("<span onclick=""return false;"">" & row("Name").ToString() & "</span>", row("ClientSubModuleID").ToString())
                            newNode.ShowCheckBox = True
                            tvAccess.Nodes(i).ChildNodes(j).ShowCheckBox = True
                            newNode.Checked = CType(row("Checked"), Boolean)
                            tvAccess.Nodes(i).ChildNodes(j).ChildNodes.Add(newNode)
                        End If
                    Next
                End If
            Next
        Next
    End Sub

    Protected Sub btnUpdateUserStatus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateUserStatus.Click
        Dim Status As Boolean
        If hdnStatus.Value = "Active" Then
            Status = False
        Else
            Status = True
        End If
        If Request.QueryString("UserID") Is Nothing = False Then
            Portal.BLL.Users.Users_UpdateNotes(CInt(Request.QueryString("UserID")), Status, txtUserStatus.Text.ToString().Replace("<br/>", vbCrLf))
            If Status = True Then
                If lblEmailAddress.Text.ToString.EndsWith("netsolace.com.pk") Then
                    Dim objUsers As New Portal.BLL.Users
                    Dim Password As String = Functions.GeneratePassword(6, 6)
                    If objUsers.UpdateDoFruitAccount(CInt(Request.QueryString("UserID")), Password) = 1 Then
                        objUsers.UpdateFranMailPassword(CInt(Request.QueryString("UserID")), Password)
                        Portal.BLL.Users.ResetStatus(CInt(Request.QueryString("UserID")), Status)
                    Else
                        Portal.BLL.Users.ResetStatus(CInt(Request.QueryString("UserID")), Status)
                        'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowAlert", "alert(The required user does not exist on domain);", True)
                    End If
                ElseIf lblEmailAddress.Text.ToString.EndsWith("netsolace.com") Then
                    Dim objUsers As New Portal.BLL.Users
                    Dim Password As String = Functions.GeneratePassword(6, 6)
                    If objUsers.Update_GoogleAccount(CInt(Request.QueryString("UserID")), Password) Then
                        objUsers.UpdateFranMailPassword(CInt(Request.QueryString("UserID")), Password)
                        Portal.BLL.Users.ResetStatus(CInt(Request.QueryString("UserID")), Status)
                    Else
                        Portal.BLL.Users.ResetStatus(CInt(Request.QueryString("UserID")), Status)
                        'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowAlert", "alert(The required user does not exist on domain);", True)
                    End If
                Else
                    Portal.BLL.Users.ResetStatus(CInt(Request.QueryString("UserID")), Status)
                End If
            Else
                Portal.BLL.Users.ResetStatus(CInt(Request.QueryString("UserID")), Status)
                SendPortalAccess()
            End If
            ShowInActiveValues()
            LoadUser()
            ShowHideFranMailAccount()
        End If
    End Sub

    Protected Sub btnResetPassword_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnResetPassword.Click
        Dim objUsersBll As Portal.BLL.Users = New Portal.BLL.Users()
        If Request.QueryString("UserID") Is Nothing = False Then
            Dim Affected As Integer = Portal.BLL.Users.ResetPassword(CInt(Request.QueryString("UserID")), txtFirstName.Text.ToString(), txtUserName.Text.ToString(), txtEmail.Text.ToString(), txtPersonalEmail.Text)
            If Affected > 0 Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowAlert", "ShowAlertMessage();", True)
            End If
        End If
    End Sub

    Protected Sub lnkBtnCreateAccount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkBtnCreateAccount.Click
        Dim objMyUser As New Portal.BLL.Users
        Dim Password As String = String.Empty
        Password = Functions.GeneratePassword(6, 6)
        objMyUser.Firstname = txtFirstName.Text
        objMyUser.Lastname = txtLastName.Text
        objMyUser.Address = txtAddress.Text
        objMyUser.City = txtCity.Text
        objMyUser.Zip = txtZip.Text
        objMyUser.WorkPhone = txtWorkPhone.Text
        If txtEmail.Text.ToString.EndsWith("netsolace.com.pk") Then
            If objMyUser.CreateDippedFruitAccount(txtEmail.Text, Password, ddlStates.SelectedItem.Text, ddlCountry.SelectedItem.Text) = 1 Then
                objMyUser.FranMail_UserName = txtEmail.Text
                objMyUser.FranMail_Password = Password
                objMyUser.Insert_googleAccount(False)
                objMyUser.UpdateUserFranMail(CType(Request.QueryString("UserID"), Integer))
                objMyUser.FranMail_UserAccess(CType(Request.QueryString("UserID"), Integer))
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "GoogleUserAlert ", "alert('New Account has been created successfully.');", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "DoFruitUserAlert", "alert('New Account cannot be created.');", True)
            End If
        ElseIf txtEmail.Text.ToString.EndsWith("netsolace.com") Then
            If objMyUser.CreateUser_OnGoogle(txtEmail.Text, Password) = True Then
                objMyUser.FranMail_UserName = txtEmail.Text
                objMyUser.FranMail_Password = Password
                objMyUser.Insert_googleAccount(False)
                objMyUser.UpdateUserFranMail(CType(Request.QueryString("UserID"), Integer))
                objMyUser.FranMail_UserAccess(CType(Request.QueryString("UserID"), Integer))
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "GoogleUserAlert ", "alert('New Account has been created successfully.');", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "GoogleUserAlert ", "alert('New Account cannot be created.');", True)
            End If
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UserAlert ", "alert('Only netsolace users can be created.');", True)
        End If
        LoadUser()
        tvAccess.Nodes.Clear()
        FillClients()
        FillModulesSubModules()
        ShowHideFranMailAccount()
    End Sub

    Protected Sub ShowHideFranMailAccount()
        If hdnStatus.Value = "InActive" Then
            Dim UserID As Integer = CType(Request.QueryString("UserID"), Integer)
            Dim IsAllow As Boolean = False
            Dim objDBAccess As New DBAccess
            Dim rdr As SqlDataReader = Nothing
            Dim FranmailUserName As String = String.Empty
            objDBAccess.AddParameter("@UserID", UserID)
            objDBAccess.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            rdr = objDBAccess.ExecuteReader("Users_GetEmailByUserID")
            If rdr.Read Then
                FranmailUserName = Functions.IfNull(rdr("FranmailUserName"), "")
                IsAllow = Functions.IfNull(rdr("IsAllow"), False)
            End If
            rdr.Close()
            If FranmailUserName = "" Then
                lnkBtnCreateAccount.Text = "Create Email"
                dvWebMailAccess.Visible = False
                lnkWebMail.Visible = False
                dvCreateAccount.Visible = True
            Else
                dvCreateAccount.Visible = False
                lnkBtnCreateAccount.Visible = False
                dvWebMailAccess.Visible = True
                lnkWebMail.Visible = True
                If IsAllow = True Then
                    lnkWebMail.Text = "Disable Remote"
                Else
                    lnkWebMail.Text = "Enable Remote"
                End If
            End If
        Else
            dvCreateAccount.Visible = False
            dvWebMailAccess.Visible = False
        End If
    End Sub

    Protected Sub lnkWebMail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkWebMail.Click
        Dim objUser As New Portal.BLL.Users
        Dim objDBAccess As New DBAccess
        Dim rdr As SqlDataReader = Nothing
        Dim FranmailUserName As String = String.Empty
        Dim FranmailPassword As String = String.Empty
        Dim UserID As Integer = CType(Request.QueryString("UserID"), Integer)
        objDBAccess.AddParameter("@UserID", UserID)
        objDBAccess.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
        rdr = objDBAccess.ExecuteReader("Users_GetEmailByUserID")
        If rdr.Read Then
            FranmailUserName = Functions.IfNull(rdr("FranmailUserName"), "")
            FranmailPassword = Functions.IfNull(rdr("FranMailPassword"), "")
        End If
        rdr.Close()
        If lnkWebMail.Text = "Enable Remote" Then
            objUser.Update_WebmailAccess(UserID, True)
            objUser.SendWebMailAccess(txtFirstName.Text, FranmailUserName, FranmailPassword, "Netsolace Webmail", txtEmail.Text, txtPersonalEmail.Text)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "wemailAccess", "alert('Webmail Access is enabled and Informaiton has  been sent!');", True)
        ElseIf lnkWebMail.Text = "Disable Remote" Then
            objUser.Update_WebmailAccess(UserID, False)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "wemailAccess", "alert('Webmail Access is disabled.');", True)
        End If
        ShowHideFranMailAccount()
    End Sub
    Protected Sub SendPortalAccess()
        Dim objUser As New Portal.BLL.Users
        Dim objDBAccess As New DBAccess
        Dim rdr As SqlDataReader = Nothing
        Dim UserName As String = String.Empty
        Dim Password As String = String.Empty
        Dim UserID As Integer = CType(Request.QueryString("UserID"), Integer)
        objDBAccess.AddParameter("@UserID", UserID)
        rdr = objDBAccess.ExecuteReader("User_GetEmailInfo")
        If rdr.Read Then
            UserName = Functions.IfNull(rdr("UserName"), "")
            Password = Functions.IfNull(rdr("Password"), "")
        End If
        rdr.Close()
        If String.IsNullOrEmpty(UserName) = False Or String.IsNullOrEmpty(Password) Then
            objUser.SendWebMailAccess(txtFirstName.Text, UserName, Password, "Netsolace Portal", txtEmail.Text, txtPersonalEmail.Text)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "EamilAccess", "alert('Portal Access has been sent successfully.');", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "EamilAccess", "alert('Portal Access cannot be sent.');", True)
        End If
    End Sub
End Class