Partial Class LM_SMSLicenseManagement
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            FilterChecks()
            ddlClient.DataBind()
            If (Request.QueryString("ddlClient") <> Nothing) Then ddlClient.SelectedValue = Request.QueryString("ddlClient")
            ddlStores.DataBind()
            If (Request.QueryString("ddlStores") <> Nothing) Then ddlStores.SelectedValue = Request.QueryString("ddlStores")
            ddlFilters.DataBind()
            If (Request.QueryString("ddlFilters") <> Nothing) Then ddlFilters.SelectedValue = Request.QueryString("ddlFilters")

            ClientScript.RegisterClientScriptBlock(Me.GetType, "SelectTab", "parent.SetSelected(2);", True)
        Else
            FilterChecks()
        End If
        hdnProductID.Value = CInt(Portal.BLL.Enumeration.NSProductIDs.SMS)
    End Sub

    Protected Sub ddlStores_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStores.DataBound
        ddlStores.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub gvlicenses_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvlicenses.RowCreated
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            For Each cell As TableCell In e.Row.Cells
                If cell.HasControls Then
                    Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                    If Not (button Is Nothing) Then
                        If gvlicenses.SortExpression = button.CommandArgument Then
                            If gvlicenses.SortDirection = SortDirection.Ascending Then
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

    Protected Sub gvlicenses_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvlicenses.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Attributes.Add("onclick", "this.className='selectedRow'; ShowDetail('" & DataBinder.Eval(e.Row.DataItem, "ID") & "');")

        End If
        If (e.Row.RowType = DataControlRowType.Pager) Then
            'Setting the Current Page and Total Page Count.
            CType(e.Row.FindControl("ltrlStartPage"), Literal).Text = (gvlicenses.PageIndex + 1).ToString()
            CType(e.Row.FindControl("ltrlLastPage"), Literal).Text = gvlicenses.PageCount.ToString()

            Dim imgPage As Image = New Image()
            Dim lnkBtnPage As LinkButton = New LinkButton()

            If (gvlicenses.PageIndex = 0) Then
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
            If (gvlicenses.PageIndex = gvlicenses.PageCount - 1) Then
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
            If (((gvlicenses.PageIndex + 1) * gvlicenses.PageSize) < gvlicenses.PageCount * gvlicenses.PageSize) Then
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = Convert.ToString((gvlicenses.PageIndex + 1) * gvlicenses.PageSize)
            Else
                CType(e.Row.FindControl("ltrlEndCount"), Literal).Text = ltrlRecordCount.Text
            End If
            'Setting the start Count
            CType(e.Row.FindControl("ltrlStartCount"), Literal).Text = Convert.ToString((gvlicenses.PageIndex * gvlicenses.PageSize) + 1)
            'Setting the total Count
            CType(e.Row.FindControl("ltrlTotalCount"), Literal).Text = ltrlRecordCount.Text
        End If
    End Sub

    Protected Sub odsLicenses_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsLicenses.Selected
        If (IsNumeric(e.ReturnValue)) Then
            ltrlRecordCount.Text = e.ReturnValue.ToString
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "showcount", "parent.showsmscount(" & e.ReturnValue.ToString() & ");", True)
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub

    Protected Sub btnRebindGrid_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRebindGrid.Click
        gvlicenses.DataBind()
    End Sub


    'Protected Sub ddlStores_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlStores.ItemsRequested
    '    'ddlStores.DataSource = sdsStoresList.r
    '    'sdsStoresList.DataBind()
    '    ddlStores.Items.Clear()
    '    Dim db As New DBAccess
    '    db.AddParameter("@ClientID", ddlClient.SelectedValue)
    '    db.AddParameter("@Search", e.Text)
    '    ddlStores.DataSource = db.ExecuteReader("FranchiseID_GetByClientID_ForList")
    '    ddlStores.DataBind()
    '    db.Dispose()
    'End Sub

    'Protected Sub sdsStoresList_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sdsStoresList.Selected

    'End Sub

    'Protected Sub sdsStoresList_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsStoresList.Selecting
    '    sdsStoresList.SelectParameters.Item("ClientID").DefaultValue = ddlClient.SelectedValue
    '    sdsStoresList.SelectParameters.Item("Search").DefaultValue = ddlStores.Text
    'End Sub

    'Protected Sub ddlStores_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlStores.SelectedIndexChanged
    '    upKeys.Update()
    '    gvlicenses.DataBind()
    'End Sub
    Function FilterChecks()
        If Functions.IsSuperAdmin(CInt(Session("AdminID"))) Then
            odsLicenses.SelectMethod = "NS_Products_FranchisesGetAllForSMS"
            odsLicenses.SelectCountMethod = "NS_Products_FranchisesGetAllCountForSMS"
            sdsClients.SelectCommand = "Clients_GetALL"
        Else
            odsLicenses.SelectMethod = "NS_Products_FranchisesGetAllForSMS_LM"
            odsLicenses.SelectCountMethod = "NS_Products_FranchisesGetAllCountForSMS_LM"
            If odsLicenses.SelectParameters("UserID") Is Nothing Then
                odsLicenses.SelectParameters.Add("UserID", CInt(Session("AdminID")))
            End If
            If sdsClients.SelectParameters("subModuleIds") Is Nothing Then
                sdsClients.SelectParameters.Add("subModuleIds", Portal.BLL.Enumeration.SubModules.LMFullAccess & "," & Portal.BLL.Enumeration.SubModules.LMReadOnlyAccess)
            End If
        End If
    End Function
End Class