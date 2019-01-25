Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_Products_Clients
#Region " Public Method "
        Public Shared Function NS_Products_ClientsGetAll() As List(Of Portal.BLL.NS.NS_Products_Clients)
            Dim colNS_Products_Clients As New List(Of Portal.BLL.NS.NS_Products_Clients)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            dr = db.ExecuteReader("NS_Products_Clients_GetAll")
            While dr.Read()
                colNS_Products_Clients.Add(New Portal.BLL.NS.NS_Products_Clients( _
                CType(dr("ID"), Integer), _
                CType(dr("ProductID"), Integer), _
                CType(dr("ClientID"), Integer), _
                CType(dr("BillTo"), Integer), _
                CType(dr("CorporatePay"), Decimal), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("Price"), Decimal), _
                CType(dr("CorporatePayType"), Integer) _
                ))
            End While
            dr.Close()
            Return colNS_Products_Clients
        End Function
        Public Shared Function NS_Products_ClientsGetByID(ByVal ID As Integer) As List(Of Portal.BLL.NS.NS_Products_Clients)
            Dim colNS_Products_Clients As New List(Of Portal.BLL.NS.NS_Products_Clients)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("NS_Products_Clients_GetByID")
            While dr.Read()
                colNS_Products_Clients.Add(New Portal.BLL.NS.NS_Products_Clients( _
                CType(dr("ID"), Integer), _
                CType(dr("ProductID"), Integer), _
                CType(dr("ClientID"), Integer), _
                CType(dr("BillTo"), Integer), _
                CType(dr("CorporatePay"), Decimal), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("Price"), Decimal), _
                CType(dr("CorporatePayType"), Integer) _
                ))
            End While
            dr.Close()
            Return colNS_Products_Clients
        End Function
        Public Shared Function NS_Products_ClientsGetByClientID(ByVal ClientID As Integer, ByVal ProductID As Integer) As List(Of Portal.BLL.NS.NS_Products_Clients)
            Dim colNS_Products_Clients As New List(Of Portal.BLL.NS.NS_Products_Clients)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@ProductID", ProductID)
            dr = db.ExecuteReader("NS_Products_Clients_GetByClientIDAndProductID")
            While dr.Read()
                colNS_Products_Clients.Add(New Portal.BLL.NS.NS_Products_Clients( _
                CType(dr("ID"), Integer), _
                CType(dr("ProductID"), Integer), _
                CType(dr("ClientID"), Integer), _
                CType(dr("BillTo"), Integer), _
                CType(dr("CorporatePay"), Decimal), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("Price"), Decimal), _
                CType(dr("CorporatePayType"), Integer) _
                ))
            End While
            dr.Close()
            Return colNS_Products_Clients
        End Function
        'Public Function Add(ByVal NS_Products_ClientsBll As Portal.BLL.NS.NS_Products_Clients) As Integer
        '    Dim db As New DBAccess

        '    'db.AddParameter("@ID", NS_Products_ClientsBll.ID)
        '    db.AddParameter("@ProductID", NS_Products_ClientsBll.ProductID)
        '    db.AddParameter("@ClientID", NS_Products_ClientsBll.ClientID)
        '    db.AddParameter("@BillTo", NS_Products_ClientsBll.BillTo)
        '    db.AddParameter("@CorporatePay", IIf(NS_Products_ClientsBll.CorporatePay = 0, DBNull.Value, NS_Products_ClientsBll.CorporatePay))
        '    db.AddParameter("@Deleted", NS_Products_ClientsBll.Deleted)
        '    db.AddParameter("@Price", NS_Products_ClientsBll.Price)
        '    db.AddParameter("@CorporatePayType", NS_Products_ClientsBll.CorporatePayType)
        '    db.AddParameter("@LastUpdatedDate", DateTime.Now)
        '    db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))

        '    Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Clients_Add")
        '    Return Affected
        'End Function
        'Public Function DeleteByClientID(ByVal ClientID As Integer) As Integer
        '    Dim db As New DBAccess
        '    db.AddParameter("@ClientID", ClientID)
        '    db.AddParameter("@LastUpdatedDate", DateTime.Now)
        '    db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))
        '    Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Clients_DeleteByClientID")
        '    Return Affected
        'End Function


        Public Function AddWithTranction(ByVal colNS_Products_Clients As List(Of Portal.BLL.NS.NS_Products_Clients), ByVal ClientID As Integer) As Integer
            Dim Affected As Integer = 0
            Dim trnOpenTrainingSession As SqlTransaction
            Dim connDB As New SqlConnection(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand()
            connDB.Open()
            trnOpenTrainingSession = connDB.BeginTransaction()
            Try

                cmd.Connection = connDB
                cmd.Transaction = trnOpenTrainingSession
                cmd.CommandType = CommandType.StoredProcedure

                cmd.CommandText = "NS_Products_Clients_DeleteByClientID"
                cmd.Parameters.AddWithValue("@ClientID", ClientID)
                cmd.Parameters.AddWithValue("@LastUpdatedDate", DateTime.Now)
                cmd.Parameters.AddWithValue("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))
                cmd.ExecuteNonQuery()
                cmd.Parameters.Clear()


                cmd.CommandText = "NS_Products_Clients_Add"
                For i As Integer = 0 To colNS_Products_Clients.Count - 1 Step 1
                    cmd.Parameters.AddWithValue("@ProductID", colNS_Products_Clients.Item(i).ProductID)
                    cmd.Parameters.AddWithValue("@ClientID", colNS_Products_Clients.Item(i).ClientID)
                    cmd.Parameters.AddWithValue("@BillTo", colNS_Products_Clients.Item(i).BillTo)
                    cmd.Parameters.AddWithValue("@CorporatePay", IIf(colNS_Products_Clients.Item(i).CorporatePay = 0, DBNull.Value, colNS_Products_Clients.Item(i).CorporatePay))
                    cmd.Parameters.AddWithValue("@Deleted", colNS_Products_Clients.Item(i).Deleted)
                    cmd.Parameters.AddWithValue("@Price", colNS_Products_Clients.Item(i).Price)
                    cmd.Parameters.AddWithValue("@CorporatePayType", colNS_Products_Clients.Item(i).CorporatePayType)
                    cmd.Parameters.AddWithValue("@LastUpdatedDate", DateTime.Now)
                    cmd.Parameters.AddWithValue("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))
                    cmd.ExecuteNonQuery()
                    cmd.Parameters.Clear()
                Next

                trnOpenTrainingSession.Commit()
                Affected = 1
            Catch ex As Exception
                trnOpenTrainingSession.Rollback()
                Affected = 0
            Finally
                connDB.Close()
                connDB.Dispose()
                connDB = Nothing
                trnOpenTrainingSession.Dispose()
                trnOpenTrainingSession = Nothing
            End Try
            Return Affected
        End Function

#End Region

    End Class
End Namespace