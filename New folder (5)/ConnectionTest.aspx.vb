Imports System.Data
Imports System.Data.SqlClient

Partial Class ConnectionTest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim connectionStringCount = ConfigurationManager.ConnectionStrings.Count
        Dim isValid = True
        For i As Integer = 0 To connectionStringCount - 1
            Dim connection As New SqlConnection(ConfigurationManager.ConnectionStrings(i).ConnectionString)
            Try
                connection.Open()
            Catch ex As Exception
                isValid = False
                Exit For
            Finally
                connection.Close()
            End Try
        Next

        If (isValid) Then
            Response.Write("I am Alive")
        Else
            Response.Write("I am Dead")
        End If
    End Sub
End Class
