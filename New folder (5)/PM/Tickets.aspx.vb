Imports System.Data
Imports Portal.BLL

Partial Class PM_Tickets
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
            'Modify the page content as you like :-)
            'pageContent = Functions.RemoveWhitespaceFromCss(pageContent)
            'pageContent = Functions.RemoveWhitespaceFromJavaScript(pageContent)
            pageContent = Functions.RemoveWhitespaceFromHtml(pageContent)
        End If
        writer.Write(pageContent)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnUserlLogID.Value = CType(HttpContext.Current.Session("AdminID"), Integer)
        LoadCategoryControlBindings()
        LoadTypes()
        loadStatus()
        BindCategorySpanvalues()
        Bind_MultipleTypesValues_Span()
        Bind_MultipleStatusValues_Span()
        If Not IsPostBack Then
            If (Portal.BLL.Users.CheckUserSubModulesAccess(Portal.BLL.Enumeration.SubModules.PMFullAccess) = False) Then
                divNewTicket.Style.Add("visibility", "hidden")
            End If
            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(2);</script>")
            ddlClients.DataBind()
            If Request.QueryString("ddlClients") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlClients")) Then
                ddlClients.SelectedValue = Request.QueryString("ddlClients")
            End If
            'ddlCategories.DataBind()
            'If Request.QueryString("ddlCategories") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlCategories")) Then
            '    ddlCategories.SelectedValue = Request.QueryString("ddlCategories")
            'End If
            'ddlTypes.DataBind()
            'If Request.QueryString("ddlTypes") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlTypes")) Then
            '    ddlTypes.SelectedValue = Request.QueryString("ddlTypes")
            'End If
            FillddlFilter()
            If Request.QueryString("ddlFilter") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlFilter")) Then
                ddlFilter.SelectedValue = Request.QueryString("ddlFilter")
            End If

            'If Request.QueryString("ddlStatus") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlStatus")) Then
            '    ddlStatus.SelectedValue = Request.QueryString("ddlStatus")
            'End If

            If Request.QueryString("txtSearch") <> String.Empty AndAlso IsNumeric(Request.QueryString("txtSearch")) Then
                txtSearch.Text = Request.QueryString("txtSearch")
            End If
            If Request.QueryString("hdnSortBy") <> String.Empty Then
                hdnSortBy.Value = Request.QueryString("hdnSortBy")

                If (hdnSortBy.Value.Contains("DESC")) Then
                    gvReleases.Sort(hdnSortBy.Value.Replace(" DESC", ""), SortDirection.Descending)
                Else
                    gvReleases.Sort(hdnSortBy.Value, SortDirection.Ascending)
                End If


            End If
            ddlWaitingForNames.DataBind()
            If Request.QueryString("ddlWaitFor") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlWaitFor")) Then
                ddlWaitingForNames.SelectedValue = Request.QueryString("ddlWaitFor")
            End If
            If Request.QueryString("GridViewCurrentPageNumber") <> String.Empty AndAlso IsNumeric(Request.QueryString("GridViewCurrentPageNumber")) Then
                gvReleases.PageIndex = Request.QueryString("GridViewCurrentPageNumber") - 1
                LastPage = Request.QueryString("GridViewCurrentPageNumber") + 1
            End If
        End If
        lstMultipleValues.Attributes.Add("onclick", "FindSelectedItems (this," + txtSelectedMLValues.ClientID + ");")
        lstMultipleValues1.Attributes.Add("onclick", "FindSelectedItems (this," + txtSelectedMLValues1.ClientID + ");")
        lstMultipleValues2.Attributes.Add("onclick", "FindSelectedItems (this," + txtSelectedMLValues2.ClientID + ");")
    End Sub
#End Region

#Region "Dropdown Events"
    'Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
    '    ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    'End Sub

    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        ddlClients.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    'Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
    '    ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
    '    ddlTypes.Items.Insert(1, New ListItem("Billable Enhancement & Project", 8))
    'End Sub

    Protected Sub ddlWaitingForNames_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWaitingForNames.DataBound
        ddlWaitingForNames.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
#End Region

#Region "GridView Events"
    Protected Sub gvReleases_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvReleases.DataBound
        Dim pagerRow As GridViewRow = gvReleases.BottomPagerRow
        If Not (pagerRow Is Nothing) Then
            Dim pageNum As Literal = CType(pagerRow.Cells(0).FindControl("litPageNumber"), Literal)
            Dim totalNum As Literal = CType(pagerRow.Cells(0).FindControl("litTotalPages"), Literal)
            If Not ((pageNum Is Nothing) Or (totalNum Is Nothing)) Then
                Dim Page As Int32 = gvReleases.PageIndex + 1
                hdnCurrentPageNumber.Value = Page
                Dim count As Int32 = gvReleases.PageCount
                pageNum.Text = Page.ToString()
                totalNum.Text = count.ToString()
            End If
        End If
    End Sub

    Protected Sub gvReleases_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvReleases.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            e.Row.Attributes.Add("onClick", "OnRowClick(" & DataBinder.Eval(e.Row.DataItem, "ReleaseID") & "," & DataBinder.Eval(e.Row.DataItem, "ID") & ");")

            If Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "UserID"), 0) <> 0 Then
                CType(e.Row.FindControl("lblAssignedBy"), Label).Text = DataBinder.Eval(e.Row.DataItem, "AssignedBy")
                CType(e.Row.FindControl("lblAssignedBy"), Label).ToolTip = DataBinder.Eval(e.Row.DataItem, "AssignedBy")
            ElseIf Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "ClientContactID"), 0) <> 0 Then
                CType(e.Row.FindControl("lblAssignedBy"), Label).Text = DataBinder.Eval(e.Row.DataItem, "ClientContactAssignedBy") & " (" & DataBinder.Eval(e.Row.DataItem, "ClientName") & ")"
                CType(e.Row.FindControl("lblAssignedBy"), Label).ToolTip = DataBinder.Eval(e.Row.DataItem, "ClientContactAssignedBy") & " (" & DataBinder.Eval(e.Row.DataItem, "ClientName") & ")"
            End If

            If CType(DataBinder.Eval(e.Row.DataItem, "Read"), Boolean) = False AndAlso Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Status"), "") <> "Completed" Then
                e.Row.CssClass = "YellowRow"
                e.Row.Attributes.Add("onmouseout", "this.className='YellowRow';")
            End If

        End If
    End Sub

    Protected Sub gvReleases_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvReleases.RowCommand
        If e.CommandName <> "Sort" And e.CommandName <> "Page" Then
            Dim ID As Integer = Convert.ToInt32(e.CommandArgument)
        End If

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If e.CommandName = "NextPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvReleases.PageIndex = CInt(e.CommandArgument.ToString()) - 1
                FirstPage = CInt(e.CommandArgument.ToString()) - 1
                LastPage = FirstPage + PageCount + 1
                If LastPage >= gvReleases.PageCount Then
                    LastPage = gvReleases.PageCount
                    FirstPage = LastPage - PageCount
                End If
                ViewState("LastPage") = LastPage.ToString()
                ViewState("FirstPage") = FirstPage.ToString()
            End If
        ElseIf e.CommandName = "PrevPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvReleases.PageIndex = CInt(e.CommandArgument.ToString()) - 1
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

    Protected Sub gvReleases_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvReleases.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If

        ''''''''''''''''''''''''''''''''''''''''''
        Dim Pageindex As Integer = 0
        If e.Row.RowType = DataControlRowType.Pager Then
            Pageindex = gvReleases.PageIndex + 1
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
                    If LastPage >= gvReleases.PageCount Then
                        LastPage = gvReleases.PageCount
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
            Dim PagerTable As HtmlTable = Functions.CreatePager(gvReleases.PageCount, Pageindex, FirstPage, LastPage)
            pageNumber.Controls.Add(PagerTable)
        End If
    End Sub
    Protected Sub gvwMyTickets_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvReleases.Sorting
        If e.SortDirection = SortDirection.Ascending Then
            hdnSortBy.Value = e.SortExpression
        Else
            hdnSortBy.Value = e.SortExpression + " DESC"
        End If

    End Sub
#End Region

#Region "Datasource Events"
    Protected Sub odsRecentTickets_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsRecentTickets.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False _
                       Or ddlClients.SelectedValue <> "0" _
                       Or ddlFilter.SelectedValue <> "0" _
                       Or ddlWaitingForNames.SelectedValue <> "0" Then

            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If
        If IsNumeric(e.ReturnValue.ToString()) Then
            lblErrorCount.Text = e.ReturnValue.ToString()
        End If
        'If String.IsNullOrEmpty(txtSearch.Text) = False Then _
        '                Or ddlClients.SelectedValue <> "0" _
        '                Or ddlFilter.SelectedValue <> "0" _
        '                Or ddlTypes.SelectedValue <> "0" _
        '                Or ddlWaitingForNames.SelectedValue <> "0" Then


        '    lblFilter.Text = "Filtered"
        'Else
        '    lblFilter.Text = "All"
        'End If
        'If IsNumeric(e.ReturnValue.ToString()) Then
        '    lblErrorCount.Text = e.ReturnValue.ToString()
        'End If
    End Sub
    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", Portal.BLL.Enumeration.SubModules.PMFullAccess & "," & Portal.BLL.Enumeration.SubModules.PMReadOnlyAccess)
    End Sub
#End Region

#Region "Private Methods"
    Private Sub FillddlFilter()
        Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
        ddlFilter.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Assigned By Me", 1)
        ddlFilter.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Associated With Me", 2)
        ddlFilter.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Assigned To Me", 3)
        ddlFilter.Items.Add(obj)
    End Sub
#End Region


    Private Sub LoadCategoryControlBindings()
        Me.CheckBoxesDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_Search_Category()
        Me.lstMultipleValues.DataSource = CheckBoxesDataTable

        Me.lstMultipleValues.DataTextField = "Name"
        Me.lstMultipleValues.DataValueField = "ID"

        Me.lstMultipleValues.AutoPostBack = False
        Me.lstMultipleValues.DataBind()
    End Sub
    Protected Sub BindCategorySpanvalues()
        Dim checkbox As CheckBoxList = lstMultipleValues
        For Each item As ListItem In checkbox.Items
            Dim Id As String = CheckBoxesDataTable.Rows(CheckBoxesRowsCount).Item(0).ToString()

            checkbox.Items(CheckBoxesRowsCount).Attributes.Add("data-value", Id)
            CheckBoxesRowsCount = CheckBoxesRowsCount + 1
        Next
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
