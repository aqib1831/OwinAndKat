
Partial Class Orders_Orders
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(1);</script>")
        End If
    End Sub
  
    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        ddlClients.Items.Insert(0, New ListItem("Select...", 0))
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

    Protected Sub gvReleases_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvReleases.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim ID As Integer = CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer)
            e.Row.Cells(0).Attributes.Add("onClick", "javascript:window.location='OrderDetail.aspx?OrderID=" & ID & "';")
            e.Row.Cells(1).Attributes.Add("onClick", "javascript:window.location='OrderDetail.aspx?OrderID=" & ID & "';")
            e.Row.Cells(2).Attributes.Add("onClick", "javascript:window.location='OrderDetail.aspx?OrderID=" & ID & "';")
            e.Row.Cells(3).Attributes.Add("onClick", "javascript:window.location='OrderDetail.aspx?OrderID=" & ID & "';")
            e.Row.Cells(4).Attributes.Add("onClick", "javascript:window.location='OrderDetail.aspx?OrderID=" & ID & "';")
            e.Row.Cells(5).Attributes.Add("onClick", "javascript:window.location='OrderDetail.aspx?OrderID=" & ID & "';")

            'Dim strRefNo As Integer = CType(DataBinder.Eval(e.Row.DataItem, "RefNo"), Integer)
            'If strRefNo <> 0 Then
            '    e.Row.Cells(1).Text = strRefNo.ToString()
            'ElseIf strRefNo = 0 Then
            '    e.Row.Cells(1).Text = CType(DataBinder.Eval(e.Row.DataItem, "ID"), String)
            'End If

            'Dim strDueDate As String
            'Dim strStatus As String
            'strDueDate = CType(DataBinder.Eval(e.Row.DataItem, "DueDate"), String)
            'strStatus = CType(DataBinder.Eval(e.Row.DataItem, "Status"), String)
            'Dim read As Boolean = CType(DataBinder.Eval(e.Row.DataItem, "Read"), Boolean)

            'If read = False AndAlso strStatus <> "Completed" Then
            '    e.Row.CssClass = "YellowRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='YellowRow';")
            'End If

            'If CType(strDueDate, Date) < DateTime.Now.Date AndAlso strStatus <> "Completed" Then
            '    e.Row.CssClass = "RedRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRow';")
            'End If
        End If
    End Sub

    Protected Sub gvReleases_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvReleases.RowCommand
        If e.CommandName <> "Sort" And e.CommandName <> "Page" Then
            Dim ID As Integer = Convert.ToInt32(e.CommandArgument)
            If e.CommandName = "View" Then
                Response.Redirect("TicketsDetail.aspx?ID=" & ID & "&PrevPage=3")
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
        If Not IsNumeric(e.ReturnValue) Then
            If String.IsNullOrEmpty(txtSearch.Text) = False _
                            Or ddlStates.SelectedValue <> "0" _
                            Or ddlClients.SelectedValue <> "0" _
                            Or ddlOrderStatus.SelectedValue <> "0" Then

                lblFilter.Text = "Filtered"
            Else
                lblFilter.Text = "All"
            End If
            Dim colOrders As System.Collections.Generic.List(Of Portal.BLL.Orders.SCM_Orders) = e.ReturnValue
            lblErrorCount.Text = colOrders.Count
        End If
    End Sub

    Protected Sub ddlOrderStatus_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlOrderStatus.DataBound
        ddlOrderStatus.Items.Insert(0, New ListItem("Select...", "0"))
        If (Request.QueryString("StatusID") <> Nothing AndAlso IsNumeric(Request.QueryString("StatusID")) = True) Then
            Dim orderStatusItem As ListItem = Nothing
            orderStatusItem = ddlOrderStatus.Items.FindByValue(Request.QueryString("StatusID"))
            If Not orderStatusItem Is Nothing Then
                ddlOrderStatus.SelectedValue = orderStatusItem.Value
            End If
        End If
    End Sub
End Class
