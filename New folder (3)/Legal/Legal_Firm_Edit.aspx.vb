Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class admin_Legal_Legal_Firm_Edit
    Inherits System.Web.UI.Page
    Dim dr As SqlDataReader

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("Home") <> Nothing Then
            If Request.QueryString("Home").ToString() <> "" Then
                btnCancel.PostBackUrl = "Legal_Firm.aspx?FirmID=" & CInt(Request.QueryString("ID"))
            Else
                btnCancel.PostBackUrl = "FirmManagement.aspx"
            End If
        Else
            btnCancel.PostBackUrl = "FirmManagement.aspx"
        End If
    End Sub
    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        Dim firmObj As Firm = New Firm()
        If Not Page.IsPostBack Then
            If Request.QueryString("ID") <> Nothing Then
                If Request.QueryString("ID").ToString() <> "" Then
                    hdnFirmID.Value = Request.QueryString("ID")
                    dr = firmObj.GetSingleFirm(CInt(hdnFirmID.Value))
                    If dr.Read() Then
                        txtName.Text = dr.Item("Name").ToString()
                        txtAddress.Text = dr.Item("Address").ToString()
                        txtPhone.Text = dr.Item("Phone").ToString()
                        ddlCountry.SelectedValue = CInt(dr.Item("CountryID"))
                        ddlStates.DataSourceID = "StatesDS"
                        ddlStates.DataBind()
                        txtFax.Text = dr.Item("Fax").ToString()
                        txtWebsite.Text = dr.Item("Website").ToString()
                        ddlFirmType.SelectedValue = dr.Item("Type").ToString()
                        ddlStates.SelectedValue = CInt(dr.Item("StateID"))
                        txtCity.Text = dr.Item("City").ToString()
                        txtZipCode.Text = dr.Item("Zip").ToString()
                        hdnContactID.Value = dr.Item("ContactID").ToString()
                        txtContactName.Text = dr.Item("ContactName").ToString()
                        txtContactTitle.Text = dr.Item("ContactTitle").ToString()
                        txtContactDepartment.Text = dr.Item("Department").ToString()
                        txtContactPhone.Text = dr.Item("ContactPhone").ToString()
                        txtContactFax.Text = dr.Item("ContactFax").ToString()
                        txtContactEmail.Text = dr.Item("ContactEmail").ToString()
                    End If
                    dr.Close()
                End If
            End If
        End If
    End Sub

    Protected Sub btnFirmSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFirmSave.Click
        If Page.IsValid = False Then
            Exit Sub
        End If
        Dim firmObj As Firm = New Firm()
        If Request.QueryString("ID") <> Nothing Then
            If Request.QueryString("ID").ToString() <> "" Then
                hdnFirmID.Value = Request.QueryString("ID")
                If hdnFirmID.Value.ToString() <> "" Then
                    firmObj.ID = CInt(hdnFirmID.Value)
                    firmObj.Name = txtName.Text
                    firmObj.Type = ddlFirmType.SelectedValue
                    firmObj.Address = txtAddress.Text
                    firmObj.Phone = txtPhone.Text
                    firmObj.Country = ddlCountry.SelectedValue
                    firmObj.State = ddlStates.SelectedValue
                    firmObj.City = txtCity.Text
                    firmObj.ZipCode = txtZipCode.Text
                    firmObj.Website = txtWebsite.Text
                    firmObj.Fax = txtFax.Text
                    firmObj.RetValue = 0
                    firmObj.UpdateFirm()
                    firmObj.ContactName = txtContactName.Text
                    firmObj.ContactTitle = txtContactTitle.Text
                    firmObj.Department = txtContactDepartment.Text
                    firmObj.ContactPhone = txtContactPhone.Text
                    firmObj.ContactFax = txtContactFax.Text
                    firmObj.ContactEmail = txtContactEmail.Text
                    firmObj.ID = CInt(hdnContactID.Value)
                    '                    firmObj.UpdateFirmContact()
                End If
                If Not Request.QueryString("Home") Is Nothing Then
                    Response.Redirect("Legal_Firm.aspx?FirmID=" & CInt(Request.QueryString("ID")))
                Else
                    Response.Redirect("FirmManagement.aspx")
                End If
            End If
        End If
    End Sub

    Protected Sub ddlCountry_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.SelectedIndexChanged
        ddlStates.DataSourceID = "StatesDS"
        ddlStates.DataBind()
    End Sub
End Class
