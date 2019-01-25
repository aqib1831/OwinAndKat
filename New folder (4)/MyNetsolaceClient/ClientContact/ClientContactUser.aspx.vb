
Partial Class MyNetsolace_ClientContactUser
    Inherits System.Web.UI.Page
    Dim totalRecords As Integer = 0
    Dim totalPages As Integer = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            hdnClientID.Value = Session("MyNetsolace_ClientID")
            If String.IsNullOrEmpty(Request.QueryString("ddlInActive")) = False Then
                ddlInActive.SelectedValue = Request.QueryString("ddlInActive")
            End If
            If String.IsNullOrEmpty(Request.QueryString("UserType")) = False Then
                ddlUserType.SelectedValue = Request.QueryString("UserType")
            End If
            If String.IsNullOrEmpty(Request.QueryString("txtSearch")) = False Then
                txtSearch.Text = Request.QueryString("txtSearch")
            End If
        End If
    End Sub

    Protected Sub ODS_GetAll_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ODS_GetAll.Selected
        If IsNumeric(e.ReturnValue.ToString()) Then
            If String.IsNullOrEmpty(txtSearch.Text) = False Then
                ltrlFiltered.Text = "Filtered"
            Else
                ltrlFiltered.Text = "All"
            End If

            lblRecordCount.Text = e.ReturnValue.ToString()
        End If
    End Sub

    Protected Sub gvUsers_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvUsers.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            totalRecords = totalRecords + 1

            'To open user edit page on click
            e.Row.Attributes.Add("onclick", "ShowUserDetail(this," & CType(DataBinder.Eval(e.Row.DataItem, "ID"), String) & ");")
        End If

        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvUsers.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvUsers.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvUsers.PageIndex = 0) Then
                'Disable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "../../images/back_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = False
                'Disalbe First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "../../images/First_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                'Enable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "../../images/back_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = True

                'Enable Last First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "../../images/First_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'To enable and Disable Next Image button.
            If (gvUsers.PageIndex = gvUsers.PageCount - 1) Then
                'Disable Next Button
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "../../images/Next_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = False

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "../../images/Last_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "../../images/Next_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = True

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "../../images/Last_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'Setting the No of Records that are being shown 
            If (((gvUsers.PageIndex + 1) * gvUsers.PageSize) < gvUsers.PageCount * gvUsers.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvUsers.PageIndex + 1) * gvUsers.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = lblRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvUsers.PageIndex * gvUsers.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = lblRecordCount.Text
        End If
    End Sub

End Class
