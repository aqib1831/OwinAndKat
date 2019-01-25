
Partial Class admin_Legal_Legal_search
    Inherits System.Web.UI.Page

    Protected Sub Search_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles Repeater1.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If Repeater1.Items.Count = 0 Then
                e.Item.FindControl("trNoRec").Visible = True
            End If
        End If
    End Sub
End Class
