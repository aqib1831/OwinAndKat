
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
        If CType(hdnEdit.Value, Boolean) = True Then
            Dim caseObj As CaseMgmt = New CaseMgmt()
            If caseObj.UpdateCaseStatusTypes(CInt(hdnID.Value), txtNewTypeName.Text) <> -1 Then
                txtNewTypeName.Text = ""
                lblMsg.ForeColor = Drawing.Color.Blue
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCaseStatusTypeUpdateSuccess", "HideAddNewType();", True)
                hdnID.Value = 0
                hdnEdit.Value = False
                gridCaseStatusType.DataBind()
                Exit Sub
            Else
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Case status type with same name already exists."
                txtNewTypeName.Text = ""
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrShowAddNewType", "ShowAddNewType();", True)
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                Exit Sub
            End If
        Else
            If CaseMgmt.AddNewCaseStatusType(CType(txtNewTypeName.Text.Trim(), String)) = -1 Then
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Case Status Type with same name already exists."
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrHideEdit", "document.getElementById('edit').style.display='none';", True)
                txtNewTypeName.Text = ""
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                Exit Sub
            Else
                gridCaseStatusType.DataSourceID = odsCaseStatusType.ID
                gridCaseStatusType.DataBind()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "sceCaseStatusTypeAddSuccess", "HideAddNewType();", True)
                txtNewTypeName.Text = ""
                lblMsg.ForeColor = Drawing.Color.Blue
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub gridCaseStatusType_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            e.Row.Attributes.Add("onclick", "ShowAddNewType();getElementById('txtNewTypeName').value='" & e.Row.DataItem("Name").ToString().Replace("'", "\'") & "';getElementById('hdnID').value='" & e.Row.DataItem("ID").ToString() & "';getElementById('lblMsg').value='" & "Edit Activity Type." & "';getElementById('hdnEdit').value=true;getElementById('edit').style.display='inline';")
            e.Row.Attributes.Add("style", "cursor:none")
        End If
    End Sub
End Class
