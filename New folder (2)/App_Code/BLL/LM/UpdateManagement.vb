Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.IO.Compression

Namespace Portal.BLL
    Public Class UpdateManagement
#Region "Private Variables"
#End Region
#Region "Public Properties"
#End Region
#Region "Public Functions"
        Public Shared Function GetAllSMSUpdate(ByVal countryID As Integer) As DataTable
            Dim objSMSUpdateServicce As se.PortalServices = New se.PortalServices()
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dataUpdate() As Byte = objSMSUpdateServicce.GetAllSMSUpdates(securityCode, countryID)
            Dim dsUpdate As DataSet = DecompressData(dataUpdate)
            If dsUpdate IsNot Nothing Then
                If dsUpdate.Tables.Count > 0 Then
                    Return dsUpdate.Tables(0)
                End If
            End If
            Return Nothing
        End Function

        Public Shared Function GetAllSMSUpdateCount(ByVal countryID As Integer) As Integer
            Dim objSMSUpdateServicce As se.PortalServices = New se.PortalServices()
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dataUpdate() As Byte = objSMSUpdateServicce.GetAllSMSUpdates(securityCode, countryID)
            Dim dsUpdate As DataSet = DecompressData(dataUpdate)
            If dsUpdate IsNot Nothing Then
                If dsUpdate.Tables.Count > 0 Then
                    Return dsUpdate.Tables(0).Rows.Count
                End If
            End If
            Return Nothing
        End Function

        Public Shared Function GetUpdateGroupsByUpdateID(ByVal countryID As Integer, ByVal updateID As Integer) As DataTable
            Dim objSMSUpdateServicce As se.PortalServices = New se.PortalServices()
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dataUpdateGroups() As Byte = objSMSUpdateServicce.GetUpdateGroupsByUpdateID(securityCode, countryID, updateID)
            Dim dsUpdate As DataSet = DecompressData(dataUpdateGroups)
            If dsUpdate IsNot Nothing Then
                If dsUpdate.Tables.Count > 0 Then
                    Return dsUpdate.Tables(0)
                End If
            End If
            Return Nothing
        End Function

        Public Shared Function GetGroupStoresByGroupID(ByVal countryID As Integer, ByVal groupID As Integer, ByVal updateID As Integer) As DataSet
            Dim objSMSUpdateServicce As se.PortalServices = New se.PortalServices()
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dataGroupStores() As Byte = objSMSUpdateServicce.GetGroupStoresByGroupID(securityCode, countryID, groupID, updateID)
            Dim dsUpdate As DataSet = DecompressData(dataGroupStores)
            If dsUpdate IsNot Nothing Then
                If dsUpdate.Tables.Count > 0 Then
                    Return dsUpdate
                End If
            End If
            Return Nothing
        End Function

        Public Shared Function GetAvailableStores(ByVal countryID As Integer, ByVal updateID As Integer) As DataSet
            Dim objSMSUpdateServicce As se.PortalServices = New se.PortalServices()
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dataGroupStores() As Byte = objSMSUpdateServicce.GetAvailableStores(securityCode, countryID, updateID)
            Dim dsUpdate As DataSet = DecompressData(dataGroupStores)
            If dsUpdate IsNot Nothing Then
                If dsUpdate.Tables.Count > 0 Then
                    Return dsUpdate
                End If
            End If
            Return Nothing
        End Function

        Public Shared Function AddUpdateGroupStore(ByVal countryID As Integer, ByVal dsGroupStore As DataSet) As Integer
            Dim objSMSUpdateServicce As se.PortalServices = New se.PortalServices()
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim rowsAffected As Integer = objSMSUpdateServicce.AddUpdateGroupStore(securityCode, countryID, dsGroupStore)
            Return rowsAffected
        End Function

        Public Shared Function DeleteGroupByID(ByVal updateID As Integer, ByVal groupID As Integer, ByVal countryID As Integer) As Integer
            Dim objSMSUpdateServicce As se.PortalServices = New se.PortalServices()
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim rowsAffected As Integer = objSMSUpdateServicce.DeleteGroupByID(countryID, updateID, groupID, securityCode)
            Return rowsAffected
        End Function



        Public Shared Function DecompressData(ByVal data As Byte()) As DataSet
            Try
                Dim memStream As New MemoryStream(data)
                Dim unzipStream As New GZipStream(memStream, CompressionMode.Decompress)
                Dim objDataSet As New DataSet()
                objDataSet.ReadXml(unzipStream, XmlReadMode.ReadSchema)
                unzipStream.Close()
                memStream.Close()
                Return objDataSet
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

#End Region
    End Class
End Namespace
