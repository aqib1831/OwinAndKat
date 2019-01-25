
Partial Class PM_MyTickets
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
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
        ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(3);</script>")
        If Not IsPostBack Then
            ddlCategories.DataBind()
            If HttpContext.Current.Request.QueryString("ddlCategories") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlCategories")) Then
                ddlCategories.SelectedValue = Request.QueryString("ddlCategories")
            End If
            FillddlFilter()
            If HttpContext.Current.Request.QueryString("ddlFilter") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlFilter")) Then
                ddlFilter.SelectedValue = Request.QueryString("ddlFilter")
            End If
            If HttpContext.Current.Request.QueryString("txtSearch") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("txtSearch")) Then
                txtSearch.Text = Request.QueryString("txtSearch")
            End If
            If HttpContext.Current.Request.QueryString("txtSearch") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("txtSearch")) Then
                txtSearch.Text = Request.QueryString("txtSearch")
            End If
        End If

    End Sub
    Private Sub FillddlFilter()
        Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 4)
        ddlFilter.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Assigned By Me", 1)
        ddlFilter.Items.Add(obj)
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub gvReleases_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Relid As Integer = CType(DataBinder.Eval(e.Row.DataItem, "ReleaseID"), Integer)
            'If (Relid > 0) Then
            '    e.Row.Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & Relid & "&ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&txtSearch=" & txtSearch.Text & "&PrevPage=4';")
            'Else

            '    e.Row.Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&txtSearch=" & txtSearch.Text & "&PrevPage=4';")
            'End If
            e.Row.Attributes.Add("onClick", "OnRowClick(" & Relid & "," & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & ");")
            'e.Row.Cells(1).Text = CType(DataBinder.Eval(e.Row.DataItem, "ID"), String)
            'Dim intRefNo As Integer = CType(DataBinder.Eval(e.Row.DataItem, "RefNo"), Integer)
            'If intRefNo <> 0 Then
            '    e.Row.Cells(1).Text = intRefNo.ToString()
            'ElseIf intRefNo = 0 Then
            '    e.Row.Cells(1).Text = CType(DataBinder.Eval(e.Row.DataItem, "ID"), String)
            'End If

            Dim strDueDate As Object
            Dim strStatus As String
            strDueDate = CType(DataBinder.Eval(e.Row.DataItem, "DueDate"), Object)
            strStatus = CType(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Status"), Portal.BLL.Enumeration.PMStatus.NotStarted.ToString), String)
            Dim read As Boolean = CType(DataBinder.Eval(e.Row.DataItem, "Read"), Boolean)

            If read = False AndAlso strStatus <> "Completed" Then
                e.Row.CssClass = "YellowRow"
                e.Row.Attributes.Add("onmouseout", "this.className='YellowRow';")
            End If

            If CType(DataBinder.Eval(e.Row.DataItem, "DueDateShowToClient"), Boolean) Then
                e.Row.Cells(6).Text = CDate(strDueDate).ToString("MM/dd/yyyy")
            Else
                e.Row.Cells(6).Text = strDueDate.ToString()
            End If

        End If
    End Sub

    Protected Sub gvReleases_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvReleases.DataBound
        Dim pagerRow As GridViewRow = gvReleases.BottomPagerRow
        If Not (pagerRow Is Nothing) Then
            Dim pageNum As Literal = CType(pagerRow.Cells(0).FindControl("litPageNumber"), Literal)
            Dim totalNum As Literal = CType(pagerRow.Cells(0).FindControl("litTotalPages"), Literal)
            If Not ((pageNum Is Nothing) Or (totalNum Is Nothing)) Then
                Dim Page As Int32 = gvReleases.PageIndex + 1
                Dim count As Int32 = gvReleases.PageCount
                pageNum.Text = Page.ToString()
                totalNum.Text = count.ToString()
            End If
        End If
    End Sub
    

    Protected Sub gvReleases_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvReleases.RowCommand
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

    Protected Sub gvReleases_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
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

    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False _
                        Or ddlCategories.SelectedValue <> "0" _
                        Or ddlFilter.SelectedValue <> "0" Then

            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If

        If IsNumeric(e.ReturnValue.ToString()) Then
            lblErrorCount.Text = e.ReturnValue.ToString()
        End If
    End Sub
End Class
