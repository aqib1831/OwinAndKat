Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Data.SqlClient
Imports System.Web

Partial Class MyNetsolace_Default
    Inherits System.Web.UI.Page

    Private _strPIN As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Browser Support Check
        Functions.CheckForIE()
        If Not IsPostBack Then
            Portal.BLL.Client.Client_Contacts.OnlyRemoveSessionOfMyNetsolace()
        End If
        trErrorMessage.Visible = False
        spnError.InnerText = String.Empty
        txtClientCode.Focus()
    End Sub
    Protected Sub cmdSignIn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdSignIn.Click
        validateUser(Trim(txtUserName.Text), Trim(txtPassword.Text))
    End Sub

    Sub validateUser(ByVal UserName As String, ByVal Password As String)
        tblForm.Style.Remove("display")
        If Portal.BLL.Client.Client_Contacts.ValidateMyNetsolaceUsers(UserName, Password, txtClientCode.Text) Then
            If Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.NewPoint OR Context.Session("MyNetsolace_ClientID") = 11 Then
                Response.Redirect("~/MyNetsolace/PM/PMMain.aspx", True)
            Else
                Response.Redirect("~/MyNetsolace/MainPage.aspx?ClientID=" & Session("MyNetsolace_ClientID"), True)
            End If
        Else
            spnError.InnerText = "Invalid Username Or Password!"
            trErrorMessage.Visible = True
        End If
    End Sub
End Class
