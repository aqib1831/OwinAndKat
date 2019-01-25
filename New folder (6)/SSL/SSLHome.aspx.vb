Partial Class EA_SSL_Default
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""

#Region "Local Variables"

    Private l_Errortext As String
    Dim URLName As String
    Protected l_SortExpression As String
    Private l_Errorcode As Portal.BLL.Enumeration.ErrorType
    Private l_URLID As Integer

#End Region

#Region "Event Handler"

#Region "Page_Load"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        SetLoadingboxSettings()
        If Session("UserBrowser") = "AppleMAC-Safari" Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "Button Adjustment", "AdjustButtons(1);", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "Button Adjustment", "AdjustButtons(0);", True)
        End If
        If txtSearch.Text <> String.Empty Then
            hdnSearch.Value = txtSearch.Text
        Else
            hdnSearch.Value = String.Empty
        End If
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

#End Region

#Region "grdURLs_RowCommand"

    Protected Sub grdURLs_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdURLs.RowCommand

        If Not e.CommandName = "Page" Then
            Dim objSSLM As New SSLM
            If e.CommandName = "UpdateURL" Then
                objSSLM = SSLM.GetUrlByID(e.CommandArgument.ToString())
                UpdateURLInfo(objSSLM.URL)
                ViewState("URLID") = e.CommandArgument.ToString()
            ElseIf e.CommandName = "CheckStatus" Then
                objSSLM = SSLM.GetUrlByID(e.CommandArgument.ToString())
                CheckStatus(objSSLM.URL)
            ElseIf e.CommandName = "EditURL" Then
                ViewState("URLID") = e.CommandArgument.ToString()
                Call CtrlAlertDiv_MyClick()
                btnSave.Text = "Update"
                lblHeadertext.Text = "Update URL Information"
            End If
        End If
        If e.CommandName = "NextPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                grdURLs.PageIndex = CInt(e.CommandArgument.ToString()) - 1
                FirstPage = CInt(e.CommandArgument.ToString()) - 1
                LastPage = FirstPage + PageCount + 1
                If LastPage >= grdURLs.PageCount Then
                    LastPage = grdURLs.PageCount
                    FirstPage = LastPage - PageCount
                End If
                ViewState("LastPage") = LastPage.ToString()
                ViewState("FirstPage") = FirstPage.ToString()
            End If
        ElseIf e.CommandName = "PrevPages" Then
            If IsNumeric(e.CommandArgument.ToString()) Then
                grdURLs.PageIndex = CInt(e.CommandArgument.ToString()) - 1
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

#End Region

#Region "grdURLs_RowDataBound"
    Protected Sub grdURLs_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdURLs.DataBound
        Dim pagerRow As GridViewRow = grdURLs.BottomPagerRow
        If Not (pagerRow Is Nothing) Then
            Dim pageNum As Literal = CType(pagerRow.Cells(0).FindControl("litPageNumber"), Literal)
            Dim totalNum As Literal = CType(pagerRow.Cells(0).FindControl("litTotalPages"), Literal)
            If Not ((pageNum Is Nothing) Or (totalNum Is Nothing)) Then
                Dim Page As Int32 = grdURLs.PageIndex + 1
                Dim count As Int32 = grdURLs.PageCount
                pageNum.Text = Page.ToString()
                totalNum.Text = count.ToString()
                Dim Pageindex As Integer = 0
                Pageindex = grdURLs.PageIndex + 1
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
                        If LastPage >= grdURLs.PageCount Then
                            LastPage = grdURLs.PageCount
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
                Dim pageNumber As Panel = CType(pagerRow.Cells(0).FindControl("pnlNumber"), Panel)
                Dim PagerTable As HtmlTable = Functions.CreatePager(grdURLs.PageCount, grdURLs.PageIndex + 1, FirstPage, LastPage)
                pageNumber.Controls.Add(PagerTable)
            End If
        End If

    End Sub

    Protected Sub grdURLs_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdURLs.RowCreated

        If e.Row.RowType = DataControlRowType.DataRow Then
            ' ScriptManager1.RegisterPostBackControl(CType(e.Row.FindControl("btnUpdate"), ImageButton))
            'ScriptManager1.RegisterPostBackControl(CType(e.Row.FindControl("btnCheck"), ImageButton))
            'ScriptManager1.RegisterPostBackControl(CType(e.Row.FindControl("btnEdit"), ImageButton))

        End If
    End Sub

    Protected Sub grdURLs_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdURLs.RowDataBound
        Dim expirationDays As Integer
        Dim lnkSortButton As LinkButton
        Dim category As String

        'Change the color for comming expiry URLs
        If e.Row.RowType = DataControlRowType.DataRow Then
            expirationDays = CType(DataBinder.Eval(e.Row.DataItem, "RemaingDays"), Integer)
            category = CType(DataBinder.Eval(e.Row.DataItem, "Category"), String)
            'If expirationDays < 32 Then
            If (expirationDays < 32) And Not (category = "Sold") Then
                Dim rowForecolor As New Drawing.Color
                rowForecolor = e.Row.ForeColor

                e.Row.ForeColor = Drawing.Color.Red '.FromArgb(253, 236, 242)
                e.Row.Cells(6).ForeColor = Drawing.Color.FromName("#000000")
                e.Row.Cells(7).ForeColor = Drawing.Color.FromName("#000000")

            End If
            'Set the Images for sorting
        ElseIf e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.Controls.Count > 0 Then
                    lnkSortButton = CType(cell.Controls(0), LinkButton)
                    If lnkSortButton.CommandArgument = grdURLs.SortExpression Then
                        If grdURLs.SortDirection = SortDirection.Ascending Then
                            lnkSortButton.Text &= "&nbsp;<img src='../images/asc.gif' title='Sort ascending' border='0' style='vertical-align:middle;'  />"
                            l_SortExpression = grdURLs.SortExpression
                        Else
                            lnkSortButton.Text &= " &nbsp;<img src='../images/desc.gif' border='0' title='Sort descending' style='vertical-align:middle;' />"
                            l_SortExpression = grdURLs.SortExpression & " DESC"
                        End If
                        Session("SortExpression") = l_SortExpression
                    End If
                End If
            Next
        End If
    End Sub

#End Region

#Region "ddlCategory_DataBound"

    Protected Sub ddlCategory_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategory.DataBound
        ddlCategory.Items.Insert(0, New ListItem("All Categories", "0"))
        ddlCategory.SelectedValue = "0"
    End Sub
    Protected Sub ddlCategory1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategory1.DataBound
        ddlCategory1.Items.Insert(0, New ListItem("Select Category", "0"))
    End Sub
#End Region

#Region "ddlAccount_DataBound"

    Protected Sub ddlAccount_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAccount.DataBound
        ddlAccount.Items.Insert(0, New ListItem("All Accounts", "0"))
        ddlAccount.SelectedValue = "0"
    End Sub
    Protected Sub ddlAccount1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAccount1.DataBound
        ddlAccount1.Items.Insert(0, New ListItem("Select Account", "0"))
    End Sub

#End Region

#Region "ddlRegistrar_DataBound"

    Protected Sub ddlRegistrar_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlRegistrar.DataBound
        ddlRegistrar.Items.Insert(0, New ListItem("All Registrars", "0"))
        ddlRegistrar.SelectedValue = "0"
    End Sub
    Protected Sub ddlRegistrar1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlRegistrar1.DataBound
        ddlRegistrar1.Items.Insert(0, New ListItem("Select Registrar", "0"))
    End Sub

#End Region

#Region "btnSave_Click"

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim objSSLM As New SSLM
        Dim rtValue As Integer
        Try

            With objSSLM
                .UrlId = ViewState("URLID")
                .AccountId = ddlAccount1.SelectedValue
                .RegistrarId = ddlRegistrar1.SelectedValue
                .CategoryId = ddlCategory1.SelectedValue
                .URL = txtURL.Text
                .ExpirationDate = txtExpirydate.Text
                .NameServer1 = txtnameServer1.Text
                .NameServer2 = txtNameServer2.Text
                .ReferralUrl = txtreferralURL.Text
                .WhoisServer = txtWhoisServer.Text
                rtValue = .AddUrl()
                ClearAllFields()
            End With
            If rtValue = 0 Then
                l_Errortext = "New URL has added successfully."
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowInfo
                CtrlAlertdiv.HeaderText = "Sucessfuly Added"
                ClientScript.RegisterStartupScript(Me.GetType, "PageStartupScript", "ShowHide('true');", True)
            ElseIf rtValue = 1 Then
                l_Errortext = "URL Information has been updated successfully."
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowInfo
                CtrlAlertdiv.HeaderText = "Updated Successfully"
                ClientScript.RegisterStartupScript(Me.GetType, "PageStartupScript", "ShowHide('true');", True)
            ElseIf rtValue = 2 Then
                l_Errortext = "URL has already added. Please choose different."
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
                CtrlAlertdiv.HeaderText = "Updated Successfully"
            End If

        Catch ex As Exception

            CtrlAlertdiv.HeaderText = "Error Occured"
            CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
            l_Errortext = "Unable to add new URL. Following error occured" & vbCrLf & ex.ToString
        End Try
        CtrlAlertdiv.DetialInfo = l_Errortext
        CtrlAlertdiv.Visible = True
        CtrlAlertdiv.Visibility = True

        grdURLs.DataSourceID = "srcSSLs"
        grdURLs.DataBind()
    End Sub

#End Region

#Region "btnUpdateAll_Click"

    Protected Sub btnUpdateAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateAll.Click

        Dim objURLArray() As String
        Dim objURLArraylist As New ArrayList
        Dim objStructURL As System.Collections.DictionaryEntry
        Dim rtValue As Boolean

        objURLArray = Split(txtURLs.Text, Chr(13))

        For i As Integer = 0 To objURLArray.Length - 1

            objStructURL = New System.Collections.DictionaryEntry

            rtValue = UpdateURLInfo(objURLArray(i).Trim, False)

            If rtValue = True Then
                objStructURL.Value = "../Images/ico_tick.gif"
            Else
                objStructURL.Value = "../Images/ico_cross.gif"
            End If

            objStructURL.Key = objURLArray(i)
            objURLArraylist.Add(objStructURL)

        Next

        Session("UpdatedURLInfo") = objURLArraylist
        divUpdatedStatus.Visible = True
        lblUpdatedDivStatus.Text = "Update Status"

    End Sub

#End Region

#Region "btnUpdateAllURLs_Click"

    Protected Sub btnUpdateAllURLs_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpdateAllURLs.Click


        Dim objURLArray As New ArrayList
        Dim objURLArraylist As New ArrayList
        Dim objStructURL As System.Collections.DictionaryEntry
        Dim rtValue As Boolean

        Dim grdRows As GridViewRowCollection
        grdRows = grdURLs.Rows

        Dim i As Integer = -1
        For Each objRow As GridViewRow In grdRows
            Dim chkbox As CheckBox

            chkbox = CType(objRow.FindControl("chkUpdateURL"), CheckBox)

            If chkbox.Checked = True Then
                objURLArray.Add(CType(objRow.FindControl("lblUrl"), Label).Text)
            End If

        Next


        For i = 0 To objURLArray.Count - 1

            objStructURL = New System.Collections.DictionaryEntry

            rtValue = UpdateURLInfo(objURLArray(i).Trim, False)

            If rtValue = True Then
                objStructURL.Value = "../Images/ico_tick.gif"
            Else
                objStructURL.Value = "../Images/ico_cross.gif"
            End If

            objStructURL.Key = objURLArray(i)
            objURLArraylist.Add(objStructURL)

        Next

        Session("UpdatedURLInfo") = Nothing
        Session("UpdatedURLInfo") = objURLArraylist
        divUpdatedStatus.Visible = True

        grdURLs.DataSourceID = "srcSSLs"
        lblUpdatedDivStatus.Text = "Update Status"
        grdURLs.DataBind()
        ClearAllFields()

    End Sub

#End Region

#Region "imgUpdateAll_Click"

    'Protected Sub imgUpdateAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles imgUpdateAll.Click
    '    divNewURL.Visible = False
    '    divUpdateURLs.Visible = True
    '    divUpdatedStatus.Visible = False
    'End Sub
#End Region

#Region "imgNewURL_Click"

    Protected Sub imgNewURL_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles imgNewURL.Click
        divNewURL.Visible = True
        divUpdateURLs.Visible = False
        divUpdatedStatus.Visible = False
        lblHeadertext.Text = "Add New SSL"
        btnSave.Text = "Add New"
        ViewState("URLID") = Nothing
        'ClientScript.RegisterStartupScript(Me.GetType, "PageStartupScript", "ShowHide(0);", True)
    End Sub

#End Region

#Region "btnDeleteSelected_Click"

    Protected Sub btnDeleteSelected_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnDeleteSelected.Click
        Dim objURLArray As New ArrayList
        Dim objURLArraylist As New ArrayList
        Dim objStructURL As System.Collections.DictionaryEntry
        Dim rtValue As Boolean

        Dim grdRows As GridViewRowCollection
        grdRows = grdURLs.Rows

        Dim i As Integer = -1
        For Each objRow As GridViewRow In grdRows
            Dim chkbox As CheckBox

            chkbox = CType(objRow.FindControl("chkUpdateURL"), CheckBox)

            If chkbox.Checked = True Then
                objURLArray.Add(CType(objRow.FindControl("lblUrl"), Label).Text)
            End If

        Next


        For i = 0 To objURLArray.Count - 1

            objStructURL = New System.Collections.DictionaryEntry

            rtValue = SSLM.Delete(objURLArray(i).Trim)

            If rtValue = True Then
                objStructURL.Value = "../Images/ico_tick.gif"
            Else
                objStructURL.Value = "../Images/ico_cross.gif"
            End If

            objStructURL.Key = objURLArray(i)
            objURLArraylist.Add(objStructURL)

        Next

        Session("UpdatedURLInfo") = Nothing
        Session("UpdatedURLInfo") = objURLArraylist

        grdURLs.DataSourceID = "srcSSLs"
        grdURLs.DataBind()
        lblUpdatedDivStatus.Text = "Delete Status"
        divUpdatedStatus.Visible = True

    End Sub

#End Region

#Region "CtrlAlertDiv_MyClick"

    Protected Sub CtrlAlertDiv_MyClick() Handles CtrlAlertdiv.MyClick
        divNewURL.Visible = True
        Dim objSSLM As New SSLM
        l_URLID = ViewState("URLID")
        objSSLM = SSLM.GetUrlByID(l_URLID)
        txtURL.Text = objSSLM.URL
        ddlAccount1.SelectedValue = objSSLM.AccountId
        ddlRegistrar1.SelectedValue = objSSLM.RegistrarId
        ddlCategory1.SelectedValue = objSSLM.CategoryId
        txtExpirydate.Text = objSSLM.ExpirationDate
        txtnameServer1.Text = objSSLM.NameServer1
        txtNameServer2.Text = objSSLM.NameServer2
        txtWhoisServer.Text = objSSLM.WhoisServer
        txtreferralURL.Text = objSSLM.ReferralUrl


    End Sub

#End Region

#End Region

#Region "Private functions"

    Private Function getInformationBytext(ByVal mainString As String, ByVal Stringtofind As String, Optional ByVal SecondOptiontofind As String = "") As String
        Dim FirstPoint As Integer
        Dim SecondPoint As Integer
        Dim rtString As String = ""


        FirstPoint = InStr(mainString, Stringtofind, CompareMethod.Text)

        If FirstPoint <= 0 Then
            FirstPoint = InStr(mainString, SecondOptiontofind, CompareMethod.Text)
            Stringtofind = SecondOptiontofind
        End If

        If Not mainString = "" Then

            FirstPoint = InStr(1, mainString, Stringtofind, vbTextCompare)

            If Not FirstPoint = 0 Then
                SecondPoint = InStr(FirstPoint + 1 + Len(Stringtofind), mainString, "<br>", vbTextCompare)
            Else
                Return ""
            End If

            rtString = Mid(mainString, FirstPoint + Len(Stringtofind), SecondPoint - FirstPoint - Len(Stringtofind))

            rtString = rtString.Replace("<br>", "")

            rtString = rtString.Replace(":", " ")

        End If

        Return rtString.Trim

    End Function

    Private Function GetTextStreamFromURL(ByVal URLName As String) As String
        Dim objHttpWebRequest As System.Net.HttpWebRequest
        Dim objHttpWebResponse As System.Net.HttpWebResponse
        Dim strHtmlText As String = ""
        Try
            objHttpWebRequest = System.Net.HttpWebRequest.Create(URLName)
            objHttpWebResponse = objHttpWebRequest.GetResponse()
            If objHttpWebResponse.StatusCode = Net.HttpStatusCode.OK Then
                Dim objStreamReader As New System.IO.StreamReader(objHttpWebResponse.GetResponseStream(), System.Text.Encoding.UTF8)
                strHtmlText = objStreamReader.ReadToEnd()
                objStreamReader.Close()
            Else
                ' Show Error fetching data
            End If
            objHttpWebResponse.Close()
        Catch ex As Exception
            l_Errortext = "GetTextStreamFromURL()--> Error occured while getting information about URL"
        End Try

        Return strHtmlText

    End Function

    Private Function ConvertToDate(ByVal argDateString As String) As Date

        Dim d As Date
        Dim strDate As String = argDateString.Replace(".", "")

        Dim strFormat(0 To 5) As String
        strFormat(0) = "^\w{3} (?<Month>\w{3}) (?<Day>\d{2}) \d{2} \d{2} \d{2} GMT (?<Year>\d{4})$"
        strFormat(1) = "^(?<Day>\d{2})-(?<Month>\w{3})-(?<Year>\d{4}) \d{2} \d{2} \d{2} UTC$"
        strFormat(2) = "^(?<Day>\d{2})-(?<Month>\w{3})-(?<Year>\d{2})$"
        strFormat(3) = "^(?<Day>\d{2})-(?<Month>\w{3})-(?<Year>\d{4})$"
        strFormat(4) = "^\w{3} (?<Month>\w{3}) (?<Day>\d{2}) \d{2} \d{2} \d{2} GMT (?<Year>\d{4})$"
        strFormat(5) = "^\w{3} (?<Month>\w{3}) (?<Day>\d{2}) \d{2} \d{2} \d{2} GMT[+ -]\d{2} \d{2} (?<Year>\d{4})$"

        Dim objMatch As System.Text.RegularExpressions.Match

        For i As Integer = 0 To strFormat.Length - 1
            objMatch = System.Text.RegularExpressions.Regex.Match(strDate, strFormat(i))

            If objMatch.Success = False Then
                ' Not in this format
            Else

                d = Date.Parse(objMatch.Result("${Month}/${Day}/${Year}")) 'datestr = objMatch.Result("${Month}") & "-" & objMatch.Result("${Day}") & "-" & objMatch.Result("${Year}")  
                Exit For
            End If
        Next

        Return d

    End Function

    Private Function isDataFound(ByVal MainString As String) As Boolean



        If MainString = "" Then
            l_Errortext = "Sorry no information found for URL " & URLName & " Make sure your are connected to the internet."
            CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
            l_Errorcode = Portal.BLL.Enumeration.ErrorType.NoInfoFound

            Return False
        ElseIf Not InStr(MainString, "Please try again later", CompareMethod.Text) <= 0 Then
            l_Errortext = "Whois server is not responding at the moment. Please try again later. information was not updated for " & URLName
            CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
            l_Errorcode = Portal.BLL.Enumeration.ErrorType.NotResponding

            Return False
        ElseIf Not InStr(MainString, "currently unregistered", CompareMethod.Text) <= 0 Then
            l_Errortext = "Requested URL is not registred yet. Make sure " & URLName & " is registred."
            CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
            l_Errorcode = Portal.BLL.Enumeration.ErrorType.NotRegistred

            Return False
        ElseIf Not InStr(MainString, "We are only able to display whois information for", CompareMethod.Text) <= 0 Then
            l_Errortext = "Server is unable to get whois information for " & URLName
            CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
            l_Errorcode = Portal.BLL.Enumeration.ErrorType.UnableToGetInfo

            Return False
        ElseIf Not InStr(MainString, "Host not found", CompareMethod.Text) <= 0 Then
            l_Errortext = "URL link might be down. Unable to update information for " & URLName
            CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
            SSLM.UpdateStatus(Portal.BLL.Enumeration.Site_Status.Down, URLName)
            l_Errorcode = Portal.BLL.Enumeration.ErrorType.UrlNotFound

            Return False
        ElseIf InStr(MainString, "Expires on", CompareMethod.Text) <= 0 Then

            If InStr(MainString, "Expiration Date", CompareMethod.Text) <= 0 Then
                l_Errortext = "Unable to find information in required format, Unable to update information for " & URLName
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
                l_Errorcode = Portal.BLL.Enumeration.ErrorType.NoIfoInRequiredFormat

                Return False
            Else
                Return True
            End If

        Else
            Return True
        End If

    End Function

    Private Function UpdateURLInfo(ByVal argURLName As String, Optional ByVal argIsShowManulaUpdate As Boolean = True) As Boolean


        Dim RequestURL, URLText As String

        URLName = argURLName.Replace(Chr(10), "")

        RequestURL = CONSTANTS.GODADDY & URLName
        URLText = GetTextStreamFromURL(RequestURL)


        If isDataFound(URLText) = True Then

            Dim objSSLM As New SSLM
            Try
                With objSSLM
                    .ExpirationDate = ConvertToDate(getInformationBytext(URLText, "Expires on", "Expiration Date"))
                    .NameServer1 = getInformationBytext(URLText, "Domain servers in listed order:<br>", "Name Server:")
                    .URL = URLName

                    .UpdateInformation()
                End With
            Catch ex As Exception
                l_Errortext = "Error occured while Updating the information for URL " & URLName
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowError
                'Allow user to manulay update the site information
                Call ManualUpdate()
            End Try

        Else 'Error has occured

            If l_Errorcode = Portal.BLL.Enumeration.ErrorType.NoIfoInRequiredFormat OrElse l_Errorcode = Portal.BLL.Enumeration.ErrorType.NotResponding OrElse l_Errorcode = Portal.BLL.Enumeration.ErrorType.UnableToGetInfo Then

                If argIsShowManulaUpdate = True Then
                    'Add attributes for manual updation
                    Call ManualUpdate()
                End If

            End If
        End If

        'Display information only when processing for a single URL.
        If argIsShowManulaUpdate = True Then
            'If no error occured then display successful message.
            If CType(l_Errortext, String) = "" Then
                l_Errortext = "Information has been updated successfully for " & URLName
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowInfo
            End If

            'Show div for process status in both cases
            CtrlAlertdiv.HeaderText = "Status"
            CtrlAlertdiv.DetialInfo = l_Errortext
            CtrlAlertdiv.Visible = True
            CtrlAlertdiv.Visibility = True

        Else
            If l_Errortext = "" Then
                Return True
            Else
                l_Errortext = ""
            End If
        End If

        grdURLs.DataSourceID = "srcSSLs"
        grdURLs.DataBind()

    End Function

    Private Function ManualUpdate() As Boolean
        Dim btnManualUpdate As Button


        btnManualUpdate = CType(CtrlAlertdiv.FindControl("btnMy"), Button)
        btnManualUpdate.Text = "Update Manualy"
        btnManualUpdate.Visible = True
        btnManualUpdate.CssClass = "button_large"
        btnSave.Text = "Update"
        lblHeadertext.Text = "Update Manualy"


    End Function

    Private Sub CheckStatus(ByVal argURL As String)
        Dim objURL As New SSLM
        Dim intID As Integer
        Dim PageRequest As Portal.BLL.Enumeration.SSLPageRequest
        If Not IsNothing(Request.QueryString("ID")) AndAlso Request.QueryString("ID") <> "" AndAlso IsNumeric(Request.QueryString("ID")) Then
            intID = Request.QueryString("ID")
        End If

        PageRequest = objURL.CheckURL(argURL)

        If Not IsNothing(PageRequest) Then
            If PageRequest.Status = False Then
                SSLM.UpdateStatus(Portal.BLL.Enumeration.Site_Status.Down, argURL)
                l_Errortext = "Site link has down."
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowWrong
            Else
                l_Errortext = "Site link is working properly."
                CtrlAlertdiv.ErrorType = Portal.BLL.Enumeration.AlertType.ShowRight
                SSLM.UpdateStatus(Portal.BLL.Enumeration.Site_Status.UP, argURL)
            End If

            'Show div for process status in both cases
            CtrlAlertdiv.HeaderText = "Status"
            CtrlAlertdiv.DetialInfo = l_Errortext
            CtrlAlertdiv.Visible = True
            CtrlAlertdiv.Visibility = True

            grdURLs.DataSourceID = "srcSSLs"
            grdURLs.DataBind()

        End If
    End Sub

#End Region

#Region "Private subs"

    Private Sub SetLoadingboxSettings()
        CtrldivLoading.HeaderText = "Loading please wait..."
        CtrldivLoading.DetialInfo = "It may take several minutes to complete the process. Please wait."
        CtrldivLoading.ErrorType = Portal.BLL.Enumeration.AlertType.ShowLoading
        CtrldivLoading.ShowCloseButton = False
        divUpdateURLs.Visible = False
        divNewURL.Visible = False
        divUpdatedStatus.Visible = False

        'Set URLString for reporting buttons
        Dim URLStr As String
        URLStr = "ViewReport/default.aspx?ReportType=" & Portal.BLL.Enumeration.ReporType.Url_List & "&AccountId=" & ddlAccount.SelectedValue & "&CategoryId=" & ddlCategory.SelectedValue & "&RegistrarId=" & ddlRegistrar.SelectedValue & "&SearchBy=" & txtSearch.Text & "&sort=" & "&Exp=" & ddlExpiry.SelectedValue
        URLStr = Replace(URLStr, "'", "\'")

        'btnPrint.Attributes.Add("onclick", "openURL(' " & URLStr & "'); return false;")
        'imgExportExcel.Attributes.Add("onclick", "exportURLlist(' " & URLStr & "&export=true" & "&Format=" & Portal.BLL.Enumeration.ExportOptions.MsExcel & "'); return false;")
        'imgExportTabbed.Attributes.Add("onclick", "exportURLlist(' " & URLStr & "&export=true" & "&Format=" & Portal.BLL.Enumeration.ExportOptions.Tabbed & "'); return false;")
        'imgExportPDF.Attributes.Add("onclick", "exportURLlist(' " & URLStr & "&export=true" & "&Format=" & Portal.BLL.Enumeration.ExportOptions.PDF & "'); return false;")

        btnSave.Attributes.Add("onclick", "Page_ClientValidate(); checkvalidation(false);")
        btnUpdateAll.Attributes.Add("onclick", "Page_ClientValidate(); checkvalidation(true);")

    End Sub

    Private Sub ClearAllFields()
        ddlAccount1.SelectedValue = "0"
        ddlRegistrar1.SelectedValue = "0"
        ddlCategory1.SelectedValue = "0"
        txtURL.Text = ""
        txtExpirydate.Text = ""
        txtnameServer1.Text = ""
        txtNameServer2.Text = ""
        txtreferralURL.Text = ""
        txtWhoisServer.Text = ""
        txtURLs.Text = ""
    End Sub


#End Region

    Protected Sub lnkResetFilters_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkResetfilters.Click

    End Sub

    Protected Sub srcSSLs_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles srcSSLs.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False Or _
        ddlAccount.SelectedValue <> "0" Or _
        ddlRegistrar.SelectedValue <> "0" Or _
        ddlExpiry.SelectedValue <> "0" Or _
        ddlCategory.SelectedValue <> "0" Then
            lblfilter.Text = "Filtered"
        Else
            lblfilter.Text = "All"
        End If
        Dim Count As Integer = 0
        If Integer.TryParse(e.ReturnValue.ToString(), Count) = True Then
            lblActivityCount.Text = Count.ToString()
        End If
    End Sub

End Class