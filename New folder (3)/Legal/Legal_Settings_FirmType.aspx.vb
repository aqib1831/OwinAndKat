Partial Class admin_Legal_Settings
    Inherits System.Web.UI.Page

    Protected Sub gridIPType_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs)
        If e.CommandName = "Delete" Then
            Dim firmObj As IntellectualProperty = New IntellectualProperty()
            firmObj.DeleteIPType(CInt(e.CommandArgument))
        End If
    End Sub



    Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Save.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsg.Text = ""
        If CBool(hdnEdit.Value) = True Then
            Dim firmObj As Firm = New Firm()
            If firmObj.UpdateFirmType(txtNewTypeName.Text, CType(UPTypes.FindControl("hdnID"), HiddenField).Value) <> -1 Then
                txtNewTypeName.Text = ""
                'lblMsg.ForeColor = Drawing.Color.Blue
                'lblMsg.Text = "Firm type updated successfully."
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCaseActivityTypeUpdateSuccess", "HideAddNewType();", True)
                hdnID.Value = 0
                hdnEdit.Value = False
                gridFirmType.DataBind()
                Exit Sub
            Else
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Firm type with same name already exists."
                txtNewTypeName.Text = ""
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                Exit Sub
            End If

        Else
            If Firm.AddFirmType(CType(txtNewTypeName.Text.Trim(), String)) = -1 Then
                lblMsg.ForeColor = Drawing.Color.Red
                txtNewTypeName.Text = ""
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrHideEdit", "document.getElementById('edit').style.display='none';", True)
                lblMsg.Text = "Firm Type with same name already exists."
                ScriptManager.GetCurrent(Me).SetFocus(txtNewTypeName)
                Exit Sub
            Else

                gridFirmType.DataBind()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "CaseStatusType", "HideAddNewType();", True)
                txtNewTypeName.Text = ""
                'lblMsg.ForeColor = Drawing.Color.Blue
                'lblMsg.Text = "Firm type added successfully."
                Exit Sub
            End If
        End If
    End Sub

    Protected Sub gridIPType_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            e.Row.Attributes.Add("onclick", "ShowAddNewType();getElementById('txtNewTypeName').value='" & e.Row.DataItem("Name").ToString().Replace("'", "\'") & "';getElementById('hdnID').value='" & e.Row.DataItem("ID").ToString() & "';getElementById('lblMsg').value='" & "Edit Activity Type." & "';getElementById('hdnEdit').value=true;getElementById('edit').style.display='inline';")
            e.Row.Attributes.Add("style", "cursor:none")
        End If
    End Sub
End Class
