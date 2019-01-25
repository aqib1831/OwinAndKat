Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class FranMail_Inbox_GApps_Details
    Inherits System.Web.UI.Page

    Private MailHost As String = String.Empty
    Private PopUsername As String = String.Empty
    Private PopPassword As String = String.Empty
    Public dtbl As DataTable
    Private Mailbox As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("Mailbox")) = False Then
            Mailbox = Request.QueryString("Mailbox")
            hdnMailBox.Value = Request.QueryString("Mailbox")
        End If
        If String.IsNullOrEmpty(Request.QueryString("ID")) = False Then
            GetMessage(CInt(Request.QueryString("ID")))
            Me.hdnMailID.Value = Request.QueryString("ID")
        End If
    End Sub
    Private Sub GetMessage(ByVal mailID As Integer)
        If String.IsNullOrEmpty(Request.QueryString("Mailbox")) = False Then
            Mailbox = Request.QueryString("Mailbox")
        Else
            Mailbox = "Inbox"
        End If

        If Mailbox = "DeletedItems" Then
            hdnMailBox.Value = "Inbox.Deleted Items"
        ElseIf Mailbox = "Spam" Then
            hdnMailBox.Value = "INBOX.Spam"
        ElseIf Mailbox = "SentItems" Then
            hdnMailBox.Value = "Inbox.Sent Items"
        ElseIf Mailbox = "Inbox" Then
            hdnMailBox.Value = "INBOX"
        ElseIf Mailbox = "GmailSpam" Then
            hdnMailBox.Value = "[Gmail]/Spam"
        ElseIf Mailbox = "GmailDrafts" Then
            hdnMailBox.Value = "[Gmail]/Drafts"
        ElseIf Mailbox = "GmailSentMail" Then
            hdnMailBox.Value = "[Gmail]/Sent Mail"
        ElseIf Mailbox = "GmailTrash" Then
            hdnMailBox.Value = "[Gmail]/Trash"
        End If

        Dim db As DBAccess = New DBAccess()
        Dim dr As SqlDataReader
        Dim email As Chilkat.Email
        Dim strFolder As String = String.Empty
        Dim strUploadFolderPath As String = String.Empty
        Dim uid As Long
        Dim isUid As Boolean
        Dim strMailServer As String = String.Empty

        MailHost = "imap.gmail.com"
        PopUsername = "kshahzad@skfacademy.org"
        PopPassword = "test123"

        Dim imap As New Chilkat.Imap()
        Dim success As Boolean
        '  Anything unlocks the component and begins a fully-functional 30-day trial.
        success = imap.UnlockComponent(ConfigurationManager.AppSettings("ChilkatEmailComponentKey"))
        If (success <> True) Then
            Exit Sub
        End If
        '  Connect to an IMAP server.
        strMailServer = MailHost
        'If Trim(LCase(strMailServer)) = "secure.emailsrvr.com" Then
        imap.Port = 993
        imap.Ssl = True
        'End If

        success = imap.Connect(MailHost)
        If (success <> True) Then
            Exit Sub
        End If
        '  Login
        success = imap.Login(PopUsername, PopPassword)
        If (success <> True) Then
            Exit Sub
        End If
        '  Select an IMAP mailbox
        'If Mailbox = "DeletedItems" Then
        '    success = imap.SelectMailbox("Inbox.Deleted Items")
        'ElseIf Mailbox = "Inbox" Then
        '    success = imap.SelectMailbox("Inbox")
        'ElseIf Mailbox = "Spam" Then
        '    success = imap.SelectMailbox("INBOX.Spam")
        'ElseIf Mailbox = "SentItems" Then
        '    success = imap.SelectMailbox("Inbox.Sent Items")
        'End If
        success = imap.SelectMailbox(hdnMailBox.Value)

        If (success <> True) Then
            Exit Sub
        End If
        isUid = True
        email = imap.FetchSingle(mailID, isUid)
        If (Not (email Is Nothing)) Then
            If email.NumAttachments > 0 Then
                strFolder = uid & "_" & Replace(Replace(Replace(Now(), ":", ""), " ", ""), "/", "")
                strUploadFolderPath = System.Configuration.ConfigurationManager.AppSettings("MailAttachmentResourcesPath")
                'strUploadFolderPath = strUploadFolderPath & "\" & strFolder
                'ClearAttachmentFolder(strUploadFolderPath)
                strUploadFolderPath = MapPath(strUploadFolderPath) & "\" & strFolder
                Directory.CreateDirectory(strUploadFolderPath)
                email.SaveAllAttachments(strUploadFolderPath)
                Dim dirInfo As New DirectoryInfo(MapPath(System.Configuration.ConfigurationManager.AppSettings("MailAttachmentResourcesPath") & "/" & strFolder))
                ' Dim dirInfo As New DirectoryInfo(MapPath(strUploadFolderPath))
                Dim aryFileNames As Array
                Dim i As Integer = 0
                ltlFileNames.Visible = True
                aryFileNames = dirInfo.GetFiles()
                For i = 0 To aryFileNames.Length - 1
                    ltlFileNames.Text = ltlFileNames.Text & "<a target='_blank' style='color:green; font-weight:normal'  href='" & System.Configuration.ConfigurationManager.AppSettings("MailAttachmentResourcesPath") & "/" & strFolder & "/" & aryFileNames(i).Name.ToString() & "'><img align='absmiddle' border='0' src=images/Program_Images/" & GetFileImage(aryFileNames(i).Extension.ToString()) & "> " & aryFileNames(i).Name.ToString() & " (" & ConvertBytes(aryFileNames(i).Length) & ")</a>; "
                    aryFileNames(i).Extension.ToString()
                Next
            Else
                ltlFileNames.Visible = False
                trAttachments.Attributes.Add("style", "display:none")
            End If
            Me.lblFrom.Text = email.FromName & " [" & email.FromAddress & "]"
            'Me.lblTo.Text = "[" & email.GetTo(0).ToString() & "]"
            Me.lblDate.Text = email.EmailDate
            Me.lblSubject.Text = Functions.StringTruncate(email.Subject, 100)
            Me.lblTitle.Text = Functions.StringTruncate(email.Subject, 85)
            Me.lblSize.Text = ConvertBytes(email.Size)
            'Me.lblEmailBody.Text = email.GetHtmlBody 'email.Body.ToString()
            If email.GetHtmlBody Is Nothing Then
                lblEmailBody.Text = Replace(email.Body, vbCrLf, "<br>")
            Else
                lblEmailBody.Text = email.GetHtmlBody
            End If
        End If
        imap.Disconnect()
    End Sub
    Private Function GetFileImage(ByVal ext As String) As String
        Dim strImageName As String
        Select Case ext

            Case ".doc"
                strImageName = "doc.gif"
            Case ".jpg"
                strImageName = "jpg.gif"
            Case ".pdf"
                strImageName = "pdf.gif"
            Case ".ppt"
                strImageName = "ppt.gif"
            Case ".txt"
                strImageName = "txt.gif"
            Case ".xls"
                strImageName = "xls.gif"
            Case ".avi"
                strImageName = "avi.gif"
            Case ".bmp"
                strImageName = "bmp.gif"
            Case ".dat"
                strImageName = "dat.gif"
            Case ".docx"
                strImageName = "docx.gif"
            Case ".flv"
                strImageName = "flv.gif"
            Case ".gif"
                strImageName = "gif.gif"
            Case ".html"
                strImageName = "htm.gif"
            Case ".htm"
                strImageName = "htm.gif"
            Case ".jpeg"
                strImageName = "jpeg.gif"
            Case ".mov"
                strImageName = "mov.gif"
            Case ".mpeg"
                strImageName = "mpeg.gif"
            Case ".png"
                strImageName = "png.gif"
            Case ".pptx"
                strImageName = "pptx.gif"
            Case ".rar"
                strImageName = "rar.gif"
            Case ".swf"
                strImageName = "swf.gif"
            Case ".xlsx"
                strImageName = "xlsx.gif"
            Case ".zip"
                strImageName = "zip.gif"
            Case Else
                strImageName = "window.gif"

        End Select

        Return strImageName

    End Function
    Function ConvertBytes(ByVal Bytes) As String
        Dim ConvertBytess As String = ""
        If Bytes >= 1073741824 Then
            ConvertBytess = Format(Bytes / 1024 / 1024 / 1024, "#0.00") & " GB"
        ElseIf Bytes >= 1048576 Then
            ConvertBytess = Format(Bytes / 1024 / 1024, "#0.00") & " MB"
        ElseIf Bytes >= 1024 Then
            ConvertBytess = Format(Bytes / 1024, "#0.00") & " KB"
        ElseIf Bytes < 1024 Then
            ConvertBytess = Fix(Bytes) & " Bytes"
        End If
        Return ConvertBytess
    End Function

    Public Function Createfolderforattachments() As String
        Dim folder As String = "Attachment"
        If My.Computer.FileSystem.DirectoryExists(folder) = False Then
            My.Computer.FileSystem.CreateDirectory(Server.MapPath(folder))
        End If
        Return folder
    End Function
    Public Sub ClearAttachmentFolder(ByVal AttachmentFolderPath As String)
        Dim rootDirectory As New DirectoryInfo(Server.MapPath(AttachmentFolderPath))
        Dim subDirectories As DirectoryInfo() = rootDirectory.GetDirectories()
        For Each subDirectory As DirectoryInfo In subDirectories
            subDirectory.Delete(True)
        Next
    End Sub

End Class
