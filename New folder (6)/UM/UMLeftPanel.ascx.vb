
Partial Class UM_UMLeftPanel
    Inherits System.Web.UI.UserControl

    Protected Sub imgBtnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnSearch.Click
        If txtSearch.Text.Trim <> String.Empty Or txtSearch.Text.Trim <> "" Then
            divSearch.Attributes.Add("Style", "display:inline;")
        Else
            divSearch.Attributes.Add("Style", "display:none;")
        End If
    End Sub

    Protected Sub rptUserManual_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptUserManual.ItemDataBound
        If (rptUserManual.Items.Count = 0) Then
            If (e.Item.ItemType = ListItemType.Footer) Then
                e.Item.FindControl("ltrlNoRecord").Visible = True
            End If
        End If
    End Sub
End Class
