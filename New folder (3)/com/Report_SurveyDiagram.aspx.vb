Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Collections.Generic
Imports System.Data.SqlClient

Partial Class Com_Report_SurveyDiagram
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Dim TotalRateCount As Integer = 0
    Dim TotalPromptnessCount As Integer = 0
    Dim TotalCourteousnessCount As Integer = 0
    Dim TotalClarityCount As Integer = 0
    Dim TotalKnowledgeableCount As Integer = 0


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(4);</script>")
            txtDateFrom.Text = DateTime.Now.AddMonths(-1).ToShortDateString()
            txtDateTo.Text = DateTime.Now.ToShortDateString()
            ddlClient.DataBind()
        End If

        FillGeneralSetting()
        FillOverAllSummary()
        FillPromptness()
        FillCourteousness()
        FillClarity()
        FillKnowledgeable()
        FillGereralStats()

        visablelabel(rc_OverAllRating)
        visablelabel(rc_Promptness)
        visablelabel(rc_Courteousness)
        visablelabel(rc_Clarity)
        visablelabel(rc_Knowledgeable)

        UP1.Update()
        UP2.Update()

    End Sub
    Private Sub FillGereralStats()
        Dim obj As SqlDataReader = Portal.BLL.Com.com_Activities_Feedback.GetActivityStats(CDate(txtDateFrom.Text.Trim), CDate(txtDateTo.Text.Trim).AddDays(1), ddlClient.SelectedValue)
        If obj.HasRows Then
            While (obj.Read())
                tdTotalCreate.InnerText = obj.Item("Created")
                tdTotalCompleted.InnerText = Functions.IfNull(obj.Item("Completed"), 0)
                tdMostActivePerson.InnerText = Functions.IfNull(obj.Item("MostActiveName"), "")
            End While
            obj.Close()
        End If
    End Sub

    Private Sub FillGeneralSetting()

        '----------------------------
        rc_OverAllRating.Series(0).Items(0).YValue = 0
        rc_OverAllRating.Series(0).Items(0).Label.TextBlock.Text = ""

        rc_OverAllRating.Series(0).Items(1).YValue = 0
        rc_OverAllRating.Series(0).Items(1).Label.TextBlock.Text = ""

        rc_OverAllRating.Series(0).Items(2).YValue = 0
        rc_OverAllRating.Series(0).Items(2).Label.TextBlock.Text = ""

        rc_OverAllRating.Series(0).Items(3).YValue = 0
        rc_OverAllRating.Series(0).Items(3).Label.TextBlock.Text = ""

        rc_OverAllRating.PlotArea.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
        rc_OverAllRating.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_OverAllRating.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_OverAllRating.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_OverAllRating.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_OverAllRating.Appearance.Border.Width = 0
        rc_OverAllRating.PlotArea.Appearance.Border.Width = 0




        'rc_OverAllRating.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        'rc_OverAllRating.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        'rc_OverAllRating.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        'rc_OverAllRating.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        'rc_OverAllRating.ChartTitle.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        'rc_OverAllRating.ChartTitle.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        'rc_OverAllRating.Legend.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        'rc_OverAllRating.Legend.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent


        '----------------------------
        rc_Promptness.Series(0).Items(0).YValue = 0
        rc_Promptness.Series(0).Items(0).Label.TextBlock.Text = ""

        rc_Promptness.Series(0).Items(1).YValue = 0
        rc_Promptness.Series(0).Items(1).Label.TextBlock.Text = ""

        rc_Promptness.Series(0).Items(2).YValue = 0
        rc_Promptness.Series(0).Items(2).Label.TextBlock.Text = ""

        rc_Promptness.Series(0).Items(3).YValue = 0
        rc_Promptness.Series(0).Items(3).Label.TextBlock.Text = ""

        rc_Promptness.PlotArea.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
        rc_Promptness.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Promptness.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Promptness.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Promptness.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Promptness.Appearance.Border.Width = 0
        rc_Promptness.PlotArea.Appearance.Border.Width = 0

        '----------------------------
        rc_Courteousness.Series(0).Items(0).YValue = 0
        rc_Courteousness.Series(0).Items(0).Label.TextBlock.Text = ""

        rc_Courteousness.Series(0).Items(1).YValue = 0
        rc_Courteousness.Series(0).Items(1).Label.TextBlock.Text = ""

        rc_Courteousness.Series(0).Items(2).YValue = 0
        rc_Courteousness.Series(0).Items(2).Label.TextBlock.Text = ""

        rc_Courteousness.Series(0).Items(3).YValue = 0
        rc_Courteousness.Series(0).Items(3).Label.TextBlock.Text = ""

        rc_Courteousness.PlotArea.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
        rc_Courteousness.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Courteousness.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Courteousness.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Courteousness.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Courteousness.Appearance.Border.Width = 0
        rc_Courteousness.PlotArea.Appearance.Border.Width = 0

        '----------------------------
        rc_Clarity.Series(0).Items(0).YValue = 0
        rc_Clarity.Series(0).Items(0).Label.TextBlock.Text = ""

        rc_Clarity.Series(0).Items(1).YValue = 0
        rc_Clarity.Series(0).Items(1).Label.TextBlock.Text = ""

        rc_Clarity.Series(0).Items(2).YValue = 0
        rc_Clarity.Series(0).Items(2).Label.TextBlock.Text = ""

        rc_Clarity.Series(0).Items(3).YValue = 0
        rc_Clarity.Series(0).Items(3).Label.TextBlock.Text = ""

        rc_Clarity.PlotArea.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
        rc_Clarity.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Clarity.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Clarity.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Clarity.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Clarity.Appearance.Border.Width = 0
        rc_Clarity.PlotArea.Appearance.Border.Width = 0

        '----------------------------
        rc_Knowledgeable.Series(0).Items(0).YValue = 0
        rc_Knowledgeable.Series(0).Items(0).Label.TextBlock.Text = ""

        rc_Knowledgeable.Series(0).Items(1).YValue = 0
        rc_Knowledgeable.Series(0).Items(1).Label.TextBlock.Text = ""

        rc_Knowledgeable.Series(0).Items(2).YValue = 0
        rc_Knowledgeable.Series(0).Items(2).Label.TextBlock.Text = ""

        rc_Knowledgeable.Series(0).Items(3).YValue = 0
        rc_Knowledgeable.Series(0).Items(3).Label.TextBlock.Text = ""

        rc_Knowledgeable.PlotArea.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
        rc_Knowledgeable.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Knowledgeable.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Knowledgeable.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        rc_Knowledgeable.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
        rc_Knowledgeable.Appearance.Border.Width = 0
        rc_Knowledgeable.PlotArea.Appearance.Border.Width = 0

    End Sub
    Private Sub VisableLabel(ByVal chart As Telerik.WebControls.RadChart)
        For index As Integer = 0 To chart.Series(0).Items.Count - 1
            If chart.Series(0).Items(index).YValue = CType(0, Double) Then
                chart.Series(0).Items(index).Label.Visible = False
            End If
        Next
    End Sub
    Private Sub LabelAddPercentage(ByVal chart As Telerik.WebControls.RadChart, ByVal total As Double)
        For index As Integer = 0 To chart.Series(0).Items.Count - 1
            If chart.Series(0).Items(index).YValue <> CType(0, Double) Then
                chart.Series(0).Items(index).Label.TextBlock.Text = chart.Series(0).Items(index).Label.TextBlock.Text & " " & FormatPercent((chart.Series(0).Items(index).YValue / total), 1).ToString
            End If
        Next
    End Sub
    Private Sub FillOverAllSummary()
        Dim obj As SqlDataReader = Portal.BLL.Com.com_Activities_Feedback.GetActivityRateByType(1, CDate(txtDateFrom.Text.Trim), CDate(txtDateTo.Text.Trim).AddDays(1), ddlClient.SelectedValue)
        If obj.HasRows Then
            While (obj.Read())
                If obj.Item("Rate") = 1 Then
                    rc_OverAllRating.Series(0).Items(3).YValue = obj.Item("RateCount")
                    rc_OverAllRating.Series(0).Items(3).Label.TextBlock.Text = "" ' Poor
                ElseIf obj.Item("Rate") = 2 Then
                    rc_OverAllRating.Series(0).Items(0).YValue = obj.Item("RateCount")
                    rc_OverAllRating.Series(0).Items(0).Label.TextBlock.Text = "" 'Fair
                ElseIf obj.Item("Rate") = 3 Then
                    rc_OverAllRating.Series(0).Items(1).YValue = obj.Item("RateCount")
                    rc_OverAllRating.Series(0).Items(1).Label.TextBlock.Text = "" 'Good
                ElseIf obj.Item("Rate") = 4 Then
                    rc_OverAllRating.Series(0).Items(2).YValue = obj.Item("RateCount")
                    rc_OverAllRating.Series(0).Items(2).Label.TextBlock.Text = "" 'Excellent
                End If
                TotalRateCount += obj.Item("RateCount")
            End While
            LabelAddPercentage(rc_OverAllRating, TotalRateCount)
            obj.Close()

            'rc_OverAllRating.Series(0).Items(0).Label.Visible = False
            'rc_OverAllRating.Series(0).Items(1).Label.Visible = False
            'rc_OverAllRating.Series(0).Items(2).Label.Visible = False
            'rc_OverAllRating.Series(0).Items(3).Label.Visible = False

            'rc_OverAllRating.Series(0).Items(3).XValue = "1"
            'rc_OverAllRating.Series(0).Items(3).XValue2 = "2"
            'rc_OverAllRating.Series(0).Items(3).YValue = "0.23"
            'rc_OverAllRating.Series(0).Items(3).YValue2 = "10056"
            'rc_OverAllRating.Series(0).Items(3).YValue3 = "5"
            'rc_OverAllRating.Series(0).Items(3).YValue4 = "6"


            'rc_OverAllRating.Series(0).Items(1).XValue = "1"
            'rc_OverAllRating.Series(0).Items(1).XValue2 = "2"
            'rc_OverAllRating.Series(0).Items(1).YValue = "3"
            'rc_OverAllRating.Series(0).Items(1).YValue2 = "4"
            'rc_OverAllRating.Series(0).Items(1).YValue3 = "5"
            'rc_OverAllRating.Series(0).Items(1).YValue4 = "6"


            'rc_OverAllRating.Series(0).Items(0).XValue = "1"
            'rc_OverAllRating.Series(0).Items(0).XValue2 = "2"
            'rc_OverAllRating.Series(0).Items(0).YValue = "3"
            'rc_OverAllRating.Series(0).Items(0).YValue2 = "4"
            'rc_OverAllRating.Series(0).Items(0).YValue3 = "5"
            'rc_OverAllRating.Series(0).Items(0).YValue4 = "6"


            'rc_OverAllRating.Series(0).Items(2).XValue = "1"
            'rc_OverAllRating.Series(0).Items(2).XValue2 = "2"
            'rc_OverAllRating.Series(0).Items(2).YValue = "3"
            'rc_OverAllRating.Series(0).Items(2).YValue2 = "4"
            'rc_OverAllRating.Series(0).Items(2).YValue3 = "5"
            'rc_OverAllRating.Series(0).Items(2).YValue4 = "6"


            'rc_OverAllRating.Legend.Visible = False
            'rc_OverAllRating.PlotArea.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
            'Dim img As System.Drawing.Image = rc_OverAllRating.GetBitmap()
            'rc_OverAllRating.PlotArea.XAxis.AutoScale = False
            'rc_OverAllRating.PlotArea.YAxis.AutoScale = False
            'rc_OverAllRating.PlotArea.YAxis2.AutoScale = False
            'rc_OverAllRating.PlotArea.XAxis.Appearance.Color = Drawing.Color.Red
            'rc_OverAllRating.PlotArea.Appearance.FillStyle.MainColor = Drawing.Color.Transparent
            'rc_OverAllRating.PlotArea.Appearance.FillStyle.SecondColor = Drawing.Color.Red
            'rc_OverAllRating.PlotArea.XAxis.LayoutMode = Telerik.Charting.Styles.ChartAxisLayoutMode.Inside
            'rc_OverAllRating.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
            'rc_OverAllRating.Series. 
            'rc_OverAllRating.Width = "auto"
            'rc_OverAllRating.Height = "auto"

            'rc_OverAllRating.Appearance.Border.Width = 1
            'rc_OverAllRating.Appearance.Dimensions.Height = 170


            'rc_OverAllRating.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
            'rc_OverAllRating.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
            'rc_OverAllRating.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
            'rc_OverAllRating.Appearance.Dimensions.Paddings = New Telerik.Charting.Styles.ChartPaddings(0, 0, 0, 0)

            'rc_OverAllRating.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
            'rc_OverAllRating.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent



            'rc_OverAllRating.PlotArea.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
            'rc_OverAllRating.PlotArea.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
            'rc_OverAllRating.PlotArea.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
            'rc_OverAllRating.PlotArea.Appearance.Dimensions.Paddings = New Telerik.Charting.Styles.ChartPaddings(0, 0, 0, 0)



            'rc_OverAllRating.ChartTitle.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
            'rc_OverAllRating.ChartTitle.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
            'rc_OverAllRating.ChartTitle.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
            'rc_OverAllRating.ChartTitle.Appearance.Dimensions.Paddings = New Telerik.Charting.Styles.ChartPaddings(0, 0, 0, 0)

            'rc_OverAllRating.Legend.Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
            'rc_OverAllRating.Legend.Appearance.FillStyle.MainColor = System.Drawing.Color.Transparent
            'rc_OverAllRating.Legend.Appearance.Dimensions.Margins = New Telerik.Charting.Styles.ChartMargins(0, 0, 0, 0)
            'rc_OverAllRating.Legend.Appearance.Dimensions.Paddings = New Telerik.Charting.Styles.ChartPaddings(0, 0, 0, 0)


            'rc_Promptness.Series(0).Appearance.LineSeriesAppearance.Color = Drawing.Color.Black
            'rc_Promptness.Series(0).Type = Telerik.Charting.ChartSeriesType.Bar
            'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.MainColor = Drawing.Color.Red
            'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.SecondColor = Drawing.Color.Blue
            'rc_Promptness.Series(0).Items(3).Appearance.FillStyle.MainColor = Drawing.Color.Black
            'rc_Promptness.Chart.Series(0).SetItemColor(0, Drawing.Color.Red)
            'rc_Promptness.Chart.Series(0).SetColors(Drawing.Color.Pink)
            'rc_Promptness.Chart.Series(0).SetItemExplode(0, True)
            'rc_Promptness.Chart.Series(0).SetItemExplode(2, True)
            'rc_Promptness.Series(0).Items(0).Label.TextBlock.Text = "asas"
            'rc_Promptness.Series(0).Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
            'rc_Promptness.Series(0).tem(1).ActiveRegion.Attributes .TrimStart.



        End If
    End Sub
    Private Sub FillPromptness()
        Dim obj As SqlDataReader = Portal.BLL.Com.com_Activities_Feedback.GetActivityRateByType(2, CDate(txtDateFrom.Text.Trim), CDate(txtDateTo.Text.Trim).AddDays(1), ddlClient.SelectedValue)
        If obj.HasRows Then
            While (obj.Read())
                If obj.Item("Promptness") = 1 Then
                    rc_Promptness.Series(0).Items(3).YValue = obj.Item("PromptnessCount")
                    rc_Promptness.Series(0).Items(3).Label.TextBlock.Text = "" 'Poor
                ElseIf obj.Item("Promptness") = 2 Then
                    rc_Promptness.Series(0).Items(0).YValue = obj.Item("PromptnessCount")
                    rc_Promptness.Series(0).Items(0).Label.TextBlock.Text = "" 'Fair
                ElseIf obj.Item("Promptness") = 3 Then
                    rc_Promptness.Series(0).Items(1).YValue = obj.Item("PromptnessCount")
                    rc_Promptness.Series(0).Items(1).Label.TextBlock.Text = "" 'Good
                ElseIf obj.Item("Promptness") = 4 Then
                    rc_Promptness.Series(0).Items(2).YValue = obj.Item("PromptnessCount")
                    rc_Promptness.Series(0).Items(2).Label.TextBlock.Text = "" 'Excellent
                End If
                TotalPromptnessCount += obj.Item("PromptnessCount")
            End While
            LabelAddPercentage(rc_Promptness, TotalPromptnessCount)
            obj.Close()
        End If

        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        'rc_Promptness.Chart.Series(0).SetExplodes(True)
        'rc_Promptness.Chart.Series(0).SetColors(Drawing.Color.Transparent)

        'rc_Promptness.Chart.Series(0).SetItemColor(0, Drawing.Color.Red)
        'rc_Promptness.Chart.Series(0).SetItemColor(2, Drawing.Color.Transparent)
        'rc_Promptness.Chart.Series(0).SetItemLabel(0, "dodo")
        'rc_Promptness.Chart.Series(0).SetItemValue(0, 6)

        'rc_Promptness.Chart.Series(0).SetColors(Drawing.Color.Pink)
        'rc_Promptness.Chart.Series(0).SetItemExplode(2, True)
        'rc_Promptness.Chart.Series(0).SetItemExplode(2, True)
        'rc_Promptness.Series(0).Items(0).Label.TextBlock.Text = "asas"
        ''rc_Promptness.Series(0).Items(0).Label.TextBlock.Appearance.FillStyle.MainColor = Drawing.Color.DarkBlue
        'rc_Promptness.Series(0).Items(0).Appearance.Border.Color = Drawing.Color.Yellow
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Image
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.MainColor = Drawing.Color.Yellow
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.SecondColor = Drawing.Color.Violet
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.GammaCorrection = True
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.FillSettings.ImageFlip = Telerik.Charting.Styles.ImageTileModes.FlipXY

        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.FillSettings.BackgroundImage = ""
        'rc_Promptness.Series(0).Appearance.FillStyle.FillType = Telerik.Charting.Styles.FillType.Solid
        'rc_Promptness.Series(0).Items(0).PointAppearance.

        'rc_Promptness.CustomPalettes.Clear()

        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.MainColor = Drawing.Color.Black
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.SecondColor = Drawing.Color.Black
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.GammaCorrection = True
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.FillSettings.GradientAngle = 90
        'rc_Promptness.Series(0).Items(0).Appearance.FillStyle.FillSettings.GradientMode = Telerik.Charting.Styles.GradientFillStyle.Horizontal



    End Sub
    Private Sub FillCourteousness()
        Dim obj As SqlDataReader = Portal.BLL.Com.com_Activities_Feedback.GetActivityRateByType(3, CDate(txtDateFrom.Text.Trim), CDate(txtDateTo.Text.Trim).AddDays(1), ddlClient.SelectedValue)
        If obj.HasRows Then
            While (obj.Read())
                If obj.Item("Courteousness") = 1 Then
                    rc_Courteousness.Series(0).Items(3).YValue = obj.Item("CourteousnessCount")
                    rc_Courteousness.Series(0).Items(3).Label.TextBlock.Text = "" 'Poor
                ElseIf obj.Item("Courteousness") = 2 Then
                    rc_Courteousness.Series(0).Items(0).YValue = obj.Item("CourteousnessCount")
                    rc_Courteousness.Series(0).Items(0).Label.TextBlock.Text = "" 'Fair
                ElseIf obj.Item("Courteousness") = 3 Then
                    rc_Courteousness.Series(0).Items(1).YValue = obj.Item("CourteousnessCount")
                    rc_Courteousness.Series(0).Items(1).Label.TextBlock.Text = "" 'Good
                ElseIf obj.Item("Courteousness") = 4 Then
                    rc_Courteousness.Series(0).Items(2).YValue = obj.Item("CourteousnessCount")
                    rc_Courteousness.Series(0).Items(2).Label.TextBlock.Text = "" 'Excellent
                End If
                TotalCourteousnessCount += obj.Item("CourteousnessCount")
            End While
            LabelAddPercentage(rc_Courteousness, TotalCourteousnessCount)
            obj.Close()
        End If
    End Sub
    Private Sub FillClarity()
        Dim obj As SqlDataReader = Portal.BLL.Com.com_Activities_Feedback.GetActivityRateByType(4, CDate(txtDateFrom.Text.Trim), CDate(txtDateTo.Text.Trim).AddDays(1), ddlClient.SelectedValue)
        If obj.HasRows Then
            While (obj.Read())
                If obj.Item("Clarity") = 1 Then
                    rc_Clarity.Series(0).Items(3).YValue = obj.Item("ClarityCount")
                    rc_Clarity.Series(0).Items(3).Label.TextBlock.Text = "" 'Poor
                ElseIf obj.Item("Clarity") = 2 Then
                    rc_Clarity.Series(0).Items(0).YValue = obj.Item("ClarityCount")
                    rc_Clarity.Series(0).Items(0).Label.TextBlock.Text = "" 'Fair
                ElseIf obj.Item("Clarity") = 3 Then
                    rc_Clarity.Series(0).Items(1).YValue = obj.Item("ClarityCount")
                    rc_Clarity.Series(0).Items(1).Label.TextBlock.Text = "" 'Good
                ElseIf obj.Item("Clarity") = 4 Then
                    rc_Clarity.Series(0).Items(2).YValue = obj.Item("ClarityCount")
                    rc_Clarity.Series(0).Items(2).Label.TextBlock.Text = "" 'Excellent
                End If
                TotalClarityCount += obj.Item("ClarityCount")
            End While
            LabelAddPercentage(rc_Clarity, TotalClarityCount)
            obj.Close()
        End If
    End Sub

    Private Sub FillKnowledgeable()
        Dim obj As SqlDataReader = Portal.BLL.Com.com_Activities_Feedback.GetActivityRateByType(5, CDate(txtDateFrom.Text.Trim), CDate(txtDateTo.Text.Trim).AddDays(1), ddlClient.SelectedValue)
        If obj.HasRows Then
            While (obj.Read())
                If obj.Item("Knowledgeable") = 1 Then
                    rc_Knowledgeable.Series(0).Items(3).YValue = obj.Item("KnowledgeableCount")
                    rc_Knowledgeable.Series(0).Items(3).Label.TextBlock.Text = "" 'Poor
                ElseIf obj.Item("Knowledgeable") = 2 Then
                    rc_Knowledgeable.Series(0).Items(0).YValue = obj.Item("KnowledgeableCount")
                    rc_Knowledgeable.Series(0).Items(0).Label.TextBlock.Text = "" 'Fair
                ElseIf obj.Item("Knowledgeable") = 3 Then
                    rc_Knowledgeable.Series(0).Items(1).YValue = obj.Item("KnowledgeableCount")
                    rc_Knowledgeable.Series(0).Items(1).Label.TextBlock.Text = "" 'Good
                ElseIf obj.Item("Knowledgeable") = 4 Then
                    rc_Knowledgeable.Series(0).Items(2).YValue = obj.Item("KnowledgeableCount")
                    rc_Knowledgeable.Series(0).Items(2).Label.TextBlock.Text = "" 'Excellent
                End If
                TotalKnowledgeableCount += obj.Item("KnowledgeableCount")
            End While
            LabelAddPercentage(rc_Knowledgeable, TotalKnowledgeableCount)
            obj.Close()
        End If
    End Sub

    Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
        ddlClient.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub


End Class
