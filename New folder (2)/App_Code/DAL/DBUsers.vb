Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data

Namespace Portal.DAL
    Public Class DBUsers
        Public Shared Function GetAll(ByVal CountryID As Integer, ByVal DepartmentID As Integer, ByVal TeamID As Integer, ByVal OfficeID As Integer, ByVal Status As String, ByVal Type As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Portal.BLL.Users)

            Dim colUsers As New List(Of Portal.BLL.Users)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@CountryID", CountryID)
            db.AddParameter("@DepartmentID", DepartmentID)
            db.AddParameter("@TeamID", TeamID)
            db.AddParameter("@OfficeID", OfficeID)
            If Status <> "Null" Then
                db.AddParameter("@Status", CType(Status, Boolean))
	        Else
	            db.AddParameter("@Status", DBNull.Value)
            End If
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            dr = db.ExecuteReader("Users_SelectUser")
            While dr.Read()
                colUsers.Add(New Portal.BLL.Users( _
                                                    CType(dr("ID"), Integer), _
                                                    CType(Functions.IfNull(dr("Name"), ""), String), _
                                                    CType(Functions.IfNull(dr("UserName"), ""), String), _
                                                    CType(Functions.IfNull(dr("Email"), ""), String), _
                                                    CType(Functions.IfNull(dr("WorkPhone"), ""), String), _
                                                    CType(Functions.IfNull(dr("Status"), ""), String), _
                                                    CType(Functions.IfNull(dr("RFID"), ""), String) _
                                                   ))
            End While
            dr.Close()
            Return colUsers

        End Function
		
        Public Shared Function GetAllCount(ByVal CountryID As Integer, ByVal DepartmentID As Integer, ByVal TeamID As Integer, ByVal OfficeID As Integer, ByVal Status As String, ByVal Type As Integer, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@CountryID", CountryID)
            db.AddParameter("@DepartmentID", DepartmentID)
            db.AddParameter("@TeamID", TeamID)
            db.AddParameter("@OfficeID", OfficeID)
            If Status <> "Null" Then
                db.AddParameter("@Status", CType(Status, Boolean))
            Else
                db.AddParameter("@Status", DBNull.Value)
            End If            
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteScalar("Users_SelectUserCount")
        End Function

		
        Public Shared Function GetUsersByID(ByVal ID As Integer) As List(Of Portal.BLL.Users)

            Dim colUsers As New List(Of Portal.BLL.Users)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("Users_SelectByUsersID")
            While dr.Read()
                colUsers.Add(New Portal.BLL.Users(CType(dr("ID"), Integer), _
                                                    CType(Functions.IfNull(dr("FirstName"), ""), String), _
                                                    CType(Functions.IfNull(dr("MiddleName"), ""), String), _
                                                    CType(Functions.IfNull(dr("LastName"), ""), String), _
                                                    CType(Functions.IfNull(dr("Username"), ""), String), _
                                                    CType(Functions.IfNull(dr("Password"), ""), String), _
                                                    CType(Functions.IfNull(dr("SSN"), ""), String), _
                                                    CType(Functions.IfNull(dr("IP"), ""), String), _
                                                    CType(Functions.IfNull(dr("IP2"), ""), String), _
                                                    CType(Functions.IfNull(dr("JobTitle"), ""), String), _
                                                    CType(Functions.IfNull(dr("Email"), ""), String), _
                                                    CType(Functions.IfNull(dr("Address"), ""), String), _
                                                    CType(Functions.IfNull(dr("City"), ""), String), _
                                                    CType(Functions.IfNull(dr("Region"), ""), String), _
                                                    CType(Functions.IfNull(dr("Zip"), ""), String), _
                                                    CType(Functions.IfNull(dr("CountryID"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("StateID"), 0), String), _
                                                    CType(Functions.IfNull(dr("HomePhone"), ""), String), _
                                                    CType(Functions.IfNull(dr("WorkPhone"), ""), String), _
                                                    CType(Functions.IfNull(dr("CellPhone"), ""), String), _
                                                    CType(Functions.IfNull(dr("Fax"), ""), String), _
                                                    CType(dr("RemoteUser"), Boolean), _
                                                    CType(Functions.IfNull(dr("TimeZoneID"), 0), Integer), _
                                                    CType(dr("Inactive"), Boolean), _
                                                    CType(dr("Deleted"), Boolean), _
                                                    CType(dr("IsTimeExampted"), Boolean), _
                                                    CType(dr("Gender"), Boolean), _
                                                    CType(Functions.IfNull(dr("HiringDate"), Nothing), Date), _
                                                    CType(Functions.IfNull(dr("DOB"), Nothing), Date), _
                                                    CType(Functions.IfNull(dr("DepartmentID"), "0"), Integer), _
                                                    CType(Functions.IfNull(dr("TeamID"), "0"), Integer), _
                                                    CType(Functions.IfNull(dr("OfficeID"), "0"), Integer), _
                                                    CType(dr("Type"), Integer), _
                                                    CType(Functions.IfNull(dr("FrutationID"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("FranSupportID"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("SecurityCode"), ""), String), _
	                                                CType(Functions.IfNull(dr("RFID"), ""), String), _
                                               		CType(Functions.IfNull(dr("ChangePasswordAccess"), 0), Boolean), _
	                                                CType(Functions.IfNull(dr("PersonalEmail"), ""), String), _
	                                                CType(Functions.IfNull(dr("OfficeTimingProfileID"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("OffSaturdayGroupType"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("IsEmailWorking"), 0), Integer)))

            End While
            dr.Close()
            Return colUsers
        End Function
        Public Shared Function GetFransupportUsersByID(ByVal FransupportID As Integer) As List(Of Portal.BLL.Users)

            Dim colUsers As New List(Of Portal.BLL.Users)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@FranSupportID", FransupportID)
            dr = db.ExecuteReader("Users_SelectByUsersID")
            While dr.Read()
                colUsers.Add(New Portal.BLL.Users(CType(dr("ID"), Integer), _
                                                    CType(Functions.IfNull(dr("FirstName"), ""), String), _
                                                    CType(Functions.IfNull(dr("MiddleName"), ""), String), _
                                                    CType(Functions.IfNull(dr("LastName"), ""), String), _
                                                    CType(Functions.IfNull(dr("Username"), ""), String), _
                                                    CType(Functions.IfNull(dr("Password"), ""), String), _
                                                    CType(Functions.IfNull(dr("SSN"), ""), String), _
                                                    CType(Functions.IfNull(dr("IP"), ""), String), _
                                                    CType(Functions.IfNull(dr("IP2"), ""), String), _
                                                    CType(Functions.IfNull(dr("JobTitle"), ""), String), _
                                                    CType(Functions.IfNull(dr("Email"), ""), String), _
                                                    CType(Functions.IfNull(dr("Address"), ""), String), _
                                                    CType(Functions.IfNull(dr("City"), ""), String), _
                                                    CType(Functions.IfNull(dr("Region"), ""), String), _
                                                    CType(Functions.IfNull(dr("Zip"), ""), String), _
                                                    CType(Functions.IfNull(dr("CountryID"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("StateID"), 0), String), _
                                                    CType(Functions.IfNull(dr("HomePhone"), ""), String), _
                                                    CType(Functions.IfNull(dr("WorkPhone"), ""), String), _
                                                    CType(Functions.IfNull(dr("CellPhone"), ""), String), _
                                                    CType(Functions.IfNull(dr("Fax"), ""), String), _
                                                    CType(dr("RemoteUser"), Boolean), _
                                                    CType(Functions.IfNull(dr("TimeZoneID"), 0), Integer), _
                                                    CType(dr("Inactive"), Boolean), _
                                                    CType(dr("Deleted"), Boolean), _
                                                    CType(dr("IsTimeExampted"), Boolean), _
                                                    CType(dr("Gender"), Boolean), _
                                                    CType(Functions.IfNull(dr("HiringDate"), Nothing), Date), _
                                                    CType(Functions.IfNull(dr("DOB"), Nothing), Date), _
                                                    CType(Functions.IfNull(dr("DepartmentID"), "0"), Integer), _
                                                    CType(Functions.IfNull(dr("TeamID"), "0"), Integer), _
                                                    CType(Functions.IfNull(dr("OfficeID"), "0"), Integer), _
                                                    CType(dr("Type"), Integer), _
                                                    CType(Functions.IfNull(dr("FrutationID"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("FranSupportID"), 0), Integer), _
                                                    CType(Functions.IfNull(dr("SecurityCode"), ""), String), _
                                                    CType(Functions.IfNull(dr("RFID"), ""), String), _
                                                    CType(Functions.IfNull(dr("ChangePasswordAccess"), 0), Boolean), _
                                                    CType(Functions.IfNull(dr("PersonalEmail"), ""), String), _
                                                    CType(Functions.IfNull(dr("IsValidEmail"), ""), String) _
                                                    ))
            End While
            dr.Close()
            Return colUsers
        End Function
        Public Function Insert(ByVal NewUser As Portal.BLL.Users) As Integer

            Dim db As New DBAccess

            db.AddParameter("@FirstName", NewUser.Firstname)        '1
            db.AddParameter("@MiddleName", NewUser.Middlename)      '2
            db.AddParameter("@LastName", NewUser.Lastname)          '3
            db.AddParameter("@Username", NewUser.UserName)          '4
            db.AddParameter("@Password", NewUser.Password) 'NewUser.Password         '5
            db.AddParameter("@SSN", NewUser.Ssn)                    '6
            db.AddParameter("@IP", NewUser.IP)                      '7
            db.AddParameter("@IP2", NewUser.IP2)
            db.AddParameter("@JobTitle", NewUser.JobTitle)          '8
            db.AddParameter("@Email", NewUser.Email)                '9
            db.AddParameter("@Address", NewUser.Address)            '10
            db.AddParameter("@City", NewUser.City)                  '11
            db.AddParameter("@Region", NewUser.Region)              '12
            db.AddParameter("@Zip", NewUser.Zip)                    '13
            db.AddParameter("@StateID", NewUser.StateID)            '14
            db.AddParameter("@CountryID", NewUser.CountryID)        '15
            db.AddParameter("@HomePhone", NewUser.HomePhone)        '16
            db.AddParameter("@WorkPhone", NewUser.WorkPhone)        '17
            db.AddParameter("@CellPhone", NewUser.CellPhone)        '18 
            db.AddParameter("@Fax", NewUser.Fax)                    '19
            db.AddParameter("@Gender", NewUser.Gender)              '20
            db.AddParameter("@RemoteUser", NewUser.RemoteUser)      '21
            db.AddParameter("@Inactive", NewUser.Inactive)          '22
            db.AddParameter("@Deleted", NewUser.Deleted)            '23
            db.AddParameter("@TimeZoneID", NewUser.TimeZoneID)      '24
            db.AddParameter("@IsTimeExampted", NewUser.IsTimeExampted) '25
            db.AddParameter("@HiringDate", NewUser.HiringDate)      '26
            db.AddParameter("@DOB", NewUser.DOB)                    '27
            db.AddParameter("@DepartmentID", NewUser.DepartmentID)
            db.AddParameter("@TeamID", NewUser.TeamID)
            db.AddParameter("@OfficeID", NewUser.OfficeID)
            db.AddParameter("@Type", NewUser.Type)
						db.AddParameter("@RFID", NewUser.RFID)			
						db.AddParameter("@ChangePasswordAccess", NewUser.ChangePasswordAccess)
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("Users_Insert")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then Affected = -101
            Return Affected
        End Function
        Public Function Update(ByVal NewUser As Portal.BLL.Users) As Integer

            Dim db As New DBAccess
            db.AddParameter("@ID", NewUser.ID)
            db.AddParameter("@FirstName", NewUser.Firstname)
            db.AddParameter("@MiddleName", NewUser.Middlename)
            db.AddParameter("@LastName", NewUser.Lastname)
            db.AddParameter("@Username", NewUser.UserName)
            db.AddParameter("@SSN", NewUser.Ssn)
            db.AddParameter("@IP", NewUser.IP)
            db.AddParameter("@IP2", NewUser.IP2)
            db.AddParameter("@JobTitle", NewUser.JobTitle)
            db.AddParameter("@Email", NewUser.Email)
            db.AddParameter("@Address", NewUser.Address)
            db.AddParameter("@City", NewUser.City)
            db.AddParameter("@Region", NewUser.Region)
            db.AddParameter("@Zip", NewUser.Zip)
            db.AddParameter("@StateID", NewUser.StateID)
            db.AddParameter("@CountryID", NewUser.CountryID)
            db.AddParameter("@HomePhone", NewUser.HomePhone)
            db.AddParameter("@WorkPhone", NewUser.WorkPhone)
            db.AddParameter("@CellPhone", NewUser.CellPhone)
            db.AddParameter("@Fax", NewUser.Fax)
            db.AddParameter("@Gender", NewUser.Gender)
            db.AddParameter("@RemoteUser", NewUser.RemoteUser)
            db.AddParameter("@Inactive", NewUser.Inactive)
            db.AddParameter("@Deleted", NewUser.Deleted)
            db.AddParameter("@TimeZoneID", NewUser.TimeZoneID)
            db.AddParameter("@IsTimeExampted", NewUser.IsTimeExampted)
            db.AddParameter("@HiringDate", NewUser.HiringDate)
            db.AddParameter("@DOB", NewUser.DOB)
            db.AddParameter("@DepartmentID", NewUser.DepartmentID)
            db.AddParameter("@TeamID", NewUser.TeamID)
            db.AddParameter("@OfficeID", NewUser.OfficeID)
			db.AddParameter("@RFID", NewUser.RFID)			
		  	db.AddParameter("@ChangePasswordAccess", NewUser.ChangePasswordAccess)
            db.AddParameter("@PersonalEmail", NewUser.PersonalEmail)
            db.AddParameter("@TimeProfileID", IIf(NewUser.OfficeTimingProfileID = 0, DBNull.Value, NewUser.OfficeTimingProfileID))			
            db.AddParameter("@OffSaturdayGroupType", IIf(NewUser.OffSaturdayGroup = 0, DBNull.Value, NewUser.OffSaturdayGroup))			
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)
            db.AddParameter("@IsEmailWorking", NewUser.IsEmailWorking)
            Dim Affected As Integer = db.ExecuteNonQuery("User_UpdateByID")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then Affected = -101
            Return Affected
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Deleted", True)
            Dim Affected As Integer = db.ExecuteNonQuery("User_DeleteByID")
            Return Affected
        End Function
        Public Function ResetPassword(ByVal ID As Integer, ByVal Password As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Password", Password)
            Dim Affected As Integer = db.ExecuteNonQuery("User_ResetPasswordByID")
            Return Affected
        End Function
        Public Function ResetStatus(ByVal ID As Integer, ByVal Status As Boolean) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Inactive", Status)
            Dim Affected As Integer = db.ExecuteNonQuery("User_ResetStatusByID")
            Return Affected
        End Function
        Public Function GetModules_SubModules(ByVal UserID As Integer, ByVal ClientID As Integer) As DataSet

            Dim colUsers As New List(Of Portal.BLL.Users)()
            Dim ds As DataSet
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@ClientID", ClientID)
            ds = db.ExecuteDataSet("ModulesSubModules_GetAll")
            Return ds
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
            db.AddParameter("@UserID", UserID)
            Dim Affected As Integer = db.ExecuteNonQuery("UserClientSubModule_DeleteByUserID")
            Return Affected
        End Function
        Public Function SQLInsert(ByVal Query As String) As Integer
            Dim db As New DBAccess
            Dim Affected As Integer = db.ExecuteDynamicQuery(Query)
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
            Dim Affected As Integer = db.ExecuteNonQuery("User_ChangePassword")
            ReturnValue = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return ReturnValue
        End Function
        Public Shared Function GetPasswordReservedWords(ByVal userID As Int64) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@userID", userID)
            Dim ds As DataSet = db.ExecuteDataSet("User_GetReservedPasswordWords")
            Return ds.Tables(0)
        End Function
        Public Shared Function GetClientsByUserIDAndSubModuleIDs(ByVal userId As Integer, ByVal subModuleIds As String) As SqlDataReader
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@UserID", userId)
            objDbAccess.AddParameter("@SubModuleIDs", subModuleIds)
            Return objDbAccess.ExecuteReader("Clients_GetByUserIDAndSubModulesID")
        End Function
		Public Shared Function GetLatestUpdatedUsersDataForPunchInMachine(ByVal LastSyncDate As DateTime, ByVal OfficeID As Integer) As DataSet
            Dim objDBAccess As New DBAccess()
            Dim dtUsersData As New System.Data.DataSet
            objDBAccess.AddParameter("@LastSyncDate", IIf(LastSyncDate = DateTime.MinValue, DBNull.Value, LastSyncDate))
            objDBAccess.AddParameter("@OfficeID", OfficeID)
            dtUsersData = objDBAccess.ExecuteDataSet("Users_GetLastUpdatedUsersListForPunchInMachine")
            Return dtUsersData
	End Function
        Public Function LM_UserAccessGetByUserID(ByVal UserID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            Return db.ExecuteDataTable("LM_UserAccessGETByUserID")
        End Function
    End Class
End Namespace