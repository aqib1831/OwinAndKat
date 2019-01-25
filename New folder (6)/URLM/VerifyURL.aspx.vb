Imports System.Data

Partial Class URLM_VerifyURL
    Inherits System.Web.UI.Page
   

    Protected Sub btnStarUpdate_Click(sender As Object, e As EventArgs) Handles btnStarUpdate.Click
        Dim objStartURLm As New URLM
        Dim myTableData As DataTable
        myTableData = objStartURLm.GetURLInfoforUpdateExpiray()
        If myTableData.Rows.Count > 0 Then
            For i As Integer = 0 To myTableData.Rows.Count - 1
                hdnurlIdarray.Value = hdnurlIdarray.Value & myTableData.Rows(i)(0) & ","
                hdnUrlarry.Value = hdnUrlarry.Value & myTableData.Rows(i)(1) & ","
            Next
            Page.ClientScript.RegisterStartupScript(Me.GetType(), "CallMyFunction", "CallCheckApiExpiry()", True)
        End If
    End Sub
   
End Class
