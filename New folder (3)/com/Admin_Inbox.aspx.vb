Imports System.IO


Partial Class com_admin_inbox
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""


    '
    Public strSupportStatus As String
    Public lngHelpDeskCount As Integer
    Public lngActivities As Integer
    Dim totalPagesInbox As Integer = 0
    Dim totalRecordsInbox As Integer = 0
    Dim totalPagesActivity As Integer = 0
    Dim totalRecordsActivity As Integer = 0

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
            pageContent = Functions.RemoveWhitespaceFromJavaScript(pageContent)
            pageContent = Functions.RemoveWhitespaceFromHtml(pageContent)
        End If
        writer.Write(pageContent)
    End Sub
    'Protected Overloads Overrides Function LoadPageStateFromPersistenceMedium() As Object
    '    Dim formatter As New LosFormatter()

    '    Dim viewState As String = Request.Form("__VSTATE")
    '    Dim bytes As Byte() = Convert.FromBase64String(viewState)
    '    bytes = Functions.DecompressViewState(bytes)

    '    Return formatter.Deserialize(Convert.ToBase64String(bytes))
    'End Function

    'Protected Overloads Overrides Sub SavePageStateToPersistenceMedium(ByVal viewState As Object)
    '    Try
    '        Dim formatter As New LosFormatter()
    '        Dim writer As New StringWriter()
    '        formatter.Serialize(writer, viewState)
    '        Dim viewStateString As String = writer.ToString()
    '        Dim bytes As Byte() = Convert.FromBase64String(viewStateString)
    '        bytes = Functions.CompressViewState(bytes)
    '        ClientScript.RegisterHiddenField("__VSTATE", Convert.ToBase64String(bytes))
    '    Catch ex As Exception
    '        Trace.Write(ex.Message)
    '    End Try
    'End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(1);</script>")
        hdnAdminID.Value = Session("AdminID")
        hdnSubModuleID.Value = Portal.BLL.Enumeration.SubModules.HelpDesk
        If Not IsPostBack Then
            lbtnExportToExcel.Attributes.Add("onclick", "javascript:return OpenTicketsExportToExcel();")
            hdnHasSupportAccess.Value = HasSupportAccess()
            ddlClient.DataBind()
            ddlFranchises.DataBind()
            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                ddlClient.DataBind()
                ddlClient.SelectedValue = Request.QueryString("ClientID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False AndAlso IsNumeric(Request.QueryString("TopicID")) Then
                ddlTopics.DataBind()
                ddlTopics.SelectedValue = Request.QueryString("TopicID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("ddlFranchises")) = False AndAlso IsNumeric(Request.QueryString("ddlFranchises")) Then
                ddlFranchises.DataBind()
                ddlFranchises.SelectedValue = Request.QueryString("ddlFranchises")
            End If
            If String.IsNullOrEmpty(Request.QueryString("FilterID")) = False AndAlso IsNumeric(Request.QueryString("FilterID")) Then
                ddlFilters.DataBind()
                ddlFilters.SelectedValue = Request.QueryString("FilterID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("AssignedByNamesID")) = False AndAlso IsNumeric(Request.QueryString("AssignedByNamesID")) Then
                ddlAssignedByNames.DataBind()
                ddlAssignedByNames.SelectedValue = Request.QueryString("AssignedByNamesID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("WaitingForNamesID")) = False AndAlso IsNumeric(Request.QueryString("WaitingForNamesID")) Then
                ddlWaitingForNames.DataBind()
                ddlWaitingForNames.SelectedValue = Request.QueryString("WaitingForNamesID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("PriorityID")) = False AndAlso IsNumeric(Request.QueryString("PriorityID")) Then
                ddlPriority.DataBind()
                ddlPriority.SelectedValue = Request.QueryString("PriorityID")
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
            getInboxCount()
            'ddlClient.Attributes.Add("onchange", "javascript:parent.DisableDropDown();")
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SetClient", "parent.SetClient(" & ddlClient.SelectedValue & ");", True)
        End If
    End Sub

    Protected Sub ddlClient_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.SelectedIndexChanged
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SetClient", "parent.SetClient(" & ddlClient.SelectedValue & ");", True)
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateMessageScript", "parent.EnableDropDown();", True)
    End Sub
    Protected Sub ddlFranchises_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFranchises.DataBound
        ddlFranchises.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub
    Protected Sub ddlTopics_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTopics.DataBound
        ddlTopics.Items.Insert(0, New ListItem("Select...", "0"))
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

    Protected Sub ddlAssignedByNames_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAssignedByNames.DataBound
        ddlAssignedByNames.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlWaitingForNames_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWaitingForNames.DataBound
        ddlWaitingForNames.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Private Function HasSupportAccess() As Boolean
        Dim str As String() = CStr(Session("UsersModulesID")).Split(",")
        For i As Integer = 0 To str.Length - 1
            If IsNumeric(str(i)) AndAlso CInt(str(i)) = CInt(Portal.BLL.Enumeration.Modules.BillingSupport) Then
                Return True
            End If
        Next
        Return False
    End Function
    


    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If String.IsNullOrEmpty(Request.QueryString("search")) = False Then
            txtSearch.Text = ""
        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "inboxcount", "inboxCount('" & CType(hdnActivityCount.Value, Integer) + CType(hdnHelpdeskCount.Value, Integer) & "' );", True)
    End Sub

    Protected Sub sdsInbox_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles sdsInbox.Selected
        If txtSearch.Text <> "" Then
            lblActvityFilter.Text = "Filtered"
            lblHelpDiskFilter.Text = "Filtered"
        Else
            lblActvityFilter.Text = "All"
            lblHelpDiskFilter.Text = "All"
        End If
        If (IsNumeric(e.ReturnValue)) Then
            totalRecordsInbox = e.ReturnValue
            totalPagesInbox = CInt(Math.Ceiling(e.ReturnValue / gvInbox.PageSize))
            hdnHelpdeskCount.Value = e.ReturnValue
            lblHelpDiskCount.Text = e.ReturnValue
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClassStyle", "ChangeRowsClass();", True)
            End If
        End If
    End Sub

    Protected Sub sdsActivity_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsActivity.Selected
        If (IsNumeric(e.ReturnValue)) Then
            totalRecordsActivity = e.ReturnValue
            totalPagesActivity = CInt(Math.Ceiling(e.ReturnValue / GV_Activity.PageSize))
            hdnActivityCount.Value = e.ReturnValue
            lblActivityCount.Text = e.ReturnValue
            lblActivityCountFiltered.Text = e.ReturnValue
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)

            End If
        End If
    End Sub

    Protected Sub gvInbox_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvInbox.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim hdnDate As HiddenField = CType(e.Row.FindControl("hdnDate"), HiddenField)
            Dim ts As TimeSpan
            Dim dtTicketDate As DateTime = Convert.ToDateTime(hdnDate.Value)
            Dim currDate As DateTime = DateTime.Now

            If dtTicketDate.Date = DateTime.Now.Date Then
                If dtTicketDate > currDate Then
                    ts = dtTicketDate.Subtract(currDate)
                Else
                    ts = currDate.Subtract(dtTicketDate)
                End If
            Else
                ts = DateTime.Now.Subtract(hdnDate.Value)
            End If

            If (ts.TotalDays * 24) > 24 OrElse CInt(DataBinder.Eval(e.Row.DataItem, "Priority") = 4) Then          ' To put that focefully high
                e.Row.CssClass = "RedRowInbox"
                e.Row.Attributes.Add("onmouseout", "RowOut(this,'RedInbox');")
            End If


            'If (ts.TotalDays * 24) > 6 Then                ' Ticket Ref # 20411  Delayed Ticket [Adam Request]
            '    e.Row.CssClass = "RedRowNewInbox"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'RedNewInbox');")
            'ElseIf (CInt(DataBinder.Eval(e.Row.DataItem, "ActivityState")) = 1 And ((DateTime.Now.Day - CDate(DataBinder.Eval(e.Row.DataItem, "Activity_Date")).Day) > 2)) Or CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 5 Then
            '    e.Row.CssClass = "RedRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'RedInbox');")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 2 Then
            '    e.Row.CssClass = "GreenRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'GreenInbox');")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 3 Then
            '    e.Row.CssClass = "YellowRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'YellowInbox');")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 4 Then
            '    e.Row.CssClass = "OrangeRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'OrangeInbox');")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 1 Then
            '    e.Row.CssClass = "SimpleHomeRow"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'SimpleHome');")
            'Else
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'SimpleHome');")
            'End If

            'If (ts.TotalDays * 24) > 24 AndAlso (ts.TotalDays * 24) < 48 Then          ' To put that focefully high
            '    e.Row.CssClass = "OrangeRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'OrangeInbox');")
            'ElseIf (ts.TotalDays * 24) > 48 Then                  ' To put that focefully high
            '    e.Row.CssClass = "RedRowInboxCritical"
            '    e.Row.Attributes.Add("onmouseout", "RowOut(this,'RedInboxCritical');")
            'End If

            Dim tcksubject As String = DataBinder.Eval(e.Row.DataItem, "Subject")
            If tcksubject.ToLower().Contains("installation") Then
                e.Row.CssClass = "YellowInstallationRowInbox"
            End If


            e.Row.Attributes.Add("onmouseover", "RowOver(this);")
            e.Row.Attributes.Add("OnClick", "RowClick(" & DataBinder.Eval(e.Row.DataItem, "Activity_ID") & "," & DataBinder.Eval(e.Row.DataItem, "ClientID") & "," & DataBinder.Eval(e.Row.DataItem, "FranchiseID") & ");")

            Dim timespent As String = Server.HtmlEncode(FormatNumber(TimeSpan.Parse(DataBinder.Eval(e.Row.DataItem, "TimeSpent")).TotalHours, 0).PadLeft(2, "0") & ":" & TimeSpan.Parse(DataBinder.Eval(e.Row.DataItem, "TimeSpent")).Minutes.ToString.PadLeft(2, "0"))

            e.Row.Cells(4).Attributes.Add("onmousemove", "ToolTipSub('" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Subject"), "")).Replace("'", "") & "','" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "ContactName"), "")) & "','" & timespent & "','" & Server.HtmlEncode(Functions.GetActivityPriorityByID_New(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Priority"), "2"))) & "');")
            e.Row.Cells(5).Attributes.Add("onmousemove", "ToolTipSta('" & Server.HtmlEncode(DataBinder.Eval(e.Row.DataItem, "ActivityStateText")) & IIf(DataBinder.Eval(e.Row.DataItem, "ActivityState") = 4, ":" & Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "WaitingForName"), ""), 100)), "") & "');")
            e.Row.Cells(6).Attributes.Add("onmousemove", "ToolTipCre('" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Activity_Date"), "")) & "');")
            e.Row.Cells(7).Attributes.Add("onmousemove", "ToolTipUpd('" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "LastUpdatedOn"), "")) & "');")
        End If
       
        ' pager 
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvInbox.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = totalPagesInbox.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvInbox.PageIndex = 0) Then
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
            If (gvInbox.PageIndex = totalPagesInbox - 1) Then
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
                lnkBtnPage.CommandArgument = totalPagesInbox.ToString()

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
                lnkBtnPage.CommandArgument = totalPagesInbox.ToString()

            End If

            '''''Setting the No of Records that are being shown 
            If (((gvInbox.PageIndex + 1) * gvInbox.PageSize) < totalPagesInbox * gvInbox.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvInbox.PageIndex + 1) * gvInbox.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = totalRecordsInbox
        End If
            ''''Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvInbox.PageIndex * gvInbox.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = totalRecordsInbox

        End If

    End Sub
    Protected Sub GV_Activity_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GV_Activity.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim hdnDate As HiddenField = CType(e.Row.FindControl("hdnDate"), HiddenField)
            Dim ts As TimeSpan
            Dim dtTicketDate As DateTime = Convert.ToDateTime(hdnDate.Value)
            Dim currDate As DateTime = DateTime.Now

            If dtTicketDate.Date = DateTime.Now.Date Then
                If dtTicketDate > currDate Then
                    ts = dtTicketDate.Subtract(currDate)
                Else
                    ts = currDate.Subtract(dtTicketDate)
                End If
            Else
                ts = DateTime.Now.Subtract(hdnDate.Value)
            End If


            If (ts.TotalDays * 24) > 24 OrElse CInt(DataBinder.Eval(e.Row.DataItem, "Priority") = 4) Then          ' To put that focefully high
                e.Row.CssClass = "RedRowInbox"
                e.Row.Attributes.Add("onmouseout", "RowOut(this,'RedInbox');")
            End If

            Dim tcksubject As String = DataBinder.Eval(e.Row.DataItem, "Subject")
            If tcksubject.ToLower().Contains("installation") Then
                e.Row.CssClass = "YellowInstallationRowInbox"
            End If

            e.Row.Attributes.Add("onmouseover", "RowOver(this);")


            e.Row.Attributes.Add("OnClick", "RowClick(" & DataBinder.Eval(e.Row.DataItem, "Activity_ID") & "," & DataBinder.Eval(e.Row.DataItem, "ClientID") & "," & DataBinder.Eval(e.Row.DataItem, "FranchiseID") & ");")

            Dim timespent As String = Server.HtmlEncode(FormatNumber(TimeSpan.Parse(DataBinder.Eval(e.Row.DataItem, "TimeSpent")).TotalHours, 0).PadLeft(2, "0") & ":" & TimeSpan.Parse(DataBinder.Eval(e.Row.DataItem, "TimeSpent")).Minutes.ToString.PadLeft(2, "0"))

            e.Row.Cells(4).Attributes.Add("onmousemove", "ToolTipSub('" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Subject"), "")).Replace("'", "") & "','" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "ContactName"), "")) & "','" & timespent & "','" & Server.HtmlEncode(Functions.GetActivityPriorityByID_New(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Priority"), "2"))) & "');")
            e.Row.Cells(5).Attributes.Add("onmousemove", "ToolTipSta('" & Server.HtmlEncode(DataBinder.Eval(e.Row.DataItem, "ActivityStateText")) & IIf(DataBinder.Eval(e.Row.DataItem, "ActivityState") = 4, ":" & Server.HtmlEncode(Functions.StringTruncate(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "WaitingForName"), ""), 100)), "") & "');")
            e.Row.Cells(6).Attributes.Add("onmousemove", "ToolTipCre('" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "Activity_Date"), "")) & "');")
            e.Row.Cells(7).Attributes.Add("onmousemove", "ToolTipUpd('" & Server.HtmlEncode(Functions.IfNull(DataBinder.Eval(e.Row.DataItem, "LastUpdatedOn"), "")) & "');")
        End If

        'If e.Row.RowType = DataControlRowType.Footer Then
        '    UpdatePanel1.Update()
        '    updatepnlHelpdesk.Update()
        'End If


        ' Pager 
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage1"), Literal).Text = (GV_Activity.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage1"), Literal).Text = totalPagesActivity.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (GV_Activity.PageIndex = 0) Then
                'Disable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious1"), Image)
                imgPage.ImageUrl = "../images/back_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious1"), LinkButton)
                lnkBtnPage.Enabled = False
                'Disalbe First Button
                imgPage = CType(e.Row.FindControl("imgFirst1"), Image)
                imgPage.ImageUrl = "../images/First_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst1"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                'Enable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious1"), Image)
                imgPage.ImageUrl = "../images/back_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious1"), LinkButton)
                lnkBtnPage.Enabled = True

                'Enable Last First Button
                imgPage = CType(e.Row.FindControl("imgFirst1"), Image)
                imgPage.ImageUrl = "../images/First_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst1"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'To enable and Disable Next Image button.
            If (GV_Activity.PageIndex = totalPagesActivity - 1) Then
                'Disable Next Button
                imgPage = CType(e.Row.FindControl("imgNext1"), Image)
                imgPage.ImageUrl = "../images/Next_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext1"), LinkButton)
                lnkBtnPage.Enabled = False

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast1"), Image)
                imgPage.ImageUrl = "../images/Last_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast1"), LinkButton)
                lnkBtnPage.Enabled = False
                lnkBtnPage.CommandArgument = totalPagesActivity.ToString()

            Else
                imgPage = CType(e.Row.FindControl("imgNext1"), Image)
                imgPage.ImageUrl = "../images/Next_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext1"), LinkButton)
                lnkBtnPage.Enabled = True


                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast1"), Image)
                imgPage.ImageUrl = "../images/Last_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast1"), LinkButton)
                lnkBtnPage.Enabled = True
                lnkBtnPage.CommandArgument = totalPagesActivity.ToString()

            End If

            '''''Setting the No of Records that are being shown 
            If (((GV_Activity.PageIndex + 1) * GV_Activity.PageSize) < totalPagesActivity * GV_Activity.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount1"), Literal).Text = Convert.ToString((GV_Activity.PageIndex + 1) * GV_Activity.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount1"), Literal).Text = totalRecordsActivity
            End If
            ''''Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount1"), Literal).Text = Convert.ToString((GV_Activity.PageIndex * GV_Activity.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount1"), Literal).Text = totalRecordsActivity

        End If

    End Sub

    Public Sub getInboxCount()
        Dim intInboxCount As Integer = Portal.BLL.Activities.GetAdminInboxForHelpDeskcount_ByClientIdList(0, 0, 0, String.Empty, -1, 0, 0, 0, 0, "0,16,13,1,18,19,2,17,3,15,14", "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25")
        ClientScript.RegisterStartupScript(Me.GetType(), "InboxCount", "parent.SetInBox(" & intInboxCount & ");", True)
    End Sub

End Class