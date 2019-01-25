Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.Orders
    Public Class SCM_OrderItems
#Region " Private Members "
        Private _id As Integer
        Private _orderid As Integer
        Private _productid As Integer
        Private _quantity As Integer
        Private _unitprice As Decimal
        Private _totalprice As Decimal

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

        Public Property OrderID() As Integer
            Get
                Return _orderid
            End Get
            Set(ByVal value As Integer)
                _orderid = value
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

        Public Property Quantity() As Integer
            Get
                Return _quantity
            End Get
            Set(ByVal value As Integer)
                _quantity = value
            End Set
        End Property

        Public Property UnitPrice() As Decimal
            Get
                Return _unitprice
            End Get
            Set(ByVal value As Decimal)
                _unitprice = value
            End Set
        End Property

        Public Property TotalPrice() As Decimal
            Get
                Return _totalprice
            End Get
            Set(ByVal value As Decimal)
                _totalprice = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal OrderID As Integer, _
          ByVal ProductID As Integer, _
          ByVal Quantity As Integer, _
          ByVal UnitPrice As Decimal, _
          ByVal TotalPrice As Decimal _
         )


            Me.ID = ID
            Me.OrderID = OrderID
            Me.ProductID = ProductID
            Me.Quantity = Quantity
            Me.UnitPrice = UnitPrice
            Me.TotalPrice = TotalPrice


        End Sub
#End Region

#Region " Public Method "
        'Public Shared Function SCM_OrderItemsGetAll() As List(Of SCM_OrderItems)
        '    Return Portal.DAL.Orders.DBSCM_OrderItems.SCM_OrderItemsGetAll()
        'End Function
        'Public Shared Function SCM_OrderItemsGetByID(ByVal ID As Integer) As List(Of SCM_OrderItems)
        '    Return Portal.DAL.Orders.DBSCM_OrderItems.SCM_OrderItemsGetByID(ID)
        'End Function
        'Public Shared Function SCM_OrderItemsAdd(ByVal ID As Integer, ByVal OrderID As Integer, ByVal ProductID As Integer, ByVal Quantity As Integer, ByVal UnitPrice As Decimal, ByVal TotalPrice As Decimal) As Integer
        '    Dim SCM_OrderItemsBll As Portal.BLL.Orders.SCM_OrderItems = New Portal.BLL.Orders.SCM_OrderItems(ID, OrderID, ProductID, Quantity, UnitPrice, TotalPrice)
        '    Dim SCM_OrderItemsDal As Portal.DAL.Orders.DBSCM_OrderItems = New Portal.DAL.Orders.DBSCM_OrderItems()
        '    Return SCM_OrderItemsDal.Add(SCM_OrderItemsBll)
        'End Function

        Public Shared Function GetOrderDetailbyID(ByVal orderID As Integer) As System.Data.SqlClient.SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@orderID", SqlDbType.Int, 4, ParameterDirection.Input, orderID)
            Return db.ExecuteReader("SCM_Get_OrderDetailByID")
        End Function

#End Region

    End Class
End Namespace