Imports System.Data.SqlClient

Partial Class Communication_WeeklyLetterHome
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnContinue.Click
        Dim letterid As Integer = CType(fvNews.Controls(0).FindControl("lblWeeklyLetterID"), HiddenField).Value
        Portal.BLL.Communication.WeeklyLetter_Users.WeeklyLetter_UsersAdd(Session("AdminID"), letterid)
        If Portal.BLL.Communication.WeeklyLetter.WeeeklyLettersGetByUserID(CType(Session("AdminID"), Integer)).Rows.Count > 0 Then
            fvNews.DataBind()
        Else
            Response.Redirect("~/Home.aspx", True)
        End If
    End Sub
End Class