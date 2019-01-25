Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.BLL
    Public Class NSProducts

#Region "Private Members"
        Private _ID As Integer
        Private _Title As String
        Private _Abbreviation As String
        Private _Type As Integer
        Private _Price As Decimal
        Private _PriceOption As Integer
        Private _MonthlySupportPrice As Decimal
        Private _ParentID As Integer
        Private _ParentTitle As String
        Private _CheckForSupport As Boolean
#End Region
#Region "Constructures"
        Public Sub New()

        End Sub
        Public Sub New(ByVal ID As Integer, ByVal Title As String, ByVal Abbreviation As String, _
        ByVal Type As Integer, ByVal Price As Decimal, ByVal CheckForSupport As Boolean) 'ByVal MonthlySupportPrice As Decimal

            Me.ID = ID
            Me.Title = Title
            Me.Abbreviation = Abbreviation
            Me.Type = Type
            Me.Price = Price
            Me.CheckForSupport = CheckForSupport
            ' Me.MonthlySupportPrice = MonthlySupportPrice
        End Sub
        Public Sub New(ByVal ID As Integer, ByVal Title As String, ByVal Abbreviation As String, _
        ByVal Type As Integer, ByVal Price As Decimal, ByVal ParentTitle As String) 'ByVal MonthlySupportPrice As Decimal

            Me.ID = ID
            Me.Title = Title
            Me.Abbreviation = Abbreviation
            Me.Type = Type
            Me.Price = Price
            Me.ParentTitle = ParentTitle
            ' Me.MonthlySupportPrice = MonthlySupportPrice
        End Sub
        Public Sub New(ByVal ID As Integer, ByVal Title As String, ByVal Abbreviation As String, _
       ByVal Type As Integer, ByVal Price As Decimal, ByVal ParentID As Integer)
            Me.ID = ID
            Me.Title = Title
            Me.Abbreviation = Abbreviation
            Me.Type = Type
            Me.Price = Price
            Me.ParentID = ParentID
        End Sub
#End Region
#Region "Public Properties"
        Public Property ID() As Integer
            Get
                Return _ID
            End Get
            Set(ByVal value As Integer)
                _ID = value
            End Set
        End Property
        Public Property Title() As String
            Get
                Return _Title
            End Get
            Set(ByVal value As String)
                _Title = value
            End Set
        End Property
        Public Property Abbreviation() As String
            Get
                Return _Abbreviation
            End Get
            Set(ByVal value As String)
                _Abbreviation = value
            End Set
        End Property
        Public Property Type() As Integer
            Get
                Return _Type
            End Get
            Set(ByVal value As Integer)
                _Type = value
            End Set
        End Property
        Public Property Price() As Decimal
            Get
                Return _Price
            End Get
            Set(ByVal value As Decimal)
                _Price = value
            End Set
        End Property
        Public Property PriceOption() As Integer
            Get
                Return _PriceOption
            End Get
            Set(ByVal value As Integer)
                _PriceOption = value
            End Set
        End Property
        Public Property MonthlySupportPrice() As Decimal
            Get
                Return _MonthlySupportPrice
            End Get
            Set(ByVal value As Decimal)
                _MonthlySupportPrice = value
            End Set
        End Property
        Public Property ParentID() As Integer
            Get
                Return _ParentID
            End Get
            Set(ByVal value As Integer)
                _ParentID = value
            End Set
        End Property
        Public Property ParentTitle() As String
            Get
                Return _ParentTitle
            End Get
            Set(ByVal value As String)
                _ParentTitle = value
            End Set
        End Property

        Public Property CheckForSupport() As Boolean
            Get
                Return _CheckForSupport
            End Get
            Set(ByVal value As Boolean)
                _CheckForSupport = value
            End Set
        End Property

#End Region
#Region "Public Methods"
        Public Shared Function ProductsGetAll(ByVal Search As String, ByVal Type As Integer, ByVal sortExpression As String) As List(Of Portal.BLL.NSProducts)
            Return Portal.DAL.DBNSProducts.ProductsGetAll(Search, Type, sortExpression)
        End Function
        Public Shared Function ProductsGetAllCount(ByVal Search As String, ByVal Type As Integer, ByVal sortExpression As String) As Integer
            Return Portal.DAL.DBNSProducts.ProductsGetAllCount(Search, Type, sortExpression)
        End Function
        Public Shared Function NS_ProductsGetByID(ByVal ID As Integer) As List(Of NSProducts)
            Return Portal.DAL.DBNSProducts.NS_ProductsGetByID(ID)
        End Function
        Public Shared Function Add(ByVal ObjNSProduct As NSProducts) As Integer
            Return Portal.DAL.DBNSProducts.Add(ObjNSProduct)
        End Function
        Public Shared Function GetModulesByProductsID(ByVal Search As String, ByVal Type As Integer, ByVal sortExpression As String, ByVal ParentID As Integer) As List(Of Portal.BLL.NSProducts)
            Return Portal.DAL.DBNSProducts.GetModulesByProductsID(Search, Type, sortExpression, ParentID)
        End Function
        Public Shared Function AddModule(ByVal ObjNSProduct As NSProducts) As Integer
            Return Portal.DAL.DBNSProducts.AddModule(ObjNSProduct)
        End Function
        Public Shared Function GetProductsAndModules(ByVal ClientID As Integer) As DataSet
            Return Portal.DAL.DBNSProducts.GetProductsAndModules(ClientID)
        End Function
        Public Shared Function AddClientProuducts(ByVal ProductIDs As String, ByVal BillTo As String, ByVal ClientID As Integer) As Integer
            Return Portal.DAL.DBNSProducts.AddClientProuducts(ProductIDs, BillTo, ClientID)
        End Function
        Public Shared Function GetProductByID(ByVal ProductID) As SqlDataReader
            Return Portal.DAL.DBNSProducts.GetProductByID(ProductID)
        End Function

#End Region

        Public Shared Function GetDataSet(ByVal ClientID As Integer) As DataSet
            Dim objProduct As New Portal.DAL.DBNSProducts
            Return objProduct.GetDataSet(ClientID)
        End Function
        Public Shared Sub UpdateDataSet(ByRef ds_Products As DataSet)
            Dim objProduct As New Portal.DAL.DBNSProducts
            objProduct.UpdateDataSet(ds_Products)
        End Sub
        Public Shared Function GetModuleByID(ByVal ID As Integer) As SqlDataReader
            Return Portal.DAL.DBNSProducts.GetModuleByID(ID)
        End Function
        Public Shared Function UpdateModule(ByVal obj As Portal.BLL.NSProducts) As Integer
            Return Portal.DAL.DBNSProducts.UpdateModule(obj)
        End Function
        Public Shared Function UpdateProduct(ByVal obj As Portal.BLL.NSProducts) As Integer
            Return Portal.DAL.DBNSProducts.UpdateProduct(obj)
        End Function
        Public Shared Function GetClientProductsByFranchiseID(ByVal FranchiseID As Integer, ByVal ClientID As Integer) As DataSet
            Return Portal.DAL.DBNSProducts.GetClientProductsByFranchiseID(FranchiseID, ClientID)
        End Function

        Public Shared Function ShouldCheckForSupport(ByVal ProductID As Integer) As Boolean
            Return Portal.DAL.DBNSProducts.ShouldCheckForSupport(ProductID)
        End Function
    End Class
End Namespace