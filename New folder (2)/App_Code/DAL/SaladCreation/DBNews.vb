Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL
    Public Class SC_DBNews
#Region " Public Method "
        Public Shared Function NewsGetAll() As List(Of Portal.BLL.SC_News)
            Dim colNews As New List(Of Portal.BLL.SC_News)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("SaladCreationConnectionString")
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
            dr = db.ExecuteReader("Portal_News_GetAll")
            While dr.Read()
                colNews.Add(New Portal.BLL.SC_News( _
                CType(dr("ID"), Integer), _
                CType(dr("Date"), Date), _
                CType(dr("Headline"), String), _
                CType(dr("News"), String), _
                CType(dr("IsNotice"), Boolean), _
                False, _
                CType(dr("Deleted"), Boolean) _
                ))
            End While
            dr.Close()
            Return colNews
        End Function

        Public Shared Function GetNewsByID(ByVal ID As Integer) As List(Of Portal.BLL.SC_News)
            Dim colNews As New List(Of Portal.BLL.SC_News)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("SaladCreationConnectionString")
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("Portal_GetNewsByID")
            While dr.Read()
                colNews.Add(New Portal.BLL.SC_News( _
                CType(dr("ID"), Integer), _
                CType(dr("Date"), Date), _
                CType(dr("Headline"), String), _
                CType(dr("News"), String), _
                CType(dr("IsNotice"), Boolean), _
                False, _
                CType(dr("Deleted"), Boolean) _
                ))
            End While
            dr.Close()
            Return colNews
        End Function

#End Region

    End Class
End Namespace