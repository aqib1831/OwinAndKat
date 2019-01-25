Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class UM_NewLink
    Inherits System.Web.UI.Page
    Dim isWriteAccess As Boolean = False
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub btnSaveLink_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveLink.Click
        Link()
    End Sub
    Public Sub Link()
        If (hdnLinkID.Value.Equals("0")) Then
            SaveLink()
        Else
            UpdateLink()
        End If
    End Sub

    Protected Sub ddlAddCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAddCategories.DataBound
        ddlAddCategories.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub
    Public Sub SaveLink()
        Dim objLink As New Portal.BLL.UM.Link
        Dim returnVal As Integer = 0
        If (hdnLinkID.Value.Equals("0")) Then
            objLink.Title = txtTitle.Text.Trim().ToString()
            objLink.Description = Me.txtDescription.Html
            objLink.CategoryID = Me.ddlAddCategories.SelectedValue
            objLink.Link = Me.txtLink.Text
            objLink.AddedBy = Session("AdminID")
            returnVal = objLink.Add()
            If (returnVal > 0) Then
                Response.Redirect("LinksList.aspx?SelectedCategory=" & Request.QueryString("SelectedCategory") & "&SelectedType=" & Request.QueryString("SelectedType"))
            Else
                If (returnVal = -1) Then
                    cvTopic.IsValid = False
                End If
            End If
        End If
    End Sub
    Public Sub UpdateLink()
        Dim objLink As New Portal.BLL.UM.Link
        Dim returnVal As Integer = 0
        If (CInt(hdnLinkID.Value) > 0) Then
            objLink.ID = hdnLinkID.Value.Trim().ToString()
            objLink.Title = txtTitle.Text.Trim().ToString()
            objLink.Description = Me.txtDescription.Html
            objLink.CategoryID = Me.ddlAddCategories.SelectedValue
            objLink.Link = Me.txtLink.Text
            objLink.LastUpdatedBy = Session("AdminID")
            returnVal = objLink.Update()
            If (returnVal > 0) Then
                Response.Redirect("LinksList.aspx?SelectedCategory=" & Request.QueryString("SelectedCategory") & "&SelectedType=" & Request.QueryString("SelectedType"))
            Else
                If (returnVal = -1) Then
                    cvTopic.IsValid = False
                End If
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            If String.IsNullOrEmpty(Request.QueryString("LinkID")) = False Then
                If IsPostBack = False Then
                End If
                hdnLinkID.Value = Request.QueryString("LinkID")
                lblPageHeader.Text = "Edit"
                isWriteAccess = Functions.CheckSubModuleAccess(Portal.BLL.Enumeration.SubModules.UMFullAccess)
                If Not isWriteAccess Then
                    btnSaveLink.Visible = False
                End If
            Else
                Me.txtLink.Text = "http://"
            End If
        End If
    End Sub
    Public Sub GetLink()
        Dim drLink As SqlDataReader = Nothing
        drLink = Portal.BLL.UM.Link.LinkGetByID(Request.QueryString("LinkID"))
        If drLink.HasRows() Then
            drLink.Read()
            Me.txtTitle.Text = drLink("Title")
            If String.IsNullOrEmpty(Request.QueryString("Search")) = False Then
                HighyLightText(drLink("Description"), Request.QueryString("Search"))
            Else
                Me.txtDescription.Html = drLink("Description")
            End If
            Me.ddlAddCategories.SelectedValue = drLink("CategoryID")
            Me.txtLink.Text = drLink("Link")
        End If
        drLink.Close()
    End Sub

    Protected Sub sdsAddCategories_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsAddCategories.Selected
        GetLink()
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
        Me.txtDescription.Html = Descriptiontxt
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
