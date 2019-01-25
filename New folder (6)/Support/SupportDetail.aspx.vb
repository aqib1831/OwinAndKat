Imports System.Collections.Generic
Imports System.Data
Partial Class Support_SupportDetail
    Inherits System.Web.UI.Page
    Dim TotalNoOfProducts As Integer = 0
    'Dim TotalAmount As Double = 0
    Dim TotalRowsCount As Integer = 0
    Dim Prev_Row_FranchiseID As Integer = 0
    Dim Ds As New DataSet


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlClient.DataBind()
            ddlProducts.DataBind()
            Dim ReportID As Integer = Request.QueryString("ReportID")
            Dim ReportDate As Date = Request.QueryString("ReportDate")
            Dim ClientID As Integer = Request.QueryString("ClientID")
            'Dim FranchiseID As Integer = Request.QueryString("FranchiseID")
            Dim ProductID As Integer = CInt(Request.QueryString("ProductID"))
            hdnReportDate.Text = ReportDate
            hdnReportID.Text = ReportID
            ddlClient.SelectedValue = ClientID
            ddlProducts.SelectedValue = ProductID
            ddlYears.SelectedValue = ReportDate.Year
            ddlMonths.SelectedValue = ReportDate.Month.ToString.PadLeft(2, "0")
            lbltitle.Text = ReportDate.ToString("MMMM yyyy")
            btnBack.PostBackUrl = "SupportClient.aspx?ReportDate=" & ReportDate
            'Ds = Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForFranchises(ddlMonths.SelectedValue & "-01-" & ddlYears.SelectedValue, ClientID, 0, ProductID) '"04-01-2009""2009-04-01"
            'gvFranchiseSupport.DataSource = Ds.Tables(1)
            'gvFranchiseSupport.DataBind()
        End If
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlProducts_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.DataBound
        ddlProducts.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub gvFranchiseSupport_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvFranchiseSupport.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvFranchiseSupport.SortExpression = button.CommandArgument Then
                            If gvFranchiseSupport.SortDirection = SortDirection.Ascending Then
                                hdnsortby.text = gvFranchiseSupport.SortExpression
                                button.Text += " &nbsp;<img src='../images/asc.gif' title='Sort ascending' style='vertical-align:middle; border:0;'  />"
                            Else
                                hdnsortby.text = gvFranchiseSupport.SortExpression & " DESC"
                                button.Text += " &nbsp;<img src='../images/desc.gif' title='Sort descending' style='vertical-align:middle; border:0;'  />"
                            End If
                        End If
                    End If
                End If
            Next
        End If
    End Sub

    Protected Sub gvFranchiseSupport_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvFranchiseSupport.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim lblBillingType As Label = CType(e.Row.FindControl("lblBillingType"), Label)

            If e.Row.DataItem("IsExempted") Then
                lblBillingType.Text = "Exempted (<span style='font-size:10px;'>Until " & CDate(e.Row.DataItem("ExemptedUntil")).ToString("MMM dd, yyyy") & "</span>)"
                lblBillingType.ToolTip = "Exempted Until " & CDate(e.Row.DataItem("ExemptedUntil")).ToString("MMM dd, yyyy")
            ElseIf (e.Row.DataItem("IsPartial")) Then
                lblBillingType.Text = "Partial"
            Else
                lblBillingType.Text = ""
            End If
        End If
        If (e.Row.RowType = DataControlRowType.Footer) Then
            lblBillingAmountTotal.Text = FormatNumber(Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForFranchisesSumAmount(hdnReportID.Text, ddlClient.SelectedValue, 0, ddlProducts.SelectedValue, txtSearch.Text, ddlStatus.SelectedValue), 2)
            If gvFranchiseSupport.Rows.Count > 0 Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "asas", "AdjustHeight(0);", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "asas", "AdjustHeight(1);", True)
            End If
        End If
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvFranchiseSupport.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvFranchiseSupport.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvFranchiseSupport.PageIndex = 0) Then
                'Disable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "../images/back_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = False
                'Disalbe First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "../images/First_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                'Enable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "../images/back_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = True

                'Enable Last First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "../images/First_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'To enable and Disable Next Image button.
            If (gvFranchiseSupport.PageIndex = gvFranchiseSupport.PageCount - 1) Then
                'Disable Next Button
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "../images/Next_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = False

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "../images/Last_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "../images/Next_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = True

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "../images/Last_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'Setting the No of Records that are being shown 
            If (((gvFranchiseSupport.PageIndex + 1) * gvFranchiseSupport.PageSize) < gvFranchiseSupport.PageCount * gvFranchiseSupport.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvFranchiseSupport.PageIndex + 1) * gvFranchiseSupport.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvFranchiseSupport.PageIndex * gvFranchiseSupport.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If
    End Sub

    Protected Sub odsSupport_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsSupport.Selected
        If (IsNumeric(e.ReturnValue)) Then
            ltrlRecordCount.Text = e.ReturnValue.ToString
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showcount", "parent.showcount(" & e.ReturnValue.ToString() & ");", True)
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub

    'Protected Sub ddlMonths_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlMonths.SelectedIndexChanged
    '    Ds = Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForClients(CDate(ddlMonths.SelectedValue & "-01-" & ddlYears.SelectedValue))
    '    rptClients.DataSource = Ds.Tables(1)
    '    rptClients.DataBind()
    'End Sub

    'Protected Sub ddlYears_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlYears.SelectedIndexChanged
    '    Ds = Portal.BLL.NS.NS_BillingReport.NS_BillingReportGetForClients(ddlMonths.SelectedValue & "-01-" & ddlYears.SelectedValue)
    '    rptClients.DataSource = Ds.Tables(1)
    '    rptClients.DataBind()
    'End Sub

    'Protected Sub rptProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) ''Handles rptProducts.ItemDataBound
    '    If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
    '        ProductCount = ProductCount + 1
    '        Dim str As String = e.Item.DataItem("ProductName")
    '        If Not Dt.Columns.Contains(e.Item.DataItem("ProductID")) Then
    '            AddColumn(e.Item.DataItem("ProductID"))
    '        End If
    '    End If
    'End Sub

    'Protected Sub rptFranchises_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptFranchises.ItemDataBound
    '    If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
    '        'If ClientID = e.Item.DataItem("ClientID") Then
    '        '    CType(e.Item.FindControl("lblClientTotal"), Label).Text = FormatCurrency(ClientTotal)
    '        '    CType(e.Item.FindControl("lblFranchiseCount"), Label).Text = FranchiseCount
    '        '    GrandTotal += ClientTotal
    '        '    TotalFranchiseCount += FranchiseCount
    '        '    ClientTotal = 0
    '        '    FranchiseCount = 0
    '        '    NoOfClients = NoOfClients + 1
    '        'End If
    '        'e.Item
    '        'ElseIf e.Item.ItemType = ListItemType.Header Then
    '        '    'Dim rptProducts As Repeater = CType(e.Item.FindControl("rptProducts"), Repeater)
    '        '    rptProducts.DataSource = Ds.Tables(0)
    '        '    rptProducts.DataBind()
    '        '    'For Each Item As RepeaterItem In rptProductsFooter.Items
    '        '    '    CType(Item.FindControl("lblProductTotal"), Label).Text = FormatCurrency(Dt.Rows(0).Item(CType(Item.FindControl("lblProductID"), Label).Text))
    '        '    'Next
    '        'ElseIf e.Item.ItemType = ListItemType.Footer Then
    '        '    Dim rptProductstd As Repeater = CType(e.Item.FindControl("rptProductstd"), Repeater)
    '        '    rptProductstd.DataSource = Ds.Tables(0)
    '        '    rptProductstd.DataBind()
    '        '    rptProductsFooter.DataSource = Ds.Tables(0)
    '        '    rptProductsFooter.DataBind()
    '        '    For Each Item As RepeaterItem In rptProductsFooter.Items
    '        '        CType(Item.FindControl("lblProductTotal"), Label).Text = FormatCurrency(Dt.Rows(0).Item(CType(Item.FindControl("lblProductID"), Label).Text))
    '        '    Next
    '        '    lblGrandTotal.Text = FormatCurrency(GrandTotal)
    '        '    lblTotalFranchiseCount.Text = TotalFranchiseCount

    '        '    If (NoOfClients Mod 2) = 0 Then 'Even
    '        '        ClientScript.RegisterStartupScript(Me.GetType, "trFooterClass", "trFooterClass('ItemRowImgAlter');", True)
    '        '    Else 'Odd
    '        '        ClientScript.RegisterStartupScript(Me.GetType, "trFooterClass", "trFooterClass('ItemRowImg');", True)
    '        '    End If
    '    End If
    'End Sub

    'Protected Sub rptFranchiseProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) ''Handles rptStoreProducts.ItemDataBound
    '    If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
    '        'If Dt.Rows.Count = 0 Then
    '        '    AddRow()
    '        'End If
    '        ''''''''

    '        If e.Item.DataItem("FranchiseID") = Prev_Row_FranchiseID Then
    '            e.Item.FindControl("span1").Visible = False
    '            e.Item.FindControl("span2").Visible = False
    '        Else
    '            Prev_Row_FranchiseID = e.Item.DataItem("FranchiseID")
    '        End If
    '        TotalRowsCount = TotalRowsCount = 1
    '        Dim lblBillingType As Label = CType(e.Item.FindControl("lblBillingType"), Label)

    '        If e.Item.DataItem("IsExempted") Then
    '            lblBillingType.Text = "Exempted"
    '        ElseIf (e.Item.DataItem("IsPartial")) Then
    '            lblBillingType.Text = "Partial"
    '        Else
    '            lblBillingType.Text = ""
    '        End If

    '        'Dim lblPrice As Label = CType(e.Item.FindControl("lblPrice"), Label)
    '        'lblPrice.Attributes.Add("OnClick", "alert('ClientID=" & e.Item.DataItem("ClientID") & ";ProductID=" & e.Item.DataItem("ProductID") & "');")
    '        'lblPrice.Style.Add("cursor", "pointer")
    '        '''''''
    '        'Dim BillingAmount As Double = e.Item.DataItem("BillingAmount")
    '        'FranchiseCount += e.Item.DataItem("FranchiseCount")
    '        'ClientTotal += BillingAmount
    '        'ClientID = e.Item.DataItem("ClientID")
    '        'Dim column As String = CStr(e.Item.DataItem("ProductID"))
    '        'UpdateDateTablePrice(column, BillingAmount)
    '    End If
    'End Sub

    'Sub AddColumn(ByVal name As String)
    '    Dim column As New System.Data.DataColumn()
    '    column.DataType = Type.GetType("System.String")
    '    column.ColumnName = name
    '    column.ReadOnly = False
    '    column.Unique = False
    '    Dt.Columns.Add(column)
    'End Sub
    'Sub AddRow()
    '    Dim row As DataRow
    '    row = Dt.NewRow()
    '    For Each column As DataColumn In Dt.Columns
    '        row(CStr(column.ColumnName)) = "0.0"
    '    Next
    '    Dt.Rows.Add(row)
    '    Dt.AcceptChanges()
    'End Sub
    'Sub UpdateDateTablePrice(ByVal column As String, ByVal Price As Double)
    '    Dt.Rows(0).BeginEdit()
    '    Dt.Rows(0).Item(column) = CStr(CType(Dt.Rows(0).Item(column), Double) + Price)
    '    Dt.Rows(0).EndEdit()
    '    Dt.Rows(0).AcceptChanges()
    'End Sub

End Class
