Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class admin_Legal_Legal_Firm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnFirmID.Value = Request.QueryString("FirmID")
        Dim firmObj As Firm = New Firm()
        Dim dr As SqlDataReader = firmObj.GetSingleFirm(CInt(hdnFirmID.Value))
        If dr.Read() Then
            lblHeading.Text = "Firm/Vendor Profile" 'Server.HtmlEncode(Functions.StringTruncate(dr("Name").ToString(), 30))
            'lblHeading.ToolTip = Server.HtmlEncode(dr("Name").ToString())
            lblName.Text = Server.HtmlEncode(dr("Name").ToString())
            lblTitle.Text = Server.HtmlEncode(dr("Title").ToString())
            lblAddress.Text = Server.HtmlEncode(dr("Address").ToString())
            lblPhone.Text = Server.HtmlEncode(dr("Phone").ToString())
            lblCountry.Text = dr("Country").ToString()
            lblState.Text = dr("State").ToString()
            lblCity.Text = Server.HtmlEncode(dr("City").ToString())
            lblZipCode.Text = Server.HtmlEncode(dr("Zip").ToString())
            lblType.Text = dr("FirmType").ToString()
            If dr("Fax").ToString() <> "" Then
                lblFax.Text = Server.HtmlEncode(dr("Fax").ToString())
            End If
            If dr("WebSite").ToString() <> "" Then
                lblWebSite.Text = Server.HtmlEncode(dr("WebSite").ToString())
            Else
                lblWebSite.Text = "&nbsp;"
            End If
            lblContactName.Text = Server.HtmlEncode(dr("ContactName").ToString())
            lblContactTitle.Text = Server.HtmlEncode(dr("ContactTitle").ToString())
            If dr("Department").ToString() <> "" Then
                lblDept.Text = Server.HtmlEncode(dr("Department").ToString())
            Else
                lblDept.Text = "&nbsp;"
            End If

            lblContactPhone.Text = Server.HtmlEncode(dr("ContactPhone").ToString())
            If dr("ContactFax").ToString() <> "" Then
                lblContactFax.Text = Server.HtmlEncode(dr("ContactFax").ToString())
            Else
                lblContactFax.Text = "&nbsp;"
            End If
            If dr("ContactEmail").ToString() <> "" Then
                lblContactEmail.Text = Server.HtmlEncode(dr("ContactEmail").ToString())
            Else
                lblContactEmail.Text = "&nbsp;"
            End If

            btnEdit.PostBackUrl = "Legal_Firm_Edit.aspx?ID=" & hdnFirmID.Value & "&Home=0"
            btnBack.PostBackUrl = "FirmManagement.aspx"
        End If
        dr.Close()
    End Sub
End Class
