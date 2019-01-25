Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.News
    Public Class News_Users
#Region " Private Members "
        Private _id As Integer
        Private _newsid As Integer
        Private _userid As Integer

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

        Public Property NewsID() As Integer
            Get
                Return _newsid
            End Get
            Set(ByVal value As Integer)
                _newsid = value
            End Set
        End Property

        Public Property UserID() As Integer
            Get
                Return _userid
            End Get
            Set(ByVal value As Integer)
                _userid = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal NewsID As Integer, _
          ByVal UserID As Integer _
         )


            Me.ID = ID
            Me.NewsID = NewsID
            Me.UserID = UserID

        End Sub
#End Region

#Region " Public Method "
        Public Shared Function News_UsersAdd(ByVal ID As Integer, ByVal NewsID As Integer, ByVal UserID As Integer) As Integer
            Dim News_UsersBll As Portal.BLL.News.News_Users = New Portal.BLL.News.News_Users(ID, NewsID, UserID)
            Dim News_UsersDal As Portal.DAL.News.DBNews_Users = New Portal.DAL.News.DBNews_Users()
            Return News_UsersDal.Add(News_UsersBll)
        End Function
#End Region

    End Class
End Namespace