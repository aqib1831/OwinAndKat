Imports System.Collections.Generic

Partial Class MyNetsolace_FransupportLogin
    Inherits System.Web.UI.Page
    'Client Contact for Auto Login
    Private ClientContactType = Portal.BLL.Enumeration.ClientContactType.EAICorporate

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Not Page.IsPostBack Then
            If Not Request.QueryString("ContactID") Is Nothing And IsNumeric(Request.QueryString("ContactID")) Then
                If Not Request.QueryString("AreaDeveloperID") Is Nothing And IsNumeric(Request.QueryString("AreaDeveloperID")) Then
                    ClientContactType = Portal.BLL.Enumeration.ClientContactType.AreaDeveloper
                End If
            End If
            If (ClientContactType = Portal.BLL.Enumeration.ClientContactType.AreaDeveloper) Then
                AuthenticateAreaDeveloper()
            Else
                AuthenticateCorporateUser()
            End If
        End If
    End Sub
    Private Sub AuthenticateCorporateUser()
        If Request.QueryString("dt") <> String.Empty And Request.QueryString("UserID") <> Nothing And Request.QueryString("ClientID") <> Nothing And IsNumeric(Request.QueryString("ClientID")) Then
            If (ValidateRequestTime() = True) Then
                Dim FranSupportIDstr As String = Request.QueryString("UserID")
                FranSupportIDstr = Functions.DecryptData(FranSupportIDstr)
                If FranSupportIDstr <> String.Empty AndAlso IsNumeric(FranSupportIDstr) Then
                    Dim AdminID As Integer = CInt(FranSupportIDstr)
                    Dim ClientContactID As Integer = 0
                    ClientContactID = Portal.BLL.Client.Client_Contacts.AuthenticateCorporateUser(CInt(Request.QueryString("ClientID")), AdminID)
                    If ClientContactID > 0 Then
                        Response.Redirect("~/MyNetsolace/MainPage.aspx?" & Request.QueryString.ToString(), True)
                    Else
                        Response.Redirect("AccessDenied.htm")
                    End If
                Else
                    Response.Redirect("AccessDenied.htm")
                End If
            Else
                Response.Redirect("AccessDenied.htm")
            End If
        Else
            Response.Redirect("AccessDenied.htm")
        End If
    End Sub

    Public Sub AuthenticateAreaDeveloper()
        If Request.QueryString("dt") <> String.Empty And Request.QueryString("ContactID") <> Nothing And Request.QueryString("ClientID") <> Nothing Then
            If (ValidateRequestTime() = True) Then
                If IsNumeric(Request.QueryString("ClientID")) And IsNumeric(Request.QueryString("ContactID")) Then
                    Dim objFranchises As Portal.BLL.Client.Client_Contacts = New Portal.BLL.Client.Client_Contacts
                    If (objFranchises.AuthenticateAreaDeveloper(CInt(Request.QueryString("ContactID")), CInt(Request.QueryString("AreaDeveloperID")), CInt(Request.QueryString("ClientID"))) > 0) Then
                        Response.Redirect("~/MyNetsolace/MainPage.aspx?" & Request.QueryString.ToString(), True)
                    Else
                        Response.Redirect("AccessDenied.htm")
                    End If
                Else
                    Response.Redirect("AccessDenied.htm")
                End If
            Else
                Response.Redirect("AccessDenied.htm")
            End If
        Else
            Response.Redirect("AccessDenied.htm")
        End If
        
    End Sub

    Public Function ValidateRequestTime() As Boolean
        Dim isValid As Boolean = False
        If Not Request.QueryString("dt") Is Nothing Then
            Dim dtstr As String = CStr(Request.QueryString("dt"))
            dtstr = Functions.DecryptData(dtstr)
            Dim dt As DateTime = CType(dtstr, DateTime)
            If dt < DateTime.Now.AddMinutes(10) AndAlso dt > DateTime.Now.AddMinutes(-10) Then
                isValid = True
            Else
                isValid = False
            End If
        Else
            isValid = False
        End If
        Return isValid
    End Function
End Class
