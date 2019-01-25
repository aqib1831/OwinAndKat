
Partial Class admin_Legal_Settings
    Inherits System.Web.UI.Page

    Protected Sub gridCaseStatusType_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs)
        If e.CommandName = "Delete" Then
            Dim caseObj As CaseMgmt = New CaseMgmt()
            caseObj.DeleteCaseStatusType(CInt(e.CommandArgument))
        End If
    End Sub
    Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Save.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsg.Text = ""
        If CType(CType(UPTypes.FindControl("hdnEdit"), HiddenField).Value, Boolean) = True Then
            Dim caseObj As CaseMgmt = New CaseMgmt()
            If caseObj.UpdateCaseActivityType(CInt(hdnID.Value), txtNewTypeName.Text) <> -1 Then
                txtNewTypeName.Text = ""
                lblMsg.ForeColor = Drawing.Color.Blue
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCaseActivityTypeUpdateSuccess", "setWindowedControlsVisibility(window,'visible');HideAddNewType();", True)
                CType(UPTypes.FindControl("hdnID"), HiddenField).Value = 0
                CType(UPTypes.FindControl("hdnEdit"), HiddenField).Value = False
                gridCaseStatusType.DataBind()
                Exit Sub
            Else
                CType(UPTypes.FindControl("hdnID"), HiddenField).Value = 0
                CType(UPTypes.FindControl("hdnEdit"), HiddenField).Value = False
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Case  activity type with same name already exists."
                txtNewTypeName.Text = ""
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                Exit Sub
            End If
        Else
            If CaseMgmt.AddNewCaseActivityType(CType(txtNewTypeName.Text.Trim(), String)) = -1 Then
                'ClientScript.RegisterStartupScript(Me.GetType(), "CaseStatusType", "<script>alert('Case Status Type with the same name already exists.');</script>")
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Case Activity Type with same name already exists."
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrHideEdit", "document.getElementById('edit').style.display='none';", True)
                txtNewTypeName.Text = ""
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "FocusTypeName", "document.getElementById('txtNewTypeName').focus();", True)
                Exit Sub
            Else
                gridCaseStatusType.DataSourceID = "odsCaseActivityType"
                gridCaseStatusType.DataBind()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCaseActivityTypeAddSuccess", "setWindowedControlsVisibility(window,'visible');HideAddNewType();document.getElementById('edit').style.display='none';", True)
                txtNewTypeName.Text = ""
                lblMsg.ForeColor = Drawing.Color.Blue
                'lblMsg.Text = "Case Activity Type added successfully."
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub gridCaseStatusType_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            e.Row.Attributes.Add("onclick", "ShowAddNewType();getElementById('txtNewTypeName').value='" & e.Row.DataItem("Name").ToString().Replace("'", "\'") & "';getElementById('hdnID').value='" & e.Row.DataItem("ID").ToString() & "';getElementById('lblMsg').value='" & "Edit Activity Type." & "';getElementById('hdnEdit').value=true; document.getElementById('edit').style.display='inline';")
            e.Row.Attributes.Add("style", "cursor:none")
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
End Class
