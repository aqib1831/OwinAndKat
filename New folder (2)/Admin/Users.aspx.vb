Imports System.Collections.Generic
Partial Class Admin_Users
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If (String.IsNullOrEmpty(Request.QueryString("Search")) = False) Then
                txtSearch.Text = Request.QueryString("Search")
            End If
            If (String.IsNullOrEmpty(Request.QueryString("Status")) = False) Then
                ddlStatus.SelectedValue = CStr(Request.QueryString("Status"))
            Else
                ddlStatus.Items.FindByValue("False").Selected = True
            End If
        End If
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub ddlCountry_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub gvUsers_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvUsers.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvUsers.SortExpression = button.CommandArgument Then
                            If gvUsers.SortDirection = SortDirection.Ascending Then
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

    Protected Sub gvUsers_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvUsers.RowDataBound

        Dim ids As Integer
        If e.Row.RowType = DataControlRowType.DataRow Then
            ids = DataBinder.Eval(e.Row.DataItem, "ID")
            e.Row.Attributes.Add("onclick", "ShowUserDetail('" & DataBinder.Eval(e.Row.DataItem, "ID") & "', this);")

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
            If (gvUsers.PageIndex = gvUsers.PageCount - 1) Then
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
            If (((gvUsers.PageIndex + 1) * gvUsers.PageSize) < gvUsers.PageCount * gvUsers.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvUsers.PageIndex + 1) * gvUsers.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvUsers.PageIndex * gvUsers.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If


    End Sub

    Protected Sub ddlDeparments_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDeparments.DataBound
        If (String.IsNullOrEmpty(Request.QueryString("Department")) = False And CInt(Request.QueryString("Department")) > 0) Then
            ddlDeparments.Items.Insert(0, New ListItem("Select...", 0))
            ddlDeparments.SelectedValue = CStr(Request.QueryString("Department"))
        Else
            ddlDeparments.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlTeams_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTeams.DataBound
        If (String.IsNullOrEmpty(Request.QueryString("Team")) = False) And CInt(Request.QueryString("Team")) > 0 Then
            ddlTeams.Items.Insert(0, New ListItem("Select...", 0))
            ddlTeams.SelectedValue = CInt(Request.QueryString("Team"))
        Else
            ddlTeams.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlOfficess_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlOfficess.DataBound
        If (String.IsNullOrEmpty(Request.QueryString("Office")) = False) And CInt(Request.QueryString("Office")) > 0 Then
            ddlOfficess.Items.Insert(0, New ListItem("Select...", 0))
            ddlOfficess.SelectedValue = CInt(Request.QueryString("Office"))
        Else
            ddlOfficess.Items.Insert(0, New ListItem("Select...", 0))
        End If

    End Sub

    Protected Sub ODS_GetAll_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles ODS_GetAll.Selected
        If (IsNumeric(e.ReturnValue)) Then
            ltrlRecordCount.Text = e.ReturnValue.ToString
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If

    End Sub
    Protected Sub gvUsers_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvUsers.Sorting
        Dim Script As String = "setValues('" & e.SortExpression & IIf(e.SortDirection = 1, " DESC", "") & "');"
        ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "AssignValues", Script, True)
    End Sub
End Class
