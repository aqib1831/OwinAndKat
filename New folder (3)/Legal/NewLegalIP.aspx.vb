
Partial Class admin_Legal_NewLegal
    Inherits System.Web.UI.Page

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        Dim ipObj As IntellectualProperty = New IntellectualProperty()
        If Page.IsValid Then


            ipObj.Title = txtTitle.Text.ToString().Trim()
            ipObj.Type = CInt(ddlType.SelectedValue)
            ipObj.DateFirstUsed = Convert.ToDateTime(txtFirstUsed.Text)

            If txtDateApplied.Text <> "" Then
                ipObj.DateApplied = Convert.ToDateTime(txtDateApplied.Text)
            End If

            If txtExpiresOn.Text <> "" Then
                ipObj.ExpiresOn = Convert.ToDateTime(txtExpiresOn.Text)
            End If

            ipObj.Firm = CInt(ddlFirm.SelectedValue)
            ipObj.ContactID = CInt(ddlContact.SelectedValue)
            ipObj.Status = CInt(ddlStatus.SelectedValue)
            ipObj.SerialNo = txtSerialNo.Text
            ipObj.RegNo = txtRegNo.Text
            ipObj.Note = txtNotes.Text
            ipObj.NDate = DateTime.Now
            ipObj.AdminID = Session("AdminID")
            ipObj.AssignedTo = CInt(ddlAssignedTo.SelectedValue)
            ipObj.Notification = CInt(ddlNotify.SelectedValue)
            ipObj.Legal_Country = CInt(ddlCountry.SelectedValue)
            ipObj.RefNo = txtRefNo.Text

            ipObj.OwnerID = CInt(ddlOwner.SelectedValue)
            If txtCreationDate.Text <> "" Then
                ipObj.CreationDate = Convert.ToDateTime(txtCreationDate.Text)
            End If

            If txtRegistrationDate.Text <> "" Then
                ipObj.RegistrationDate = Convert.ToDateTime(txtRegistrationDate.Text)
            End If

            If txtDeclarationofUseFrom.Text <> "" Then
                ipObj.DeclarationOfUseFrom = Convert.ToDateTime(txtDeclarationofUseFrom.Text)
            End If

            If txtDeclarationofUseTo.Text <> "" Then
                ipObj.DeclarationOfUseTo = Convert.ToDateTime(txtDeclarationofUseTo.Text)
            End If

            If txtExpiresOnTo.Text <> "" Then
                ipObj.ExpiresOnTo = Convert.ToDateTime(txtExpiresOnTo.Text)
            End If

            If txtPublishedOpposition.Text <> "" Then
                ipObj.PbulishedForOpposition = Convert.ToDateTime(txtPublishedOpposition.Text)
            End If

            ipObj.File1 = FileUpload1
            ipObj.File2 = FileUpload2
            ipObj.File3 = FileUpload3
            'ipObj.WaitingFor = ddlWaitingFor.SelectedValue
            Dim intIdentity As Integer = ipObj.AddNewLegalIP()
            If intIdentity = -1 Then
                lblMsg.Text = "Intellectual Property with the same Registration No/Serial No already exists."

            Else
                ' Response.Redirect("Legal_IP.aspx")
                Response.Redirect("IPMain.aspx?Source=Legal_IP&ID=" & intIdentity.ToString() & "&Firm=-1&Type=-1&Status=-1&Country=-1")
            End If
 
        End If


    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(HttpContext.Current.Session("AdminId")) = False Then
            Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        End If

        txtDateApplied.Text = Request(txtDateApplied.UniqueID)
        txtFirstUsed.Text = Request(txtFirstUsed.UniqueID)
        txtExpiresOn.Text = Request(txtExpiresOn.UniqueID)
        txtCreationDate.Text = Request(txtCreationDate.UniqueID)
        txtRegistrationDate.Text = Request(txtRegistrationDate.UniqueID)
        txtDeclarationofUseFrom.Text = Request(txtDeclarationofUseFrom.UniqueID)
        txtDeclarationofUseTo.Text = Request(txtDeclarationofUseTo.UniqueID)
        txtExpiresOnTo.Text = Request(txtExpiresOnTo.UniqueID)
        txtPublishedOpposition.Text = Request(txtPublishedOpposition.UniqueID)
        'lnkNewFirm.Attributes.Add("onclick", "Javascript:return newFirm();")

    End Sub
    'Protected Sub btnSaveFirm_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFirmSave.Click
    '    Dim firm As Firm = New Firm()
    '    firm.Name = txtName.Text
    '    firm.Title = txtFirmTitle.Text
    '    firm.Address = txtAddress.Text
    '    firm.Phone = txtPhone.Text
    '    firm.Country = ddlCountry.SelectedValue
    '    firm.State = ddlStates.SelectedValue
    '    firm.City = txtCity.Text
    '    firm.ZipCode = txtZipCode.Text
    '    Dim val As Integer = firm.AddNewFirm()
    '    If val <> -1 Then
    '        ddlFirm.DataSourceID = "FirmDS"
    '        ddlFirm.DataBind()
    '        ddlFirm.SelectedValue = val
    '    End If

    'End Sub
    'Protected Sub ddlCountry_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.SelectedIndexChanged
    '    ddlStates.DataSourceID = "StatesDS"
    '    ddlStates.DataBind()
    'End Sub

    
    'Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
    '    ddlStates.Items.Insert(0, New ListItem("Choose...", -1))
    'End Sub

    Protected Sub SaveIP_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SaveIP.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsgIP.Text = ""
        If Page.IsValid Then
            Dim Val As Integer = IntellectualProperty.AddNewIPType(CType(txtNewTypeNameIP.Text, String))
            If Val = -1 Then
                'ClientScript.RegisterStartupScript(Me.GetType(), "CaseStatusType", "<script>alert('Intellectual Property Type with the same name already exists.');</script>")
                lblMsgIP.ForeColor = Drawing.Color.Red
                txtNewTypeNameIP.Text = ""
                lblMsgIP.Text = "Intellectual Property Type with the same name already exists."

            Else
                ddlType.DataSourceID = "sdsIPType"
                ddlType.DataBind()
                ddlType.SelectedValue = Val
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrIPType", "HideAddNewType();", True)
                txtNewTypeNameIP.Text = ""
                lblMsgIP.ForeColor = Drawing.Color.Blue
                lblMsgIP.Text = "Intellectual Property Type added successfully."
                Return
            End If
        End If
    End Sub

    Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsgStatus.Text = ""
        If Page.IsValid Then
            Dim Val As Integer = IntellectualProperty.AddNewIPStatusType(CType(txtNewTypeNameStatus.Text, String))
            If Val = -1 Then
                'ClientScript.RegisterStartupScript(Me.GetType(), "CaseStatusType", "<script>alert('Intellectual Property Status Type with the same name already exists.');</script>")
                txtNewTypeNameStatus.Text = ""
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsgStatus.Text = "Intellectual Property Status Type with the same name already exists."

            Else
                ddlStatus.DataSourceID = "sdsIPStatusTypes"
                ddlStatus.DataBind()
                ddlStatus.SelectedValue = Val
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrIPStatusType", "HideAddNewTypeStatus();", True)
                txtNewTypeNameStatus.Text = ""
                lblMsgStatus.ForeColor = Drawing.Color.Blue
                lblMsgStatus.Text = "Intellectual Property Status Type added successfully."
                Return
            End If
        End If
    End Sub

    'Protected Sub btnBinder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBinder.Click
    '    ddlFirm.DataBind()
    '    If Not ddlFirm.Items.FindByValue(CInt(hdnFirmID.Value)) Is Nothing Then
    '        ddlFirm.SelectedValue = CInt(hdnFirmID.Value)
    '    End If
    'End Sub

    'Protected Sub ddlContact_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlContact.DataBound
    '    ddlContact.Items.Insert(0, New ListItem("Choose...", -1))
    'End Sub
    'Protected Sub ddlFirm_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFirm.DataBound
    '    ddlFirm.Items.Insert(0, New ListItem("Choose...", -1))
    'End Sub

    Protected Sub ddlFirm_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFirm.DataBound
        If Not ddlFirm.Items.FindByValue(CInt(hdnFirmID.Value)) Is Nothing Then
            ddlFirm.SelectedValue = CInt(hdnFirmID.Value)
        Else
            ddlFirm.Items.Insert("0", New ListItem("Choose...", "-1"))
        End If
        ddlContact.DataSourceID = ContactsDS.ID
        ddlContact.DataBind()
        'If Not ddlContact.Items.FindByValue(CInt(hdnContactID.Value)) Is Nothing AndAlso CInt(hdnContactID.Value) <> 0 Then
        '    ddlContact.SelectedValue = CInt(hdnContactID.Value)
        'End If
    End Sub

    Protected Sub ddlContact_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlContact.DataBound

        If Not ddlContact.Items.FindByValue(CInt(hdnContactID.Value)) Is Nothing AndAlso CInt(hdnContactID.Value) <> 0 Then
            ddlContact.SelectedValue = CInt(hdnContactID.Value)
        Else
            ddlContact.Items.Insert("0", New ListItem("Choose...", "-1"))
        End If
    End Sub

    Protected Sub btnBinder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBinder.Click
        ddlFirm.DataSourceID = FirmDS.ID
        ddlFirm.DataBind()
    End Sub
    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete

        If Not ddlAssignedTo.Items.FindByValue(hdnAssignedTo.Value) Is Nothing Then
            ddlAssignedTo.SelectedValue = CInt(hdnAssignedTo.Value)
        End If
        If Not ddlStatus.Items.FindByValue(hdnStatus.Value) Is Nothing Then
            ddlStatus.SelectedValue = CInt(hdnStatus.Value)
        End If
        If Not ddlType.Items.FindByValue(hdnType.Value) Is Nothing Then
            ddlType.SelectedValue = CInt(hdnType.Value)
        End If
        'If Not ddlFirm.Items.FindByValue(hdnFirmID.Value) Is Nothing Then
        '    ddlFirm.SelectedValue = CInt(hdnFirmID.Value)
        'End If
        'If Not ddlContact.Items.FindByValue(hdnContactID.Value) Is Nothing Then
        '    ddlContact.SelectedValue = CInt(hdnContactID.Value)
        'End If
        'ddlAssignedTo.SelectedValue = CInt(hdnAssignedTo.Value)
        'ddlFirm.SelectedValue = CInt(hdnFirmID.Value)
        'ddlContact.SelectedValue = CInt(hdnContactID.Value)
    End Sub

    Protected Sub ddlCountry_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.Items.Insert("0", New ListItem("Choose...", "-1"))
    End Sub

    Protected Sub ddlType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlType.DataBound
        ddlType.Items.Insert("0", New ListItem("Choose...", "-1"))
    End Sub

    Protected Sub ddlStatus_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStatus.DataBound
        ddlStatus.Items.Insert("0", New ListItem("Choose...", "-1"))
    End Sub

    Protected Sub ddlFirm_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFirm.Init

    End Sub
End Class

