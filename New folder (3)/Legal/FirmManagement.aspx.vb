
Partial Class admin_Legal_FirmManagement
    Inherits System.Web.UI.Page

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim firmObj As Firm = New Firm()
        If e.CommandName = "Delete" Then
            firmObj.DeleteFirm(CInt(e.CommandArgument))
            GridView1.DataSourceID = AllFirmsDS.ID
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "event.cancelBubble=true;parent.frameMain.location='VendorProfile.aspx?FirmID=" & e.Row.DataItem("ID") & "';")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
    End Sub

    Protected Sub reset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles reset.Click
        GridView1.DataSourceID = AllFirmsDS.ID
        GridView1.DataBind()
    End Sub
End Class
