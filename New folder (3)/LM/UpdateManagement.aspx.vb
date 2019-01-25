Imports System.Data
Imports System.Data.SqlClient

Partial Class LM_UpdateManagement
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Page.IsPostBack = False Then
                'hdnUserID.Value = Session("adminID")
               BindGridData()
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "Page_Load", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Protected Sub gvwUpdates_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwUpdates.RowDataBound
        Try

        
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Attributes.Add("onclick", "this.className='selectedRow'; ShowUpdateGroups('" & DataBinder.Eval(e.Row.DataItem, "ID") & "', '" & DataBinder.Eval(e.Row.DataItem, "VersionNo") & "');")

            If ((e.Row.RowIndex Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If


        End If
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvwUpdates.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvwUpdates.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvwUpdates.PageIndex = 0) Then
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
            If (gvwUpdates.PageIndex = gvwUpdates.PageCount - 1) Then
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
            If (((gvwUpdates.PageIndex + 1) * gvwUpdates.PageSize) < gvwUpdates.PageCount * gvwUpdates.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvwUpdates.PageIndex + 1) * gvwUpdates.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvwUpdates.PageIndex * gvwUpdates.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdates_RowDataBound", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Protected Sub gvwUpdates_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwUpdates.RowCreated
        Try
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If CType(ViewState("SortExpression"), String) = button.CommandArgument Then
                            If CType(ViewState("SortDirection"), String) = "ASC" Then
                                button.Text += " &nbsp;<img src='../images/asc.gif' title='Sort ascending' style='vertical-align:middle; border:0;'  />"
                            Else
                                button.Text += " &nbsp;<img src='../images/desc.gif' title='Sort descending' style='vertical-align:middle; border:0;'  />"
                            End If
                        End If
                    End If
                End If
            Next
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdates_RowCreated", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Protected Sub ddlCountry_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.SelectedIndexChanged
        Try
        Dim dt As DataTable = Nothing
        dt = Portal.BLL.UpdateManagement.GetAllSMSUpdate(Convert.ToInt32(ddlCountry.SelectedValue))
        Me.ViewState.Add("dt", dt)
            BindGridData()
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "ddlCountry_SelectedIndexChanged", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Private Function BindGridData()
        Dim dt As DataTable = Nothing
        If (Me.ViewState("dt") Is Nothing) Then
            dt = Portal.BLL.UpdateManagement.GetAllSMSUpdate(Convert.ToInt32(ddlCountry.SelectedValue))
            Me.ViewState.Add("dt", dt)
        Else
            dt = CType(Me.ViewState("dt"), DataTable)
        End If
        gvwUpdates.DataSource = Nothing
        If (dt IsNot Nothing) Then
            gvwUpdates.DataSource = dt
            ltrlRecordCount.Text = dt.Rows.Count
        End If
        gvwUpdates.DataBind()
        
    End Function

    Protected Sub gvwUpdates_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvwUpdates.Sorting
        Try
        Dim dt As DataTable = CType(Me.ViewState("dt"), DataTable)
        dt.DefaultView.Sort = e.SortExpression & " " & GetSortDirection(e.SortExpression)
            BindGridData()
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdates_Sorting", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Private Function GetSortDirection(ByVal column As String) As String
        Dim sortDirection = "ASC"
        Dim sortExpression = TryCast(ViewState("SortExpression"), String)
        If sortExpression IsNot Nothing Then
            If sortExpression = column Then
                Dim lastDirection = TryCast(ViewState("SortDirection"), String)
                If lastDirection IsNot Nothing _
                  AndAlso lastDirection = "ASC" Then
                    sortDirection = "DESC"
                End If
            End If
        End If
        ViewState("SortDirection") = sortDirection
        ViewState("SortExpression") = column
        Return sortDirection
    End Function


    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
        Dim dt As DataTable = Nothing
        dt = Portal.BLL.UpdateManagement.GetAllSMSUpdate(Convert.ToInt32(ddlCountry.SelectedValue))
        Me.ViewState.Add("dt", dt)
        BindGridData()

        Dim dtFiltered As DataTable = New DataTable

        dtFiltered.Columns.Add("ID", GetType(Int32))
        dtFiltered.Columns.Add("VersionNo", GetType(String))
        dtFiltered.Columns.Add("ReleaseDate", GetType(DateTime))
        dtFiltered.Columns.Add("Description", GetType(String))
        dtFiltered.Columns.Add("UpdateAvailableDate", GetType(DateTime))

        Dim foundRows As DataRow()
        foundRows = dt.Select("VersionNo like ('%" + txtSearch.Text + "%')")

        For Each dr As DataRow In foundRows
            dtFiltered.ImportRow(dr)
        Next
        Me.ViewState.Add("dt", dtFiltered)
            BindGridData()
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "btnSearch_Click", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Protected Sub gvwUpdates_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvwUpdates.PageIndexChanging
        Try
        gvwUpdates.PageIndex = e.NewPageIndex
            BindGridData()
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdates_PageIndexChanging", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub
End Class

