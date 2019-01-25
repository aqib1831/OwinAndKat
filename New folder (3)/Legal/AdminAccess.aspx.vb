
Partial Class admin_Legal_AdminAccess
    Inherits System.Web.UI.Page
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        If (hdnflag.Value.ToString().ToLower().Equals("false")) Then
            Dim objAdminAccess As New Fransupport.BLL.Legal.AdminAccess
            objAdminAccess.AddAdmins(hdnSelectedAdmins.Value)
            AdminsSelected.Items.Clear()
            AdminsSelected.DataBind()
        End If
        
    End Sub
End Class
