Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class UMv3_TopicDetail
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False Then
                Response.Flush()
                Response.Expires = -1
                Response.Write(GetTopic(Request.QueryString("TopicID")))
                Response.End()
            End If
        End If
    End Sub
    Public Function GetTopic(ByVal topicId As Int32) As String
        Dim TopicDetail As String = String.Empty
        Dim drTopic As SqlDataReader = Nothing
        drTopic = Portal.BLL.UM.Topic.TopicGetByID(topicId)
        If drTopic.HasRows() Then
            drTopic.Read()
            TopicDetail = Functions.IfNull(drTopic("Description"), "")
        End If
        drTopic.Close()
        Return TopicDetail
    End Function
    
End Class
