Imports System.Data.SqlClient

Partial Class Admin_ChangePassword
    Inherits System.Web.UI.Page

    Protected CountryID As String = String.Empty
    Protected StateID As String = String.Empty
    Protected RoleID As String = String.Empty
    Protected Password As String = String.Empty


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("Type") <> String.Empty Then
                hdnType.Value = Request.QueryString("Type")
            End If
            'If (CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ChangePasswordvar Or CBool(Session("Admin_ChangePassword")) = True) Then
            '    Me.btnCancel.Visible = False
            '    Me.SpanSecurutyMess.Visible = True
            'Else
            Me.btnCancel.Visible = True
            Me.SpanSecurutyMess.Visible = False
            'End If

        End If
    End Sub

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        Dim ID As Integer = Integer.Parse(Session("MyNetsolace_ClientContactID").ToString())
        Dim Result As Integer = 0
        'If (Portal.BLL.Users.IsPasswordAllowed(NewPassword.Text.Trim) = False) Then
        '          trErrorMessage.Attributes.Add("style", "display:inline")
        '          spnError.InnerText = "Password shouldn't match with your Username,Company or City name. please try again. "
        '          Exit Sub
        '      End If
        Result = Portal.BLL.Client.Client_Contacts.ChangePassword(ID, OldPassword.Text.Trim, NewPassword.Text.Trim)
        If Result = 1 Then
            trErrorMessage.Attributes.Add("style", "display:inline")
            spnError.InnerHtml = "<font color=""#308A22"">Password has been changed.</font>"

            'Response.Redirect("~/Home.aspx", True)
            Me.btnCancel.Visible = True
            Me.SpanSecurutyMess.Visible = False
            'If hdnType.Value <> Nothing AndAlso CStr(hdnType.Value) = "Password" Then
            '    Response.Redirect("~/Mynetsolace/MainPage.aspx", True)
            'End If
        ElseIf Result = 2 Then
            trErrorMessage.Attributes.Add("style", "display:inline")
            spnError.InnerText = "Old Password is Incorrect"
        End If
    End Sub

End Class