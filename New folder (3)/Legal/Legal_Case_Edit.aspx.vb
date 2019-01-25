Imports System.Data.SqlClient
Imports System.Data.Sql

Partial Class admin_Legal_NewLegal
    Inherits System.Web.UI.Page

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        If HttpContext.Current.Session("AdminID") Is Nothing Then
            Response.Redirect("SessionExpire.htm")
        Else
            Dim caseObj As CaseMgmt = New CaseMgmt()
            caseObj.CID = CInt(Request.QueryString("ID"))
            caseObj.Title = txtTitle.Text.ToString().Trim()
            caseObj.Type = CInt(ddlType.SelectedValue)
            caseObj.Franchisee = CInt(hdnID.Value)
            caseObj.DateEntered = txtDateEntered.Text
            caseObj.Note = txtNotes.Text
            If txtCaseDate.Text <> "" Then
                caseObj.CaseDate = txtCaseDate.Text
            Else
                caseObj.CaseDate = "12/12/1900 12:00:00 AM"
            End If
            caseObj.Firm = ddlFirm.SelectedValue
            caseObj.Status = ddlStatus.SelectedValue
            If ddlContact.Items.Count > 0 Then
                caseObj.ContactID = ddlContact.SelectedValue
            End If
            caseObj.ConcernedParties = txtConcernedParties.Text
            caseObj.DocketNo = txtDocketNo.Text
            caseObj.FirmCaseNo = txtFirmCaseNo.Text
            caseObj.AssignedTo = ddlCompAdmins.SelectedValue
            caseObj.AdminID = Session("AdminID")
            caseObj.UpdateCase()
            Response.Redirect("Legal_Case.aspx?" & Request.QueryString().ToString())
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtCaseDate.Text = Request(txtCaseDate.UniqueID)
        txtDateEntered.Text = Request(txtDateEntered.UniqueID)
    End Sub
    Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Save.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsgNew.Text = ""
        If Page.IsValid Then
            Dim Val As Integer = CaseMgmt.AddNewCaseStatusType(CType(txtNewTypeName.Text, String))
            If Val = -1 Then
                'ClientScript.RegisterStartupScript(Me.GetType(), "CaseStatusType", "<script>alert('Case Status Type with the same name already exists.');</script>")
                lblMsgNew.ForeColor = Drawing.Color.Red
                lblMsgNew.Text = "Case Status Type with the same name already exists."
                txtNewTypeName.Text = ""
                Return
            Else
                ddlStatus.DataSourceID = "sdsCaseStatus"
                ddlStatus.DataBind()
                ddlStatus.SelectedValue = Val
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CaseStatusType", "setWindowedControlsVisibility(window,'visible');HideAddNewStatusType();", True)
                txtNewTypeName.Text = ""
                lblMsgNew.ForeColor = Drawing.Color.Blue
                lblMsgNew.Text = "Case Status Type added successfully."
                Return
            End If
        End If
    End Sub
    Protected Sub Repeater1_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs)
        If e.Item.ItemType = ListItemType.Footer Then
            If Repeater1.Items.Count = 0 Then
                e.Item.FindControl("trNoRec").Visible = True
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
                ' ClientScript.RegisterStartupScript(Me.GetType(), "CaseStatusType", "<script>alert('Case Type with the same name already exists.');</script>")
                txtNewTypeName1.Text = ""
                lblMsgNew1.ForeColor = Drawing.Color.Red
                lblMsgNew1.Text = "Case Type with the same name already exists."
                Return
            Else
                ddlType.DataSourceID = "sdsCaseTypes"
                ddlType.DataBind()
                ddlType.SelectedValue = Val
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CaseStatusType", "setWindowedControlsVisibility(window,'visible');HideAddNewType();", True)
                lblMsgNew1.ForeColor = Drawing.Color.Blue
                txtNewTypeName1.Text = ""
                lblMsgNew1.Text = "Case Type added successfully."
                Return
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
        If Not ddlFirm.Items.FindByValue(CInt(hdnFirmID.Value)) Is Nothing Then
            ddlFirm.SelectedValue = CInt(hdnFirmID.Value)
        End If
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
        If Not Page.IsPostBack Then
            Dim caseObj As CaseMgmt = New CaseMgmt()
            Dim dr As SqlDataReader = caseObj.GetSingleCase(Convert.ToInt32(Request.QueryString("ID")))
            dr.Read()
            txtTitle.Text = dr.Item("Title").ToString()

            If Not ddlFirm.Items.FindByValue(dr.Item("FirmID")) Is Nothing Then
                ddlFirm.SelectedValue = CInt(dr.Item("FirmID"))
            End If
            If dr.Item("DocketNo").ToString() <> "" Then
                txtDocketNo.Text = dr.Item("DocketNo").ToString()
            Else
                txtDocketNo.Text = ""
            End If
            txtDateEntered.Text = Convert.ToDateTime(dr.Item("DateEntered")).ToShortDateString()
            If Not ddlStatus.Items.FindByValue(dr.Item("Status")) Is Nothing Then
                ddlStatus.SelectedValue = CInt(dr.Item("Status"))
            End If
            Dim li As ListItem = ddlType.Items.FindByValue(CInt(dr.Item("Type")))
            If Not ddlType.Items.FindByValue(dr.Item("Type")) Is Nothing Then
                ddlType.SelectedValue = CInt(dr.Item("Type"))
            End If
            If Not dr.Item("ContactID") Is Nothing Then
                If Not ddlContact.Items.FindByValue(dr.Item("ContactID")) Is Nothing Then
                    ddlContact.SelectedValue = CInt(dr.Item("ContactID"))
                End If
            End If
            If Not IsDBNull(dr.Item("ConcernedParties")) Then
                txtConcernedParties.Text = dr.Item("ConcernedParties").ToString().Trim()
            End If


            txtNotes.Text = dr.Item("Description").ToString()
            If Not ddlCompAdmins.Items.FindByValue(CInt(dr.Item("AssignedTo"))) Is Nothing Then
                ddlCompAdmins.SelectedValue = CInt(dr.Item("AssignedTo"))
            End If
            If dr.Item("FranchiseID").ToString() <> "" Then
                hdnID.Value = CInt(dr.Item("FranchiseID"))
            Else
                hdnID.Value = 0
            End If

            If dr.Item("FirmCaseNo").ToString() <> "" Then
                txtFirmCaseNo.Text = dr.Item("FirmCaseNo").ToString()
            Else
                txtFirmCaseNo.Text = ""
            End If
            If dr.Item("CaseDate").ToString() <> "" Then
                If dr.Item("CaseDate").ToString() <> "12/12/1900 12:00:00 AM" Then
                    txtCaseDate.Text = Convert.ToDateTime(dr.Item("CaseDate")).ToShortDateString()
                End If
            Else
                txtCaseDate.Text = ""
            End If
            If dr.Item("StoreName").ToString() <> "" Then
                txtFranchisee.Text = dr.Item("StoreName").ToString()
            Else
                txtFranchisee.Text = ""
            End If
            dr.Close()
            ContactsDS.SelectParameters.Item("FirmID").DefaultValue = ddlFirm.SelectedValue
            ddlContact.SelectedIndex = 1
        End If
    End Sub
End Class
