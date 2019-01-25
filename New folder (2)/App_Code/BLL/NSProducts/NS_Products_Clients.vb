Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_Products_Clients
#Region " Private Members "
        Private _id As Integer
        Private _productid As Integer
        Private _clientid As Integer
        Private _billto As Integer
        Private _corporatepay As Decimal
        Private _deleted As Boolean
        Private _price As Decimal
        Private _corporatepaytype As Integer
        Private _lastupdateddate As DateTime
        Private _lastupdatedby As Integer

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

        Public Property ClientID() As Integer
            Get
                Return _clientid
            End Get
            Set(ByVal value As Integer)
                _clientid = value
            End Set
        End Property

        Public Property BillTo() As Integer
            Get
                Return _billto
            End Get
            Set(ByVal value As Integer)
                _billto = value
            End Set
        End Property

        Public Property CorporatePay() As Decimal
            Get
                Return _corporatepay
            End Get
            Set(ByVal value As Decimal)
                _corporatepay = value
            End Set
        End Property

        Public Property Deleted() As Boolean
            Get
                Return _deleted
            End Get
            Set(ByVal value As Boolean)
                _deleted = value
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

        Public Property CorporatePayType() As Integer
            Get
                Return _corporatepaytype
            End Get
            Set(ByVal value As Integer)
                _corporatepaytype = value
            End Set
        End Property

        Public Property LastUpdatedDate() As DateTime
            Get
                Return _lastupdateddate
            End Get
            Set(ByVal value As DateTime)
                _lastupdateddate = value
            End Set
        End Property

        Public Property LastUpdatedBy() As Integer
            Get
                Return _lastupdatedby
            End Get
            Set(ByVal value As Integer)
                _lastupdatedby = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ProductID As Integer, _
          ByVal ClientID As Integer, _
          ByVal BillTo As Integer, _
          ByVal CorporatePay As Decimal, _
          ByVal Deleted As Boolean, _
          ByVal Price As Decimal, _
          ByVal CorporatePayType As Integer _
         )
            Me.ID = ID
            Me.ProductID = ProductID
            Me.ClientID = ClientID
            Me.BillTo = BillTo
            Me.CorporatePay = CorporatePay
            Me.Deleted = Deleted
            Me.Price = Price
            Me.CorporatePayType = CorporatePayType
        End Sub
#End Region

#Region " Public Method "
        Public Shared Function NS_Products_ClientsGetAll() As List(Of NS_Products_Clients)
            Return Portal.DAL.NS.DBNS_Products_Clients.NS_Products_ClientsGetAll()
        End Function
        Public Shared Function NS_Products_ClientsGetByID(ByVal ID As Integer) As List(Of NS_Products_Clients)
            Return Portal.DAL.NS.DBNS_Products_Clients.NS_Products_ClientsGetByID(ID)
        End Function
        Public Shared Function NS_Products_ClientsGetByClientID(ByVal ClientID As Integer, ByVal ProductID As Integer) As List(Of NS_Products_Clients)
            Return Portal.DAL.NS.DBNS_Products_Clients.NS_Products_ClientsGetByClientID(ClientID, ProductID)
        End Function
        'Public Shared Function NS_Products_ClientsAdd(ByVal ID As Integer, ByVal ProductID As Integer, ByVal ClientID As Integer, ByVal BillTo As Integer, ByVal CorporatePay As Decimal, ByVal Deleted As Boolean, ByVal Price As Decimal, ByVal CorporatePayType As Integer) As Integer
        '    Dim NS_Products_ClientsBll As Portal.BLL.NS.NS_Products_Clients = New Portal.BLL.NS.NS_Products_Clients(ID, ProductID, ClientID, BillTo, CorporatePay, Deleted, Price, CorporatePayType)
        '    Dim NS_Products_ClientsDal As Portal.DAL.NS.DBNS_Products_Clients = New Portal.DAL.NS.DBNS_Products_Clients()
        '    Return NS_Products_ClientsDal.Add(NS_Products_ClientsBll)
        'End Function
        'Public Shared Function NS_Products_ClientsDeleteByClientID(ByVal ClientID As Integer) As Integer
        '    Dim NS_Products_ClientsDal As Portal.DAL.NS.DBNS_Products_Clients = New Portal.DAL.NS.DBNS_Products_Clients()
        '    Return NS_Products_ClientsDal.DeleteByClientID(ClientID)
        'End Function
        Public Shared Function NS_Products_ClientsAddWithTranction(ByVal colNS_Products_Clients As List(Of Portal.BLL.NS.NS_Products_Clients), ByVal ClientID As Integer) As Integer
            Dim NS_Products_ClientsDal As Portal.DAL.NS.DBNS_Products_Clients = New Portal.DAL.NS.DBNS_Products_Clients()
            Return NS_Products_ClientsDal.AddWithTranction(colNS_Products_Clients, ClientID)
        End Function
#End Region

    End Class
End Namespace