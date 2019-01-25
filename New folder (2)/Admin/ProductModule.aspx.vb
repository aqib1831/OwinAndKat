
Partial Class Admin_ProductModule
    Inherits System.Web.UI.Page

    Protected Sub Admin_ProductModule_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If String.IsNullOrEmpty(Request.QueryString("ModuleID")) OrElse IsNumeric(Request.QueryString("ModuleID")) = False Then
                hdnModuleID.Value = 0
                hdnProductID.Value = 0
                btnSave.Text = "Save"
            Else
                hdnModuleID.Value = Request.QueryString("ModuleID").Trim
                Dim NSModule As Portal.BLL.NSProductModule = Portal.DAL.NSProductModuleManager.getModule(hdnModuleID.Value)
                txtModuleName.Text = NSModule.Name
                ddlProducts.SelectedValue = NSModule.RelatedToProductID
                hdnProductID.Value = NSModule.RelatedToProductID
                chkInactive.Checked = NSModule.Inactive
                btnSave.Text = "Update"
                btnCancel.Text = "Back"
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If Page.IsValid Then
            Dim ModuleName As String = txtModuleName.Text.Trim
            Dim Inactive As Boolean = chkInactive.Checked
            Dim RelatedToProductID As Integer = ddlProducts.SelectedValue
            If CInt(hdnModuleID.Value) = 0 Then
                Dim AddedBy As Integer = Session("AdminID")
                Dim AddedOn As DateTime = DateTime.Now
                Portal.DAL.NSProductModuleManager.Add(ModuleName, Inactive, RelatedToProductID, AddedBy, AddedOn)
            Else
                Portal.DAL.NSProductModuleManager.Update(hdnModuleID.Value, ModuleName, Inactive, RelatedToProductID)
            End If

            Response.Redirect("ManageProductModules.aspx", True)
        End If
    End Sub

    Protected Sub cvValidateModuleName_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles cvValidateModuleName.ServerValidate
        If CInt(hdnModuleID.Value) = 0 OrElse hdnProductID.Value <> ddlProducts.SelectedValue Then
            If Portal.DAL.NSProductModuleManager.ModuleExists(ddlProducts.SelectedValue, txtModuleName.Text.Trim) Then
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        End If
    End Sub
End Class
