Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.DAL
    Public Class DFLicenseManagement

        Public Shared Function GetAllDFLicenses(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                                ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            Return objDBAccess.ExecuteDataTable("DF_GetAllDFLicenses")
        End Function

        Public Shared Function GetAllDFLicensesCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            Return objDBAccess.ExecuteScalar("DF_GetAllDFLicensesCount")
        End Function
        '=========================
        Public Shared Function GetAllDFLicenses_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
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
            Return objDBAccess.ExecuteDataTable("DF_GetAllDFLicenses_LM")
        End Function

        Public Shared Function GetAllDFLicensesCount_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal UserID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            Return objDBAccess.ExecuteScalar("DF_GetAllDFLicensesCount_LM")
        End Function
        Public Shared Function GetAllSMXLicensesForReporting_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, ByVal UserID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@UserID", UserID)
            Return objDBAccess.ExecuteDataTable("DF_GetAllDFLicensesforPrinting_LM")
        End Function

        '=========================
        Public Shared Function GetStoreLicensesCount(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@ClientID", ClientID)
            Return objDBAccess.ExecuteScalar("DF_GetLicenseForStore")

        End Function

        Public Shared Function GetAllSMXLicensesForReporting(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))

            Return objDBAccess.ExecuteDataTable("DF_GetAllDFLicensesforPrinting")
        End Function

        Public Function CheckSystemIPAvailability(ByVal StaticIP As String, ByVal LicencesID As Integer)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@LicencesID", LicencesID)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DF_CheckSytemIPAvailability")
            returnVal = CInt(objDBAccess.Parameters("@IPStatus").Value)
            Return returnVal
        End Function

        Public Function CheckBundleAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)


            Return objDBAccess.ExecuteScalar("DF_CheckBundleAvailability")
        End Function

        Public Function AddSMSXLicense(ByVal objDFLicenseManagement As Portal.BLL.DFLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@ClientID", objDFLicenseManagement.ClientID)
            objDBAccess.AddParameter("@StoreNo", objDFLicenseManagement.StoreNo)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objDFLicenseManagement.SystemIP), DBNull.Value, objDFLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@IsIPDynamic", objDFLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objDFLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objDFLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@Notes", IIf(String.IsNullOrEmpty(objDFLicenseManagement.Notes), DBNull.Value, objDFLicenseManagement.Notes))
            objDBAccess.AddParameter("@IssuedByID", objDFLicenseManagement.IssuedByID)

            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DF_GenerateNewDFLicense")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function



        Public Function AddDFLicenseTerminal(ByVal objDFLicenseManagement As Portal.BLL.DFLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@InVoiceNo", objDFLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@IssuedByID", objDFLicenseManagement.IssuedByID)
            objDBAccess.AddParameter("@LicenseID", objDFLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@TerminalName", objDFLicenseManagement.TerminalName)

            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DF_GenerateNewDFLicenseTerminals")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function

        Public Function CheckAdditinalAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@OutPutID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DF_CheckAdditonalAvailability")
            returnVal = CInt(objDBAccess.Parameters("@OutPutID").Value)
            Return returnVal
        End Function

        Public Function CheckStaticIPAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal StaticIP As String) As Integer
            Dim objDBAccess As New DBAccess
            Dim IPStatus As Integer = 0
            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteNonQuery("DF_CheckStaticIPAvailability")
            IPStatus = CInt(objDBAccess.Parameters("@IPStatus").value)
            Return IPStatus
        End Function

        Public Function CheckStaticIPExits(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess
            Dim IPStatus As Integer = 0
            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)

            objDBAccess.AddParameter("@IPExits", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteNonQuery("DF_CheckStaticIPExits")
            IPStatus = CInt(objDBAccess.Parameters("@IPExits").value)
            Return IPStatus
        End Function

        Public Function UpdateDFLicenseLog(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal Notes As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@userID", userID)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@Notes", Notes)

            Return objDBAccess.ExecuteScalar("DF_UpdateDFLicenseLog")
        End Function

        Public Function UpdateDynamicIPToStaticIP(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal StaticIP As String, ByVal Notes As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@userID", userID)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@Notes", Notes)

            Return objDBAccess.ExecuteScalar("DF_UpdateDynamicToStaticIP")
        End Function

        Public Shared Function GetAllDFLicensesTerminalByLicienceID(ByVal LicenseID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteDataTable("DF_GetAllDFLicensesTerminalbyID")
        End Function

        Public Function GetDFLicenseDetail(ByVal licenseID As Integer) As Portal.BLL.DFLicenseManagement
            Dim objDBAccess As New DBAccess
            Dim rdrLicenseDFDetail As SqlDataReader
            Dim objDFLicenseManagement As New Portal.BLL.DFLicenseManagement
            objDBAccess.AddParameter("@LicenseID", licenseID)
            rdrLicenseDFDetail = objDBAccess.ExecuteReader("DF_GetDFLicenseDetailByID")
            Try
                If (rdrLicenseDFDetail.HasRows) Then
                    If (rdrLicenseDFDetail.Read()) Then
                        objDFLicenseManagement.StoreNo = CInt(rdrLicenseDFDetail("StoreNumber"))
                        objDFLicenseManagement.StoreNick = rdrLicenseDFDetail("StoreNick").ToString()
                        objDFLicenseManagement.ClientName = rdrLicenseDFDetail("ClientCode").ToString()
                        objDFLicenseManagement.ClientID = rdrLicenseDFDetail("ClientID")
                        objDFLicenseManagement.SystemIP = rdrLicenseDFDetail("SystemIP").ToString()
                        'objDFLicenseManagement.IsLicenseInActive = CBool(rdrLicenseDFDetail("Inactive"))
                        objDFLicenseManagement.Notes = rdrLicenseDFDetail("Notes").ToString()
                        objDFLicenseManagement.InVoiceNo = rdrLicenseDFDetail("InvoiceNo").ToString()
                        objDFLicenseManagement.IsDynamicIP = CBool(rdrLicenseDFDetail("Is_IPDynamic"))
                        objDFLicenseManagement.IssuedBy = rdrLicenseDFDetail("IssuedBy").ToString()
                        objDFLicenseManagement.DynamicIPEndDate = IIf(rdrLicenseDFDetail("DynamicIPEndDate") Is DBNull.Value, DateTime.MinValue, rdrLicenseDFDetail("DynamicIPEndDate"))
                        objDFLicenseManagement.UpdatedOn = IIf(rdrLicenseDFDetail("UpdatedOn") Is DBNull.Value, DateTime.MinValue, rdrLicenseDFDetail("UpdatedOn"))
                        objDFLicenseManagement.LastUpdatedBy = rdrLicenseDFDetail("LastUpdatedBy")
                        objDFLicenseManagement.IssuedOn = rdrLicenseDFDetail("IssuedOn")
                        objDFLicenseManagement.IsLicenseInActive = rdrLicenseDFDetail("Inactive")
                        objDFLicenseManagement.NoOfTerminals = IIf(rdrLicenseDFDetail("TerminalCount") Is DBNull.Value, 0, CInt(rdrLicenseDFDetail("TerminalCount")))
                        objDFLicenseManagement.NoOfLiveTerminals = IIf(rdrLicenseDFDetail("LiveTerminalCount") Is DBNull.Value, 0, CInt(rdrLicenseDFDetail("LiveTerminalCount")))
                        objDFLicenseManagement.InstallationDate = CType(rdrLicenseDFDetail("InstallationDate"), DateTime)


                    End If
                End If
            Catch ex As Exception
                'Don't do any thing
            Finally
                objDBAccess.Dispose()
                rdrLicenseDFDetail.Close()
            End Try
            Return objDFLicenseManagement
        End Function


        Public Function UpdateDFLicenseDetail(ByVal objDFLicenseManagement As Portal.BLL.DFLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@LicenseID", objDFLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@Is_IPDynamic", objDFLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objDFLicenseManagement.SystemIP), DBNull.Value, objDFLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objDFLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objDFLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@UpdatedByID", objDFLicenseManagement.UpdatedByID)
            'objDBAccess.AddParameter("@InvoiceNo", objDFLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@Notes", objDFLicenseManagement.Notes)
            objDBAccess.AddParameter("@Inactive", objDFLicenseManagement.IsLicenseInActive)
            If objDFLicenseManagement.InstallationDate <> Date.MaxValue Then
                objDBAccess.AddParameter("@InstallationDate", objDFLicenseManagement.InstallationDate)

            End If


            Return objDBAccess.ExecuteScalar("DF_LicenseDetail_Update")
        End Function

        Public Function CheckSystemIPAvailabilitybyLicenseID(ByVal LicenseID As Integer, ByVal StaticIP As String)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DF_CheckSytemIPAvailabilityByLicenseID")
            returnVal = CInt(objDBAccess.Parameters("@IPStatus").Value)
            Return returnVal
        End Function


        Public Shared Function GetActiveStoreLicensesCount(ByVal DF_LicenseID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@DF_LicenseID", DF_LicenseID)
            Return objDBAccess.ExecuteScalar("DF_CheckLicenseForStore")
        End Function

        Public Sub AddDFLicenseTerminalLog(ByVal objDFLicenseManagement As Portal.BLL.DFLicenseManagement)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@UserID", objDFLicenseManagement.UserID)
            objDBAccess.AddParameter("@LicenseID", objDFLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@Changes", objDFLicenseManagement.Changes)
            objDBAccess.AddParameter("@LicenseTerminalID", IIf(String.IsNullOrEmpty(objDFLicenseManagement.LicenseTerminalID), DBNull.Value, objDFLicenseManagement.LicenseTerminalID))

            objDBAccess.ExecuteScalar("DF_AddDFLicenseTerminalLog")

            objDBAccess.Dispose()

        End Sub

        Public Function DF_RegenerateTerminalByID(ByVal ID As Integer, ByVal UpdatedUserID As Integer) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)
            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("DF_RegenerateTerminalByID")
            Dim returnVal As Integer
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            Return returnVal
        End Function

        Public Shared Function GetAllDFLicensesTerminalForEmailByLicienceIDForActivity(ByVal LicenseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteReader("DF_GetAllDFLicensesTerminalbyIDForActivity")
        End Function

        Public Shared Function GETDFFranchiseIDByStoreNumber(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@ClientID", ClientID)
            Return objDBAccess.ExecuteReader("SMSX_GetFranchiseByStoreNumber")
        End Function

        Public Shared Function GETDFIP(ByVal ClientID As Integer, ByVal StoreNumber As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            Dim Dr As SqlDataReader
            objDBAccess.AddParameter("@ClientID", ClientID)
            objDBAccess.AddParameter("@StoreNo", StoreNumber)
            Dr = objDBAccess.ExecuteReader("DF_GETDFIPByClientID")
            Return Dr
        End Function

        Public Function MakeInActiveTerminal(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)

            Return objDBAccess.ExecuteScalar("DF_MakeLicenseTerminalInActive")
        End Function

        Public Function MakeActive(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)

            Return objDBAccess.ExecuteScalar("DF_MakeLicenseTerminalActive")
        End Function

        Public Function GetAllDFLicensesModified(ByVal lastUpdatedOn As DateTime) As DataSet
            Dim ds As DataSet = Nothing
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LastSyncDate", lastUpdatedOn)
            ds = objDBAccess.ExecuteDataSet("DF_Licenses_GetAllModified")
            If ds IsNot Nothing Then
                If ds.Tables.Contains("Table") Then ds.Tables(0).TableName = "License"
                If ds.Tables.Contains("Table1") Then ds.Tables(1).TableName = "LicenseTerminal"
            End If
            Return ds
        End Function

        Public Function UpdateLicenseDetails(ByVal dsLicenseDetail As DataSet) As Integer
            Dim objDBManager As New DbManager
            Dim rowsAffected As Integer = 0
            Try

                objDBManager.BeginTransaction()
                If dsLicenseDetail.Tables.Contains("License") AndAlso dsLicenseDetail.Tables("License").Rows.Count > 0 Then
                    objDBManager.AddParameter("@LicenseId", SqlDbType.Int, 4, "ID")
                    objDBManager.AddParameter("@CurrentIP", SqlDbType.NVarChar, 50, "CurrentIP")
                    rowsAffected += objDBManager.UpdateDataTable("DF_Licenses_UpdateCurrentIP", dsLicenseDetail.Tables("License"))
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
                    rowsAffected += objDBManager.UpdateDataTable("DF_LicensesTerminals_Update_WS", dsLicenseDetail.Tables("LicenseTerminal"))
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
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateLicenseDetails", String.Empty, String.Empty, "DF Web service")
                Return rowsAffected
            End Try
        End Function

        Public Shared Function GetLicenseDetailForWebService(ByVal licenseId As Integer) As DataSet
            Dim objDbManager As New DbManager
            objDbManager.AddParameter("@LicenseId", licenseId)
            Return objDbManager.ExecuteDataSet("DF_Licenses_GetDetailByID_WS")
        End Function

        Public Shared Function GetLicenseTerminalDetailForWebService(ByVal NewId As Integer, ByVal TerminalID As Integer, ByVal licenseId As Integer) As DataSet
            Dim objDbManager As New DbManager
            objDbManager.AddParameter("@TerminalID", TerminalID)
            objDbManager.AddParameter("@LicenseId", licenseId)
            objDbManager.AddParameter("@NewId", NewId)
            Return objDbManager.ExecuteDataSet("DF_LicensesTerminal_GetDetailByID_WS")
        End Function

        Public Shared Function DeleteDFLicense(ByVal ID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@ID", ID)
            Return objDBAccess.ExecuteNonQuery("DF_DeleteLicense")
        End Function
    End Class
End Namespace