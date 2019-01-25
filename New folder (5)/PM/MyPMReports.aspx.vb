
Imports System.Collections.Generic
Imports System.Data
Imports System.Web.UI.MobileControls

Partial Class PM_MyPMReports
    Inherits System.Web.UI.Page
    Dim dt As DataTable
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        'Dim ProjectManagerDataTable As DataTable = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String))
        'Dim dt As DataTable = Portal.BLL.PM.PM_Ticket_Features.GetPMName(CType(HttpContext.Current.Session("AdminID"), Integer), CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String))
        'ticketGrid.DataSource = dt
        'ticketGrid.DataBind()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim userId = CType(HttpContext.Current.Session("AdminID"), Integer)
        dt = Portal.BLL.PM.PM_Ticket_Features.GetMyReport(userId)
        gvwMyTickets.DataSource = dt
        gvwMyTickets.DataBind()
        If Not IsPostBack Then
            BindGrid()
        End If
    End Sub

    Private Sub BindGrid()
        Dim dtt As DataTable = Portal.BLL.PM.PM_Ticket_Features.GetPMName(CType(HttpContext.Current.Session("AdminID"), Integer), CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String), 1)
        ticketGrid.DataSource = dtt
        ticketGrid.DataBind()
    End Sub

    Protected Sub btnReport_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/PM/CreateReport.aspx")
    End Sub
    'Protected Sub chkSelectAll_CheckedChanged(sender As Object, e As EventArgs)
    '    Dim yes As Boolean = False
    '    For Each row As GridViewRow In gvwMyTickets.Rows
    '        If DirectCast(row.FindControl("chkSelectAll"), CheckBox).Checked Then
    '            yes = True
    '        End If
    '        If yes = True Then
    '            CType(row.FindControl("chkReport"), CheckBox).Checked = True
    '        End If
    '    Next
    'End Sub

    Protected Sub btnYes_Click(sender As Object, e As EventArgs)
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "myScriptfdfs", "Hello();", True)
        'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "alertMessage", "Hello()", True)
        'If CType(gvwMyTickets.HeaderRow.FindControl("chkSelectAll"), CheckBox).Checked Then
        '    For Each row As GridViewRow In gvwMyTickets.Rows
        '        If String.IsNullOrEmpty(hdnlistofDeleted.Value) Then
        '            hdnlistofDeleted.Value = CType(row.FindControl("reptID"), HiddenField).Value
        '        Else
        '            hdnlistofDeleted.Value = hdnlistofDeleted.Value & "," & CType(row.FindControl("reptID"), HiddenField).Value
        '        End If
        '    Next
        'Else
        '    For Each row As GridViewRow In gvwMyTickets.Rows
        '        If CType(row.FindControl("chkReport"), CheckBox).Checked Then
        '            If String.IsNullOrEmpty(hdnlistofDeleted.Value) Then
        '                hdnlistofDeleted.Value = CType(row.FindControl("reptID"), HiddenField).Value
        '            Else
        '                hdnlistofDeleted.Value = hdnlistofDeleted.Value & "," & CType(row.FindControl("reptID"), HiddenField).Value
        '            End If
        '        End If
        '    Next
        'End If
        Dim ReportID As String = CType(ViewState("ReportID"), String)
        If Not String.IsNullOrEmpty(ReportID) Then
            Dim i As Integer = Portal.BLL.PM.PM_Ticket_Features.DeleteReport(ReportID)
            dt = Portal.BLL.PM.PM_Ticket_Features.GetMyReport(CType(HttpContext.Current.Session("AdminID"), Integer))
            gvwMyTickets.DataSource = dt
            gvwMyTickets.DataBind()
            DivTicketFlagRemove.Attributes.CssStyle.Add("display", "none")
            del.Attributes.CssStyle.Add("display", "block")



        End If



    End Sub
    Protected Sub gvwMyTickets_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim x As Integer = CType(DataBinder.Eval(e.Row.DataItem, "SharedID"), Integer)
            Dim ID As Integer
            Dim hdn As HiddenField = CType(e.Row.FindControl("reptID"), HiddenField)

            If x = -1 Then
                ID = DataBinder.Eval(e.Row.DataItem, "ID")
                hdn.Value = DataBinder.Eval(e.Row.DataItem, "ID")
            Else
                ID = DataBinder.Eval(e.Row.DataItem, "SharedID")
                hdn.Value = DataBinder.Eval(e.Row.DataItem, "SharedID")
            End If
            If (CType(DataBinder.Eval(e.Row.DataItem, "ID"), Integer) > 0) Then
                For i As Integer = 1 To e.Row.Cells.Count - 2
                    e.Row.Cells(i).Attributes.Add("onClick", "javascript:window.location='MyReportDetail.aspx?ID=" & ID & "&Name=" & DataBinder.Eval(e.Row.DataItem, "ReportName").ToString().Replace("'", "%27") & "';")
                Next


            End If
        End If

    End Sub



    Protected Sub btnShare_Click(sender As Object, e As EventArgs)
        Dim ReportID As String
        Dim alLeastOneCheckBox As Boolean = False
        For Each Row As GridViewRow In gvwMyTickets.Rows
            Dim Check As CheckBox = CType(Row.FindControl("chkReport"), CheckBox)
            If Check.Checked Then
                Dim RID = CType(Row.FindControl("reptID"), HiddenField).Value
                If String.IsNullOrEmpty(ReportID) Then
                    ReportID = RID
                Else
                    ReportID = ReportID & "," & RID
                End If
                alLeastOneCheckBox = True

            End If


        Next
        If alLeastOneCheckBox Then
            ViewState("ReportID") = ReportID
            Dim s As Integer = 1
            For Each Row As GridViewRow In gvwMyTickets.Rows

                'Row.Cells(s).Attributes.Add("onClick", "")
                Dim Check As CheckBox = CType(Row.FindControl("chkReport"), CheckBox)
                Dim link As LinkButton = CType(Row.FindControl("lbltest"), LinkButton)
                link.Enabled = False

                Check.Enabled = False
                s = s + 1

                For i As Integer = 1 To Row.Cells.Count - 1
                    Row.Cells(i).Attributes.Remove("onclick")
                Next

            Next
            Dim checkbox As CheckBox = CType(gvwMyTickets.HeaderRow.FindControl("chkSelectAll"), CheckBox)
            checkbox.Enabled = False
            DivTicketDetail.Attributes.CssStyle.Add("display", "block")
       Else 
           ErrorShare.Attributes.CssStyle.Add("display","block")

        End If


    End Sub
    Protected Sub btnSaveTicket_Click(sender As Object, e As EventArgs)
        Dim ReportID As String
        Dim UserID As String
        ReportID = CType(ViewState("ReportID"), String)
        ViewState("ReportID") = Nothing
        'For Each Row As GridViewRow In gvwMyTickets.Rows
        '    Dim Check As CheckBox = CType(Row.FindControl("chkReport"), CheckBox)
        '    If Check.Checked Then

        '        Dim RID = CType(Row.FindControl("reptID"), HiddenField).Value
        '        If String.IsNullOrEmpty(ReportID) Then
        '            ReportID = RID
        '        Else
        '            ReportID = ReportID & "," & RID
        '        End If
        '    End If


        'Next

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
        If Not String.IsNullOrEmpty(UserID) And Not String.IsNullOrEmpty(ReportID) Then
            Portal.BLL.PM.PM_Ticket_Features.ShareReport(ReportID, UserID)
            DivTicketDetail.Attributes.CssStyle.Add("display", "none")
            SucessShare.Attributes.CssStyle.Add("display", "inline")
        Else
            'Validation.Value = 1
            'Page.ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "ColoumnValid();", True)
            'PleaseSelect.Attributes.CssStyle.Add("display", "inline")
        End If

    End Sub
    Protected Sub TxtSearch_TextChanged(sender As Object, e As EventArgs)
        dt = Portal.BLL.PM.PM_Ticket_Features.GetPMName(CType(HttpContext.Current.Session("AdminID"), Integer), CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String), 1)
        Dim dv As New DataView(dt)
        dv.RowFilter = "Name like('%" & TxtSearch.Text & "%')"
        ticketGrid.DataSource = dv.ToTable()
        ticketGrid.DataBind()
        'Page.SetFocus(TxtSearch)
        'TxtSearch.Text = TxtSearch.Text
        'ScriptManager.GetCurrent(Me.Page).SetFocus(Me.TxtSearch)




    End Sub
    Protected Sub gvwMyTickets_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Action" Then
            Dim ID As String = e.CommandArgument.ToString()
            Response.Redirect("EditReport.aspx?ID=" & ID)
        End If
    End Sub
    Protected Sub Button1_Click1(sender As Object, e As EventArgs)
        Response.Redirect("MyPMReports.aspx")
    End Sub

    Protected Sub btnDelete_Click(sender As Object, e As EventArgs)
        Dim ReportID As String
        Dim alLeastOneCheckBox As Boolean = False
        For Each Row As GridViewRow In gvwMyTickets.Rows
            Dim Check As CheckBox = CType(Row.FindControl("chkReport"), CheckBox)
            If Check.Checked Then
                Dim RID = CType(Row.FindControl("reptID"), HiddenField).Value
                If String.IsNullOrEmpty(ReportID) Then
                    ReportID = RID
                Else
                    ReportID = ReportID & "," & RID
                End If
                alLeastOneCheckBox = True

            End If


        Next
        If alLeastOneCheckBox Then
            ViewState("ReportID") = ReportID
            Dim s As Integer = 1
            For Each Row As GridViewRow In gvwMyTickets.Rows
                Dim Check As CheckBox = CType(Row.FindControl("chkReport"), CheckBox)
                Dim link As LinkButton = CType(Row.FindControl("lbltest"), LinkButton)
                link.Enabled = False

                Check.Enabled = False
                s = s + 1

                For i As Integer = 1 To Row.Cells.Count - 1
                    Row.Cells(i).Attributes.Remove("onclick")
                Next

            Next
            Dim checkbox As CheckBox = CType(gvwMyTickets.HeaderRow.FindControl("chkSelectAll"), CheckBox)
            checkbox.Enabled = False
            DivTicketFlagRemove.Attributes.CssStyle.Add("display", "block")


        End If

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
