Imports Portal.BLL
Imports Chilkat
Imports System.Data
Imports System.Data.SqlClient

Partial Class MyNetsolace_AddActivityFromEmail
    Inherits System.Web.UI.Page
    Const GeneralTicket As Integer = Integer.MaxValue
    Private daUidl As SqlDataAdapter

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        ScanEmails()
    End Sub
  
    Private Sub AddHelpDeskActivity(ByVal subject As String, ByVal body As String, ByVal drFranchisee As DataRow, ByVal email As Chilkat.Email)
        Try
            Dim ObjectActivity As New Portal.BLL.Activities()
            Dim ActivityID As Integer = 0
            With ObjectActivity
                .Subject = subject
                .Type = Enumeration.ActivityType.HelpDesk
                .SubType = Enumeration.ActivitySubType.General
                .TimeSpent = TimeSpan.Parse("00:00")
                .AdminID = 0
                .PlacedBy = Enumeration.PlacedBy.Franchisee
                .ClientContactID = 0
                .FranchiseContactID = drFranchisee("ContactID")
                .WaitingFor = 0
                .FranchiseID = drFranchisee("ID")
                .DepartmentID = Enumeration.EAI_DepartmentID.Netsolace
                .ActivityState = Enumeration.ActivityState.NotStarted
                .Description = body
                .ActivityDate = DateTime.Now
                .Status = False
                .AdminInboxStatus = 0
                .RelatedTo = GeneralTicket
                .ModuleId = GeneralTicket

                ActivityID = .ActivitiesAdd(Enumeration.ClientID.EA, .FranchiseID, .AdminID, .DepartmentID, .FranchiseContactID, .TimeSpent.ToString(), .ActivityDate, .Type, .SubType, .Subject, .Description, .Status, .PlacedBy, .ActivityState, .WaitingFor, .AdminInboxStatus, False, .ClientContactID, .RelatedTo, .ModuleId)

            End With
            If ActivityID > 0 Then
                If email.NumAttachments > 0 Then
                    Dim intNewNotesID As Integer = 0
                    Dim objActivityAttachement As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
                    With objActivityAttachement
                        .ActivityID = ActivityID        'Specifying the activity ID for Which the attachements Are                    
                        .NotesID = 0                    'Specifying the Notes ID as 0 in case the attachement is for activity

                        Dim DirectoryName As String = Functions.GetDateTimeUniqueString()
                        Dim path As String = .GetAttachmentPath(DirectoryName)
                        email.SaveAllAttachments(path)

                        If email.GetAttachmentFilename(0) <> Nothing Then
                            .FileName = email.GetAttachmentFilename(0)
                            .FilePath = DirectoryName & "\" & email.GetAttachmentFilename(0)
                            .AddAttachment(objActivityAttachement)
                        End If
                        If email.GetAttachmentFilename(1) <> Nothing Then
                            .FileName = email.GetAttachmentFilename(1)
                            .FilePath = DirectoryName & "\" & email.GetAttachmentFilename(1)
                            .AddAttachment(objActivityAttachement)
                        End If
                        If email.GetAttachmentFilename(2) <> Nothing Then
                            .FileName = email.GetAttachmentFilename(2)
                            .FilePath = DirectoryName & "\" & email.GetAttachmentFilename(2)
                            .AddAttachment(objActivityAttachement)
                        End If
                    End With
                End If
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddActivityFromEmail", String.Empty, Request.UserHostAddress, String.Empty)
        End Try
    End Sub
    Private Function GetAllSystemEmailAddresses() As DataTable
        Dim db As DBAccess = New DBAccess()
        Dim dtblSystemEmailAddresses As DataTable = New DataTable("SystemEmailAddresses")
        dtblSystemEmailAddresses = db.ExecuteDataTable("MyNetsolace_Emails_GetAllSystemEmailAddresses")
        System.Web.HttpContext.Current.Cache("SystemEmailAddresses") = dtblSystemEmailAddresses
        Return dtblSystemEmailAddresses
    End Function

    Private Function GetSeenEmailIDs() As DataTable
        Dim dtSeenEmailIds As New DataTable
        Dim sqlConn As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString)
        Dim da As New SqlDataAdapter("SELECT ID,UIDL FROM MyNetsolace_Scanned_Emails", sqlConn)
        da.InsertCommand = New SqlCommand("INSERT INTO MyNetsolace_Scanned_Emails(UIDL) VALUES(@UIDL)", sqlConn)
        da.InsertCommand.Parameters.Add("@UIDL", SqlDbType.NVarChar, 100, "UIDL")
        da.Fill(dtSeenEmailIds)
        daUidl = da
        Return dtSeenEmailIds
    End Function
    Private Sub ScanEmails()
        Try

            Dim mailman As New Chilkat.MailMan()
            Dim success As Boolean = mailman.UnlockComponent(Convert.ToString(ConfigurationManager.AppSettings("ChilkatEmailComponentKey")))
            'Dim success As Boolean = mailman.UnlockComponent("Anything for 30-day trial")
            If (success <> True) Then
                Exit Sub
            End If
            ' Set our POP3 hostname, login and password
            mailman.MailHost = Convert.ToString(ConfigurationManager.AppSettings("FranMailServerAddress"))
            mailman.PopUsername = ConfigurationManager.AppSettings("SupportEmailAddress")
            mailman.PopPassword = ConfigurationManager.AppSettings("SupportEmailAddressPassword")

            '  Get the complete list of UIDLs on the mail server.
            Dim saUidls As Chilkat.StringArray
            saUidls = mailman.GetUidls()
            If (saUidls Is Nothing) Then
                Exit Sub
            End If

            Dim dtSeemUidls As DataTable = GetSeenEmailIDs()
            Dim dtScannedEmails As New DataTable
            dtScannedEmails = dtSeemUidls

            '  Create a new string array object (it's an object, not an actual array)
            '  and add the UIDLs from saUidls that aren't already seen.
            Dim saUnseenUidls As New Chilkat.StringArray()
            While saUidls.Count > 0
                Dim match() As DataRow = dtSeemUidls.Select("UIDL='" & saUidls.GetString(0) & "'", "UIDL")
                If match.Length <= 0 Then
                    saUnseenUidls.Append(saUidls.GetString(0))
                    Dim dr As DataRow = dtScannedEmails.NewRow()
                    dr("UIDL") = saUidls.GetString(0)
                    dtScannedEmails.Rows.Add(dr)
                End If
                saUidls.RemoveAt(0)
            End While

            If (saUnseenUidls.Count = 0) Then
                Exit Sub
            End If

            '  Download in full the unseen emails:
            Dim bundle As Chilkat.EmailBundle
            bundle = mailman.FetchMultiple(saUnseenUidls)
            If (bundle Is Nothing) Then
                Exit Sub
            End If

            Dim email As Chilkat.Email
            Dim arrMatches() As DataRow
            Dim strSelect As String = String.Empty
            Dim dtAddresses As DataTable
            Dim strBody As String = String.Empty
            Dim strSubject As String = String.Empty
            dtAddresses = GetAllSystemEmailAddresses()
            For i As Integer = 0 To bundle.MessageCount - 1
                email = bundle.GetEmail(i)
                If email IsNot Nothing Then
                    strSelect = email.FromAddress.ToLower     ' Scan From Address
                    strSelect = "EmailAddress='" & Replace(strSelect, "'", "") & "'"
                    arrMatches = dtAddresses.Select(strSelect, "EmailAddress")
                    If arrMatches.Length > 0 Then
                        strBody = String.Empty
                        strSubject = String.Empty
                        strSubject = email.Subject
                       'strBody = email.GetPlainTextBody
			If email.GetHtmlBody Is Nothing Then
                            strBody = email.GetPlainTextBody
                        Else
                            strBody = email.GetHtmlBody
                        End If
                        AddHelpDeskActivity(strSubject, strBody, arrMatches(0), email)
                    End If
                End If
            Next
            email.Dispose()
            'saving new email UIDLS to DB
            daUidl.Update(dtScannedEmails)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "ScanEmails", String.Empty, Request.UserHostAddress, String.Empty)
        Finally
 If daUidl IsNot Nothing Then
            daUidl.Dispose()
End If
        End Try
    End Sub

    
    
End Class
