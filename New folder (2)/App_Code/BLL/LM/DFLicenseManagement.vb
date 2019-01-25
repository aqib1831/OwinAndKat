Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL
    Public Class DFLicenseManagement

#Region "Private Variables"
        Private _SBSUserID As Integer
        Private _ClientID As Integer
        Private _FranchiseID As Integer
        Private _ClientName As String
        Private _ProductID As Integer
        Private _ProductName As String
        Private _StoreNo As Integer
        Private _StoreNick As String
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
        Private _LicenseID As Integer
        Private _GuidInstallation As String
        Private _GuidActivation As String
        Private _SystemID As String
        Private _TerminalName As String
        Private _NoOfterminals As Integer
        Private _NoOfLiveterminals As Integer
        Private _LastUpdatedBy As String
        Private _UserID As Integer
        Private _Changes As String
        Private _LicenseTerminalID As String
        Private _InstallationDate As DateTime



#End Region


#Region "Public Properties"
        Public Property UserID() As Integer
            Get
                Return _UserID
            End Get
            Set(ByVal value As Integer)
                _UserID = value
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
        Public Property FranchiseID() As Integer
            Get
                Return _FranchiseID
            End Get
            Set(ByVal value As Integer)
                _FranchiseID = value
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
        Public Property InVoiceNo() As String
            Get
                Return _InVoiceNo
            End Get
            Set(ByVal value As String)
                _InVoiceNo = value
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

        Public Property LicenseID() As Integer
            Get
                Return _LicenseID
            End Get
            Set(ByVal value As Integer)
                _LicenseID = value
            End Set
        End Property

        Public Property GuidInstallation() As String
            Get
                Return _GuidInstallation
            End Get
            Set(ByVal value As String)
                _GuidInstallation = value
            End Set
        End Property

        Public Property GuidActivation() As String
            Get
                Return _GuidActivation
            End Get
            Set(ByVal value As String)
                _GuidActivation = value
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

        Public Property SystemName() As String
            Get
                Return _SystemName
            End Get
            Set(ByVal value As String)
                _SystemName = value
            End Set
        End Property

        Public Property TerminalName() As String
            Get
                Return _TerminalName
            End Get
            Set(ByVal value As String)
                _TerminalName = value
            End Set
        End Property

        Public Property NoOfTerminals() As Integer
            Get
                Return _NoOfterminals
            End Get
            Set(ByVal value As Integer)
                _NoOfterminals = value
            End Set
        End Property

        Public Property NoOfLiveTerminals() As Integer
            Get
                Return _NoOfLiveterminals
            End Get
            Set(ByVal value As Integer)
                _NoOfLiveterminals = value
            End Set
        End Property

        Public Property LastUpdatedBy() As String
            Get
                Return _LastUpdatedBy
            End Get
            Set(ByVal value As String)
                _LastUpdatedBy = value
            End Set
        End Property

        Public Property Changes() As String
            Get
                Return _Changes
            End Get
            Set(ByVal value As String)
                _Changes = value
            End Set
        End Property

        Public Property LicenseTerminalID() As Integer
            Get
                Return _LicenseTerminalID
            End Get
            Set(ByVal value As Integer)
                _LicenseTerminalID = value
            End Set
        End Property
        Public Property InstallationDate() As DateTime
            Get
                Return _InstallationDate
            End Get
            Set(ByVal value As DateTime)
                _InstallationDate = value
            End Set
        End Property

#End Region

#Region "Public Function"

        Public Shared Function GetAllDFLicenses(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                              ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Return Portal.DAL.DFLicenseManagement.GetAllDFLicenses(search, clientId, inActive, stateId, sortBy, startRowIndex, maximumRows)
        End Function

        Public Shared Function GetAllDFLicensesCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer) As Integer
            Return Portal.DAL.DFLicenseManagement.GetAllDFLicensesCount(search, clientId, inActive, stateId)
        End Function
        '==============
        Public Shared Function GetAllDFLicenses_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                            ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal UserID As Integer) As DataTable
            Return Portal.DAL.DFLicenseManagement.GetAllDFLicenses_LM(search, clientId, inActive, stateId, sortBy, startRowIndex, maximumRows, UserID)
        End Function

        Public Shared Function GetAllDFLicensesCount_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal UserID As Integer) As Integer
            Return Portal.DAL.DFLicenseManagement.GetAllDFLicensesCount_LM(search, clientId, inActive, stateId, UserID)
        End Function
        Public Shared Function GetAllDFLicensesForReporting_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, ByVal UserID As Integer) As DataTable

            Return Portal.DAL.DFLicenseManagement.GetAllSMXLicensesForReporting_LM(search, clientId, inActive, stateId, sortBy, UserID)
        End Function
        '==============

        Public Shared Function GetStoreLicensesCount(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Return Portal.DAL.DFLicenseManagement.GetStoreLicensesCount(StoreNumber, ClientID)
        End Function

        Public Shared Function GetAllDFLicensesForReporting(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String) As DataTable
            Return Portal.DAL.DFLicenseManagement.GetAllSMXLicensesForReporting(search, clientId, inActive, stateId, sortBy)
        End Function

        Public Function CheckSystemIPAvailability(ByVal StaticIP As String, ByVal LicensesID As Integer)
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.CheckSystemIPAvailability(StaticIP, LicensesID)
        End Function

        Public Function CheckBundleAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.CheckBundleAvailability(clientID, StoreNo)
        End Function

        Public Function AddDFLicense() As Integer
            Dim objDfLicense As New Portal.DAL.DFLicenseManagement
            Return objDfLicense.AddSMSXLicense(Me)
        End Function



        Public Function AddDFLicenseTerminal() As Integer
            Dim objDfLicense As New Portal.DAL.DFLicenseManagement
            Return objDfLicense.AddDFLicenseTerminal(Me)
        End Function

        Public Function CheckAdditinalAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDfLicense As New Portal.DAL.DFLicenseManagement
            Return objDfLicense.CheckAdditinalAvailability(clientID, StoreNo)
        End Function

        Public Function CheckStaticIPAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal StaticIP As String) As Integer
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.CheckStaticIPAvailability(clientID, StoreNo, StaticIP)
        End Function

        Public Function CheckStaticIPExits(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.CheckStaticIPExits(clientID, StoreNo)
        End Function

        Public Function UpdateDFLicenseLog(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal Notes As String) As Boolean
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.UpdateDFLicenseLog(userID, LicenseID, Notes)
        End Function

        Public Function UpdateDynamicIPToStaticIP(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal StaticIP As String, ByVal Notes As String) As Boolean
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.UpdateDynamicIPToStaticIP(userID, LicenseID, StaticIP, Notes)
        End Function

        Public Shared Function GetAllDFLicensesTerminalByLicienceID(ByVal LicenseID As Integer) As DataTable
            Return Portal.DAL.DFLicenseManagement.GetAllDFLicensesTerminalByLicienceID(LicenseID)
        End Function

        Public Function GetDFLicenseDetail(ByVal licenseID As Integer) As Portal.BLL.DFLicenseManagement
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.GetDFLicenseDetail(licenseID)
        End Function

        Public Function UpdateDFLicenseDetail() As Integer
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.UpdateDFLicenseDetail(Me)
        End Function

        Public Function CheckSystemIPAvailabilitybyLicenseID(ByVal LicenseID As Integer, ByVal StaticIP As String)
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.CheckSystemIPAvailabilitybyLicenseID(LicenseID, StaticIP)
        End Function

        Public Shared Function GetActiveStoreLicensesCount(ByVal DF_LicenseID As Integer) As Integer
            Return Portal.DAL.DFLicenseManagement.GetActiveStoreLicensesCount(DF_LicenseID)
        End Function

        Public Sub AddDFLicenseTerminalLog()
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            objDFLicense.AddDFLicenseTerminalLog(Me)
        End Sub

        Public Function DF_RegenerateTerminalByID(ByVal ID As Integer, ByVal UpdatedUserID As Integer) As Integer
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Dim TId As Integer
            TId = objDFLicense.DF_RegenerateTerminalByID(ID, UpdatedUserID)
            Return TId
        End Function

        Public Shared Function GetAllDFLicensesTerminalForEmailByLicienceIDForActivity(ByVal LicenseID As Integer) As SqlDataReader
            Return Portal.DAL.DFLicenseManagement.GetAllDFLicensesTerminalForEmailByLicienceIDForActivity(LicenseID)
        End Function

        Public Shared Function GETDFFranchiseIDByStoreNumber(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As SqlDataReader
            Return Portal.DAL.SMSXLicenseManagement.GETSMSXFranchiseIDByStoreNumber(StoreNumber, ClientID)
        End Function

        Public Shared Function GETDFIP(ByVal ClientID As Integer, ByVal StoreNumber As Integer) As SqlDataReader
            Dim Dr As SqlDataReader
            Dr = Portal.DAL.DFLicenseManagement.GETDFIP(ClientID, StoreNumber)
            Return Dr
        End Function

        Public Function MakeInActiveTerminal(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.MakeInActiveTerminal(ID, UpdatedUserID)
        End Function

        Public Function MakeActive(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDFLicense As New Portal.DAL.DFLicenseManagement
            Return objDFLicense.MakeActive(ID, UpdatedUserID)
        End Function

        Public Shared Function DeleteDFLicense(ByVal ID As Integer) As Integer
            Dim objLMQs As New Portal.DAL.DFLicenseManagement
            Return DAL.DFLicenseManagement.DeleteDFLicense(ID)
        End Function
#End Region

    End Class
End Namespace