
Partial Class admin_Legal_VendorProfile
    Inherits System.Web.UI.Page

    Protected Sub admin_Legal_VendorProfile_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not String.IsNullOrEmpty(Request.QueryString("FirmID")) Then
            hdnFirmID.Value = Request.QueryString("FirmID")
        End If
    End Sub
    Protected Function GetSite(ByVal site As Object) As String
        If (site.ToString().Equals("-") = False) Then
            Return "http://" & site.ToString()
        Else
            Return "http://-"
        End If
        Return "http://-"
    End Function


    Protected Sub dlContacts_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlContacts.DeleteCommand
        If e.CommandName = "Delete" Then
            odsContacts.DeleteParameters("ContactID").DefaultValue = CInt(e.CommandArgument)
            odsContacts.Delete()
            dlContacts.DataBind()
        End If

    End Sub

    Protected Sub dlContacts_EditCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlContacts.EditCommand
        dlContacts.EditItemIndex = e.Item.ItemIndex
        dlContacts.DataBind()
    End Sub

    Protected Sub dlContacts_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlContacts.ItemCommand
        If e.CommandName = "Cancel" Then
            dlContacts.EditItemIndex = -1

            dlContacts.DataBind()
        End If
    End Sub

    Protected Sub dlContacts_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles dlContacts.UpdateCommand
        Dim ID As Integer = CInt(dlContacts.DataKeys(e.Item.ItemIndex))
        Dim Name As String = CType(e.Item.FindControl("txtCName"), TextBox).Text.Trim
        Dim Title As String = CType(e.Item.FindControl("txtCTitle"), TextBox).Text.Trim
        Dim Department As String = CType(e.Item.FindControl("txtCDept"), TextBox).Text.Trim
        Dim Phone As String = CType(e.Item.FindControl("txtCPhone"), TextBox).Text.Trim
        Dim Fax As String = CType(e.Item.FindControl("txtCFax"), TextBox).Text.Trim
        Dim Email As String = CType(e.Item.FindControl("txtCEmail"), TextBox).Text.Trim

        odsContacts.UpdateParameters("ID").DefaultValue = ID
        odsContacts.UpdateParameters("Name").DefaultValue = Name
        odsContacts.UpdateParameters("Title").DefaultValue = Title
        odsContacts.UpdateParameters("Department").DefaultValue = Department
        odsContacts.UpdateParameters("Phone").DefaultValue = Phone
        odsContacts.UpdateParameters("Fax").DefaultValue = Fax
        odsContacts.UpdateParameters("Email").DefaultValue = Email
        odsContacts.Update()
        dlContacts.EditItemIndex = -1
        dlContacts.DataBind()
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click

        odsContacts.InsertParameters("Name").DefaultValue = txtCName.Text
        odsContacts.InsertParameters("Title").DefaultValue = txtCTitle.Text
        odsContacts.InsertParameters("Department").DefaultValue = txtCDept.Text
        odsContacts.InsertParameters("Phone").DefaultValue = txtCPhone.Text
        odsContacts.InsertParameters("Fax").DefaultValue = txtCFax.Text
        odsContacts.InsertParameters("Email").DefaultValue = txtCEmail.Text
        odsContacts.InsertParameters("FirmID").DefaultValue = CInt(hdnFirmID.Value)
        odsContacts.Insert()
        dlContacts.EditItemIndex = -1
        dlContacts.DataBind()
        txtCName.Text = ""
        txtCTitle.Text = ""
        txtCDept.Text = ""
        txtCPhone.Text = ""
        txtCFax.Text = ""
        txtCEmail.Text = ""
    End Sub
    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.Items.FindByValue(fvVendor.DataKey("StateID")) IsNot Nothing Then
            ddl.Items.FindByValue(fvVendor.DataKey("StateID")).Selected = True
        End If
    End Sub
    Protected Sub ddlFirmType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.Items.FindByValue(fvVendor.DataKey("Type")) IsNot Nothing Then
            ddl.Items.FindByValue(fvVendor.DataKey("Type")).Selected = True
        End If
    End Sub

    Protected Sub fvVendor_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdateEventArgs) Handles fvVendor.ItemUpdating
        'odsFirm.UpdateParameters("Type").DefaultValue = CType(fvVendor.FindControl("ddlFirmType"), DropDownList).SelectedValue
    End Sub

    Protected Sub odsFirm_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsFirm.Updated
        Dim retVal As Int32 = e.ReturnValue
        If (retVal = -1) Then
            lblMsg.Text = "Firm/Vendor with the same name and phone already exists."
            fvVendor.ChangeMode(FormViewMode.Edit)
        Else
            lblMsg.Text = ""
        End If
    End Sub
End Class
