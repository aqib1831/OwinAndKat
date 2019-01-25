Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL
    Public Class FR_News
#Region " Public Method "
        Public Shared Function NewsGetAll() As List(Of Portal.BLL.FR_News)
            Dim colNews As New List(Of Portal.BLL.FR_News)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("FrutationConnectionString")
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
            dr = db.ExecuteReader("Portal_News_GetAll")
            While dr.Read()
                colNews.Add(New Portal.BLL.FR_News( _
                CType(dr("ID"), Integer), _
                CType(dr("Date"), Date), _
                CType(dr("Headline"), String), _
                CType(dr("News"), String), _
                CType(dr("IsNotice"), Boolean), _
                CType(dr("ForManager"), Boolean), _
                CType(dr("Deleted"), Boolean) _
                ))
            End While
            dr.Close()
            Return colNews
        End Function

        Public Shared Function GetNewsByID(ByVal ID As Integer) As List(Of Portal.BLL.FR_News)
            Dim colNews As New List(Of Portal.BLL.FR_News)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("FrutationConnectionString")
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("Portal_GetNewsByID")
            While dr.Read()
                colNews.Add(New Portal.BLL.FR_News( _
                CType(dr("ID"), Integer), _
                CType(dr("Date"), Date), _
                CType(dr("Headline"), String), _
                CType(dr("News"), String), _
                CType(dr("IsNotice"), Boolean), _
                CType(dr("ForManager"), Boolean), _
                CType(dr("Deleted"), Boolean) _
                ))
            End While
            dr.Close()
            Return colNews
        End Function


#End Region

    End Class
End Namespace