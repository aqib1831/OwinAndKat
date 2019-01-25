
Partial Class KB_left_Panel
    Inherits System.Web.UI.UserControl
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    'Protected Sub RepCategorylst_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles RepCategorylst.ItemCommand
    '    If (e.CommandName.ToLower() = "delete") Then
    '        Dim ImgButton As New ImageButton()
    '        ImgButton = CType(e.Item.FindControl("btndelete"), ImageButton)
    '        Category.Delete(CInt(ImgButton.Attributes("CategoryID")))
    '        Response.Redirect("Default.aspx")
    '    End If
    'End Sub

    'Protected Sub RepCategorylst_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RepCategorylst.ItemDataBound
    '    If (e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem) Then
    '        Dim ImgButton As ImageButton
    '        ImgButton = New ImageButton()
    '        ImgButton = CType(e.Item.FindControl("btndelete"), ImageButton)
    '        ImgButton.Attributes.Add("CategoryID", CInt(e.Item.DataItem("ID")))
    '    End If
    'End Sub
End Class
