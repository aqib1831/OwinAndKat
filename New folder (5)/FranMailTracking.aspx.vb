Imports System.Data.SqlClient
Imports System.Data
Imports System.Net.Mail
Imports Chilkat
Partial Class FranMailTracking

    Inherits System.Web.UI.Page
    Dim ATTACHMENT_SAVE As String = ConfigurationManager.AppSettings("FranMailTracking")
    Dim dtblDomains As DataTable
   
    Public Shared Function Users_GetLoginInfo() As SqlDataReader
        Dim db As New DBAccess
        Return db.ExecuteReader("Users_GetLoginInfo")
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim drEmployeeLoginInfo As SqlDataReader
        Dim UserName As String = String.Empty
        Dim Password As String = String.Empty
        Dim UserId As Integer = 0
        dtblDomains = dtblGetAllDomains() 'Load all domains to skip their tracking

        drEmployeeLoginInfo = Users_GetLoginInfo() ' get all users for their email tracking 
        While drEmployeeLoginInfo.Read
            UserName = Functions.IfNull(drEmployeeLoginInfo("FranMail_UserName"), "")
            Password = Functions.IfNull(drEmployeeLoginInfo("FranMail_Password"), "")
            UserId = drEmployeeLoginInfo("ID")
            If UserName.Contains("netsolace.com.pk") Then
                LogAndSendEmails(UserName, Password, UserId)
            End If
        End While

        drEmployeeLoginInfo.Close()

    End Sub

    Private Sub LogAndSendEmails(ByVal strUserName As String, ByVal strPassword As String, ByVal UserID As Integer)

        TrackEmails("Sent", strUserName, strPassword, UserID)
        TrackEmails("Trash", strUserName, strPassword, UserID)

    End Sub

    Private Sub TrackEmails(ByVal strmailbox As String, ByVal strUserName As String, ByVal strPassword As String, ByVal UserID As Integer)

        Dim retVal As Boolean = False
        Dim strDate As String = Date.Now.ToString("dd-MMM-yyyy").ToString()

        'Create a mailman object for reading email.
        Dim uidls As Chilkat.MessageSet
        Dim chunk As New Chilkat.MessageSet
        Dim bundle As Chilkat.EmailBundle
        Dim strBody As String = String.Empty
        Dim success As Boolean

        Dim hasEmailAttachment As Boolean = False
        Dim attachmentString As String = String.Empty

        Dim imap As New Chilkat.Imap()
        '  Anything unlocks the component and begins a fully-functional 30-day trial.
        success = imap.UnlockComponent(ConfigurationManager.AppSettings("ChilkatEmailComponentKey"))
        If (success <> True) Then
            Exit Sub
        End If

        imap.Port = 993
        imap.Ssl = True

        '  Connect to an IMAP server.
        success = imap.Connect(Convert.ToString(ConfigurationManager.AppSettings("FranMailServerAddress")))
        If (success <> True) Then
            Exit Sub
        End If
        'Login
        success = imap.Login(strUserName, strPassword)
        If (success <> True) Then
            Exit Sub
        End If

        imap.ReadTimeout = 60

        'Select an IMAP mailbox
        success = imap.SelectMailbox(strmailbox)

        If (success <> True) Then
            Exit Sub
        End If


        uidls = imap.Search("SENTON " & strDate, True)

        If (Not (uidls Is Nothing)) Then

            bundle = imap.FetchHeaders(uidls)
            If bundle Is Nothing Then
                imap.Disconnect()
                Exit Sub
            End If
            Dim i As Integer
            Dim n As Integer = bundle.MessageCount

            For i = 0 To n - 1
                Dim dtblLargeSizeEmails As DataTable
                Dim drow() As DataRow
                Dim drowDomains() As DataRow
                dtblLargeSizeEmails = dtblGetLargeSizeEmails()
                Dim AttachmentSize As Integer = 0
                Dim strEmailBody As String = String.Empty

                Dim email As Chilkat.Email = bundle.GetEmail(i)

                Dim emailTo() As String
                Dim strEmail As String = email.GetToAddr(0)
                Dim splitChar() As Char = {"@"}
                emailTo = strEmail.Split(splitChar)

                drowDomains = dtblDomains.Select("DomainName= '" & emailTo(1).ToString & "'", "DomainName") 'filter that email address exist in our domain

                Dim uid As Integer
                uid = email.GetHeaderField("ckx-imap-uid")

                Dim bodyEmail As Chilkat.Email

                bodyEmail = imap.FetchSingle(uid, True) 'search the body against that uid 

                For attchmentCounter As Integer = 0 To bodyEmail.NumAttachments - 1
                    AttachmentSize += bodyEmail.GetAttachmentSize(attchmentCounter)
                Next

                Dim strEmailSize As Integer = ConfigurationManager.AppSettings("TrackedEmailSize")
                If (drowDomains.Length) = 0 Or (AttachmentSize >= strEmailSize) Then  'Also check that size of each email is more than 4MB 

                    drow = dtblLargeSizeEmails.Select("EmailID='" & uid & "'") 'Filter that email is already tracked

                    If drow.Length = 0 Then

                        Dim objEmail As New Portal.BLL.Email
                        Dim MailMsg As New MailMessage()
                        Dim emailDetails As String = String.Empty

                        If email.GetHtmlBody Is Nothing Then
                            strEmailBody = bodyEmail.Body
                        Else
                            strEmailBody = bodyEmail.GetHtmlBody
                        End If


                        If Add(uid, email.Subject, strEmailBody, email.EmailDate, email.FromAddress, UserID, email.Size, "Sent", strEmail) > 0 Then 'insert into database

                            Dim flgAttachments As Boolean = False

                            If bodyEmail.NumAttachments > 0 Then
                                CreateFolder(Server.MapPath(ATTACHMENT_SAVE & uid)) ' save attachment to direcroty and add to email object for sending to notify admin
                                flgAttachments = True
                                If bodyEmail.SaveAllAttachments(Server.MapPath(ATTACHMENT_SAVE & uid & "\")) = True Then
                                    If bodyEmail.NumAttachments > 0 Then
                                        objEmail.FileOne = Server.MapPath(ATTACHMENT_SAVE & uid & "\" & bodyEmail.GetAttachmentFilename(0).ToString())
                                    End If
                                    If bodyEmail.NumAttachments > 1 Then
                                        objEmail.Filetwo = Server.MapPath(ATTACHMENT_SAVE & uid & "\" & bodyEmail.GetAttachmentFilename(1).ToString())
                                    End If
                                    If bodyEmail.NumAttachments > 2 Then
                                        objEmail.Filetwo = Server.MapPath(ATTACHMENT_SAVE & uid & "\" & bodyEmail.GetAttachmentFilename(1).ToString())
                                    End If
                                End If
                            End If

                            emailDetails = "Sent From : " + email.FromAddress + "<br>" + "Sent To: " + strEmail + "<br><br>" + "Body:<br>" + strEmailBody

                            Dim emailFromAddress As String = ConfigurationManager.AppSettings("TrackedFromAddress").ToString
                            Dim emailToAddress As String = ConfigurationManager.AppSettings("TrackedToEmailAddress").ToString
                            Dim emailBccAddress As String = ConfigurationManager.AppSettings("TrackedBccEmailAddress").ToString

                            objEmail.MailFrom = emailFromAddress
                            objEmail.MailTo = emailToAddress
                            objEmail.MailBCC = emailBccAddress
                            objEmail.Subject = "Tracked Email: " & email.Subject

                            objEmail.Detail = emailDetails

                            objEmail.Send_mail()
                            If flgAttachments = True Then
                                RemoveFolder(Server.MapPath(ATTACHMENT_SAVE & uid)) 'Delete attachments after sending email
                            End If

                        End If

                    End If

                End If

                email.Dispose()

            Next i

            bundle.Dispose()
            imap.Disconnect()
        End If


    End Sub

    Private Function dtblGetLargeSizeEmails() As DataTable

        Dim dTable As DataTable = New DataTable("LargeSizeEmails")
        Dim objDBAccess As New DBAccess
        dTable = objDBAccess.ExecuteDataTable("Users_TrackLargeSizeEmail_GetList")
        Return dTable

    End Function

    Private Function dtblGetAllDomains() As DataTable

        Dim dTable As DataTable = New DataTable("AllDomains")
        Dim objDBAccess As New DBAccess
        dTable = objDBAccess.ExecuteDataTable("EmailDomains_GetALL")
        Return dTable

    End Function

    Private Sub CreateFolder(ByVal Path As String)

        If Not IO.Directory.Exists(Path) Then
            IO.Directory.CreateDirectory(Path)
        End If

    End Sub

    Private Sub RemoveFolder(ByVal Path As String)

        Dim s As String
        For Each s In System.IO.Directory.GetFiles(Path)
            System.IO.File.Delete(s)
        Next s

        If IO.Directory.Exists(Path) Then
            IO.Directory.Delete(Path)
        End If

    End Sub

    Public Function Add(ByVal EmailId As Integer, ByVal emailSubject As String, ByVal emailBody As String, ByVal emailDate As Date, ByVal MailFrom As String, ByVal UserId As Integer, ByVal MailSize As String, ByVal MailType As String, ByVal emailTo As String) As String
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@UserId", UserId)
        db.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@Subject", emailSubject)
        db.AddParameter("@MailDate", emailDate)
        db.AddParameter("@MailBody", emailBody)
        db.AddParameter("@MailFrom", MailFrom)
        db.AddParameter("@MailId", EmailId)
        db.AddParameter("@MailSize", MailSize)
        db.AddParameter("@MailType", MailType)
        db.AddParameter("@MailTo", emailTo)
        db.ExecuteNonQuery("Users_LargeSizeEmail_Add")

        If Convert.IsDBNull(db.Parameters("@ReturnVal").Value) = False Then
            Return db.Parameters("@ReturnVal").Value
        Else
            Return 0
        End If
    End Function

End Class
