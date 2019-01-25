
Imports System.Data

Partial Class PM_MyReportDetail
    Inherits System.Web.UI.Page
    Protected ID As Integer
    Dim dt As DataTable
    Dim dta As DataTable

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        'If Not IsPostBack Then
        '    Dim dtt As DataTable = Portal.BLL.PM.PM_Ticket_Features.GeTReportPMName(CType(HttpContext.Current.Session("AdminID"), Integer), CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String))
        '    ticketGrid.DataSource = dtt
        '    ticketGrid.DataBind()
        'End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        UserId.Value=HttpContext.Current.Session("AdminID")

        ID = CType(Request.QueryString("ID"), Integer)
        If Not IsPostBack Then
            Dim QS = Request.QueryString("ID")
            ReportName.Text = Request.QueryString("Name")

            If ID = 0 Then
                dt = CType(Session("dtCart"), DataTable)
                Session("dtCart") = Nothing
                btnReport.Attributes.CssStyle.Add("display", "none")
                btnShareReport.Attributes.CssStyle.Add("display", "none")
                btnExport.Attributes.CssStyle.Add("display", "none")
            Else
                dt = Portal.BLL.PM.PM_Ticket_Features.GetReportById(ID)
            End If
            Dim key As Integer = CType(Request.QueryString("key"), Integer)
            If key = 1 Then
                'btnReport.Attributes.CssStyle.Add("display", "inline")
                ' btnShareReport.Attributes.CssStyle.Add("display", "inline")
                btnExport.Attributes.CssStyle.Add("display", "inline")
            End If
            'loader.Attributes.CssStyle.Add("Display", "inline")
            iddd.Value = ID
            lblTotalRecord.Text = dt.Rows.Count
            Dim x As Integer = dt.Rows.Count
            If x < 1 Then
                DivTicketFlagRemove.Attributes.CssStyle.Add("display", "block")
            End If
            gvwMyTickets.DataSource = dt
            gvwMyTickets.DataBind()
        End If
        If Not IsPostBack Then
            BindGrid()
        End If
        'loader.Attributes.CssStyle.Add("Display", "none")
    End Sub


    Private Sub BindGrid()
        Dim dtt As DataTable = Portal.BLL.PM.PM_Ticket_Features.GetPMName(CType(HttpContext.Current.Session("AdminID"), Integer), CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String), 1)
        ticketGrid.DataSource = dtt
        ticketGrid.DataBind()
    End Sub
    Protected Sub gvwMyTickets_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        '        If (e.Row.RowType == DataControlRowType.Header) Then

        '{

        'e.Row.Cells[0].Width = New Unit("300px");

        'e.Row.Cells[1].Width = New Unit("250px");

        '}

    End Sub
    Protected Sub btnShareReport_Click(sender As Object, e As EventArgs)

        DivTicketDetail.Attributes.CssStyle.Add("display", "block")

    End Sub
    Protected Sub TxtSearch_TextChanged(sender As Object, e As EventArgs)
        dta = Portal.BLL.PM.PM_Ticket_Features.GetPMName(CType(HttpContext.Current.Session("AdminID"), Integer), CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String), 1)
        Dim dv As New DataView(dta)
        dv.RowFilter = "Name like('%" & TxtSearch.Text & "%')"
        ticketGrid.DataSource = dv.ToTable()
        ticketGrid.DataBind()

    End Sub
    Protected Sub btnSaveTicket_Click(sender As Object, e As EventArgs)
        Dim ReportID As String
        ReportID = ID
        Dim UserID As String
        For Each Row As GridViewRow In ticketGrid.Rows
            Dim Check As CheckBox = CType(Row.FindControl("checkTicket"), CheckBox)
            If Check.Checked Then

                Dim UID = CType(Row.FindControl("UserID"), HiddenField).Value
                If String.IsNullOrEmpty(UserID) Then
                    UserID = UID
                Else
                    UserID = UserID & "," & UID
                End If
            End If
        Next
        If Not String.IsNullOrEmpty(UserID) Then
            Portal.BLL.PM.PM_Ticket_Features.ShareReport(ReportID, UserID)
            DivTicketDetail.Attributes.CssStyle.Add("display", "none")
            SucessShare.Attributes.CssStyle.Add("display", "inline")
        End If

    End Sub
    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        Response.Redirect("MyPMReports.aspx")
    End Sub
    Protected Sub btnReport_Click(sender As Object, e As EventArgs)
        Response.Redirect("EditReport.aspx?ID=" & ID)
    End Sub

    Protected Sub ticketGrid_OnPageIndexChanging(sender As Object, e As GridViewPageEventArgs)
        ticketGrid.PageIndex = e.NewPageIndex
        Me.BindGrid()
        'Dim pageNumber As Integer = e.NewPageIndex
        'BindGrid()
        'Dim userId = CType(HttpContext.Current.Session("AdminID"), Integer)
        'dt = Portal.BLL.PM.PM_Ticket_Features.GetMyReport(userId)
        'gvwMyTickets.DataSource = dt
        'gvwMyTickets.DataBind()
        'Dim dtt As DataTable = Portal.BLL.PM.PM_Ticket_Features.GetPMName(CType(HttpContext.Current.Session("AdminID"), Integer), CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String), pageNumber + 1)
        'ticketGrid.DataSource = dtt
        '    ticketGrid.DataBind()

    End Sub
End Class
