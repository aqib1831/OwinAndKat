							 												  																	 Imports System.Collections.Generic
Imports Telerik.Charting
Imports Telerik.WebControls
Partial Class com_TechnicianReport
    Inherits System.Web.UI.Page

    Dim greatTotal As Integer = 0
    Dim okeyTotal As Integer = 0
    Dim notHappyTotal As Integer = 0
    Dim noFeedbackTotal As Integer = 0
    Dim totalsTotal As Integer = 0
    Dim noFeedBackPercentage As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''System.Diagnostics.Debugger.Launch()
        If Not IsPostBack Then
            ResetFilters()
        End If

    End Sub
    Protected Sub ResetFilters()
        Dim dateTo As New DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day)
        Dim dateFrom As DateTime = dateTo.AddMonths(-1)
        txtDateFrom.Text = dateFrom.ToShortDateString()
        txtDateTo.Text = dateTo.ToShortDateString()
        txtDateFrom.Attributes.Add("init", dateFrom.ToShortDateString())
        txtDateTo.Attributes.Add("init", dateTo.ToShortDateString())
    End Sub

    'Protected Sub gvSurveryReport_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvSurveryReport.DataBound
    '    DisplayTotalData()
    '    DisplayChart()
    'End Sub
    Protected ReadOnly Property GetGreatTotal() As Integer
        Get
            Return greatTotal
        End Get
    End Property
    Protected ReadOnly Property GetOkayTotal() As Integer
        Get
            Return okeyTotal
        End Get
    End Property
    Protected ReadOnly Property GetNotHappyTotal() As Integer
        Get
            Return notHappyTotal
        End Get
    End Property
    Protected ReadOnly Property GetTotalsTotal() As Integer
        Get
            Return totalsTotal
        End Get
    End Property
    Protected Sub DisplayTotalData()
        ''Display Total figures
        lblGreatTotal.Text = greatTotal.ToString()
        lblOkeyTotal.Text = okeyTotal.ToString()
        lblNotHappytotal.Text = notHappyTotal.ToString()
        lblNoFeedback.Text = noFeedbackTotal.ToString()


        Dim greatPercent As Decimal = 0D
        Dim okeyPercent As Decimal = 0D
        Dim notHappyPercent As Decimal = 0D
        Dim noFeedbackPercent As Decimal = 0D

        ''Calculate and Display Percentages
        If (Not totalsTotal = 0) Then       ''to avoid division by zero
            greatPercent = FormatNumber((CType(greatTotal, Decimal) / totalsTotal) * 100, 0)
            okeyPercent = FormatNumber((CType(okeyTotal, Decimal) / totalsTotal) * 100, 0)
            notHappyPercent = FormatNumber((CType(notHappyTotal, Decimal) / totalsTotal) * 100, 0)
            noFeedbackPercent = FormatNumber((CType(noFeedbackTotal, Decimal) / totalsTotal) * 100, 0)
        End If

        ''Displaying percentages
        lblPrcntGreatTotal.Text = greatPercent & "%"
        lblPrcntOkeyTotal.Text = okeyPercent & "%"
        lblPrcntNotHappyTotal.Text = notHappyPercent & "%"
        lblPrcntNoFeedbackTotal.Text = noFeedbackPercent & "%"
        noFeedBackPercentage = noFeedbackPercent


        ''Total of totals
        lblTotal.Text = greatTotal + okeyTotal + notHappyTotal + noFeedbackTotal


    End Sub
    Protected Sub rptSurveyReport_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptSurveyReport.ItemDataBound

        'System.Diagnostics.Debugger.Launch()
        If (e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem) Then
            greatTotal = greatTotal + Int32.Parse(DataBinder.Eval(e.Item.DataItem, "Great"))
            okeyTotal = okeyTotal + Int32.Parse(DataBinder.Eval(e.Item.DataItem, "Okay"))
            notHappyTotal = notHappyTotal + Int32.Parse(DataBinder.Eval(e.Item.DataItem, "NotHappy"))
            noFeedbackTotal = noFeedbackTotal + Int32.Parse(DataBinder.Eval(e.Item.DataItem, "NoFeedback"))
            totalsTotal = greatTotal + okeyTotal + notHappyTotal + noFeedbackTotal
        ElseIf (e.Item.ItemType = ListItemType.Footer) Then
            lblGreatFooter.Text = greatTotal.ToString()
            lblOkeyFooter.Text = okeyTotal.ToString()
            lblNotHappyFooter.Text = notHappyTotal.ToString()
            lblTotalFooter.Text = totalsTotal.ToString()
            If (rptSurveyReport.Items.Count = 0) Then
                CType(e.Item.FindControl("trFakeRow"), HtmlTableRow).Visible = True
            Else
                CType(e.Item.FindControl("trFakeRow"), HtmlTableRow).Visible = True
            End If

        End If
    End Sub

    Protected Sub rptSurveyReport_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptSurveyReport.PreRender
        DisplayTotalData()
    End Sub
End Class



