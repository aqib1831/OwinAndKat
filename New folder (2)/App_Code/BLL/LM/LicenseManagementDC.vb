Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.BLL
    Public Class LicenseManagementDC

#Region "Private Variables"
        Private _SBSUserID As Integer
        Private _ClientID As Integer
        Private _ClientName As String
        Private _ProductID As Integer
        Private _ProductName As String
        Private _StoreNo As Integer
        Private _StoreNick As String
        Private _StoreEmail As String
        Private _InVoiceNo As String
        Private _SystemName As String
        Private _SystemIP As String
        Private _CurrentIP As String
        Private _RegistrationKey As String
        Private _Notes As String
        Private _IssuedOn As DateTime
        Private _IssuedBy As String
        Private _UpdatedOn As DateTime
        Private _UpdatedBy As String
        Private _CurrentVersion As String
        Private _IsDynamicIP As Boolean
        Private _IsTrainingActive As Boolean
        Private _IsLicenseInActive As Boolean
        Private _LastSyncTime As String
        Private _IssuedByID As Integer
        Private _UpdatedByID As Integer
        Private _ApplicationToConnect As Integer
        Private _ApplicationToConnectName As String
        Private _IsSMSAppEnabled As Boolean
        Private _DynamicIPEndDate As DateTime
        Private _SystemID As String
#End Region

#Region "Public Properties"
        Public Property SBSUserID() As Integer
            Get
                Return _SBSUserID
            End Get
            Set(ByVal value As Integer)
                _SBSUserID = value
            End Set
        End Property
        Public Property ClientID() As Integer
            Get
                Return _ClientID
            End Get
            Set(ByVal value As Integer)
                _ClientID = value
            End Set
        End Property
        Public Property ClientName() As String
            Get
                Return _ClientName
            End Get
            Set(ByVal value As String)
                _ClientName = value
            End Set
        End Property
        Public Property ProductID() As Integer
            Get
                Return _ProductID
            End Get
            Set(ByVal value As Integer)
                _ProductID = value
            End Set
        End Property
        Public Property ProductName() As String
            Get
                Return _ProductName
            End Get
            Set(ByVal value As String)
                _ProductName = value
            End Set
        End Property
        Public Property StoreNo() As Integer
            Get
                Return _StoreNo
            End Get
            Set(ByVal value As Integer)
                _StoreNo = value
            End Set
        End Property
        Public Property StoreNick() As String
            Get
                Return _StoreNick
            End Get
            Set(ByVal value As String)
                _StoreNick = value
            End Set
        End Property
        Public Property StoreEmail() As String
            Get
                Return _StoreEmail
            End Get
            Set(ByVal value As String)
                _StoreEmail = value
            End Set
        End Property
        Public Property InVoiceNo() As String
            Get
                Return _InVoiceNo
            End Get
            Set(ByVal value As String)
                _InVoiceNo = value
            End Set
        End Property
        Public Property SystemName() As String
            Get
                Return _SystemName
            End Get
            Set(ByVal value As String)
                _SystemName = value
            End Set
        End Property
        Public Property SystemIP() As String
            Get
                Return _SystemIP
            End Get
            Set(ByVal value As String)
                _SystemIP = value
            End Set
        End Property
        Public Property CurrentIP() As String
            Get
                Return _CurrentIP
            End Get
            Set(ByVal value As String)
                _CurrentIP = value
            End Set
        End Property
        Public Property IsDynamicIP() As Boolean
            Get
                Return _IsDynamicIP
            End Get
            Set(ByVal value As Boolean)
                _IsDynamicIP = value
            End Set
        End Property
        Public Property Notes() As String
            Get
                Return _Notes
            End Get
            Set(ByVal value As String)
                _Notes = value
            End Set
        End Property
        Public Property IssuedBy() As String
            Get
                Return _IssuedBy
            End Get
            Set(ByVal value As String)
                _IssuedBy = value
            End Set
        End Property
        Public Property IssuedByID() As Integer
            Get
                Return _IssuedByID
            End Get
            Set(ByVal value As Integer)
                _IssuedByID = value
            End Set
        End Property
        Public Property IssuedOn() As DateTime
            Get
                Return _IssuedOn
            End Get
            Set(ByVal value As DateTime)
                _IssuedOn = value
            End Set
        End Property
        Public Property CurrentVersion() As String
            Get
                Return _CurrentVersion
            End Get
            Set(ByVal value As String)
                _CurrentVersion = value
            End Set
        End Property
        Public Property UpdatedOn() As DateTime
            Get
                Return _UpdatedOn
            End Get
            Set(ByVal value As DateTime)
                _UpdatedOn = value
            End Set
        End Property
        Public Property UpdatedBy() As String
            Get
                Return _UpdatedBy
            End Get
            Set(ByVal value As String)
                _UpdatedBy = value
            End Set
        End Property
        Public Property IsLicenseInActive() As Boolean
            Get
                Return _IsLicenseInActive
            End Get
            Set(ByVal value As Boolean)
                _IsLicenseInActive = value
            End Set
        End Property
        Public Property IsTrainingActive() As Boolean
            Get
                Return _IsTrainingActive
            End Get
            Set(ByVal value As Boolean)
                _IsTrainingActive = value
            End Set
        End Property
        Public Property RegistrationKey() As String
            Get
                Return _RegistrationKey
            End Get
            Set(ByVal value As String)
                _RegistrationKey = value
            End Set
        End Property
        Public Property LastSyncTime() As String
            Get
                Return _LastSyncTime
            End Get
            Set(ByVal value As String)
                _LastSyncTime = value
            End Set
        End Property
        Public Property UpdatedByID() As Integer
            Get
                Return _UpdatedByID
            End Get
            Set(ByVal value As Integer)
                _UpdatedByID = value
            End Set
        End Property
        Public Property ApplicationToConnect() As Integer
            Get
                Return _ApplicationToConnect
            End Get
            Set(ByVal value As Integer)
                _ApplicationToConnect = value
            End Set
        End Property
        Public Property ApplicationToConnectName() As String
            Get
                Return _ApplicationToConnectName
            End Get
            Set(ByVal value As String)
                _ApplicationToConnectName = value
            End Set
        End Property
        Public Property IsSMSAppEnabled() As Boolean
            Get
                Return _IsSMSAppEnabled
            End Get
            Set(ByVal value As Boolean)
                _IsSMSAppEnabled = value
            End Set
        End Property
        Public Property DynamicIPEndDate() As DateTime
            Get
                Return _DynamicIPEndDate
            End Get
            Set(ByVal value As DateTime)
                _DynamicIPEndDate = value
            End Set
        End Property
        Public Property SystemID() As String
            Get
                Return _SystemID
            End Get
            Set(ByVal value As String)
                _SystemID = value
            End Set
        End Property
#End Region

#Region "Public Functions"

        Public Shared Function GetAllNextStepLicenses(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                               ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Return Portal.DAL.LicenseManagementDC.GetAllNextStepLicenses(search, clientId, inActive, stateId, sortBy, startRowIndex, maximumRows)
        End Function

        Public Shared Function GetAllNextStepLicensesCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer) As Integer
            Return Portal.DAL.LicenseManagementDC.GetAllNextStepLicensesCount(search, clientId, inActive, stateId)
        End Function
        '===================
        Public Shared Function GetAllNextStepLicenses_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                              ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal UserID As Integer) As DataTable
            Return Portal.DAL.LicenseManagementDC.GetAllNextStepLicenses_LM(search, clientId, inActive, stateId, sortBy, startRowIndex, maximumRows, UserID)
        End Function

        Public Shared Function GetAllNextStepLicensesCount_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal UserID As Integer) As Integer
            Return Portal.DAL.LicenseManagementDC.GetAllNextStepLicensesCount_LM(search, clientId, inActive, stateId, UserID)
        End Function
        '===================

        Public Function AddNextStepLicense() As Integer
            Dim objLM As New Portal.DAL.LicenseManagementDC
            Return objLM.AddNextStepLicense(Me)
        End Function

        Public Function GetNextStepLicenseDetail(ByVal sbsUserId As Integer) As Portal.BLL.LicenseManagementDC
            Dim objLM As New Portal.DAL.LicenseManagementDC
            Return objLM.GetNextStepLicenseDetail(sbsUserId)
        End Function

        Public Function UpdateLicenseDetail() As Integer
            Dim objLM As New Portal.DAL.LicenseManagementDC
            Return objLM.UpdateNextStepLicenseDetail(Me)
        End Function

        Public Shared Function GetAllNextStepLicensesForReporting(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String) As SqlDataReader
            Return Portal.DAL.LicenseManagementDC.GetAllNextStepLicensesForReporting(search, clientId, inActive, stateId, sortBy)
        End Function
        Public Shared Function GetAllNextStepLicensesForReporting_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, ByVal UserID As Integer) As SqlDataReader
            Return Portal.DAL.LicenseManagementDC.GetAllNextStepLicensesForReporting_LM(search, clientId, inActive, stateId, sortBy, UserID)
        End Function

        Public Shared Function GetLicenseKeyBySystemIDStoreID(ByVal storeNumber As Integer, ByVal MACAdress As String, ByVal clientId As Integer) As String
            Return Portal.DAL.LicenseManagementDC.GetLicenseKeyBySystemIDStoreID(storeNumber,MACAdress,clientId)
        End Function
        Public Shared Function GetStoreLicensesCount(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Return Portal.DAL.LicenseManagementDC.GetStoreLicensesCount(StoreNumber,ClientID)
        End Function

        Public Function CheckAdditinalAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Return Portal.DAL.LicenseManagementDC.GetStoreLicensesCount(ClientID,StoreNo)
        End Function
        Public Shared Function AddDCLicenseTerminals(ByVal MACAdress As String, ByVal ClinetID As Integer, ByVal StoreNumber As Integer,ByVal InVoiceNo  As String, ByVal IssuedByID As Integer) As String 
            Return Portal.DAL.LicenseManagementDC.AddDCLicenseTerminals(MACAdress,ClinetID,StoreNumber,InVoiceNo,IssuedByID)
        End Function
#End Region
    End Class
End Namespace