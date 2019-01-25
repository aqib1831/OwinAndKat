Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_Products_TechnicalInfo_Extentions
#Region " Private Members "
        Private _id As Integer
        Private _producttechnicalinfoid As Integer
        Private _productfranchiseid As Integer
        Private _contentfilteringprevious As Integer
        Private _contentfilteringnew As Integer
        Private _enteredby As Integer
        Private _enteredon As Date

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

        Public Property ProductTechnicalInfoID() As Integer
            Get
                Return _producttechnicalinfoid
            End Get
            Set(ByVal value As Integer)
                _producttechnicalinfoid = value
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

        Public Property ContentFilteringPrevious() As Integer
            Get
                Return _contentfilteringprevious
            End Get
            Set(ByVal value As Integer)
                _contentfilteringprevious = value
            End Set
        End Property

        Public Property ContentFilteringNew() As Integer
            Get
                Return _contentfilteringnew
            End Get
            Set(ByVal value As Integer)
                _contentfilteringnew = value
            End Set
        End Property

        Public Property EnteredBy() As Integer
            Get
                Return _enteredby
            End Get
            Set(ByVal value As Integer)
                _enteredby = value
            End Set
        End Property

        Public Property EnteredOn() As Date
            Get
                Return _enteredon
            End Get
            Set(ByVal value As Date)
                _enteredon = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ProductTechnicalInfoID As Integer, _
          ByVal ProductFranchiseID As Integer, _
          ByVal ContentFilteringPrevious As Integer, _
          ByVal ContentFilteringNew As Integer, _
          ByVal EnteredBy As Integer, _
          ByVal EnteredOn As Date _
         )


            Me.ID = ID
            Me.ProductTechnicalInfoID = ProductTechnicalInfoID
            Me.ProductFranchiseID = ProductFranchiseID
            Me.ContentFilteringPrevious = ContentFilteringPrevious
            Me.ContentFilteringNew = ContentFilteringNew
            Me.EnteredBy = EnteredBy
            Me.EnteredOn = EnteredOn


        End Sub
#End Region

#Region " Public Method "
        'Public Shared Function NS_Products_TechnicalInfo_ExtentionsGetAll() As List(Of NS_Products_TechnicalInfo_Extentions)
        '    Return Portal.DAL.NS.DBNS_Products_TechnicalInfo_Extentions.NS_Products_TechnicalInfo_ExtentionsGetAll()
        'End Function
        'Public Shared Function NS_Products_TechnicalInfo_ExtentionsGetByID(ByVal ID As Integer) As List(Of NS_Products_TechnicalInfo_Extentions)
        '    Return Portal.DAL.NS.DBNS_Products_TechnicalInfo_Extentions.NS_Products_TechnicalInfo_ExtentionsGetByID(ID)
        'End Function
        Public Shared Function NS_Products_TechnicalInfo_ExtentionsAdd(ByVal ID As Integer, ByVal ProductTechnicalInfoID As Integer, ByVal ProductFranchiseID As Integer, ByVal ContentFilteringPrevious As Integer, ByVal ContentFilteringNew As Integer, ByVal EnteredBy As Integer, ByVal EnteredOn As Date) As Integer
            Dim NS_Products_TechnicalInfo_ExtentionsBll As Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions = New Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions(ID, ProductTechnicalInfoID, ProductFranchiseID, ContentFilteringPrevious, ContentFilteringNew, EnteredBy, EnteredOn)
            Dim NS_Products_TechnicalInfo_ExtentionsDal As Portal.DAL.NS.DBNS_Products_TechnicalInfo_Extentions = New Portal.DAL.NS.DBNS_Products_TechnicalInfo_Extentions()
            Return NS_Products_TechnicalInfo_ExtentionsDal.Add(NS_Products_TechnicalInfo_ExtentionsBll)
        End Function

#End Region

    End Class
End Namespace