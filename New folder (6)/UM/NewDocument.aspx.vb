Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class UM_NewDocument
    Inherits System.Web.UI.Page
    Dim isWriteAccess As Boolean = False
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub btnSaveDocument_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveDocument.Click
        Document()
    End Sub
    Public Sub Document()
        If (hdnDocumentID.Value.Equals("0")) Then
            SaveDocument()
        Else
            UpdateDocument()
        End If
    End Sub

    Protected Sub ddlAddCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAddCategories.DataBound
        ddlAddCategories.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub
    Public Sub SaveDocument()
        Dim objDocument As New Portal.BLL.UM.Document
        Dim returnVal As Integer = 0
        Dim DirectoryName As String = ""
        DirectoryName = Functions.GetDateTimeUniqueString()
        If (hdnDocumentID.Value.Equals("0")) Then
            objDocument.Title = txtTitle.Text.Trim().ToString()
            objDocument.Description = Me.txtDescription.Content
            objDocument.CategoryID = Me.ddlAddCategories.SelectedValue
            objDocument.DirectoryName = DirectoryName
            If Me.fileUploadDocument.HasFile Then
                objDocument.FileName = DirectoryName + "/" + fileUploadDocument.FileName
                objDocument.FileUpload = Me.fileUploadDocument
            End If
            objDocument.AddedBy = Session("AdminID")

            returnVal = objDocument.Add()
            If (returnVal > 0) Then
                Response.Redirect("DocumentList.aspx?SelectedCategory=" & Request.QueryString("SelectedCategory") & "&UMType=" & Request.QueryString("UMType"))
            Else
                If (returnVal = -1) Then
                    cvTopic.IsValid = False
                End If
            End If
        End If
    End Sub
    Public Sub UpdateDocument()
        Dim objDocument As New Portal.BLL.UM.Document
        Dim returnVal As Integer = 0
        Dim DirectoryName As String = ""
        DirectoryName = Functions.GetDateTimeUniqueString()
        If (CInt(hdnDocumentID.Value) > 0) Then
            objDocument.ID = hdnDocumentID.Value.Trim().ToString()
            objDocument.Title = txtTitle.Text.Trim().ToString()
            objDocument.Description = Me.txtDescription.Content
            objDocument.CategoryID = Me.ddlAddCategories.SelectedValue
            objDocument.LastUpdatedBy = Session("AdminID")
            returnVal = objDocument.Update()
            If (returnVal > 0) Then
                Response.Redirect("DocumentList.aspx?SelectedCategory=" & Request.QueryString("SelectedCategory") & "&UMType=" & Request.QueryString("UMType"))
            Else
                If (returnVal = -1) Then
                    cvTopic.IsValid = False
                End If
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("DocumentID")) = False Then
            If IsPostBack = False Then
            End If
            hdnDocumentID.Value = Request.QueryString("DocumentID")
            lblPageHeader.Text = "Edit"
            isWriteAccess = Functions.CheckSubModuleAccess(Portal.BLL.Enumeration.SubModules.UMFullAccess)
            If Not isWriteAccess Then
                btnSaveDocument.Visible = False
            End If
        End If
        'txtDescription.ImageManager.ViewPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
        'txtDescription.ImageManager.UploadPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
        'txtDescription.ImageManager.DeletePaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}

    End Sub
    Public Sub GetDocument()
        Dim drDocument As SqlDataReader = Nothing
        drDocument = Portal.BLL.UM.Document.DocumentGetByID(Request.QueryString("DocumentID"))
        If drDocument.HasRows() Then
            drDocument.Read()
            Me.txtTitle.Text = drDocument("Title")
            If String.IsNullOrEmpty(Request.QueryString("Search")) = False Then
                HighyLightText(drDocument("Description"), Request.QueryString("Search"))
            Else
                Me.txtDescription.Content = drDocument("Description")
            End If
            Me.ddlAddCategories.SelectedValue = drDocument("CategoryID")
            Me.uploadedfile.HRef = ConfigurationManager.AppSettings("PMAttachmentPath") + drDocument("FileName")
            Me.uploadedfile.Target = "blank"
            Me.uploadedfile.InnerHtml = drDocument("FileName")
            TRuploadfile.Visible = False
            TRUploadedfile.Attributes.Add("style", "display:inline;")
        End If
        drDocument.Close()
    End Sub

    Private Sub HighyLightText(ByVal Descriptiontxt As String, ByVal Searchtxt As String)
        Dim Pattren As String() = Searchtxt.TrimStart().TrimEnd.Split(" ")
        Dim i As Integer = 0
        For i = 0 To Pattren.Length - 1
            If Pattren(i).Length > 2 Then
                If CheckNoiseWords(Pattren(i)) = False Then
                    Descriptiontxt = Regex.Replace(Descriptiontxt, Pattren(i), "<span style=""background-color:Yellow;font-weight:bold;"">" & Pattren(i) & "</span>", RegexOptions.IgnoreCase)
                End If
            End If
        Next
        Me.txtDescription.Content = Descriptiontxt
    End Sub
    Protected Sub sdsAddCategories_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsAddCategories.Selected
        GetDocument()
    End Sub
    Private Function CheckNoiseWords(ByVal Searchtxt As String) As Boolean
        Dim noisyWord() As String = {"$", "a", "about", "after", "all", "also", "an", "and", "another", "any", "are", "as", "at", "b", "be", "because", "been", "before", "being", "between", "both", "but", "by", "c", "came", "can", "come", "could", "d", "did", "do", "does", "e", "each", "else", "f", "for", "from", "g", "get", "got", "h", "had", "has", "have", "he", "her", "here", "him", "himself", "his", "how", "i", "if", "in", "into", "is", "it", "its", "j", "just", "k", "l", "like", "m", "make", "many", "me", "might", "more", "most", "much", "must", "my", "n", "never", "now", "o", "of", "on", "only", "or", "other", "our", "out", "over", "p", "q", "r", "re", "s", "said", "same", "see", "should", "since", "so", "some", "still", "such", "t", "take", "Test", "than", "that", "the", "their", "them", "then", "there", "these", "they", "this", "those", "through", "to", "too", "u", "under", "up", "use", "v", "very", "w", "want", "was", "way", "we", "well", "were", "what", "when", "where", "which", "while", "who", "will", "with", "would", "x", "y", "you", "your", "z"}
        Dim i As Integer = 0
        For i = 0 To noisyWord.Length - 1
            If (Searchtxt.ToLower() = noisyWord(i)) Then
                Return True
            End If
        Next
        Return False
    End Function
End Class