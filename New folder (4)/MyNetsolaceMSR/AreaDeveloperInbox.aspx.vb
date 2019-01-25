
Partial Class MyNetsolace_AreaDeveloperInbox
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnAreaDeveloperID.Value = Session("MyNetsolace_AreaDeveloperID")
        hdnClientId.Value = Request.QueryString("ClientID")
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeSelected", "parent.SetTrBackGround(1);", True)
    End Sub

    Protected Sub ddlFranchises_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFranchises.DataBound
        ddlFranchises.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub odsInbox_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsInbox.Selected
        If (IsNumeric(e.ReturnValue)) Then
            lblActivityCount.Text = e.ReturnValue
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ParentInboxCount", "parent.SetInBox('" & lblActivityCount.Text & "')", True)
        End If
    End Sub
    Protected Sub gvwInbox_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwInbox.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow'")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow'")
            e.Row.Attributes.Add("onclick", "ShowDetail(" & DataBinder.Eval(e.Row.DataItem, "ActivityID") & "," & DataBinder.Eval(e.Row.DataItem, "FranchiseID") & "," & DataBinder.Eval(e.Row.DataItem, "ClientID") & ");")
        End If
    End Sub
End Class
