Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Partial Class FranchiseAutoSignIn
    Inherits System.Web.UI.Page

    Protected strSqlFranchiseContact As String
    Protected reqFrachiseID As String
    Protected reqAccountType As String
    Protected strUserName As String
    Protected strPassword As String
    Protected strStoreNumber As String
    Protected reqCoordinator As String
    Protected strFranSupportFranchiseeLoginPostUrl As String = ConfigurationManager.AppSettings("FransupportOwnerLoginURL")
    Protected strFranSupportStoreLoginPostUrl As String = ConfigurationManager.AppSettings("FransupportStoreLoginURL")


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ClientID As Integer = 0

        reqFrachiseID = Trim(Functions.DecryptData(Request.QueryString("FranchiseID")))
        reqAccountType = Trim(Functions.DecryptData(Request.QueryString("Type")))
        reqCoordinator = Trim(Request("Coordinator"))

        LogPortalAdminFransupportLogin()

        '----Get Fransupport ID
        Dim dr As SqlDataReader
        Dim objConnectionStringSettingsPortal As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
        Dim db1 As DBAccess = New DBAccess(objConnectionStringSettingsPortal.ConnectionString)
        db1.AddParameter("@ID", reqFrachiseID)
        dr = db1.ExecuteReader("Franchises_GetFransupportFranchiseID_ByID")
        While dr.Read()
            reqFrachiseID = dr("FranchiseID")
        End While
        dr.Close()
        '---------------------
        Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("FransupportConnectionString")
        Dim TotalStores As Integer = 0
        If ClientID = Portal.BLL.Enumeration.ClientID.Frutation Then
            objConnectionStringSettings = ConfigurationManager.ConnectionStrings("FrutationConnectionString")
        ElseIf ClientID = Portal.BLL.Enumeration.ClientID.SaladCreation Then
            objConnectionStringSettings = ConfigurationManager.ConnectionStrings("SaladCreationConnectionString")
        End If
        Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
        db.AddParameter("@FranchiseID", reqFrachiseID)
        db.AddParameter("@Type", reqAccountType)
        If CLng(reqAccountType) = Portal.BLL.Enumeration.LoginAccountID.Owner Then
            db.AddParameter("@Primary", 1)
        End If
        dr = db.ExecuteReader("Portal_UserAutoLoginAutentication")
        While dr.Read()
            strUserName = dr("UserName")
            strPassword = dr("Password")
            strStoreNumber = dr("StoreNumber")
        End While
        dr.Close()
    End Sub

    Public Sub LogPortalAdminFransupportLogin()

        Dim objFransupportLoginHistory As New Portal.BLL.FransupportLoginHistory

        objFransupportLoginHistory.AdminId = Session("AdminId")
        If CInt(reqAccountType) = Portal.BLL.Enumeration.LoginAccountID.Owner Then
            objFransupportLoginHistory.FransupportEnd = Portal.BLL.Enumeration.FransupportEnd.OwnerEnd
        ElseIf CInt(reqAccountType) = Portal.BLL.Enumeration.LoginAccountID.Store Then
            objFransupportLoginHistory.FransupportEnd = Portal.BLL.Enumeration.FransupportEnd.StoreEnd
        End If
        objFransupportLoginHistory.IP = Request.UserHostAddress

        Portal.DAL.FransupportLoginHistoryManager.Add(objFransupportLoginHistory)

    End Sub
End Class
