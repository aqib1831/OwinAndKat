
Partial Class URLM_Category
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub gvClient_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvClient.RowCommand
        If e.CommandName = "MyDelete" Then
            Portal.BLL.Client.Clients.Client_Delete(CInt(e.CommandArgument), True)
            gvClient.DataBind()
        End If
    End Sub
    Protected Sub gvClient_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvClient.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'e.Row.Attributes.Add("onclick", "javascript:parent.window.location='Client_Main.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
            'e.Row.Attributes.Add("onclick", "javascript:window.location='ClientView.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
            e.Row.Cells(0).Attributes.Add("onclick", "javascript:window.location='ClientView.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
            e.Row.Cells(1).Attributes.Add("onclick", "javascript:window.location='ClientView.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
            e.Row.Cells(2).Attributes.Add("onclick", "javascript:window.location='ClientView.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
            e.Row.Cells(3).Attributes.Add("onclick", "javascript:window.location='ClientView.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
            e.Row.Cells(4).Attributes.Add("onclick", "javascript:window.location='ClientView.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
            e.Row.Cells(5).Attributes.Add("onclick", "javascript:window.location='ClientView.aspx?ClientID=" & CInt(CType(e.Row.FindControl("lblID"), Label).Text) & "';return false;")
        End If
    End Sub
    Protected Sub gvClient_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvClient.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
    End Sub

   
End Class
