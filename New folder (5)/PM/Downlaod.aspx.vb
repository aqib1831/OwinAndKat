Imports System.IO
Imports System.Data.SqlClient
Partial Class PM_Downlaod
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("dt")) = False Then
            Dim Dt As DateTime = Functions.DecryptData(Request.QueryString("dt"))
            If Dt >= DateTime.Now.AddMinutes(-100) Then
                GetFile()
            End If
        End If
    End Sub

    Private Sub GetFile()
        Dim rdrAttachment As SqlDataReader = Nothing
        If String.IsNullOrEmpty(Request.QueryString("AttachmentID")) = False Then
            Dim AttachmentID As String = Functions.DecryptData(Request.QueryString("AttachmentID"))
            If AttachmentID > 0 Then
                Dim objNotes As New Portal.BLL.PM.PM_Notes
                rdrAttachment = objNotes.PM_GetAttachementsByID(AttachmentID)
            End If
        ElseIf String.IsNullOrEmpty(Request.QueryString("TicketID")) = False Then
            Dim AttachmentID As String = Functions.DecryptData(Request.QueryString("TicketID"))
            If AttachmentID > 0 Then
                Dim objNotes As New Portal.BLL.PM.PM_Notes
                rdrAttachment = objNotes.PM_GetAttachementsByTicketID(AttachmentID)
            End If
        End If

        Dim path As String
        If rdrAttachment.Read Then
            path = Server.MapPath(ConfigurationManager.AppSettings("PMAttachmentPath").ToString())
            path = path & "\" & rdrAttachment("FilePath")
            If File.Exists(path) Then
                Response.AppendHeader("content-disposition", "attachment; filename=" + rdrAttachment("FileName"))
                Response.ContentType = "Application/octet-binary"
                Response.WriteFile(path)
                Response.End()
            End If
            rdrAttachment.Close()
        End If
    End Sub
End Class
