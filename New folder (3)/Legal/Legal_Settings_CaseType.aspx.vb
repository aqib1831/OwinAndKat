
Partial Class admin_Legal_Settings
    Inherits System.Web.UI.Page

    Protected Sub gridCaseType_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs)
        If e.CommandName = "Delete" Then
            Dim caseObj As CaseMgmt = New CaseMgmt()
            caseObj.DeleteCaseType(CInt(e.CommandArgument))
        End If
    End Sub

    Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Save.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsg.Text = ""

        If CType(hdnEdit.Value, Boolean) = True Then
            Dim caseObj As CaseMgmt = New CaseMgmt()
            If caseObj.UpdateCaseTypes(CInt(hdnID.Value), txtNewTypeName.Text) <> -1 Then
                txtNewTypeName.Text = ""
                'lblMsg.ForeColor = Drawing.Color.Blue
                'lblMsg.Text = "Case type updated successfully."
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCaseTypeUpdateSuccess", "HideAddNewType();", True)
                hdnID.Value = 0
                hdnEdit.Value = False
                gridCaseType.DataBind()
                Exit Sub
            Else
                'hdnID.Value = 0
                'hdnEdit.Value = False
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Case Type with the same name already exists."
                txtNewTypeName.Text = ""
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                Exit Sub
            End If

        Else
            If CaseMgmt.AddNewCaseType(CType(txtNewTypeName.Text.Trim(), String)) = -1 Then
                txtNewTypeName.Text = ""
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Case Type with the same name already exists."
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrNameFocus", "document.getElementById('edit').style.display='none';SetFocus();", True)
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                Exit Sub
            Else
                gridCaseType.DataSourceID = "odsCaseType"
                gridCaseType.DataBind()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCaseTypeAddSuccess", "HideAddNewType();", True)
                lblMsg.ForeColor = Drawing.Color.Blue
                txtNewTypeName.Text = ""
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub gridCaseType_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            e.Row.Attributes.Add("onclick", "ShowAddNewType();getElementById('txtNewTypeName').value='" & e.Row.DataItem("Name").ToString().Replace("'", "\'") & "';getElementById('hdnID').value='" & e.Row.DataItem("ID").ToString() & "';getElementById('lblMsg').value='" & "Edit Activity Type." & "';getElementById('hdnEdit').value=true;getElementById('edit').style.display='inline';")
            e.Row.Attributes.Add("style", "cursor:none")
        End If
    End Sub

End Class
