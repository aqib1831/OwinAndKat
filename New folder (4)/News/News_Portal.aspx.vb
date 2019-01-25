Imports System.Data.SqlClient

Partial Class News_News_Portal
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnContinue.Click
        Dim newdsid As Integer = CType(fvNews.FindControl("lblNewsID"), HiddenField).Value
        Portal.BLL.News.News_Users.News_UsersAdd(0, newdsid, Session("AdminID"))
        If Portal.BLL.News.News.NewsGetByUserID(CType(Session("AdminID"), Integer)).Rows.Count > 0 Then
            fvNews.DataBind()
        Else
            If Portal.BLL.Communication.WeeklyLetter.WeeeklyLettersGetByUserID(CType(Session("AdminID"), Integer)).Rows.Count > 0 Then
                Response.Redirect("~/Communication/WeeklyLetterHome.aspx")
            Else
                Response.Redirect("~/Home.aspx", True)
            End If
        End If
    End Sub
End Class