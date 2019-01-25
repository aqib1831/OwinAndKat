Imports System.Data.SqlClient
Imports System.Data
Imports System.Collections.Generic

Partial Class Support_SupportInvoicePrint
    Inherits System.Web.UI.Page
    Dim GrandTotal As Decimal = 0.0
    Dim Total As Decimal = 0.0
    Dim Tax As Decimal = 0.0
    Dim TaxRate As Decimal = 0.0

   

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            hdnSupportInvoiceID.Value = Request.QueryString("SupportInvoiceID")
            Dim DT As DataTable = Portal.BLL.NS.NS_Billing_SupportInvoices.NS_Billing_SupportInvoicesGetbyID(Request.QueryString("SupportInvoiceID"))
            If DT.Rows.Count > 0 Then
                lblInvoceNumber.Text = DT.Rows(0).Item("ID").ToString().PadLeft(4, CChar(CStr(0)))
                lblInvoiceDate.Text = CDate(DT.Rows(0).Item("GeneratedOn")).ToString("MMM dd, yyyy")
                lblStoreName.Text = DT.Rows(0).Item("StoreNumber").ToString() & " - " & DT.Rows(0).Item("StoreNick").ToString()
                lblAddress.Text = DT.Rows(0).Item("Address")
                lblCityStateCodeZip.Text = DT.Rows(0).Item("City").ToString() & ", " & DT.Rows(0).Item("StateCode").ToString() & " " & DT.Rows(0).Item("ZIP").ToString()
                lblCountry.Text = DT.Rows(0).Item("Country")
                lblPhone.Text = DT.Rows(0).Item("Phone")
                lblCoporateEmail.Text = DT.Rows(0).Item("CorporateEmail")
                If (CBool(DT.Rows(0).Item("Status"))) Then
                    tblPaid.Visible = True
                    tblUnpaid.Visible = False
                    lblPaymentMethod.Text = DT.Rows(0).Item("PaymentMethodName")
                    lblQBRefnumber.Text = DT.Rows(0).Item("QuickBookInvoiceNo")
                    lblBy.Text = DT.Rows(0).Item("PaymentBy") & " On " & CDate(DT.Rows(0).Item("PaymentDate")).ToString("MMM dd, yyyy")
                Else
                    tblPaid.Visible = False
                    tblUnpaid.Visible = True
                End If
            End If
        End If
    End Sub

    Protected Sub RptmainProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RptmainProducts.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Total += e.Item.DataItem("BillingAmount")
            GrandTotal = Functions.IfNull(e.Item.DataItem("GrandTotal"), 0.0)
            Tax = e.Item.DataItem("Tax")
            TaxRate = e.Item.DataItem("TaxRate")
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            Dim lblTaxRate As Label = CType(e.Item.FindControl("lblTaxRate"), Label)
            CType(e.Item.FindControl("lblProductTotal"), Label).Text = FormatNumber(Total, 2)
            CType(e.Item.FindControl("lblGrandTotal"), Label).Text = FormatNumber(GrandTotal, 2)
            CType(e.Item.FindControl("lblTax"), Label).Text = FormatNumber(Tax, 2)
            lblTaxRate.Text = "(" + FormatNumber(TaxRate, 1).ToString() + "%)"
            If FormatNumber(TaxRate, 1) <> 0 Then
                lblTaxRate.Attributes.Add("style", "visibility:inline;text-align: right; font-weight:normal; font-size: 11px")
            Else
                lblTaxRate.Attributes.Add("style", "visibility:hidden;text-align: right; font-weight:normal; font-size: 11px")
            End If


        End If
    End Sub

End Class