Imports System.Data
Imports System.Data.SqlClient
Partial Class com_Topic_List
    Inherits System.Web.UI.Page
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objTopic As New ActivityTopic
        Dim result As Integer = 0
        objTopic.Topic = Me.txtTopic.Text
        result = objTopic.Add()
        If result = 0 Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "show", "ShowTopicDiv();", True)
            Me.lblMessageAdd.Visible = True
        Else
            Me.gvTopic.DataSourceID = Me.odsTopic.ID
            Me.gvTopic.DataBind()
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "close", "CloseTopicDiv();", True)
        End If
    End Sub
    Protected Sub gvTopic_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvTopic.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
    End Sub
    Protected Sub gvTopic_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs)
        If e.CommandName = "Edit" Then
            Dim ID As Integer = 0
            ID = CType(e.CommandArgument, Integer)
            hdID.Value = ID.ToString()
            Dim dr_Topics As SqlDataReader = ActivityTopic.GetTopicByID(ID)
            If dr_Topics.HasRows Then
                dr_Topics.Read()
                Me.txtTopicUpdate.Text = dr_Topics("Topic").ToString()
                dr_Topics.Close()
            End If
            Me.lblMessage.Visible = False
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "show", "ShowTopicDivEdit();", True)
        End If
    End Sub
    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim objTopic As New ActivityTopic
        Dim result As Integer = 0
        objTopic.ID = CType(hdID.Value, Integer)
        objTopic.Topic = Me.txtTopicUpdate.Text
        result = objTopic.Update()
        If result = 0 Then
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "show1", "ShowTopicDiv1();", True)
            Me.lblMessage.Visible = True
        Else
            Me.gvTopic.DataSourceID = Me.odsTopic.ID
            Me.gvTopic.DataBind()
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "close1", "CloseTopicDiv1();", True)
            Me.UPMain.Update()
        End If
    End Sub
End Class
