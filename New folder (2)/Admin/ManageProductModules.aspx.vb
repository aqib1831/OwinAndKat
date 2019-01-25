
Partial Class Admin_ManageProductModules
    Inherits System.Web.UI.Page
    Protected Function GetStatusOperation(ByVal Inactive As Boolean) As String
        Return IIf(Inactive, "Activate", "Inactivate")
    End Function

    Protected Sub gvModules_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvModules.DataBound
        ltrlModulesCount.Text = gvModules.Rows.Count
        If ((gvModules.Rows.Count Mod 2) <> 0) Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
        End If
    End Sub

    Protected Sub gvModules_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvModules.RowCommand
        If e.CommandName = "Activate" Then
            Portal.DAL.NSProductModuleManager.UpdateStatus(e.CommandArgument, False)
        ElseIf e.CommandName = "Inactivate" Then
            Portal.DAL.NSProductModuleManager.UpdateStatus(e.CommandArgument, True)
        End If

        gvModules.DataBind()
    End Sub

    Protected Sub gvModules_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvModules.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "this.className='selectedRow'; ModuleClicked(" & e.Row.DataItem("ID") & ");")
        End If
    End Sub

    Protected Sub ddlProducts_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.DataBound
        ddlProducts.Items.Insert(0, New ListItem("All", 0))
    End Sub
End Class
