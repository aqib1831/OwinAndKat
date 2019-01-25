Imports System.Collections.Generic
Partial Class Support_SupportBatchReport
    Inherits System.Web.UI.Page


    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Not String.IsNullOrEmpty(Request.QueryString("IsXLS")) AndAlso CBool(Request.QueryString("IsXLS")) Then
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment; filename=SupportBatch.csv")
            Response.ContentType = "application/vnd.ms-excel"
        End If
    End Sub
End Class
