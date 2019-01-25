Imports System.IO
Imports System.Data.SqlClient

Partial Class StoreDocuments_Download
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'Admin.ValidateSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) = True Then
            hdnAttachmentID.Value = Request.QueryString("ID")
            Try
                If hdnAttachmentID.Value > 0 Then
                    Dim rdrAttachment As SqlDataReader = Nothing
                    Dim path As String
                    'rdrAttachment = Activity.Vendor_SCM_GetAttachmentsPathByID(hdnAttachmentID.Value)
                    rdrAttachment = IntellectualProperty.Legal_GetAttachmentsPathByID(hdnAttachmentID.Value)
                    If rdrAttachment.Read Then
                        If Request.QueryString("Type") = "Legal" Then
                            path = Server.MapPath(ConfigurationManager.AppSettings("IPAttachPath").ToString())
                        Else
                            path = Server.MapPath(ConfigurationManager.AppSettings("CaseAttachPath").ToString())
                        End If
                        path = path & "\" & rdrAttachment("FilePath")
                        If File.Exists(path) Then
                            Response.AppendHeader("content-disposition", "attachment; filename=" + path)
                            Response.ContentType = "Application/octet-binary"
                            Response.WriteFile(path)
			    Response.end
                        End If
                    End If
                    rdrAttachment.Close()
                End If
            Catch ex As Exception
        End Try
        End If
    End Sub

End Class
