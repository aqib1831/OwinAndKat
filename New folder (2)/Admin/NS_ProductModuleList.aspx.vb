Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Partial Class Admin_NS_ProductModuleList
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            If String.IsNullOrEmpty(Request.QueryString("ProductID")) = False Then
                'Me.lblProductTitle.Text = Portal.BLL.NSProducts.GetProductName(CInt(Request.QueryString("ProductID")))
                Me.hdnProductID.Value = Request.QueryString("ProductID").ToString()
            End If
        End If
    End Sub
    Protected Sub odsNSProductModules_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsNSProductModules.Selected
        If String.IsNullOrEmpty(txtSearch.Text) = False Then
            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If
        Dim col As List(Of Portal.BLL.NSProducts) = CType(e.ReturnValue, List(Of Portal.BLL.NSProducts))
        lblProductCount.Text = col.Count.ToString()
    End Sub

End Class
