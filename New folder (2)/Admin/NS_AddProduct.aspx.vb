Imports System.Data.SqlClient
Imports System.Data
Partial Class Admin_NS_AddProduct
    Inherits System.Web.UI.Page
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If String.IsNullOrEmpty(Request.QueryString("ProductID")) = False Then
            UpdateProduct()
        Else
            Dim objNS_Product As New Portal.BLL.NSProducts
            objNS_Product.Title = Me.txtTitle.Text.Trim
            objNS_Product.Abbreviation = Me.txtAbbreviation.Text.Trim
            objNS_Product.Type = Me.ddlType.SelectedValue.Trim
            objNS_Product.Price = Me.txtPrice.Text.Trim
            objNS_Product.PriceOption = Me.ddlPriceOption.SelectedValue.Trim
            objNS_Product.ParentID = Me.ddlProduct.SelectedValue
            Dim result As Integer = Portal.BLL.NSProducts.Add(objNS_Product)
            If result > 0 Then
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "javascript:parent.window.CloseAddProductDiv();", True)
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Update", "javascript:parent.window.UpdateButton();", True)
            ElseIf result = 0 Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Show", "parent.window.OpenAddProductDiv();", True)
                Me.lblMessage.Visible = True
            End If
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            If String.IsNullOrEmpty(Request.QueryString("ProductID")) = False Then
                Me.hdnProductID.Value = Request.QueryString("ProductID").ToString()
                Me.btnCancel.Attributes.Add("onclick", "javascript:parent.window.CloseEditProductDiv();return false;")
                Me.lblHeader.Text = "Edit Product"
                Me.ddlProduct.Enabled = False
                GetProduct()
            Else
                Me.btnCancel.Attributes.Add("onclick", "javascript:parent.window.CloseAddProductDiv();return false;")
                Me.lblHeader.Text = "Add Product"
            End If
        End If
    End Sub
    Private Sub GetProduct()
        Dim dr_Product As SqlDataReader = Nothing
        dr_Product = Portal.BLL.NSProducts.GetModuleByID(CInt(Me.hdnProductID.Value))
        While dr_Product.Read()
            Me.txtTitle.Text = CType(Functions.IfNull(dr_Product("Title").ToString(), ""), String)
            Me.txtAbbreviation.Text = CType(Functions.IfNull(dr_Product("Abbreviation").ToString(), ""), String)
            Me.txtPrice.Text = CType(FormatNumber(Functions.IfNull(dr_Product("Price"), 0.0), 2), Decimal)
            Me.ddlType.SelectedValue = CType(Functions.IfNull(dr_Product("Type"), 0), Integer)
            Me.ddlPriceOption.SelectedValue = CType(Functions.IfNull(dr_Product("PriceOption"), 0), Integer)
        End While
        dr_Product.Close()
    End Sub
    Public Sub UpdateProduct()
        Dim objNS_Product As New Portal.BLL.NSProducts
        objNS_Product.Title = Me.txtTitle.Text.Trim
        objNS_Product.Abbreviation = Me.txtAbbreviation.Text.Trim
        objNS_Product.Type = Me.ddlType.SelectedValue.Trim
        objNS_Product.Price = Me.txtPrice.Text.Trim
        objNS_Product.PriceOption = Me.ddlPriceOption.SelectedValue.Trim
        objNS_Product.ID = CInt(Me.hdnProductID.Value)
        Dim returnValue As Integer = Portal.BLL.NSProducts.UpdateProduct(objNS_Product)
        If returnValue > 0 Then
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "javascript:parent.window.CloseEditProductDiv();", True)
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Update", "javascript:parent.window.UpdateButton();", True)
        ElseIf returnValue = 0 Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Show", "parent.window.OpenEditProductDiv();", True)
            Me.lblMessage.Visible = True
        End If
    End Sub
    Protected Sub ddlProduct_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProduct.DataBound
        Me.ddlProduct.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
End Class
