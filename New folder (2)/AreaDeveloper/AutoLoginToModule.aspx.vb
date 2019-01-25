Imports System.Data
Imports System.Data.SqlClient
Partial Class MyNetsolace_AutoLoginToModule
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("FranchiseID") <> Nothing Then
            If Request.QueryString("ContactID") <> Nothing Then
                Response.Redirect("FranchiseLogin.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&ClientID=" & Functions.DecryptData(Request.QueryString("ClientID")) & "&FranchiseID=" & Functions.DecryptData(Request.QueryString("FranchiseID")) & "&ContactID=" & Functions.DecryptData(Request.QueryString("ContactID")))
            Else
                Response.Redirect("AccessDenied.htm")
            End If
        ElseIf Request.QueryString("StoreNumber") <> Nothing Then
            Dim drContact As SqlDataReader
            Dim lngClientID As Integer
            Dim intStoreNumber As Integer
            lngClientID = CType(Functions.DecryptData(Request.QueryString("ClientID")), Integer)
            intStoreNumber = CType(Functions.DecryptData(Request.QueryString("StoreNumber")), Integer)
            drContact = Portal.BLL.Franchises.GetQsContactByStoreNumberandClientID(intStoreNumber, lngClientID)

            While drContact.Read
                If drContact.HasRows = True Then
                    Response.Redirect("FranchiseLogin.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&ClientID=" & lngClientID & "&FranchiseID=" & drContact("FranchiseID") & "&ContactID=" & drContact("ContactID"))
                Else
                    Response.Redirect("AccessDenied.htm")
                End If
            End While
            drContact.Close()
        Else
            If (Request.QueryString("ClientID") <> Nothing And IsNumeric(Request.QueryString("ClientID"))) Then
                If Not Request.QueryString("AreaDeveloperID") Is Nothing Then
                    If Not Request.QueryString("ContactID") Is Nothing Then
                        Response.Redirect("FransupportLogin.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&ClientID=" & Request.QueryString("ClientID") & "&ContactID=" & Functions.DecryptData(Request.QueryString("ContactID")) & "&AreaDeveloperID=" & Functions.DecryptData(Request.QueryString("AreaDeveloperID")))
                    End If
                Else
                    Response.Redirect("FransupportLogin.aspx?dt=" & Functions.EncryptData(DateTime.Now) & "&ClientID=" & Request.QueryString("ClientID") & "&UserID=" & Request.QueryString("UserID"))
                End If

            Else
                Response.Redirect("AccessDenied.htm")
            End If
        End If
    End Sub
End Class
