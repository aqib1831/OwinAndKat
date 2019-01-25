Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services

Partial Class LM_UpdateGroups
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Page.IsPostBack = False Then
                BindGridData(True)
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "Page_Load", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Protected Sub ddlStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStatus.SelectedIndexChanged
        Try
        Dim dt As DataTable = Nothing
        Dim countryID As Integer = Request.QueryString("countryID")
        Dim updateID As Integer = Request.QueryString("updateID")
            dt = Portal.BLL.UpdateManagement.GetUpdateGroupsByUpdateID(countryID, updateID)

            Me.ViewState.Add("dt", dt)
            Dim dtFiltered As DataTable = New DataTable
            If (Convert.ToInt32(ddlStatus.SelectedValue) = -1) Then
                BindGridData(False)
                Return
            End If
            If (dt IsNot Nothing) Then
                dtFiltered.Columns.Add("ID", GetType(Int32))
                dtFiltered.Columns.Add("Title", GetType(String))
        dtFiltered.Columns.Add("Name", GetType(String))
        dtFiltered.Columns.Add("StatusID", GetType(Int32))

        dtFiltered.Columns.Add("StatusName", GetType(String))
        dtFiltered.Columns.Add("StoreCount", GetType(Int32))
        dtFiltered.Columns.Add("VersionNo", GetType(String))
        dtFiltered.Columns.Add("Threshold", GetType(Int32))
        dtFiltered.Columns.Add("UpdateMandatoryDate", GetType(String))
        dtFiltered.Columns.Add("IsMandatory", GetType(String))

        Dim foundRows As DataRow()
        foundRows = dt.Select("StatusID = " + ddlStatus.SelectedValue.ToString())

        For Each dr As DataRow In foundRows
            dtFiltered.ImportRow(dr)
        Next
        Me.ViewState.Add("dt", dtFiltered)
            End If
            BindGridData(False)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "ddlStatus_SelectedIndexChanged", String.Empty, String.Empty, String.Empty)
        End Try

    End Sub

    Protected Sub btnRebindGrid_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRebindGrid.Click
        Try
            Dim dt As DataTable = Nothing
            Dim countryID As Integer = Request.QueryString("countryID")
            Dim updateID As Integer = Request.QueryString("updateID")
            dt = Portal.BLL.UpdateManagement.GetUpdateGroupsByUpdateID(countryID, updateID)
            Me.ViewState.Add("dt", dt)
            ddlStatus.SelectedValue = -1
            BindGridData(False)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "btnRebindGrid_Click", String.Empty, String.Empty, String.Empty)
        End Try

    End Sub

    Private Function BindGridData(ByVal isPageLoad As Boolean)
        Dim dt As DataTable = Nothing
        If (Me.ViewState("dt") Is Nothing) Then
            Dim countryID As Integer = Request.QueryString("countryID")
            Dim updateID As Integer = Request.QueryString("updateID")
            dt = Portal.BLL.UpdateManagement.GetUpdateGroupsByUpdateID(countryID, updateID)
            Me.ViewState.Add("dt", dt)
        Else
            dt = CType(Me.ViewState("dt"), DataTable)
        End If
        gvwUpdateGroups.DataSource = Nothing
        If (dt IsNot Nothing) Then
            Dim TotalCount As Object
            TotalCount = dt.Compute("Count(ID)", "")
            If (TotalCount IsNot Nothing AndAlso Not IsDBNull(TotalCount)) Then
                ViewState("TotalCount") = TotalCount
            End If


            
            If (isPageLoad) Then
                ltrlUpdateVersionNo.Text = dt.Rows(0)("VersionNo")
                Me.ViewState.Add("VersionNo", dt.Rows(0)("VersionNo"))
                Dim countryID As Integer = Request.QueryString("countryID")
                If (countryID = 1) Then
                    ltrlCountry.Text = "United States"
                ElseIf (countryID = 3) Then
                    ltrlCountry.Text = "Canada"
                End If
            End If
            Dim sumObject As Object
            sumObject = dt.Compute("Sum(StoreCount)", "")
            Dim storeDesc As String = "Store"
            If (sumObject IsNot Nothing AndAlso Not IsDBNull(sumObject)) Then
                If (sumObject > 1) Then
                    storeDesc = "Stores"
                End If
                ltrlUpdateVersionNo.Text = dt.Rows(0)("VersionNo") + " - Available for " + sumObject.ToString() + " " + storeDesc
            Else
                ltrlUpdateVersionNo.Text = CType(Me.ViewState("VersionNo"), String)
            End If

        Else
            ltrlUpdateVersionNo.Text = Request.QueryString("VersionNo").ToString()
            Dim countryID As Integer = Request.QueryString("countryID")
            If (countryID = 1) Then
                ltrlCountry.Text = "United States"
            ElseIf (countryID = 3) Then
                ltrlCountry.Text = "Canada"
            End If
        End If
        gvwUpdateGroups.DataSource = dt
        gvwUpdateGroups.DataBind()
    End Function


    Protected Sub gvwUpdateGroups_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwUpdateGroups.RowDataBound
        Try
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            'e.Row.Attributes.Add("onclick", "this.className='selectedRow';")

            If ((e.Row.RowIndex Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvwUpdateGroups.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvwUpdateGroups.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvwUpdateGroups.PageIndex = 0) Then
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
            If (gvwUpdateGroups.PageIndex = gvwUpdateGroups.PageCount - 1) Then
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
            If (((gvwUpdateGroups.PageIndex + 1) * gvwUpdateGroups.PageSize) < gvwUpdateGroups.PageCount * gvwUpdateGroups.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvwUpdateGroups.PageIndex + 1) * gvwUpdateGroups.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = CType(ViewState("TotalCount"), Integer)
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvwUpdateGroups.PageIndex * gvwUpdateGroups.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = CType(ViewState("TotalCount"), Integer)
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdateGroups_RowDataBound", String.Empty, String.Empty, String.Empty)
        End Try

    End Sub

    Protected Sub gvwUpdateGroups_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvwUpdateGroups.RowCommand
        Try
            If e.CommandName = "DeleteGroup" Then
                ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "event.cancelBubble=true; DeleteGroup('" & Convert.ToInt32(e.CommandArgument) & "');", True)
            ElseIf e.CommandName = "EditGroup" Then
                ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "event.cancelBubble=true; ShowNewGroupDiv_Grid('" & Convert.ToInt32(e.CommandArgument) & "');", True)
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdateGroups_RowCommand", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    <WebMethod()> _
    Public Shared Function DeleteGroupByID(ByVal countryID As Integer, ByVal groupID As Integer, ByVal updateID As Integer) As Boolean
        Try
            Dim rowsAffected As Integer = 0
            rowsAffected = Portal.BLL.UpdateManagement.DeleteGroupByID(updateID, groupID, countryID)
            If rowsAffected > 0 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "DeleteGroupByID", String.Empty, String.Empty, String.Empty)
        End Try
    End Function



    Protected Sub gvwUpdateGroups_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwUpdateGroups.RowCreated
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
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdateGroups_RowCreated", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    Protected Sub gvwUpdateGroups_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvwUpdateGroups.Sorting
        Try


            Dim dt As DataTable = CType(Me.ViewState("dt"), DataTable)
            dt.DefaultView.Sort = e.SortExpression & " " & GetSortDirection(e.SortExpression)
            BindGridData(False)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdateGroups_Sorting", String.Empty, String.Empty, String.Empty)
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
        Dim countryID As Integer = Request.QueryString("countryID")
        Dim updateID As Integer = Request.QueryString("updateID")
        dt = Portal.BLL.UpdateManagement.GetUpdateGroupsByUpdateID(countryID, updateID)
        Me.ViewState.Add("dt", dt)

        

        Dim dtFiltered As DataTable = New DataTable

        dtFiltered.Columns.Add("ID", GetType(Int32))
        dtFiltered.Columns.Add("Title", GetType(String))
        dtFiltered.Columns.Add("Name", GetType(String))
        dtFiltered.Columns.Add("StatusID", GetType(Integer))
        dtFiltered.Columns.Add("StatusName", GetType(String))
        dtFiltered.Columns.Add("StoreCount", GetType(Integer))

        dtFiltered.Columns.Add("VersionNo", GetType(String))
        dtFiltered.Columns.Add("Threshold", GetType(Integer))
        dtFiltered.Columns.Add("UpdateMandatoryDate", GetType(String))
        dtFiltered.Columns.Add("IsMandatory", GetType(String))


        Dim foundRows As DataRow()
        If (ddlStatus.SelectedValue = -1) Then
            foundRows = dt.Select("Title like ('%" + txtSearch.Text + "%') OR Name like ('%" + txtSearch.Text + "%')")
        Else
            foundRows = dt.Select("StatusID = " + ddlStatus.SelectedValue.ToString() + "AND (Title like ('%" + txtSearch.Text + "%') OR Name like ('%" + txtSearch.Text + "%'))")
        End If
        dt.Select("StatusID = " + ddlStatus.SelectedValue.ToString())


        For Each dr As DataRow In foundRows
            dtFiltered.ImportRow(dr)
        Next
            Me.ViewState.Add("dt", dtFiltered)
            BindGridData(False)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "btnSearch_Click", String.Empty, String.Empty, String.Empty)
        End Try


    End Sub

    Protected Sub gvwUpdateGroups_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvwUpdateGroups.PageIndexChanging
        Try
            gvwUpdateGroups.PageIndex = e.NewPageIndex
            BindGridData(False)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "gvwUpdateGroups_PageIndexChanging", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub
End Class