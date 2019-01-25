
Partial Class Communication_WeeklyLetterHomeContent
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dt As Data.DataTable = Portal.BLL.Communication.WeeklyLetter.WeeeklyLettersGetByUserID(CType(Session("AdminID"), Integer))
        If dt.Rows.Count > 0 Then
            'div.InnerHtml = dt.Rows(0).Item("Description")
            Response.Write(dt.Rows(0).Item("Description"))
        End If
    End Sub
End Class
