Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.News
    Public Class DBNews_Users
#Region " Public Method "
        Public Function Add(ByVal News_UsersBll As Portal.BLL.News.News_Users) As Integer
            Dim db As New DBAccess

            db.AddParameter("@NewsID", News_UsersBll.NewsID)
            db.AddParameter("@UserID", News_UsersBll.UserID)
            Dim Affected As Integer = db.ExecuteNonQuery("News_Users_Add")
            Return Affected
        End Function
#End Region

    End Class
End Namespace
