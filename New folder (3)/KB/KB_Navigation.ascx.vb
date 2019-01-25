
Partial Class KB_KB_Navigation
    Inherits System.Web.UI.UserControl
    Dim ObjTopic As New Topic
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False AndAlso IsNumeric(Request.QueryString("TopicID")) = True Then
            ObjTopic.LoadTopicDetail(Request.QueryString("TopicID"))
            lnkCategory.NavigateUrl = "List_Topics.aspx?CategoryID=" & ObjTopic.CategoryID
            lnkCategory.Text = Server.HtmlEncode(ObjTopic.CategoryName)
            lblTopic.Text = Server.HtmlEncode(ObjTopic.Name)
        End If
    End Sub
End Class
