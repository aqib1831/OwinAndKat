
Partial Class HR_ManageTimeHistory
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
            LoadStores("")
            ' ddlUsers.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select...", 0))
            ddlUsers.FindItemByValue(CInt(Session("AdminID"))).Selected = True
            Me.txtStartDate.Text = System.DateTime.Now.Date.AddDays(-7).ToShortDateString()
            Me.txtEndDate.Text = System.DateTime.Now.Date.AddHours(24).ToShortDateString()
            hdnSessionID.value = Session("AdminID")
        End If
    End Sub

    Protected Sub ddlUsers_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlUsers.ItemsRequested
        LoadStores(e.Text)
    End Sub
    Private Sub LoadStores(ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@Search", byvalsearch)
        dt = db.ExecuteDataTable("HR_Users_GetAll_ForRadCombo")
        ddlUsers.DataSource = dt
        ddlUsers.DataBind()
    End Sub
    Private Sub RadComboBox1_ItemDataBound(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemDataBoundEventArgs) Handles ddlUsers.ItemDataBound
        e.Item.Text = CType(e.Item.DataItem, System.Data.DataRowView)("Name").ToString()
    End Sub
    Protected Sub ddlUsers_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlUsers.SelectedIndexChanged
        gvReleases.DataSourceID = ObjectDataSource1.ID
        gvReleases.DataBind()
    End Sub
    Protected Sub ddlUsers_SelectedIndexChanged()
       
    End Sub

    Protected Sub refreshGrid_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles refreshGrid.Click
        gvReleases.DataSourceID = ObjectDataSource1.ID
        gvReleases.DataBind()
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

    Protected Sub gvReleases_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvReleases.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            CType(e.Row.FindControl("lbtnNotes"), LinkButton).Attributes.Add("OnClick", "javascript:OpenNotes('" & CType(e.Row.FindControl("lblNotes"), Label).Text.Replace(vbCrLf, "$*") & "');return false;")
            e.Row.Cells(0).Attributes.Add("onclick", "EditTime(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(1).Attributes.Add("onclick", "EditTime(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(2).Attributes.Add("onclick", "EditTime(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(3).Attributes.Add("onclick", "EditTime(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(4).Attributes.Add("onclick", "EditTime(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(5).Attributes.Add("onclick", "EditTime(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            ' e.Row.Cells(6).Attributes.Add("onclick", "EditTime(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            ''Dim strpunchin As DateTime = CType(DataBinder.Eval(e.Row.DataItem, "PunchInTime"), DateTime)
            ''If (CType(FormatDateTime(strpunchin, DateFormat.LongTime), DateTime) > #9:16:00 AM#) Then
            ''    e.Row.Style.Add("background-color", "#FFF1F1")
            ''End If
        End If
    End Sub
    Protected Sub ObjectDataSource1_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ObjectDataSource1.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False Then

            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If

        If IsNumeric(e.ReturnValue.ToString()) Then
            lblErrorCount.Text = e.ReturnValue.ToString()
        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        LoadStores(lbluserid.Value)
        ddlUsers.Value = lbluserid.Value
        ddlUsers.Text = lblusername.Value
    End Sub


End Class

