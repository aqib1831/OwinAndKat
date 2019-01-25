
Partial Class UM_LinksList
    Inherits System.Web.UI.Page
    Private flag As Boolean = False
    Dim isWriteAccess As Boolean = False
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub gvContent_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvContent.RowDataBound
        If e.Row.RowType = DataControlRowType.Header Or e.Row.RowType = DataControlRowType.Footer Then
            If Not isWriteAccess Then
                e.Row.Cells(e.Row.Cells.Count - 1).Attributes.Add("style", "display:none")
            End If
        End If
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lnkEdit As LinkButton = CType(e.Row.FindControl("lnkEdit"), LinkButton)
            If Not lnkEdit Is Nothing Then
                lnkEdit.Attributes.Add("onclick", "javascript:window.location='NewLink.aspx?LinkID=" & e.Row.DataItem("ID") & "&SelectedCategory=" & Me.ddlCategories.SelectedValue & "&UMType=" & Request.QueryString("UMType") & "'")
            End If

            e.Row.Attributes.Add("onclick", "this.className='selectedRow';javascript:window.location='NewLink.aspx?LinkID=" & e.Row.DataItem("ID") & "&SelectedCategory=" & Me.ddlCategories.SelectedValue & "&UMType=" & Request.QueryString("UMType") & "';return false;")
            If Not isWriteAccess Then
                e.Row.Cells(e.Row.Cells.Count - 1).Attributes.Add("style", "display:none")
            End If

        End If
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvContent.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvContent.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvContent.PageIndex = 0) Then
                'Disable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "images/back_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = False
                'Disalbe First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "images/First_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                'Enable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "images/back_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = True

                'Enable Last First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "images/First_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'To enable and Disable Next Image button.
            If (gvContent.PageIndex = gvContent.PageCount - 1) Then
                'Disable Next Button
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "images/Next_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = False

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "images/Last_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "images/Next_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = True

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "images/Last_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'Setting the No of Records that are being shown 
            If (((gvContent.PageIndex + 1) * gvContent.PageSize) < gvContent.PageCount * gvContent.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvContent.PageIndex + 1) * gvContent.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvContent.PageIndex * gvContent.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If
    End Sub

    Protected Sub odsContent_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsContent.Selected
        Dim Count As Integer = 0
        If Not e.ReturnValue Is Nothing Then
            If IsNumeric(e.ReturnValue) = True Then
                ltrlRecordCount.Text = e.ReturnValue.ToString
                Me.lblLinkCount.Text = e.ReturnValue.ToString()

                If ((e.ReturnValue Mod 2) <> 0) Then
                    ClientScript.RegisterStartupScript(Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
                End If
            End If
        End If
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        Me.ddlCategories.Items.Insert(0, New ListItem("Show All...", "0"))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        isWriteAccess = Functions.CheckSubModuleAccess(Portal.BLL.Enumeration.SubModules.UMFullAccess)
        If Not isWriteAccess Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "hide", "document.getElementById('btnAddLink').style.display='none';", True)
        End If
    End Sub
End Class
