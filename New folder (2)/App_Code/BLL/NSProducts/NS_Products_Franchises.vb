Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_Products_Franchises
#Region " Private Members "
        Private _id As Integer
        Private _productid As Integer
        Private _franchiseid As Integer
        Private _ip As String
        Private _version As String
        Private _lastupdatedate As DateTime
        Private _serverusername As String
        Private _serverpassword As String
        Private _nooflicenses As Integer
        Private _ccpaymentgateway As Integer
        Private _ccmerchantid As Integer
        Private _ccmerchantpassword As String
        Private _onsupport As Boolean
        Private _supportstartdate As DateTime
        Private _supportenddate As DateTime
        Private _waivedmonths As Integer
        Private _noofliveterminals As Integer
        Private _updatedby As Integer
        Private _updatedon As DateTime
        Private _inactive As Boolean
        Private _notes As String
        Private _isstaticip As Boolean
        Private _price As Decimal

        Private _storenumber As Integer
        Private _storenick As String
        Private _clientcode As String
        Private _updatedbyname As String
        Private _productname As String
        Private _grandopening As Date
        Private _fransupportfranchiseid As Integer
        Private _clientid As Integer
		 Private _installationDate As DateTime
        Private _SMTPPort As Integer
        Private _OSVersionID As Integer


#End Region
#Region " Public Properties "

        Public Property ID() As Integer
            Get
                Return _id
            End Get
            Set(ByVal value As Integer)
                _id = value
            End Set
        End Property

        Public Property ProductID() As Integer
            Get
                Return _productid
            End Get
            Set(ByVal value As Integer)
                _productid = value
            End Set
        End Property

        Public Property FranchiseID() As Integer
            Get
                Return _franchiseid
            End Get
            Set(ByVal value As Integer)
                _franchiseid = value
            End Set
        End Property

        Public Property IP() As String
            Get
                Return _ip
            End Get
            Set(ByVal value As String)
                _ip = value
            End Set
        End Property

        Public Property Version() As String
            Get
                Return _version
            End Get
            Set(ByVal value As String)
                _version = value
            End Set
        End Property

        Public Property LastUpdateDate() As DateTime
            Get
                Return _lastupdatedate
            End Get
            Set(ByVal value As DateTime)
                _lastupdatedate = value
            End Set
        End Property

        Public Property ServerUserName() As String
            Get
                Return _serverusername
            End Get
            Set(ByVal value As String)
                _serverusername = value
            End Set
        End Property

        Public Property ServerPassword() As String
            Get
                Return _serverpassword
            End Get
            Set(ByVal value As String)
                _serverpassword = value
            End Set
        End Property

        Public Property NoOfLicenses() As Integer
            Get
                Return _nooflicenses
            End Get
            Set(ByVal value As Integer)
                _nooflicenses = value
            End Set
        End Property

        Public Property CCPaymentGateway() As Integer
            Get
                Return _ccpaymentgateway
            End Get
            Set(ByVal value As Integer)
                _ccpaymentgateway = value
            End Set
        End Property

        Public Property CCMerchantID() As Integer
            Get
                Return _ccmerchantid
            End Get
            Set(ByVal value As Integer)
                _ccmerchantid = value
            End Set
        End Property

        Public Property CCMerchantPassword() As String
            Get
                Return _ccmerchantpassword
            End Get
            Set(ByVal value As String)
                _ccmerchantpassword = value
            End Set
        End Property

        Public Property onSupport() As Boolean
            Get
                Return _onsupport
            End Get
            Set(ByVal value As Boolean)
                _onsupport = value
            End Set
        End Property

        Public Property SupportStartDate() As DateTime
            Get
                Return _supportstartdate
            End Get
            Set(ByVal value As DateTime)
                _supportstartdate = value
            End Set
        End Property

        Public Property SupportEnddate() As DateTime
            Get
                Return _supportenddate
            End Get
            Set(ByVal value As DateTime)
                _supportenddate = value
            End Set
        End Property

        Public Property WaivedMonths() As Integer
            Get
                Return _waivedmonths
            End Get
            Set(ByVal value As Integer)
                _waivedmonths = value
            End Set
        End Property

        Public Property NoOfLiveTerminals() As Integer
            Get
                Return _noofliveterminals
            End Get
            Set(ByVal value As Integer)
                _noofliveterminals = value
            End Set
        End Property


        Public Property UpdatedBy() As Integer
            Get
                Return _updatedby
            End Get
            Set(ByVal value As Integer)
                _updatedby = value
            End Set
        End Property

        Public Property UpdatedOn() As DateTime
            Get
                Return _updatedon
            End Get
            Set(ByVal value As DateTime)
                _updatedon = value
            End Set
        End Property

        Public Property Inactive() As Boolean
            Get
                Return _inactive
            End Get
            Set(ByVal value As Boolean)
                _inactive = value
            End Set
        End Property

        Public Property Notes() As String
            Get
                Return _notes
            End Get
            Set(ByVal value As String)
                _notes = value
            End Set
        End Property



        Public Property StoreNumber() As Integer
            Get
                Return _storenumber
            End Get
            Set(ByVal value As Integer)
                _storenumber = value
            End Set
        End Property

        Public Property StoreNick() As String
            Get
                Return _storenick
            End Get
            Set(ByVal value As String)
                _storenick = value
            End Set
        End Property

        Public Property ClientCode() As String
            Get
                Return _clientcode
            End Get
            Set(ByVal value As String)
                _clientcode = value
            End Set
        End Property

        Public Property UpdatedByName() As String
            Get
                Return _updatedbyname
            End Get
            Set(ByVal value As String)
                _updatedbyname = value
            End Set
        End Property
        Public Property IsStaticIP() As Boolean
            Get
                Return _isstaticip
            End Get
            Set(ByVal value As Boolean)
                _isstaticip = value
            End Set
        End Property

        Public Property ProductName() As String
            Get
                Return _productname
            End Get
            Set(ByVal value As String)
                _productname = value
            End Set
        End Property

        Public Property Price() As Decimal
            Get
                Return _price
            End Get
            Set(ByVal value As Decimal)
                _price = value
            End Set
        End Property

        Public Property GrandOpening() As Date
            Get
                Return _grandopening
            End Get
            Set(ByVal value As Date)
                _grandopening = value
            End Set
        End Property
        Public Property FransupportFranchiseID() As Integer
            Get
                Return _fransupportfranchiseid
            End Get
            Set(ByVal value As Integer)
                _fransupportfranchiseid = value
            End Set
        End Property

        Public Property ClientID() As Integer
            Get
                Return _clientid
            End Get
            Set(ByVal value As Integer)
                _clientid = value
            End Set
        End Property
		 Public Property InstallationDate() As DateTime
            Get
                Return _installationDate
            End Get
            Set(ByVal value As DateTime)
                _installationDate = value
            End Set
        End Property
        Public Property SMTPPort() As Integer
            Get
                Return _SMTPPort
            End Get
            Set(ByVal value As Integer)
                _SMTPPort = value
            End Set
        End Property
        Public Property OSVersionID() As Integer
            Get
                Return _OSVersionID
            End Get
            Set(ByVal value As Integer)
                _OSVersionID = value
            End Set
        End Property
#End Region


#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ProductID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal IP As String, _
          ByVal Version As String, _
          ByVal LastUpdateDate As DateTime, _
          ByVal ServerUserName As String, _
          ByVal ServerPassword As String, _
          ByVal NoOfLicenses As Integer, _
          ByVal CCPaymentGateway As Integer, _
          ByVal CCMerchantID As Integer, _
          ByVal CCMerchantPassword As String, _
          ByVal onSupport As Boolean, _
          ByVal SupportStartDate As DateTime, _
          ByVal SupportEnddate As DateTime, _
          ByVal WaivedMonths As Integer, _
          ByVal NoOfLiveTerminals As Integer, _
          ByVal UpdatedBy As Integer, _
          ByVal UpdatedOn As DateTime, _
          ByVal Inactive As Boolean, _
          ByVal Notes As String, _
          ByVal IsStaticIP As Boolean, _
          ByVal Price As Decimal _
         )


            Me.ID = ID
            Me.ProductID = ProductID
            Me.FranchiseID = FranchiseID
            Me.IP = IP
            Me.Version = Version
            Me.LastUpdateDate = LastUpdateDate
            Me.ServerUserName = ServerUserName
            Me.ServerPassword = ServerPassword
            Me.NoOfLicenses = NoOfLicenses
            Me.CCPaymentGateway = CCPaymentGateway
            Me.CCMerchantID = CCMerchantID
            Me.CCMerchantPassword = CCMerchantPassword
            Me.onSupport = onSupport
            Me.SupportStartDate = SupportStartDate
            Me.SupportEnddate = SupportEnddate
            Me.WaivedMonths = WaivedMonths
            Me.NoOfLiveTerminals = NoOfLiveTerminals
            Me.UpdatedBy = UpdatedBy
            Me.UpdatedOn = UpdatedOn
            Me.Inactive = Inactive
            Me.Notes = Notes
            Me.IsStaticIP = IsStaticIP
            Me.Price = Price
	#End Sub

        'GetAll for SMS
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ProductID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal IP As String, _
          ByVal Version As String, _
          ByVal LastUpdateDate As DateTime, _
          ByVal ServerUserName As String, _
          ByVal ServerPassword As String, _
          ByVal NoOfLicenses As Integer, _
          ByVal CCPaymentGateway As Integer, _
          ByVal CCMerchantID As Integer, _
          ByVal CCMerchantPassword As String, _
          ByVal onSupport As Boolean, _
          ByVal SupportStartDate As DateTime, _
          ByVal SupportEnddate As DateTime, _
          ByVal WaivedMonths As Integer, _
          ByVal NoOfLiveTerminals As Integer, _
          ByVal UpdatedBy As Integer, _
          ByVal UpdatedOn As DateTime, _
          ByVal Inactive As Boolean, _
          ByVal Notes As String, _
          ByVal IsStaticIP As Boolean, _
          ByVal Price As Decimal, _
          ByVal StoreNumber As Integer, _
          ByVal StoreNick As String, _
          ByVal ClientCode As String _
         )


            Me.ID = ID
            Me.ProductID = ProductID
            Me.FranchiseID = FranchiseID
            Me.IP = IP
            Me.Version = Version
            Me.LastUpdateDate = LastUpdateDate
            Me.ServerUserName = ServerUserName
            Me.ServerPassword = ServerPassword
            Me.NoOfLicenses = NoOfLicenses
            Me.CCPaymentGateway = CCPaymentGateway
            Me.CCMerchantID = CCMerchantID
            Me.CCMerchantPassword = CCMerchantPassword
            Me.onSupport = onSupport
            Me.SupportStartDate = SupportStartDate
            Me.SupportEnddate = SupportEnddate
            Me.WaivedMonths = WaivedMonths
            Me.NoOfLiveTerminals = NoOfLiveTerminals
            Me.UpdatedBy = UpdatedBy
            Me.UpdatedOn = UpdatedOn
            Me.Inactive = Inactive
            Me.Notes = Notes
            Me.IsStaticIP = IsStaticIP
            Me.Price = Price
            Me.StoreNumber = StoreNumber
            Me.StoreNick = StoreNick
            Me.ClientCode = ClientCode

	#End Sub

        'GetAll Support
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ProductID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal IP As String, _
          ByVal Version As String, _
          ByVal LastUpdateDate As DateTime, _
          ByVal ServerUserName As String, _
          ByVal ServerPassword As String, _
          ByVal NoOfLicenses As Integer, _
          ByVal CCPaymentGateway As Integer, _
          ByVal CCMerchantID As Integer, _
          ByVal CCMerchantPassword As String, _
          ByVal onSupport As Boolean, _
          ByVal SupportStartDate As DateTime, _
          ByVal SupportEnddate As DateTime, _
          ByVal WaivedMonths As Integer, _
          ByVal NoOfLiveTerminals As Integer, _
          ByVal UpdatedBy As Integer, _
          ByVal UpdatedOn As DateTime, _
          ByVal Inactive As Boolean, _
          ByVal Notes As String, _
          ByVal IsStaticIP As Boolean, _
          ByVal Price As Decimal, _
          ByVal StoreNumber As Integer, _
          ByVal StoreNick As String, _
          ByVal ClientCode As String, _
          ByVal ProductName As String, _
          ByVal GrandOpening As Date, _
          ByVal ClientID As Integer _
         )


            Me.ID = ID
            Me.ProductID = ProductID
            Me.FranchiseID = FranchiseID
            Me.IP = IP
            Me.Version = Version
            Me.LastUpdateDate = LastUpdateDate
            Me.ServerUserName = ServerUserName
            Me.ServerPassword = ServerPassword
            Me.NoOfLicenses = NoOfLicenses
            Me.CCPaymentGateway = CCPaymentGateway
            Me.CCMerchantID = CCMerchantID
            Me.CCMerchantPassword = CCMerchantPassword
            Me.onSupport = onSupport
            Me.SupportStartDate = SupportStartDate
            Me.SupportEnddate = SupportEnddate
            Me.WaivedMonths = WaivedMonths
            Me.NoOfLiveTerminals = NoOfLiveTerminals
            Me.UpdatedBy = UpdatedBy
            Me.UpdatedOn = UpdatedOn
            Me.Inactive = Inactive
            Me.Notes = Notes
            Me.IsStaticIP = IsStaticIP
            Me.Price = Price
            Me.StoreNumber = StoreNumber
            Me.StoreNick = StoreNick
            Me.ClientCode = ClientCode
            Me.ProductName = ProductName
            Me.GrandOpening = GrandOpening
            Me.ClientID = ClientID


	#End Sub

        'GetAll HelpDesk
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ProductID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal onSupport As Boolean, _
          ByVal SupportEnddate As DateTime, _
          ByVal StoreNumber As Integer, _
          ByVal StoreNick As String, _
          ByVal ClientCode As String, _
          ByVal ProductName As String _
         )

            Me.ID = ID
            Me.ProductID = ProductID
            Me.FranchiseID = FranchiseID
            Me.onSupport = onSupport
            Me.SupportEnddate = SupportEnddate
            Me.StoreNumber = StoreNumber
            Me.StoreNick = StoreNick
            Me.ClientCode = ClientCode
            Me.ProductName = ProductName

	#End Sub
#End Region

#Region " Public Method "
        Public Shared Function NS_Products_FranchisesGetAllForSMS(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As List(Of NS_Products_Franchises)
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllForSMS(search, ClientID, Inactive, StoreID, ProductID, sortBy, startRowIndex, maximumRows)
        End Function
        '====LM Accessed Methods =============
        Public Shared Function NS_Products_FranchisesGetAllForSMS_LM(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal UserID As Integer) As List(Of NS_Products_Franchises)
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllForSMS_BYLMRights(search, ClientID, Inactive, StoreID, ProductID, sortBy, startRowIndex, maximumRows, UserID)
        End Function
        Public Shared Function NS_Products_FranchisesGetAllCountForSMS_LM(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer, ByVal UserID As Integer) As Integer
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllCountForSMS_ByLMRights(search, ClientID, Inactive, StoreID, ProductID, UserID)
        End Function
        '======================================
        Public Shared Function NS_Products_FranchisesGetAllCountForSMS(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer) As Integer
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllCountForSMS(search, ClientID, Inactive, StoreID, ProductID)
        End Function
        Public Shared Function NS_Products_FranchisesGetAllForSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer, ByVal OnSupport As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllForSupport(search, ClientID, Inactive, StoreID, StoreStatus, ProductID, OnSupport, sortBy, startRowIndex, maximumRows)
        End Function
        Public Shared Function NS_Products_FranchisesGetAllCountForSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer, ByVal OnSupport As Integer) As Integer
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllCountForSupport(search, ClientID, Inactive, StoreID, StoreStatus, ProductID, OnSupport)
        End Function
        'Public Shared Function NS_Products_FranchisesGetAllForNotSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
        '    Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllForNotSupport(search, ClientID, Inactive, StoreID, StoreStatus, ProductID, sortBy, startRowIndex, maximumRows)
        'End Function
        'Public Shared Function NS_Products_FranchisesGetAllCountForNotSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer) As Integer
        '    Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllCountForNotSupport(search, ClientID, Inactive, StoreID, StoreStatus, ProductID)
        'End Function
        Public Shared Function NS_Products_FranchisesGetAllForNotSupportForHelpDesk(ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As List(Of NS_Products_Franchises)
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllForNotSupportForHelpDesk(sortBy, startRowIndex, maximumRows)
        End Function
        Public Shared Function NS_Products_FranchisesGetAllCountForNotSupportForHelpDesk() As Integer
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetAllCountForNotSupportForHelpDesk()
        End Function
        Public Shared Function NS_Products_FranchisesGetByID(ByVal ID As Integer) As NS_Products_Franchises
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetByID(ID)
        End Function
        Public Shared Function NS_Products_FranchisesGetByFranID_ProductID(ByVal FranchiseID As Integer, ByVal ProductID As Integer) As NS_Products_Franchises
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetByFranID_ProductID(FranchiseID, ProductID)
        End Function
        'Public Shared Function NS_Products_FranchisesAdd(ByVal ID As Integer, ByVal ProductID As Integer, ByVal FranchiseID As Integer, ByVal IP As String, ByVal Version As String, ByVal LastUpdateDate As Date, ByVal ServerUserName As String, ByVal ServerPassword As String, ByVal NoOfLicenses As Integer, ByVal CCPaymentGateway As Integer, ByVal CCMerchantID As Integer, ByVal CCMerchantPassword As String, ByVal onSupport As Boolean, ByVal SupportStartDate As Date, ByVal SupportEnddate As Date, ByVal WaivedMonths As Integer, ByVal NoOfLiveTerminals As Integer, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date, ByVal Inactive As Boolean, ByVal Notes As String, ByVal IsStaticIP As Boolean, ByVal Price As Decimal) As Integer
        '    Dim NS_Products_FranchisesBll As Portal.BLL.NS.NS_Products_Franchises = New Portal.BLL.NS.NS_Products_Franchises(ID, ProductID, FranchiseID, IP, Version, LastUpdateDate, ServerUserName, ServerPassword, NoOfLicenses, CCPaymentGateway, CCMerchantID, CCMerchantPassword, onSupport, SupportStartDate, SupportEnddate, WaivedMonths, NoOfLiveTerminals, UpdatedBy, UpdatedOn, Inactive, Notes, IsStaticIP, Price)
        '    Dim NS_Products_FranchisesDal As Portal.DAL.NS.DBNS_Products_Franchises = New Portal.DAL.NS.DBNS_Products_Franchises()
        '    Return NS_Products_FranchisesDal.Add(NS_Products_FranchisesBll)
        'End Function
		Public Shared Function NS_Products_FranchisesAdd(ByVal ProductID As Integer, ByVal FranchiseID As Integer, ByVal onSupport As Boolean, ByVal SupportStartDate As Date, ByVal SupportEnddate As Date, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date, ByVal Inactive As Boolean, ByVal Notes As String, ByVal Price As Decimal, ByVal NoOfLicenses As Integer) As Integer
            Dim NS_Products_FranchisesDal As Portal.DAL.NS.DBNS_Products_Franchises = New Portal.DAL.NS.DBNS_Products_Franchises()
            Return NS_Products_FranchisesDal.Add(ProductID, FranchiseID, onSupport, SupportStartDate, SupportEnddate, UpdatedBy, UpdatedOn, Inactive, Notes, Price, NoOfLicenses)
        End Function
        Public Shared Function NS_Products_FranchisesUpdate(ByVal ID As Integer, ByVal IP As String, ByVal ServerUserName As String, ByVal ServerPassword As String, ByVal NoOfLicenses As Integer, ByVal Notes As String, ByVal IsStaticIP As Boolean, ByVal CCPaymentGateway As Integer, ByVal CCMerchantID As Integer, ByVal CCMerchantPassword As String, ByVal InstallationDate As Date, ByVal SMTPPort As Integer, ByVal OSVersionID As Integer) As Integer
            Dim NS_Products_FranchisesDal As Portal.DAL.NS.DBNS_Products_Franchises = New Portal.DAL.NS.DBNS_Products_Franchises()
            Return NS_Products_FranchisesDal.Update(ID, IP, ServerUserName, ServerPassword, NoOfLicenses, Notes, IsStaticIP, CCPaymentGateway, CCMerchantID, CCMerchantPassword, InstallationDate, SMTPPort, OSVersionID)
        End Function
        Public Shared Function NS_Products_FranchisesUpdateSupport(ByVal ID As Integer, ByVal onSupport As Boolean, ByVal SupportStartDate As Date, ByVal SupportEnddate As Date, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date, ByVal Inactive As Boolean, ByVal Notes As String, ByVal Price As Decimal, ByVal NoOfLicenses As Integer) As Integer
            Dim NS_Products_FranchisesDal As Portal.DAL.NS.DBNS_Products_Franchises = New Portal.DAL.NS.DBNS_Products_Franchises()
            Return NS_Products_FranchisesDal.UpdateSupport(ID, onSupport, SupportStartDate, SupportEnddate, UpdatedBy, UpdatedOn, Inactive, Notes, Price, NoOfLicenses)
        End Function
        Public Shared Function NS_Products_FranchisesUpdateSupport(ByVal ID As Integer, ByVal SupportEnddate As Date, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date) As Integer
            Dim NS_Products_FranchisesDal As Portal.DAL.NS.DBNS_Products_Franchises = New Portal.DAL.NS.DBNS_Products_Franchises()
            Return NS_Products_FranchisesDal.UpdateSupport(ID, SupportEnddate, UpdatedBy, UpdatedOn)
        End Function
        Public Shared Function NS_Products_CheckDuplicateProduct(ByVal ID As Integer, ByVal FranchiseID As Integer) As Integer
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_CheckDuplicateProduct(ID, FranchiseID)
        End Function
        Public Shared Function NS_Products_CheckParentProduct(ByVal ID As Integer, ByVal FranchiseID As Integer) As Integer
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_CheckParentProduct(ID, FranchiseID)
        End Function
        Public Shared Function NS_Products_CheckFranchisesInReportRecords(ByVal FranchiseID As Integer) As Integer
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_CheckFranchisesInReportRecords(FranchiseID)
        End Function
        Public Shared Function NS_Products_CheckDatesInReportDeatil(ByVal FranchiseID As Integer, ByVal ProductID As Integer) As NS_Products_Franchises
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_CheckDatesInReportDeatil(FranchiseID, ProductID)
        End Function
        ''Public Shared Function GetClientProductsReport(ByVal ReqStartDate As Date, ByVal ReqEndDate As Date, ByVal ClientID As Integer) As DataSet
        ''    Return Portal.DAL.NS.DBNS_Products_Franchises.GetClientProductsReport(ReqStartDate, ReqEndDate, ClientID)
        ''End Function
        ''Public Shared Function GetClientHeaderProducts(ByVal ReqStartDate As Date, ByVal ReqEndDate As Date, ByVal ClientID As Integer) As DataTable
        ''    Return Portal.DAL.NS.DBNS_Products_Franchises.GetClientHeaderProducts(ReqStartDate, ReqEndDate, ClientID)
        ''End Function

	Public Shared Function NS_Products_FranchisesGetbyFranchiseID(ByVal FranchiseID As Integer) As DataSet
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_FranchisesGetbyFranchiseID(FranchiseID)
        End Function
        Public Shared Function NS_Products_Franchises_IsExist(ByVal ProductID As Integer, ByVal FranchiseID As Integer) As Boolean
            Return Portal.DAL.NS.DBNS_Products_Franchises.NS_Products_Franchises_IsExist(ProductID, FranchiseID)
        End Function

  	Public Shared Function NS_Products_FranchisesUpdate_DM(ByVal ID As Integer, ByVal IP As String, ByVal IsStaticIP As Boolean) As Integer
            Dim NS_Products_FranchisesDal As Portal.DAL.NS.DBNS_Products_Franchises = New Portal.DAL.NS.DBNS_Products_Franchises()
            Return NS_Products_FranchisesDal.Update_DM(ID, IP, IsStaticIP)
        End Function

  	Public Shared Function NS_Products_FranchisesUpdate_nxStep(ByVal ID As Integer, ByVal IP As String, ByVal IsStaticIP As Boolean) As Integer
            Dim NS_Products_FranchisesDal As Portal.DAL.NS.DBNS_Products_Franchises = New Portal.DAL.NS.DBNS_Products_Franchises()
            Return NS_Products_FranchisesDal.Update_nxStep(ID, IP, IsStaticIP)
        End Function

        Public Shared Function GetLicenseID(ByVal ID As Integer) As Integer
            Return Portal.DAL.SMSXLicenseManagement.GetLicenseID(ID)
        End Function

#End Region

    End Class
End Namespace
