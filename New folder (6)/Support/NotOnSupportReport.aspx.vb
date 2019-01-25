Imports System.Collections.Generic
Partial Class Support_NotOnSupportReport
    Inherits System.Web.UI.Page
    Dim rowCount As Integer = 0
    Dim rowPriceCount As Integer = 0

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Not String.IsNullOrEmpty(Request.QueryString("IsXLS")) AndAlso CBool(Request.QueryString("IsXLS")) Then
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment; filename=OnSupport.xls")
            Response.ContentType = "application/vnd.ms-excel"
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        showClientOrState()
        odsSupport.SelectParameters("sortBy").DefaultValue = Request.QueryString("sortBy")
    End Sub

    Public Sub showClientOrState()
        If (CInt(Request.QueryString("ddlClient")) > 0 AndAlso CInt(Request.QueryString("ddlStores")) = 0) Then
            lblShowClientOrState.Text = "Client:&nbsp;" & GetClientByID(Request.QueryString("ddlClient"))
        ElseIf (CInt(Request.QueryString("ddlStores")) > 0) Then
            Dim colFranchises As New System.Collections.Generic.List(Of Portal.BLL.Franchises)()
            colFranchises = Portal.BLL.Franchises.FranchiseGetByID(0, Request.QueryString("ddlStores"))
            If colFranchises.Count > 0 Then
                lblShowClientOrState.Text = "Store:&nbsp;" & colFranchises.Item(0).StoreNick
            End If
        Else
            divClientOrState.Visible = False
        End If
        If (CInt(Request.QueryString("ddlProducts")) > 0) Then
            Dim colNS_Products As New List(Of Portal.BLL.NSProducts)()
            colNS_Products = Portal.BLL.NSProducts.NS_ProductsGetByID(Request.QueryString("ddlProducts"))
            If colNS_Products.Count > 0 Then
                lblProduct.Text = "Product:&nbsp;" & colNS_Products.Item(0).Title
            End If
        Else
            divProduct.Visible = False
        End If
        If (CInt(Request.QueryString("ddlStoreStatus")) > 0) Then
            lblStoreStatus.Text = "Store Status:&nbsp;" & Functions.GetStoreStatus(Request.QueryString("ddlStoreStatus"))
        Else
            divStoreStatus.Visible = False
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

    Protected Sub rptReport_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptReport.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            rowCount += 1
            rowPriceCount += CType(CType(e.Item.FindControl("lblPrice"), Label).Text, Double)
            'If CInt(Request.QueryString("ddlClient")) > 0 Then
            '    Dim tdClientCode As HtmlTableCell = CType(e.Item.FindControl("tdClientCode"), HtmlTableCell)
            '    tdClientCode.Visible = False
            'End If
        End If
        'If e.Item.ItemType = ListItemType.Header Then
        '    If CInt(Request.QueryString("ddlClient")) > 0 Then
        '        Dim tdClient As HtmlTableCell = CType(e.Item.FindControl("tdClient"), HtmlTableCell)
        '        tdClient.Visible = False
        '    End If
        'End If
        If e.Item.ItemType = ListItemType.Footer Then
            Dim tblNoRecord As HtmlTable = CType(e.Item.FindControl("tblNoRecord"), HtmlTable)
            Dim tblFooter As HtmlTable = CType(e.Item.FindControl("tblFooter"), HtmlTable)
            Dim lblTotalLicenses As Label = CType(e.Item.FindControl("lblTotalLicenses"), Label)
            Dim lblTotalPrice As Label = CType(e.Item.FindControl("lblTotalPrice"), Label)

            If rowCount > 0 Then
                tblNoRecord.Visible = False
                tblFooter.Visible = True
                lblTotalLicenses.Text = rowCount
                lblTotalPrice.Text = FormatCurrency(rowPriceCount)
            Else
                tblNoRecord.Visible = True
                tblFooter.Visible = False
            End If
        End If
    End Sub
End Class
