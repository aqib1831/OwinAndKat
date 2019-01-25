Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.DAL
    Public Class QsLicenseManagment


        Public Shared Function GetAllQsLicenses(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                                ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            Return objDBAccess.ExecuteDataTable("Qs_GetAllQsLicenses")
        End Function

        Public Shared Function GetAllQsLicensesCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            Return objDBAccess.ExecuteScalar("Qs_GetAllQsLicensesCount")
        End Function


        '' LM ''
        Public Shared Function GetAllQsLicenses_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                                ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal UserID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            objDBAccess.AddParameter("@UserId", UserID)
            Return objDBAccess.ExecuteDataTable("Qs_GetAllQsLicenses_LM")
        End Function

        Public Shared Function GetAllQsLicensesCount_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal UserID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserId", UserID)
            Return objDBAccess.ExecuteScalar("Qs_GetAllQsLicensesCount_LM")
        End Function
        Public Shared Function GetAllQsLicensesForReporting_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, ByVal UserID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))

            Return objDBAccess.ExecuteDataTable("Qs_GetAllQsLicensesforPrinting_LM")
        End Function
        '===========
        Public Shared Function GetAllQsLicensesForReporting(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))

            Return objDBAccess.ExecuteDataTable("Qs_GetAllQsLicensesforPrinting")
        End Function

        Public Function AddQsLicense(ByVal objQsLicenseManagement As Portal.BLL.QsLicenseManagment) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@ClientID", objQsLicenseManagement.ClientID)
            objDBAccess.AddParameter("@StoreNo", objQsLicenseManagement.StoreNo)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objQsLicenseManagement.SystemIP), DBNull.Value, objQsLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@IsIPDynamic", objQsLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objQsLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objQsLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@Notes", IIf(String.IsNullOrEmpty(objQsLicenseManagement.Notes), DBNull.Value, objQsLicenseManagement.Notes))
            objDBAccess.AddParameter("@IssuedByID", objQsLicenseManagement.IssuedByID)

            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("Qs_GenerateNewQsLicense")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function
        Public Function GetQsLicenseDetail(ByVal licenseID As Integer) As Portal.BLL.QsLicenseManagment
            Dim objDBAccess As New DBAccess
            Dim rdrLicenseQsDetail As SqlDataReader
            Dim objQsLicenseManagement As New Portal.BLL.QsLicenseManagment
            objDBAccess.AddParameter("@LicenseID", licenseID)
            rdrLicenseQsDetail = objDBAccess.ExecuteReader("Qs_GetQsLicenseDetailByID")
            Try
                If (rdrLicenseQsDetail.HasRows) Then
                    If (rdrLicenseQsDetail.Read()) Then
                        objQsLicenseManagement.StoreNo = CInt(rdrLicenseQsDetail("StoreNumber"))
                        objQsLicenseManagement.StoreNick = rdrLicenseQsDetail("StoreNick").ToString()
						objQsLicenseManagement.ClientID = rdrLicenseQsDetail("ClientID").ToString()
                        objQsLicenseManagement.ClientName = rdrLicenseQsDetail("ClientCode").ToString()
                        objQsLicenseManagement.SystemIP = rdrLicenseQsDetail("SystemIP").ToString()
                        'objQsLicenseManagement.IsLicenseInActive = CBool(rdrLicenseSMXDetail("Inactive"))
                        objQsLicenseManagement.Notes = rdrLicenseQsDetail("Notes").ToString()
                        objQsLicenseManagement.InVoiceNo = rdrLicenseQsDetail("InvoiceNo").ToString()
                        objQsLicenseManagement.IsDynamicIP = CBool(rdrLicenseQsDetail("Is_IPDynamic"))
                        objQsLicenseManagement.IssuedBy = rdrLicenseQsDetail("IssuedBy").ToString()
                        objQsLicenseManagement.DynamicIPEndDate = IIf(rdrLicenseQsDetail("DynamicIPEndDate") Is DBNull.Value, DateTime.MinValue, rdrLicenseQsDetail("DynamicIPEndDate"))
                        objQsLicenseManagement.UpdatedOn = IIf(rdrLicenseQsDetail("UpdatedOn") Is DBNull.Value, DateTime.MinValue, rdrLicenseQsDetail("UpdatedOn"))
                        objQsLicenseManagement.LastUpdatedBy = rdrLicenseQsDetail("LastUpdatedBy")
                        objQsLicenseManagement.IssuedOn = rdrLicenseQsDetail("IssuedOn")
                        objQsLicenseManagement.IsLicenseInActive = rdrLicenseQsDetail("Inactive")
                        objQsLicenseManagement.NoOfTerminals = IIf(rdrLicenseQsDetail("TerminalCount") Is DBNull.Value, 0, CInt(rdrLicenseQsDetail("TerminalCount")))
                        objQsLicenseManagement.NoOfLiveTerminals = IIf(rdrLicenseQsDetail("LiveTerminalCount") Is DBNull.Value, 0, CInt(rdrLicenseQsDetail("LiveTerminalCount")))
                    End If
                End If
            Catch ex As Exception
                'Don't do any thing
            Finally
                objDBAccess.Dispose()
                rdrLicenseQsDetail.Close()
            End Try
            Return objQsLicenseManagement
        End Function
        Public Function AddQsLicenseTerminals(ByVal objQsLicenseManagement As Portal.BLL.QsLicenseManagment) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@InVoiceNo", objQsLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@IssuedByID", objQsLicenseManagement.IssuedByID)
            objDBAccess.AddParameter("@LicenseID", objQsLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@TerminalName", objQsLicenseManagement.TerminalName)
            objDBAccess.AddParameter("@CurrentVersion", objQsLicenseManagement.CurrentVersion)
            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("Qs_GenerateNewQsLicenseTerminals")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function

        Public Shared Function GetAllQsLicensesTerminalByLicienceID(ByVal LicenseID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteDataTable("Qs_GetAllQsLicensesTerminalbyID")
        End Function
        Public Function CheckBundleAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)


            Return objDBAccess.ExecuteScalar("Qs_CheckBundleAvailability")
        End Function
        Public Function Qs_UpdateStaticIP(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal StaticIP As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@StaticIP", StaticIP)

            Return objDBAccess.ExecuteScalar("[Qs_UpdateStaticIP]")
        End Function

        Public Function CheckStaticIPAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal StaticIP As String) As Integer
            Dim objDBAccess As New DBAccess
            Dim IPStatus As Integer = 0
            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteNonQuery("QS_CheckStaticIPAvailability")
            IPStatus = CInt(objDBAccess.Parameters("@IPStatus").value)
            Return IPStatus
        End Function


        Public Function CheckStaticIPExits(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess
            Dim IPStatus As Integer = 0
            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)

            objDBAccess.AddParameter("@IPExits", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteNonQuery("Qs_CheckStaticIPExits")
            IPStatus = CInt(objDBAccess.Parameters("@IPExits").value)
            Return IPStatus
        End Function

        Public Function Qs_UpdateDynamic(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal DynamicDate As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@StaticIP", DynamicDate)

            Return objDBAccess.ExecuteScalar("[Qs_UpdateStaticIP]")
        End Function

        Public Function CheckAdditinalAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@OutPutID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("Qs_CheckAdditonalAvailability")
            returnVal = CInt(objDBAccess.Parameters("@OutPutID").Value)
            Return returnVal
        End Function

        Public Function MakeActive(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)

            Return objDBAccess.ExecuteScalar("Qs_MakeLicenseTerminalActive")
        End Function

        Public Function MakeInActiveTerminal(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)

            Return objDBAccess.ExecuteScalar("Qs_MakeLicenseTerminalInActive")
        End Function


        Public Function UpdateQsLicenseDetail(ByVal objQsLicenseManagement As Portal.BLL.QsLicenseManagment) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@LicenseID", objQsLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@Is_IPDynamic", objQsLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objQsLicenseManagement.SystemIP), DBNull.Value, objQsLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objQsLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objQsLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@UpdatedByID", objQsLicenseManagement.UpdatedByID)
            'objDBAccess.AddParameter("@InvoiceNo", objSMSXLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@Notes", objQsLicenseManagement.Notes)
            objDBAccess.AddParameter("@Inactive", objQsLicenseManagement.IsLicenseInActive)

            Return objDBAccess.ExecuteScalar("Qs_LicenseDetail_Update")
        End Function

        Public Sub AddQsLicenseTerminalLog(ByVal objQsLicenseManagement As Portal.BLL.QsLicenseManagment)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@UserID", objQsLicenseManagement.UserID)
            objDBAccess.AddParameter("@LicenseID", objQsLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@Changes", objQsLicenseManagement.Changes)
            objDBAccess.AddParameter("@LicenseTerminalID", IIf(String.IsNullOrEmpty(objQsLicenseManagement.LicenseTerminalID), DBNull.Value, objQsLicenseManagement.LicenseTerminalID))

            objDBAccess.ExecuteScalar("Qs_AddQsLicenseTerminalLog")

            objDBAccess.Dispose()

        End Sub

        Public Function UpdateQsLicenseLog(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal Notes As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@userID", userID)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@Notes", Notes)

            Return objDBAccess.ExecuteScalar("Qs_UpdateQsLicenseLog")
        End Function

        Public Function UpdateDynamicIPToStaticIP(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal StaticIP As String, ByVal Notes As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@userID", userID)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@Notes", Notes)

            Return objDBAccess.ExecuteScalar("Qs_UpdateDynamicToStaticIP")
        End Function

        Public Function CheckSystemIPAvailability(ByVal StaticIP As String, ByVal LicencesID As Integer)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@LicencesID", LicencesID)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("Qs_CheckSytemIPAvailability")
            returnVal = CInt(objDBAccess.Parameters("@IPStatus").Value)
            Return returnVal
        End Function

        Public Function CheckSystemIPAvailabilitybyLicenseID(ByVal LicenseID As Integer, ByVal StaticIP As String)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("Qs_CheckSytemIPAvailabilityByLicenseID")
            returnVal = CInt(objDBAccess.Parameters("@IPStatus").Value)
            Return returnVal
        End Function

        Public Shared Function GetLicenseDetailForWebService(ByVal licenseId As Integer) As DataSet
            Dim objDbManager As New DbManager
            objDbManager.AddParameter("@LicenseId", licenseId)
            Return objDbManager.ExecuteDataSet("Qs_Licenses_GetDetailByID_WS")
        End Function


        Public Function UpdateLicenseDetails(ByVal dsLicenseDetail As DataSet) As Integer
            Dim objDBManager As New DbManager
            Dim rowsAffected As Integer = 0
            Try

                objDBManager.BeginTransaction()
                If dsLicenseDetail.Tables.Contains("License") AndAlso dsLicenseDetail.Tables("License").Rows.Count > 0 Then
                    objDBManager.AddParameter("@LicenseId", SqlDbType.Int, 4, "ID")
                    objDBManager.AddParameter("@CurrentIP", SqlDbType.NVarChar, 50, "CurrentIP")
                    rowsAffected += objDBManager.UpdateDataTable("Qs_Licenses_UpdateCurrentIP", dsLicenseDetail.Tables("License"))
                End If
                If dsLicenseDetail.Tables.Contains("LicenseTerminal") AndAlso dsLicenseDetail.Tables("LicenseTerminal").Rows.Count > 0 Then
                    objDBManager.Parameters.Clear()
                    objDBManager.AddParameter("@ID", SqlDbType.Int, 4, "ID")
                    objDBManager.AddParameter("@SystemID", SqlDbType.NVarChar, 500, "SystemID")
                    objDBManager.AddParameter("@SystemName", SqlDbType.VarChar, 70, "SystemName")
                    objDBManager.AddParameter("@CurrentVersion", SqlDbType.NVarChar, 200, "CurrentVersion")
                    objDBManager.AddParameter("@InstalledOn", SqlDbType.SmallDateTime, 4, "InstalledOn")
                    objDBManager.AddParameter("@ActivatedOn", SqlDbType.SmallDateTime, 4, "ActivatedOn")
                    objDBManager.AddParameter("@LastTimeSync", SqlDbType.SmallDateTime, 4, "LastTimeSync")
                    rowsAffected += objDBManager.UpdateDataTable("Qs_LicensesTerminals_Update_WS", dsLicenseDetail.Tables("LicenseTerminal"))
                End If
                If rowsAffected = Functions.GetRowCount(dsLicenseDetail) Then
                    objDBManager.CommitTransaction()
                Else
                    objDBManager.RollBackTransaction()
                End If
                Return rowsAffected
            Catch ex As Exception
                Try
                    objDBManager.RollBackTransaction()
                Catch excep As Exception
                End Try
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateLicenseDetails", String.Empty, String.Empty, "SMX Web service")
                Return rowsAffected
            End Try
        End Function

        ' Added by TZ on August 26, 2009
        Public Function GetAllSMSLicensesModified(ByVal lastUpdatedOn As DateTime) As DataSet
            Dim ds As DataSet = Nothing
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LastSyncDate", lastUpdatedOn)
            ds = objDBAccess.ExecuteDataSet("Qs_Licenses_GetAllModified")
            If ds IsNot Nothing Then
                If ds.Tables.Contains("Table") Then ds.Tables(0).TableName = "License"
                If ds.Tables.Contains("Table1") Then ds.Tables(1).TableName = "LicenseTerminal"
            End If
            Return ds
        End Function
        Public Shared Function GetAllQsLicensesTerminalForEmailByLicienceID(ByVal LicenseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteReader("Qs_GetAllQsLicensesTerminalbyID")
        End Function
        Public Shared Function GETQsFranchiseIDByStoreNumber(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@ClientID", ClientID)
            Return objDBAccess.ExecuteReader("Qs_GetFranchiseByStoreNumber")
        End Function
        Public Shared Function GETQsLicenseByFranchiseID(ByVal FranchiseID As Integer) As DataSet
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@FranchiseId", FranchiseID)
            Return objDBAccess.ExecuteDataSet("Qs_GetAllQsLicensesTerminalbyFranchiseID")
        End Function
        Public Shared Function GETQsIP(ByVal ClientID As Integer, ByVal StoreNumber As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            Dim Dr As SqlDataReader
            objDBAccess.AddParameter("@ClientID", ClientID)
            objDBAccess.AddParameter("@StoreNo", StoreNumber)
            Dr = objDBAccess.ExecuteReader("Qs_GETQsIPByClientID")
            Return Dr
        End Function

        Public Shared Function GetAllQsLicensesTerminalForEmailByLicienceIDForActivity(ByVal LicenseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteReader("Qs_GetAllQsLicensesTerminalbyIDForActivity")
        End Function

        Public Function Qs_RegenerateTerminalByID(ByVal ID As Integer, ByVal UpdatedUserID As Integer) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)
            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("Qs_RegenerateTerminalByID")
            Dim returnVal As Integer
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            Return returnVal
        End Function

        Public Shared Function GetLicenseTerminalDetailForWebService(ByVal NewId As Integer, ByVal TerminalID As Integer, ByVal licenseId As Integer) As DataSet
            Dim objDbManager As New DbManager
            objDbManager.AddParameter("@TerminalID", TerminalID)
            objDbManager.AddParameter("@LicenseId", licenseId)
            objDbManager.AddParameter("@NewId", NewId)
            Return objDbManager.ExecuteDataSet("Qs_LicensesTerminal_GetDetailByID_WS")
        End Function
        Public Shared Function Qs_LicensesChangeStatusByFranchiseID(ByVal FranchiseID As Integer, ByVal Status As Integer) As Integer
            Dim objDbManager As New DBAccess
            objDbManager.AddParameter("@FranchiseID", FranchiseID)
            objDbManager.AddParameter("@Status", Status)
            Dim LicensesID As Integer
            objDbManager.AddParameter("@LicensesID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDbManager.ExecuteNonQuery("Qs_LicensesChangeStatusByFranchiseID")
            LicensesID = CInt(Functions.IfNull(objDbManager.Parameters("@LicensesID").Value, 0))
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(LicensesID)
            dsLicenseDetail.DataSetName = "SMSXLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            Try
                'Update the details in the sms db via webservice.
                'Dim objSMSWebservice As New se.PortalServices
                'Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateSMSXLicense", String.Empty, String.Empty, String.Empty)
            End Try

        End Function

        Public Shared Function QsFranchiseID_ByStoreNumber(ByVal FranchiseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@FranchseID", FranchiseID)
            Return objDBAccess.ExecuteReader("Qs_GetFranchiseIDForSkip")
        End Function
        Public Shared Function GetActiveStoreLicensesCount(ByVal Qs_LicenseID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Qs_LicenseID", Qs_LicenseID)
            Return objDBAccess.ExecuteScalar("Qs_CheckLicenseForStore")
        End Function

        Public Shared Function GetStoreLicensesCount(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@ClientID", ClientID)
            Return objDBAccess.ExecuteScalar("Qs_GetLicenseForStore")

        End Function
		
        Public Shared Function GetTotalNoOfTerminalsByStoreNumber(ByVal StoreNumber As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            Return objDBAccess.ExecuteScalar("QS_GetNoOfTerminalsByStoreNumber")

        End Function

        Public Shared Function DeleteQsLicense(ByVal ID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@ID", ID)
            Return objDBAccess.ExecuteNonQuery("Qs_DeleteLicense")
        End Function
    End Class
End Namespace