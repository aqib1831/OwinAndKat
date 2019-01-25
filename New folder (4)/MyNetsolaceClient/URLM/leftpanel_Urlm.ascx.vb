Partial Class contacts_leftpanel_PM
    Inherits System.Web.UI.UserControl

    Protected intStoreCount As Integer = 0
    Protected SelectedValue As Integer = 0

#Region " Private Members "

    Private _Selected As Integer = 0

#End Region

#Region " Public Properties "

    Public Property Seleted() As Integer
        Get
            Return _Selected
        End Get
        Set(ByVal value As Integer)
            _Selected = value
        End Set
    End Property
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '_Selected = 3
        'If _Selected = 1 Then
        '    tr_One.Attributes.Add("class", "Calendar_Selected")
        'End If
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub rptStores_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptStores.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            intStoreCount = 0
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            intStoreCount += 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If intStoreCount > 0 Then
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = False
            Else
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = True
            End If
        End If
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        If txtSearch.Text <> String.Empty Then
            If Session("UserBrowser") = "AppleMAC-Safari" Then
                divStores.Attributes.Add("Style", "display:block;")
            Else
                divStores.Attributes.Add("Style", "display:inline;height:100%;width:100%;")
            End If
            tr_One.Attributes.Add("Style", "display:none;")
            'tr_Two.Attributes.Add("Style", "display:none;")
            'tr_Three.Attributes.Add("Style", "display:none;")
            'tr_Four.Attributes.Add("Style", "display:none;")
        Else
            tr_One.Attributes.Add("Style", "display:'';") ' display:inline  have problems in Safari here, so this statement Equals To display:inline
            'tr_Two.Attributes.Add("Style", "display:'';")
            'tr_Three.Attributes.Add("Style", "display:'';")
            'tr_Four.Attributes.Add("Style", "display:'';")
            divStores.Attributes.Add("Style", "display:none;")
        End If
    End Sub
End Class