Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_Products_TechnicalInfo
#Region " Private Members "
        Private _id As Integer
        Private _productfranchiseid As Integer
        Private _isptype As String
        Private _primarydns As String
        Private _secondarydns As String
        Private _isppassword As String
        Private _ispusername As String
        Private _firewallrouter As String
        Private _firewallrouteraccess As String
        Private _firewallrouterlogin As String
        Private _deliverycharge As Decimal
        Private _deliverychargevat As Decimal
        Private _merchantno As String
        Private _authlogin As String
        Private _cclogin As String
        Private _ccpassword As String
        Private _tagprinting As Boolean
        Private _housecharge As Boolean
        Private _housechargeamount As Decimal
        Private _smsautodiscount As Decimal
        Private _taxrate As Decimal
        Private _contentfiltering As Integer

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

        Public Property ProductFranchiseID() As Integer
            Get
                Return _productfranchiseid
            End Get
            Set(ByVal value As Integer)
                _productfranchiseid = value
            End Set
        End Property

        Public Property ISPType() As String
            Get
                Return _isptype
            End Get
            Set(ByVal value As String)
                _isptype = value
            End Set
        End Property

        Public Property PrimaryDNS() As String
            Get
                Return _primarydns
            End Get
            Set(ByVal value As String)
                _primarydns = value
            End Set
        End Property

        Public Property SecondaryDNS() As String
            Get
                Return _secondarydns
            End Get
            Set(ByVal value As String)
                _secondarydns = value
            End Set
        End Property

        Public Property ISPPassword() As String
            Get
                Return _isppassword
            End Get
            Set(ByVal value As String)
                _isppassword = value
            End Set
        End Property

        Public Property ISPUserName() As String
            Get
                Return _ispusername
            End Get
            Set(ByVal value As String)
                _ispusername = value
            End Set
        End Property

        Public Property FirewallRouter() As String
            Get
                Return _firewallrouter
            End Get
            Set(ByVal value As String)
                _firewallrouter = value
            End Set
        End Property

        Public Property FirewallRouterAccess() As String
            Get
                Return _firewallrouteraccess
            End Get
            Set(ByVal value As String)
                _firewallrouteraccess = value
            End Set
        End Property

        Public Property FirewallRouterLogin() As String
            Get
                Return _firewallrouterlogin
            End Get
            Set(ByVal value As String)
                _firewallrouterlogin = value
            End Set
        End Property

        Public Property DeliveryCharge() As Decimal
            Get
                Return _deliverycharge
            End Get
            Set(ByVal value As Decimal)
                _deliverycharge = value
            End Set
        End Property

        Public Property DeliveryChargeVAT() As Decimal
            Get
                Return _deliverychargevat
            End Get
            Set(ByVal value As Decimal)
                _deliverychargevat = value
            End Set
        End Property

        Public Property MerchantNo() As String
            Get
                Return _merchantno
            End Get
            Set(ByVal value As String)
                _merchantno = value
            End Set
        End Property

        Public Property AuthLogin() As String
            Get
                Return _authlogin
            End Get
            Set(ByVal value As String)
                _authlogin = value
            End Set
        End Property

        Public Property CCLogin() As String
            Get
                Return _cclogin
            End Get
            Set(ByVal value As String)
                _cclogin = value
            End Set
        End Property

        Public Property CCPassword() As String
            Get
                Return _ccpassword
            End Get
            Set(ByVal value As String)
                _ccpassword = value
            End Set
        End Property

        Public Property TagPrinting() As Boolean
            Get
                Return _tagprinting
            End Get
            Set(ByVal value As Boolean)
                _tagprinting = value
            End Set
        End Property

        Public Property HouseCharge() As Boolean
            Get
                Return _housecharge
            End Get
            Set(ByVal value As Boolean)
                _housecharge = value
            End Set
        End Property

        Public Property HouseChargeAmount() As Decimal
            Get
                Return _housechargeamount
            End Get
            Set(ByVal value As Decimal)
                _housechargeamount = value
            End Set
        End Property

        Public Property SMSAutoDiscount() As Decimal
            Get
                Return _smsautodiscount
            End Get
            Set(ByVal value As Decimal)
                _smsautodiscount = value
            End Set
        End Property

        Public Property TaxRate() As Decimal
            Get
                Return _taxrate
            End Get
            Set(ByVal value As Decimal)
                _taxrate = value
            End Set
        End Property

        Public Property ContentFiltering() As Integer
            Get
                Return _contentfiltering
            End Get
            Set(ByVal value As Integer)
                _contentfiltering = value
            End Set
        End Property
#End Region


#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
           ByVal ID As Integer, _
           ByVal ProductFranchiseID As Integer, _
           ByVal ISPType As String, _
           ByVal PrimaryDNS As String, _
           ByVal SecondaryDNS As String, _
           ByVal ISPPassword As String, _
           ByVal ISPUserName As String, _
           ByVal FirewallRouter As String, _
           ByVal FirewallRouterAccess As String, _
           ByVal FirewallRouterLogin As String, _
           ByVal DeliveryCharge As Decimal, _
           ByVal DeliveryChargeVAT As Decimal, _
           ByVal MerchantNo As String, _
           ByVal AuthLogin As String, _
           ByVal CCLogin As String, _
           ByVal CCPassword As String, _
           ByVal TagPrinting As Boolean, _
           ByVal HouseCharge As Boolean, _
           ByVal HouseChargeAmount As Decimal, _
           ByVal SMSAutoDiscount As Decimal, _
           ByVal TaxRate As Decimal, _
           ByVal ContentFiltering As Integer _
          )


            Me.ID = ID
            Me.ProductFranchiseID = ProductFranchiseID
            Me.ISPType = ISPType
            Me.PrimaryDNS = PrimaryDNS
            Me.SecondaryDNS = SecondaryDNS
            Me.ISPPassword = ISPPassword
            Me.ISPUserName = ISPUserName
            Me.FirewallRouter = FirewallRouter
            Me.FirewallRouterAccess = FirewallRouterAccess
            Me.FirewallRouterLogin = FirewallRouterLogin
            Me.DeliveryCharge = DeliveryCharge
            Me.DeliveryChargeVAT = DeliveryChargeVAT
            Me.MerchantNo = MerchantNo
            Me.AuthLogin = AuthLogin
            Me.CCLogin = CCLogin
            Me.CCPassword = CCPassword
            Me.TagPrinting = TagPrinting
            Me.HouseCharge = HouseCharge
            Me.HouseChargeAmount = HouseChargeAmount
            Me.SMSAutoDiscount = SMSAutoDiscount
            Me.TaxRate = TaxRate
            Me.ContentFiltering = ContentFiltering


        End Sub

        
#End Region

#Region " Public Method "
        'Public Shared Function NS_Products_TechnicalInfoGetAll() As List(Of NS_Products_TechnicalInfo)
        '    Return Portal.DAL.NS.DBNS_Products_TechnicalInfo.NS_Products_TechnicalInfoGetAll()
        'End Function
        Public Shared Function NS_Products_TechnicalInfoGetByProductFranchiseID(ByVal ProductFranchiseID As Integer) As List(Of NS_Products_TechnicalInfo)
            Return Portal.DAL.NS.DBNS_Products_TechnicalInfo.NS_Products_TechnicalInfoGetByProductFranchiseID(ProductFranchiseID)
        End Function
        'Public Shared Function NS_Products_TechnicalInfoAddOrUpdate(ByVal ID As Integer, ByVal ProductFranchiseID As Integer, ByVal ISPType As String, ByVal PrimaryDNS As String, ByVal SecondaryDNS As String, ByVal DialupSpeed As String, ByVal DialupNumber As String, ByVal DialupLogin As String, ByVal Switch As String, ByVal FirewallRouter As String, ByVal FirewallRouterAccess As String, ByVal FirewallRouterLogin As String) As Integer
        '    Dim NS_Products_TechnicalInfoBll As Portal.BLL.NS.NS_Products_TechnicalInfo = New Portal.BLL.NS.NS_Products_TechnicalInfo(ID, ProductFranchiseID, ISPType, PrimaryDNS, SecondaryDNS, DialupSpeed, DialupNumber, DialupLogin, Switch, FirewallRouter, FirewallRouterAccess, FirewallRouterLogin)
        '    Dim NS_Products_TechnicalInfoDal As Portal.DAL.NS.DBNS_Products_TechnicalInfo = New Portal.DAL.NS.DBNS_Products_TechnicalInfo()
        '    Return NS_Products_TechnicalInfoDal.AddOrUpdate(NS_Products_TechnicalInfoBll)
        'End Function

        Public Shared Function NS_Products_TechnicalInfoAddOrUpdate(ByVal ID As Integer, ByVal ProductFranchiseID As Integer, ByVal ISPType As String, ByVal ISPPassword As String, ByVal ISPUserName As String, ByVal PrimaryDNS As String, ByVal SecondaryDNS As String, ByVal FirewallRouter As String, ByVal FirewallRouterAccess As String, ByVal FirewallRouterLogin As String, ByVal DeliveryCharge As Decimal, ByVal DeliveryChargeVAT As Decimal, ByVal MerchantNo As String, ByVal AuthLogin As String, ByVal CCLogin As String, ByVal CCPassword As String, ByVal TagPrinting As Boolean, ByVal HouseCharge As Boolean, ByVal HouseChargeAmount As Decimal, ByVal SMSAutoDiscount As Decimal, ByVal TaxRate As Decimal, ByVal ContentFiltering As Integer) As Integer
            Dim NS_Products_TechnicalInfoBll As Portal.BLL.NS.NS_Products_TechnicalInfo = New Portal.BLL.NS.NS_Products_TechnicalInfo(ID, ProductFranchiseID, ISPType, ISPPassword, ISPUserName, PrimaryDNS, SecondaryDNS, FirewallRouter, FirewallRouterAccess, FirewallRouterLogin, DeliveryCharge, DeliveryChargeVAT, MerchantNo, AuthLogin, CCLogin, CCPassword, TagPrinting, HouseCharge, HouseChargeAmount, SMSAutoDiscount, TaxRate, ContentFiltering)
            Dim NS_Products_TechnicalInfoDal As Portal.DAL.NS.DBNS_Products_TechnicalInfo = New Portal.DAL.NS.DBNS_Products_TechnicalInfo()
            Return NS_Products_TechnicalInfoDal.AddOrUpdate(NS_Products_TechnicalInfoBll)
        End Function

#End Region

    End Class
End Namespace