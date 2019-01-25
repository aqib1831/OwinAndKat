Partial Class KB_Add_Topic
    Inherits System.Web.UI.Page
#Region "Page Envents"
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If (IsPostBack = False) Then
            If String.IsNullOrEmpty(Request.QueryString("CategoryID")) = False AndAlso IsNumeric(Request.QueryString("CategoryID")) = True Then
                ddlCategories.SelectedValue = Request.QueryString("CategoryID")
            End If
            If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False AndAlso IsNumeric(Request.QueryString("TopicID")) = True Then
                PopulateControl(CInt(Request.QueryString("TopicID")))
            End If
        End If

        'editorDescription.ImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
        'editorDescription.UploadImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
        'editorDescription.DeleteImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
    End Sub
#End Region

#Region "Event handler"
    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        Dim objTopic As New Topic
        If Page.IsValid Then
            With objTopic
                .Name = txtName.Text.Trim()
                .CreatedDate = DateTime.Now
                .CategoryID = CInt(ddlCategories.SelectedValue)
                .Keywords = txtKeyword.Text
                .Description = editorDescription.Content
                .Sequence = 1
                .PlainDescription = RemoveHTML(editorDescription.Text)
                .AddedBy = CInt(Session("AdminID"))
            End With
            If String.IsNullOrEmpty(Request.QueryString("TopicID")) = False AndAlso IsNumeric(Request.QueryString("TopicID")) = True Then
                objTopic.ID = Request.QueryString("TopicID")
                objTopic.UpdatedDate = DateTime.Now
                If objTopic.Update() = -1 Then
                    lblMsg.Text = "Topic with same title already exists"
                    Exit Sub
                End If
            Else
                If objTopic.Add() = -1 Then
                    lblMsg.Text = "Topic with same title already exists"
                    Exit Sub
                End If
            End If
        Else
            val_Editor.Text = "Enter description"
            Exit Sub
        End If
        Response.Redirect("List_Topics.aspx?CategoryID=" & ddlCategories.SelectedValue)
    End Sub

    Protected Sub BtnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnCancel.Click
        If String.IsNullOrEmpty(Request.QueryString("CategoryID")) = False AndAlso IsNumeric(Request.QueryString("CategoryID")) = True Then
            Response.Redirect("List_Topics.aspx?" & Request.QueryString("CategoryID"))
        Else
            Response.Redirect("List_Topics.aspx")
        End If
    End Sub
    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
#End Region

#Region "Private Methods"
    Private Sub PopulateControl(ByVal TopicID As Integer)
        Dim ObjTopic As New Topic
        lblHeading.Text = "Edit Topic"
        ObjTopic.LoadTopicDetail(TopicID)
        txtName.Text = ObjTopic.Name
        txtKeyword.Text = ObjTopic.Keywords
        ddlCategories.SelectedValue = ObjTopic.CategoryID

        editorDescription.Content = ObjTopic.Description
        hdnCategoryID.Value = ObjTopic.CategoryID
        ddlCategories.SelectedValue = ObjTopic.CategoryID
    End Sub
    Function RemoveHTML(ByVal strText)
        Dim strOutput As String
        strOutput = Regex.Replace(strText, "<[^>]*>", "")
        strOutput = Regex.Replace(strOutput, "\s+", " ")
        strOutput = Regex.Replace(strOutput, "&nbsp;", " ")
        RemoveHTML = Server.HtmlEncode(strOutput)
    End Function
#End Region
End Class