Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_Products_Franchises_Extentions
#Region " Private Members "
        Private _id As Integer
        Private _productid As Integer
        Private _franchiseid As Integer
        Private _extendedfromdate As Date
        Private _extendedtodate As Date
        Private _supportstartdate As Date
        Private _supportenddate As Date
        Private _updatedby As Integer
        Private _updatedon As Date
        Private _price As Decimal
        Private _onsupport As Boolean
        Private _type As Integer
        Private _notes As String
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

        Public Property ExtendedFromDate() As Date
            Get
                Return _extendedfromdate
            End Get
            Set(ByVal value As Date)
                _extendedfromdate = value
            End Set
        End Property

        Public Property ExtendedToDate() As Date
            Get
                Return _extendedtodate
            End Get
            Set(ByVal value As Date)
                _extendedtodate = value
            End Set
        End Property

        Public Property SupportStartDate() As Date
            Get
                Return _supportstartdate
            End Get
            Set(ByVal value As Date)
                _supportstartdate = value
            End Set
        End Property

        Public Property SupportEndDate() As Date
            Get
                Return _supportenddate
            End Get
            Set(ByVal value As Date)
                _supportenddate = value
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

        Public Property UpdatedOn() As Date
            Get
                Return _updatedon
            End Get
            Set(ByVal value As Date)
                _updatedon = value
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

        Public Property OnSupport() As Boolean
            Get
                Return _onsupport
            End Get
            Set(ByVal value As Boolean)
                _onsupport = value
            End Set
        End Property

        Public Property Type() As Integer
            Get
                Return _type
            End Get
            Set(ByVal value As Integer)
                _type = value
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
#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ProductID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal ExtendedFromDate As Date, _
          ByVal ExtendedToDate As Date, _
          ByVal SupportStartDate As Date, _
          ByVal SupportEndDate As Date, _
          ByVal UpdatedBy As Integer, _
          ByVal UpdatedOn As Date, _
          ByVal Price As Decimal, _
          ByVal OnSupport As Boolean, _
          ByVal Type As Integer, _
          ByVal Notes As String _
         )


            Me.ID = ID
            Me.ProductID = ProductID
            Me.FranchiseID = FranchiseID
            Me.ExtendedFromDate = ExtendedFromDate
            Me.ExtendedToDate = ExtendedToDate
            Me.SupportStartDate = SupportStartDate
            Me.SupportEndDate = SupportEndDate
            Me.UpdatedBy = UpdatedBy
            Me.UpdatedOn = UpdatedOn
            Me.Price = Price
            Me.OnSupport = OnSupport
            Me.Type = Type
            Me.Notes = Notes

        End Sub
#End Region

#Region " Public Method "

        Public Shared Function NS_Products_Franchises_ExtentionsGetByID(ByVal ID As Integer) As List(Of NS_Products_Franchises_Extentions)
            Return Portal.DAL.NS.DBNS_Products_Franchises_Extentions.NS_Products_Franchises_ExtentionsGetByID(ID)
        End Function
        Public Shared Function NS_Products_Franchises_ExtentionsAdd(ByVal ID As Integer, ByVal ProductID As Integer, ByVal FranchiseID As Integer, ByVal ExtendedFromDate As Date, ByVal ExtendedToDate As Date, ByVal SupportStartDate As Date, ByVal SupportEndDate As Date, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date, ByVal Price As Decimal, ByVal OnSupport As Boolean, ByVal Type As Integer, ByVal Notes As String) As Integer
            Dim NS_Products_Franchises_ExtentionsBll As Portal.BLL.NS.NS_Products_Franchises_Extentions = New Portal.BLL.NS.NS_Products_Franchises_Extentions(ID, ProductID, FranchiseID, ExtendedFromDate, ExtendedToDate, SupportStartDate, SupportEndDate, UpdatedBy, UpdatedOn, Price, OnSupport, Type, Notes)
            Dim NS_Products_Franchises_ExtentionsDal As Portal.DAL.NS.DBNS_Products_Franchises_Extentions = New Portal.DAL.NS.DBNS_Products_Franchises_Extentions()
            Return NS_Products_Franchises_ExtentionsDal.Add(NS_Products_Franchises_ExtentionsBll)
        End Function

#End Region

    End Class
End Namespace