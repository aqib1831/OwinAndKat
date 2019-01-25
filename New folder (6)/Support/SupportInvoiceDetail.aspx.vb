
Partial Class Support_SupportInvoiceDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ClientScript.RegisterClientScriptBlock(Me.GetType, "SelectTab", "parent.SetSelected(8);", True)
            hdnSupportInvoiceID.Value = Request.QueryString("SupportInvoiceID")
            btnSetPaid.Attributes.Add("onclick", "ShowNotConfirm('" & hdnSupportInvoiceID.Value & "'); return false;")
            ifrmStatus.Attributes.Add("src", "SupportInvoicePrint.aspx?SupportInvoiceID=" & hdnSupportInvoiceID.Value)


            hdnSupportInvoiceID.Value = Request.QueryString("SupportInvoiceID")
            Dim DT As Data.DataTable = Portal.BLL.NS.NS_Billing_SupportInvoices.NS_Billing_SupportInvoicesGetbyID(Request.QueryString("SupportInvoiceID"))
            If DT.Rows.Count > 0 Then
                If (CBool(DT.Rows(0).Item("Status"))) Then
                    btnSetPaid.Visible = False
                    lblStatus.Text = "Paid"
                    lblStatus.ForeColor = Drawing.Color.Green
                Else
                    lblStatus.Text = "Unpaid"
                    lblStatus.ForeColor = Drawing.Color.Red
                End If
            End If

        End If
    End Sub
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Portal.BLL.NS.NS_Billing_SupportInvoices.NS_Billing_SupportInvoicesUpdateStatus(hdnSupportInvoiceID.Value, ddlPaymentMethod.SelectedValue, txtQBNumber.Text, Session("AdminID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideNotConfirm", "HideNotConfirm(); ifrmStatus.location='SupportInvoicePrint.aspx?SupportInvoiceID=" & hdnSupportInvoiceID.Value & "'; getElement('" & btnSetPaid.ClientID & "').style.display='none';", True)
        hdnSupportInvoiceID.Value = Request.QueryString("SupportInvoiceID")
        Dim DT As Data.DataTable = Portal.BLL.NS.NS_Billing_SupportInvoices.NS_Billing_SupportInvoicesGetbyID(Request.QueryString("SupportInvoiceID"))
        If DT.Rows.Count > 0 Then
            If (CBool(DT.Rows(0).Item("Status"))) Then
                btnSetPaid.Visible = False
                lblStatus.Text = "Paid"
                lblStatus.ForeColor = Drawing.Color.Green
            Else
                lblStatus.Text = "Unpaid"
                lblStatus.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub

    Protected Sub ddlPaymentMethod_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPaymentMethod.DataBound
        ddlPaymentMethod.Items.Insert(0, New ListItem("Select", "0"))
    End Sub
End Class
