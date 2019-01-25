Partial Class URLM_Category
    Inherits System.Web.UI.Page

    Protected Sub lnkAddNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddNew.Click
        DivNew.Attributes.Add("style", "display:inline;")
        lnkAddNew.Enabled = False
    End Sub

    Protected Sub BtnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnCancel.Click
        DivNew.Attributes.Add("style", "display:none;")
        lnkAddNew.Enabled = True
    End Sub

    Protected Sub gvCategory_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvCategory.RowCommand
        If e.CommandName = "Delete" Then
            hdnID.Value = Convert.ToInt32(e.CommandArgument)
        End If
    End Sub


    Protected Sub gvCategory_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvCategory.RowEditing
      
    End Sub

    Protected Sub gvCategory_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvCategory.RowUpdating
        Dim row As GridViewRow = gvCategory.Rows(e.RowIndex)
        hdnID.Value = CType(row.FindControl("lblID"), Label).Text
        hdnTitle.Value = CType(row.FindControl("txtTitle"), TextBox).Text
    End Sub

    Protected Sub sdsCategories_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCategories.Inserted
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDiv", "DivOptionHide();", True)
        If CInt(e.Command.Parameters("@ReturnValue").Value) = 0 Or CInt(e.Command.Parameters("@ReturnValue").Value) = 1 Then
            lblError.Visible = False
        Else
            lblError.Visible = True
        End If
    End Sub

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        If Page.IsValid Then
            Dim objURLm As URLM = New URLM()
            hdnTitle.Value = Functions.ProperCase(Server.HtmlDecode(txtTitle.Text.Trim))
            hdnDescription.Value = Server.HtmlDecode(txtDescription.Text.Trim)
            sdsCategories.Insert()
        End If
    End Sub

    Protected Sub sdsCategories_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCategories.Selected

        If e.Command.Parameters("@RecCount").Value IsNot DBNull.Value Then
            lblCount.Text = e.Command.Parameters("@RecCount").Value
        Else
            lblCount.Text = 0.ToString
        End If
        If String.IsNullOrEmpty(txtSearch.Text.Trim) = False Then
            lblFilter.Text = "Filtered"
        Else
            lblFilter.Text = "All"
        End If

    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub sdsCategories_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsCategories.Updated
       
    End Sub

    Protected Sub gvHowHeards_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvCategory.RowEditing
        Session("hdnRowID") = e.NewEditIndex.ToString()
    End Sub

    Protected Sub val_server_duplicate_Category_check_Grid_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        Dim Row As GridViewRow = gvCategory.Rows(Integer.Parse(Session("hdnRowID").ToString()))
        Title = Server.HtmlEncode(CType(Row.FindControl("txtTitle"), TextBox).Text.Trim)
        If Title <> "" Then
            Dim Result As Integer = 0
            Dim ID As Integer = Integer.Parse(CType(Row.FindControl("lblID"), Label).Text.Trim)
            Result = URLM.CheckDuplicateCategory(ID, Title)
            If Result > 0 Then
                CType(Row.FindControl("val_server_duplicate_Category_check_Grid"), CustomValidator).ErrorMessage = "<b>" & Title & "</b> already exists."
                args.IsValid = False
            Else
                args.IsValid = True
            End If
        Else
            args.IsValid = False
        End If

    End Sub
    Protected Sub URLM_Category_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserBrowser") = "AppleMAC-Safari" Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "Button Adjustment", "AdjustButtons(1);", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "Button Adjustment", "AdjustButtons(0);", True)
        End If
    End Sub
End Class