Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports System
Imports System.Text
Imports System.Net.Mail
Imports System.Data.SqlClient
Imports Portal.BLL.Email

<System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class NSContact
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function NS_AddContactUs(ByVal FullName As String, ByVal CompanyName As String, ByVal PhoneNumber As String, ByVal EmailAddress As String, ByVal Subject As String, ByVal Message As String, ByVal Address As String, ByVal BestTime As String, ByVal CountryCode As String, ByVal StateCode As String, ByVal State As String, ByVal ZipCode As String, ByVal City As String) As Integer
        Dim ReturnVal As Integer
        Dim IP As String = String.Empty
        If Not HttpContext.Current Is Nothing Then
            IP = HttpContext.Current.Request.UserHostAddress()
        End If
        Dim db As New DBAccess
        Dim IsValidated As Boolean = True
        If String.IsNullOrEmpty(FullName) Then
            IsValidated = False
        End If
        If String.IsNullOrEmpty(PhoneNumber) Then
            IsValidated = False
        End If
        If String.IsNullOrEmpty(EmailAddress) Then
            IsValidated = False
        End If
        If String.IsNullOrEmpty(Subject) Then
            IsValidated = False
        End If
        If String.IsNullOrEmpty(Message) Then
            IsValidated = False
        End If
        If String.IsNullOrEmpty(CountryCode) Then
            'IsValidated = False
        End If
        If String.IsNullOrEmpty(StateCode) AndAlso String.IsNullOrEmpty(State) Then
            'IsValidated = False
        End If
        If IsValidated = False Then
            Return -1
            Exit Function
        End If

        Try
            If Not String.IsNullOrEmpty(FullName) Then
                db.AddParameter("@FullName", SqlDbType.VarChar, 100, ParameterDirection.Input, FullName)
            Else
                db.AddParameter("@FullName", SqlDbType.VarChar, 100, ParameterDirection.Input, String.Empty)
            End If

            If Not String.IsNullOrEmpty(CompanyName) Then
                db.AddParameter("@CompanyName", SqlDbType.VarChar, 100, ParameterDirection.Input, CompanyName)
            Else
                db.AddParameter("@CompanyName", SqlDbType.VarChar, 100, ParameterDirection.Input, DBNull.Value)
            End If
            If Not String.IsNullOrEmpty(PhoneNumber) Then
                db.AddParameter("@PhoneNumber", SqlDbType.VarChar, 50, ParameterDirection.Input, PhoneNumber)
            Else
                db.AddParameter("@PhoneNumber", SqlDbType.VarChar, 50, ParameterDirection.Input, DBNull.Value)
            End If
            If IsValidEmail(EmailAddress) Then
                db.AddParameter("@EmailAddress", SqlDbType.VarChar, 50, ParameterDirection.Input, EmailAddress)
            Else
                db.AddParameter("@EmailAddress", SqlDbType.VarChar, 50, ParameterDirection.Input, DBNull.Value)
            End If
            If Not String.IsNullOrEmpty(Subject) Then
                db.AddParameter("@Subject", SqlDbType.VarChar, 50, ParameterDirection.Input, Subject)
            Else
                db.AddParameter("@Subject", SqlDbType.VarChar, 50, ParameterDirection.Input, DBNull.Value)
            End If
            If Not String.IsNullOrEmpty(Message) Then
                db.AddParameter("@Message", SqlDbType.VarChar, 8000, ParameterDirection.Input, Message)
            Else
                db.AddParameter("@Message", SqlDbType.VarChar, 8000, ParameterDirection.Input, DBNull.Value)
            End If
            db.AddParameter("@DateModified", SqlDbType.DateTime, 4, ParameterDirection.Input, Date.UtcNow())
            db.AddParameter("@DateEntered", SqlDbType.DateTime, 4, ParameterDirection.Input, Date.UtcNow())
            If String.IsNullOrEmpty(Address) = False Then
                db.AddParameter("@Address", SqlDbType.NVarChar, 500, ParameterDirection.Input, Address)
            Else
                db.AddParameter("@Address", SqlDbType.NVarChar, 500, ParameterDirection.Input, DBNull.Value)
            End If
            If String.IsNullOrEmpty(BestTime) = False Then
                db.AddParameter("@BestTime", SqlDbType.VarChar, 50, ParameterDirection.Input, BestTime)
            Else
                db.AddParameter("@BestTime", SqlDbType.VarChar, 50, ParameterDirection.Input, DBNull.Value)
            End If
            If Not String.IsNullOrEmpty(IP) Then
                db.AddParameter("@IP", SqlDbType.VarChar, 50, ParameterDirection.Input, IP)
            Else
                db.AddParameter("@IP", SqlDbType.VarChar, 50, ParameterDirection.Input, DBNull.Value)
            End If

            db.AddParameter("@Deleted", SqlDbType.Bit, 1, ParameterDirection.Input, False)
            If CountryCode = String.Empty Then
                db.AddParameter("@CountryCode", "N/A")
            Else
                db.AddParameter("@CountryCode", CountryCode)
            End If

            If StateCode = String.Empty Then
                db.AddParameter("@StateCode", "N/A")
            Else
                db.AddParameter("@StateCode", StateCode)
            End If
            If (Not String.IsNullOrEmpty(State) AndAlso State IsNot Nothing) Then
                db.AddParameter("@State", SqlDbType.VarChar, 100, ParameterDirection.Input, State)
            Else
                db.AddParameter("@State", SqlDbType.VarChar, 100, ParameterDirection.Input, DBNull.Value)
            End If
            If Not String.IsNullOrEmpty(ZipCode) Then
                db.AddParameter("@ZipCode", SqlDbType.VarChar, 50, ParameterDirection.Input, ZipCode)
            Else
                db.AddParameter("@ZipCode", SqlDbType.VarChar, 50, ParameterDirection.Input, DBNull.Value)
            End If
            If Not String.IsNullOrEmpty(City) Then
                db.AddParameter("@City", SqlDbType.VarChar, 100, ParameterDirection.Input, City)
            Else
                db.AddParameter("@City", SqlDbType.VarChar, 100, ParameterDirection.Input, DBNull.Value)
            End If
            ReturnVal = db.ExecuteNonQuery("NS_ContactUs_Add_Modified")
            If (ReturnVal > -1) Then
                SendMailNewContact(FullName, CompanyName, PhoneNumber, EmailAddress, Subject, Message, Address, BestTime, CountryCode, StateCode, State, ZipCode, City)
            End If
            Return ReturnVal
        Catch ex As Exception
            ErrorLogger.AddError(ex.ToString(), ex.Message, "NSContact.vb", "NS_AddContactUs", "", "", ex.InnerException.ToString)
            Return -1
            Exit Function
        End Try



    End Function

    Private Sub SendMailNewContact(ByVal FullName As String, ByVal CompanyName As String, ByVal PhoneNumber As String, ByVal EmailAddress As String, ByVal Subject As String, ByVal Message As String, ByVal Address As String, ByVal BestTime As String, ByVal CountryCode As String, ByVal StateCode As String, ByVal State As String, ByVal ZipCode As String, ByVal City As String)
        Try


            Dim db As New DBAccess
            Dim dtEmailAddresses As DataTable = db.ExecuteDataTable("NS_GetEmailAddress")
            If (dtEmailAddresses.Rows.Count > 0) Then
                For Each dr As DataRow In dtEmailAddresses.Rows
                    SendEmail(dr("EmailAddress"), FullName, CompanyName, PhoneNumber, EmailAddress, Subject, Message, Address, BestTime, CountryCode, StateCode, State, ZipCode, City)
                Next
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.ToString(), ex.Message, "NSContact.vb", "SendMailNewContact", "", "", ex.InnerException.ToString)
        End Try
    End Sub

    Private Sub SendEmail(ByVal ToEmailAddress As String, ByVal FullName As String, ByVal CompanyName As String, ByVal PhoneNumber As String, ByVal EmailAddress As String, ByVal Subject As String, ByVal Message As String, ByVal Address As String, ByVal BestTime As String, ByVal CountryCode As String, ByVal StateCode As String, ByVal State As String, ByVal ZipCode As String, ByVal City As String)
        Dim mail As Portal.BLL.Email
        mail = New Portal.BLL.Email()
        Dim EmailBody As String = String.Empty
        EmailBody = EmailBody & "FullName: " & FullName & vbCrLf
        EmailBody = EmailBody & "PhoneNumber: " & PhoneNumber & vbCrLf
        EmailBody = EmailBody & "EmailAddress: " & EmailAddress & vbCrLf
        EmailBody = EmailBody & "Subject: " & Subject & vbCrLf
        EmailBody = EmailBody & "Message: " & Message & vbCrLf
        EmailBody = EmailBody & "State: " & State
        Send_mail(EmailBody, ToEmailAddress)

    End Sub
    Private Function IsValidEmail(ByVal EmailAddress As String) As Boolean
        Dim IsValid As Boolean = True
        Dim mailAddress As System.Net.Mail.MailAddress
        Try
            mailAddress = New System.Net.Mail.MailAddress(EmailAddress)
        Catch ex As Exception
            IsValid = False
        Finally
            mailAddress = Nothing
        End Try
        Return IsValid
    End Function
    Public Function Send_mail(ByVal detail As String, ByVal ToEmailAddress As String) As Integer
        Dim Emailaddress As String = ""
        Dim MailMsg As New MailMessage()
        MailMsg.From = New MailAddress("support@netsolace.com", "Netsolace")
        If ToEmailAddress <> "" Then
            While ToEmailAddress.IndexOf(",") <> -1
                Emailaddress = ToEmailAddress.Substring(0, ToEmailAddress.IndexOf(","))
                Try
                    MailMsg.To.Add(Emailaddress)
                Catch ex As Exception

                End Try
                ToEmailAddress = ToEmailAddress.Substring(ToEmailAddress.IndexOf(",") + 1, ToEmailAddress.Length - (ToEmailAddress.IndexOf(",") + 1))
            End While
            If ToEmailAddress.IndexOf(",") = -1 And ToEmailAddress <> "" Then
                Try
                    MailMsg.To.Add(ToEmailAddress)
                Catch ex As Exception

                End Try

            End If
        End If
        MailMsg.BodyEncoding = Encoding.Default
        MailMsg.Subject = "Netsolace.com Contact Us"
        MailMsg.Body = detail
        MailMsg.Priority = MailPriority.Normal
        MailMsg.IsBodyHtml = False
        Dim Client As New SmtpClient("localhost")


        Try
            Client.Send(MailMsg)
        Catch ex As Exception

        End Try
        Client = Nothing
        MailMsg.Dispose()

        Return 1
    End Function
End Class