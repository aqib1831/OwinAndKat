Imports System.Data.SqlClient

Partial Class admin_comm_WeeklyLetter_Published
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim LetterID As String
        Dim objWeeklyLetter As New Portal.BLL.Communication.WeeklyLetter
        Dim rdr As SqlDataReader
        Dim reqStoreEmployee As String
        reqStoreEmployee = Request.QueryString("StoreEmployee")

        LetterID = Request.QueryString("LetterID")
        rdr = objWeeklyLetter.GetWeeklyLetter_ByID(LetterID)

        If rdr.Read Then
            Response.Clear()
            If reqStoreEmployee = "1" Then
                Response.Write(rdr("DescriptionForStoreEmployee"))
            Else
                Response.Write(rdr("Description"))
            End If

        End If
        rdr.Close()

    End Sub
End Class
