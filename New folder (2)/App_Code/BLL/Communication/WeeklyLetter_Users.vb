Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.Communication
    Public Class WeeklyLetter_Users
#Region " Private Members "
        Private _id As Integer
        Private _userid As Integer
        Private _letterid As Integer

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

        Public Property UserID() As Integer
            Get
                Return _userid
            End Get
            Set(ByVal value As Integer)
                _userid = value
            End Set
        End Property

        Public Property LetterID() As Integer
            Get
                Return _letterid
            End Get
            Set(ByVal value As Integer)
                _letterid = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal UserID As Integer, _
          ByVal LetterID As Integer _
         )


            Me.ID = ID
            Me.UserID = UserID
            Me.LetterID = LetterID


        End Sub
#End Region

#Region " Public Method "
        Public Shared Function WeeklyLetter_UsersAdd(ByVal UserID As Integer, ByVal LetterID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@LetterID", LetterID)
            Dim Affected As Integer = db.ExecuteNonQuery("WeeklyLetter_Users_Add")
            Return Affected
        End Function

#End Region

    End Class
End Namespace