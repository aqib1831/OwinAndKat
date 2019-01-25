
Partial Class PM_TicketsHistory
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'If (Portal.BLL.Users.CheckUserSubModulesAccess(Portal.BLL.Enumeration.SubModules.PMFullAccess) = False) Then
            '    divNewTicket.Style.Add("visibility", "hidden")
            'End If
            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(4);</script>")
            'ddlClients.DataBind()
            'If HttpContext.Current.Request.QueryString("ddlClients") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlClients")) Then
            '    ddlClients.SelectedValue = Request.QueryString("ddlClients")
            'End If
            ddlCategories.DataBind()
            If HttpContext.Current.Request.QueryString("ddlCategories") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlCategories")) Then
                ddlCategories.SelectedValue = Request.QueryString("ddlCategories")
            End If
            ddlTypes.DataBind()
            If HttpContext.Current.Request.QueryString("ddlTypes") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlTypes")) Then
                ddlTypes.SelectedValue = Request.QueryString("ddlTypes")
            End If
            FillddlFilter()
            If HttpContext.Current.Request.QueryString("ddlFilter") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlFilter")) Then
                ddlFilter.SelectedValue = Request.QueryString("ddlFilter")
            End If
            If HttpContext.Current.Request.QueryString("txtSearch") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("txtSearch")) Then
                txtSearch.Text = Request.QueryString("txtSearch")
            End If
        End If
    End Sub
    Private Sub FillddlFilter()
        Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
        ddlFilter.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Assigned By Me", 1)
        ddlFilter.Items.Add(obj)
    End Sub
    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    'Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
    '    ddlClients.Items.Insert(0, New ListItem("Select...", 0))
    'End Sub
    Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
        ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
	ddlTypes.Items.Insert(1, New ListItem("Billable Enhancement & Project", 8))
    End Sub


    Protected Sub gvReleases_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvReleases.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim Relid As Integer = CType(DataBinder.Eval(e.Row.DataItem, "ReleaseID"), Integer)
            e.Row.Cells(0).Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & Relid & "&ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&ddlClients=" & Session("MyNetsolace_ClientID").ToString() & "&ddlCategories=" & ddlCategories.SelectedValue.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & ddlFilter.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text & "&PrevPage=5';")
            e.Row.Cells(1).Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & Relid & "&ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&ddlClients=" & Session("MyNetsolace_ClientID").ToString() & "&ddlCategories=" & ddlCategories.SelectedValue.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & ddlFilter.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text & "&PrevPage=5';")
            e.Row.Cells(2).Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & Relid & "&ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&ddlClients=" & Session("MyNetsolace_ClientID").ToString() & "&ddlCategories=" & ddlCategories.SelectedValue.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & ddlFilter.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text & "&PrevPage=5';")
            e.Row.Cells(3).Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & Relid & "&ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&ddlClients=" & Session("MyNetsolace_ClientID").ToString() & "&ddlCategories=" & ddlCategories.SelectedValue.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & ddlFilter.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text & "&PrevPage=5';")
            e.Row.Cells(4).Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & Relid & "&ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&ddlClients=" & Session("MyNetsolace_ClientID").ToString() & "&ddlCategories=" & ddlCategories.SelectedValue.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & ddlFilter.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text & "&PrevPage=5';")

            Dim strRefNo As Integer = CType(DataBinder.Eval(e.Row.DataItem, "RefNo"), Integer)
            If strRefNo <> 0 Then
                e.Row.Cells(1).Text = strRefNo.ToString()
            ElseIf strRefNo = 0 Then
                e.Row.Cells(1).Text = CType(DataBinder.Eval(e.Row.DataItem, "ID"), String)
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
        If e.CommandName <> "Sort" And e.CommandName <> "Page" Then
            Dim ID As Integer = Convert.ToInt32(e.CommandArgument)
            If e.CommandName = "View" Then
                Response.Redirect("TicketsDetail.aspx?ID=" & ID & "&ddlClients=" & Session("MyNetsolace_ClientID").ToString() & "&ddlCategories=" & ddlCategories.SelectedValue.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & ddlFilter.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text & "&PrevPage=5")
            End If
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
    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False _
                        Or ddlCategories.SelectedValue <> "0" _
                        Or ddlFilter.SelectedValue <> "0" _
                        Or ddlTypes.SelectedValue <> "0" Then


            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If

        If IsNumeric(e.ReturnValue.ToString()) Then
            lblErrorCount.Text = e.ReturnValue.ToString()
        End If
    End Sub

End Class
