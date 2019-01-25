
Partial Class admin_Legal_FirmMgt
    Inherits System.Web.UI.Page

    
    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        Dim firm As Firm = New Firm()
        firm.Name = txtName.Text
        firm.Address = txtAddress.Text
        firm.Phone = txtPhone.Text
        firm.Country = ddlCountry.SelectedValue
        firm.State = ddlStates.SelectedValue
        firm.City = txtCity.Text
        firm.ZipCode = txtZipCode.Text
        firm.Type = ddlFirmType.SelectedValue
        firm.Fax = txtFax.Text
        firm.Website = txtWebsite.Text
        Dim nFirmID As Integer = firm.AddNewFirm()
        If nFirmID = -1 Then
            lblMsg.Text = "Firm/Vendor with the same Name or Phone Number already exists."
        Else
            firm.ContactName = txtContactName.Text
            firm.ContactTitle = txtContactTitle.Text
            firm.Department = txtContactDepartment.Text
            firm.ContactPhone = txtContactPhone.Text
            firm.ContactFax = txtContactFax.Text
            firm.ContactEmail = txtContactEmail.Text
            firm.IsPrimary = True
            Dim nContactID As Integer = firm.AddFirmContact()
           
            If CInt(SubPageID.Value) = 1 Then
                UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "scrChkCaseParent", "parent.onSaveClick_Case(" & nFirmID & "," & nContactID & ");", True)
                UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CancelFirm", "CancelFirm();", True)
            Else
                If CInt(SubPageID.Value) = 2 Then
                    UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "scrChkIPParent", "parent.onSaveClick_IP(" & nFirmID & "," & nContactID & ");", True)
                    UI.ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CancelFirm", "CancelFirm();", True)
                Else
                    Response.Redirect("FirmManagement.aspx")
                End If
            End If
        
        End If
    End Sub

    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Choose...", -1))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("subpage")) = False Then
            SubPageID.Value = CInt(Request.QueryString("subpage"))
        End If
        If (Not Page.IsPostBack) Then
            ddlCountry.SelectedValue = "2"
        End If
    End Sub

    Protected Sub ddlCountry_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.SelectedValue = 1
        ddlStates.DataBind()
    End Sub
End Class
