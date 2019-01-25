Imports Telerik.WebControls
Partial Class Admin_UploadImage
    Inherits System.Web.UI.Page


    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    '    If Not IsPostBack Then
    '        If Request.QueryString("hdnClientID") <> String.Empty AndAlso IsNumeric(Request.QueryString("hdnClientID")) Then
    '            Me.hdnClientID.Text = CStr(Request.QueryString("hdnClientID"))
    '        End If
    '    End If
    'End Sub

    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnUpload.Click
        Dim TelfileImage As UploadedFile = RadUploadContext.Current.UploadedFiles(fileImage.UniqueID)
        If Not TelfileImage Is Nothing Then
            Dim strFolder As String = Nothing
            Dim strImagePath As String = ConfigurationManager.AppSettings("ClientImagesPath").ToString()
            strFolder = Functions.GetDateTimeUniqueString()
            strImagePath = HttpContext.Current.Server.MapPath(strImagePath) & strFolder
            If My.Computer.FileSystem.DirectoryExists(strImagePath) = False Then
                My.Computer.FileSystem.CreateDirectory(strImagePath)
            End If

            'Dim fileProcessImageTelFixSize As System.Drawing.Bitmap = GetFixSizeImage(fileProcessImageTel.InputStream)
            'If (fileProcessImageTel.GetExtension().ToLower() = ".jpg" Or fileProcessImageTel.GetExtension().ToLower() = ".jpeg") Then
            strImagePath = strImagePath & "/" & TelfileImage.GetName
            strFolder = strFolder & "/" & TelfileImage.GetName
            TelfileImage.SaveAs(strImagePath, True)
            Dim fullurlpath As String = ResolveClientUrl(ConfigurationManager.AppSettings("ClientImagesPath") & strFolder)
            'Else
            '    fileProcessImageTelFixSize.Save(strAlbumPath & "\" & fileProcessImageTel.GetNameWithoutExtension & ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg)
            'End If


            'LooongMethodWhichUpdatesTheProgressContext(fileProcessImageTel)
            'Dim fileProcessImageTelThumbs As System.Drawing.Bitmap = GetThumbImage(fileProcessImageTel.InputStream)
            'fileProcessImageTelThumbs.Save(strAlbumPath & "\Thumb" & fileProcessImageTel.GetNameWithoutExtension & ".jpg", System.Drawing.Imaging.ImageFormat.Jpeg)
            'Dim objProductProcessTempFiles As New Portal.BLL.SBS.SBS_Product_Process_TempFiles

            'With objProductProcessTempFiles
            '    .GUID = hdnGUID.Value
            '    .CategoryProductSizeID = hdnProductSizeID.Value
            '    .Name = fileProcessImageTel.GetNameWithoutExtension & ".jpg"
            '    .Path = strpath & "/"
            '    .ThumbName = "Thumb" & fileProcessImageTel.GetNameWithoutExtension & ".jpg"
            '    .EntryDate = DateTime.Now
            '    .Deleted = False
            '    .Type = 1 'Images
            '    Portal.BLL.SBS.SBS_Product_Process_TempFiles.SBS_Product_Process_TempFilesAdd(.GUID, .CategoryProductSizeID, .Name, .Path, .ThumbName, .EntryDate, .Deleted, .Type)
            'End With
            ClientScript.RegisterStartupScript(Me.GetType(), "SetImagePath", "parent.SetImagePath('" & strFolder & "','" & fullurlpath & "');", True)
        End If
    End Sub
End Class
