
Partial Class KB_Add_Category
    Inherits System.Web.UI.Page
#Region "Page Events"
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (IsPostBack = False) Then
            If String.IsNullOrEmpty(Request.QueryString("CategoryID")) = False AndAlso IsNumeric(Request.QueryString("CategoryID")) = True Then
                PopulateControl(Request.QueryString("CategoryID"))
            End If
        End If
    End Sub
#End Region

#Region "Event Handler"
    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        Dim ObjCategory As New Category
        If Page.IsValid Then
            With ObjCategory
                .Name = txtName.Text.Trim()
                .Sequence = 1
                If String.IsNullOrEmpty(Request.QueryString("CategoryID")) = False AndAlso IsNumeric(Request.QueryString("CategoryID")) = True Then
                    .ID = Request.QueryString("CategoryID")
                    If .Update() = -1 Then
                        lblMsg.Text = "Category with same title already exists. "
                        Exit Sub
                    End If
                Else
                    If .Add() = -1 Then
                        lblMsg.Text = "Category with same title already exists. "
                        Exit Sub
                    End If
                End If
            End With
        End If
        ' Response.Redirect("List_Categories.aspx")

        ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ChangeIframe", "parent.RefreshMain();", True)
    End Sub
    Protected Sub BtnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnCancel.Click
        Response.Redirect("List_Categories.aspx")
    End Sub
#End Region

#Region "private Methods"
    Private Sub PopulateControl(ByVal CategoryID As Integer)
        lblHeading.Text = "Edit Category"
        Dim ObjCategory As New Category
        ObjCategory.LoadCategoryDetail(CategoryID)
        txtName.Text = ObjCategory.Name
    End Sub
#End Region
End Class
