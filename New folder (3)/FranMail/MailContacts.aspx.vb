Imports System.Data
Imports System.Data.SqlClient

Partial Class FranMail_MailContacts
    Inherits System.Web.UI.Page

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click

        Dim intReturn As Integer = 0
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Email", LCase(txtEmail.Text))
        db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, intReturn)
        Try
            db.ExecuteNonQuery("FranMail_Emails_Add")
            intReturn = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
        Catch ex As Exception
            intReturn = 0
        Finally
            db.Dispose()
        End Try

        If intReturn = 1 Then
            lblError.Text = "<br>This email address already exists!"
        Else
            Response.Redirect(Request.Url.ToString)
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", Request.QueryString("ID"))
            Try
                db.ExecuteNonQuery("FranMail_Emails_Delete")
            Catch ex As Exception
            Finally
                db.Dispose()
            End Try
        End If

    End Sub

End Class
