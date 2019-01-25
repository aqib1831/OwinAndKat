Imports System.Collections.Generic
Imports System.Data
Partial Class Support_SupportClient
    Inherits System.Web.UI.Page
    Dim ClientTotal As Double = 0
    Dim NoOfClients As Integer = 0
    Dim ProductTotal As Double = 0
    Dim GrandTotal As Double = 0
    Dim ProductCount As Integer = 0
    Dim ReportID As Integer = 0
    'Dim FranchiseCount As Integer = 0
    'Dim TotalFranchiseCount As Integer = 0
    Dim ClientID As Integer = 0
    Dim ProductID As Integer = 0
    Dim Dt As New DataTable
    Dim Ds As New DataSet


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlYears.DataBind()
            Dim ReportDate As Date = IIf(String.IsNullOrEmpty(Request.QueryString("ReportDate")), Date.Now, Request.QueryString("ReportDate"))
            ddlYears.SelectedValue = ReportDate.Year
            ddlMonths.SelectedValue = ReportDate.Month.ToString.PadLeft(2, "0")
            Ds = Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForClients(ddlMonths.SelectedValue & "-01-" & ddlYears.SelectedValue) '"04-01-2009""2009-04-01"
            rptClients.DataSource = Ds.Tables(1)
            rptClients.DataBind()
        End If
    End Sub

    Protected Sub ddlMonths_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlMonths.SelectedIndexChanged
        Dt = New DataTable
        GrandTotal = 0
        Ds = Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForClients(CDate(ddlMonths.SelectedValue & "-01-" & ddlYears.SelectedValue))
        rptClients.DataSource = Ds.Tables(1)
        rptClients.DataBind()
        ScriptManager.GetCurrent(Me).SetFocus(ddlMonths)
    End Sub

    Protected Sub ddlYears_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlYears.SelectedIndexChanged
        Dt = New DataTable
        GrandTotal = 0
        Ds = Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForClients(ddlMonths.SelectedValue & "-01-" & ddlYears.SelectedValue)
        rptClients.DataSource = Ds.Tables(1)
        rptClients.DataBind()
    End Sub

    Protected Sub rptProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) ''Handles rptProducts.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            ProductCount = ProductCount + 1
            Dim str As String = e.Item.DataItem("ProductName")
            If Not Dt.Columns.Contains(e.Item.DataItem("ProductID")) Then
                AddColumn(e.Item.DataItem("ProductID"))
            End If
        End If
    End Sub

    Protected Sub rptClients_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptClients.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            If ClientID = e.Item.DataItem("ClientID") Then
                Dim lblClientTotal As Label = CType(e.Item.FindControl("lblClientTotal"), Label)
                lblClientTotal.Text = FormatNumber(ClientTotal, 2)
                lblClientTotal.Attributes.Add("OnClick", "ShowDetail('" & e.Item.DataItem("ReportID") & "','" & e.Item.DataItem("ClientID") & "','0');")
                lblClientTotal.Style.Add("cursor", "pointer")
                ReportID = e.Item.DataItem("ReportID")
                'Dim lblFranchiseCount As Label = CType(e.Item.FindControl("lblFranchiseCount"), Label)
                'lblFranchiseCount.Text = FranchiseCount

                'lblFranchiseCount.Attributes.Add("OnClick", "ShowDetail('" & e.Item.DataItem("ClientID") & "','0');")
                'lblFranchiseCount.Style.Add("cursor", "pointer")

                GrandTotal += ClientTotal
                'TotalFranchiseCount += FranchiseCount
                ClientTotal = 0
                'FranchiseCount = 0
                NoOfClients = NoOfClients + 1
            End If
        ElseIf e.Item.ItemType = ListItemType.Header Then
            'Dim rptProducts As Repeater = CType(e.Item.FindControl("rptProducts"), Repeater)
            rptProducts.DataSource = Ds.Tables(0)
            rptProducts.DataBind()
            
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            Dim rptProductstd As Repeater = CType(e.Item.FindControl("rptProductstd"), Repeater)
            rptProductstd.DataSource = Ds.Tables(0)
            rptProductstd.DataBind()
            rptProductsFooter.DataSource = Ds.Tables(0)
            rptProductsFooter.DataBind()
            For Each Item As RepeaterItem In rptProductsFooter.Items
				CType(Item.FindControl("lblProductTotal"), Label).Text = FormatNumber(Dt.Rows(0).Item(CType(Item.FindControl("lblProductID"), Label).Text), 2)
            Next
            lblGrandTotal.Text = FormatNumber(GrandTotal, 2)
            lblGrandTotal.Attributes.Add("OnClick", "ShowDetail('" & ReportID & "','0','0');")
            lblGrandTotal.Style.Add("cursor", "pointer")
            'lblTotalFranchiseCount.Text = TotalFranchiseCount

            If (NoOfClients Mod 2) = 0 Then 'Even
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "trFooterClass", "trFooterClass('ItemRowImgAlter','" & rptClients.Items.Count & "');", True)
            Else 'Odd
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "trFooterClass", "trFooterClass('ItemRowImg','" & rptClients.Items.Count & "');", True)
            End If
            upKeys.Update()
        End If
    End Sub

    Protected Sub rptClientProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) ''Handles rptStoreProducts.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            If Dt.Rows.Count = 0 Then
                AddRow()
            End If
            ''''''''
            Dim lblPrice As Label = CType(e.Item.FindControl("lblPrice"), Label)
            lblPrice.Attributes.Add("OnClick", "ShowDetail('" & e.Item.DataItem("ReportID") & "','" & e.Item.DataItem("ClientID") & "','" & e.Item.DataItem("ProductID") & "');")
            lblPrice.Style.Add("cursor", "pointer")
            '''''''''
            Dim BillingAmount As Double = e.Item.DataItem("BillingAmount")
            'FranchiseCount += e.Item.DataItem("FranchiseCount")
            ClientTotal += BillingAmount
            ClientID = e.Item.DataItem("ClientID")
            Dim column As String = CStr(e.Item.DataItem("ProductID"))
            UpdateDateTablePrice(column, BillingAmount)
        End If
    End Sub

    Sub AddColumn(ByVal name As String)
        Dim column As New System.Data.DataColumn()
        column.DataType = Type.GetType("System.String")
        column.ColumnName = name
        column.ReadOnly = False
        column.Unique = False
        Dt.Columns.Add(column)
    End Sub
    Sub AddRow()
        Dim row As DataRow
        row = Dt.NewRow()
        For Each column As DataColumn In Dt.Columns
            row(CStr(column.ColumnName)) = "0.0"
        Next
        Dt.Rows.Add(row)
        Dt.AcceptChanges()
    End Sub
    Sub UpdateDateTablePrice(ByVal column As String, ByVal Price As Double)
        Dt.Rows(0).BeginEdit()
        Dt.Rows(0).Item(column) = CStr(CType(Dt.Rows(0).Item(column), Double) + Price)
        Dt.Rows(0).EndEdit()
        Dt.Rows(0).AcceptChanges()
    End Sub

End Class
