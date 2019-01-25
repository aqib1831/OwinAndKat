Imports Microsoft.VisualBasic
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Portal.Utility
Imports System.Data
Imports System.Web.Script.Serialization
Imports System.Collections.Generic

<WebService(Namespace:="https://www.netsolace.com/portal/WebServices")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class NSClient
    Inherits System.Web.Services.WebService
    <WebMethod()> _
    Public Function GetSettingsByCodeAndAppIdentifier(ByVal CompanyCode As String, ByVal AppIdentifier As String) As String
        Dim retVal As String = "False"
        Try
            If String.IsNullOrEmpty(CompanyCode) = False And String.IsNullOrEmpty(AppIdentifier) = False Then
                Dim db As New DbManager
                CompanyCode = DecryptValue(CompanyCode)
                AppIdentifier = DecryptValue(AppIdentifier)
                db.AddParameter("@CompanyCode", CompanyCode)
                db.AddParameter("@AppIdentifier", AppIdentifier)
                Dim dt As DataTable = db.ExecuteDataTable("ClientApp_GetByCompanyCodeAndAppIdentifier")
                If dt.Rows.Count > 0 Then
                    Dim row As DataRow = dt.Rows(0)
                    Dim objClientApp As New ClientApp
                    objClientApp.clientId = Functions.IfNull(row("ClientId"), 0)
                    objClientApp.clientCode = Functions.IfNull(row("ClientCode"), String.Empty)
                    objClientApp.companyCode = Functions.IfNull(row("CompanyCode"), String.Empty)
                    objClientApp.companyName = Functions.IfNull(row("CompanyName"), String.Empty)
                    objClientApp.appIdentifier = Functions.IfNull(row("AppIdentifier"), String.Empty)
                    objClientApp.appName = Functions.IfNull(row("AppName"), String.Empty)
                    objClientApp.serviceEncryptionKey = Functions.IfNull(row("ServiceEncryptionKey"), String.Empty)
                    objClientApp.serviceURL = Functions.IfNull(row("ServiceURL"), String.Empty)
                    objClientApp.customAttributes = Functions.IfNull(row("CustomAttributes"), String.Empty)
                    retVal = New System.Web.Script.Serialization.JavaScriptSerializer().Serialize(objClientApp)
                    retVal = EncryptValue(retVal)
                    Dim objDict As New System.Collections.Generic.Dictionary(Of String, String)
                    objDict.Add("result", retVal)
                    retVal = New System.Web.Script.Serialization.JavaScriptSerializer().Serialize(objDict)
                End If
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "NSClient-GetByCodeAndAPPID", String.Empty, String.Empty, String.Empty)
            Return "False"
            Exit Function
        End Try
        Return retVal
    End Function



    <WebMethod()> _
    Public Function GetVersionUpdates(ByVal appVersion As String, ByVal appID As String, ByVal AppType As Integer) As String

        Dim retVal As String = "False"
        Dim lstversiondata As New Generic.List(Of Object)

        Try
            If String.IsNullOrEmpty(appVersion) = False And String.IsNullOrEmpty(appID) = False Then
                Dim db As New DbManager
                appVersion = DecryptValue(appVersion)
                appID = DecryptValue(appID)
                db.AddParameter("@AppVersion", appVersion)
                db.AddParameter("@AppID", appID)
                db.AddParameter("@AppType", AppType)


                Dim dt As DataTable = db.ExecuteDataTable("ClientApp_GetGetVersionUpdates")
                For Each r As DataRow In dt.Rows
                    Dim objVersionUpdates As New VersionUpdates
                    objVersionUpdates.AppID = Functions.IfNull(r("AppId"), 0)
                    objVersionUpdates.AppType = Functions.IfNull(r("AppType"), 0)
                    objVersionUpdates.Version = Functions.IfNull(r("version"), String.Empty)
                    objVersionUpdates.IsForceUpdate = Functions.IfNull(r("IsForceUpdate"), 0)
                    objVersionUpdates.CreatedDate = Functions.IfNull(r("CreatedDate"), String.Empty)
                    objVersionUpdates.Notes = Functions.IfNull(r("Notes"), String.Empty)
                    lstversiondata.Add(objVersionUpdates)
                Next

                Dim jSerializer As New JavaScriptSerializer
                retVal = jSerializer.Serialize(lstversiondata)
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "NSClient-GetByCodeAndAPPID", String.Empty, String.Empty, String.Empty)
            Return ex.Message
            Exit Function
        End Try
        Return retVal
    End Function

    
    
    Private Function EncryptValue(ByVal inputVal As String) As String
        Try
            Dim AESEncryption_SECRET_KEY As String = ConfigurationManager.AppSettings("AESEncryptionSecretKey")
            If Not inputVal = String.Empty Then
                Dim encryptor As New AESEncryption.Encryptor()
                inputVal = encryptor.Encrypt(inputVal, AESEncryption_SECRET_KEY)
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return inputVal
    End Function


    'this method is used to decrypt the input value using AES Encryption.
    'Developer Notes : this method is declared as public because it is also accessible from imageUpload_mobile.ashx (To decrypt adminID and contactID for image uploading of ZEE/ZOR)
    Private Function DecryptValue(ByVal inputVal As String) As String
        Try
            Dim AESEncryption_SECRET_KEY As String = ConfigurationManager.AppSettings("AESEncryptionSecretKey")
            If Not inputVal = String.Empty Then
                Dim decryptor As New AESEncryption.Decryptor()
                inputVal = decryptor.Decrypt(inputVal, AESEncryption_SECRET_KEY)
            End If
        Catch ex As Exception
            Throw ex
        End Try
        Return inputVal
    End Function

End Class
Public Class ClientApp
    Private _clientId As Integer = 0
    Private _clientCode As String = String.Empty
    Private _companyCode As String = String.Empty
    Private _companyName As String = String.Empty
    Private _appIdentifier As String = String.Empty
    Private _appName As String = String.Empty
    Private _serviceEncryptionKey As String = String.Empty
    Private _serviceURL As String = String.Empty
    Private _customAttributes As String = String.Empty

    Public Property clientId() As Integer
        Get
            Return _clientId
        End Get
        Set(ByVal value As Integer)
            _clientId = value
        End Set
    End Property
    Public Property clientCode() As String
        Get
            Return _clientCode
        End Get
        Set(ByVal value As String)
            _clientCode = value
        End Set
    End Property
    Public Property companyCode() As String
        Get
            Return _companyCode
        End Get
        Set(ByVal value As String)
            _companyCode = value
        End Set
    End Property
    Public Property companyName() As String
        Get
            Return _companyName
        End Get
        Set(ByVal value As String)
            _companyName = value
        End Set
    End Property
    Public Property appIdentifier() As String
        Get
            Return _appIdentifier
        End Get
        Set(ByVal value As String)
            _appIdentifier = value
        End Set
    End Property
    Public Property appName() As String
        Get
            Return _appName
        End Get
        Set(ByVal value As String)
            _appName = value
        End Set
    End Property
    Public Property serviceEncryptionKey() As String
        Get
            Return _serviceEncryptionKey
        End Get
        Set(ByVal value As String)
            _serviceEncryptionKey = value
        End Set
    End Property
    Public Property serviceURL() As String
        Get
            Return _serviceURL
        End Get
        Set(ByVal value As String)
            _serviceURL = value
        End Set
    End Property
    Public Property customAttributes() As String
        Get
            Return _customAttributes
        End Get
        Set(ByVal value As String)
            _customAttributes = value
        End Set
    End Property
End Class


Public Class VersionUpdates
    Private _appID As Integer = 0
    Private _AppType As Integer = 0
    Private _Version As String = String.Empty
    Private _IsForceUpdate As String = String.Empty
    Private _CreatedDate As String = String.Empty
    Private _Notes As String = String.Empty



    Public Property Notes() As String
        Get
            Return _Notes
        End Get
        Set(ByVal value As String)
            _Notes = value
        End Set
    End Property


    Public Property CreatedDate() As String
        Get
            Return _CreatedDate
        End Get
        Set(ByVal value As String)
            _CreatedDate = value
        End Set
    End Property

    Public Property IsForceUpdate() As String
        Get
            Return _IsForceUpdate
        End Get
        Set(ByVal value As String)
            _IsForceUpdate = value
        End Set
    End Property

    Public Property Version() As String
        Get
            Return _Version
        End Get
        Set(ByVal value As String)
            _Version = value
        End Set
    End Property

    Public Property AppType() As Integer
        Get
            Return _AppType
        End Get
        Set(ByVal value As Integer)
            _AppType = value
        End Set
    End Property

    Public Property AppID() As Integer
        Get
            Return _appID
        End Get
        Set(ByVal value As Integer)
            _appID = value
        End Set
    End Property


End Class
