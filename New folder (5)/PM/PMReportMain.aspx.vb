Imports Portal.DAL

Partial Class PM_PMReportMain
    Inherits System.Web.UI.Page
    Public QueryString As String = String.Empty
    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", Portal.BLL.Enumeration.SubModules.PMFullAccess & "," & Portal.BLL.Enumeration.SubModules.PMReadOnlyAccess)
    End Sub
    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        If Not Page.IsPostBack Then
            ddlClients.Items.Insert(0, New ListItem("Select...", 0))
            If Not Request.QueryString("ClientId") Is Nothing Then
                ddlClients.Items.FindByValue(Request.QueryString("ClientId")).Selected = True
            Else
                ddlClients.SelectedValue = 1
            End If
        End If
        
    End Sub
    Protected Sub ddlTeams_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTeams.DataBound
        If Not Page.IsPostBack Then
            ddlTeams.Items.Insert(0, New ListItem("Select...", 0))
            If Not Request.QueryString("TeamId") Is Nothing Then
                ddlTeams.Items.FindByValue(Request.QueryString("TeamId")).Selected = True
            End If
        End If
    End Sub
    Protected Sub ddlCategory_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategory.DataBound
         If ddlCategory.Items.Contains(New ListItem("Select...", 0)) = False Then
            ddlCategory.Items.Insert(0, New ListItem("Select...", 0))
        End If
        If Not Page.IsPostBack Then
            If Not Request.QueryString("CategoryId") Is Nothing Then
                ddlCategory.Items.FindByValue(Request.QueryString("CategoryId")).Selected = True
            End If
        End If
    End Sub
    Protected Sub ddlType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlType.DataBound
        If Not Page.IsPostBack Then
            ddlType.Items.Insert(0, New ListItem("Select...", 0))
            If Not Request.QueryString("Type") Is Nothing Then
                ddlType.Items.FindByValue(Request.QueryString("Type")).Selected = True
            End If
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Request.QueryString("StartDate") Is Nothing Then
                txtDateFrom.Text = CDate(Request.QueryString("StartDate")).ToShortDateString()
                txtDateTo.Text = CDate(Request.QueryString("EndDate")).ToShortDateString()
                hdnStartDate.Value = New DateTime(DateTime.Today.Year, DateTime.Today.Month, 1).ToShortDateString()
                hdnEndDate.Value = DateTime.Now.ToShortDateString()
            Else
                txtDateFrom.Text = New DateTime(DateTime.Today.Year, DateTime.Today.Month, 1).ToShortDateString()
                txtDateTo.Text = DateTime.Now.ToShortDateString()
                hdnStartDate.Value = txtDateFrom.Text
                hdnEndDate.Value = txtDateTo.Text
            End If
            
        End If

    End Sub

    'Protected Sub rptrPMHoursSpent_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrPMHoursSpent.ItemDataBound
    '    If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
    '        '  Ctype(e.Item.FindControl("lblJan"),Label).Text = 
    '        '  Dim t As String = e.Item.DataItem("Team")
    '    End If
    'End Sub
    Protected Function ConvertDBNull(ByVal obj As Object, ByVal ReplaceWith As Object) As Object
        If obj Is DBNull.Value Then
            Return ReplaceWith
        Else
            Return obj
        End If
    End Function
    Protected Sub gvPMStats_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvPMStats.RowCreated
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
            e.Row.Attributes.Add("onclick", "ShowDetail(" + e.Row.DataItem("ID").ToString + ");")
            Dim time As String = "0:00"
            Dim strArray() As String
            If Not e.Row.DataItem("TimeAsString") Is DBNull.Value Then
                strArray = e.Row.DataItem("TimeAsString").ToString.Split(":")
                If strArray(1).Length = 0 Then
                    time = strArray(0) + ":" + "00"
                ElseIf strArray(1).Length = 1 Then
                    time = strArray(0) + ":" + "0" + strArray(1)
                Else
                    time = e.Row.DataItem("TimeAsString")
                End If
            End If
            CType(e.Row.FindControl("lblTimeSpent"), Label).Text = time
        End If
    End Sub

    Protected Sub gvPMStats_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvPMStats.Sorting
        If e.SortDirection = SortDirection.Ascending Then
            hdnSortBy.Value = e.SortExpression
        Else
            hdnSortBy.Value = e.SortExpression + " DESC"
        End If

    End Sub
End Class