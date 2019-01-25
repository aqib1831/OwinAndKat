Imports System.Collections.Generic
Imports Microsoft.VisualBasic
Partial Class PM_Features
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    'Dim reClient As String
    'Dim reCatagory As String
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If HttpContext.Current.Request.QueryString("reClients") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("reClients")) Then
            hdnClient.Value = Request.QueryString("reClients")
        End If
        If HttpContext.Current.Request.QueryString("reCategories") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("reCategories")) Then
            hdnCatagory.Value = Request.QueryString("reCategories")
        End If
        If Not Page.IsPostBack Then
            'If (Portal.BLL.Users.CheckUserSubModulesAccess(Portal.BLL.Enumeration.SubModules.PMFullAccess) = False) Then
            btnnewfeature.Style.Add("visibility", "hidden")
            'End If
            FillddlFilter()
            'ddlClients.DataBind()
            'If HttpContext.Current.Request.QueryString("ftrClients") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ftrClients")) Then
            '    ddlClients.SelectedValue = Request.QueryString("ftrClients")
            'End If
            ddlCategories.DataBind()
            If HttpContext.Current.Request.QueryString("ftrCategories") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ftrCategories")) Then
                ddlCategories.SelectedValue = Request.QueryString("ftrCategories")
            End If
            ddlTypes.DataBind()
            If HttpContext.Current.Request.QueryString("ftrTypes") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ftrTypes")) Then
                ddlTypes.SelectedValue = Request.QueryString("ftrTypes")
            End If
            If HttpContext.Current.Request.QueryString("ftrFilter") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ftrFilter")) Then
                ddlFilter.SelectedValue = Request.QueryString("ftrFilter")
            End If
            If HttpContext.Current.Request.QueryString("ftrSearch") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ftrSearch")) Then
                txtSearch.Text = Request.QueryString("ftrSearch")
            End If

            If HttpContext.Current.Request.QueryString("ID") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ID")) Then
                ReleaseID.Value = Request.QueryString("ID")
                LoadRelease()
                'btnnewfeature.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/FeaturesNew.aspx?ReleaseID=" & ReleaseID.Value) & "&ddlClients=" & ddlClients.SelectedValue & "&ddlCategories=" & ddlCategories.SelectedValue & "&ddlTypes=" & ddlTypes.SelectedValue & "&ddlFilter=" & ddlFilter.SelectedValue & "'; return false; ")

                'If HttpContext.Current.Request.QueryString("ddlClients") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlClients")) Then
                '    ddlClients.SelectedValue = Request.QueryString("ddlClients")
                'End If

                If HttpContext.Current.Request.QueryString("ddlCategories") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlCategories")) Then
                    ddlCategories.SelectedValue = Request.QueryString("ddlCategories")
                End If

                If HttpContext.Current.Request.QueryString("ddlTypes") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlTypes")) Then
                    ddlTypes.SelectedValue = Request.QueryString("ddlTypes")
                End If
                If HttpContext.Current.Request.QueryString("ddlFilter") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ddlFilter")) Then
                    ddlFilter.SelectedValue = Request.QueryString("ddlFilter")
                End If
                If HttpContext.Current.Request.QueryString("txtSearch") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("txtSearch")) Then
                    txtSearch.Text = Request.QueryString("txtSearch")
                End If
                If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
                    PrevPage.Value = CInt(Request.QueryString("PrevPage"))
                    Select Case PrevPage.Value
                        Case 1 'release page
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/PM/Releases.aspx?reClients=" & hdnClient.Value) & "&reCategories=" & hdnCatagory.Value & "'; return false; ")
                            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(1);</script>")
                        Case 2 'release history page
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/PM/ReleasesHistory.aspx?ddlClients=" & Session("MyNetsolace_ClientID")) & "&ddlCategories=" & ddlCategories.SelectedValue & "&reClients=" & hdnClient.Value & "&reCategories=" & hdnCatagory.Value & "'; return false; ")
                            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(6);</script>")
                        Case Else
                            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(1);</script>")
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/PM/Releases.aspx?reClients=" & hdnClient.Value) & "&reCategories=" & hdnCatagory.Value & "'; return false; ")
                    End Select
                Else
                    ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(1);</script>")
                    btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/MyNetsolaceClient/PM/Releases.aspx?reClients=" & hdnClient.Value) & "&reCategories=" & hdnCatagory.Value & "'; return false; ")
                End If

            End If
        End If

    End Sub
    Protected Sub LoadRelease()
        Dim objReleases As Portal.BLL.PM.PM_Releases = New Portal.BLL.PM.PM_Releases()
        Dim colReleases As New List(Of Portal.BLL.PM.PM_Releases)()
        colReleases = Portal.BLL.PM.PM_Releases.PM_ReleasesGetByID(ReleaseID.Value)
        If colReleases.Count > 0 Then
            Me.lblReleaseName.Text = colReleases.Item(0).Name

        End If
    End Sub
    Private Sub FillddlFilter()
        Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
        ddlFilter.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Assinged By Me", 1)
        ddlFilter.Items.Add(obj)
        'obj = New System.Web.UI.WebControls.ListItem("Waiting For Me", 2)
        'ddlFilter.Items.Add(obj)
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    'Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
    '    ddlClients.Items.Insert(0, New ListItem("Select...", 0))
    'End Sub
    Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
        ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
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
        If e.CommandName <> "Sort" Then
            Dim ID As Integer = Convert.ToInt32(e.CommandArgument)
            If e.CommandName = "Edit" Then
                Response.Redirect("TicketsDetail.aspx?ReleaseID=" & ReleaseID.Value & "&ID=" & ID & "&ddlClients=" & Session("MyNetsolace_ClientID") & "&ddlCategories=" & ddlCategories.SelectedValue & "&reClients=" & hdnClient.Value & "&reCategories=" & hdnCatagory.Value & "&PrevPage=2")
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

            e.Row.Attributes.Add("onClick", "javascript:window.location='TicketsDetail.aspx?ReleaseID=" & ReleaseID.Value & "&ID=" & CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) & "&ddlClients=" & Session("MyNetsolace_ClientID").ToString() & "&ddlCategories=" & ddlCategories.SelectedValue.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & ddlFilter.SelectedValue.ToString() & "&txtSearch=" & txtSearch.Text.ToString() & "&reClients=" & hdnClient.Value & "&reCategories=" & hdnCatagory.Value & "&PrevPage=2';")

            Dim strRefNo As Integer = CType(DataBinder.Eval(e.Row.DataItem, "RefNo"), Integer)
            'If strRefNo <> 0 Then
            '    e.Row.Cells(0).Text = strRefNo.ToString()
            'ElseIf strRefNo = 0 Then
            '    e.Row.Cells(0).Text = CType(DataBinder.Eval(e.Row.DataItem, "ID"), String)
            'End If
            Dim strDueDate As Object
            Dim strStatus As String
            strDueDate = CType(DataBinder.Eval(e.Row.DataItem, "DueDate"), Object)
            strStatus = CType(DataBinder.Eval(e.Row.DataItem, "Status"), String)
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

    'Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
    '    e.InputParameters.Add("subModuleIds", Portal.BLL.Enumeration.SubModules.PMFullAccess & "," & Portal.BLL.Enumeration.SubModules.PMReadOnlyAccess)
    'End Sub
End Class