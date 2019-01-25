Imports System.Collections.Generic
Partial Class PM_TicketsReport
    Inherits System.Web.UI.Page
    Dim colTickets As New List(Of Portal.BLL.PM.PM_Ticket_Features)()
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If HttpContext.Current.Request.QueryString("TicketID") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("TicketID")) Then
                hdnTicketID.Value = Request.QueryString("TicketID")
                lblPrintDate.Text = "Printed Online On " & System.DateTime.Now.ToShortDateString()
                LoadTicket()
            End If
            hdnTimeSpent.Value = "00:00:00"
        End If
    End Sub
    Private Sub LoadTicket()
        Dim objTicketsBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features()
        colTickets = Portal.BLL.PM.PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(Me.hdnTicketID.Value, Integer))
        Me.lblTicketNo.Text = colTickets.Item(0).ID
        Me.lblTicketName.Text = colTickets.Item(0).Name
        Me.lblType.Text = colTickets.Item(0).TypeName
        Me.lblDateEntered.Text = colTickets.Item(0).DateEntered.ToShortDateString()

        Me.lblUserID.Text = IIf(colTickets.Item(0).UserName = "", colTickets.Item(0).ClientContactName, colTickets.Item(0).UserName)
        Me.lblClient.Text = colTickets.Item(0).ClientName
        Me.lblCategory.Text = colTickets.Item(0).CatagoryName
        Dim str As String = IIf(colTickets.Item(0).Priority = 1, "High", IIf(colTickets.Item(0).Priority = 2, "Normal", IIf(colTickets.Item(0).Priority = 3, "Low", "")))
        Me.lblPriority.Text = str
        If colTickets.Item(0).ReleaseID > 0 Then
            Dim objReleases As Portal.BLL.PM.PM_Releases = New Portal.BLL.PM.PM_Releases()
            Dim colReleases As New List(Of Portal.BLL.PM.PM_Releases)()
            colReleases = Portal.BLL.PM.PM_Releases.PM_ReleasesGetByID(colTickets.Item(0).ReleaseID)
            Me.lblReleaseName.Text = colReleases.Item(0).Name
            Me.lblTicketColumnName.Text = "Feature #"
            Me.tdTitleReport.InnerText = "Feature Report"
        Else
            Me.lblReleaseName.Text = ""
            Me.tdrelease.Attributes.Add("style", "display:none;")
            trrelease.Attributes.Add("style", "display:none;")
            Me.lblTicketColumnName.Text = "Ticket #"
            Me.tdTitleReport.InnerText = "Ticket Report"
        End If
    End Sub

    Protected Sub rptrNotes_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrNotes.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rptrAttachments"), Repeater)
            Dim NotesID As Integer = CType(CType(e.Item.FindControl("lblID"), Label).Text, Integer)
            sdsAttachments.FilterExpression = "[NoteID] = " & NotesID.ToString
            rpt.DataSource = sdsAttachments '"sdsAttachments"
            rpt.DataBind()
            If rpt.Items.Count <= 0 Then
                rpt.Visible = False
            End If
            Dim objTimeSpent As TimeSpan = TimeSpan.Parse(CType(CType(e.Item.FindControl("lblTimeSpent"), Label).Text, String)).Add(TimeSpan.Parse(hdnTimeSpent.Value))
            hdnTimeSpent.Value = objTimeSpent.ToString()
            Dim strHours As String = ""
            Dim strMin As String = ""
            If CType(objTimeSpent.TotalHours, Integer) < 10 Then
                strHours = "0" & CType(objTimeSpent.TotalHours, Integer).ToString()
            Else
                strHours = CType(objTimeSpent.TotalHours, Integer).ToString()
            End If
            If CType(objTimeSpent.Minutes, Integer) < 10 Then
                strMin = "0" & CType(objTimeSpent.Minutes, Integer).ToString()
            Else
                strMin = CType(objTimeSpent.Minutes, Integer).ToString()
            End If

            lblTotalTimeSpent.Text = strHours & ":" & strMin
        End If
    End Sub
    Protected Sub rptrTicket_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrTicket.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rptrTicketAttachments"), Repeater)
            SDS_TicketsAttachments.FilterExpression = "[Ticket_FeatureID] = " & Me.hdnTicketID.Value
            rpt.DataSourceID = "SDS_TicketsAttachments"
            rpt.DataBind()
            If rpt.Items.Count <= 0 Then
                rpt.Visible = False
            End If
        End If
    End Sub
End Class
