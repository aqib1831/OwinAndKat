Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Imports Portal.BLL.Client

Namespace Portal.DAL.Client
    Public Class DBClient_Contacts
#Region " Public Method "
        Public Shared Function Client_ContactsGetByID(ByVal ID As Integer) As List(Of Client_Contacts)
            Dim lstClientContacts As New List(Of Client_Contacts)()
            Dim objClientContacts As New Client_Contacts
            Dim drClientDetails As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            drClientDetails = db.ExecuteReader("Client_Contacts_GetByID")
            Try
                If drClientDetails.Read() Then
                    With objClientContacts
                        .ID = drClientDetails("ID")
                        .ClientID = drClientDetails("ClientID")
                        .AdminID = drClientDetails("AdminId")
                        .AreaDeveloperID = drClientDetails("AreaDeveloperID")
                        .ContactID = drClientDetails("ContactID")
                        .FirstName = drClientDetails("FirstName")
                        .MiddleName = drClientDetails("MiddleName")
                        .LastName = drClientDetails("LastName")
                        .Gender = drClientDetails("Gender")
                        .JobTitle = drClientDetails("JobTitle")
                        .HomePhone = drClientDetails("HomePhone")
                        .WorkPhone = drClientDetails("WorkPhone")
                        .CellPhone = drClientDetails("CellPhone")
                        .Fax = drClientDetails("Fax")
                        .Email1 = drClientDetails("Email1")
                        .Email2 = drClientDetails("Email2")
                        .Address = drClientDetails("Address")
                        .Address2 = drClientDetails("Address2")
                        .City = drClientDetails("City")
                        .Zip = drClientDetails("Zip")
                        .StateID = drClientDetails("StateID")
                        .CountryID = drClientDetails("CountryID")
                        .ContactType = drClientDetails("ContactType")
                        .UserName = drClientDetails("UserName")
                        .IsAdmin = drClientDetails("IsAdmin")
                        .HasPMFullAccess = drClientDetails("HasPMFullAccess")
                        .HasTicketApprovalAccess = drClientDetails("HasTicketApprovalAccess")
                        .HasURLMAccess = drClientDetails("HasURLMAccess")
                        '.Notes = Functions.IfNull(drClientDetails("Notes"), "")
                        '.StatusChangedDate = Functions.IfNull(drClientDetails("ChangedDate"), DateTime.MinValue)
                        '.StatusChangedBy = Functions.IfNull(drClientDetails("ChangedBy"), "")
                        '.Status = Functions.IfNull(drClientDetails("Status"), 0)
                    End With
                    lstClientContacts.Add(objClientContacts)
                End If
            Catch ex As Exception
                Throw ex
            Finally
                If drClientDetails.IsClosed() = False Then
                    drClientDetails.Close()
                End If
            End Try

            Return lstClientContacts
        End Function
        Public Function ResetStatus(ByVal ID As Integer, ByVal Status As Boolean) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Inactive", Status)
            Dim Affected As Integer = db.ExecuteNonQuery("ClientContact_ResetStatusByID")
            Return Affected
        End Function
        Public Function GetClients() As String(,)
            Dim tbClients As DataTable = New DataTable
            tbClients.Columns.Add("ID")
            tbClients.Columns.Add("Name")
            tbClients.Columns.Add("Code")
            tbClients.Columns.Add("Deleted")
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            Dim count As Integer = 0
            dr = db.ExecuteReader("Clients_GetAll")
            While dr.Read()
                Dim drow As DataRow = tbClients.NewRow()
                drow("ID") = dr("ID").ToString()
                drow("Name") = dr("Name").ToString()
                drow("Code") = dr("Code").ToString()
                drow("Deleted") = dr("Deleted").ToString()
                tbClients.Rows.Add(drow)
                count = count + 1
            End While
            Dim strClient(count, 3) As String
            For i As Integer = 0 To count - 1
                strClient(i, 0) = tbClients.Rows(i)(0).ToString()
                strClient(i, 1) = tbClients.Rows(i)(1).ToString()
                strClient(i, 2) = tbClients.Rows(i)(2).ToString()
                strClient(i, 3) = tbClients.Rows(i)(3).ToString()
            Next
            Return strClient
        End Function
        Public Function AccessDelete(ByVal UserID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ClientContactID", UserID)
            Dim Affected As Integer = db.ExecuteNonQuery("ClientContactClientSubModule_DeleteByUserID")
            Return Affected
        End Function
        Public Function SQLInsert(ByVal Query As String) As Integer
            Dim db As New DBAccess
            Dim Affected As Integer = db.ExecuteDynamicQuery(Query)
            Return Affected
        End Function
        Public Function GetModules_SubModules(ByVal UserID As Integer, ByVal ClientID As Integer) As DataSet

            Dim colUsers As New List(Of Portal.BLL.Client.Client_Contacts())
            Dim ds As DataSet
            Dim db As New DBAccess
            db.AddParameter("@ClientContactID", UserID)
            db.AddParameter("@ClientID", ClientID)
            ds = db.ExecuteDataSet("ModulesSubModules_Client_GetAll_ForClientContact")
            Return ds
        End Function
        Public Shared Function ClientsContactsGetAllCount(ByVal ClientID As Integer, ByVal UserType As Integer, ByVal InActive As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Dim colClients As New List(Of Portal.BLL.Client.Client_Contacts)()
            Dim db As New DBAccess
            Dim paramActive As Object
            If InActive = 0 Then
                paramActive = DBNull.Value
            ElseIf InActive = 1 Then
                paramActive = False
            Else
                paramActive = True
            End If
            db.AddParameter("@ClientID", ClientID)

            If UserType <> -1 Then
                db.AddParameter("@UserType", UserType)
            Else
                db.AddParameter("@UserType", DBNull.Value)
            End If
           
            db.AddParameter("@InActive", paramActive)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("Clients_Contact_GetAll_Count"))
        End Function
        Public Shared Function GetClientContactEmails(ByVal FranchiseID As Integer) As System.Collections.ArrayList
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            Dim list As New System.Collections.ArrayList()
            db.AddParameter("@ID", FranchiseID)
            dr = db.ExecuteReader("Franchises_FranchiseContactsEmails_GetByFranchiseID")
            Dim StrEmail As String = Nothing
            While dr.Read()
                StrEmail = ""
                StrEmail = CType(dr("FirstName"), String)
                StrEmail = StrEmail + " "
                StrEmail = StrEmail + CType(Functions.IfNull(dr("LastName"), ""), String)
                StrEmail = StrEmail + ","
                StrEmail = StrEmail + CType(dr("Email1"), String)
                StrEmail = StrEmail + ","
                StrEmail = StrEmail + CType(dr("ID"), String)
                list.Add(StrEmail)
            End While
            dr.Close()
            Return list
        End Function


        Public Shared Function ClientsContactsGetAll(ByVal ClientID As Integer, ByVal UserType As Integer, ByVal InActive As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Dim db As New DBAccess
            Dim paramActive As Object
            If InActive = 0 Then
                paramActive = DBNull.Value
            ElseIf InActive = 1 Then
                paramActive = False
            Else
                paramActive = True
            End If
            db.AddParameter("@ClientID", ClientID)

            If UserType <> -1 Then
                db.AddParameter("@UserType", UserType)
            Else
                db.AddParameter("@UserType", DBNull.Value)
            End If

            db.AddParameter("@InActive", paramActive)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            If (String.IsNullOrEmpty(txtsearch)) Then
                db.AddParameter("@searchtxt", DBNull.Value)
            Else
                db.AddParameter("@searchtxt", txtsearch)
            End If

            Return db.ExecuteDataTable("Clients_Contact_GetAll")
        End Function
        Public Shared Function ClientsContactsGetNotes(ByVal UserID As Integer) As Portal.BLL.Client.ClientContactNotes
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            Dim objClientContactsNotes As New Portal.BLL.Client.ClientContactNotes
            db.AddParameter("@UserID", UserID)
            Try
                dr = db.ExecuteReader("Clients_Contact_Get_Notes")
                If dr.Read() Then
                    objClientContactsNotes.Notes = CType(dr("Notes"), String)
                    objClientContactsNotes.ChangedBy = CType(dr("ChangedBy"), String)
                    objClientContactsNotes.Status = CType(dr("Status"), Boolean)
                    objClientContactsNotes.ChangedDate = CType(dr("ChangedDate"), DateTime)
                End If
                Return objClientContactsNotes
            Catch ex As Exception
                Throw ex
            Finally
                dr.Close()
            End Try
        End Function
        Public Shared Function Add(ByVal objClientContacts As Portal.BLL.Client.Client_Contacts) As Integer
            Dim db As New DBAccess

            'db.AddParameter("@ID", Client_ContactsBll.ID)
            db.AddParameter("@ClientID", objClientContacts.ClientID)
            db.AddParameter("@AdminID", IIf(objClientContacts.AdminID = 0, DBNull.Value, objClientContacts.AdminID))
            db.AddParameter("@AreaDeveloperID", IIf(objClientContacts.AreaDeveloperID = 0, DBNull.Value, objClientContacts.AreaDeveloperID))
            db.AddParameter("@ContactID", IIf(objClientContacts.ContactID = 0, DBNull.Value, objClientContacts.ContactID))
            db.AddParameter("@FirstName", objClientContacts.FirstName)
            db.AddParameter("@MiddleName", objClientContacts.MiddleName)
            db.AddParameter("@LastName", objClientContacts.LastName)
            db.AddParameter("@Gender", objClientContacts.Gender)
            db.AddParameter("@JobTitle", objClientContacts.JobTitle)
            db.AddParameter("@HomePhone", objClientContacts.HomePhone)
            db.AddParameter("@WorkPhone", objClientContacts.WorkPhone)
            db.AddParameter("@CellPhone", objClientContacts.CellPhone)
            db.AddParameter("@Fax", objClientContacts.Fax)
            db.AddParameter("@Email1", objClientContacts.Email1)
            db.AddParameter("@Email2", objClientContacts.Email2)
            db.AddParameter("@Address", objClientContacts.Address)
            db.AddParameter("@Address2", objClientContacts.Address2)
            db.AddParameter("@City", objClientContacts.City)
            db.AddParameter("@Zip", objClientContacts.Zip)
            db.AddParameter("@StateID", IIf(objClientContacts.StateID = 0, DBNull.Value, objClientContacts.StateID))
            db.AddParameter("@CountryID", objClientContacts.CountryID)
            db.AddParameter("@ContactType", IIf(objClientContacts.ContactType = 0, 1, objClientContacts.ContactType)) ' forced. 
            db.AddParameter("@Deleted", objClientContacts.Deleted)
            db.AddParameter("@LastUpdatedDate", DateTime.Now)
            db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))
            db.AddParameter("@UserName", objClientContacts.UserName)
            db.AddParameter("@Password", objClientContacts.PassWord)
            db.AddParameter("@IsAdmin", objClientContacts.IsAdmin)
            db.AddParameter("@HasPMFullAccess", objClientContacts.HasPMFullAccess)
            db.AddParameter("@HasTicketApprovalAccess", objClientContacts.HasTicketApprovalAccess)
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)
            db.AddParameter("@ClientContactID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@HasURLMAccess", objClientContacts.HasURLMAccess)

            Dim Affected As Integer = db.ExecuteNonQuery("Client_Contacts_Add")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then
                Return -101
            Else
                Dim ClientContactID As Integer = CInt(CType(db.Parameters("@ClientContactID"), System.Data.SqlClient.SqlParameter).Value)
                Return ClientContactID
            End If
        End Function

        Public Function AddFromFransupport(ByVal objClientContacts As Portal.BLL.Client.Client_Contacts, ByVal HasMynetsolaceAccess As Boolean, ByVal FransupportAdminName As String, ByVal State As String) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ClientID", objClientContacts.ClientID)
            db.AddParameter("@FransupportAdminID", objClientContacts.AdminID)
            db.AddParameter("@FirstName", objClientContacts.FirstName)
            db.AddParameter("@MiddleName", objClientContacts.MiddleName)
            db.AddParameter("@LastName", objClientContacts.LastName)
            db.AddParameter("@Gender", objClientContacts.Gender)
            db.AddParameter("@JobTitle", objClientContacts.JobTitle)
            db.AddParameter("@HomePhone", objClientContacts.HomePhone)
            db.AddParameter("@WorkPhone", objClientContacts.WorkPhone)
            db.AddParameter("@CellPhone", objClientContacts.CellPhone)
            db.AddParameter("@Fax", objClientContacts.Fax)
            db.AddParameter("@Email1", objClientContacts.Email1)
            db.AddParameter("@Email2", objClientContacts.Email2)
            db.AddParameter("@Address", objClientContacts.Address)
            db.AddParameter("@Address2", objClientContacts.Address2)
            db.AddParameter("@City", objClientContacts.City)
            db.AddParameter("@Zip", objClientContacts.Zip)
            db.AddParameter("@State", State)
            db.AddParameter("@CountryID", objClientContacts.CountryID)
            db.AddParameter("@ContactType", objClientContacts.ContactType)
            db.AddParameter("@UserName", objClientContacts.UserName)
            db.AddParameter("@Password", objClientContacts.PassWord)
            db.AddParameter("@IsAdmin", objClientContacts.IsAdmin)
            db.AddParameter("@AddFromFSByAdminId", objClientContacts.AddFromFSByAdminId)
            db.AddParameter("@HasMynetsolaceAccess", HasMynetsolaceAccess)
            db.AddParameter("@FransupportAdminName", FransupportAdminName)
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)
            db.AddParameter("@ClientContactID", SqlDbType.Int, 4, ParameterDirection.Output, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("ClientContact_Add_SyncFromFransupport")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then
                Return -101
            Else
                Dim ClientContactID As Integer = CInt(CType(db.Parameters("@ClientContactID"), System.Data.SqlClient.SqlParameter).Value)
                Return ClientContactID
            End If
        End Function

        Public Shared Function Update(ByVal objClientContacts As Portal.BLL.Client.Client_Contacts) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", objClientContacts.ID)
            db.AddParameter("@ClientID", objClientContacts.ClientID)
            db.AddParameter("@AdminID", IIf(objClientContacts.AdminID = 0, DBNull.Value, objClientContacts.AdminID))
            db.AddParameter("@AreaDeveloperID", IIf(objClientContacts.AreaDeveloperID = 0, DBNull.Value, objClientContacts.AreaDeveloperID))
            db.AddParameter("@ContactID", IIf(objClientContacts.ContactID = 0, DBNull.Value, objClientContacts.ContactID))
            db.AddParameter("@FirstName", objClientContacts.FirstName)
            db.AddParameter("@MiddleName", objClientContacts.MiddleName)
            db.AddParameter("@LastName", objClientContacts.LastName)
            db.AddParameter("@Gender", objClientContacts.Gender)
            db.AddParameter("@JobTitle", objClientContacts.JobTitle)
            db.AddParameter("@HomePhone", objClientContacts.HomePhone)
            db.AddParameter("@WorkPhone", objClientContacts.WorkPhone)
            db.AddParameter("@CellPhone", objClientContacts.CellPhone)
            db.AddParameter("@Fax", objClientContacts.Fax)
            db.AddParameter("@Email1", objClientContacts.Email1)
            db.AddParameter("@Email2", objClientContacts.Email2)
            db.AddParameter("@Address", objClientContacts.Address)
            db.AddParameter("@Address2", objClientContacts.Address2)
            db.AddParameter("@City", objClientContacts.City)
            db.AddParameter("@Zip", objClientContacts.Zip)
            db.AddParameter("@StateID", IIf(objClientContacts.StateID = 0, DBNull.Value, objClientContacts.StateID))
            db.AddParameter("@CountryID", objClientContacts.CountryID)
            db.AddParameter("@ContactType", IIf(objClientContacts.ContactType = 0, 1, objClientContacts.ContactType)) ' forced. 
            db.AddParameter("@Deleted", objClientContacts.Deleted)
            db.AddParameter("@LastUpdatedDate", DateTime.Now)
            db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))
            db.AddParameter("@HasPMFullAccess", objClientContacts.HasPMFullAccess)
            db.AddParameter("@HasTicketApprovalAccess", objClientContacts.HasTicketApprovalAccess)
            db.AddParameter("@UserName", objClientContacts.UserName)
            db.AddParameter("@IsAdmin", objClientContacts.IsAdmin)
            db.AddParameter("@HasURLMAccess", objClientContacts.HasURLMAccess)

            Dim Affected As Integer = db.ExecuteNonQuery("Client_Contacts_Update")
            If Affected = -1 Then
                Return -101
            Else
                Return Affected
            End If
        End Function
        Public Function Delete(ByVal ID As Integer, ByVal Deleted As Boolean) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@Deleted", Deleted)
            db.AddParameter("@LastUpdatedDate", DateTime.Now)
            db.AddParameter("@LastUpdatedBy", CInt(HttpContext.Current.Session("Admin_AdminID")))
            Dim Affected As Integer = db.ExecuteNonQuery("Client_Contacts_Delete")

            Return Affected
        End Function

        Public Function ChangePassword(ByVal ID As Integer, ByVal OldPassword As String, ByVal NewPassword As String) As Integer
            Dim db As New DBAccess
            Dim ReturnValue As Integer = 0
            db.AddParameter("@ID", ID)
            db.AddParameter("@OldPassword", SqlDbType.NVarChar, 50, ParameterDirection.Input, OldPassword)
            db.AddParameter("@NewPassword", SqlDbType.NVarChar, 50, ParameterDirection.Input, NewPassword)
            db.AddParameter("@ChangePassword", SqlDbType.Bit, 1, ParameterDirection.Input, False)
            db.AddParameter("@ChangePassDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            Dim Affected As Integer = db.ExecuteNonQuery("ClientContact_ChangePassword")
            ReturnValue = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return ReturnValue
        End Function

        Public Shared Function ResetPassword(ByVal ID As Integer, ByVal NewPassword As String) As Integer
            Dim db As New DBAccess
            Dim ReturnValue As Integer = 0
            db.AddParameter("@ID", ID)
            db.AddParameter("@NewPassword", SqlDbType.NVarChar, 50, ParameterDirection.Input, NewPassword)
            db.AddParameter("@ChangePassword", SqlDbType.Bit, 1, ParameterDirection.Input, False)
            db.AddParameter("@ChangePassDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)

            Dim Affected As Integer = db.ExecuteNonQuery("ClientContact_ResetPassword")
            Return Affected
        End Function

        Public Shared Function GetTicketApprovalAccessByClientId(ByVal ClientID As Integer) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            Return CType(db.ExecuteScalar("ClientContacts_GetTicketApprovalAccessByClientId"), Boolean)
        End Function

        Public Shared Function HasPMFullAccess(ByVal ClientContactId As Integer) As Boolean
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@ClientContactID", ClientContactId)
            Return CType(objDbAccess.ExecuteScalar("Client_Contacts_HasPMFullAccess"), Boolean)
        End Function

#End Region

    End Class
End Namespace