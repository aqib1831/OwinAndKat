Imports System.Data
Imports Portal.BLL.PM

Partial Class PM_MyTickets
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Protected CheckBoxesDataTable As DataTable
    Protected CheckBoxesRowsCount As Integer = 0
    Protected CheckBoxesTypeDataTable As DataTable
    Protected CheckBoxesTypeRowCount As Integer = 0
    Protected CheckBoxesStatusDataTable As DataTable
    Protected CheckBoxesStatusRowCount As Integer = 0

#Region "Page Events"
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Overloads Overrides Sub Render(ByVal writer As HtmlTextWriter)

        Dim memorystream As New System.IO.MemoryStream()
        Dim streamwriter As New System.IO.StreamWriter(memorystream)
        Dim htmltextwriter As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(streamwriter)
        MyBase.Render(htmltextwriter)

        htmltextwriter.Flush()
        htmltextwriter.Dispose()

        Dim strmRdr As New System.IO.StreamReader(memorystream)
        strmRdr.BaseStream.Position = 0
        Dim pageContent As String = strmRdr.ReadToEnd()
        strmRdr.Dispose()
        memorystream.Dispose()
        If Not Page.IsPostBack Then
            pageContent = Functions.RemoveWhitespaceFromHtml(pageContent)
        End If
        writer.Write(pageContent)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnUserlLogID.Value = CType(HttpContext.Current.Session("AdminID"), Integer)
        'lstMultipleValues_DataBound(lstMultipleValues, New EventArgs)
        LoadCurrencyControlBindings()
        LoadTypes()
        loadStatus()
        BindCategorySpanvalues()
        Bind_MultipleTypesValues_Span()
        Bind_MultipleStatusValues_Span()

        If Not IsPostBack Then

            'loadStatus()


            If (Portal.BLL.Users.CheckUserSubModulesAccess(Portal.BLL.Enumeration.SubModules.PMFullAccess) = False) Then
                divNewTicket.Style.Add("visibility", "hidden")
            End If
            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(3);</script>")
            ddlClients.DataBind()
            If Request.QueryString("ddlClients") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlClients")) Then
                ddlClients.SelectedValue = Request.QueryString("ddlClients")
            End If
            'ddlCategories.DataBind()
            'If Request.QueryString("ddlCategories") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlCategories")) Then
            '    ddlCategories.SelectedValue = Request.QueryString("ddlCategories")
            'End If
            If Request.QueryString("ddlFilter") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlFilter")) Then
                ddlFilter.SelectedValue = Request.QueryString("ddlFilter")
            End If
            'If Request.QueryString("ddlStatus") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlStatus")) Then
            '    ddlStatus.SelectedValue = Request.QueryString("ddlStatus")
            'End If

            'ddlTypes.DataBind()
            'If Request.QueryString("ddlTypes") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlTypes")) Then
            '    ddlTypes.SelectedValue = Request.QueryString("ddlTypes")
            'End If

            If Request.QueryString("txtSearch") <> String.Empty Then
                txtSearch.Text = Request.QueryString("txtSearch")
            End If

            txtDateFrom.Text = New DateTime(DateTime.Now.Year - 5, 1, 1).ToShortDateString()
            txtDateTo.Text = DateTime.Now.ToShortDateString()

            If String.IsNullOrEmpty(Request.QueryString("txtDateFrom")) = False Then
                txtDateFrom.Text = Request.QueryString("txtDateFrom")
            End If

            If String.IsNullOrEmpty(Request.QueryString("txtDateTo")) = False Then
                txtDateTo.Text = Request.QueryString("txtDateTo")
            End If
            If Request.QueryString("hdnSortBy") <> String.Empty Then
                hdnSortBy.Value = Request.QueryString("hdnSortBy")

                If (hdnSortBy.Value.Contains("DESC")) Then
                    gvwMyTickets.Sort(hdnSortBy.Value.Replace(" DESC", ""), SortDirection.Descending)
                Else
                    gvwMyTickets.Sort(hdnSortBy.Value, SortDirection.Ascending)
                End If
            End If


            If Request.QueryString("GridViewCurrentPageNumber") <> String.Empty AndAlso IsNumeric(Request.QueryString("GridViewCurrentPageNumber")) Then
                gvwMyTickets.PageIndex = Request.QueryString("GridViewCurrentPageNumber") - 1
                LastPage = Request.QueryString("GridViewCurrentPageNumber") + 1
            End If


        End If
        lstMultipleValues.Attributes.Add("onclick", "FindSelectedItems (this," + txtSelectedMLValues.ClientID + ");")
        lstMultipleValues1.Attributes.Add("onclick", "FindSelectedItems (this," + txtSelectedMLValues1.ClientID + ");")
        lstMultipleValues2.Attributes.Add("onclick", "FindSelectedItems (this," + txtSelectedMLValues2.ClientID + ");")
        'Me.MultiSelectDropDown1.CallingPage = Me


        'AddHandler Me.MultiSelectDropDown1.OnItemsSelected, AddressOf MultiSelectDropDown1_OnItemsSelected

    End Sub

    Private Sub LoadTypes()
        Me.CheckBoxesTypeDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_Search_Type()
        Me.lstMultipleValues1.DataSource = CheckBoxesTypeDataTable
        Me.lstMultipleValues1.DataTextField = "Name"
        Me.lstMultipleValues1.DataValueField = "ID"
        Me.lstMultipleValues1.AutoPostBack = False
        Me.lstMultipleValues1.DataBind()
    End Sub
    Private Sub loadStatus()
        Me.CheckBoxesStatusDataTable = GetStatusValues()
        Me.lstMultipleValues2.DataSource = CheckBoxesStatusDataTable
        Me.lstMultipleValues2.DataTextField = "Name"
        Me.lstMultipleValues2.DataValueField = "ID"
        Me.lstMultipleValues2.AutoPostBack = False
        Me.lstMultipleValues2.DataBind()
    End Sub
#End Region

#Region "GridView Events"
    Protected Sub gvwMyTickets_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwMyTickets.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (CType(DataBinder.Eval(e.Row.DataItem, "ReleaseID"), Integer) > 0) Then
                e.Row.Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & DataBinder.Eval(e.Row.DataItem, "ReleaseID") & "&ID=" & DataBinder.Eval(e.Row.DataItem, "ID") & "&ddlClients=" & ddlClients.SelectedValue & "&ddlFilter=" & ddlFilter.SelectedValue & "&txtSearch=" & txtSearch.Text & "&PrevPage=4';")
            Else
                e.Row.Attributes.Add("onClick", "OnRowClick(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            End If

            'If CType(DataBinder.Eval(e.Row.DataItem, "Read"), Boolean) = False AndAlso Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Status"), "") <> "Completed" AndAlso Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "UserID"), 0) <> Session("AdminID") Then
            If CType(DataBinder.Eval(e.Row.DataItem, "Read"), Boolean) = False AndAlso Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Status"), "") <> "Completed" Then
                e.Row.CssClass = "YellowRow"
                e.Row.Attributes.Add("onmouseout", "this.className='YellowRow';")
            End If
            If CType(DataBinder.Eval(e.Row.DataItem, "Flag"), Boolean) = True Then
                e.Row.CssClass = "BlueTableRow"
                e.Row.Attributes.Add("onmouseout", "this.className='BlueTableRow';")
            End If
        End If
    End Sub

    Protected Sub gvwMyTickets_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvwMyTickets.DataBound
        Dim pagerRow As GridViewRow = gvwMyTickets.BottomPagerRow
        If Not (pagerRow Is Nothing) Then
            Dim pageNum As Literal = CType(pagerRow.Cells(0).FindControl("litPageNumber"), Literal)
            Dim totalNum As Literal = CType(pagerRow.Cells(0).FindControl("litTotalPages"), Literal)
            If Not ((pageNum Is Nothing) Or (totalNum Is Nothing)) Then
                Dim Page As Int32 = gvwMyTickets.PageIndex + 1
                hdnCurrentPageNumber.Value = Page
                Dim count As Int32 = gvwMyTickets.PageCount
                pageNum.Text = Page.ToString()
                totalNum.Text = count.ToString()
            End If
        End If
    End Sub


    Protected Sub gvwMyTickets_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvwMyTickets.RowCommand
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If e.CommandName = "NextPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvwMyTickets.PageIndex = CInt(e.CommandArgument.ToString()) - 1
                FirstPage = CInt(e.CommandArgument.ToString()) - 1
                LastPage = FirstPage + PageCount + 1
                If LastPage >= gvwMyTickets.PageCount Then
                    LastPage = gvwMyTickets.PageCount
                    FirstPage = LastPage - PageCount
                End If
                ViewState("LastPage") = LastPage.ToString()
                ViewState("FirstPage") = FirstPage.ToString()
            End If
        ElseIf e.CommandName = "PrevPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvwMyTickets.PageIndex = CInt(e.CommandArgument.ToString()) - 1
                LastPage = CInt(e.CommandArgument.ToString()) + 1
                FirstPage = LastPage - (PageCount + 1)
                If FirstPage <= 1 Then
                    FirstPage = 1
                    LastPage = FirstPage + PageCount
                End If
                ViewState("LastPage") = LastPage.ToString()
                ViewState("FirstPage") = FirstPage.ToString()
            End If
        Else
            CommandArgs = e.CommandArgument.ToString()
        End If
    End Sub

    Protected Sub gvwMyTickets_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwMyTickets.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
        ''''''''''''''''''''''''''''''''''''''''''
        Dim Pageindex As Integer = 0
        If e.Row.RowType = DataControlRowType.Pager Then
            Pageindex = gvwMyTickets.PageIndex + 1
            If String.IsNullOrEmpty(CommandArgs) = False Then
                If Not IsNumeric(CommandArgs) Then
                    If LastPage = Pageindex Then
                        FirstPage = Pageindex - 1
                        LastPage = FirstPage + PageCount + 1
                    End If
                    If FirstPage = Pageindex Then
                        FirstPage = Pageindex - PageCount
                        LastPage = FirstPage + PageCount + 1
                    End If
                    If FirstPage <= 1 Then
                        FirstPage = 1
                        LastPage = FirstPage + PageCount
                    End If
                    If LastPage >= gvwMyTickets.PageCount Then
                        LastPage = gvwMyTickets.PageCount
                        FirstPage = LastPage - PageCount
                    End If
                    ViewState("FirstPage") = FirstPage
                    ViewState("LastPage") = LastPage
                Else
                    Pageindex = CInt(CommandArgs)
                End If
            End If
            If String.IsNullOrEmpty(ViewState("LastPage")) = False AndAlso String.IsNullOrEmpty(ViewState("FirstPage")) = False Then
                FirstPage = CInt(ViewState("FirstPage").ToString())
                LastPage = CInt(ViewState("LastPage").ToString())
            End If

            Dim pageNumber As Panel = CType(e.Row.Cells(0).FindControl("pnlNumber"), Panel)
            Dim PagerTable As HtmlTable = Functions.CreatePager(gvwMyTickets.PageCount, Pageindex, FirstPage, LastPage)
            pageNumber.Controls.Add(PagerTable)
        End If
    End Sub


    Protected Sub gvwMyTickets_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvwMyTickets.Sorting
        If e.SortDirection = SortDirection.Ascending Then
            hdnSortBy.Value = e.SortExpression
        Else
            hdnSortBy.Value = e.SortExpression + " DESC"
        End If

    End Sub
#End Region

#Region "Dropdown Events"
    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        ddlClients.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    'Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
    '    ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    'End Sub
    'Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
    '    ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
    '    ddlTypes.Items.Insert(1, New ListItem("Billable Enhancement & Project", 8))
    'End Sub
#End Region

#Region "Datasource Events"
    Protected Sub odsMyTickets_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsMyTickets.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False _
                        Or ddlClients.SelectedValue <> "0" _
                        Or ddlFilter.SelectedValue <> "0" Then

            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If
        If IsNumeric(e.ReturnValue.ToString()) Then
            lblErrorCount.Text = e.ReturnValue.ToString()
        End If
    End Sub

    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", Portal.BLL.Enumeration.SubModules.PMFullAccess & "," & Portal.BLL.Enumeration.SubModules.PMReadOnlyAccess)
    End Sub
#End Region

    Private Sub LoadCurrencyControlBindings()
        Me.CheckBoxesDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_Search_Category()
        Me.lstMultipleValues.DataSource = CheckBoxesDataTable

        Me.lstMultipleValues.DataTextField = "Name"
        Me.lstMultipleValues.DataValueField = "ID"

        Me.lstMultipleValues.AutoPostBack = False
        Me.lstMultipleValues.DataBind()
    End Sub


    'Private Sub MultiSelectDropDown1_OnItemsSelected(sender As Object, args As MultiSelectDropDownItemSelectedEventArgs)
    '    'Me.tbSelectedFullText.Text = String.Empty
    '    'Me.tbSelectedOptionsValue.Text = String.Empty
    '    'Me.lbSelectedItemList.Items.Clear()
    '    'Me.tbSelectedOptionsValue.Text = args.SelectedOptionText
    '    'Me.tbSelectedFullText.Text = args.SelectedOptionText
    '    'For Each selectedOption As String In args.SelectedOptionList
    '    '    Me.lbSelectedItemList.Items.Add(selectedOption)
    '    'Next
    'End Sub
    'Protected Sub ImageButton1_Click(sender As Object, e As ImageClickEventArgs)

    '    Dim dt As DataTable = PM_Ticket_Features.PM_MYTicketGetAll(0, hdnlistOfCategoryIds.Value, 0, 0, Nothing, 50, 0, Nothing, txtDateFrom.Text, txtDateTo.Text, 0)
    '    gvwMyTickets.DataSource = dt
    '    gvwMyTickets.DataBind()
    '    LoadCurrencyControlBindings()
    '    BindCategorySpanvalues()
    '    LoadTypes()
    '    Bind_MultipleTypesValues_Span()
    '    'lstMultipleValues_DataBound(lstMultipleValues, New EventArgs)
    'End Sub

    Protected Sub BindCategorySpanvalues()
        Dim checkbox As CheckBoxList = lstMultipleValues
        For Each item As ListItem In checkbox.Items
            Dim Id As String = CheckBoxesDataTable.Rows(CheckBoxesRowsCount).Item(0).ToString()

            checkbox.Items(CheckBoxesRowsCount).Attributes.Add("data-value", Id)
            CheckBoxesRowsCount = CheckBoxesRowsCount + 1
        Next
    End Sub
    'Protected Sub btnTypeFilter_Click(sender As Object, e As ImageClickEventArgs)
    '    Dim dt As DataTable = PM_Ticket_Features.PM_MYTicketGetAll(0, 0, 0, 0, Nothing, 50, 0, Nothing, txtDateFrom.Text, txtDateTo.Text, hdnlistOfTypeIds.Value)
    '    gvwMyTickets.DataSource = dt
    '    gvwMyTickets.DataBind()
    '    LoadTypes()
    '    Bind_MultipleTypesValues_Span()
    '    LoadCurrencyControlBindings()
    '    BindCategorySpanvalues()
    'End Sub
    'Protected Sub btnStatusFilter_Click(sender As Object, e As ImageClickEventArgs)
    '    Dim dt As DataTable = PM_Ticket_Features.PM_MYTicketGetAll(0, 0, hdnlistofStatusIds.Value, 0, Nothing, 50, 0, Nothing, txtDateFrom.Text, txtDateTo.Text, 0)
    '    gvwMyTickets.DataSource = dt
    '    gvwMyTickets.DataBind()
    '    loadStatus()
    '    Bind_MultipleStatusValues_Span()
    'End Sub
    Protected Sub Bind_MultipleTypesValues_Span()
        Dim checkbox As CheckBoxList = lstMultipleValues1
        For Each item As ListItem In checkbox.Items
            Dim Id As String = CheckBoxesTypeDataTable.Rows(CheckBoxesTypeRowCount).Item(0).ToString()

            checkbox.Items(CheckBoxesTypeRowCount).Attributes.Add("data-value", Id)
            CheckBoxesTypeRowCount = CheckBoxesTypeRowCount + 1
        Next

    End Sub

    Protected Sub Bind_MultipleStatusValues_Span()
        Dim checkbox As CheckBoxList = lstMultipleValues2
        For Each item As ListItem In checkbox.Items
            Dim Id As String = CheckBoxesStatusDataTable.Rows(CheckBoxesStatusRowCount).Item(0).ToString()

            checkbox.Items(CheckBoxesStatusRowCount).Attributes.Add("data-value", Id)
            CheckBoxesStatusRowCount = CheckBoxesStatusRowCount + 1
        Next

    End Sub

    Private Function GetStatusValues() As DataTable
        Dim dt As New DataTable("DataTable")

        Dim dr As DataRow = Nothing
        dt.Columns.AddRange(New DataColumn() {New DataColumn("ID"), New DataColumn("Name")})
        dr = dt.NewRow()

        dr("ID") = "2"
        dr("Name") = "Not Started"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "14"
        dr("Name") = "In Requirement Gathering"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "13"
        dr("Name") = "In Design Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "11"
        dr("Name") = "In Development Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "12"
        dr("Name") = "In QA Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "7"
        dr("Name") = "On Hold"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "10"
        dr("Name") = "Confirm Solved"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "16"
        dr("Name") = "UAT Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "17"
        dr("Name") = "Local Production Checkout"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "18"
        dr("Name") = "Ready to go live"
        dt.Rows.Add(dr)

        Return dt
    End Function


End Class

