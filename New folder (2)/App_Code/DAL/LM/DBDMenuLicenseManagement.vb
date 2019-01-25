Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.DAL.LM
    Public Class DBDMenuLicenseManagement
        Public Shared Function GetAllDMenuLicenses(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                                ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            Return objDBAccess.ExecuteDataTable("DMenu_GetAllLicenses")
        End Function

        Public Shared Function GetAllDMenuLicensesByLMRights(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                               ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal UserID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            objDBAccess.AddParameter("@UserID", UserID)
            Return objDBAccess.ExecuteDataTable("DMenu_GetAllLicenses_ByLMRights")
        End Function
        Public Shared Function GetAllDMenuLicensesByLMRightsCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal UserID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            Return objDBAccess.ExecuteScalar("DMenu_GetAllLicenses_ByLMRights_Count")
        End Function
        Public Shared Function GetAllDMenuLicensesCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            Return objDBAccess.ExecuteScalar("DMenu_GetAllLicenses_Count")
        End Function
        Public Function AddDMenuLicense(ByVal objLicenseManagement As Portal.BLL.LM.DMenuLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0
            objDBAccess.AddParameter("@ClientID", objLicenseManagement.ClientID)
            objDBAccess.AddParameter("@StoreNumber", objLicenseManagement.StoreNo)
            objDBAccess.AddParameter("@InVoiceNo", objLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@IsDynamicIP", objLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@ProductID", objLicenseManagement.ProductID)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objLicenseManagement.SystemIP), DBNull.Value, objLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@Notes", IIf(String.IsNullOrEmpty(objLicenseManagement.Notes), DBNull.Value, objLicenseManagement.Notes))
            objDBAccess.AddParameter("@IssuedByID", objLicenseManagement.IssuedByID)
            objDBAccess.AddParameter("@NumberOfDisplays", objLicenseManagement.NumberOfDisplays)
            objDBAccess.AddParameter("@Version", objLicenseManagement.CurrentVersion)
            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DMenu_GenerateNewLicense")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function
        Public Function GetDMenuLicenseDetail(ByVal sbsUserId As Integer) As Portal.BLL.LM.DMenuLicenseManagement
            Dim objDBAccess As New DBAccess
            Dim rdrLicenseDetail As SqlDataReader
            Dim objLicenseManagement As New Portal.BLL.LM.DMenuLicenseManagement
            objDBAccess.AddParameter("@DMenuUserID", sbsUserId)
            rdrLicenseDetail = objDBAccess.ExecuteReader("DMenu_GetLicenseDetailByID")
            Try
                If (rdrLicenseDetail.HasRows) Then
                    If (rdrLicenseDetail.Read()) Then
                        objLicenseManagement.StoreNo = CInt(rdrLicenseDetail("StoreNumber"))
                        objLicenseManagement.StoreNick = rdrLicenseDetail("StoreNick").ToString()
                        objLicenseManagement.ClientName = rdrLicenseDetail("Client").ToString()
                        objLicenseManagement.ClientID = rdrLicenseDetail("ClientId")
                        objLicenseManagement.SystemName = rdrLicenseDetail("SystemName").ToString()
                        objLicenseManagement.SystemIP = rdrLicenseDetail("SystemIP").ToString()
                        objLicenseManagement.CurrentVersion = rdrLicenseDetail("CurrentVersion").ToString()
                        objLicenseManagement.NumberOfDisplays = rdrLicenseDetail("NumberOfDisplays")
                        objLicenseManagement.IsLicenseInActive = CBool(rdrLicenseDetail("Inactive"))
                        objLicenseManagement.RegistrationKey = rdrLicenseDetail("RegKey").ToString()
                        objLicenseManagement.LastSyncTime = rdrLicenseDetail("LastTimeSync").ToString()
                        objLicenseManagement.IssuedBy = rdrLicenseDetail("IssuedBy").ToString()
                        objLicenseManagement.UpdatedBy = rdrLicenseDetail("UpdatedBy").ToString()
                        objLicenseManagement.IssuedOn = Functions.IfNull(rdrLicenseDetail("RegistrationDate"), Date.MinValue)
                        objLicenseManagement.UpdatedOn = Functions.IfNull(rdrLicenseDetail("UpdatedOn"), Date.MinValue)
                        objLicenseManagement.Notes = rdrLicenseDetail("Notes").ToString()
                        objLicenseManagement.InVoiceNo = rdrLicenseDetail("InvoiceNo").ToString()
                        objLicenseManagement.IsDynamicIP = CBool(rdrLicenseDetail("Is_IPDynamic"))
                        objLicenseManagement.CurrentIP = rdrLicenseDetail("CurrentIP")
                    End If
                End If
            Catch ex As Exception
                'Don't do any thing
            Finally
                objDBAccess.Dispose()
                rdrLicenseDetail.Close()
            End Try
            Return objLicenseManagement
        End Function
        Public Function UpdateDMenuLicenseDetail(ByVal objLicenseManagement As Portal.BLL.LM.DMenuLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@DMenuUserID", objLicenseManagement.DMenuUserID)
            objDBAccess.AddParameter("@IsDynamicIP", objLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@IsNextStepInActive", objLicenseManagement.IsLicenseInActive)
            objDBAccess.AddParameter("@NumberOfDisplays", objLicenseManagement.NumberOfDisplays)
            objDBAccess.AddParameter("@SystemIP", objLicenseManagement.SystemIP)
            objDBAccess.AddParameter("@UpdatedByID", objLicenseManagement.UpdatedByID)
            objDBAccess.AddParameter("@InvoiceNo", objLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@Notes", objLicenseManagement.Notes)
            Return objDBAccess.ExecuteScalar("DMenu_LicenseDetail_Update")
        End Function
        Public Shared Function GetAllDMenuLicensesForReporting(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            Return objDBAccess.ExecuteReader("DMenu_GetAllLicensesForPrinting")
        End Function
		
        Public Shared Function GetAllDMenuLicensesForReporting_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, ByVal UserID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            Return objDBAccess.ExecuteReader("DMenu_GetAllLicensesForPrinting_LM")
        End Function
        Public Shared Function DMenuLicenses_GetDisplayNoByClientIDForWebService(ByVal ClientID As Integer, ByVal CountryID As Integer) As DataSet
            Dim objDBAccess As New DBAccess
            Dim ds As New DataSet
            objDBAccess.AddParameter("@ClientID", ClientID)
            objDBAccess.AddParameter("@CountryID", CountryID)
            ds = objDBAccess.ExecuteDataSet("DMenu_Users_DisplayNoByClientID")
            ds.DataSetName = "DMenuFranchises"
            Return ds
        End Function

		Public Sub DMenu_Users_ClearSession(ByVal ID As Integer, ByVal UpdatedByID As Integer, ByVal Notes As String)
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedByID", UpdatedByID)
            objDBAccess.AddParameter("@Notes", Notes)
            objDBAccess.ExecuteNonQuery("DMenu_Users_ClearSession")
        End Sub

	Public Function AddDMenuLicenseFromService(ByVal objLicenseManagement As Portal.BLL.LM.DMenuLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0
            objDBAccess.AddParameter("@ClientID", objLicenseManagement.ClientID)
            objDBAccess.AddParameter("@StoreNumber", objLicenseManagement.StoreNo)
            objDBAccess.AddParameter("@InVoiceNo", objLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@IsDynamicIP", objLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@ProductID", objLicenseManagement.ProductID)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objLicenseManagement.SystemIP), DBNull.Value, objLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@Notes", IIf(String.IsNullOrEmpty(objLicenseManagement.Notes), DBNull.Value, objLicenseManagement.Notes))
            objDBAccess.AddParameter("@IssuedByID", objLicenseManagement.IssuedByID)
            objDBAccess.AddParameter("@NumberOfDisplays", objLicenseManagement.NumberOfDisplays)
            objDBAccess.AddParameter("@Version", objLicenseManagement.CurrentVersion)
            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DMenu_GenerateNewLicenseFromService")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function

    End Class
End Namespace