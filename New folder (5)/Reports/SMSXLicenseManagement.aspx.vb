Partial Class LM_SMSXLicenseManagement
    Inherits System.Web.UI.Page

    Protected Sub gvwKeys_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwKeys.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvwKeys.SortExpression = button.CommandArgument Then
                            If gvwKeys.SortDirection = SortDirection.Ascending Then
                                button.Text += " &nbsp;<img src='../images/asc.gif' title='Sort ascending' style='vertical-align:middle; border:0;'  />"
                            Else
                                button.Text += " &nbsp;<img src='../images/desc.gif' title='Sort descending' style='vertical-align:middle; border:0;'  />"
                            End If
                        End If
                    End If
                End If
            Next
        End If
    End Sub

    Protected Sub gvwKeys_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwKeys.RowDataBound
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvwKeys.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvwKeys.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvwKeys.PageIndex = 0) Then
                'Disable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "../images/back_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = False
                'Disalbe First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "../images/First_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                'Enable Previous Button
                imgPage = CType(e.Row.FindControl("imgPrevious"), Image)
                imgPage.ImageUrl = "../images/back_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnPrevious"), LinkButton)
                lnkBtnPage.Enabled = True

                'Enable Last First Button
                imgPage = CType(e.Row.FindControl("imgFirst"), Image)
                imgPage.ImageUrl = "../images/First_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnFirst"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'To enable and Disable Next Image button.
            If (gvwKeys.PageIndex = gvwKeys.PageCount - 1) Then
                'Disable Next Button
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "../images/Next_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = False

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "../images/Last_gry.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = False

            Else
                imgPage = CType(e.Row.FindControl("imgNext"), Image)
                imgPage.ImageUrl = "../images/Next_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnNext"), LinkButton)
                lnkBtnPage.Enabled = True

                'Disable Last Button
                imgPage = CType(e.Row.FindControl("imgLast"), Image)
                imgPage.ImageUrl = "../images/Last_blk.jpg"
                lnkBtnPage = CType(e.Row.FindControl("lnkBtnLast"), LinkButton)
                lnkBtnPage.Enabled = True

            End If

            'Setting the No of Records that are being shown 
            If (((gvwKeys.PageIndex + 1) * gvwKeys.PageSize) < gvwKeys.PageCount * gvwKeys.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvwKeys.PageIndex + 1) * gvwKeys.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvwKeys.PageIndex * gvwKeys.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If
    End Sub
    Protected Sub odsSBSSMSXLicenses_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsSBSSMSXLicenses.Selected
        If (IsNumeric(e.ReturnValue)) Then
            ltrlRecordCount.Text = e.ReturnValue.ToString
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showsmsxcount", "parent.showsmsxcount(" & e.ReturnValue.ToString() & ");", True)
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
    End Sub
    Protected Sub gvwKeys_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvwKeys.Sorting
        Dim Script As String = "setValues('" & e.SortExpression & IIf(e.SortDirection = 1, " DESC", "") & "');"
        ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "AssignValues", Script, True)
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
End Class

