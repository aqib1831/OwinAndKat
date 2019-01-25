Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.Client
    Public Class DBClients
#Region " Public Method "
        Public Shared Function ClientsGetAll() As List(Of Portal.BLL.Client.Clients)
            Dim colClients As New List(Of Portal.BLL.Client.Clients)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            dr = db.ExecuteReader("Clients_GetAll")
            While dr.Read()
                colClients.Add(New Portal.BLL.Client.Clients( _
                CType(dr("ID"), Integer), _
                CType(dr("Name"), String), _
                CType(dr("Code"), String), _
                CType(dr("Phone"), String), _
                CType(dr("Fax"), String), _
                CType(dr("Email"), String), _
                CType(dr("Address1"), String), _
                CType(dr("Address2"), String), _
                CType(dr("City"), String), _
                CType(dr("Zip"), String), _
                CType(dr("StateID"), Integer), _
                CType(dr("CountryID"), Integer), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("detail"), String), _
                CType(dr("BillsSendOption"), Integer), _
                CType(dr("PreferredModePayment"), Integer), _
                CType(dr("Isfeatured"), Boolean), _
                CType(dr("Image"), String), _
                CType(dr("url"), String), _
                CType(dr("logo"), String), _
                CType(dr("HasFransupport"), Boolean), _
                CType(dr("FransupportConnectionString"), String) _
                ))
            End While
            dr.Close()
            Return colClients
        End Function
        Public Shared Function ClientsGetByID(ByVal ID As Integer) As List(Of Portal.BLL.Client.Clients)
            Dim colClients As New List(Of Portal.BLL.Client.Clients)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("Clients_GetByID")
            While dr.Read()
                colClients.Add(New Portal.BLL.Client.Clients( _
                CType(dr("ID"), Integer), _
                CType(dr("Name"), String), _
                CType(dr("Code"), String), _
                CType(dr("Phone"), String), _
                CType(dr("Fax"), String), _
                CType(dr("Email"), String), _
                CType(dr("Address1"), String), _
                CType(dr("Address2"), String), _
                CType(dr("City"), String), _
                CType(dr("Zip"), String), _
                CType(dr("StateID"), Integer), _
                CType(dr("CountryID"), Integer), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("detail"), String), _
                CType(dr("BillsSendOption"), Integer), _
                CType(dr("PreferredModePayment"), Integer), _
                CType(dr("Isfeatured"), Boolean), _
                CType(dr("Image"), String), _
                CType(dr("url"), String), _
                CType(dr("logo"), String), _
                CType(dr("StateCode"), String), _
                CType(dr("CountryCode"), String) _
                ))
            End While
            dr.Close()
            Return colClients
        End Function
        Public Function Add(ByVal ClientsBll As Portal.BLL.Client.Clients) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, ClientsBll.ID)
            db.AddParameter("@Name", ClientsBll.Name)
            db.AddParameter("@Code", ClientsBll.Code)
            db.AddParameter("@Phone", ClientsBll.Phone)
            db.AddParameter("@Fax", ClientsBll.Fax)
            db.AddParameter("@Email", ClientsBll.Email)
            db.AddParameter("@Address1", ClientsBll.Address1)
            db.AddParameter("@Address2", ClientsBll.Address2)
            db.AddParameter("@City", ClientsBll.City)
            db.AddParameter("@Zip", ClientsBll.Zip)
            db.AddParameter("@StateID", IIf(ClientsBll.StateID = 0, DBNull.Value, ClientsBll.StateID))
            db.AddParameter("@CountryID", ClientsBll.CountryID)
            db.AddParameter("@Deleted", ClientsBll.Deleted)
            'db.AddParameter("@detail", ClientsBll.detail)
            db.AddParameter("@BillsSendOption", ClientsBll.BillsSendOption)
            db.AddParameter("@PreferredModePayment", ClientsBll.PreferredModePayment)
            db.AddParameter("@Isfeatured", ClientsBll.Isfeatured)
            'db.AddParameter("@Image", ClientsBll.Image)
            db.AddParameter("@url", ClientsBll.url)
            db.AddParameter("@logo", ClientsBll.logo)
            'db.AddParameter("@HasFransupport", ClientsBll.HasFransupport)
            'db.AddParameter("@FransupportConnectionString", ClientsBll.FransupportConnectionString)
            db.AddParameter("@LastUpdatedDate", DateTime.Now)
            db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))

            Dim Affected As Integer = db.ExecuteNonQuery("Clients_Add")
            Affected = CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
            Return Affected
        End Function
        Public Function Update(ByVal ClientsBll As Portal.BLL.Client.Clients) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ClientsBll.ID)
            db.AddParameter("@Name", ClientsBll.Name)
            db.AddParameter("@Code", ClientsBll.Code)
            db.AddParameter("@Phone", ClientsBll.Phone)
            db.AddParameter("@Fax", ClientsBll.Fax)
            db.AddParameter("@Email", ClientsBll.Email)
            db.AddParameter("@Address1", ClientsBll.Address1)
            db.AddParameter("@Address2", ClientsBll.Address2)
            db.AddParameter("@City", ClientsBll.City)
            db.AddParameter("@Zip", ClientsBll.Zip)
            db.AddParameter("@StateID", IIf(ClientsBll.StateID = 0, DBNull.Value, ClientsBll.StateID))
            db.AddParameter("@CountryID", ClientsBll.CountryID)
            db.AddParameter("@Deleted", ClientsBll.Deleted)
            'db.AddParameter("@detail", ClientsBll.detail)
            db.AddParameter("@BillsSendOption", ClientsBll.BillsSendOption)
            db.AddParameter("@PreferredModePayment", ClientsBll.PreferredModePayment)
            db.AddParameter("@Isfeatured", ClientsBll.Isfeatured)
            'db.AddParameter("@Image", ClientsBll.Image)
            db.AddParameter("@url", ClientsBll.url)
            db.AddParameter("@logo", ClientsBll.logo)
            'db.AddParameter("@HasFransupport", ClientsBll.HasFransupport)
            'db.AddParameter("@FransupportConnectionString", ClientsBll.FransupportConnectionString)
            db.AddParameter("@LastUpdatedDate", DateTime.Now)
            db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))

            Dim Affected As Integer = db.ExecuteNonQuery("Clients_Update")
            Return Affected
        End Function
        Public Function Delete(ByVal ID As Integer, ByVal Deleted As Boolean) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@Deleted", Deleted)
            db.AddParameter("@LastUpdatedDate", DateTime.Now)
            db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))

            Dim Affected As Integer = db.ExecuteNonQuery("Clients_Delete")
            Return Affected
        End Function
        Public Shared Function ClientDuplicateName(ByVal ID As Integer, ByVal Name As String) As Integer
            Dim ReturnValue As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Name", Name)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.ExecuteNonQuery("Clients_CheckDuplicateName")
            Dim Result As Integer = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return Result
        End Function
		
        Public Shared Function GetFransupportConnectionStringByClientID(ByVal ID As Integer) As String
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@ClientID", ID)
            Return CType(objDbAccess.ExecuteScalar("Clients_GetFransupportConnectionStringByClientID"), String)
        End Function

	Public Shared Function HasMarkTicketForApprovalByClientId(ByVal ClientId As Integer) As Boolean
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@ClientID", ClientId)
            Return CType(objDbAccess.ExecuteScalar("Client_GetMarkTicketForApproval"), Boolean)
        End Function

#End Region

    End Class
End Namespace