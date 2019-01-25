Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL.UM
    Public Class Link
#Region "Private Fields"
        Private _ID As Integer
        Private _CategoryID As Integer
        Private _Title As String
        Private _Description As String
        Private _Link As String
        Private _AddedBy As Integer
        Private _AddedOn As DateTime
        Private _LastUpdatedBy As Integer
        Private _LastUpdatedOn As DateTime
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
        Public Property CategoryID() As Integer
            Get
                Return _CategoryID
            End Get
            Set(ByVal value As Integer)
                _CategoryID = value
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
        Public Property Description() As String
            Get
                Return _Description
            End Get
            Set(ByVal value As String)
                _Description = value
            End Set
        End Property
        Public Property Link() As String
            Get
                Return _Link
            End Get
            Set(ByVal value As String)
                _Link = value
            End Set
        End Property
        Public Property AddedBy() As Integer
            Get
                Return _AddedBy
            End Get
            Set(ByVal value As Integer)
                _AddedBy = value
            End Set
        End Property
        Public Property AddedOn() As DateTime
            Get
                Return _AddedOn
            End Get
            Set(ByVal value As DateTime)
                _AddedOn = value
            End Set
        End Property
        Public Property LastUpdatedBy() As Integer
            Get
                Return _LastUpdatedBy
            End Get
            Set(ByVal value As Integer)
                _LastUpdatedBy = value
            End Set
        End Property
        Public Property LastUpdatedOn() As DateTime
            Get
                Return _LastUpdatedOn
            End Get
            Set(ByVal value As DateTime)
                _LastUpdatedOn = value
            End Set
        End Property
#End Region
#Region "Public Methods"
        Public Function GetAllLinksBySearch(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataSet
            Dim ObjDALLink As New Portal.DAL.UM.Link
            Dim dsLinks As DataSet = Nothing
            dsLinks = ObjDALLink.GetAllLinksBySearch(Search, CategoryID, SortExpression, startRowIndex, maximumRows)
            Return dsLinks
        End Function
        Public Function GetAllLinksBySearchCount(ByVal Search As String, ByVal CategoryID As Integer, ByVal SortExpression As String) As Integer
            Dim ObjDALLink As New Portal.DAL.UM.Link
            Dim rowCount As Integer = 0
            rowCount = ObjDALLink.GetAllLinksBySearchCount(Search, CategoryID, SortExpression)
            Return rowCount
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim ObjDALLink As New Portal.DAL.UM.Link
            ObjDALLink.Delete(ID)
        End Function
        Public Shared Function LinkGetByID(ByVal ID As Integer) As SqlDataReader
            Dim drLink As SqlDataReader = Nothing
            drLink = Portal.DAL.UM.Link.LinkGetByID(ID)
            Return drLink
        End Function

        Public Function Add() As Integer
            Dim ID As Integer = 0
            Dim ObjDALLink As New Portal.DAL.UM.Link
            ID = ObjDALLink.Add(Me)
            Return ID
        End Function
        Public Function Update() As Integer
            Dim ReturnValue As Integer = 0
            Dim ObjDALLink As New Portal.DAL.UM.Link
            ReturnValue = ObjDALLink.Update(Me)
            Return ReturnValue
        End Function
#End Region


    End Class
End Namespace