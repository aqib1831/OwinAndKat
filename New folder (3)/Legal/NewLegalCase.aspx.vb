
Partial Class admin_Legal_NewLegalCase
    Inherits System.Web.UI.Page

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        If String.IsNullOrEmpty(HttpContext.Current.Session("AdminId")) = False Then
            Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        End If
        Dim caseObj As CaseMgmt = New CaseMgmt()
        caseObj.Title = txtTitle.Text.ToString().Trim()
        caseObj.Type = CInt(ddlType.SelectedValue)
        If hdnID.Value <> Nothing Then
            caseObj.Franchisee = CInt(hdnID.Value)
        Else
            caseObj.Franchisee = 0
        End If
        If txtCaseDate.Text <> "" Then
            caseObj.CaseDate = DateTime.Parse(txtCaseDate.Text)
        Else
            caseObj.CaseDate = DateTime.Parse("12/12/1900 12:00:00 AM")
        End If
        caseObj.ConcernedParties = txtConcernedParties.Text
        caseObj.ContactID = ddlContact.SelectedValue
        caseObj.Firm = ddlFirm.SelectedValue
        caseObj.Notify = Request(txtNotify.UniqueID)
        caseObj.Status = ddlStatus.SelectedValue
        caseObj.DocketNo = txtDocketNo.Text
        caseObj.FirmCaseNo = txtFirmCaseNo.Text
        caseObj.AssignedTo = ddlCompAdmins.SelectedValue
        caseObj.Note = txtNotes.Text
        caseObj.AdminID = Session("AdminID")
        'If caseObj.AddNewCase() = 0 Then
        Dim intCaseID As Integer = caseObj.AddNewCase()
        If intCaseID > 0 Then
            'Response.Redirect("Legal_Case.aspx")
            Response.Redirect("CaseMain.aspx?Source=Legal_Case&ID=" & intCaseID.ToString() & "&Firm=-1&Type=-1&Status=-1")
        Else
            lblMsg.Text = "Case with the same information already exists."
        End If
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'If Session("Admin_AdminID") Is Nothing Then
        '    Response.Redirect("SessionExpire.htm")
        'End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnCurrentDate.Text = Now().Date.ToString("MM/dd/yyyy")
        txtCaseDate.Text = Request(txtCaseDate.UniqueID)
        txtDateEntered.Text = Request(txtDateEntered.UniqueID)
        If Not IsPostBack Then
            txtDateEntered.Text = DateTime.Now.ToShortDateString()
        End If

    End Sub

    Protected Sub Repeater1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If Repeater1.Items.Count = 0 Then
                e.Item.FindControl("trNoRec").Visible = True
            End If
        End If
    End Sub

    Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Save.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsgNew.Text = ""
        If Page.IsValid Then
            Dim Val As Integer = CaseMgmt.AddNewCaseStatusType(CType(txtNewTypeName.Text, String))
            If Val = -1 Then
                lblMsgNew.ForeColor = Drawing.Color.Red
                lblMsgNew.Text = "Case Status already exists!"
                txtNewTypeName.Text = ""
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CaseStatusType", "setWindowedControlsVisibility(window,'hidden');ShowAddNewStatusType();$get('" & txtNewTypeName.ClientID & "').focus()", True)
                Exit Sub
            Else
                ddlStatus.DataSourceID = "sdsCaseStatus"
                ddlStatus.DataBind()
                ddlStatus.SelectedValue = Val
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CaseStatusType", "setWindowedControlsVisibility(window,'visible');HideAddNewStatusType();", True)
                txtNewTypeName.Text = ""
                lblMsgNew.ForeColor = Drawing.Color.Blue
                'lblMsgNew.Text = "Case Status Type added successfully."
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub SaveType_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SaveType.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsgNew1.Text = ""
        If Page.IsValid Then
            Dim Val As Integer = CaseMgmt.AddNewCaseType(CType(txtNewTypeName1.Text, String))
            If Val = -1 Then
                txtNewTypeName1.Text = ""
                lblMsgNew1.ForeColor = Drawing.Color.Red
                lblMsgNew1.Text = "Case Type already exists!"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CaseStatusType", "setWindowedControlsVisibility(window,'hidden');ShowAddNewType();$get('" & txtNewTypeName1.ClientID & "').focus()", True)
                Exit Sub
            Else
                ddlType.DataSourceID = "sdsCaseTypes"
                ddlType.DataBind()
                ddlType.SelectedValue = Val
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CaseStatusType", "setWindowedControlsVisibility(window,'visible');HideAddNewType();", True)
                lblMsgNew1.ForeColor = Drawing.Color.Blue
                txtNewTypeName1.Text = ""
                'lblMsgNew1.Text = "Case Type added successfully."
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub ddlType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlType.DataBound
        ddlType.Items.Insert(0, New ListItem("Choose...", "-1"))
        ddlType.SelectedValue = -1
    End Sub

    Protected Sub ddlStatus_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStatus.DataBound
        ddlStatus.Items.Insert(0, New ListItem("Choose...", "-1"))
        ddlStatus.SelectedValue = -1
    End Sub

    Protected Sub ddlFirm_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFirm.DataBound
        If Not ddlFirm.Items.FindByValue(CInt(hdnFirmID.Value)) Is Nothing AndAlso CInt(hdnContactID.Value) <> 0 Then
            ddlFirm.SelectedValue = CInt(hdnFirmID.Value)
        End If
    End Sub

    Protected Sub ddlContact_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlContact.DataBound
        ddlContact.Items.Insert("0", New ListItem("Choose...", "-1"))
        If Not ddlContact.Items.FindByValue(CInt(hdnContactID.Value)) Is Nothing AndAlso CInt(hdnContactID.Value) <> 0 Then
            ddlContact.SelectedValue = CInt(hdnContactID.Value)
        Else
            ddlContact.SelectedIndex = 0
        End If
    End Sub

    Protected Sub btnBinder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBinder.Click
        ddlFirm.DataSourceID = FirmDS.ID
        ddlFirm.DataBind()
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ScrAsyncFranSearch", "setWindowedControlsVisibility(window,'hidden');", True)
    End Sub
End Class
