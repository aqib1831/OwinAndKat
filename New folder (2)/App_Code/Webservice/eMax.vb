Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports System.Web.HttpUtility
Imports Portal.BLL
Imports Portal.BLL.PM

<WebService(Namespace:="https://qa.netsolace.com/Portal/WebServices")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class emax

    Inherits System.Web.Services.WebService
    Dim fromName As String = ConfigurationManager.AppSettings("emaxFromName")
    Dim fromEmail As String = ConfigurationManager.AppSettings("emaxFromEmail")
    Dim ticketStatus As Integer = 2
    Dim ticketStatusName As String = "Not Started"
    Dim ticketType As Integer = 4
    Dim ticketTypeName As String = "Suggesion "
    Dim ticketPriority As Integer = 2
    Dim TicketPriorityName As String = "Normal"
    Dim clientName As String = "eMaximation"
    Dim CategoryID As Integer = 50


    <WebMethod()> _
    Public Function CreateNewPMTicket(ByVal securityCode As String, ByVal Name As String, ByVal Description As String) As Integer
        If Not String.IsNullOrEmpty(securityCode) Then
            securityCode = Functions.DecryptString128Bit(UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))
            If securityCode = ConfigurationManager.AppSettings("eMaxServiceAuthCode") Then
                Dim db As New DBAccess
                db.AddParameter("@Name", Replace(Name, "[amp]", "&"))
                db.AddParameter("@DateEntered", Date.Now.ToString("MM/dd/yyyy"))
                db.AddParameter("@Description", Replace(Description, "[amp]", "&"))
                db.AddParameter("@TypeID", ticketType)
                db.AddParameter("@UserID", ConfigurationManager.AppSettings("emaxUserID"))        ' User Id can't be null , so we have to create a user with ID
                db.AddParameter("@Read", False)
                db.AddParameter("@Status", ticketStatus)   ' Not Started
                db.AddParameter("@Deleted", False)
                db.AddParameter("@History", False)
                db.AddParameter("@DueDate", Date.Now.AddDays(10).ToString("MM/dd/yyyy"))
                db.AddParameter("@Priority", ticketPriority)
                db.AddParameter("@CategoryID", CategoryID)
                db.AddParameter("@ClientID", ConfigurationManager.AppSettings("emaxClientID")) ' emax 
                db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
                Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Add")
                Dim TicketID As Integer = CInt(Functions.IfNull(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value, "0"))
                If TicketID > 0 Then
                    CheckToMail(TicketID, Name, Date.Now.AddDays(10).ToString("MM/dd/yyyy"))
                    Return TicketID
                Else
                    Return TicketID
                End If
            End If
        End If
        Return Nothing
    End Function

    Private Function CheckToMail(ByVal TicketID As Integer, ByVal ticketName As String, ByVal dueDate As Date) As Integer
        Dim objDBAccess As DBAccess = New DBAccess()
        Dim dtUsers As Data.DataTable = Nothing
        Dim FranmailUserName As String = String.Empty
        Dim i As Integer = 0
        objDBAccess.AddParameter("@TicketFeatureID", TicketID)
        dtUsers = objDBAccess.ExecuteDataTable("PM_Ticket_Features_GetAllUsersForEmail")
        Dim strStatus As String = ""
        strStatus = ticketStatusName  ' Not Started
        Dim strPriority As String = ""
        strPriority = "Normal"
        Dim subject As String = "Created Netsolace Portal Ticket #" & TicketID & ": " & ticketName
        Try
            For i = 0 To dtUsers.Rows.Count - 1
                If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Client Then 'Client Contacts
                    SendMailToClientContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), fromEmail, fromName, "", _
                        subject, _
                        "has been created", _
                        TicketID, _
                        ticketName.Trim(), _
                        strStatus, _
                        dueDate, _
                        strPriority, _
                        ticketTypeName, _
                        clientName, _
                        ticketTypeName, False)
                ElseIf dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Netsolace Then 'Netsolace Contacts
                    SendMailToNetsolaceContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), "", _
                    subject, _
                    "has been created", _
                    TicketID, _
                    ticketName.Trim(), _
                    strStatus, _
                    dueDate, _
                    strPriority, _
                    ticketTypeName, _
                    clientName, _
                    ticketTypeName)
                End If
            Next

        Catch Exc As Exception
            ErrorLogger.AddError(Exc.ToString(), Exc.StackTrace, Exc.Source, Exc.TargetSite.Name, HttpContext.Current.Request.UserAgent, HttpContext.Current.Request.UserHostAddress, TicketID)
        Finally
            dtUsers.Dispose()
        End Try
        Return TicketID

    End Function
    Public Sub SendMailToNetsolaceContacts(ByVal ToName As String, ByVal ToEmail As String, ByVal ToCCEmail As String, ByVal MailSubject As String, ByVal CreatedORUpdatedORWaiting As String, ByVal TicketNo As String, ByVal TicketName As String, ByVal Status As String, ByVal DueDate As String, ByVal Priority As String, ByVal Type As String, ByVal Client As String, ByVal Category As String)

        Dim mail As Portal.BLL.Email
        mail = New Portal.BLL.Email()
        Dim strBody As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/NetsolaceContactsTicket.htm"))
        With mail
            .LeadID = 0
            .MailTo = ToEmail
            .MailFrom = fromEmail
            .DisplayName = fromName
            .MailBCC = ""
            .MailCC = ToCCEmail
            .Subject = MailSubject
            .TaskType = 3
            .Detail = strBody.Replace("@OwnerName", ToName).Replace("@CreatedORUpdatedORWaiting", CreatedORUpdatedORWaiting).Replace("@TicketNo", TicketNo).Replace("@OpenTicketNo", Functions.EncryptData(TicketNo)).Replace("@TicketName", TicketName).Replace("@Status", Status).Replace("@DueDate", DueDate).Replace("@Priority", Priority).Replace("@Type", Type).Replace("@Client", Client).Replace("@Category", Category)
            .CompletedDate = System.DateTime.Now
            .Send_mail()
        End With
    End Sub


    Public Shared Sub SendMailToClientContacts(ByVal ToName As String, ByVal ToEmail As String, ByVal FromEmail As String, ByVal DisplayName As String, ByVal ToCCEmail As String, ByVal MailSubject As String, ByVal CreatedORUpdatedORWaiting As String, ByVal TicketNo As String, ByVal TicketName As String, ByVal Status As String, ByVal DueDate As String, ByVal Priority As String, ByVal Type As String, ByVal Client As String, ByVal Category As String, ByVal IsNetsolaceUser As Boolean, Optional ByVal Link As String = "", Optional ByVal NonVisitedLink As String = "", Optional ByVal IsAreaDeveloperUser As Boolean = False)

        'remove from template also
        Dim mail As Portal.BLL.Email
        mail = New Portal.BLL.Email()

        Dim strBodyForUser As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/NetsolaceContactsTicket.htm"))
        Dim strBodyForClientContact As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/ClientContactsTicket.htm"))
        Dim strBodyForEAContact As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/EAContactsTicket.htm"))

        Dim strBody As String = ""
        If IsNetsolaceUser Then
            strBody = strBodyForUser ' for AdminId or Portal User or Is Netsolace User
        Else
            If Client.Contains("Edible") Then
                If Not IsAreaDeveloperUser Then
                    strBody = strBodyForEAContact
                Else
                    strBody = strBodyForClientContact
                End If
            Else
                strBody = strBodyForClientContact ' for CleintContactId or MyNetsolace User
            End If
        End If

        With mail
            .LeadID = 0
            .MailTo = ToEmail
            .MailFrom = FromEmail
            .DisplayName = DisplayName
            .MailBCC = ""
            .MailCC = ToCCEmail
            .Subject = MailSubject
            .TaskType = 3
            .Detail = strBody.Replace("@OwnerName", ToName).Replace("@CreatedORUpdatedORWaiting", CreatedORUpdatedORWaiting).Replace("@TicketNo", TicketNo).Replace("@OpenTicketNo", Functions.EncryptData(TicketNo)).Replace("@TicketName", TicketName).Replace("@Status", Status).Replace("@DueDate", DueDate).Replace("@Priority", Priority).Replace("@Type", Type).Replace("@Client", Client).Replace("@Category", Category).Replace("@Link", Link).Replace("@NonVisitedLink", NonVisitedLink)
            .CompletedDate = System.DateTime.Now
            .Send_mail()
        End With

        'End If
    End Sub
End Class