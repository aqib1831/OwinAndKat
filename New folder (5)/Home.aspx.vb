Imports Portal.BLL.Enumeration
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Partial Class Admin_Home
    Inherits System.Web.UI.Page
    Protected intStoreCount As Integer = 0
    Protected intTotalActivities As Integer = 0
    Protected intTotalTickets As Integer = 0
    Protected intTicketCount As Integer = 0
    Protected intActivityCount As Integer = 0
    Protected ComingSoon As Integer = 0
    Protected intTotalStores As Integer = 0
    Protected SelectedIndex As Integer = 0
    Protected Operating As Integer = 0
    Protected ClientChanged As Boolean = False
    Dim objFunctions As New List(Of Functions)()

    Private AdminID As Integer = 0

    Private Property dataSource() As DataTable
        Get
            Return CType(ViewState("dataSource"), DataTable)
        End Get
        Set(ByVal value As DataTable)
            ViewState("dataSource") = value
        End Set
    End Property

    Protected Sub Home_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.Home

        If Not IsPostBack Then
            ddlClient.DataBind()
            '    Me.BindClientState()
            BindActivityOption()
            'By Default Selecting Show All Clients 
            ddlClient.SelectedValue = "0"
            'if Selected Client is show All then hide News
            'TR_News.Visible = True
            'rptrNews.Visible = True
            'tblForRptNoNews.Visible = False
            'rptrNews.DataSourceID = sdsNews.ID
            'rptrNews.DataBind()

            'By Default Selecting My Activities
            ddlActivitiesSource.SelectedIndex = "1"

            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                ddlClient.SelectedValue = Request.QueryString("ClientID").ToString()
            End If
            ddlClient.Attributes.Add("onchange", "javascript:DisableDropDown();")
            Me.ChangeClient(CInt(ddlClient.SelectedValue))
            'If ddlClient.Items.Count = 1 AndAlso ddlClient.SelectedValue = 5 Then
            '    trStoreStats.Visible = False
            'End If
        End If
    End Sub

    Protected Sub rptrTickets_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrTickets.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            intTicketCount = 0
            'lblTicketCount.Text = intTicketCount
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            intTicketCount += 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If intTicketCount > 0 Then
                'lblTicketCount.Text = intTicketCount
                CType(e.Item.FindControl("trTickets_NoRecord"), HtmlTableRow).Visible = False
            Else
                CType(e.Item.FindControl("trTickets_NoRecord"), HtmlTableRow).Visible = True
            End If
        End If
    End Sub

    Protected Sub rptMyActivities_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptMyActivities.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            intActivityCount = 0
            lblActivities.Text = intActivityCount
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            intActivityCount += 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If intActivityCount > 0 Then
                lblActivities.Text = intActivityCount
                CType(e.Item.FindControl("trMyActivities_NoRecord"), HtmlTableRow).Visible = False
            Else
                CType(e.Item.FindControl("trMyActivities_NoRecord"), HtmlTableRow).Visible = True
            End If
        End If
    End Sub

    Protected Sub MenuSortActivities_MenuItemClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.MenuEventArgs) Handles MenuSortActivities.MenuItemClick
        lblSortBy.Text = e.Item.Text
        odsMyActivities.SelectParameters("SortExpression").DefaultValue = e.Item.Value
        odsMyActivities.SortParameterName = ""
        Me.ChangeClient(CInt(IIf(ddlClient.SelectedValue = "0", "1", ddlClient.SelectedValue)))
    End Sub

    Protected Sub rptStores_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptStores.ItemDataBound
        If e.Item.ItemType = ListItemType.Header Then
            intStoreCount = 0
            lblStores.Text = "0"
        ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            intStoreCount += 1
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If intStoreCount > 0 Then
                lblStores.Text = intStoreCount
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = False
            Else
                CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = True
            End If
        End If
    End Sub

    Protected Sub ddlStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStates.DataBound
        ddlStates.Items.Insert(0, New ListItem("Show All", "0"))
        ddlStates.SelectedIndex = SelectedIndex
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub

    Protected Sub ddlClient_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.SelectedIndexChanged
        'Me.BindStoreState(CInt(IIf(ddlClient.SelectedValue = "0", "1", ddlClient.SelectedValue)))
        Me.ChangeClient(CInt(ddlClient.SelectedValue))
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateMessageScript", "EnableDropDown();", True)
    End Sub

    Protected Sub ChangeClient(ByVal ClientID As Integer)

        'Dim isAllow As Boolean = False
        'Dim colModules As New System.Collections.Generic.List(Of Portal.BLL.Modules)()
        'colModules = Portal.BLL.Modules.ModulesGetByUserID(CType(Session("AdminID"), Integer))
        'If colModules.Count > 0 Then
        '    Dim i As Integer
        '    For i = 0 To colModules.Count - 1
        '        If CInt(colModules.Item(i).ID.ToString()) = Portal.BLL.Enumeration.Modules.Communication Then
        '            isAllow = True
        '            Exit For
        '        End If
        '    Next
        'End If
    End Sub

    'Protected Sub BindStoreState(ByVal ClientID As Integer)
    '    If ClientID <> Portal.BLL.Enumeration.ClientID.EA AndAlso ClientID <> Portal.BLL.Enumeration.ClientID.Frutation Then
    '        trStoreStats.Visible = False
    '    Else
    '        trStoreStats.Visible = True
    '        objFunctions = Functions.GetStoreStats(ClientID)
    '        'lblOpeningSoon.Text = objFunctions.Item(0).ComingSoon.ToString()
    '        'lblOperatingStores.Text = objFunctions.Item(0).Operating.ToString()
    '        'lblTotalStores.Text = (objFunctions.Item(0).ComingSoon + objFunctions.Item(0).Operating).ToString()
    '    End If
    'End Sub

    'Protected Sub BindClientState()
    '    trStoreStats.Visible = True
    '    objFunctions = Functions.GetClientStats()
    '    rptrClientState.DataSource = objFunctions
    '    rptrClientState.DataBind()

    'End Sub

    Protected Sub BindActivityOption()
        If (ddlActivitiesSource IsNot Nothing) Then
            ddlActivitiesSource.Items.Insert(1, New ListItem("My Activities", "A" & CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID))
            odsMyActivities.SelectParameters("WaitingFor").DefaultValue = "A" & CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID
        End If
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        Me.ChangeClient(CInt(ddlClient.SelectedValue))
    End Sub
    Protected Sub lnkResetFilters_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkResetFilters.Click
        Me.ChangeClient(CInt(ddlClient.SelectedValue))
    End Sub

    'Protected Sub rptrClientState_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrClientState.ItemDataBound
    '    If e.Item.ItemType = ListItemType.Header Then
    '        intTotalActivities = 0
    '        intTotalTickets = 0
    '        intTotalStores = 0
    '        intStoreCount = 0
    '    ElseIf e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
    '        intTotalActivities += CType(DataBinder.Eval(e.Item.DataItem, "OpenActivities"), Integer)
    '        intTotalStores += CType(DataBinder.Eval(e.Item.DataItem, "TotalStores"), Integer)
    '        intTotalTickets += CType(DataBinder.Eval(e.Item.DataItem, "OpenTicket"), Integer)
    '        intStoreCount += 1
    '    ElseIf e.Item.ItemType = ListItemType.Footer Then
    '        CType(e.Item.FindControl("lblActivityTotal"), Label).Text = intTotalActivities
    '        CType(e.Item.FindControl("lblTicketTotal"), Label).Text = intTotalTickets
    '        CType(e.Item.FindControl("lblStoreTotal"), Label).Text = intTotalStores
    '        If intStoreCount > 0 Then
    '            lblStores.Text = intStoreCount
    '            CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = False
    '        Else
    '            CType(e.Item.FindControl("trStores_NoRecord"), HtmlTableRow).Visible = True
    '        End If
    '        intStoreCount = 0
    '    End If
    'End Sub
    'Protected Sub rptrNews_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrNews.ItemDataBound
    '    If e.Item.ItemType = ListItemType.Header Then
    '    ElseIf e.Item.ItemType = ListItemType.Footer Then
    '        If rptrNews.Items.Count > 0 Then
    '            'lblTicketCount.Text = intTicketCount
    '            CType(e.Item.FindControl("trTickets_NoRecord"), HtmlTableRow).Visible = False
    '        Else
    '            CType(e.Item.FindControl("trTickets_NoRecord"), HtmlTableRow).Visible = True
    '        End If
    '    End If
    'End Sub
    
    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        Dim startDate As DateTime = New DateTime(DateTime.Now.Year - 5, 1, 1).ToShortDateString()
        Dim endDate As DateTime = DateTime.Now.ToShortDateString()
        Dim TotalRows As Integer

        Dim objDBPM_Ticket_Features As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
        TotalRows = objDBPM_Ticket_Features.PM_MYTicketGetAllCount(ddlClient.SelectedValue, 0, 0, 0, Session("AdminID"), "", startDate, endDate)
        lblTicketCount.Text = TotalRows

        If TotalRows > 15 Then
            trViewMore.Style.Add("display", "inline")
        Else
            trViewMore.Style.Add("display", "none")
        End If
    End Sub
End Class