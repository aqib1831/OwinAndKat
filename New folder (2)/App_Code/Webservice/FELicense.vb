Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.HttpUtility

<WebService(Namespace:="https://qa.netsolace.com/portal/WebServices")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FELicense
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function AddFELicense(ByVal securityCode As String, ByVal sQuantity As String, _
                                    ByVal sStoreNumber As String, _
                                    ByVal InvoiceNumber As String, ByVal Notes As String, ByVal TerminalType As Byte) As Boolean

        Dim StoreNumber As Integer = CType(Functions.DecryptData(sStoreNumber.ToString()), Integer)
        Dim Quantity As Integer = CType(Functions.DecryptData(sQuantity.ToString()), Integer)
        'Dim StoreNumber As Integer = 302
        'Dim Quantity As Integer = 3

        ' Default Values
        ' will always be 1 for EA
        Dim ClientID As Integer = 1
        Dim IssuedByID As Integer = 98 ' Asked to put it hard coded by Usman

        ' Verify Security code before any further processing
        If String.IsNullOrEmpty(securityCode) Or securityCode <> "M@rket$FELincen$e@2013" Then
            Return False
            Exit Function
        End If
        Dim TerminalName As String = String.Empty
        If TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.FruitExpert Then
            TerminalName = "Fruit Expert"
        ElseIf TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxOrderingApp Then
            TerminalName = "SMSx Ordering App"
        ElseIf TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxDeliveryApp Then
            TerminalName = "SMSx Delivery App"
        Else
            Return False
            Exit Function
        End If

        ' Step 1: Get License Count for the Store if Count > 0 Cancel the process
        ' TODO: Have to understand the business Logic
        Dim LicenseCount As Integer = 0
        LicenseCount = Portal.BLL.SMSXLicenseManagement.GetStoreLicensesCount(StoreNumber, ClientID)
        If LicenseCount > 0 Then
            Return False
        End If

        ' Step 2: Set Field Values, not required Here
        ' Step 3: IP info 
        ' TODO: Have to understand IP Info
        ' Step 4: Get LicenseID
        Dim objSMSXLM As New Portal.BLL.SMSXLicenseManagement
        objSMSXLM.StoreNo = StoreNumber
        objSMSXLM.ClientID = ClientID
        Dim LicenseID As Integer = objSMSXLM.CheckAdditinalAvailability(ClientID, StoreNumber)
        If LicenseID < 0 Then
            Return False
        End If

        Dim tempID As Integer 'To tempoarary hold ID
        Dim TerminalIDs As String = String.Empty
        Try
            Dim i As Integer = 0
            For i = 1 To Quantity
                Dim objSMSXLMs As New Portal.BLL.SMSXLicenseManagement
                objSMSXLMs.TerminalName = TerminalName
                objSMSXLMs.InVoiceNo = InvoiceNumber 'txtInvoiceNo.Text.Trim()
                objSMSXLMs.IssuedByID = IssuedByID 'CInt(Session("AdminID"))
                objSMSXLMs.LicenseID = LicenseID 'CInt(LicenseID)
                objSMSXLMs.TerminalType = TerminalType
                tempID = objSMSXLMs.AddSMSXLicenseTerminals()
                TerminalIDs = TerminalIDs & tempID.ToString() & ","
            Next
            TerminalIDs = TerminalIDs.Substring(0, TerminalIDs.Length - 1)

            'Step 5: Update LicenseManagement
            Dim objSMSXLicenseManagement As New Portal.BLL.SMSXLicenseManagement
            objSMSXLicenseManagement.UpdateSMSXLicenseLog(IssuedByID, LicenseID, Notes)

            AddActivity(objSMSXLM.StoreNo, LicenseID, objSMSXLM.StoreNick, objSMSXLM.ClientID, IssuedByID)


            ' Step 6: Get License Details in Data set to update sms DB via webservice
            ' Setting up the security code 
            Dim securityCode2 As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(LicenseID)
            dsLicenseDetail.DataSetName = "SMSXLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode2), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            'Update the details in the sms db via webservice.
            Dim objSMSWebservice As New se.PortalServices
            Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))

            SendMail(LicenseID, TerminalIDs, TerminalType)

        Catch ex As Exception

	    If ex.InnerException Is Nothing Then
                ErrorLogger.AddError(ex.ToString(), ex.StackTrace, ex.Source, ex.TargetSite.Name, HttpContext.Current.Request.UserAgent, HttpContext.Current.Request.UserHostAddress, "")
            Else
                ErrorLogger.AddError(ex.InnerException.ToString(), ex.InnerException.StackTrace, ex.InnerException.Source, ex.InnerException.TargetSite.Name, HttpContext.Current.Request.UserAgent, HttpContext.Current.Request.UserHostAddress, "")
            End If

            Return False
        End Try
        Return True
    End Function


    Sub AddActivity(ByVal StoreNo As String, ByVal LicenseId As Integer, ByVal StoreName As String, ByVal ClientID As Integer, ByVal IssuedByID As Integer)
        ''Dim objTicketsBLL As New Portal.BLL.PM.PM_Ticket_Features
        Dim strTerminals As New StringBuilder

        Dim DrTerminalDetail As SqlClient.SqlDataReader = Nothing
        Try
            Portal.BLL.SMSXLicenseManagement.GetAllSMSXLicensesTerminalForEmailByLicienceIDForActivity(LicenseId)
            strTerminals.Append("<table style='border: 2px solid #17415a' cellpadding='0' cellspacing='0'>")
        strTerminals.Append("<tr>")
        strTerminals.Append("<td style='position:relative;height:20px;padding-right:3px;padding-left:3px;font-size:10px;font-weight:bold;border-bottom:1px solid #9bb8c6;border-right:1px solid #9bb8c6;background-color:#dbedf9;text-align:left;'>Terminal Name</td>")
        strTerminals.Append("<td style='position:relative;height:20px;padding-right:3px;padding-left:3px;font-size:10px;font-weight:bold;border-bottom:1px solid #9bb8c6;border-right:1px solid #9bb8c6;background-color:#dbedf9;text-align:left;'>Activation Key</td>")
        strTerminals.Append("<td style='position:relative;height:20px;padding-right:3px;padding-left:3px;font-size:10px;font-weight:bold;border-bottom:1px solid #9bb8c6;border-right:1px solid #9bb8c6;background-color:#dbedf9;text-align:left;'>Installation Key</td>")
        strTerminals.Append("</tr>")
        While DrTerminalDetail.Read
            strTerminals.Append("<tr>")
            strTerminals.Append("<td style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-weight:bold;font-size:10px;'>" & DrTerminalDetail("TerminalName") & "</td>")
            strTerminals.Append("<td style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-weight:bold;font-size:10px;'>" & DrTerminalDetail("GUID_Activation") & "</td>")
            strTerminals.Append("<td style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-weight:bold;font-size:10px;'>" & DrTerminalDetail("GUID_Installation") & "</td>")
            strTerminals.Append("</tr>")
        End While
        'strTerminals.Append("</table> <br>")

        Catch ex As Exception
        Finally
            If Not DrTerminalDetail Is Nothing Then
                If Not DrTerminalDetail.IsClosed Then
                    DrTerminalDetail.Close()
                End If
            End If
        End Try
	strTerminals.Append("</table> <br>")

        Dim drFranchises As SqlDataReader = Nothing
        Dim FranchiseID As Integer = 0
        Dim FranchiseContactID As Integer = 0
        Try
            drFranchises = Portal.BLL.SMSXLicenseManagement.GETSMSXFranchiseIDByStoreNumber(StoreNo, ClientID)
        If drFranchises.Read Then
            FranchiseID = drFranchises("FranchiseId")
            FranchiseContactID = drFranchises("FranchiseContactsID")
        End If
        drFranchises.Close()
        Catch ex As Exception
        Finally
            If Not drFranchises Is Nothing Then
                If Not drFranchises.IsClosed Then
                    drFranchises.Close()
                End If
            End If
        End Try
        Dim ObjectActivity As New Portal.BLL.Activities
        Dim ActivityID As Integer = 0
        With ObjectActivity
            .Subject = ConfigurationManager.AppSettings("SMS-XSubject")
            .Type = Portal.BLL.Enumeration.ActivityType.Installation
            .SubType = Portal.BLL.Enumeration.ActivitySubType.Installation
            .TimeSpent = TimeSpan.Zero
            .FranchiseID = 0 'CInt(hdnFranchiseID.Value)
            .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
            .Description = "<strong>" & ConfigurationManager.AppSettings("SMS-XDescription") & "</strong><br><br>" & strTerminals.ToString
            .ActivityDate = DateTime.Now
            .ActivityState = Portal.BLL.Enumeration.ActivityState.NotStarted
            .RelatedTo = Portal.BLL.Enumeration.NSProductIDs.SMS_X
            'If .RelatedTo = NotApplicable Then
            .ModuleId = Portal.BLL.Enumeration.Modules.Installation
            'Else
            '    .ModuleId = hdnSelectedModule.Value
            'End If
            .WaitingFor = "0"
            .Status = False
            .AdminInboxStatus = 0          'Making it closed in admin inbox status and status as closed.
            .PlacedBy = Portal.BLL.Enumeration.PlacedBy.PortalAdmin
            '.UserID = CInt(Session("AdminID"))
            .UserID = IssuedByID
            .FranchiseContactID = FranchiseContactID ' Portal.BLL.Enumeration.C
            .ClientContactID = 0
            .Priority = Portal.BLL.Enumeration.ActivityPriority.Minimal
            .ClientID = Portal.BLL.Enumeration.ClientID.EA
            .Charge = False
            .FranchiseID = FranchiseID
            .ActivitiesAdd(ObjectActivity)
        End With

    End Sub

    Public Sub SendMail(ByVal LicenseID As Integer, ByVal TerminalIDs As String, ByVal TerminalType As Byte)
        Dim GetStartedFilePath As String = String.Empty
        Dim Subject As String = String.Empty
        If TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.FruitExpert Then
            Subject = "Fruit Expert License Information"
            GetStartedFilePath = Server.MapPath("~/templates/Getting Started with Fruit Expert.pdf")
        ElseIf TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxOrderingApp Then
            Subject = "Ordering App License Information"
            GetStartedFilePath = Server.MapPath("~/templates/Getting Started with Fruit Expert.pdf")
        ElseIf TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxDeliveryApp Then
            Subject = "Delivey App License Information"
            GetStartedFilePath = Server.MapPath("~/templates/Getting Started with Fruit Expert.pdf")

        End If
        Dim strEmailName As String = String.Empty
        Dim strText As String = GetLetterText(TerminalType)
        Dim strKeys As New StringBuilder
        'Dim DrEmail As SqlClient.SqlDataReader = Portal.BLL.SMSXLicenseManagement.GetAllSMSXLicensesTerminalForEmailByLicienceID(LicenseID)
        Dim DrEmail As SqlClient.SqlDataReader = Nothing
        Try
            DrEmail = Portal.BLL.SMSXLicenseManagement.GetActivationKeysByTerminalIDs(TerminalIDs)
            While DrEmail.Read
                strEmailName = DrEmail("CorporateEmail")
                strKeys.Append("<tr><td style='background-color: #EFEFEF; padding: 4px 10px; border-top: 1px solid #DFDFDF;'>" & DrEmail("GUID_Activation") & "</td></tr>")
            End While
        Catch ex As Exception
        Finally
            If Not DrEmail Is Nothing Then
                If DrEmail.IsClosed = False Then
                    DrEmail.Close()
                End If
            End If
        End Try
        strText = strText.Replace("<!--***Keys***-->", strKeys.ToString)
        If Functions.IsValidEmail(strEmailName) Then
        Dim objEmail As New Portal.BLL.Email
            objEmail.DisplayName = "Netsolace Support" 'Session("Admin_Name")
            objEmail.MailTo = strEmailName
            objEmail.MailBCC = "mali@broadpeakit.com"
            objEmail.MailFrom = "support@netsolace.com"
            objEmail.Subject = Subject
            objEmail.Detail = strText
            '.Attachments = Server.MapPath("~/templates/Getting Started with Fruit Expert.pdf")
            If TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.FruitExpert Then
                objEmail.FileOne = GetStartedFilePath
            End If
            objEmail.Send_mail()
            objEmail = Nothing
        End If

    End Sub

    Private Function GetLetterText(ByVal TerminalType As Byte) As String
        Dim objStreamReader As IO.StreamReader
        Dim strReturn As String = String.Empty
        Dim mailtemplatePath As String = String.Empty
        If TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.FruitExpert Then
            mailtemplatePath = Server.MapPath("~/templates/FELicenseEmail.htm")
        ElseIf TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxOrderingApp Then
            mailtemplatePath = Server.MapPath("~/templates/OrderingAppLicenseEmail.htm")
        ElseIf TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxDeliveryApp Then
            mailtemplatePath = Server.MapPath("~/templates/FELicenseEmail.htm")
        End If
        If IO.File.Exists(mailtemplatePath) Then
            strReturn = IO.File.ReadAllText(mailtemplatePath)
        End If
        Return strReturn
    End Function
    <WebMethod()> _
    Public Function AddDCLicence(ByVal securityCode As String, _
                                    ByVal sStoreNumber As String, _
                                    ByVal InvoiceNumber As String, ByVal Notes As String) As Boolean
        ' Verify Security code before any further processing
        If String.IsNullOrEmpty(securityCode) Or securityCode <> "M@rket$DCLincen$E@2013" Then
            Return False
        End If

        Dim StoreNumber As Integer = CType(Functions.DecryptData(sStoreNumber), Integer)
        Dim invoiceNo As String = InvoiceNumber
        Dim _notes As String = Notes
        ' Default Values
        ' will always be 1 for EA
        Dim ClientID As Integer = 1
        Dim IssuedByID As Integer = 98 ' Asked to put it hard coded by Usman



        Dim objLM As New Portal.BLL.LicenseManagementDC
        Dim returnVal As Integer = 0
        objLM.InVoiceNo = invoiceNo
        objLM.ClientID = ClientID
        objLM.ProductID = Portal.BLL.Enumeration.NSProductIDs.DC
        objLM.StoreNo = StoreNumber
        objLM.IsTrainingActive = False
        objLM.Notes = _notes.Trim()
        objLM.IssuedByID = IssuedByID
        objLM.CurrentVersion = ConfigurationManager.AppSettings("digitalCatalogVersion")
        'If static ip is selected then we are going to save static ip
        'Other wise dynamic ip will be used for a particular date.
        objLM.SystemIP = String.Empty
        objLM.IsDynamicIP = True
        objLM.DynamicIPEndDate = Date.Now().AddYears(2)

        returnVal = objLM.AddNextStepLicense()

        If (returnVal > 0) Then
            Dim objDC As New Portal.BLL.LicenseManagementDC
            SendDCMail(returnVal)
            Return True
        Else
            Return False
        End If
    End Function
    Private Sub SendDCMail(ByVal LicenseID As Integer)
        Dim strEmailName As String = String.Empty
        Dim strText As String = GetDCLetterText()
        Dim strKeys As New StringBuilder
        Dim objLicence As New Portal.BLL.LicenseManagementDC
        Dim objDCLicence As Portal.BLL.LicenseManagementDC
        objDCLicence = objLicence.GetNextStepLicenseDetail(LicenseID)

        strEmailName = objDCLicence.StoreEmail
        strKeys.Append("<tr><td style='background-color: #EFEFEF; padding: 4px 10px; border-top: 1px solid #DFDFDF;'>" & objDCLicence.RegistrationKey & "</td></tr>")


        strText = strText.Replace("<!--***Keys***-->", strKeys.ToString)
        Dim objEmail As New Portal.BLL.Email
        With objEmail
            .DisplayName = "Netsolace Support" 'Session("Admin_Name")
            .MailTo = strEmailName
            .MailBCC = "mali@broadpeakit.com"
            .MailFrom = "support@netsolace.com"
            .Subject = "Digital Flipbook License Information"
            .Detail = strText
            .Send_mail()
        End With

        objEmail = Nothing
    End Sub
    Private Function GetDCLetterText() As String
        Dim objStreamReader As IO.StreamReader
        Dim strReturn As String = String.Empty
        If IO.File.Exists(Server.MapPath("~/templates/DCLicenseEmail.htm")) Then
            objStreamReader = IO.File.OpenText(Server.MapPath("~/templates/DCLicenseEmail.htm"))
            strReturn = objStreamReader.ReadToEnd
            objStreamReader.Close()
        End If
        Return strReturn
    End Function

End Class