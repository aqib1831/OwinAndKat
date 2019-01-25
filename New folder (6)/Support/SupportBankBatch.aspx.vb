
Partial Class Support_SupportBankBatch
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ClientScript.RegisterClientScriptBlock(Me.GetType, "SelectTab", "parent.SetSelected(7);", True)
            CV_FutureDate.ValueToCompare = DateTime.Now.ToShortDateString()
        End If
    End Sub

    Protected Sub ddlCountry_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCountry.DataBound
        ddlCountry.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlReport_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReport.DataBound
        ddlReport.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub gvSupport_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvSupport.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvSupport.SortExpression = button.CommandArgument Then
                            If gvSupport.SortDirection = SortDirection.Ascending Then
                                hdnsortby.text = gvSupport.SortExpression
                                button.Text += " &nbsp;<img src='../images/asc.gif' title='Sort ascending' style='vertical-align:middle; border:0;'  />"
                            Else
                                hdnsortby.text = gvSupport.SortExpression & " DESC"
                                button.Text += " &nbsp;<img src='../images/desc.gif' title='Sort descending' style='vertical-align:middle; border:0;'  />"
                            End If
                        End If
                    End If
                End If
            Next
        End If
    End Sub

    Protected Sub gvSupport_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvSupport.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
          
        End If
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvSupport.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvSupport.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvSupport.PageIndex = 0) Then
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
            If (gvSupport.PageIndex = gvSupport.PageCount - 1) Then
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
            If (((gvSupport.PageIndex + 1) * gvSupport.PageSize) < gvSupport.PageCount * gvSupport.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvSupport.PageIndex + 1) * gvSupport.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvSupport.PageIndex * gvSupport.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If
    End Sub

    Protected Sub odsSupport_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsSupport.Selected
        If (IsNumeric(e.ReturnValue)) Then
            ltrlRecordCount.Text = e.ReturnValue.ToString
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Portal.BLL.NS.NS_Billing_BankBatch.NS_Billing_BankBatchUpdateConfirm(hdnSelectedBatchID.Value, Session("AdminID"))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideNotConfirm", "HideNotConfirm();", True)
        gvSupport.DataBind()
    End Sub
End Class