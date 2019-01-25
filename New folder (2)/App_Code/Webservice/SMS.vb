Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports System.Web.HttpUtility

<WebService(Namespace:="https://qa.netsolace.com/portal/WebServices")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class SMS
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function GetModifiedSMSXLicenses(ByVal securityCode As String, ByVal lastSynchDate As DateTime) As Byte()
        If Not String.IsNullOrEmpty(securityCode) Then
            securityCode = Functions.DecryptString128Bit(UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))
            If securityCode = ConfigurationManager.AppSettings("SMSServiceAuthCode") Then
                Dim objSMSXLM As New Portal.DAL.SMSXLicenseManagement
                Dim ds As DataSet = objSMSXLM.GetAllSMSLicensesModified(lastSynchDate)
                Portal.DAL.WebServiceLog.Add(Portal.BLL.Enumeration.ProductNames.SMSX, "GetModifiedSMSXLicenses")
                'ErrorLogger.AddError("Checking Data", ConvertDataSetToXML(ds), "", "GetModifiedSMSXLicenses", "", "", "")
                If ds IsNot Nothing Then Return Functions.CompressDataSet(ds)
            End If
        End If
        Return Nothing
    End Function

    <WebMethod()> _
    Public Function UpdateModifiedSMSXLicenses(ByVal securityCode As String, ByVal data() As Byte) As Integer
        If Not String.IsNullOrEmpty(securityCode) Then
            Dim result As Integer = Integer.MinValue
            securityCode = Functions.DecryptString128Bit(UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))
            If securityCode = ConfigurationManager.AppSettings("SMSServiceAuthCode") Then
                Dim ds As DataSet = Functions.DecompressDataSet(data)
                'ErrorLogger.AddError("Checking Updated Data", ConvertDataSetToXML(ds), "", "UpdateModifiedSMSXLicenses", "", "", "")
                If ds IsNot Nothing Then
                    Try
                        Dim objSMSXLM As New Portal.DAL.SMSXLicenseManagement
                        result = objSMSXLM.UpdateLicenseDetails(ds)
                        Portal.DAL.WebServiceLog.Add(Portal.BLL.Enumeration.ProductNames.SMSX, "UpdateModifiedSMSXLicenses")
                    Catch ex As Exception
                        ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateModifiedSMSXLicenses", String.Empty, String.Empty, ds.GetXml().ToString())
                    End Try
                    Return result
                End If
            End If
        End If
        Return Nothing
    End Function

    Public Function ConvertDataSetToXML(ByVal xmlDS As DataSet) As String
        Dim stream As IO.MemoryStream = Nothing
        Dim writer As System.Xml.XmlTextWriter = Nothing
        Try
            stream = New IO.MemoryStream()
            ' Load the XmlTextReader from the stream
            writer = New System.Xml.XmlTextWriter(stream, Encoding.Unicode)
            ' Write to the file with the WriteXml method.
            xmlDS.WriteXml(writer)
            Dim count As Integer = CInt(stream.Length)
            Dim arr As Byte() = New Byte(count - 1) {}
            stream.Seek(0, IO.SeekOrigin.Begin)
            stream.Read(arr, 0, count)
            Dim utf As New UnicodeEncoding()
            Return utf.GetString(arr).Trim()
        Catch
            Return [String].Empty
        Finally
            If writer IsNot Nothing Then
                writer.Close()
            End If
        End Try
    End Function  

<WebMethod()> _
    Public Function AddLicenseTerminal(ByVal securityCode As String, ByVal StoreNumber As String, ByVal TerminalType As Integer) As Integer
        Try
            If String.IsNullOrEmpty(securityCode) = False And securityCode = ConfigurationManager.AppSettings("SMSServiceAuthCode") Then
                Dim ClientID As Integer = 1
                Dim IssuedByID As Integer = 98
                securityCode = Functions.DecryptString128Bit(UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))
                'StoreNumber = Functions.DecryptString128Bit(StoreNumber, ConfigurationManager.AppSettings("128BitDecryptionKey"))

                'If TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.FruitExpert Then
                'TerminalName = "Fruit Expert"
                'ElseIf TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxOrderingApp Then
                '   TerminalName = "SMSx Ordering App"
                'Else
                ' If terminal type is delivery app then continu process else stop
                Dim TerminalName As String = String.Empty
                If String.IsNullOrEmpty(TerminalType.ToString()) Then
                    TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxDeliveryApp
                End If
                If TerminalType = Portal.BLL.Enumeration.SMSxTerminalType.SMSxDeliveryApp Then
                    TerminalName = "SMSx Delivery App"
                Else
                    Return 0
                    Exit Function
                End If
                ' If Store have any inactive license the stop process
                Dim LicenseCount As Integer = 0
                LicenseCount = Portal.BLL.SMSXLicenseManagement.GetStoreLicensesCount(StoreNumber, ClientID)
                If LicenseCount > 0 Then
                    Return 0
                    Exit Function
                End If
                'If store does not have any active license then stop process
                Dim objSMSXLM As New Portal.BLL.SMSXLicenseManagement
                objSMSXLM.StoreNo = StoreNumber
                objSMSXLM.ClientID = ClientID
                Dim LicenseID As Integer = objSMSXLM.CheckAdditinalAvailability(ClientID, StoreNumber)
                If LicenseID < 0 Then
                    Return 0
                    Exit Function
                End If
                ' Add terminal
                Dim objSMSXLMs As New Portal.BLL.SMSXLicenseManagement
                objSMSXLMs.TerminalName = TerminalName
                objSMSXLMs.InVoiceNo = "0000"
                objSMSXLMs.IssuedByID = IssuedByID 'CInt(Session("AdminID"))
                objSMSXLMs.LicenseID = LicenseID 'CInt(LicenseID)
                objSMSXLMs.TerminalType = TerminalType
                objSMSXLMs.AddSMSXLicenseTerminals()
                ' Log Chnages
                Dim objSMSXLicenseManagement As New Portal.BLL.SMSXLicenseManagement
                objSMSXLicenseManagement.UpdateSMSXLicenseLog(IssuedByID, LicenseID, "Auto Generate " & TerminalName & " Terminal for Store:" & StoreNumber.ToString())
                ' Make securitycode, dataset to push To SMS Server
                Dim securityCode2 As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
                Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(LicenseID)
                dsLicenseDetail.DataSetName = "SMSXLicense"
                dsLicenseDetail.Tables(0).TableName = "License"
                dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
                securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode2), ConfigurationManager.AppSettings("128BitDecryptionKey"))

                'Update the details in the sms db via webservice.
                Dim objSMSWebservice As New se.PortalServices
                Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                Return 1
                Exit Function
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddLicenseTerminal", String.Empty, String.Empty, String.Empty)
            Return -1
        End Try
        Return 0
    End Function

End Class