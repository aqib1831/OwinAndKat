Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Partial Class UM_NewTopic
    Inherits System.Web.UI.Page
    Dim isWriteAccess As Boolean = False
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub btnSaveTopic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveTopic.Click
        Topic()
    End Sub

    Protected Sub ddlAddCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAddCategories.DataBound
        ddlAddCategories.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False Then
                hdnTopicID.Value = Request.QueryString("TopicID")
                lblPageHeader.Text = "Edit"
                isWriteAccess = Functions.CheckSubModuleAccess(Portal.BLL.Enumeration.SubModules.UMFullAccess)
                If Not isWriteAccess Then
                    btnSaveTopic.Visible = False
                End If
            End If
        End If
    End Sub
    Public Sub GetTopic()
        Dim drTopic As SqlDataReader = Nothing
        drTopic = Portal.BLL.UM.Topic.TopicGetByID(Request.QueryString("TopicID"))
        If drTopic.HasRows() Then
            drTopic.Read()
            Me.txtTitle.Text = drTopic("Title")
            If String.IsNullOrEmpty(Request.QueryString("Search")) = False Then
                HighyLightText(drTopic("Description"), Request.QueryString("Search"))
            Else
                Me.txtDescription.Content = drTopic("Description")
            End If
            Me.ddlAddCategories.SelectedValue = drTopic("CategoryID")
            Me.ddlAddType.SelectedValue = drTopic("Type")
        End If
        drTopic.Close()
    End Sub

    Public Sub SaveTopic()
        Dim objTopic As New Portal.BLL.UM.Topic
        Dim returnVal As Integer = 0
        If (hdnTopicID.Value.Equals("0")) Then
            objTopic.Title = txtTitle.Text.Trim().ToString()
            objTopic.Description = Me.txtDescription.Content
            objTopic.CategoryID = Me.ddlAddCategories.SelectedValue
            objTopic.Type = Me.ddlAddType.SelectedValue
            If Request.QueryString("UMType") = 1 Then 'Manuals
                objTopic.ManualType = 1 'Manual
            ElseIf Request.QueryString("UMType") = 4 Then 'KB
                objTopic.ManualType = 2 'KB
            End If
            objTopic.AddedBy = Session("AdminID")
            returnVal = objTopic.Add()
            If (returnVal > 0) Then
                Response.Redirect("TopicList.aspx?SelectedCategory=" & Request.QueryString("SelectedCategory") & "&SelectedType=" & Request.QueryString("SelectedType") & "&UMType=" & Request.QueryString("UMType"))
            Else
                If (returnVal = -1) Then
                    cvTopic.IsValid = False
                End If
            End If
        End If
    End Sub
    Public Sub UpdateTopic()
        Dim objTopic As New Portal.BLL.UM.Topic
        Dim returnVal As Integer = 0
        If (CInt(hdnTopicID.Value) > 0) Then
            objTopic.ID = hdnTopicID.Value.Trim().ToString()
            objTopic.Title = txtTitle.Text.Trim().ToString()
            objTopic.Description = Me.txtDescription.Content
            objTopic.CategoryID = Me.ddlAddCategories.SelectedValue
            objTopic.Type = Me.ddlAddType.SelectedValue
            If Request.QueryString("UMType") = 1 Then 'Manuals
                objTopic.ManualType = 1 ' Manual
            ElseIf Request.QueryString("UMType") = 4 Then 'KB
                objTopic.ManualType = 2 ' KB
            End If
            objTopic.LastUpdatedBy = Session("AdminID")
            returnVal = objTopic.Update()
            If (returnVal > 0) Then
                If String.IsNullOrEmpty(Request.QueryString("NavigateTo")) = False Then
                    If Request.QueryString("NavigateTo") = "RecentUpdates" Then
                        Response.Redirect("RecentUpdates.aspx")
                    End If
                Else
                    Response.Redirect("TopicList.aspx?SelectedCategory=" & Request.QueryString("SelectedCategory") & "&SelectedType=" & Request.QueryString("SelectedType") & "&UMType=" & Request.QueryString("UMType"))
                End If
            Else
                If (returnVal = -1) Then
                    cvTopic.IsValid = False
                End If
            End If
        End If
    End Sub

    Public Sub Topic()
        If (hdnTopicID.Value.Equals("0")) Then
            SaveTopic()
        Else
            UpdateTopic()
        End If
    End Sub

    Protected Sub sdsAddCategories_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsAddCategories.Selected
        GetTopic()
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