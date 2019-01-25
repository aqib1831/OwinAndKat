Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Imports Telerik
Imports Telerik.WebControls
Partial Class Admin_NS_ProductsServices
    Inherits System.Web.UI.Page
    Protected Sub UpdateButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles UpdateButton.Click
        Me.gvNSProducts.DataSourceID = Me.odsNSProducts.ID
        Me.gvNSProducts.DataBind()
    End Sub
    Protected Sub odsNSProducts_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsNSProducts.Selected
        'If String.IsNullOrEmpty(txtSearch.Text) = False _
        '                Or ddlType.SelectedValue <> "0" Then

        '    lblFilter.Text = "Filtered"
        'Else
        '    lblFilter.Text = "All"
        'End If
        'Dim Count As Integer = 0
        'If Not e.ReturnValue Is Nothing Then
        '    Dim col As List(Of Portal.BLL.NSProducts) = CType(e.ReturnValue, List(Of Portal.BLL.NSProducts))
        '    lblProductCount.Text = col.Count.ToString()
        'End If
    End Sub
    Protected Sub gvNSProducts_ColumnCreated(ByVal sender As Object, ByVal e As Telerik.WebControls.GridColumnCreatedEventArgs) Handles gvNSProducts.ColumnCreated
    End Sub
    Protected Sub gvNSProducts_ItemCommand(ByVal source As Object, ByVal e As Telerik.WebControls.GridCommandEventArgs) Handles gvNSProducts.ItemCommand
        If e.CommandName = "Add" Then
            Me.hdnProductID.Value = e.CommandArgument.ToString
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "AddModule", "OpenAddProductModuleDiv();", True)
        ElseIf e.CommandName = "EditModule" Then
            If (e.Item.OwnerTableView.Name = "Module") Then
                Dim lblID As Label = CType(e.Item.FindControl("lblID"), Label)
                Dim lblParentID As Label = CType(e.Item.FindControl("lblParentID"), Label)
                '  Dim ModuleID As Integer = Int(lblID.Text)
                ' Dim ProductID As Integer = Int(lblParentID.Text)
                Me.hdnModuleID.Value = lblID.Text
                Me.hdnProductID.Value = lblParentID.Text
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "EditModule", "OpenEditProductModuleDiv();", True)
            End If
        ElseIf e.CommandName = "EditProduct" Then
            If (e.Item.OwnerTableView.Name = "Product") Then
                Dim lblID As Label = CType(e.Item.FindControl("lblID"), Label)
                Dim ModuleID As Integer = Int(lblID.Text)
                Me.hdnProductID.Value = lblID.Text
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "EditProduct", "OpenEditProductDiv();", True)
            End If
        End If
    End Sub
    Protected Sub gvNSProducts_ItemCreated(ByVal sender As Object, ByVal e As Telerik.WebControls.GridItemEventArgs) Handles gvNSProducts.ItemCreated
        If e.Item.ItemType = Telerik.WebControls.GridItemType.AlternatingItem Or e.Item.ItemType = Telerik.WebControls.GridItemType.Item Then
            e.Item.Attributes.Add("onmouseover", "this.className='HighlightedHomeRowRad';")
            e.Item.Attributes.Add("onmouseout", "this.className='SimpleHomeRowRad';")
            e.Item.Attributes.Add("style", "border-bottom:solid 1px #C9EAFC;")
        End If
    End Sub
    Protected Sub gvNSProducts_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvNSProducts.PreRender
        gvNSProducts.MasterTableView.HierarchyDefaultExpanded = True
        gvNSProducts.Rebind()
        gvNSProducts.MasterTableView.GetColumn("ExpandColumn").Display = False
    End Sub
End Class
