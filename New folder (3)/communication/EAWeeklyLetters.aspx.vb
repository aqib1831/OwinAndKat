
Partial Class admin_comm_EAWeeklyLetters
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If String.IsNullOrEmpty(Request.QueryString("Search")) = False Then
                txtSearch.Text = Request.QueryString("Search")
            End If
            If String.IsNullOrEmpty(Request.QueryString("Status")) = False Then
                ddlStatus.SelectedValue = Request.QueryString("Status")            
            End If
            If String.IsNullOrEmpty(Request.QueryString("IsPublished")) = False Then
                ddlStatus.SelectedValue = Request.QueryString("IsPublished")
            End If
        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SelectTab", "parent.ChangeTrBackGround(2);", True)

    End Sub
    Protected Sub admin_comm_EAWeeklyLetters_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub odsLetters_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsLetters.Selected
        If (IsNumeric(e.ReturnValue)) Then
            lblRecCount.Text = e.ReturnValue.ToString
        End If
    End Sub
    Protected Sub gvUsers_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvLetters.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvLetters.SortExpression = button.CommandArgument Then
                            If gvLetters.SortDirection = SortDirection.Ascending Then
                                button.Text += " &nbsp;<img src='../images/asc_small.gif' title='Sort ascending' style='vertical-align:middle; border:0;'  />"
                            Else
                                button.Text += " &nbsp;<img src='../images/desc_small.gif' title='Sort descending' style='vertical-align:middle; border:0;'  />"
                            End If
                        End If
                    End If
                End If
            Next
        End If
    End Sub
    Protected Sub gvLetters_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvLetters.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Attributes.Add("onclick", "this.className='selected';")
            Dim isPublised As Boolean = CType(DataBinder.Eval(e.Row.DataItem, "IsPublished"), Boolean)
            Dim weeklyLetterId As Integer = CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer)
            e.Row.Cells(0).Attributes.Add("onclick", "ShowWeeklyLetterDetail('" & weeklyLetterId & "','" & isPublised & "', this);")
            e.Row.Cells(1).Attributes.Add("onclick", "ShowWeeklyLetterDetail('" & weeklyLetterId & "','" & isPublised & "', this);")
            e.Row.Cells(2).Attributes.Add("onclick", "ShowWeeklyLetterDetail('" & weeklyLetterId & "','" & isPublised & "', this);")
            Dim lnkBtn As LinkButton = CType(e.Row.FindControl("lnkBtnEdit"), LinkButton)
            If (isPublised) Then
                lnkBtn.Text = "View"
                e.Row.Cells(3).Attributes.Add("onclick", "ShowWeeklyLetterDetail('" & weeklyLetterId & "','" & isPublised & "', this);")
            Else
                e.Row.Cells(3).Attributes.Add("onclick", "EditWeeklyLetter('" & weeklyLetterId & "', this);")
                lnkBtn.Text = "Edit"
                lnkBtn.OnClientClick = "event.cancelBubble=false; return false;"
            End If
        Else
            If (e.Row.RowType = DataControlRowType.Pager) Then
                'Setting the Current Page and Total Page Count.
                CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvLetters.PageIndex + 1).ToString()
                CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvLetters.PageCount.ToString()

                Dim imgPage As Image = New Image()
                Dim lnkBtnPage As LinkButton = New LinkButton()

                If (gvLetters.PageIndex = 0) Then
                    'Disable Previous Button
                    imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                    imgPage.ImageUrl = "~/images/back_gry.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                    lnkBtnPage.Enabled = False
                    'Disalbe First Button
                    imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                    imgPage.ImageUrl = "~/images/First_gry.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                    lnkBtnPage.Enabled = False

                Else
                    'Enable Previous Button
                    imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                    imgPage.ImageUrl = "~/images/back_blk.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                    lnkBtnPage.Enabled = True

                    'Enable Last First Button
                    imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                    imgPage.ImageUrl = "~/images/First_blk.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                    lnkBtnPage.Enabled = True

                End If

                'To enable and Disable Next Image button.
                If (gvLetters.PageIndex = gvLetters.PageCount - 1) Then
                    'Disable Next Button
                    imgPage = CType(e.Row.FindControl("imgNext"), Image)
                    imgPage.ImageUrl = "~/images/Next_gry.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                    lnkBtnPage.Enabled = False

                    'Disable Last Button
                    imgPage = CType(e.Row.FindControl("imgLast"), Image)
                    imgPage.ImageUrl = "~/images/Last_gry.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                    lnkBtnPage.Enabled = False

                Else
                    imgPage = CType(e.Row.FindControl("imgNext"), Image)
                    imgPage.ImageUrl = "~/images/Next_blk.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                    lnkBtnPage.Enabled = True

                    'Disable Last Button
                    imgPage = CType(e.Row.FindControl("imgLast"), Image)
                    imgPage.ImageUrl = "~/images/Last_blk.jpg"
                    lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                    lnkBtnPage.Enabled = True

                End If

                'Setting the No of Records that are being shown 
                If (((gvLetters.PageIndex + 1) * gvLetters.PageSize) < gvLetters.PageCount * gvLetters.PageSize) Then
                    CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvLetters.PageIndex + 1) * gvLetters.PageSize)
                Else
                    CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = lblRecCount.Text
                End If
                'Setting the start Count
                CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvLetters.PageIndex * gvLetters.PageSize) + 1)
                'Setting the total Count
                CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = lblRecCount.Text
            End If
        End If
    End Sub
End Class
