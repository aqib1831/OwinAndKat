Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.News
    Public Class DBNews
#Region " Public Method "
        Public Shared Function NewsGetByID(ByVal NewsID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@NewsID", NewsID)
            Return db.ExecuteDataTable("News_GetByID")
        End Function
        Public Shared Function NewsGetByUserID(ByVal UserID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            Return db.ExecuteDataTable("News_GetByUserID")
        End Function
        Public Shared Function NewsGetByUserIDForHome() As DataTable
            Dim db As New DBAccess
            Return db.ExecuteDataTable("News_GetByUserIDForHome")
        End Function
        Public Function Add(ByVal [Date] As Date, ByVal Headline As String, ByVal News As String, ByVal Deleted As Boolean, ByVal IsNotice As Boolean, ByVal WeeklyLetterID As Integer, ByVal AddedBy As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@Date", [Date])
            db.AddParameter("@Headline", Headline)
            db.AddParameter("@News", News)
            db.AddParameter("@Deleted", Deleted)
            db.AddParameter("@IsNotice", IsNotice)
            db.AddParameter("@WeeklyLetterID", WeeklyLetterID)
            db.AddParameter("@AddedBy", AddedBy)

            Dim Affected As Integer = db.ExecuteNonQuery("News_Add")
            Return Affected
        End Function
#End Region

    End Class
End Namespace