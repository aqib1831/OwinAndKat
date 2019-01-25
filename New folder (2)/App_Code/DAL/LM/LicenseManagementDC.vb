Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.DAL
    Public Class LicenseManagementDC
        Public Shared Function GetAllNextStepLicenses(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                                ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            Return objDBAccess.ExecuteDataTable("DC_GetAllLicenses")
        End Function

        Public Shared Function GetAllNextStepLicensesCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            Return objDBAccess.ExecuteScalar("DC_GetAllLicenses_Count")
        End Function
        '=======================
        Public Shared Function GetAllNextStepLicenses_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
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
            Return objDBAccess.ExecuteDataTable("DC_GetAllLicenses_LM")
        End Function

        Public Shared Function GetAllNextStepLicensesCount_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal UserID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            Return objDBAccess.ExecuteScalar("DC_GetAllLicenses_Count_LM")
        End Function
        '=======================
        Public Function AddNextStepLicense(ByVal objLicenseManagement As Portal.BLL.LicenseManagementDC) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0
            objDBAccess.AddParameter("@ClientID", objLicenseManagement.ClientID)
            objDBAccess.AddParameter("@StoreNumber", objLicenseManagement.StoreNo)
            objDBAccess.AddParameter("@InVoiceNo", objLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@IsDynamicIP", objLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@ProductID", objLicenseManagement.ProductID)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objLicenseManagement.SystemIP), DBNull.Value, objLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@Notes", IIf(String.IsNullOrEmpty(objLicenseManagement.Notes), DBNull.Value, objLicenseManagement.Notes))
            objDBAccess.AddParameter("@IssuedByID", objLicenseManagement.IssuedByID)
            objDBAccess.AddParameter("@IsTrainingActive", objLicenseManagement.IsTrainingActive)
            objDBAccess.AddParameter("@Version", objLicenseManagement.CurrentVersion)
            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DC_GenerateNewLicense")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function
        Public Function GetNextStepLicenseDetail(ByVal sbsUserId As Integer) As Portal.BLL.LicenseManagementDC
            Dim objDBAccess As New DBAccess
            Dim rdrLicenseDetail As SqlDataReader
            Dim objLicenseManagement As New Portal.BLL.LicenseManagementDC
            objDBAccess.AddParameter("@SBSUserID", sbsUserId)
            rdrLicenseDetail = objDBAccess.ExecuteReader("DC_GetLicenseDetailByID")
            Try
                If (rdrLicenseDetail.HasRows) Then
                    If (rdrLicenseDetail.Read()) Then
                        objLicenseManagement.StoreNo = CInt(rdrLicenseDetail("StoreNumber"))
                        objLicenseManagement.StoreNick = rdrLicenseDetail("StoreNick").ToString()
                        objLicenseManagement.StoreEmail = rdrLicenseDetail("CorporateEmail").ToString()
                        objLicenseManagement.ClientName = rdrLicenseDetail("Client").ToString()
                        objLicenseManagement.ClientID = rdrLicenseDetail("ClientId")
                        objLicenseManagement.SystemName = rdrLicenseDetail("SystemName").ToString()
                        objLicenseManagement.SystemIP = rdrLicenseDetail("SystemIP").ToString()
                        objLicenseManagement.CurrentVersion = rdrLicenseDetail("CurrentVersion").ToString()
                        objLicenseManagement.IsTrainingActive = CBool(rdrLicenseDetail("Is_TrainingActive"))
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
                        objLicenseManagement.CurrentIP = rdrLicenseDetail("CurrentIP").ToString()
                        objLicenseManagement.ApplicationToConnect = CInt(Functions.IfNull(rdrLicenseDetail("ApplicationToConnect"), 3))
                        objLicenseManagement.ApplicationToConnectName = CStr(Functions.IfNull(rdrLicenseDetail("ApplicationToConnectName"), ""))
                        objLicenseManagement.IsSMSAppEnabled = CBool(rdrLicenseDetail("IsSMSAppEnabled"))
                        objLicenseManagement.DynamicIPEndDate = Functions.IfNull(rdrLicenseDetail("DynamicIPEndDate"), Date.MinValue)
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
        Public Function UpdateNextStepLicenseDetail(ByVal objLicenseManagement As Portal.BLL.LicenseManagementDC) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@SBSUserID", objLicenseManagement.SBSUserID)
            objDBAccess.AddParameter("@IsDynamicIP", objLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@IsNextStepInActive", objLicenseManagement.IsLicenseInActive)
            objDBAccess.AddParameter("@IsTrainingActive", objLicenseManagement.IsTrainingActive)
            objDBAccess.AddParameter("@SystemIP", objLicenseManagement.SystemIP)
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@UpdatedByID", objLicenseManagement.UpdatedByID)
            objDBAccess.AddParameter("@InvoiceNo", objLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@Notes", objLicenseManagement.Notes)
            objDBAccess.AddParameter("@ApplicationToConnect", objLicenseManagement.ApplicationToConnect)
            objDBAccess.AddParameter("@IsSMSAppEnabled", objLicenseManagement.IsSMSAppEnabled)
            Return objDBAccess.ExecuteScalar("DC_LicenseDetail_Update")
        End Function
        Public Shared Function GetAllNextStepLicensesForReporting(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            Return objDBAccess.ExecuteReader("DC_GetAllLicensesForPrinting")
        End Function

        Public Shared Function GetAllNextStepLicensesForReporting_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, ByVal UserID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            Return objDBAccess.ExecuteReader("DC_GetAllLicensesForPrinting_LM")
        End Function
        Public Function GetnXstepPinAndIP(ByVal licenseId As Integer) As DataSet
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@licenseId", licenseId)
            Return objDBAccess.ExecuteDataSet("WS_DC_Users_GetIPAndPin")

        End Function
        Public Function CheckHasUpdatedPin(ByVal clientId As Integer, ByVal franchiseId As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@licenseId", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.AddParameter("@clientId", clientId)
            objDBAccess.AddParameter("@franchiseId", franchiseId)
            objDBAccess.ExecuteScalar("WS_DC_Users_CheckHasUpdatedPin")
            If Not IsDBNull(CType(objDBAccess.Parameters("@licenseId"), SqlParameter).Value) Then
                Return CInt(CType(objDBAccess.Parameters("@licenseId"), SqlParameter).Value)
            Else
                Return Integer.MinValue
            End If

        End Function
        Public Function UpdatenXstepIPAndPin(ByVal LicenseId As Integer, ByVal nXstepPin As String, ByVal systemIp As String, ByVal notes As String) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@licenseId", LicenseId)
            objDBAccess.AddParameter("@nXstepPin", nXstepPin)
            objDBAccess.AddParameter("@systemIp", systemIp)
            objDBAccess.AddParameter("@notes", notes)
            objDBAccess.ExecuteNonQuery("WS_DC_Users_UpdateIPAndPin")
            Return LicenseId
        End Function

        Public Sub SBS_Users_ClearSession(ByVal ID As Integer, ByVal UpdatedByID As Integer, ByVal Notes As String)
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedByID", UpdatedByID)
            objDBAccess.AddParameter("@Notes", Notes)
            objDBAccess.ExecuteNonQuery("DC_Users_ClearSession")
        End Sub

        Public Shared Function GetLicenseKeyBySystemIDStoreID(ByVal storeNumber As Integer, ByVal MACAdress As String, ByVal clientId As Integer) As String
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", storeNumber)
            objDBAccess.AddParameter("@MACAdress", MACAdress)
            objDBAccess.AddParameter("@ClinetID", clientId)
            Dim dt as DataTable  =objDBAccess.ExecuteDataTable("GetLicenseKeyBySystemIDStoreID")
            If dt.Rows.Count=0
                     Return ""
                Else 
                    Return dt.Rows(0).Item("GUID")
            End If
        End Function

        Public Shared Function GetStoreLicensesCount(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@ClientID", ClientID)
            Return objDBAccess.ExecuteScalar("DC_GetLicenseForStore")
        End Function

        Public Function CheckAdditinalAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0
            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@OutPutID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DC_CheckAdditonalAvailability")
            returnVal = CInt(objDBAccess.Parameters("@OutPutID").Value)
            Return returnVal
        End Function

        Public Shared Function AddDCLicenseTerminals(ByVal MACAdress As String, ByVal ClinetID As Integer, ByVal StoreNumber As Integer,ByVal InVoiceNo  As String, ByVal IssuedByID As Integer) As String 
            Dim objDBAccess As New DBAccess
            Dim returnVal As String =Nothing
            objDBAccess.AddParameter("@MACAdress", MACAdress)
            objDBAccess.AddParameter("@ClinetID", ClinetID)
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@InVoiceNO", InVoiceNo)
            objDBAccess.AddParameter("@IssuedByID", IssuedByID)
           ' objDBAccess.AddParameter("@OutPutID", SqlDbType.VarChar,100, ParameterDirection.Output, 0)
            objDBAccess.ExecuteNonQuery("DC_GenerateNewSMSXLicenseTerminals")
            'returnVal = objDBAccess.Parameters("@OutPutID").Value
            Return returnVal
        End Function
    End Class
End Namespace