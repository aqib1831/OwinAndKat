Partial Class com_admin_History
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(2);</script>")
        hdnAdminID.Value = Session("AdminID")
        hdnSubModuleID.Value = Portal.BLL.Enumeration.SubModules.HelpDesk
        If Not IsPostBack Then
            lbtnExportToExcel.Attributes.Add("onclick", "javascript:return OpenExportToExcel();")

            txtDateFrom.Text = DateTime.Now.AddDays(-7).ToShortDateString()
            txtDateTo.Text = DateTime.Now.ToShortDateString()
            If String.IsNullOrEmpty(Request.QueryString("FromDate")) = False Then
                txtDateFrom.Text = Request.QueryString("FromDate")
            End If
            If String.IsNullOrEmpty(Request.QueryString("ToDate")) = False Then
                txtDateTo.Text = Request.QueryString("ToDate")
            End If
            If String.IsNullOrEmpty(Request.QueryString("CID")) = False AndAlso IsNumeric(Request.QueryString("CID")) Then
                ddlClient.DataBind()
                ddlClient.SelectedValue = Request.QueryString("CID").ToString()
            Else
                If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            ddlClient.DataBind()
                ddlClient.SelectedValue = Request.QueryString("ClientID").ToString()
                End If
            End If

            If String.IsNullOrEmpty(Request.QueryString("FID")) = False AndAlso IsNumeric(Request.QueryString("FID")) Then
                ddlFranchises.DataBind()
                ddlFranchises.SelectedValue = Request.QueryString("FID")
            Else
                If String.IsNullOrEmpty(Request.QueryString("ddlFranchises")) = False AndAlso IsNumeric(Request.QueryString("ddlFranchises")) Then
                    ddlFranchises.DataBind()
                    ddlFranchises.SelectedValue = Request.QueryString("ddlFranchises")
                End If
            End If
            
            If String.IsNullOrEmpty(Request.QueryString("AssignedByNamesID")) = False AndAlso IsNumeric(Request.QueryString("AssignedByNamesID")) Then
                ddlAssignedByNames.DataBind()
                ddlAssignedByNames.SelectedValue = Request.QueryString("AssignedByNamesID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("CompletedByNamesID")) = False AndAlso IsNumeric(Request.QueryString("CompletedByNamesID")) Then
                ddlCompletedBy.DataBind()
                ddlCompletedBy.SelectedValue = Request.QueryString("CompletedByNamesID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("RelatedTo")) = False AndAlso IsNumeric(Request.QueryString("RelatedTo")) Then
                ddlRelatedTo.DataBind()
                ddlRelatedTo.SelectedValue = Request.QueryString("RelatedTo")
            End If
            If String.IsNullOrEmpty(Request.QueryString("PriorityID")) = False AndAlso IsNumeric(Request.QueryString("PriorityID")) Then
                ddlPriority.DataBind()
                ddlPriority.SelectedValue = Request.QueryString("PriorityID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("TypeID")) = False AndAlso IsNumeric(Request.QueryString("TypeID")) Then
                ddlType.SelectedValue = Request.QueryString("TypeID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("SubTypeID")) = False AndAlso IsNumeric(Request.QueryString("SubTypeID")) Then
                ddlSubType.SelectedValue = Request.QueryString("SubTypeID")
            End If

            If String.IsNullOrEmpty(Request.QueryString("search")) = False Then
                txtSearch.Text = Request.QueryString("search")
            End If

            If Not String.IsNullOrEmpty(Request.QueryString("PageIndex")) Then
                If Request.QueryString("PageIndex") = 0 Then
                    gvInbox.PageIndex = 0
                Else
                    gvInbox.PageIndex = Request.QueryString("PageIndex") - 1
                End If
            End If

            ddlClient.Attributes.Add("onchange", "javascript:parent.DisableDropDown();")
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SetClient", "parent.SetClient(" & ddlClient.SelectedValue & ");", True)
        End If

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

    Protected Sub ddlAssignedByNames_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAssignedByNames.DataBound
        ddlAssignedByNames.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub
    Protected Sub ddlCompletedBy_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCompletedBy.DataBound
        ddlCompletedBy.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub
    Protected Sub ddlRelatedTo_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlRelatedTo.DataBound
        ddlRelatedTo.Items.Insert(0, New ListItem("Show All", "0"))
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
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
        '    e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        'End If
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
                hdnPageIndex.Value = Pageindex
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
        If e.Row.RowType = DataControlRowType.Header Then
        End If
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Dim hdnDate As HiddenField = CType(e.Row.FindControl("hdnDate"), HiddenField)
            'Dim ts As TimeSpan
            'Dim dtTicketDate As DateTime = Convert.ToDateTime(hdnDate.Value)
            'Dim currDate As DateTime = DateTime.Now

            'If dtTicketDate.Date = DateTime.Now.Date Then
            '    If dtTicketDate > currDate Then
            '        ts = dtTicketDate.Subtract(currDate)
            '    Else
            '        ts = currDate.Subtract(dtTicketDate)
            '    End If
            'Else
            '    ts = DateTime.Now.Subtract(hdnDate.Value)
            'End If

            'If (ts.TotalDays * 24) > 6 AndAlso DataBinder.Eval(e.Row.DataItem, "ActivityState") <> Portal.BLL.Enumeration.ActivityState.Completed Then
            '    e.Row.CssClass = "RedRowNew-HD"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRowNew-HD';hideToolTip();")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 5 Then
            '    e.Row.CssClass = "RedRow-HD"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRow-HD';hideToolTip();")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 2 Then
            '    e.Row.CssClass = "GreenRow-HD"
            '    e.Row.Attributes.Add("onmouseout", "this.className='GreenRow-HD';hideToolTip();")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 3 Then
            '    e.Row.CssClass = "YellowRow-HD"
            '    e.Row.Attributes.Add("onmouseout", "this.className='YellowRow-HD';hideToolTip();")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 4 Then
            '    e.Row.CssClass = "OrangeRow-HD"
            '    e.Row.Attributes.Add("onmouseout", "this.className='OrangeRow-HD';hideToolTip();")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 1 Then
            '    e.Row.CssClass = "SimpleHomeRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';hideToolTip();")
            'Else
            '    e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';hideToolTip();")
            'End If

            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';hideToolTip();")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("OnClick", "RowClick(" & DataBinder.Eval(e.Row.DataItem, "Activity_ID") & "," & DataBinder.Eval(e.Row.DataItem, "ClientID") & "," & DataBinder.Eval(e.Row.DataItem, "FranchiseID") & ");")

            e.Row.Cells(4).Attributes.Add("onmousemove", "showToolTip('" & "Subject: " & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Subject"), "")).Replace("'", "") & "<br />Initiated By: " & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "ContactName"), "")) & "<br />TimeSpent: " & Server.HtmlEncode(DataBinder.Eval(e.Row.DataItem, "TimeSpent")) & "<br />Priority: " & Server.HtmlEncode(Functions.GetActivityPriorityByID_New(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Priority"), "2"))) & "');")
            e.Row.Cells(5).Attributes.Add("onmousemove", "showToolTip('" & "Status:<br />" & Server.HtmlEncode(DataBinder.Eval(e.Row.DataItem, "ActivityStateText")) & IIf(DataBinder.Eval(e.Row.DataItem, "ActivityState") = 4, ":" & Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "WaitingForName"), ""), 100)), "") & "');")
            e.Row.Cells(6).Attributes.Add("onmousemove", "showToolTip('" & "Created Date:<br />" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Activity_Date"), "")) & "');")
            e.Row.Cells(7).Attributes.Add("onmousemove", "showToolTip('" & "Last Updated On:<br />" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "LastUpdatedOn"), "")) & "');")
        End If
        If e.Row.RowType = DataControlRowType.Footer Then
        End If
    End Sub
  
    Protected Sub sdsInbox_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles sdsInbox.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False Or ddlType.SelectedValue <> "0" Or ddlSubType.SelectedValue <> "0" Or ddlFranchises.SelectedValue <> "0" Then
            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If
        If IsNumeric(e.ReturnValue) = True Then
            lblActivityCount.Text = e.ReturnValue.ToString()
        End If       
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
        Dim ClientIDlist As String
        For Each item As ListItem In ddlClient.Items
            ClientIDlist += item.Value + ","
        Next
        ClientIDlist.Remove(ClientIDlist.LastIndexOf(","))
        hdnClientIDList.Value = ClientIDlist
    End Sub
    Protected Sub ddlClient_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.SelectedIndexChanged

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeCount", "parent.SetClient(" & ddlClient.SelectedValue & ");", True)
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateMessageScript", "parent.EnableDropDown();", True)
    End Sub
    Protected Sub ddlFranchises_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFranchises.DataBound
        ddlFranchises.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If String.IsNullOrEmpty(Request.QueryString("search")) = False Then
            txtSearch.Text = ""
        End If
    End Sub
End Class