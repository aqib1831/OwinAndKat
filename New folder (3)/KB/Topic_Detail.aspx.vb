
Partial Class KB_Topic_Detail
    Inherits System.Web.UI.Page
    Dim ObjTopic As New Topic
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (IsPostBack = False) Then
            If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False AndAlso IsNumeric(Request.QueryString("TopicID")) = True Then
                hdnTopicID.Value = Request.QueryString("TopicID")
                objTopic.LoadTopicDetail(hdnTopicID.Value)
                lblHeading.Text = Server.HtmlEncode(Functions.StringTruncate(ObjTopic.Name, 50))
                Page.Title = ObjTopic.Name
                ifrmTopicDetail.Attributes.Add("src", "PrintTopic.aspx?" & Request.QueryString.ToString())
            End If
        End If
    End Sub
End Class
