Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class MyNetsolace_NSBS_Download
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("ID")) = False Then
            Dim id As Integer = Request.QueryString("ID")
            Dim rdr As SqlDataReader
            rdr = Portal.BLL.UM.Document.DocumentGetByID(id)
            While rdr.Read()
                'Dim path As String = Server.MapPath("../../" & ConfigurationManager.AppSettings("PortalComAttachmentPath")) & rdr("FileName")
		Dim path As String =  Server.MapPath(ConfigurationManager.AppSettings("PortalComAttachmentPath")) & rdr("FileName")
                If File.Exists(path) Then
                    Dim strFileName As String = rdr("FileName").Substring(rdr("FileName").LastIndexOf("/") + 1, rdr("FileName").Length - (rdr("FileName").LastIndexOf("/") + 1))
                    Response.AppendHeader("content-disposition", "attachment; filename=" + strFileName)
                    Response.ContentType = "Application/octet-binary"
                    Response.WriteFile(path)
                End If
            End While
            rdr.Close()
        End If
    End Sub
End Class
