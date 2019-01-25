Partial Class URLM_Registrar
    Inherits System.Web.UI.Page

    Protected Sub lnkAddNew_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddNew.Click
        DivNew.Attributes.Add("style", "display:inline;")
        lnkAddNew.Enabled = False
    End Sub

    Protected Sub BtnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnCancel.Click
        DivNew.Attributes.Add("style", "display:none;")
        lnkAddNew.Enabled = True
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub gvCategory_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvRegistrars.RowCommand
        If e.CommandName = "Delete" Then
            hdnID.Value = Convert.ToInt32(e.CommandArgument)
            DivNew.Attributes.Add("style", "display:none;")
            divDisable.Attributes.Add("style", "width:0px; height:0px")
        End If
    End Sub


    Protected Sub gvCategory_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvRegistrars.RowEditing

    End Sub

    Protected Sub gvRegistrars_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvRegistrars.RowUpdating
        Dim row As GridViewRow = gvRegistrars.Rows(e.RowIndex)
        hdnID.Value = CType(row.FindControl("lblID"), Label).Text
        hdnTitle.Value = CType(row.FindControl("txtTitle"), TextBox).Text
    End Sub

    Protected Sub sdsRegistrars_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsRegistrars.Inserted
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDiv", "DivOptionHide();", True)
        If CInt(e.Command.Parameters("@ReturnValue").Value) = 0 Or CInt(e.Command.Parameters("@ReturnValue").Value) = 1 Then
            lblError.Visible = False
        Else
            lblError.Visible = True
        End If
    End Sub

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
      If Page.IsValid Then
            Dim objURLm As SSLM = New SSLM()
            hdnTitle.Value = Functions.ProperCase(Server.HtmlDecode(txtTitle.Text.Trim))
            hdnDescription.Value = Server.HtmlDecode(txtDescription.Text.Trim)
            Dim Result As Integer = 0
            Result = SSLM.CheckDuplicateRegistrarByTitle(txtTitle.Text)
            If Result > 0 Then
                lblErrorMsg.Visible = True
                'lblErrorMsg.Text = "Registrar already exsits."
                DivNew.Attributes.Add("style", "display:inline; border:solid 1px #000000; position:absolute;width:33%;height:250px;top:20%; left:25%;")
                divDisable.Attributes.Add("style", "width:100%;height:100%")
            Else
                Dim abc As Integer = sdsRegistrars.Insert()
                DivNew.Attributes.Add("style", "display:none;")
                Response.Redirect(Request.RawUrl)
            End If
        ElseIf txtTitle.Text = "" Or txtDescription.Text = "" Then
            DivNew.Attributes.Add("style", "display:inline; border:solid 1px #000000; position:absolute;width:33%;height:250px;top:20%; left:25%;")
            divDisable.Attributes.Add("style", "width:100%;height:100%")
            lblErrorMsg.Visible = False
        End If
    End Sub

    Protected Sub sdsRegistrars_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsRegistrars.Selected

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

    Protected Sub gvHowHeards_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvRegistrars.RowEditing
        Session("hdnRowID") = e.NewEditIndex.ToString()
        DivNew.Attributes.Add("style", "display:none;")
    End Sub

    Protected Sub val_server_duplicate_Category_check_Grid_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
        Dim Row As GridViewRow = gvRegistrars.Rows(Integer.Parse(Session("hdnRowID").ToString()))
        Title = Server.HtmlEncode(CType(Row.FindControl("txtTitle"), TextBox).Text.Trim)
        If Title <> "" Then
            Dim Result As Integer = 0
            Dim ID As Integer = Integer.Parse(CType(Row.FindControl("lblID"), Label).Text.Trim)
            Result = SSLM.CheckDuplicateRegistrar(ID, Title)
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

    Protected Sub URLM_Registrar_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserBrowser") = "AppleMAC-Safari" Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "Button Adjustment", "AdjustButtons(1);", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "Button Adjustment", "AdjustButtons(0);", True)
        End If
    End Sub
End Class