Imports System.Collections.Generic
Imports System.Data
Partial Class Support_SupportDetailReport
    Inherits System.Web.UI.Page
    Dim TotalAmount As Double = 0
    Dim TotalRowsCount As Integer = 0
    Dim Prev_Row_FranchiseID As Integer = 0



    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        If Not String.IsNullOrEmpty(Request.QueryString("IsXLS")) AndAlso CBool(Request.QueryString("IsXLS")) Then
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment; filename=FranchiseeSupportReport.xls")
            Response.ContentType = "application/vnd.ms-excel"
        End If
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If Not IsPostBack Then
            Dim ReportDate As Date = Request.QueryString("ReportDate")
            Dim ClientID As Integer = Request.QueryString("ClientID")
            'Dim FranchiseID As Integer = Request.QueryString("FranchiseID")
            Dim ProductID As Integer = CInt(Request.QueryString("ProductID"))
            Dim Status As Integer = CInt(Request.QueryString("Status"))
            'ddlYears.SelectedValue = ReportDate.Year
            'ddlMonths.SelectedValue = ReportDate.Month.ToString.PadLeft(2, "0")

            lblReportDate.Text = "For " & ReportDate.ToString("MMMM yyyy")

            If ClientID > 0 Then
                lblClient.Text = "Client:&nbsp;" & GetClientByID(ClientID)
            End If
           
            If ProductID > 0 Then
                lblProduct.Text = "Product:&nbsp;" & GetByProductID(ProductID)
            End If
            If Status = 1 Then
                lblStatus.Text = "Status:&nbsp;Exempted"
            ElseIf Status = 2 Then
                lblStatus.Text = "Status:&nbsp;Partial"
            ElseIf Status = 3 Then
                lblStatus.Text = "Status:&nbsp;Exempted & Partial"
            End If
            'ClientScript.RegisterStartupScript(Me.GetType, "", "")
        End If
    End Sub
    Public Function GetClientByID(ByVal ClientID As Integer) As String
        Dim strClientName As String = ""
        Dim objCol As List(Of Portal.BLL.Client.Clients) = Portal.BLL.Client.Clients.ClientsGetByID(ClientID)
        If objCol.Count > 0 Then
            strClientName = objCol.Item(0).Name.ToString
        End If
        Return strClientName
    End Function
    Public Function GetByProductID(ByVal ProductID As Integer) As String
        Dim strProductName As String = ""
        Dim objCol As List(Of Portal.BLL.NSProducts) = Portal.BLL.NSProducts.NS_ProductsGetByID(ProductID)
        If objCol.Count > 0 Then
            strProductName = objCol.Item(0).Title
        End If
        Return strProductName
    End Function


    Protected Sub rptFranchises_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptFranchises.ItemDataBound
       If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim lblBillingType As Label = CType(e.Item.FindControl("lblBillingType"), Label)
            If e.Item.DataItem("IsExempted") Then
                lblBillingType.Text = "Exempted"
            ElseIf (e.Item.DataItem("IsPartial")) Then
                lblBillingType.Text = "Partial"
            Else
                lblBillingType.Text = ""
            End If
            TotalAmount = TotalAmount + CType(e.Item.DataItem("BillingAmount"), Double)
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            Dim lblTotalAmount As Label = CType(e.Item.FindControl("lblTotalAmount"), Label)
            lblTotalAmount.Text = FormatNumber(TotalAmount, 2)
        End If
    End Sub

End Class
