Imports System.Data.SqlClient

Partial Class Admin_ChangePassword
    Inherits System.Web.UI.Page

    Protected CountryID As String = String.Empty
    Protected StateID As String = String.Empty
    Protected RoleID As String = String.Empty
    Protected Password As String = String.Empty


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Request.QueryString("Type") <> String.Empty Then
                hdnType.Value = Request.QueryString("Type")
                lblPassword.Text = "Old Password:"
            ElseIf Request.QueryString("Temp") <> String.Empty Then
                hdnTemp.Value = Request.QueryString("Temp")
                lblPassword.Text = "Temporary Password:"
            End If
			If (CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ChangePasswordvar Or CBool(Session("Admin_ChangePassword")) = True) Then
                Me.btnCancel.Visible = False
                Me.SpanSecurutyMess.Visible = True
            Else
                Me.btnCancel.Visible = True
                Me.SpanSecurutyMess.Visible = False
            End If

        End If
    End Sub

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        Dim ID As Integer = Integer.Parse(Session("AdminID").ToString())
        Dim Result As Integer = 0
		If (Portal.BLL.Users.IsPasswordAllowed(NewPassword.Text.Trim) = False) Then
            trErrorMessage.Attributes.Add("style", "display:inline")
            spnError.InnerText = "Password shouldn't match with your Username, Company or City name. please try again. "
            Exit Sub
        End If
        Result = Portal.BLL.Users.ChangePassword(ID, OldPassword.Text.Trim, NewPassword.Text.Trim)
        If Result = 1 Then
            trErrorMessage.Attributes.Add("style", "display:inline")
            spnError.InnerHtml = "<font color=""#308A22"">Password has been changed.</font>"
            Session.Contents.Remove("Admin_ChangePassword")
            CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ChangePasswordvar = 0
            'Response.Redirect("~/Home.aspx", True)
            Me.btnCancel.Visible = True
            Me.SpanSecurutyMess.Visible = False
            If hdnType.Value <> Nothing AndAlso CStr(hdnType.Value) = "Password" Then
                Response.Redirect("~/Home.aspx", True)
            ElseIf hdnTemp.Value <> Nothing AndAlso CStr(hdnTemp.Value) = "TempPassword" Then
                Response.Redirect("~/Home.aspx", True)
            End If
        ElseIf Result = 2 Then
            'If Not String.IsNullOrEmpty(hdnType.Value) Then
            If hdnType.Value = "Password" Then
                trErrorMessage.Attributes.Add("style", "display:inline")
                spnError.InnerText = "Old Password is Incorrect"
            ElseIf hdnTemp.Value = "TempPassword" Then
                trErrorMessage.Attributes.Add("style", "display:inline")
                spnError.InnerText = "Temporary Password is Incorrect"
            Else
                trErrorMessage.Attributes.Add("style", "display:inline")
                spnError.InnerText = "Old Password is Incorrect"
            End If
            
        End If
    End Sub

End Class