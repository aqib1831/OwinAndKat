Imports System.Collections.Generic
Imports System.Data
Partial Class Support_SupportProcess
    Inherits System.Web.UI.Page
    Private total As Double = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ClientScript.RegisterClientScriptBlock(Me.GetType, "SelectTab", "parent.SetSelected(6);", True)
            rptProducts.DataSource = Nothing
            rptProducts.DataBind()
        End If
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Select", "0"))
    End Sub

    Protected Sub ddlCountry_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.Items.Insert(0, New ListItem("Select", "0"))
    End Sub

    Protected Sub ddlReport_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReport.DataBound
        ddlReport.Items.Insert(0, New ListItem("Select", "0"))
    End Sub

    Protected Sub ddlProducts_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.DataBound
        ddlProducts.Items.Insert(0, New ListItem("All", "0"))
    End Sub

    Protected Sub ddlClient_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.SelectedIndexChanged
        FillRepeater()
    End Sub

    Protected Sub ddlCountry_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.SelectedIndexChanged
        FillRepeater()
    End Sub

    Protected Sub ddlReport_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReport.SelectedIndexChanged
        FillRepeater()
    End Sub

    Protected Sub ddlProducts_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.SelectedIndexChanged
        FillRepeater()
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        FillRepeater()
    End Sub

    Private Sub FillRepeater()
        If ddlClient.SelectedValue > 0 AndAlso ddlCountry.SelectedValue > 0 AndAlso ddlReport.SelectedValue > 0 Then
            rptProducts.DataSource = Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForProcessing(ddlClient.SelectedValue, ddlCountry.SelectedValue, ddlReport.SelectedValue, ddlProducts.SelectedValue, txtSearch.Text, "")
        Else
            trNoRecord.Style.Add("Display", "inline")
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "trhide", "trhide();", True)
        End If
        rptProducts.DataBind()
    End Sub

    Protected Sub rptProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptProducts.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            total += e.Item.DataItem("BillingAmount")
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If rptProducts.Items.Count = 0 Then
                CType(e.Item.FindControl("trNoRecord2"), HtmlTableRow).Style.Add("Display", "Inline")
                trNoRecord.Style.Add("Display", "none")
                CType(e.Item.FindControl("trFooter"), HtmlTableRow).Style.Add("Display", "none")
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "trhide", "trhide();", True)
            Else
                CType(e.Item.FindControl("trNoRecord2"), HtmlTableRow).Style.Add("Display", "none")
                trNoRecord.Style.Add("Display", "none")
                CType(e.Item.FindControl("trfooter"), HtmlTableRow).Style.Add("Display", "inline")
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "trdisplay", "trdisplay('" & FormatNumber(total, 2) & "',' " & FormatNumber(total, 2) & " ');", True)
                ltrlRecordCount.Text = rptProducts.Items.Count
            End If
        End If
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click
        If GetStrIDs().Length > 0 Then
            Dim BankBatchAffect As Integer = Portal.BLL.NS.NS_Billing_BankBatch.NS_Billing_BankBatchAdd(ddlCountry.SelectedValue, ddlClient.SelectedValue, ddlReport.SelectedValue, GetStrIDs)
            If BankBatchAffect > 0 Then
                Response.Redirect("SupportBankBatch.aspx")
            End If
        End If
    End Sub
    Private Function GetStrIDs() As String
        Dim strIDs As String = ""
        For index As Integer = 0 To rptProducts.Items.Count - 1
            If CType(rptProducts.Items(index).FindControl("chkSelected"), CheckBox).Checked = True Then
                strIDs += CType(rptProducts.Items(index).FindControl("lblID"), Label).Text & ","
            End If
        Next
        If strIDs.Length > 0 AndAlso strIDs.EndsWith(",") Then strIDs = strIDs.Remove(strIDs.Length - 1, 1)
        Return strIDs
    End Function
End Class
