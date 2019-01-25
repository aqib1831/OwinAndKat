Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL.UM

    Public Class Category
#Region "Private Fields"
        Private _ID As Integer
        Private _Title As String
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
        Public Property Title() As String
            Get
                Return _Title
            End Get
            Set(ByVal value As String)
                _Title = value
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
        
        Public Function GetAllCategoriesBySearch(ByVal Search As String, ByVal SortExpression As String) As DataSet
            Dim dsCategories As DataSet = Nothing
            Dim objCategory As Portal.DAL.UM.Category = New Portal.DAL.UM.Category
            dsCategories = objCategory.GetAllCategoriesBySearch(Search, SortExpression)
            Return dsCategories
        End Function

        Public Function Add() As Integer
            Dim ObjDALCategory As New Portal.DAL.UM.Category
            Dim ID As Integer = 0
            ID = ObjDALCategory.Add(Me)
            Return ID
        End Function

        Public Function Update() As Integer
            Dim ObjDALCategory As New Portal.DAL.UM.Category
            Dim returnValue As Integer = 0
            returnValue = ObjDALCategory.Update(Me)
            Return returnValue
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim ObjDALCategory As New Portal.DAL.UM.Category
            Dim returnValue As Integer = 0
            returnValue = ObjDALCategory.Delete(ID)
            Return returnValue
        End Function
        Public Shared Function SearchUserManual(ByVal Search As String) As SqlDataReader
            Dim drSearchUserManual As SqlDataReader = Nothing
            drSearchUserManual = Portal.DAL.UM.Category.SearchUserManual(Search)
            Return drSearchUserManual
        End Function
        Public Shared Function GetByID(ByVal ID As Integer) As SqlDataReader
            Return Portal.DAL.UM.Category.GetByID(ID)
        End Function
#End Region
    End Class
End Namespace
