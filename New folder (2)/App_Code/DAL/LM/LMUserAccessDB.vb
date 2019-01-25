Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Public Class LMUserAccessDB
    Public Function GetRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@SBS_UserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("Lm_GetRightsByLicenseID")
    End Function

    Public Function GetDMRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@DMenuUserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_DmenuAccessByLicenseID")
    End Function
    Public Function GetSMSRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@DMenuUserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_SMSAccessByLicenseID")
    End Function
    Public Function GetLMRightsByUserID(ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_CheckFor_ReadWriteByUserID")
    End Function
    Public Function GetQSRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@DMenuUserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_QSAccessByLicenseID")
    End Function
    Public Function GetSMSXRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@DMenuUserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_SMSXAccessByLicenseID")
    End Function
    Public Function GetSMSKRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@DMenuUserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_SMSKAccessByLicenseID")
    End Function
    Public Function GetDFRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@DMenuUserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_DFAccessByLicenseID")
    End Function
    Public Function GetDCRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
        Dim objDBAccess As New DBAccess
        objDBAccess.AddParameter("@DMenuUserID", LicenseID)
        objDBAccess.AddParameter("@UserID", UserID)
        Return objDBAccess.ExecuteDataTable("LM_DCAccessByLicenseID")
    End Function
End Class