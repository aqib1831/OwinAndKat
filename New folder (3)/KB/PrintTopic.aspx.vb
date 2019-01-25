
Partial Class KB_PrintTopic
    Inherits System.Web.UI.Page
    Dim ObjTopic As New Topic
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (IsPostBack = False) Then
            If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False AndAlso IsNumeric(Request.QueryString("TopicID")) = True Then
                Dim topicId As Integer
                topicId = Request.QueryString("TopicID")
                ObjTopic.LoadTopicDetail(topicId)

                If String.IsNullOrEmpty(Request.QueryString("Searchtxt")) = False Then
                    HighyLightText(ObjTopic.Description, Request.QueryString("Searchtxt"))
                Else
                    LtrlTopicDetail.Text = ObjTopic.Description
                End If                
                Page.Title = ObjTopic.Name
            End If
        End If
    End Sub
    Private Sub HighyLightText(ByVal Descriptiontxt As String, ByVal Searchtxt As String)
        Dim Pattren As String() = Searchtxt.TrimStart().TrimEnd.Split(" ")
        Dim i As Integer = 0
        For i = 0 To Pattren.Length - 1
            If Pattren(i).Length > 2 Then
                Descriptiontxt = Regex.Replace(Descriptiontxt, Pattren(i), "<span style=""background-color:#FFFF66;font-weight:bold;"">" & Pattren(i) & "</span>", RegexOptions.IgnoreCase)
            End If
        Next
        LtrlTopicDetail.Text = Descriptiontxt
    End Sub
End Class
