Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports Portal.DAL
Namespace Portal.BLL


    Public Class LMUserAccess

#Region "Private Variables"
        Private _UserID As String
        Private _ClientID As String
        Private _AccessType As String
#End Region

#Region "Public Properties"

        Public Property UserID() As String
            Get
                Return _UserID
            End Get
            Set(ByVal value As String)
                _UserID = value
            End Set
        End Property

        Public Property ClientID() As String
            Get
                Return _ClientID
            End Get
            Set(ByVal value As String)
                _ClientID = value
            End Set
        End Property

        Public Property AccessType() As String
            Get
                Return _AccessType
            End Get
            Set(ByVal value As String)
                _AccessType = value
            End Set
        End Property

#End Region

#Region "Public Functions"
        Public Function GetRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetRightsByLicenseID(LicenseID, UserID)
        End Function
        Public Function GetSMSRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetSMSRightsByLicenseID(LicenseID, UserID)
        End Function
        Public Function GetDMRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetDMRightsByLicenseID(LicenseID, UserID)
        End Function
        Public Function GetLMRightsByUserID(ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetLMRightsByUserID(UserID)
        End Function
        Public Function GetQSRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetQSRightsByLicenseID(LicenseID, UserID)
        End Function

        Public Function GetSMSXRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetSMSXRightsByLicenseID(LicenseID, UserID)
        End Function

        Public Function GetSMSKRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetSMSKRightsByLicenseID(LicenseID, UserID)
        End Function
        Public Function GetSDFRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetDFRightsByLicenseID(LicenseID, UserID)
        End Function
        Public Function GetDCRightsByLicenseID(ByVal LicenseID As Integer, ByVal UserID As Integer) As DataTable
            Dim objDB As New LMUserAccessDB
            Return objDB.GetDCRightsByLicenseID(LicenseID, UserID)
        End Function
#End Region
    End Class
End Namespace