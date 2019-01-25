Imports System.Data.SqlClient
Partial Class Case_IP_History
    Inherits System.Web.UI.Page
    Dim totalPages As Integer = 0
    Dim totalRecords As Integer = 0
    Dim blnCaseName As Boolean = False

    Protected Sub gvHistory_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvHistory.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvHistory.SortExpression = button.CommandArgument Then
                            If gvHistory.SortDirection = SortDirection.Ascending Then
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
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvHistory.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If hdnRequestFrom.Value = 1 Then
                e.Row.Attributes.Add("onclick", "parent.RightFrame.location='NewCaseNote.aspx?Source=Case_IP_History&ID=" & e.Row.DataItem("ID") & "&CaseID=" & Request.QueryString("ID") & "';")
            Else
                e.Row.Attributes.Add("onclick", "parent.RightFrame.location='NewActivityNote.aspx?Source=Case_IP_History&ID=" & e.Row.DataItem("ID") & "&IPID=" & Request.QueryString("ID") & "';")
            End If

            If blnCaseName = False Then

            End If

        End If

        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.

            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvHistory.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = totalPages

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvHistory.PageIndex = 0) Then
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
            If (gvHistory.PageIndex = totalPages - 1) Then
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
            If (((gvHistory.PageIndex + 1) * gvHistory.PageSize) < totalPages * gvHistory.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvHistory.PageIndex + 1) * gvHistory.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvHistory.PageIndex * gvHistory.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If
    End Sub

    Protected Sub LegaLCasesDS_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odshistory.Selected
        If IsNumeric(e.ReturnValue) = True Then
            lblCaseCount.Text = e.ReturnValue.ToString
            ltrlRecordCount.Text = e.ReturnValue.ToString
            totalRecords = e.ReturnValue
            totalPages = CInt(Math.Ceiling(e.ReturnValue / gvhistory.PageSize))
            If ((e.ReturnValue Mod 2) <> 0) Then
                ClientScript.RegisterStartupScript(Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtDateFrom.Text = Request(txtDateFrom.UniqueID)
        txtDateTo.Text = Request(txtDateTo.UniqueID)

        If Not IsPostBack Then
            hdnCaseID.Value = Request.QueryString("ID")
            hdnRequestFrom.Value = Request.QueryString("RequestFrom")
            txtDateFrom.Text = Date.Now.AddMonths(-6).ToShortDateString()
            txtDateTo.Text = Date.Now.ToShortDateString()
            If Request.QueryString("RequestFrom") = 1 Then
                Dim caseObj As CaseMgmt = New CaseMgmt()
                Dim dr As SqlDataReader = caseObj.GetSingleCase(Request.QueryString("ID"))
                dr.Read()
                lblCaseName.Text = Functions.StringTruncate(dr.Item("Title"), 30)
                lblCaseName.ToolTip = dr.Item("Title").ToString()
                dr.Close()
            Else
                Dim dr As SqlDataReader = IntellectualProperty.Legal_GetSingleIP(Convert.ToInt32(Request.QueryString("ID")))
                dr.Read()
                lblCaseName.Text = Functions.StringTruncate(dr.Item("Title"), 30)
                lblCaseName.ToolTip = dr.Item("Title").ToString()
                dr.Close()

            End If
            
        End If
    End Sub

    Protected Sub ImgBtnBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImgBtnBack.Click
        If hdnRequestFrom.Value = 1 Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "redirect", "parent.RightFrame.location='Legal_Case_Activities.aspx?" & Request.QueryString().ToString() & "';", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "redirect", "parent.RightFrame.location='Legal_IP_Activities.aspx?" & Request.QueryString().ToString() & "';", True)
        End If

    End Sub
End Class
