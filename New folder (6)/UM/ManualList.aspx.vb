Imports System.Data
Partial Class UM_ManualList
    Inherits System.Web.UI.Page
    Dim rowcount As Integer = 0
    Dim isWriteAccess As Boolean = False
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub gvCategories_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            If gvCategories.SortExpression.ToString() = "" Then
                Dim button As LinkButton = DirectCast(e.Row.Cells(2).Controls(0), LinkButton) 'By default grid is sorted on Admin name
                If Not (button Is Nothing) Then
                    'button.Text += " &nbsp;<img src='images/asc.gif' title='Sort descending' style='vertical-align:middle;'  />"
                End If
            Else
                For Each cell As TableCell In e.Row.Cells
                    If cell.HasControls Then
                        Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                        If Not (button Is Nothing) Then
                            If gvCategories.SortExpression = button.CommandArgument Then
                                If gvCategories.SortDirection = SortDirection.Ascending Then
                                    '  button.Text += " &nbsp;<img src='images/asc.gif' title='Sort descending' style='vertical-align:middle;'  />"
                                Else
                                    '  button.Text += " &nbsp;<img src='images/desc.gif' title='Sort ascending' style='vertical-align:middle;'  />"
                                End If
                            End If
                        End If
                    End If
                Next
            End If
        End If
    End Sub

    Protected Sub btnSaveCategory_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveCategory.Click
        Dim objCategory As New Portal.BLL.UM.Category
        Dim returnVal As Integer = 0
        If (hdnCategoryID.Value.Equals("0")) Then
            objCategory.Title = txtTitle.Text.Trim().ToString()
            objCategory.AddedBy = Session("AdminID")
            returnVal = objCategory.Add()
            If (returnVal > 0) Then
                gvCategories.DataBind()
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseCategory", "CloseCategoryDiv();", True)
            Else
                If (returnVal = -1) Then
                    cvCategory.IsValid = False
                End If
            End If
        Else
            If (CInt(hdnCategoryID.Value) > 0) Then
                objCategory.Title = txtTitle.Text.Trim().ToString()
                objCategory.ID = hdnCategoryID.Value.Trim().ToString()
                objCategory.LastUpdatedBy = Session("AdminID")
                returnVal = objCategory.Update()
                If (returnVal > 0) Then
                    gvCategories.DataBind()
                    ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseCategory", "CloseCategoryDiv();", True)
                Else
                    If (returnVal = -1) Then
                        cvCategory.IsValid = False
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub gvCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvCategories.DataBound
        lblCategoriesCount.Text = rowcount
        If ((rowcount Mod 2) <> 0) Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
        End If
    End Sub

    Protected Sub gvCategories_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvCategories.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            rowcount += 1
            Dim lnkEdit As LinkButton = CType(e.Row.FindControl("lnkEdit"), LinkButton)
            Dim ltrl1 As Literal = CType(e.Row.FindControl("ltrl1"), Literal)
            Dim ltrl2 As Literal = CType(e.Row.FindControl("ltrl2"), Literal)
            Dim lnkBtnDelete As LinkButton = CType(e.Row.FindControl("lnkBtnDelete"), LinkButton)
            Dim lnkClientView As LinkButton = CType(e.Row.FindControl("lnkClientView"), LinkButton)
            If Not lnkClientView Is Nothing Then
                Dim ID As String = Functions.EncryptData(e.Row.DataItem("ID"))
                lnkClientView.Attributes.Add("onclick", "javascript:window.open('Client/UMClientMain.aspx?CategoryID=" & ID & "&BackTo=Portal')")
            End If
            If Not lnkEdit Is Nothing AndAlso isWriteAccess Then
                lnkEdit.Attributes.Add("onclick", "event.cancelBubble=true;javascript:EditCategoryDiv(" & e.Row.DataItem("ID") & ",'" & e.Row.DataItem("Title") & "');return false;")
            Else
                lnkEdit.Attributes.Add("style", "display:none")
                lnkBtnDelete.Attributes.Add("style", "display:none")
                ltrl1.Visible = False
                ltrl2.Visible = False

            End If
            Select Case Request.QueryString("UMType")
                Case 1
                    e.Row.Attributes.Add("onclick", "this.className='selectedRow';javascript:window.location='TopicList.aspx?CategoryID=" & e.Row.DataItem("ID") & "&UMType=" & Request.QueryString("UMType") & "';return false;")
                Case 2
                    e.Row.Attributes.Add("onclick", "this.className='selectedRow';javascript:window.location='DocumentList.aspx?CategoryID=" & e.Row.DataItem("ID") & "&UMType=" & Request.QueryString("UMType") & "';return false;")
                Case 3
                    e.Row.Attributes.Add("onclick", "this.className='selectedRow';javascript:window.location='LinksList.aspx?CategoryID=" & e.Row.DataItem("ID") & "&UMType=" & Request.QueryString("UMType") & "';return false;")
                Case 4
                    e.Row.Attributes.Add("onclick", "this.className='selectedRow';javascript:window.location='TopicList.aspx?CategoryID=" & e.Row.DataItem("ID") & "&UMType=" & Request.QueryString("UMType") & "';return false;")
            End Select
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        rowcount = 0
        isWriteAccess = Functions.CheckSubModuleAccess(Portal.BLL.Enumeration.SubModules.UMFullAccess)
        If isWriteAccess = False Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "hide", "document.getElementById('btnAddCategory').style.display='none';", True)
        End If
    End Sub

    Protected Sub odsCategories_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsCategories.Selected
        Dim Count As Integer = 0
        If Not e.ReturnValue Is Nothing Then
            Dim ds As DataSet = CType(e.ReturnValue, DataSet)
            If (ds.Tables(0).Rows.Count > 0) Then
                Count = CInt(ds.Tables(0).Rows.Count)
                ltrlRecordCount.Text = Count
                Me.lblCategoriesCount.Text = Count

                If ((Count Mod 2) <> 0) Then
                    ClientScript.RegisterStartupScript(Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
                End If
            End If
        End If
    End Sub
End Class
