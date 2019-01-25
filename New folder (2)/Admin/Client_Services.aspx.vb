
Partial Class Admin_ClientServices_Add
    Inherits System.Web.UI.Page
    Public RecordCount As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub
    Protected Sub rptProductTypes_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptProductTypes.ItemCreated
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim lblProductID As Label = CType(e.Item.FindControl("lblProductID"), Label)
            Dim rptProducts As Repeater = CType(e.Item.FindControl("rptProducts"), Repeater)
            AddHandler rptProducts.ItemCreated, AddressOf rptProducts_ItemCreated
            AddHandler rptProducts.ItemDataBound, AddressOf rptProducts_ItemDataBound
        End If
    End Sub
    Protected Sub rptProducts_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim lblProductID As Label = CType(e.Item.FindControl("lblProductID"), Label)
            Dim rptModules As Repeater = CType(e.Item.FindControl("rptModules"), Repeater)
        End If
    End Sub
    Protected Sub rptProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            RecordCount = RecordCount + 1
        End If
    End Sub

    Protected Sub rptProductTypes_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptProductTypes.PreRender
        If RecordCount = 0 Then
            rptProductTypes.Visible = False
            ltlNoRecordsFound.Visible = True
        End If
    End Sub
End Class
