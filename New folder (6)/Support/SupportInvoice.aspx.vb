Partial Class Support_SupportInvoice
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "MarkAsPaidValidation", "MarkAsPaidValidation();", True)
        txtStartDate.Text = Request(txtStartDate.UniqueID)
        txtEndDate.Text = Request(txtEndDate.UniqueID)
        If Not Page.IsPostBack Then
            ClientScript.RegisterClientScriptBlock(Me.GetType, "SelectTab", "parent.SetSelected(8);", True)
            txtStartDate.Text = Date.Now.AddMonths(-1).ToShortDateString()
            txtEndDate.Text = Date.Now.ToShortDateString

            If Not String.IsNullOrEmpty(Request.QueryString("ClientID")) Then
                ddlClient.DataBind()
                ddlStates.DataBind()
                ddlStatus.DataBind()
                ddlClient.SelectedValue = Request.QueryString("ClientID")
                ddlStates.SelectedValue = Request.QueryString("StateID")
                ddlStatus.SelectedValue = Request.QueryString("StatusID")
                txtStartDate.Text = Request.QueryString("StartDate")
                txtEndDate.Text = Request.QueryString("EndDate")
        End If
        End If
    End Sub

    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlPaymentMethod_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPaymentMethod.DataBound
        ddlPaymentMethod.Items.Insert(0, New ListItem("Select", "0"))
    End Sub

    Protected Sub gvSupport_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvSupport.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton
                    Dim ctrlCount As Integer = cell.Controls.Count
                    If (ctrlCount = 1) Then
                        button = DirectCast(cell.Controls(0), LinkButton)
                    Else
                        button = Nothing
                    End If
                    If Not (button Is Nothing) Then
                        If gvSupport.SortExpression = button.CommandArgument Then
                            If gvSupport.SortDirection = SortDirection.Ascending Then
                                hdnsortby.Text = gvSupport.SortExpression
                                button.Text += " &nbsp;<img src='../images/asc.gif' title='Sort ascending' style='vertical-align:middle; border:0;'  />"
                            Else
                                hdnsortby.Text = gvSupport.SortExpression & " DESC"
                                button.Text += " &nbsp;<img src='../images/desc.gif' title='Sort descending' style='vertical-align:middle; border:0;'  />"
                            End If
                        End If
                    End If
                End If
            Next
        End If
    End Sub

    Protected Sub gvSupport_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvSupport.RowDataBound
        If (e.Row.RowType = DataControlRowType.Header) Then
            CType(e.Row.FindControl("CheckAll"), CheckBox).Attributes.Add("onclick", "CheckAll(this);")
        End If
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            CType(e.Row.FindControl("chkBox"), CheckBox).Attributes.Add("onclick", "SetCheckdStatus(this);")
            e.Row.Cells(1).Attributes.Add("onclick", "Detail(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(2).Attributes.Add("onclick", "Detail(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(3).Attributes.Add("onclick", "Detail(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
            e.Row.Cells(4).Attributes.Add("onclick", "Detail(" & DataBinder.Eval(e.Row.DataItem, "ID") & ");")
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
            If (Request.QueryString("From") = Nothing) Then
                'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showcount", "parent.showcount(" & e.ReturnValue.ToString() & ");", True)
            End If
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If hdnbtnMarkAsPaid.Value = "1" Then
            Portal.BLL.NS.NS_Billing_SupportInvoices.NS_Billing_SupportInvoicesUpdateInvoiceStatus(hdnInvoiceIds.Value, ddlPaymentMethod.SelectedValue, Session("AdminID"))
        Else
        Portal.BLL.NS.NS_Billing_SupportInvoices.NS_Billing_SupportInvoicesUpdateStatus(hdnSelectedInvoiceID.Value, ddlPaymentMethod.SelectedValue, txtQBNumber.Text, Session("AdminID"))
        End If

        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideNotConfirm", "HideNotConfirm();", True)
        gvSupport.DataBind()
    End Sub
End Class