
Partial Class MyNetsolace_FranchisorInbox
    Inherits System.Web.UI.Page

    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If (Context.Session.Count < 1) Then
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "SessionExpiration", "<script language='javascript' type='text/javascript'>parent.window.location='AccessDenied.htm';</script>", False)
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.Title = "Netsolace Portal - My Netsolace"
        If Not Request.QueryString("ClientID") Is Nothing AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            hdnClientID.Value = Request.QueryString("ClientID")
        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeSelected", "parent.SetTrBackGround(1);", True)
    End Sub

    Protected Sub gvInbox_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvInbox.DataBound
        Dim pagerRow As GridViewRow = gvInbox.BottomPagerRow
        If Not (pagerRow Is Nothing) Then
            Dim pageNum As Literal = CType(pagerRow.Cells(0).FindControl("litPageNumber"), Literal)
            Dim totalNum As Literal = CType(pagerRow.Cells(0).FindControl("litTotalPages"), Literal)
            If Not ((pageNum Is Nothing) Or (totalNum Is Nothing)) Then
                Dim Page As Int32 = gvInbox.PageIndex + 1
                Dim count As Int32 = gvInbox.PageCount
                pageNum.Text = Page.ToString()
                totalNum.Text = count.ToString()
            End If
        End If

    End Sub

    Protected Sub gvInbox_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvInbox.RowCommand
        If e.CommandName = "NextPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvInbox.PageIndex = CInt(e.CommandArgument.ToString()) - 1
                FirstPage = CInt(e.CommandArgument.ToString()) - 1
                LastPage = FirstPage + PageCount + 1
                If LastPage >= gvInbox.PageCount Then
                    LastPage = gvInbox.PageCount
                    FirstPage = LastPage - PageCount

                End If
                ViewState("LastPage") = LastPage.ToString()
                ViewState("FirstPage") = FirstPage.ToString()
            End If
        ElseIf e.CommandName = "PrevPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvInbox.PageIndex = CInt(e.CommandArgument.ToString()) - 1
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

    Protected Sub gvInbox_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvInbox.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
        Dim Pageindex As Integer = 0
        If e.Row.RowType = DataControlRowType.Pager Then
            Pageindex = gvInbox.PageIndex + 1
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
                    If LastPage >= gvInbox.PageCount Then
                        LastPage = gvInbox.PageCount
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
            Dim PagerTable As HtmlTable = Functions.CreatePager(gvInbox.PageCount, Pageindex, FirstPage, LastPage)
            pageNumber.Controls.Add(PagerTable)
        End If
    End Sub

    Protected Sub gvInbox_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvInbox.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If CInt(CType(e.Row.FindControl("lblIntType"), Label).Text) = 1 And ((DateTime.Now.Day - CDate(DataBinder.Eval(e.Row.DataItem, "Activity_Date")).Day) > 2) Then
                e.Row.CssClass = "RedRow"
                e.Row.Attributes.Add("onmouseout", "this.className='RedRow';")
                'ElseIf CBool(CType(e.Row.FindControl("lblAdminReadStatus"), Label).Text) Then
                '    e.Row.CssClass = "YellowRow"
                '    e.Row.Attributes.Add("onmouseout", "this.className='YellowRow';")
            End If
            e.Row.Attributes.Add("onclick", "javascript:window.location='ActivityDetail.aspx?ID=" & CType(e.Row.FindControl("lblID"), Label).Text & "&PrevPage=3&ClientID=" & hdnClientID.Value & "&FranchiseID=" & CType(e.Row.FindControl("lblFranchiseID"), Label).Text & "';return false;")
        End If
        If e.Row.RowType = DataControlRowType.Footer Then

        End If
    End Sub

    Protected Sub sdsInbox_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles sdsInbox.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False Or ddlFilters.SelectedValue <> "-1" Or CInt(ddlFranchises.SelectedValue) > 0 Then
            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If
        Dim Count As Integer = 0

        If IsNumeric(e.ReturnValue) = True Then            
            lblActivityCount.Text = e.ReturnValue.ToString()
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeCount", "parent.SetInBox(" & e.ReturnValue.ToString() & ");", True)
        End If
    End Sub

    Protected Sub ddlFranchises_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFranchises.DataBound
        ddlFranchises.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub
End Class
