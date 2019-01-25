
Partial Class admin_Legal_Legal_Countries
    Inherits System.Web.UI.Page

    Protected Sub grdCountries_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdCountries.RowCommand
        If e.CommandName = "Delete" Then
            Dim CountryObj As Legal_Country = New Legal_Country()
            CountryObj.Delete(CInt(e.CommandArgument))
        End If
    End Sub

    Protected Sub grdCountries_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdCountries.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            e.Row.Attributes.Add("onclick", "ShowAddNewCountry();getElementById('txtNewCountry').value='" & e.Row.DataItem("Name").ToString().Replace("'", "\'") & "';getElementById('hdnID').value='" & e.Row.DataItem("ID").ToString() & "';getElementById('lblMsg').value='" & "Edit Activity Type." & "';getElementById('hdnEdit').value=true;getElementById('edit').style.display='inline';")
            e.Row.Attributes.Add("style", "cursor:none")
        End If
    End Sub

    Protected Sub Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Save.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        lblMsg.Text = ""

        If CType(hdnEdit.Value, Boolean) = True Then
            Dim CountryObj As Legal_Country = New Legal_Country()
            If CountryObj.Update(CInt(hdnID.Value), txtNewCountry.Text) <> -1 Then
                txtNewCountry.Text = ""
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCountryUpdateSuccess", "HideAddNewCountry();", True)
                hdnID.Value = 0
                hdnEdit.Value = False
                grdCountries.DataBind()
                Exit Sub
            Else
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Country with the same name already exists."
                txtNewCountry.Text = ""
                ScriptManager.GetCurrent(Me).SetFocus(txtNewCountry)
                Exit Sub
            End If

        Else
            If Legal_Country.AddNew(CType(txtNewCountry.Text.Trim(), String)) = -1 Then
                txtNewCountry.Text = ""
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Text = "Country with the same name already exists."
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrNameFocus", "document.getElementById('edit').style.display='none';", True)
                ScriptManager.GetCurrent(Me).SetFocus(txtNewCountry)
                Exit Sub
            Else
                grdCountries.DataSourceID = "odsCountries"
                grdCountries.DataBind()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "scrCountryAddSuccess", "HideAddNewCountry();", True)
                lblMsg.ForeColor = Drawing.Color.Blue
                txtNewCountry.Text = ""
                Exit Sub
            End If
        End If
    End Sub

End Class
