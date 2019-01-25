Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class FranMail_Inbox_GApps
    Inherits System.Web.UI.Page

    Private AdminID As Integer
    Public dtbl As DataTable
    Private UnSeenEmailCount As Integer = 0
    Dim pageSize As Integer = 0
    Dim totalRecords As Integer
    Dim pageCount As Integer
    Private Mailbox As String = ""
    Dim SequenceNo As Integer = 1
    Dim flagForDeleteion As Boolean = False

    Private Property dataSource() As DataTable
        Get
            Return CType(ViewState("dataSource"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            ViewState("dataSource") = value
        End Set
    End Property
    Private Property folderName() As String
        Get
            Return CStr(ViewState("folderName"))
        End Get
        Set(ByVal value As String)
            ViewState("folderName") = value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Response.Write("count: " & GetMessageCount())
        If IsPostBack = False Then
            If String.IsNullOrEmpty(Request.QueryString("Mailbox")) = False Then
                Mailbox = Request.QueryString("Mailbox")
            Else
                Mailbox = "INBOX"
                hdnMailBox.Value = "INBOX"
            End If
            If Mailbox = "SentItems" Then
                InboxType.SelectedValue = "Sent"
                hdnMailBox.Value = "INBOX.Sent Items"
            End If

            'If Mailbox = "DeletedItems" Then
            '    hdnMailBox.Value = "INBOX.Trash"
            '    Me.lblPageTitle.Text = "Deleted Items"
            'ElseIf Mailbox = "Spam" Then
            '    hdnMailBox.Value = "INBOX.Spam"
            '    Me.lblPageTitle.Text = "Spam"
            'ElseIf Mailbox = "SentItems" Then
            '    hdnMailBox.Value = "INBOX.Sent"
            '    Me.lblPageTitle.Text = "Sent Items"
            'ElseIf Mailbox = "INBOX" Then
            '    hdnMailBox.Value = "INBOX"
            '    Me.lblPageTitle.Text = "Inbox"
            '    InboxType.SelectedValue = "Inbox"
            'ElseIf Mailbox = "Spam" Then
            '    hdnMailBox.Value = "INBOX.spam"
            '    Me.lblPageTitle.Text = "Spam"
            'ElseIf Mailbox = "Drafts" Then
            '    hdnMailBox.Value = "INBOX.Drafts"
            '    Me.lblPageTitle.Text = "Drafts"
            'End If

            Me.hdnMailHost.Value = "imap.gmail.com"
            Me.hdnPopUsername.Value = "kshahzad@skfacademy.org"
            Me.hdnPopPassword.Value = "test123"

            Me.lblEmailAddress.Text = Me.hdnPopUsername.Value
            folderName = "inbox"
            dataSource = New DataTable()
            Me.gvInbox.PageSize = 30
            pageSize = Me.gvInbox.PageSize
            ViewState("pageSize") = pageSize
            GetMessageHeaders()
            ViewState("SortDirectionFrom") = "ASC"
            ViewState("SortDirectionSubject") = "ASC"
            ViewState("SortDirectionDate") = "ASC"
        End If
    End Sub


    Public Sub GetMessageHeaders()
        If String.IsNullOrEmpty(Request.QueryString("Mailbox")) = False Then
            Mailbox = Request.QueryString("Mailbox")
        Else
            Mailbox = "INBOX"
        End If
        Dim imap As New Chilkat.Imap()
        Dim messageSetCount As Chilkat.MessageSet = Nothing
        Dim messageSetUnSeenCount As Chilkat.MessageSet = Nothing
        Dim bundleToShow As Chilkat.EmailBundle
        Dim fetchUids As Boolean
        Dim strMailServer As String = String.Empty
        fetchUids = True
        dtbl = New DataTable("Inbox")
        Dim success As Boolean
        '  Anything unlocks the component and begins a fully-functional 30-day trial.

        success = imap.UnlockComponent(ConfigurationManager.AppSettings("ChilkatEmailComponentKey"))
        If (success <> True) Then
            Exit Sub
        End If
        '  Connect to an IMAP server.
        strMailServer = Me.hdnMailHost.Value
        'If Trim(LCase(strMailServer)) = "secure.emailsrvr.com" Then
        imap.Port = 993
        imap.Ssl = True
        'End If

        success = imap.Connect(Me.hdnMailHost.Value)
        If (success <> True) Then
            Exit Sub
        End If
        '  Login
        success = imap.Login(Me.hdnPopUsername.Value, Me.hdnPopPassword.Value)
        If (success <> True) Then
            Exit Sub
        End If
        '  Select an IMAP mailbox
        success = imap.SelectMailbox(hdnMailBox.Value)
        If (success <> True) Then
            Exit Sub
        End If
        '  Get the message IDs of all the emails in the mailbox
        If IsPostBack = False Or flagForDeleteion Then
            messageSetCount = imap.GetAllUids()
            ViewState("totalRecords") = messageSetCount.Count
        End If
        'Gives us the total no of pages.
        pageCount = CInt(ViewState("totalRecords")) / Me.gvInbox.PageSize
        Me.gvInbox.VirtualItemCount = CInt(ViewState("totalRecords"))
        'Me.gvInbox.VirtualItemCount = 5
        If IsPostBack = False Then
            If String.IsNullOrEmpty(ViewState("PreviousSequenceNo")) = True Then
                SequenceNo = CInt(ViewState("totalRecords")) - CInt(ViewState("pageSize")) + 1
                If SequenceNo < 1 Then
                    SequenceNo = 1
                End If
                ViewState("PreviousSequenceNo") = SequenceNo
            Else
                SequenceNo = CInt(ViewState("PreviousSequenceNo")) - CInt(ViewState("pageSize"))
            End If
        End If
        If Not CInt(ViewState("totalRecords")) = 0 Then
            'bundleToShow = imap.FetchSequenceHeaders(SequenceNo, CInt(ViewState("pageSize")))
            bundleToShow = imap.FetchHeaders(messageSetCount)
            If Not bundleToShow Is Nothing Then
                bundleToShow.SortByDate(False)
                Dim dcolColumn As DataColumn
                Dim drowItem As DataRow
                ' Create DataTable
                ' Create Columns
                dcolColumn = New DataColumn("ID", GetType(String))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("UIDL", GetType(String))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("Subject", GetType(String))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("Date", GetType(Date))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("RecivedDateWithoutTime", GetType(Date))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("From", GetType(String))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("AttachmentAddress", GetType(String))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("FromAddress", GetType(String))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("NumAttachments", GetType(Integer))
                dtbl.Columns.Add(dcolColumn)
                dcolColumn = New DataColumn("EmailSeen", GetType(Integer))
                dtbl.Columns.Add(dcolColumn)
                Dim i As Long
                Dim j As Long
                Dim blnAddInList As Boolean = False

                Dim dtblBadLinks As DataTable
                Dim arrMatches() As DataRow
                Dim strSelect As String = String.Empty

                ' If exempted urls has been retrieved from the db or not.
                'If Not Context.Cache("Links") Is Nothing Then
                'dtblBadLinks = CType(Context.Cache("Emails"), DataTable)
                'Else
                dtblBadLinks = GetEmailContacts()
                'End If

                For i = 0 To bundleToShow.MessageCount - 1
                    Dim email As Chilkat.Email
                    blnAddInList = False
                    strSelect = String.Empty
                    email = bundleToShow.GetEmail(i)
                    ' Add Rows

                    strSelect = email.FromAddress.ToLower     ' Scan From Address
                    strSelect = "Email='" & strSelect & "'"
                    arrMatches = dtblBadLinks.Select(strSelect, "Email")
                    If arrMatches.Length > 0 Then
                        blnAddInList = True
                    End If


                    For j = 0 To email.NumTo - 1            ' Scan To addresses
                        strSelect = email.GetToAddr(j).ToString.ToLower
                        strSelect = "Email='" & strSelect & "'"
                        arrMatches = dtblBadLinks.Select(strSelect, "Email")
                        If arrMatches.Length > 0 Then
                            blnAddInList = True
                        End If
                    Next

                    For j = 0 To email.NumCC - 1            ' Scan CC addresses
                        strSelect = email.GetCcAddr(j).ToString.ToLower
                        strSelect = "Email='" & strSelect & "'"
                        arrMatches = dtblBadLinks.Select(strSelect, "Email")
                        If arrMatches.Length > 0 Then
                            blnAddInList = True
                        End If
                    Next

                    For j = 0 To email.NumBcc - 1            ' Scan Bcc addresses
                        strSelect = email.GetBccAddr(j).ToString.ToLower
                        strSelect = "Email='" & strSelect & "'"
                        arrMatches = dtblBadLinks.Select(strSelect, "Email")
                        If arrMatches.Length > 0 Then
                            blnAddInList = True
                        End If
                    Next

                    If blnAddInList = True Then
                        drowItem = dtbl.NewRow()
                        drowItem("ID") = email.GetHeaderField("ckx-imap-uid")
                        drowItem("UIDL") = email.GetHeaderField("ckx-imap-uid")
                        If email.Subject = String.Empty Then
                            drowItem("Subject") = "no subject"
                        Else
                            drowItem("Subject") = email.Subject
                        End If
                        drowItem("Date") = email.EmailDate
                        drowItem("FromAddress") = email.FromAddress
                        drowItem("NumAttachments") = imap.GetMailNumAttach(email)
                        drowItem("EmailSeen") = imap.GetMailFlag(email, "Seen")
                        drowItem("RecivedDateWithoutTime") = FormatDateTime(email.EmailDate, DateFormat.ShortDate)
                        If email.FromName = String.Empty Then
                            drowItem("From") = email.From
                        Else
                            drowItem("From") = email.FromName
                        End If
                        If email.GetHeaderField("ckx-imap-numAttach") > 0 Then
                            drowItem("AttachmentAddress") = email.GetHeaderField("ckx-imap-numAttach")
                        Else
                            drowItem("AttachmentAddress") = String.Empty
                        End If
                        dtbl.Rows.Add(drowItem)
                    End If
                Next
            End If
        Else

        End If

        success = imap.SelectMailbox("INBOX")
        If success Then
            messageSetUnSeenCount = imap.Search("UNSEEN", fetchUids)
            hdnUnSeenEmailCount.Value = messageSetUnSeenCount.Count
        End If
        'If Mailbox = "Inbox" Then
        '    Me.lblMailCount.Text = hdnUnSeenEmailCount.Value & "&nbsp;Unread&nbsp;" & ViewState("totalRecords") & "&nbsp;Total Messages"
        'Else
        '    Me.lblMailCount.Text = ViewState("totalRecords") & "&nbsp;Total Messages"
        'End If
        '  Disconnect from the IMAP server.
        imap.Disconnect()
        dataSource = dtbl
        Me.gvInbox.DataSource = dataSource
        Me.gvInbox.DataBind()
    End Sub

    Function GetEmailContacts() As DataTable
        Dim db As DBAccess = New DBAccess()
        Dim dtblBadLinks As DataTable = New DataTable("Emails")
        dtblBadLinks = db.ExecuteDataTable("FranMail_Emails_GetAll")
        Context.Cache("Emails") = dtblBadLinks
        Return dtblBadLinks
    End Function


    Public Function EmailSeen(ByVal EmailSeenStatus As Integer) As String
        Dim image As String = ""
        If EmailSeenStatus = 1 Then
            image = "Email.gif"
        ElseIf EmailSeenStatus = 0 Then
            image = "ico_newmessage.gif"
        End If
        Return image
    End Function
    Public Function EmailAttachment(ByVal NumEmailAttachment As Integer) As String
        Dim image As String = ""
        If NumEmailAttachment > 0 Then
            image = "ico_attachment.gif"
        End If
        Return image
    End Function
    Public Sub DeleteEmail(ByVal EmailID As Integer)
        Dim imap As New Chilkat.Imap()
        Dim success As Boolean
        Dim fetchUids As Boolean
        Dim strMailServer As String = String.Empty

        fetchUids = True
        success = imap.UnlockComponent(ConfigurationManager.AppSettings("ChilkatEmailComponentKey"))
        If (success <> True) Then
            Exit Sub
        End If
        strMailServer = Me.hdnMailHost.Value
        'If Trim(LCase(strMailServer)) = "secure.emailsrvr.com" Then
        imap.Port = 993
        imap.Ssl = True
        'End If

        success = imap.Connect(Me.hdnMailHost.Value)
        If (success <> True) Then
            Exit Sub
        End If
        success = imap.Login(Me.hdnPopUsername.Value, Me.hdnPopPassword.Value)
        If (success <> True) Then
            Exit Sub
        End If
        success = imap.SelectMailbox(hdnMailBox.Value)
        If (success <> True) Then
            Exit Sub
        End If
        Dim DeleteEmail As Chilkat.Email = imap.FetchSingle(EmailID, True)
        If Not hdnMailBox.Value = "Inbox_GApps.Deleted Items" Then
            If Not DeleteEmail Is Nothing Then
                success = imap.Copy(EmailID, True, "Inbox.Deleted Items")
                If (success <> True) Then
                    Exit Sub
                End If
                success = imap.SetMailFlag(DeleteEmail, "Deleted", 1)
                If (success <> True) Then
                    Exit Sub
                End If
                success = imap.ExpungeAndClose()
                If (success <> True) Then
                    Exit Sub
                End If
                ViewState("pageSize") = CInt(ViewState("pageSize")) - 1
            End If
        Else
            success = imap.SetMailFlag(DeleteEmail, "Deleted", 1)
            If (success <> True) Then
                Exit Sub
            End If
            success = imap.ExpungeAndClose()
            If (success <> True) Then
                Exit Sub
            End If
            ViewState("pageSize") = CInt(ViewState("pageSize")) - 1
        End If
        '  Disconnect from the IMAP server.
        imap.Disconnect()
    End Sub

    Protected Sub gvInbox_ItemCreated(ByVal sender As Object, ByVal e As Telerik.WebControls.GridItemEventArgs) Handles gvInbox.ItemCreated
        If e.Item.ItemType = Telerik.WebControls.GridItemType.AlternatingItem Or e.Item.ItemType = Telerik.WebControls.GridItemType.Item Then
            e.Item.Attributes.Add("onmouseover", "this.className='HighlightedHomeRowRad';")
            e.Item.Attributes.Add("onmouseout", "this.className='SimpleHomeRowRad';")
            e.Item.Attributes.Add("style", "border-bottom:solid 1px #C9EAFC;")
        End If
    End Sub
    Protected Sub gvInbox_ItemDataBound(ByVal sender As Object, ByVal e As Telerik.WebControls.GridItemEventArgs) Handles gvInbox.ItemDataBound
        If e.Item.ItemType = Telerik.WebControls.GridItemType.AlternatingItem Or e.Item.ItemType = Telerik.WebControls.GridItemType.Item Then

            If String.IsNullOrEmpty(Request.QueryString("Mailbox")) = False Then
                Mailbox = Request.QueryString("Mailbox")
            Else
                Mailbox = "Inbox"
            End If
            e.Item.Cells(2).Attributes.Add("onclick", "OpenMailDetailDiv(" & CType(e.Item.FindControl("lblID"), Label).Text & "," & e.Item.DataItem("EmailSeen") & ",'" & Mailbox & "');")
            e.Item.Cells(4).Attributes.Add("onclick", "OpenMailDetailDiv(" & CType(e.Item.FindControl("lblID"), Label).Text & "," & e.Item.DataItem("EmailSeen") & ",'" & Mailbox & "');")
            e.Item.Cells(5).Attributes.Add("onclick", "OpenMailDetailDiv(" & CType(e.Item.FindControl("lblID"), Label).Text & "," & e.Item.DataItem("EmailSeen") & ",'" & Mailbox & "');")
            e.Item.Cells(6).Attributes.Add("onclick", "OpenMailDetailDiv(" & CType(e.Item.FindControl("lblID"), Label).Text & "," & e.Item.DataItem("EmailSeen") & ",'" & Mailbox & "');")
            e.Item.Cells(7).Attributes.Add("onclick", "OpenMailDetailDiv(" & CType(e.Item.FindControl("lblID"), Label).Text & "," & e.Item.DataItem("EmailSeen") & ",'" & Mailbox & "');")
            e.Item.Cells(8).Attributes.Add("onclick", "OpenMailDetailDiv(" & CType(e.Item.FindControl("lblID"), Label).Text & "," & e.Item.DataItem("EmailSeen") & ",'" & Mailbox & "');")
            Dim lblEmailSeen As Label = CType(e.Item.FindControl("lblEmailSeen"), Label)
            Dim lblFrom As Label = CType(e.Item.FindControl("lblFrom"), Label)
            Dim lblSubject As Label = CType(e.Item.FindControl("lblSubject"), Label)
            Dim lblDate As Label = CType(e.Item.FindControl("lblDate"), Label)
            If Not lblEmailSeen Is Nothing Then
                If lblEmailSeen.Text = 0 Then
                    lblFrom.Font.Bold = True
                    lblSubject.Font.Bold = True
                    lblDate.Font.Bold = True
                End If
            End If
        End If
    End Sub
    Protected Sub gvInbox_PageIndexChanged(ByVal source As Object, ByVal e As Telerik.WebControls.GridPageChangedEventArgs) Handles gvInbox.PageIndexChanged
        '  If (e.NewPageIndex = 0) Then
        '  Else
        ViewState("pageSize") = Me.gvInbox.PageSize
        'SequenceNo = e.NewPageIndex * pageSize + 1
        Dim difference As Integer = e.NewPageIndex - CInt(ViewState("PreviousPageIndex"))
        If difference = 1 Then 'move to next page 
            SequenceNo = CInt(ViewState("PreviousSequenceNo")) - CInt(ViewState("pageSize"))
            If SequenceNo < 1 Then
                ViewState("pageSize") = CInt(ViewState("pageSize")) + SequenceNo + (-1)
                ViewState("PreviousPageSize") = ViewState("pageSize")
                SequenceNo = 1
            End If
            ViewState("PreviousPageSize") = ViewState("pageSize")
            ViewState("PreviousSequenceNo") = SequenceNo
            ViewState("PreviousPageIndex") = e.NewPageIndex
        End If
        If difference = -1 Then 'move to previous page
            If Not CInt(ViewState("PreviousPageSize")) = CInt(ViewState("pageSize")) Then
                SequenceNo = ViewState("PreviousPageSize") + 1
            Else
                SequenceNo = CInt(ViewState("PreviousSequenceNo")) + CInt(ViewState("pageSize"))
            End If
            ViewState("PreviousPageSize") = ViewState("pageSize")
            ViewState("PreviousSequenceNo") = SequenceNo
            ViewState("PreviousPageIndex") = e.NewPageIndex
        End If
        If difference > 1 Then 'move to next pages the 'difference' times
            SequenceNo = ViewState("PreviousSequenceNo") - (CInt(ViewState("pageSize")) * difference)
            If SequenceNo < 1 Then
                ViewState("pageSize") = CInt(ViewState("pageSize")) + SequenceNo - 1
                ViewState("PreviousPageSize") = ViewState("pageSize")
                SequenceNo = 1
            End If
            ViewState("PreviousPageSize") = ViewState("pageSize")
            ViewState("PreviousSequenceNo") = SequenceNo
            ViewState("PreviousPageIndex") = e.NewPageIndex
        End If
        If difference < -1 Then ' move to previous pages the 'differnce' times
            If Not CInt(ViewState("PreviousPageSize")) = CInt(ViewState("pageSize")) Then
                SequenceNo = (CInt(ViewState("PreviousPageSize")) + (CInt(ViewState("pageSize")) * (Math.Abs(difference) - 1)) + 1)
            Else
                SequenceNo = ViewState("PreviousSequenceNo") + (CInt(ViewState("pageSize")) * Math.Abs(difference))
            End If
            ViewState("PreviousPageSize") = ViewState("pageSize")
            ViewState("PreviousSequenceNo") = SequenceNo
            ViewState("PreviousPageIndex") = e.NewPageIndex
        End If
        GetMessageHeaders()
        'End If
    End Sub
    Protected Sub gvInbox_SortCommand(ByVal source As Object, ByVal e As Telerik.WebControls.GridSortCommandEventArgs) Handles gvInbox.SortCommand
        Dim dv As DataView = dataSource.DefaultView
        If e.SortExpression = "From" Then
            If ViewState("SortDirectionFrom") = "ASC" Then
                dv.Sort = "From"
                dataSource = dv.ToTable()
                Me.gvInbox.DataSource = dataSource 'dtbl
                Me.gvInbox.DataBind()
                ViewState("SortDirectionFrom") = "DESC"
            ElseIf ViewState("SortDirectionFrom") = "DESC" Then
                dv.Sort = "From Desc"
                dataSource = dv.ToTable()
                Me.gvInbox.DataSource = dataSource 'dtbl
                Me.gvInbox.DataBind()
                ViewState("SortDirectionFrom") = "ASC"
            End If
        End If
        If e.SortExpression = "Subject" Then
            If ViewState("SortDirectionSubject") = "ASC" Then
                dv.Sort = "Subject"
                dataSource = dv.ToTable()
                Me.gvInbox.DataSource = dataSource 'dtbl
                Me.gvInbox.DataBind()
                ViewState("SortDirectionSubject") = "DESC"
            ElseIf ViewState("SortDirectionSubject") = "DESC" Then
                dv.Sort = "Subject Desc"
                dataSource = dv.ToTable()
                Me.gvInbox.DataSource = dataSource 'dtbl
                Me.gvInbox.DataBind()
                ViewState("SortDirectionSubject") = "ASC"
            End If
        End If
        If e.SortExpression = "Date" Then
            If ViewState("SortDirectionDate") = "ASC" Then
                dv.Sort = "Date"
                dataSource = dv.ToTable()
                Me.gvInbox.DataSource = dataSource 'dtbl
                Me.gvInbox.DataBind()
                ViewState("SortDirectionDate") = "DESC"
            ElseIf ViewState("SortDirectionDate") = "DESC" Then
                dv.Sort = "Date Desc"
                dataSource = dv.ToTable()
                Me.gvInbox.DataSource = dataSource 'dtbl
                Me.gvInbox.DataBind()
                ViewState("SortDirectionDate") = "ASC"
            End If
        End If
    End Sub

    Protected Sub InboxType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles InboxType.SelectedIndexChanged
        If InboxType.SelectedValue = "Sent" Then
            Response.Redirect("Inbox_GApps.aspx?Mailbox=SentItems")
        Else
            Response.Redirect("Inbox_GApps.aspx")
        End If
    End Sub

    Protected Sub btnRefreshNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefreshNew.Click
        Response.Redirect(Request.Url.ToString)
    End Sub

    Function GetMessageCount()
        Dim imap As New Chilkat.Imap()
        Dim success As Boolean
        Dim strMailServer As String = String.Empty
        Dim strUserName As String = String.Empty
        Dim strPassword As String = String.Empty

        strUserName = "kshahzad@skfacademy.org"
        strPassword = "test123"

        'strUserName = "rana.paki@gmail.com"
        'strPassword = "isitis"

        strMailServer = "imap.gmail.com"


        success = imap.UnlockComponent(ConfigurationManager.AppSettings("ChilkatEmailComponentKey"))
        If (success <> True) Then
            Exit Function
        End If

        imap.Port = 993
        imap.Ssl = True

        '  Connect to an IMAP server.
        success = imap.Connect(strMailServer)
        If (success <> True) Then
            Exit Function
        End If

        '  Login
        success = imap.Login(strUserName, strPassword)
        If (success <> True) Then
            Exit Function
        End If

        '  Select an IMAP mailbox
        success = imap.SelectMailbox("Inbox")
        If (success <> True) Then
            Exit Function
        End If

        '  After selecting the mailbox. the total number of emails
        '  is immediately available:
        Dim totalNum As Long
        totalNum = imap.NumMessages

        '  To determine the number of unseen messages, a call
        '  to Search is required, which returns the set of UIDs
        '  of all unseen messages.

        Dim messageSet As Chilkat.MessageSet
        '  We can choose to fetch UIDs or sequence numbers.
        Dim fetchUids As Boolean
        fetchUids = True

        messageSet = imap.Search("UNSEEN", fetchUids)
        If (messageSet Is Nothing) Then
            'MsgBox(imap.LastErrorText)
            Response.Write(imap.LastErrorText)
            Exit Function
        End If

        Dim numUnseen As Long
        numUnseen = messageSet.Count

        '  Disconnect from the IMAP server.
        imap.Disconnect()

        Return numUnseen
    End Function

End Class
