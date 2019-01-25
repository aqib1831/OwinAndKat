Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.BLL.Orders
    Public Class SCM_Orders
#Region " Private Members "
        Private _id As Integer
        Private _clientid As Integer
        Private _franchiseid As Integer
        Private _storenumber As Integer
        Private _address As String
        Private _city As String
        Private _stateid As Integer
        Private _countryid As Integer
        Private _zip As String
        Private _phone As String
        Private _email As String
        Private _orderdate As Date
        Private _paymenttype As Integer
        Private _cctype As Integer
        Private _bankaccounttype As Integer
        Private _ccname As String
        Private _ccvnumber As String
        Private _ccnumber As String
        Private _ccexpirationdate As Date
        Private _bankname As String
        Private _bankaccount As String
        Private _bankrouting As String
        Private _printname As String
        Private _grandtotal As Decimal
        Private _totalwithouttax As Decimal
        Private _taxamount As Decimal
        Private _statusid As Integer
        Private _clientname As String
        Private _storename As String
        Private _OrderStatus As String

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

        Public Property ClientID() As Integer
            Get
                Return _clientid
            End Get
            Set(ByVal value As Integer)
                _clientid = value
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

        Public Property StoreNumber() As Integer
            Get
                Return _storenumber
            End Get
            Set(ByVal value As Integer)
                _storenumber = value
            End Set
        End Property

        Public Property Address() As String
            Get
                Return _address
            End Get
            Set(ByVal value As String)
                _address = value
            End Set
        End Property

        Public Property City() As String
            Get
                Return _city
            End Get
            Set(ByVal value As String)
                _city = value
            End Set
        End Property

        Public Property StateID() As Integer
            Get
                Return _stateid
            End Get
            Set(ByVal value As Integer)
                _stateid = value
            End Set
        End Property

        Public Property CountryID() As Integer
            Get
                Return _countryid
            End Get
            Set(ByVal value As Integer)
                _countryid = value
            End Set
        End Property

        Public Property Zip() As String
            Get
                Return _zip
            End Get
            Set(ByVal value As String)
                _zip = value
            End Set
        End Property

        Public Property Phone() As String
            Get
                Return _phone
            End Get
            Set(ByVal value As String)
                _phone = value
            End Set
        End Property

        Public Property Email() As String
            Get
                Return _email
            End Get
            Set(ByVal value As String)
                _email = value
            End Set
        End Property

        Public Property OrderDate() As Date
            Get
                Return _orderdate
            End Get
            Set(ByVal value As Date)
                _orderdate = value
            End Set
        End Property

        Public Property PaymentType() As Integer
            Get
                Return _paymenttype
            End Get
            Set(ByVal value As Integer)
                _paymenttype = value
            End Set
        End Property

        Public Property CCType() As Integer
            Get
                Return _cctype
            End Get
            Set(ByVal value As Integer)
                _cctype = value
            End Set
        End Property

        Public Property BankAccountType() As Integer
            Get
                Return _bankaccounttype
            End Get
            Set(ByVal value As Integer)
                _bankaccounttype = value
            End Set
        End Property

        Public Property CCName() As String
            Get
                Return _ccname
            End Get
            Set(ByVal value As String)
                _ccname = value
            End Set
        End Property

        Public Property CCVNumber() As String
            Get
                Return _ccvnumber
            End Get
            Set(ByVal value As String)
                _ccvnumber = value
            End Set
        End Property

        Public Property CCNumber() As String
            Get
                Return _ccnumber
            End Get
            Set(ByVal value As String)
                _ccnumber = value
            End Set
        End Property

        Public Property CCExpirationDate() As Date
            Get
                Return _ccexpirationdate
            End Get
            Set(ByVal value As Date)
                _ccexpirationdate = value
            End Set
        End Property

        Public Property BankName() As String
            Get
                Return _bankname
            End Get
            Set(ByVal value As String)
                _bankname = value
            End Set
        End Property

        Public Property BankAccount() As String
            Get
                Return _bankaccount
            End Get
            Set(ByVal value As String)
                _bankaccount = value
            End Set
        End Property

        Public Property BankRouting() As String
            Get
                Return _bankrouting
            End Get
            Set(ByVal value As String)
                _bankrouting = value
            End Set
        End Property

        Public Property PrintName() As String
            Get
                Return _printname
            End Get
            Set(ByVal value As String)
                _printname = value
            End Set
        End Property

        Public Property GrandTotal() As Decimal
            Get
                Return _grandtotal
            End Get
            Set(ByVal value As Decimal)
                _grandtotal = value
            End Set
        End Property

        Public Property TotalWithoutTax() As Decimal
            Get
                Return _totalwithouttax
            End Get
            Set(ByVal value As Decimal)
                _totalwithouttax = value
            End Set
        End Property

        Public Property TaxAmount() As Decimal
            Get
                Return _taxamount
            End Get
            Set(ByVal value As Decimal)
                _taxamount = value
            End Set
        End Property

        Public Property StatusID() As Integer
            Get
                Return _statusid
            End Get
            Set(ByVal value As Integer)
                _statusid = value
            End Set
        End Property
        Public Property ClientName() As String
            Get
                Return _clientname
            End Get
            Set(ByVal value As String)
                _clientname = value
            End Set
        End Property

        Public Property StoreName() As String
            Get
                Return _storename
            End Get
            Set(ByVal value As String)
                _storename = value
            End Set
        End Property
        Public Property OrderStatus() As String
            Get
                Return _OrderStatus
            End Get
            Set(ByVal value As String)
                _OrderStatus = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub
        'Get All
        Public Sub New( _
                  ByVal ID As Integer, _
                  ByVal ClientID As Integer, _
                  ByVal FranchiseID As Integer, _
                  ByVal StoreNumber As Integer, _
                  ByVal Address As String, _
                  ByVal City As String, _
                  ByVal StateID As Integer, _
                  ByVal CountryID As Integer, _
                  ByVal Zip As String, _
                  ByVal Phone As String, _
                  ByVal Email As String, _
                  ByVal OrderDate As Date, _
                  ByVal PaymentType As Integer, _
                  ByVal CCType As Integer, _
                  ByVal BankAccountType As Integer, _
                  ByVal CCName As String, _
                  ByVal CCVNumber As String, _
                  ByVal CCNumber As String, _
                  ByVal CCExpirationDate As Date, _
                  ByVal BankName As String, _
                  ByVal BankAccount As String, _
                  ByVal BankRouting As String, _
                  ByVal PrintName As String, _
                  ByVal GrandTotal As Decimal, _
                  ByVal TotalWithoutTax As Decimal, _
                  ByVal TaxAmount As Decimal, _
                  ByVal StatusID As Integer, _
                  ByVal ClientName As String, _
                  ByVal StoreName As String _
                 )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.FranchiseID = FranchiseID
            Me.StoreNumber = StoreNumber
            Me.Address = Address
            Me.City = City
            Me.StateID = StateID
            Me.CountryID = CountryID
            Me.Zip = Zip
            Me.Phone = Phone
            Me.Email = Email
            Me.OrderDate = OrderDate
            Me.PaymentType = PaymentType
            Me.CCType = CCType
            Me.BankAccountType = BankAccountType
            Me.CCName = CCName
            Me.CCVNumber = CCVNumber
            Me.CCNumber = CCNumber
            Me.CCExpirationDate = CCExpirationDate
            Me.BankName = BankName
            Me.BankAccount = BankAccount
            Me.BankRouting = BankRouting
            Me.PrintName = PrintName
            Me.GrandTotal = GrandTotal
            Me.TotalWithoutTax = TotalWithoutTax
            Me.TaxAmount = TaxAmount
            Me.StatusID = StatusID
            Me.ClientName = ClientName
            Me.StoreName = StoreName


        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ClientID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal StoreNumber As Integer, _
          ByVal Address As String, _
          ByVal City As String, _
          ByVal StateID As Integer, _
          ByVal CountryID As Integer, _
          ByVal Zip As String, _
          ByVal Phone As String, _
          ByVal Email As String, _
          ByVal OrderDate As Date, _
          ByVal PaymentType As Integer, _
          ByVal CCType As Integer, _
          ByVal BankAccountType As Integer, _
          ByVal CCName As String, _
          ByVal CCVNumber As String, _
          ByVal CCNumber As String, _
          ByVal CCExpirationDate As Date, _
          ByVal BankName As String, _
          ByVal BankAccount As String, _
          ByVal BankRouting As String, _
          ByVal PrintName As String, _
          ByVal GrandTotal As Decimal, _
          ByVal TotalWithoutTax As Decimal, _
          ByVal TaxAmount As Decimal, _
          ByVal StatusID As Integer _
         )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.FranchiseID = FranchiseID
            Me.StoreNumber = StoreNumber
            Me.Address = Address
            Me.City = City
            Me.StateID = StateID
            Me.CountryID = CountryID
            Me.Zip = Zip
            Me.Phone = Phone
            Me.Email = Email
            Me.OrderDate = OrderDate
            Me.PaymentType = PaymentType
            Me.CCType = CCType
            Me.BankAccountType = BankAccountType
            Me.CCName = CCName
            Me.CCVNumber = CCVNumber
            Me.CCNumber = CCNumber
            Me.CCExpirationDate = CCExpirationDate
            Me.BankName = BankName
            Me.BankAccount = BankAccount
            Me.BankRouting = BankRouting
            Me.PrintName = PrintName
            Me.GrandTotal = GrandTotal
            Me.TotalWithoutTax = TotalWithoutTax
            Me.TaxAmount = TaxAmount
            Me.StatusID = StatusID


        End Sub

        Public Sub New( _
                  ByVal ID As Integer, _
                  ByVal StoreNumber As Integer, _
                  ByVal OrderDate As Date, _
                  ByVal GrandTotal As Decimal, _
                  ByVal StatusID As Integer, _
                  ByVal ClientName As String, _
                  ByVal StoreName As String, _
                  ByVal OrderStatus As String)

            Me.ID = ID
            Me.StoreNumber = StoreNumber
            Me.OrderDate = OrderDate
            Me.GrandTotal = GrandTotal
            Me.StatusID = StatusID
            Me.ClientName = ClientName
            Me.StoreName = StoreName
            Me.OrderStatus = OrderStatus


        End Sub


#End Region

#Region " Public Method "
        Public Shared Function SCM_OrdersGetAll(ByVal ClientID As Integer, ByVal OrderStatusID As Integer, ByVal StateID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of SCM_Orders)
            Return Portal.DAL.Orders.DBSCM_Orders.SCM_OrdersGetAll(ClientID, OrderStatusID, StateID, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function

        Public Shared Function SCM_SearchOrders(ByVal Search As String) As SqlDataReader
            Dim accessObj As DBAccess = New DBAccess()
            If (String.IsNullOrEmpty(Search) = True) Then
                accessObj.AddParameter("@searchtxt", DBNull.Value)
            Else
                accessObj.AddParameter("@searchtxt", Search)
            End If
            Return accessObj.ExecuteReader("SCM_Orders_Search")
        End Function


        'Public Shared Function SCM_OrdersGetByID(ByVal ID As Integer) As List(Of SCM_Orders)
        '    Return Portal.DAL.Orders.DBSCM_Orders.SCM_OrdersGetByID(ID)
        'End Function
        'Public Shared Function SCM_OrdersAdd(ByVal ID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal StoreNumber As Integer, ByVal Address As String, ByVal City As String, ByVal StateID As Integer, ByVal CountryID As Integer, ByVal Zip As String, ByVal Phone As String, ByVal Email As String, ByVal OrderDate As Date, ByVal PaymentType As Integer, ByVal CCType As Integer, ByVal BankAccountType As Integer, ByVal CCName As String, ByVal CCVNumber As String, ByVal CCNumber As String, ByVal CCExpirationDate As Date, ByVal BankName As String, ByVal BankAccount As String, ByVal BankRouting As String, ByVal PrintName As String, ByVal GrandTotal As Decimal, ByVal TotalWithoutTax As Decimal, ByVal TaxAmount As Decimal, ByVal StatusID As Integer) As Integer
        '    Dim SCM_OrdersBll As Portal.BLL.Orders.SCM_Orders = New Portal.BLL.Orders.SCM_Orders(ID, ClientID, FranchiseID, StoreNumber, Address, City, StateID, CountryID, Zip, Phone, Email, OrderDate, PaymentType, CCType, BankAccountType, CCName, CCVNumber, CCNumber, CCExpirationDate, BankName, BankAccount, BankRouting, PrintName, GrandTotal, TotalWithoutTax, TaxAmount, StatusID)
        '    Dim SCM_OrdersDal As Portal.DAL.Orders.DBSCM_Orders = New Portal.DAL.Orders.DBSCM_Orders()
        '    Return SCM_OrdersDal.Add(SCM_OrdersBll)
        'End Function

        Public Function UpdateOrderStatus(ByVal orderStatusID As Integer, ByVal orderID As Integer, ByVal userID As Integer, ByVal Notes As String) As Integer
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@OrderStatusID", orderStatusID)
            accessObj.AddParameter("@OrderID", orderID)
            accessObj.AddParameter("@Notes", Notes)
            accessObj.AddParameter("@UserID", userID)
            Return accessObj.ExecuteNonQuery("SCM_Orders_UpdateStatusByID")
        End Function

        Public Sub GetOrderStatus(ByVal orderID As Integer)
            Dim accessObj As DBAccess = New DBAccess()
            Dim reader As SqlDataReader = Nothing
            accessObj.AddParameter("@OrderID", orderID)
            reader = accessObj.ExecuteReader("SCM_GetOrderStatusByOrderID")
            reader.Read()
            Me.OrderStatus = reader("OrderStatus").ToString()
            Me.StatusID = CInt(reader("StatusID"))
            reader.Close()
        End Sub
        Public Function UpdateCCNumber(ByVal orderID As Integer, ByVal CCNumber As String) As Integer
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@OrderID", orderID)            
            accessObj.AddParameter("@CCNumber", CCNumber)
            Return accessObj.ExecuteNonQuery("SCM_OrderCCNumber_Update")
        End Function
        
        Public Function GetEmailAddress(ByVal orderID As Integer) As String
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@OrderID", orderID)
            Return CStr(accessObj.ExecuteScalar("SCM_Orders_GetEmailByOrderID"))
        End Function



        Public Function Order_ShipingInfo_ADD(ByVal orderID As Integer, _
                                             ByVal ShipCompanyID As Integer, _
                                             ByVal ShipDate As Date, _
                                             ByVal ShipCharges As Decimal, _
                                             ByVal TrackingNo As String, _
                                             ByVal Notes As String, _
                                             ByVal ETA As String) As Integer

            Dim accessObj As DBAccess = New DBAccess()
            Dim returnVal As Integer = 0
            accessObj.AddParameter("@OrderID", orderID)
            accessObj.AddParameter("@ShipCompanyID", ShipCompanyID)
            accessObj.AddParameter("@ShipDate", ShipDate)
            accessObj.AddParameter("@ShipCharges", ShipCharges)
            accessObj.AddParameter("@TrackingNo", TrackingNo)
            accessObj.AddParameter("@Notes", Notes)
            If Not String.IsNullOrEmpty(ETA) Then
                accessObj.AddParameter("@ETA", CDate(ETA))
            Else
                accessObj.AddParameter("@ETA", DBNull.Value)
            End If
            accessObj.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            accessObj.ExecuteNonQuery("SCM_Orders_ShipingInfo_Add")
            'Getting the value if 0 the shipping has been added already else the id of shipment.
            returnVal = CInt(accessObj.Parameters("@ReturnVal").Value)
            Return returnVal

        End Function

#End Region

    End Class
End Namespace