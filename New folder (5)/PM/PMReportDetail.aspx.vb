																		
Partial Class PM_PMReportDetail
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("StartDate") Is Nothing Or Request.QueryString("EndDate") Is Nothing Then
                txtDateFrom.Text = New DateTime(DateTime.Today.Year, DateTime.Today.Month, 1).ToShortDateString()
                txtDateTo.Text = DateTime.Now.ToShortDateString()
                hdnStartDate.Value = txtDateFrom.Text
                hdnEndDate.Value = txtDateTo.Text
            Else
                txtDateFrom.Text = CDate(Request.QueryString("StartDate")).ToShortDateString()
                txtDateTo.Text = CDate(Request.QueryString("EndDate")).ToShortDateString()
                hdnStartDate.Value = New DateTime(DateTime.Today.Year, DateTime.Today.Month, 1).ToShortDateString()
                hdnEndDate.Value = DateTime.Now.ToShortDateString()
            End If
        End If
    End Sub
    Protected Sub ddlTeams_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTeams.DataBound
        If Not Page.IsPostBack Then
            ddlTeams.Items.Insert(0, New ListItem("Select...", 0))
            ddlTeams.Items.FindByValue(Request.QueryString("TeamId")).Selected = True
            ddlUsers.DataBind()
        End If
    End Sub
    Protected Sub ddlCategory_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategory.DataBound
        If ddlCategory.Items.Contains(New ListItem("Select User...", 0)) = False Then
            ddlCategory.Items.Insert(0, New ListItem("Select...", 0))
        End If
        If Not Page.IsPostBack Then
            ddlCategory.Items.FindByValue(Request.QueryString("CategoryId")).Selected = True
        End If
    End Sub
    Protected Sub ddlType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlType.DataBound
        If Not Page.IsPostBack Then
            ddlType.Items.Insert(0, New ListItem("Select...", 0))
            ddlType.Items.FindByValue(Request.QueryString("Type")).Selected = True
        End If

    End Sub
    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", Portal.BLL.Enumeration.SubModules.PMFullAccess & "," & Portal.BLL.Enumeration.SubModules.PMReadOnlyAccess)
    End Sub

    Protected Sub gvDashBoardTickets_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvDashBoardTickets.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onClick", "ShowDetail(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")

            Dim strRefNo As Integer = CType(DataBinder.Eval(e.Row.DataItem, "RefNo"), Integer)
            If strRefNo <> 0 Then
                e.Row.Cells(1).Text = strRefNo.ToString()
            ElseIf strRefNo = 0 Then
                e.Row.Cells(1).Text = CType(DataBinder.Eval(e.Row.DataItem, "ID"), String)
            End If
            Dim time As String = "0:00"
            Dim strArray() As String
            If Not e.Row.DataItem("TimeAsString") Is DBNull.Value Then
                strArray = e.Row.DataItem("TimeAsString").ToString.Split(":")
                If strArray(1).Length = 0 Then
                    time = strArray(0) + ":" + "00"
                ElseIf strArray(1).Length = 1 Then
                    time = strArray(0) + ":" + "0" + strArray(1)
                Else
                    time = e.Row.DataItem("TimeAsString")
                End If
            Else
                time = "N/A"
            End If
            CType(e.Row.FindControl("lblTimeSpent"), Label).Text = time

        End If
    End Sub

    Protected Sub gvDashBoardTickets_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvDashBoardTickets.DataBound
        Dim pagerRow As GridViewRow = gvDashBoardTickets.BottomPagerRow
        If Not (pagerRow Is Nothing) Then
            Dim pageNum As Literal = CType(pagerRow.Cells(0).FindControl("litPageNumber"), Literal)
            Dim totalNum As Literal = CType(pagerRow.Cells(0).FindControl("litTotalPages"), Literal)
            If Not ((pageNum Is Nothing) Or (totalNum Is Nothing)) Then
                Dim Page As Int32 = gvDashBoardTickets.PageIndex + 1
                Dim count As Int32 = gvDashBoardTickets.PageCount
                pageNum.Text = Page.ToString()
                totalNum.Text = count.ToString()
            End If
        End If
    End Sub
    Protected Sub gvDashBoardTickets_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvDashBoardTickets.RowCommand
        If e.CommandName <> "Sort" And e.CommandName <> "Page" Then
            Dim ID As Integer = Convert.ToInt32(e.CommandArgument)
            If e.CommandName = "View" Then
                'Response.Redirect("TicketsDetail.aspx?ID=" & ID & "&ddlClients=" & ddlClients.SelectedValue.ToString() & "&ddlCategories=" & ddlCategory.SelectedValue.ToString() & "&ddlTypes=" & ddlType.SelectedValue.ToString() & "&ddlFilter=" & ddlFil.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text & "&PrevPage=5")
            End If
        End If
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        If e.CommandName = "NextPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvDashBoardTickets.PageIndex = CInt(e.CommandArgument.ToString()) - 1
                FirstPage = CInt(e.CommandArgument.ToString()) - 1
                LastPage = FirstPage + PageCount + 1
                If LastPage >= gvDashBoardTickets.PageCount Then
                    LastPage = gvDashBoardTickets.PageCount
                    FirstPage = LastPage - PageCount
                End If
                ViewState("LastPage") = LastPage.ToString()
                ViewState("FirstPage") = FirstPage.ToString()
            End If
        ElseIf e.CommandName = "PrevPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                gvDashBoardTickets.PageIndex = CInt(e.CommandArgument.ToString()) - 1
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
    Protected Sub gvDashBoardTickets_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvDashBoardTickets.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If

        ''''''''''''''''''''''''''''''''''''''''''
        Dim Pageindex As Integer = 0
        If e.Row.RowType = DataControlRowType.Pager Then
            Pageindex = gvDashBoardTickets.PageIndex + 1
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
                    If LastPage >= gvDashBoardTickets.PageCount Then
                        LastPage = gvDashBoardTickets.PageCount
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
            Dim PagerTable As HtmlTable = Functions.CreatePager(gvDashBoardTickets.PageCount, Pageindex, FirstPage, LastPage)
            pageNumber.Controls.Add(PagerTable)
        End If
    End Sub


    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        If Not Page.IsPostBack Then
            If ddlClients.Items.Contains(New ListItem("Select User...", 0)) = False Then
                ddlClients.Items.Insert(0, New ListItem("Select...", 0))
            End If
            ddlClients.Items.FindByValue(Request.QueryString("ClientId")).Selected = True
        End If

    End Sub
    Protected Function ConvertDBNull(ByVal obj As Object, ByVal ReplaceWith As Object) As Object
        If obj Is DBNull.Value Then
            Return ReplaceWith
        Else
            Return obj
        End If
    End Function

    Protected Sub ddlUsers_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlUsers.DataBound
        If ddlUsers.Items.Contains(New ListItem("Select User...", 0)) = False Then
            ddlUsers.Items.Insert(0, New ListItem("Select User...", 0))
            If Not Request.QueryString("UserId") = Nothing Then
                ddlUsers.Items.FindByValue(Request.QueryString("UserId")).Selected = True
            End If
        End If
    End Sub

    Protected Sub ddlTeams_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTeams.SelectedIndexChanged
        ddlUsers.DataBind()
    End Sub

    Protected Sub gvDashBoardTickets_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvDashBoardTickets.Sorting
        If e.SortDirection = SortDirection.Ascending Then
            hdnSortBy.Value = e.SortExpression
        Else
            hdnSortBy.Value = e.SortExpression + " DESC"
        End If
    End Sub
    Private Sub SetTotalTimeSpent()
        Dim TotalHoursCount As Integer = 0
        Dim TotalMinsCount As Integer = 0
        Dim dt As System.Data.DataTable = Portal.BLL.PM.PM_Ticket_Features.GetPMDashBoardTickets(CDate(txtDateFrom.Text.Trim), CDate(txtDateTo.Text.Trim), CInt(ddlClients.SelectedValue), CInt(ddlCategory.SelectedValue), CInt(ddlType.SelectedValue), CInt(ddlTeams.SelectedValue), CInt(ddlUsers.SelectedValue), "", 1000000000, 0, String.Empty)
        For Each Row As System.Data.DataRow In dt.Rows
            Dim strArray() As String
            If Not Row("TimeAsString") Is DBNull.Value Then
                strArray = Row("TimeAsString").ToString.Split(":")
                TotalHoursCount = TotalHoursCount + CInt(strArray(0))
                TotalMinsCount = TotalMinsCount + CInt(strArray(1))
            End If
        Next
        TotalHoursCount = TotalHoursCount + Math.Floor(TotalMinsCount / 60)
        Dim TimeString As String = TotalHoursCount.ToString + ":"
        If (TotalMinsCount Mod 60) > 9 Then
            TimeString = TimeString + (TotalMinsCount Mod 60).ToString
        ElseIf (TotalMinsCount Mod 60) <= 0 Then
            TimeString = TimeString + "00"
        Else
            TimeString = TimeString + "0" + (TotalMinsCount Mod 60).ToString
        End If
        lblTimeSum.Text = TimeString
    End Sub

    Protected Sub odsDashBoardTicket_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsDashBoardTicket.Selected
        SetTotalTimeSpent()
    End Sub
End Class