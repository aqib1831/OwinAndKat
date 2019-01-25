
Partial Class HR_Career
    Inherits System.Web.UI.Page
    Protected count As Integer = 1

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        'If CStr(Session("HRAdminID")) = "" Then
        '    Response.Redirect("Default.aspx")
        'End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'ClientScript.RegisterStartupScript(Me.GetType(), "SelectParent", "parent.SetSelected(2);", True)

        If Not IsPostBack Then

        End If
    End Sub

    Protected Sub gvwIdeas_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvwIdeas.RowCommand
        If e.CommandName = "EditMy" Then
            Response.Redirect("Career_New.aspx?JobID=" & e.CommandArgument.ToString())
        End If
        If e.CommandName = "DeleteMy" Then
            Portal.BLL.HR.Jobs.Jobs_DeleteByID(e.CommandArgument.ToString())
        End If
        gvwIdeas.DataBind()
    End Sub

    Protected Sub gvwIdeas_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwIdeas.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvwIdeas.SortExpression = button.CommandArgument Then
                            If gvwIdeas.SortDirection = SortDirection.Ascending Then
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


    Protected Sub gvwIdeas_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwIdeas.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            'Dim lbl As Label = e.Row.FindControl("lblSeq")
            'lbl.Text = count.ToString()
            'count += 1
            Dim job As Portal.BLL.HR.Jobs = CType(e.Row.DataItem, Portal.BLL.HR.Jobs)
            e.Row.Cells(1).Attributes.Add("onClick", "this.className='selectedRow'; javascript:window.location='Career_New.aspx?JobID=" & job.ID & "';")
            e.Row.Cells(2).Attributes.Add("onClick", "this.className='selectedRow'; javascript:window.location='Career_New.aspx?JobID=" & job.ID & "';")
            e.Row.Cells(3).Attributes.Add("onClick", "this.className='selectedRow'; javascript:window.location='Career_New.aspx?JobID=" & job.ID & "';")


            Dim Lastdate As Date = CType(DataBinder.Eval(e.Row.DataItem, "Lastdate"), Date)
            If (Lastdate <> #1/1/1900# AndAlso Lastdate < Date.Now) Then
                'e.Row.Cells(0).Style.Add("background-color", "#FFF1F1")
                'e.Row.Cells(1).Style.Add("background-color", "#FFF1F1")
                'e.Row.Cells(2).Style.Add("background-color", "#FFF1F1")
                'e.Row.Cells(3).Style.Add("background-color", "#FFF1F1")
                'e.Row.Cells(4).Style.Add("background-color", "#FFF1F1")
                ' e.Row.Cells(5).Style.Add("background-color", "#FFF1F1")
            End If
        End If

        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvwIdeas.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvwIdeas.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvwIdeas.PageIndex = 0) Then
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
            If (gvwIdeas.PageIndex = gvwIdeas.PageCount - 1) Then
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
            If (((gvwIdeas.PageIndex + 1) * gvwIdeas.PageSize) < gvwIdeas.PageCount * gvwIdeas.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvwIdeas.PageIndex + 1) * gvwIdeas.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvwIdeas.PageIndex * gvwIdeas.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If
    End Sub


    Protected Sub odsIdeas_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsIdeas.Selected
        If (IsNumeric(e.ReturnValue)) Then
            ltrlRecordCount.Text = e.ReturnValue.ToString
            'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowCount", "parent.SetSumbissionCount(" & e.ReturnValue & ");", True)

            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            End If
        End If
    End Sub
End Class
