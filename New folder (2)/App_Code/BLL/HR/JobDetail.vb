Imports Microsoft.VisualBasic
Imports Portal.DAL
Imports System.Collections.Generic

Namespace Portal.BLL.HR
    Public Class JobDetail
#Region " Private Members "
        Private _id As Integer
        Private _jobId As Integer
        Private _name As String
        Private _attributeId As Integer
        Private _deleted As Boolean
        Private _parentId As Integer
        Private _subItemsList As JobDetailList
#End Region

#Region " Constructor "
        Public Sub New()
        End Sub

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

        Public Property JobID() As Integer
            Get
                Return _jobId
            End Get
            Set(ByVal value As Integer)
                _jobId = value
            End Set
        End Property

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal value As String)
                _name = value
            End Set
        End Property

        Public Property AttributeID() As Integer
            Get
                Return _attributeId
            End Get
            Set(ByVal value As Integer)
                _attributeId = value
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

        Public Property ParentID() As Integer
            Get
                Return _parentId
            End Get
            Set(ByVal value As Integer)
                _parentId = value
            End Set
        End Property

        Public Property SubItemsList() As JobDetailList
            Get
                Return _subItemsList
            End Get
            Set(ByVal value As JobDetailList)
                _subItemsList = value
            End Set
        End Property
#End Region
    End Class


    Public Class JobDetailList
        Inherits List(Of JobDetail)
    End Class
End Namespace