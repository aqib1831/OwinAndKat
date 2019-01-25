Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.DAL
    Public Class SMSXLicenseManagement

        Public Shared Function GetAllSMSXLicenses(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
                                                ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            Return objDBAccess.ExecuteDataTable("SMSX_GetAllSMSXLicenses")
        End Function

        Public Shared Function GetAllSMSXLicensesCount(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            Return objDBAccess.ExecuteScalar("SMSX_GetAllSMSXLicensesCount")
        End Function

        '=======================
        Public Shared Function GetAllSMSXLicenses_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, _
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
            Return objDBAccess.ExecuteDataTable("SMSX_GetAllSMSXLicenses_LM")
        End Function

        Public Shared Function GetAllSMSXLicensesCount_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal UserID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            Return objDBAccess.ExecuteScalar("SMSX_GetAllSMSXLicensesCount_LM")
        End Function
        Public Shared Function GetAllSMXLicensesForReporting_LM(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String, ByVal UserID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@UserID", UserID)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))

            Return objDBAccess.ExecuteDataTable("SMSX_GetAllSMSXLicensesforPrinting_LM")
        End Function
        '=======================

        Public Shared Function GetAllSMXLicensesForReporting(ByVal search As String, ByVal clientId As Integer, ByVal inActive As Integer, ByVal stateId As Integer, ByVal sortBy As String) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Search", IIf(String.IsNullOrEmpty(search), DBNull.Value, search))
            objDBAccess.AddParameter("@ClientID", clientId)
            objDBAccess.AddParameter("@InActive", inActive)
            objDBAccess.AddParameter("@StateID", stateId)
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))

            Return objDBAccess.ExecuteDataTable("SMSX_GetAllSMSXLicensesforPrinting")
        End Function

        Public Function AddSMSXLicense(ByVal objSMSXLicenseManagement As Portal.BLL.SMSXLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@ClientID", objSMSXLicenseManagement.ClientID)
            objDBAccess.AddParameter("@StoreNo", objSMSXLicenseManagement.StoreNo)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objSMSXLicenseManagement.SystemIP), DBNull.Value, objSMSXLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@IsIPDynamic", objSMSXLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objSMSXLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objSMSXLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@Notes", IIf(String.IsNullOrEmpty(objSMSXLicenseManagement.Notes), DBNull.Value, objSMSXLicenseManagement.Notes))
            objDBAccess.AddParameter("@IssuedByID", objSMSXLicenseManagement.IssuedByID)

            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("SMSX_GenerateNewSMSXLicense")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function
        Public Function GetSMSXLicenseDetail(ByVal licenseID As Integer) As Portal.BLL.SMSXLicenseManagement
            Dim objDBAccess As New DBAccess
            Dim rdrLicenseSMXDetail As SqlDataReader
            Dim objSMSXLicenseManagement As New Portal.BLL.SMSXLicenseManagement
            objDBAccess.AddParameter("@LicenseID", licenseID)
            rdrLicenseSMXDetail = objDBAccess.ExecuteReader("SMSX_GetSMSXLicenseDetailByID")
            Try
                If (rdrLicenseSMXDetail.HasRows) Then
                    If (rdrLicenseSMXDetail.Read()) Then
                        objSMSXLicenseManagement.StoreNo = CInt(rdrLicenseSMXDetail("StoreNumber"))
                        objSMSXLicenseManagement.StoreNick = rdrLicenseSMXDetail("StoreNick").ToString()
                        objSMSXLicenseManagement.ClientName = rdrLicenseSMXDetail("ClientCode").ToString()
                        objSMSXLicenseManagement.ClientID = rdrLicenseSMXDetail("ClientId")
                        objSMSXLicenseManagement.SystemIP = rdrLicenseSMXDetail("SystemIP").ToString()
                        'objSMSXLicenseManagement.IsLicenseInActive = CBool(rdrLicenseSMXDetail("Inactive"))
                        objSMSXLicenseManagement.Notes = rdrLicenseSMXDetail("Notes").ToString()
                        objSMSXLicenseManagement.InVoiceNo = rdrLicenseSMXDetail("InvoiceNo").ToString()
                        objSMSXLicenseManagement.IsDynamicIP = CBool(rdrLicenseSMXDetail("Is_IPDynamic"))
                        objSMSXLicenseManagement.IssuedBy = rdrLicenseSMXDetail("IssuedBy").ToString()
                        objSMSXLicenseManagement.DynamicIPEndDate = IIf(rdrLicenseSMXDetail("DynamicIPEndDate") Is DBNull.Value, DateTime.MinValue, rdrLicenseSMXDetail("DynamicIPEndDate"))
                        objSMSXLicenseManagement.UpdatedOn = IIf(rdrLicenseSMXDetail("UpdatedOn") Is DBNull.Value, DateTime.MinValue, rdrLicenseSMXDetail("UpdatedOn"))
                        objSMSXLicenseManagement.LastUpdatedBy = rdrLicenseSMXDetail("LastUpdatedBy")
                        objSMSXLicenseManagement.IssuedOn = rdrLicenseSMXDetail("IssuedOn")
                        objSMSXLicenseManagement.IsLicenseInActive = rdrLicenseSMXDetail("Inactive")
                        objSMSXLicenseManagement.NoOfTerminals = IIf(rdrLicenseSMXDetail("TerminalCount") Is DBNull.Value, 0, CInt(rdrLicenseSMXDetail("TerminalCount")))
                        objSMSXLicenseManagement.NoOfLiveTerminals = IIf(rdrLicenseSMXDetail("LiveTerminalCount") Is DBNull.Value, 0, CInt(rdrLicenseSMXDetail("LiveTerminalCount")))
						objSMSXLicenseManagement.InstallationDate = CType(rdrLicenseSMXDetail("InstallationDate"), DateTime)
                    End If
                End If
            Catch ex As Exception
                'Don't do any thing
            Finally
                objDBAccess.Dispose()
                rdrLicenseSMXDetail.Close()
            End Try
            Return objSMSXLicenseManagement
        End Function
        Public Function AddSMSXLicenseTerminals(ByVal objSMSXLicenseManagement As Portal.BLL.SMSXLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@InVoiceNo", objSMSXLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@IssuedByID", objSMSXLicenseManagement.IssuedByID)
            objDBAccess.AddParameter("@LicenseID", objSMSXLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@TerminalName", objSMSXLicenseManagement.TerminalName)
            objDBAccess.AddParameter("@TerminalType", objSMSXLicenseManagement.TerminalType)

            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("SMSX_GenerateNewSMSXLicenseTerminals")
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            objDBAccess.Dispose()
            Return returnVal
        End Function

        Public Shared Function GetAllSMSXLicensesTerminalByLicienceID(ByVal LicenseID As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteDataTable("SMSX_GetAllSMSXLicensesTerminalbyID")
        End Function
        Public Function CheckBundleAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)


            Return objDBAccess.ExecuteScalar("SMSX_CheckBundleAvailability")
        End Function
        Public Function SMS_UpdateStaticIP(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal StaticIP As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@StaticIP", StaticIP)

            Return objDBAccess.ExecuteScalar("[SMSX_UpdateStaticIP]")
        End Function

        Public Function CheckStaticIPAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal StaticIP As String) As Integer
            Dim objDBAccess As New DBAccess
            Dim IPStatus As Integer = 0
            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteNonQuery("SMSX_CheckStaticIPAvailability")
            IPStatus = CInt(objDBAccess.Parameters("@IPStatus").value)
            Return IPStatus
        End Function


        Public Function CheckStaticIPExits(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess
            Dim IPStatus As Integer = 0
            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)

            objDBAccess.AddParameter("@IPExits", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteNonQuery("SMSX_CheckStaticIPExits")
            IPStatus = CInt(objDBAccess.Parameters("@IPExits").value)
            Return IPStatus
        End Function

        Public Function SMS_UpdateDynamic(ByVal clientID As Integer, ByVal StoreNo As Integer, ByVal DynamicDate As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@StaticIP", DynamicDate)

            Return objDBAccess.ExecuteScalar("[SMSX_UpdateStaticIP]")
        End Function

        Public Function CheckAdditinalAvailability(ByVal clientID As Integer, ByVal StoreNo As Integer) As Integer
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@ClientID", clientID)
            objDBAccess.AddParameter("@StoreNo", StoreNo)
            objDBAccess.AddParameter("@OutPutID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("SMSX_CheckAdditonalAvailability")
            returnVal = CInt(objDBAccess.Parameters("@OutPutID").Value)
            Return returnVal
        End Function

        Public Function MakeActive(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)

            Return objDBAccess.ExecuteScalar("SMSX_MakeLicenseTerminalActive")
        End Function

        Public Function MakeInActiveTerminal(ByVal ID As Integer, ByVal UpdatedUserID As Integer)
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)

            Return objDBAccess.ExecuteScalar("SMSX_MakeLicenseTerminalInActive")
        End Function


        Public Function UpdateSMSXLicenseDetail(ByVal objSMSXLicenseManagement As Portal.BLL.SMSXLicenseManagement) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@LicenseID", objSMSXLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@Is_IPDynamic", objSMSXLicenseManagement.IsDynamicIP)
            objDBAccess.AddParameter("@SystemIP", IIf(String.IsNullOrEmpty(objSMSXLicenseManagement.SystemIP), DBNull.Value, objSMSXLicenseManagement.SystemIP))
            objDBAccess.AddParameter("@DynamicIPEndDate", IIf(objSMSXLicenseManagement.DynamicIPEndDate = Date.MinValue, DBNull.Value, objSMSXLicenseManagement.DynamicIPEndDate))
            objDBAccess.AddParameter("@UpdatedByID", objSMSXLicenseManagement.UpdatedByID)
            'objDBAccess.AddParameter("@InvoiceNo", objSMSXLicenseManagement.InVoiceNo)
            objDBAccess.AddParameter("@Notes", objSMSXLicenseManagement.Notes)
            objDBAccess.AddParameter("@Inactive", objSMSXLicenseManagement.IsLicenseInActive)
			If (objSMSXLicenseManagement.InstallationDate = DateTime.MinValue) Then
				objDBAccess.AddParameter("@InstallationDate",  DBNull.Value)
            Else
			objDBAccess.AddParameter("@InstallationDate", objSMSXLicenseManagement.InstallationDate)
            End If

            Return objDBAccess.ExecuteScalar("SMSX_LicenseDetail_Update")
        End Function

        Public Sub AddSMSXLicenseTerminalLog(ByVal objSMSXLicenseManagement As Portal.BLL.SMSXLicenseManagement)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@UserID", objSMSXLicenseManagement.UserID)
            objDBAccess.AddParameter("@LicenseID", objSMSXLicenseManagement.LicenseID)
            objDBAccess.AddParameter("@Changes", objSMSXLicenseManagement.Changes)
            objDBAccess.AddParameter("@LicenseTerminalID", IIf(String.IsNullOrEmpty(objSMSXLicenseManagement.LicenseTerminalID), DBNull.Value, objSMSXLicenseManagement.LicenseTerminalID))

            objDBAccess.ExecuteScalar("SMSX_AddSMSXLicenseTerminalLog")

            objDBAccess.Dispose()

        End Sub

        Public Function UpdateSMSXLicenseLog(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal Notes As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@userID", userID)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@Notes", Notes)

            Return objDBAccess.ExecuteScalar("SMSX_UpdateSMSXLicenseLog")
        End Function

        Public Function UpdateDynamicIPToStaticIP(ByVal userID As Integer, ByVal LicenseID As Integer, ByVal StaticIP As String, ByVal Notes As String) As Boolean
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@userID", userID)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@Notes", Notes)

            Return objDBAccess.ExecuteScalar("SMSX_UpdateDynamicToStaticIP")
        End Function

        Public Function CheckSystemIPAvailability(ByVal StaticIP As String, ByVal LicencesID As Integer)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@LicencesID", LicencesID)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("SMSX_CheckSytemIPAvailability")
            returnVal = CInt(objDBAccess.Parameters("@IPStatus").Value)
            Return returnVal
        End Function

        Public Function CheckSystemIPAvailabilitybyLicenseID(ByVal LicenseID As Integer, ByVal StaticIP As String)
            Dim objDBAccess As New DBAccess
            Dim returnVal As Integer = 0

            objDBAccess.AddParameter("@StaticIP", StaticIP)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            objDBAccess.AddParameter("@IPStatus", System.Data.SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("SMSX_CheckSytemIPAvailabilityByLicenseID")
            returnVal = CInt(objDBAccess.Parameters("@IPStatus").Value)
            Return returnVal
        End Function

        Public Shared Function GetLicenseDetailForWebService(ByVal licenseId As Integer) As DataSet
            Dim objDbManager As New DbManager
            objDbManager.AddParameter("@LicenseId", licenseId)
            Return objDbManager.ExecuteDataSet("SMSX_Licenses_GetDetailByID_WS")
        End Function

        Public Function UpdateLicenseDetails(ByVal dsLicenseDetail As DataSet) As Integer
            Dim objDBManager As New DbManager
            Dim rowsAffected As Integer = 0
	    Dim dsTableCount As Integer = 0

	    dsTableCount = dsLicenseDetail.Tables("LicenseTerminal").Rows.Count
            Try

                objDBManager.BeginTransaction()
                If dsLicenseDetail.Tables.Contains("License") AndAlso dsLicenseDetail.Tables("License").Rows.Count > 0 Then
                    objDBManager.AddParameter("@LicenseId", SqlDbType.Int, 4, "ID")
                    objDBManager.AddParameter("@CurrentIP", SqlDbType.NVarChar, 50, "CurrentIP")
                    rowsAffected += objDBManager.UpdateDataTable("SMSX_Licenses_UpdateCurrentIP", dsLicenseDetail.Tables("License"))
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

                    objDBManager.AddParameter("@GUID_Activation", SqlDbType.NVarChar, 100, "GUID_Activation")
                    objDBManager.AddParameter("@GUID_Installation", SqlDbType.NVarChar, 100, "GUID_Installation")

                    rowsAffected += objDBManager.UpdateDataTable("SMSX_LicensesTerminals_Update_WS", dsLicenseDetail.Tables("LicenseTerminal"))
                End If
                'If rowsAffected = Functions.GetRowCount(dsLicenseDetail) Then
		If rowsAffected > 0 Then
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
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateLicenseDetails" & dsTableCount.ToString(), String.Empty, String.Empty, "SMX Web service" & dsLicenseDetail.GetXml() )
                Return rowsAffected
            End Try
        End Function
        
        ' Added by TZ on August 26, 2009
        Public Function GetAllSMSLicensesModified(ByVal lastUpdatedOn As DateTime) As DataSet
            Dim ds As DataSet = Nothing
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LastSyncDate", lastUpdatedOn)
            ds = objDBAccess.ExecuteDataSet("SMSX_Licenses_GetAllModified")
            If ds IsNot Nothing Then
                If ds.Tables.Contains("Table") Then ds.Tables(0).TableName = "License"
                If ds.Tables.Contains("Table1") Then ds.Tables(1).TableName = "LicenseTerminal"
            End If
            Return ds
        End Function
        Public Shared Function GetAllSMSXLicensesTerminalForEmailByLicienceID(ByVal LicenseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteReader("SMSX_GetAllSMSXLicensesTerminalbyID")
        End Function
        Public Shared Function GetActivationKeysByTerminalIDs(ByVal TerminalIDs As String) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@IDs", TerminalIDs)
            Return objDBAccess.ExecuteReader("SMSX_GetActivationKeysByTerminalIDs")
        End Function
        Public Shared Function GETSMSXFranchiseIDByStoreNumber(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@ClientID", ClientID)
            Return objDBAccess.ExecuteReader("SMSX_GetFranchiseByStoreNumber")
        End Function
        Public Shared Function GETSMSXLicenseByFranchiseID(ByVal FranchiseID As Integer) As DataSet
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@FranchiseId", FranchiseID)
            Return objDBAccess.ExecuteDataSet("SMSX_GetAllSMSXLicensesTerminalbyFranchiseID")
        End Function
        Public Shared Function GETSMSXIP(ByVal ClientID As Integer, ByVal StoreNumber As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            Dim Dr As SqlDataReader
            objDBAccess.AddParameter("@ClientID", ClientID)
            objDBAccess.AddParameter("@StoreNo", StoreNumber)
            Dr = objDBAccess.ExecuteReader("SMSX_GETSMSXIPByClientID")
            Return Dr
        End Function

        Public Shared Function GetAllSMSXLicensesTerminalForEmailByLicienceIDForActivity(ByVal LicenseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteReader("SMSX_GetAllSMSXLicensesTerminalbyIDForActivity")
        End Function

        Public Function SMSX_RegenerateTerminalByID(ByVal ID As Integer, ByVal UpdatedUserID As Integer) As Integer
            Dim objDBAccess As New DBAccess

            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@UpdatedBy", UpdatedUserID)
            objDBAccess.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBAccess.ExecuteScalar("SMSX_RegenerateTerminalByID")
            Dim returnVal As Integer
            returnVal = CInt(objDBAccess.Parameters("@ReturnVal").Value)
            Return returnVal
        End Function

        Public Shared Function GetLicenseTerminalDetailForWebService(ByVal NewId As Integer, ByVal TerminalID As Integer, ByVal licenseId As Integer) As DataSet
            Dim objDbManager As New DbManager
            objDbManager.AddParameter("@TerminalID", TerminalID)
            objDbManager.AddParameter("@LicenseId", licenseId)
            objDbManager.AddParameter("@NewId", NewId)
            Return objDbManager.ExecuteDataSet("SMSX_LicensesTerminal_GetDetailByID_WS")
        End Function

        Public Shared Function SMSX_LicensesChangeStatusByFranchiseID(ByVal FranchiseID As Integer, ByVal Status As Integer) As Integer
            Dim objDbManager As New DBAccess
            objDbManager.AddParameter("@FranchiseID", FranchiseID)
            objDbManager.AddParameter("@Status", Status)
            Dim LicensesID As Integer
            objDbManager.AddParameter("@LicensesID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDbManager.ExecuteNonQuery("SMSX_LicensesChangeStatusByFranchiseID")
            LicensesID = CInt(Functions.IfNull(objDbManager.Parameters("@LicensesID").Value, 0))
                Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(LicensesID)
            dsLicenseDetail.DataSetName = "SMSXLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            Try
                'Update the details in the sms db via webservice.
                Dim objSMSWebservice As New se.PortalServices
                Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateSMSXLicense", String.Empty, String.Empty, String.Empty)
            End Try
           
        End Function

        Public Shared Function SMSXFranchiseID_ByStoreNumber(ByVal FranchiseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@FranchseID", FranchiseID)
            Return objDBAccess.ExecuteReader("SMSX_GetFranchiseIDForSkip")
        End Function

        Public Shared Function GetActiveStoreLicensesCount(ByVal SMSx_LicenseID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@SMSx_LicenseID", SMSx_LicenseID)
            Return objDBAccess.ExecuteScalar("SMSX_CheckLicenseForStore")
        End Function

        Public Shared Function GetStoreLicensesCount(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@StoreNumber", StoreNumber)
            objDBAccess.AddParameter("@ClientID", ClientID)
            Return objDBAccess.ExecuteScalar("SMSX_GetLicenseForStore")

        End Function

        Public Shared Function UpdateTerminalName(ByVal ID As Integer, ByVal TerminalName As String) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@TerminalName", TerminalName)
            Return objDBAccess.ExecuteNonQuery("SMSX_UpdateTerminalName")
        End Function
        Public Shared Function IsTerminalNameExist(ByVal ID As Integer, ByVal TerminalName As String, ByVal LicenseID As Integer) As SqlDataReader
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@ID", ID)
            objDBAccess.AddParameter("@TerminalName", TerminalName)
            objDBAccess.AddParameter("@LicenseID", LicenseID)
            Return objDBAccess.ExecuteReader("SMSX_IsTerminalNameExist")

        End Function

	Public Shared Function GetLicenseID(ByVal ID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@NS_Products_FranchiseID", ID)
            Dim licenseid As Integer = -1
            Dim rdr As SqlDataReader = Nothing
            rdr = objDBAccess.ExecuteReader("SMSx_GetLicenseID")
            While rdr.Read
                licenseid = rdr("LicenseID")
            End While
	    rdr.Close	
            Return licenseid

        End Function

        Public Shared Function GetAllSMSXLicensesSMSxVersion(ByVal version As String, ByVal Status As Integer, ByVal sortBy As String, _
                                                ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim objDBAccess As New DBAccess

            If version = "All" Then
                objDBAccess.AddParameter("@version", DBNull.Value)
            Else
                objDBAccess.AddParameter("@version", version)
            End If
            If Status = 0 Then
                objDBAccess.AddParameter("@Status", DBNull.Value)
            Else
                objDBAccess.AddParameter("@Status", Status)
            End If


            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))
            objDBAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDBAccess.AddParameter("@MaximumRows", maximumRows)
            Return objDBAccess.ExecuteDataTable("SMSX_GetAllSMSXLicensesSMSxVersionReport")
        End Function

        Public Shared Function GetAllSMSXLicensesSMSxVersionCount(ByVal version As String, ByVal Status As Integer) As Integer
            Dim objDBAccess As New DBAccess

            If version = "All" Then
                objDBAccess.AddParameter("@version", DBNull.Value)
            Else
                objDBAccess.AddParameter("@version", version)
            End If
            If Status = 0 Then
                objDBAccess.AddParameter("@Status", DBNull.Value)
            Else
                objDBAccess.AddParameter("@Status", Status)
            End If
            Return objDBAccess.ExecuteScalar("SMSX_GetAllSMSXLicensesSMSxVersionReportCount")
        End Function

        Public Shared Function GetAllSMXLicensesSMSxVersionForReporting(ByVal version As String, ByVal sortBy As String, ByVal Status As Integer) As DataTable
            Dim objDBAccess As New DBAccess
            If version = "All" Then
                objDBAccess.AddParameter("@version", DBNull.Value)
            Else
                objDBAccess.AddParameter("@version", version)
            End If
            If Status = 0 Then
                objDBAccess.AddParameter("@Status", DBNull.Value)
            Else
                objDBAccess.AddParameter("@Status", Status)
            End If
            objDBAccess.AddParameter("@SortBy", IIf(String.IsNullOrEmpty(sortBy), DBNull.Value, sortBy))

            Return objDBAccess.ExecuteDataTable("SMSX_GetAllSMSXLicensesSMSxVersionforPrinting")
        End Function

        Public Shared Function DeleteSMSXLicense(ByVal ID As Integer) As Integer
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@ID", ID)
            Return objDBAccess.ExecuteNonQuery("SMSX_DeleteLicense")
        End Function
    End Class
End Namespace