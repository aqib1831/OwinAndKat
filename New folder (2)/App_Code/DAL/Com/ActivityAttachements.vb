Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports Portal.BLL

Namespace Portal.DAL
    Public Class ActivityAttachements
        Public Function SaveAttachments(ByVal DirectoryName As String, ByVal Attachment As FileUpload, ByVal objActivityAttachement As Portal.BLL.ActivityAttachements) As Integer
            Dim strAlbumPath As String = ConfigurationManager.AppSettings("PortalComAttachmentPath").ToString()
            strAlbumPath = HttpContext.Current.Server.MapPath(strAlbumPath) & DirectoryName
            If My.Computer.FileSystem.DirectoryExists(strAlbumPath) = False Then
                My.Computer.FileSystem.CreateDirectory(strAlbumPath)
            End If
            If Attachment.FileName.Trim() <> String.Empty Then
                objActivityAttachement.FileName = Attachment.FileName
                objActivityAttachement.FilePath = DirectoryName & "\" & objActivityAttachement.FileName                
                Attachment.SaveAs(strAlbumPath & "\" & objActivityAttachement.FileName)
                Return Me.AddAttachments(objActivityAttachement)
            End If
        End Function

        Public Function AddAttachments(ByVal objActivityAttachment As Portal.BLL.ActivityAttachements) As Integer
            Dim intReturn As Integer            
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ActivityID", IIf(objActivityAttachment.ActivityID = 0, DBNull.Value, objActivityAttachment.ActivityID))
            db.AddParameter("@NotesID", SqlDbType.Int, 4, ParameterDirection.Input, IIf(objActivityAttachment.NotesID = 0, DBNull.Value, objActivityAttachment.NotesID))
            db.AddParameter("@Filepath", objActivityAttachment.FilePath)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            Try
                db.ExecuteNonQuery("Activities_NotesAttachment_Add")
                intReturn = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                db.Dispose()
            End Try
            Return intReturn
        End Function
        Public Function GetAttachmentPath(ByVal DirectoryName As String) As String
            Dim strAlbumPath As String = ConfigurationManager.AppSettings("PortalComAttachmentPath").ToString()
            strAlbumPath = HttpContext.Current.Server.MapPath(strAlbumPath) & DirectoryName
            If My.Computer.FileSystem.DirectoryExists(strAlbumPath) = False Then
                My.Computer.FileSystem.CreateDirectory(strAlbumPath)
            End If
            Return strAlbumPath
        End Function
    End Class
End Namespace


