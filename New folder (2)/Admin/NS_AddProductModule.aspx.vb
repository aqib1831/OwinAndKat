Imports System.Data.SqlClient
Imports System.Data
Partial Class Admin_NS_AddProductModule
    Inherits System.Web.UI.Page
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If String.IsNullOrEmpty(Request.QueryString("ModuleID")) = False Then
            UpdateModule()
        Else
            Dim objNS_Product As New Portal.BLL.NSProducts
            objNS_Product.Title = Me.txtTitle.Text.Trim
            objNS_Product.Abbreviation = Me.txtAbbreviation.Text.Trim
            objNS_Product.Type = Me.ddlType.SelectedValue.Trim
            objNS_Product.Price = Me.txtPrice.Text.Trim
            objNS_Product.PriceOption = Me.ddlPriceOption.SelectedValue.Trim
            objNS_Product.ParentID = CInt(Me.hdnProductID.Value)
            Dim result As Integer = Portal.BLL.NSProducts.AddModule(objNS_Product)
            If result > 0 Then
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "javascript:parent.window.CloseAddProductModuleDiv();", True)
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Update", "javascript:parent.window.UpdateButton();", True)
            ElseIf result = 0 Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Show", "parent.window.OpenAddProductModuleDiv();", True)
                Me.lblMessage.Visible = True
            End If
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            If String.IsNullOrEmpty(Request.QueryString("ProductID")) = False Then
                Me.hdnProductID.Value = Request.QueryString("ProductID").ToString()
                Me.btnCancel.Attributes.Add("onclick", "javascript:parent.window.CloseAddProductModuleDiv();return false;")
                Me.lblHeader.Text = "Add Module"
            End If
            If String.IsNullOrEmpty(Request.QueryString("ModuleID")) = False Then
                Me.hdnModuleID.Value = Request.QueryString("ModuleID").ToString()
                GetModule(CInt(Me.hdnModuleID.Value))
                Me.btnCancel.Attributes.Add("onclick", "javascript:parent.window.CloseEditProductModuleDiv();return false;")
                Me.lblHeader.Text = "Edit Module"
            End If
        End If
         End Sub
    Public Sub GetModule(ByVal ID As Integer)
        Dim dr_Module As SqlDataReader = Nothing
        dr_Module = Portal.BLL.NSProducts.GetModuleByID(ID)
        While dr_Module.Read()
            Me.txtTitle.Text = CType(Functions.IfNull(dr_Module("Title").ToString(), ""), String)
            Me.txtAbbreviation.Text = CType(Functions.IfNull(dr_Module("Abbreviation").ToString(), ""), String)
            Me.txtPrice.Text = CType(FormatNumber(Functions.IfNull(dr_Module("Price"), 0.0), 2), Decimal)
            Me.ddlType.SelectedValue = CType(Functions.IfNull(dr_Module("Type"), 0), Integer)
            Me.ddlPriceOption.SelectedValue = CType(Functions.IfNull(dr_Module("PriceOption"), 0), Integer)
            Me.ddlProduct.SelectedValue = CType(Functions.IfNull(dr_Module("ParentID"), 0), Integer)
        End While
        dr_Module.Close()
    End Sub
    Public Sub UpdateModule()
        Dim objNS_Product As New Portal.BLL.NSProducts
        objNS_Product.Title = Me.txtTitle.Text.Trim
        objNS_Product.Abbreviation = Me.txtAbbreviation.Text.Trim
        objNS_Product.Type = Me.ddlType.SelectedValue.Trim
        objNS_Product.Price = Me.txtPrice.Text.Trim
        objNS_Product.PriceOption = Me.ddlPriceOption.SelectedValue.Trim
        objNS_Product.ID = CInt(Me.hdnModuleID.Value)
        objNS_Product.ParentID = CInt(Me.ddlProduct.SelectedValue)
        Dim returnValue As Integer = Portal.BLL.NSProducts.UpdateModule(objNS_Product)
        If returnValue > 0 Then
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "javascript:parent.window.CloseEditProductModuleDiv();", True)
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "Update", "javascript:parent.window.UpdateButton();", True)
        ElseIf returnValue = 0 Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Show", "parent.window.OpenEditProductModuleDiv();", True)
            Me.lblMessage.Visible = True
        End If
    End Sub
End Class
