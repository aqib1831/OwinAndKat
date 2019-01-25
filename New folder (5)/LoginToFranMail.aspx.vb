Imports Portal.BLL
Imports System.Data.SqlClient
Partial Class LoginToFranMail
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strResponse As String = ""
        If String.IsNullOrEmpty(Session("AdminID")) = False Then
            strResponse = LoginToFranMail(Session("AdminID"))
            If strResponse <> "" Then
                Response.Redirect(strResponse, True)
            End If
        End If

    End Sub
    Public Shared Function LoginToFranMail(ByVal AdminID As Integer) As String

        'Dim objSecure As New us.webmail.secure.Webmail
        Dim obj2 As New us.webmail.secure.Webmail
        Dim AdministrativeUserName As String
        Dim AdministrativePassword As String
        Dim strReturn As String = String.Empty
        Dim strResponse As String = String.Empty
        Dim WebMailSessionID As String = ""
        Dim WebMailUserID As String = ""
        Dim WebMailUserName As String = ""
        Dim CountryID As String = ""
        Dim strDomain As String = "netsolace.com.pk"
        Dim db As New DBAccess
        Dim dr As SqlDataReader
        Dim strLoginUrl As String = String.Empty
        AdministrativeUserName = ConfigurationManager.AppSettings("AdministrativeUserName")
        AdministrativePassword = ConfigurationManager.AppSettings("AdministrativePassword")

        db.AddParameter("@UserID", AdminID)
        db.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
        dr = db.ExecuteReader("FranMail_GetLoginInfo_ByUserID")
        If dr.Read Then
            WebMailUserName = dr("FranMail_UserName")
        End If
        dr.Close()

        WebMailUserID = Replace(WebMailUserName, "@netsolace.com.pk", "")
        obj2.ConnectionGroupName = Guid.NewGuid().ToString
        strResponse = obj2.LoginUserWebmail(AdministrativeUserName, AdministrativePassword, strDomain, WebMailUserID, WebMailSessionID)

        obj2.Dispose()

        If WebMailUserID <> "" And WebMailUserID <> "" Then
            'strReturn = "https://" & strLoginUrl & "/mail/src/redirect.php?user_name=" & WebMailUserName & "&emailaddress=" & WebMailUserName & "&sessionID=" & WebMailSessionID
            strReturn = "https://webmail.dofruit.com/mail/src/redirect.php?user_name=" & WebMailUserName & "&emailaddress=" & WebMailUserName & "&sessionID=" & WebMailSessionID
        End If

        Return strReturn

    End Function
End Class

