Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Partial Class Com_Fran_Inbox
    Inherits System.Web.UI.Page

    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Dim colEAFranchise As New List(Of Franchises)()
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(1);</script>")
        If Not IsPostBack Then
            hdnHasSupportAccess.Value = HasSupportAccess()
            hdnStoreID.Value = Functions.EncryptData(Enumeration.LoginAccountID.Store)
            hdnOwnerID.Value = Functions.EncryptData(Enumeration.LoginAccountID.Owner)
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDiv", "showHideVital();", True)
        End If
        If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
            hdnFranchiseID.Value = Request.QueryString("FranchiseID").ToString()
        End If
        If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            hdnClientID.Value = Request.QueryString("ClientID").ToString()
            Dim colClients As New System.Collections.Generic.List(Of Portal.BLL.Client.Clients)()
            colClients = Portal.BLL.Client.Clients.ClientsGetByID(CInt(hdnClientID.Value))
            If (colClients.Count > 0) Then
                lblClient.Text = colClients.Item(0).Name
            End If
        End If

        LoadOwnerAndStoreLogin()

    End Sub

    Public Sub LoadOwnerAndStoreLogin()

        'If Session("AdminId") = Enumeration.Users.Rehan_Shahab Or Session("AdminId") = Enumeration.Users.Catherine_Sobask Then

        '    OwnerLogin.Visible = True
        '    imgSeparator.Visible = True
        '    StoreLogin.Visible = True
'
        '    OwnerLogin.Attributes.Add("onclick", "FranchiseLogin('1','" & Functions.EncryptData(Request.QueryString("FranchiseID").ToString()) & "');")
        '    StoreLogin.Attributes.Add("onclick", "FranchiseLogin('0','" & Functions.EncryptData(Request.QueryString("FranchiseID").ToString()) & "');")
'
        'End If

    End Sub
    Private Function HasSupportAccess() As Boolean
        Dim str As String() = CStr(Session("UsersModulesID")).Split(",")
        For i As Integer = 0 To str.Length - 1
            If IsNumeric(str(i)) AndAlso CInt(str(i)) = CInt(Portal.BLL.Enumeration.Modules.BillingSupport) Then
                Return True
            End If
        Next
		'Special Check for Rehan to allow him to sign up ESET Antivirus.
		If (CInt(Session("AdminID")) = Portal.BLL.Enumeration.Users.Rehan_Shahab) Then
            Return True
        End If
        Return False
    End Function

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
            'Dim tcksubject As String = DataBinder.Eval(e.Row.DataItem, "Subject")
            If (ts.TotalDays * 24) > 24 OrElse CInt(DataBinder.Eval(e.Row.DataItem, "Priority") = 4) Then          ' To put that focefully high
                e.Row.CssClass = "RedRowInbox"
                'e.Row.Attributes.Add("onmouseout", "this.className='RedRowInbox';")
            End If
            'If tcksubject.ToLower().Contains("installation") Then
            '    e.Row.CssClass = "YellowInstallationRowInbox"
            If CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 2 Then
                    e.Row.CssClass = "YellowRow"
                    e.Row.Attributes.Add("onmouseout", "this.className='YellowRow';")
                ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 3 Then
                e.Row.CssClass = "OrangeRowNew"
                e.Row.Attributes.Add("onmouseout", "this.className='OrangeRowNew';")
            ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 4 Then
                e.Row.CssClass = "RedRowNew"
                e.Row.Attributes.Add("onmouseout", "this.className='RedRowNew';")
            ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 1 Then
                    e.Row.CssClass = "SimpleHomeRow"
                    e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
                ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 5 Then
                    e.Row.CssClass = "RedRowInbox"
                    e.Row.Attributes.Add("onmouseout", "this.className='RedRowInbox';")
            End If

            'If (ts.TotalDays * 24) > 24 Then
            '    e.Row.CssClass = "RedRowNew"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRowNew';")
            'ElseIf CInt(CType(e.Row.FindControl("lblIntType"), Label).Text) = 1 And ((DateTime.Now.Day - CDate(DataBinder.Eval(e.Row.DataItem, "Activity_Date")).Day) > 2) Or CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 5 Then
            '    e.Row.CssClass = "RedRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRow';")
            'ElseIf (ts.TotalDays * 24) > 48 Then
            '    e.Row.CssClass = "RedRowInboxCritical"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRowInboxCritical';")
            
           
            'If tcksubject.ToLower().Contains("installation") Then
            '    e.Row.CssClass=""
            '    e.Row.CssClass = "YellowInstallationRowInbox"
            'End If

            'If CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 2 Then
            '    e.Row.CssClass = "YellowRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='YellowRow';")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 3 Then
            '    e.Row.CssClass = "OrangeRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='OrangeRow';")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 4 Then
            '    e.Row.CssClass = "RedRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRow';")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 1 Then
            '    e.Row.CssClass = "SimpleHomeRow"
            '    e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            'ElseIf CInt(DataBinder.Eval(e.Row.DataItem, "Priority")) = 5 Then
            '    e.Row.CssClass = "RedRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "this.className='RedRowInbox';")
            'Else
            '    e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            'End If

            'Dim tcksubject As String = DataBinder.Eval(e.Row.DataItem, "Subject")
            'If tcksubject.ToLower().Contains("installation") Then
            '    e.Row.CssClass = "GreenOrderRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "this.className='GreenOrderRowInbox';")

            'ElseIf (tcksubject.ToLower().Contains("order")) Then
            '    e.Row.CssClass = "BlueInstallationRowInbox"
            '    e.Row.Attributes.Add("onmouseout", "this.className='BlueInstallationRowInbox';")
            'End If


            'e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")

            e.Row.Attributes.Add("OnClick", "javascript:window.location='ActivityDetail.aspx?ID=" & CType(e.Row.FindControl("lblID"), Label).Text & "&PrevPage=5&FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value & "';return false;")
        End If
        If e.Row.RowType = DataControlRowType.Footer Then
        End If
    End Sub
    Protected Sub sdsInbox_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles sdsInbox.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False Then
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

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not IsPostBack Then
            BindEAFranchise()
        End If
    End Sub
    Protected Sub BindEAFranchise()
        Dim franchiseList As List(Of Portal.BLL.Franchises)
        franchiseList = Portal.BLL.Franchises.FranchiseGetByID(CInt(hdnClientID.Value), CInt(hdnFranchiseID.Value))
        If (franchiseList.Count > 0) Then
            lblFranchiseName.Text = franchiseList.Item(0).StoreName & " " & franchiseList.Item(0).StoreNumber
            If (franchiseList.Item(0).IsCorporate = True) Then
                tdCorpInfo.Visible = False
            Else
                tdCorpInfo.Visible = True
            End If
            lblStore.Text = lblFranchiseName.Text
            hdnFranStatus.Value = franchiseList.Item(0).Status

           If hdnFranStatus.Value = Enumeration.StoreStatus.Operating Then
                If franchiseList.Item(0).IsSuspended Then
                    DivMessageFranchiseMSG.InnerText = "THIS STORE IS SUSPENDED!"
                    hdnFranIsSuspendedOrAbandon.Value = True
                ElseIf franchiseList.Item(0).IsAbandon Then
                    DivMessageFranchiseMSG.InnerText = "THIS STORE IS ABANDON!"
                    hdnFranIsSuspendedOrAbandon.Value = True
                Else
                    hdnFranIsSuspendedOrAbandon.Value = False
                End If
            ElseIf hdnFranStatus.Value = Enumeration.StoreStatus.Suspended Then
                DivMessageFranchiseMSG.InnerText = "THIS STORE IS SUSPENDED!"
                hdnFranIsSuspendedOrAbandon.Value = True
            ElseIf hdnFranStatus.Value = Enumeration.StoreStatus.Terminated Then
                DivMessageFranchiseMSG.InnerText = "THIS STORE IS TERMINATED!"
                hdnFranIsSuspendedOrAbandon.Value = True
            ElseIf hdnFranStatus.Value = Enumeration.StoreStatus.Transferred Then
                DivMessageFranchiseMSG.InnerText = "THIS STORE IS TRANSFERRED!"
                hdnFranIsSuspendedOrAbandon.Value = True
            Else
                'Enumeration.StoreStatus.ComingSoon Or Enumeration.StoreStatus.Corporate 
                'Do Nothing
                hdnFranIsSuspendedOrAbandon.Value = False
            End If

        End If
    End Sub
    Protected Sub gvHistory_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvHistory.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
           'e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
           'e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
    End Sub

    Protected Sub gvHistory_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvHistory.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("OnClick", "javascript:window.location='ActivityDetail.aspx?ID=" & CType(e.Row.FindControl("lblID"), Label).Text & "&PrevPage=5&ClientID=" & hdnClientID.Value & "&FranchiseID=" & CType(e.Row.FindControl("lblFranchiseID"), Label).Text & "';return false;")
        End If
    End Sub
End Class