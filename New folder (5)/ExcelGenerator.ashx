<%@ WebHandler Language="VB" Class="ExcelGenerator" %>

Imports System
Imports System.Web
Imports System.IO
Imports System.Data
Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System.Data.SqlClient


Public Class ExcelGenerator : Implements IHttpHandler

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        If context.Request.QueryString("Action") = "PMDashboard" Then
            ExportPMDashBoard()
        ElseIf context.Request.QueryString("Action") = "PMDashBoardTickets" Then
            ExportPMDashBoardTickets()
        ElseIf context.Request.QueryString("Action") = "ExportPMTicketsAndFeatures" Then
            ExportPMTicketsAndFeatures()
        ElseIf context.Request.QueryString("Action") = "ExportPMRecentTicketsAndFeatures" Then
            ExportPMRecentTicketsAndFeatures()
        ElseIf context.Request.QueryString("Action") = "ExportPMCurrentReleases" Then
            ExportPMCurrentReleases()
        ElseIf context.Request.QueryString("Action") = "ExportSMSxLicense" Then
            ExportSMSxLicense()
        ElseIf context.Request.QueryString("Action") = "ShareReport" Then
            ShareReport()
        End If
    End Sub

    Private Sub ShareReport()

        Dim strCurrentDir As String = HttpContext.Current.Server.MapPath("~/")
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "MYReport" & "_" & Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If


        Dim ID As Integer = CType(HttpContext.Current.Request.QueryString("ID"), Integer)
        If ID = 0 Then
            Dim Datatab As DataTable = Portal.BLL.PM.PM_Ticket_Features.GET_REPORT_BY_ID()
            ID = Datatab.Rows(0).Item("ID")
        End If

        Dim dtDashboardStats As DataTable = Portal.DAL.PM.DBPM_Ticket_Features.GetReportById(ID,CType(HttpContext.Current.Request.QueryString("UserId"), Integer))
        Dim DName As DataTable = Portal.BLL.PM.PM_Ticket_Features.GetReportNameForExcel(ID)
        Using package As New ExcelPackage(newFile)
            Dim i As Integer = 0
            Dim j As Integer = 0
            Dim x As Integer = 3
            Dim y As Integer = 1
            Dim index As Integer = 0
            Dim LatestActivityIndex As Integer = 0
            Dim SOWIndex As Integer = 0
            Dim DueDateIndex As Integer = 0
            Dim CreationIndex As Integer = 0

            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("My Report")

            For Each column As DataColumn In dtDashboardStats.Columns
                worksheet.Cells(1, 5).Value = DName.Rows(0).Item("ReportName")
                worksheet.Cells(1, 5).Style.Font.Bold = True
                worksheet.Cells(1, 5).Style.Font.Size = 15
                worksheet.Cells(x, y).Value = column.ColumnName
                worksheet.Cells(x, y).Style.Font.Bold = True
                worksheet.Cells(x, y).Style.Font.Size = 12
                worksheet.Cells(x, y).Style.Font.Name = "Arial"
                worksheet.Column(y).Width = 20
                worksheet.Column(y).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
                y = y + 1
                If column.ColumnName.Equals("Latest Activity") Then
                    LatestActivityIndex = index
                End If
                If column.ColumnName.Equals("SOW Sign Date") Then
                    SOWIndex = index
                End If
                If column.ColumnName.Equals("Creation Date") Then
                    CreationIndex = index
                End If
                If column.ColumnName.Equals("Due Date") Then
                    DueDateIndex = index
                End If
                index = index + 1

            Next
            x = x + 1
            y = 1
            For i = 0 To dtDashboardStats.Rows.Count() - 1
                For j = 0 To dtDashboardStats.Rows(i).ItemArray().Length - 1

                    If LatestActivityIndex > 0 Or SOWIndex > 0 Or CreationIndex > 0 Or DueDateIndex > 0 Then
                        If j = LatestActivityIndex Or j = SOWIndex Or j = CreationIndex Or j = DueDateIndex Then
                            worksheet.Cells(x, y).Value = String.Format("{0:MMM dd, yyyy}", dtDashboardStats.Rows(i).Item(j))
                        Else
                            worksheet.Cells(x, y).Value = dtDashboardStats.Rows(i).Item(j)
                        End If
                    Else
                        worksheet.Cells(x, y).Value = dtDashboardStats.Rows(i).Item(j)
                    End If

                    worksheet.Cells(x, y).Style.Font.Size = 8
                    worksheet.Cells(x, y).Style.Font.Name = "Arial"
                    y = y + 1
                Next
                x = x + 1
                y = 1
            Next
            worksheet.Cells(x + 2, y + 2).Value = "Total Records - " + dtDashboardStats.Rows.Count().ToString()

            package.Save()
        End Using
        HttpContext.Current.Response.ContentType = "application/force-download"
        HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)

        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub


    Private Sub ExportPMDashBoard()
        Dim strCurrentDir As String = HttpContext.Current.Server.MapPath("~/")

        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "PM-Dashboard" & Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If
        Dim ClientId As Integer = HttpContext.Current.Request.QueryString("ClientId")
        Dim CategoryId As Integer = HttpContext.Current.Request.QueryString("CategoryId")
        Dim Type As Integer = HttpContext.Current.Request.QueryString("Type")
        Dim TeamId As Integer = HttpContext.Current.Request.QueryString("TeamId")
        Dim StartDate As DateTime = HttpContext.Current.Request.QueryString("StartDate")
        Dim EndDate As DateTime = HttpContext.Current.Request.QueryString("EndDate")
        Dim SortBy As String = HttpContext.Current.Request.QueryString("SortBy")


        Dim dtDashboardStats As DataTable = Portal.BLL.PM.PM_Ticket_Features.GetPMDashBoardStats(ClientId, CategoryId, Type, TeamId, StartDate, EndDate, SortBy) ' GetAllReviewers(HttpContext.Current.Request.QueryString("Search"), HttpContext.Current.Request.QueryString("Status"), HttpContext.Current.Request.QueryString("SortBy"), 0, 10000, HttpContext.Current.Request.QueryString("CountryId"), HttpContext.Current.Request.QueryString("StateId"), HttpContext.Current.Request.QueryString("CountyId"), HttpContext.Current.Request.QueryString("ReviewerId"))


        Using package As New ExcelPackage(newFile)
            ' add a new worksheet to the empty workbook
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("PM-Dashbaord Stats Report ")

            worksheet.Cells(1, 1).Value = "Netsolace, Inc."
            worksheet.Cells(1, 1).Style.Font.Size = 14
            worksheet.Cells(1, 1).Style.Font.Bold = True
            worksheet.Cells(1, 1).Style.Font.Name = "Arial"

            worksheet.Cells(3, 1).Value = "PM Report"
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Size = 12
            worksheet.Cells(3, 1).Style.Font.Name = "Arial"

            worksheet.Cells(4, 1).Value = "Generated on: " & System.DateTime.Now.ToString()
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Size = 8
            worksheet.Cells(4, 1).Style.Font.Name = "Arial"

            worksheet.Cells("A1:C1").Merge = True
            worksheet.Cells("A1:C1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:C3").Merge = True
            worksheet.Cells("A3:C3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:C4").Merge = True
            worksheet.Cells("A4:C4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            Dim i As Integer = 6

            If Not HttpContext.Current.Request.QueryString("StartDate") Is Nothing AndAlso Not HttpContext.Current.Request.QueryString("EndDate") Is Nothing Then
                worksheet.Cells(i, 1).Value = "Date ( " + HttpContext.Current.Request.QueryString("StartDate") + " - " + HttpContext.Current.Request.QueryString("EndDate") + " )"
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("ClientId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Client: " + HttpContext.Current.Request.QueryString("ClientName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("CategoryId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Category: " + HttpContext.Current.Request.QueryString("CategoryName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("TeamId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Team: " + HttpContext.Current.Request.QueryString("TeamName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("Type") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Type: " + HttpContext.Current.Request.QueryString("TypeName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If

            i = i+2


            worksheet.Cells(i, 1).Value = "Team"
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"
            worksheet.Cells(i, 2).Value = "Time Spent (HH:MM)"
            worksheet.Cells(i, 2).Style.Font.Bold = True
            worksheet.Cells(i, 2).Style.Font.Size = 8
            worksheet.Cells(i, 2).Style.Font.Name = "Arial"
            worksheet.Cells(i, 3).Value = "Total Tickets"
            worksheet.Cells(i, 3).Style.Font.Bold = True
            worksheet.Cells(i, 3).Style.Font.Size = 8
            worksheet.Cells(i, 3).Style.Font.Name = "Arial"


            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(204, 255, 204))
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Top.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Top.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Right.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Left.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Left.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Bottom.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":C" + i.ToString()).Style.Border.Bottom.Color.SetColor(System.Drawing.Color.Black)



            i = i + 1


            worksheet.Column(1).Width = 30
            worksheet.Column(2).Width = 30
            worksheet.Column(3).Width = 30
            Dim TotalTicketCount As Integer = 0
            Dim TotalHoursCount As Integer = 0
            Dim TotalMinsCount As Integer = 0
            For Each row As DataRow In dtDashboardStats.Rows
                worksheet.Cells(i, 1).Value = row("Team")
                worksheet.Cells(i, 1).Style.Font.Size = 8
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"


                worksheet.Cells(i, 2).Style.Font.Size = 8
                worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                Dim time As String = "0:00"
                Dim strArray() As String
                If Not row("TimeAsString") Is DBNull.Value Then
                    strArray = row("TimeAsString").ToString.Split(":")
                    TotalHoursCount = TotalHoursCount + CInt(strArray(0))
                    TotalMinsCount = TotalMinsCount + CInt(strArray(1))
                    If strArray(1).Length = 0 Then
                        time = strArray(0) + ":" + "00"
                    ElseIf strArray(1).Length = 1 Then
                        time = strArray(0) + ":" + "0" + strArray(1)
                    Else
                        time = row("TimeAsString")
                    End If
                End If
                worksheet.Cells(i, 2).Value = time




                worksheet.Cells(i, 3).Style.Font.Size = 8
                worksheet.Cells(i, 3).Style.Font.Name = "Arial"
                worksheet.Cells(i, 3).Value = Functions.IfNull(row("TicketsCompleted"), "0")
                worksheet.Cells(i, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right

                i += 1
                TotalTicketCount = TotalTicketCount + CInt(Functions.IfNull(row("TicketsCompleted"), "0"))

            Next
            i = i + 1
            worksheet.Cells(i, 1).Value = "Grand Total"
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"

            ' Converting Minutes to hours  wich are convertable to hours
            TotalHoursCount = TotalHoursCount + Math.Floor(TotalMinsCount / 60)
            Dim TimeString As String = TotalHoursCount.ToString + ":"
            If (TotalMinsCount Mod 60) > 9 Then
                TimeString = TimeString + (TotalMinsCount Mod 60).ToString
            ElseIf (TotalMinsCount Mod 60) <= 0 Then
                TimeString = TimeString + "00"
            Else
                TimeString = TimeString + "0" + (TotalMinsCount Mod 60).ToString
            End If
            worksheet.Cells(i, 2).Value = TimeString
            worksheet.Cells(i, 2).Style.Font.Size = 8
            worksheet.Cells(i, 2).Style.Font.Bold = True
            worksheet.Cells(i, 2).Style.Font.Name = "Arial"
            worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right

            worksheet.Cells(i, 3).Value = TotalTicketCount
            worksheet.Cells(i, 3).Style.Font.Size = 8
            worksheet.Cells(i, 3).Style.Font.Bold = True
            worksheet.Cells(i, 3).Style.Font.Name = "Arial"
            worksheet.Cells(i, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right






            i = i + 2

            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"
            worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Merge = True
            worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Value = "Total Records - " + dtDashboardStats.Rows.Count().ToString()


            'worksheet.Cells(i, 2).Style.Font.Size = 8
            'worksheet.Cells(i, 2).Style.Font.Bold = True
            'worksheet.Cells(i, 2).Style.Font.Name = "Arial"
            'worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
            'worksheet.Cells(i, 2).Value = dtDashboardStats.Rows.Count().ToString()



            package.Save()
        End Using
        HttpContext.Current.Response.ContentType = "application/force-download"
        HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)

        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub
    Private Sub ExportPMDashBoardTickets()
        Dim strCurrentDir As String = HttpContext.Current.Server.MapPath("~/")
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "PM-Dashboard" & Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If
        Dim ClientId As Integer = HttpContext.Current.Request.QueryString("ClientId")
        Dim CategoryId As Integer = HttpContext.Current.Request.QueryString("CategoryId")
        Dim Type As Integer = HttpContext.Current.Request.QueryString("Type")
        Dim TeamId As Integer = HttpContext.Current.Request.QueryString("TeamId")
        Dim UserId As Integer = HttpContext.Current.Request.QueryString("UserId")
        Dim StartDate As DateTime = HttpContext.Current.Request.QueryString("StartDate")
        Dim EndDate As DateTime = HttpContext.Current.Request.QueryString("EndDate")
        Dim SortBy As String = HttpContext.Current.Request.QueryString("SortBy")
        Dim Search As String = String.Empty

        Dim dtDashboardTickets As DataTable = Portal.BLL.PM.PM_Ticket_Features.GetPMDashBoardTickets(StartDate, EndDate, ClientId, CategoryId, Type, TeamId, UserId, SortBy, 100000000, 0, Search)


        Using package As New ExcelPackage(newFile)
            ' add a new worksheet to the empty workbook
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("PM-Dashbaord Stats Report ")

            worksheet.Cells(1, 1).Value = "Netsolace, Inc."
            worksheet.Cells(1, 1).Style.Font.Size = 14
            worksheet.Cells(1, 1).Style.Font.Bold = True
            worksheet.Cells(1, 1).Style.Font.Name = "Arial"

            worksheet.Cells(3, 1).Value = "PM Detail Report"
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Size = 12
            worksheet.Cells(3, 1).Style.Font.Name = "Arial"

            worksheet.Cells(4, 1).Value = "Generated on: " & System.DateTime.Now.ToString()
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Size = 10
            worksheet.Cells(4, 1).Style.Font.Name = "Arial"


            worksheet.Cells("A1:I1").Merge = True
            worksheet.Cells("A1:I1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:I3").Merge = True
            worksheet.Cells("A3:I3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:I4").Merge = True
            worksheet.Cells("A4:I4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            Dim i As Integer = 6

            If Not HttpContext.Current.Request.QueryString("StartDate") Is Nothing AndAlso Not HttpContext.Current.Request.QueryString("EndDate") Is Nothing Then
                worksheet.Cells(i, 1).Value = "Date ( " + HttpContext.Current.Request.QueryString("StartDate") + " - " + HttpContext.Current.Request.QueryString("EndDate") + " )"
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("ClientId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Client: " + HttpContext.Current.Request.QueryString("ClientName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("CategoryId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Category: " + HttpContext.Current.Request.QueryString("CategoryName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("TeamId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Team: " + HttpContext.Current.Request.QueryString("TeamName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("UserId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "User: " + HttpContext.Current.Request.QueryString("UserName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("Type") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Type: " + HttpContext.Current.Request.QueryString("TypeName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            i = i + 2



            worksheet.Cells(i, 1).Value = "Ref #"
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"

            worksheet.Cells(i, 2).Value = "Subject"
            worksheet.Cells(i, 2).Style.Font.Bold = True
            worksheet.Cells(i, 2).Style.Font.Size = 8
            worksheet.Cells(i, 2).Style.Font.Name = "Arial"

            worksheet.Cells(i, 3).Value = "Category"
            worksheet.Cells(i, 3).Style.Font.Bold = True
            worksheet.Cells(i, 3).Style.Font.Size = 8
            worksheet.Cells(i, 3).Style.Font.Name = "Arial"

            worksheet.Cells(i, 4).Value = "Entered On"
            worksheet.Cells(i, 4).Style.Font.Bold = True
            worksheet.Cells(i, 4).Style.Font.Size = 8
            worksheet.Cells(i, 4).Style.Font.Name = "Arial"

            worksheet.Cells(i, 5).Value = "Initiated By"
            worksheet.Cells(i, 5).Style.Font.Bold = True
            worksheet.Cells(i, 5).Style.Font.Size = 8
            worksheet.Cells(i, 5).Style.Font.Name = "Arial"



            worksheet.Cells(i, 6).Value = "Status"
            worksheet.Cells(i, 6).Style.Font.Bold = True
            worksheet.Cells(i, 6).Style.Font.Size = 8
            worksheet.Cells(i, 6).Style.Font.Name = "Arial"

            worksheet.Cells(i, 7).Value = "Completed On"
            worksheet.Cells(i, 7).Style.Font.Bold = True
            worksheet.Cells(i, 7).Style.Font.Size = 8
            worksheet.Cells(i, 7).Style.Font.Name = "Arial"

            worksheet.Cells(i, 8).Value = "Completed Survey Y/N"
            worksheet.Cells(i, 8).Style.Font.Bold = True
            worksheet.Cells(i, 8).Style.Font.Size = 8
            worksheet.Cells(i, 8).Style.Font.Name = "Arial"

            worksheet.Cells(i, 9).Value = "Time Spent (HH:MM)"
            worksheet.Cells(i, 9).Style.Font.Bold = True
            worksheet.Cells(i, 9).Style.Font.Size = 8
            worksheet.Cells(i, 9).Style.Font.Name = "Arial"


            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(204, 255, 204))
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Color.SetColor(System.Drawing.Color.Black)
            i += 1

            worksheet.Column(1).Width = 20
            worksheet.Column(2).Width = 20
            worksheet.Column(3).Width = 20
            worksheet.Column(4).Width = 20
            worksheet.Column(5).Width = 20
            worksheet.Column(6).Width = 20
            worksheet.Column(7).Width = 20
            worksheet.Column(8).Width = 20
            worksheet.Column(9).Width = 20

            Dim TotalHoursCount As Integer = 0
            Dim TotalMinsCount As Integer = 0

            For Each row As DataRow In dtDashboardTickets.Rows
                worksheet.Cells(i, 1).Value = row("RefNo")
                worksheet.Cells(i, 1).Style.Font.Size = 8
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"
                worksheet.Cells(i, 1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                worksheet.Cells(i, 2).Style.Font.Size = 8
                worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                worksheet.Cells(i, 2).Value = row("Name")

                worksheet.Cells(i, 3).Style.Font.Size = 8
                worksheet.Cells(i, 3).Style.Font.Name = "Arial"
                worksheet.Cells(i, 3).Value = row("CategoryName")

                worksheet.Cells(i, 4).Style.Font.Size = 8
                worksheet.Cells(i, 4).Style.Font.Name = "Arial"
                worksheet.Cells(i, 4).Value = row("DateEntered")

                worksheet.Cells(i, 5).Style.Font.Size = 8
                worksheet.Cells(i, 5).Style.Font.Name = "Arial"
                worksheet.Cells(i, 5).Value = row("InitiatedBy")

                worksheet.Cells(i, 6).Style.Font.Size = 8
                worksheet.Cells(i, 6).Style.Font.Name = "Arial"
                worksheet.Cells(i, 6).Value = row("Status")

                worksheet.Cells(i, 7).Style.Font.Size = 8
                worksheet.Cells(i, 7).Style.Font.Name = "Arial"
                worksheet.Cells(i, 7).Value = row("DateCompleted")

                worksheet.Cells(i, 8).Style.Font.Size = 8
                worksheet.Cells(i, 8).Style.Font.Name = "Arial"
                worksheet.Cells(i, 8).Value = Functions.IfNull(IIf(row("SurveyExisted") = 0, "No", "Yes"), "N/A")

                worksheet.Cells(i, 9).Style.Font.Size = 8
                worksheet.Cells(i, 9).Style.Font.Name = "Arial"
                worksheet.Cells(i, 9).Value = Functions.IfNull(row("TimeAsString"), "N/A")




                Dim time As String = "0:00"
                Dim strArray() As String
                If Not row("TimeAsString") Is DBNull.Value Then
                    strArray = row("TimeAsString").ToString.Split(":")
                    TotalHoursCount = TotalHoursCount + CInt(strArray(0))
                    TotalMinsCount = TotalMinsCount + CInt(strArray(1))
                    If strArray(1).Length = 0 Then
                        time = strArray(0) + ":" + "00"
                    ElseIf strArray(1).Length = 1 Then
                        time = strArray(0) + ":" + "0" + strArray(1)
                    Else
                        time = row("TimeAsString")
                    End If
                End If
                worksheet.Cells(i, 9).Value = time

                i += 1

            Next
            If dtDashboardTickets.Rows.Count() > 0 Then


                worksheet.Cells(i, 1).Value = "Total Time Spent"
                worksheet.Cells(i, 1).Style.Font.Size = 8
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"
                worksheet.Cells("A" + i.ToString + ":G" + i.ToString).Merge = True

                ' Converting Minutes to hours  wich are convertable to hours
                TotalHoursCount = TotalHoursCount + Math.Floor(TotalMinsCount / 60)
                Dim TimeString As String = TotalHoursCount.ToString + ":"
                If (TotalMinsCount Mod 60) > 9 Then
                    TimeString = TimeString + (TotalMinsCount Mod 60).ToString
                ElseIf (TotalMinsCount Mod 60) <= 0 Then
                    TimeString = TimeString + "00"
                Else
                    TimeString = TimeString + "0" + (TotalMinsCount Mod 60).ToString
                End If
                worksheet.Cells(i, 9).Value = TimeString
                worksheet.Cells(i, 9).Style.Font.Size = 8
                worksheet.Cells(i, 9).Style.Font.Bold = True
                worksheet.Cells(i, 9).Style.Font.Name = "Arial"
                worksheet.Cells(i, 9).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
            End If
            i = i + 2
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"
            worksheet.Cells("A" + i.ToString + ":G" + i.ToString).Merge = True
            worksheet.Cells("A" + i.ToString + ":G" + i.ToString).Value = "Total Records - " + dtDashboardTickets.Rows.Count().ToString()


            'worksheet.Cells(i, 8).Style.Font.Size = 8
            'worksheet.Cells(i, 8).Style.Font.Bold = True
            'worksheet.Cells(i, 8).Style.Font.Name = "Arial"
            'worksheet.Cells(i, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
            'worksheet.Cells(i, 8).Value = dtDashboardTickets.Rows.Count().ToString()

            package.Save()
        End Using
        HttpContext.Current.Response.ContentType = "application/force-download"
        HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)

        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub

    Private Sub ExportPMCurrentReleases()

        Dim strCurrentDir As String = HttpContext.Current.Server.MapPath("~/")
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "PMCurrentReleases" & "_" & Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If

        Dim ClientId As Integer = HttpContext.Current.Request.QueryString("ClientId")
        Dim CategoryId As Integer = HttpContext.Current.Request.QueryString("CategoryId")
        Dim UserId As Integer = HttpContext.Current.Request.QueryString("UserLogID")
        Dim typeID As Integer = HttpContext.Current.Request.QueryString("TypeID")
        Dim Status As Integer = HttpContext.Current.Request.QueryString("Status")
        'Dim StartDate As DateTime = HttpContext.Current.Request.QueryString("StartDate")
        'Dim EndDate As DateTime = HttpContext.Current.Request.QueryString("EndDate")
        Dim SortBy As String = HttpContext.Current.Request.QueryString("SortBy")
        Dim searchtxt As String = HttpContext.Current.Request.QueryString("searchtxt")
        Dim Filter As Integer = HttpContext.Current.Request.QueryString("filter")
        Dim ReleaseID As Integer = HttpContext.Current.Request.QueryString("ReleaseID")
        Dim ReleaseName As String = HttpContext.Current.Request.QueryString("ReleaseName")

        'Dim dtDashboardStats As DataTable = Portal.BLL.PM.PM_Releases.GetAll_Excel(ClientId, CategoryId, 1000000, 0, searchtxt, UserId)

        Dim dtDashboardStats As DataTable = Portal.BLL.PM.PM_Ticket_Features.PM_TicketGetAll(ClientId, CategoryId, Status, typeID, Filter, 0, ReleaseID, SortBy, 1000000, 0, searchtxt, UserId)

        Using package As New ExcelPackage(newFile)
            ' add a new worksheet to the empty workbook
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("Release: " + ReleaseName)

            'worksheet.Cells(1, 1).Value = "PM My Tickets & Features Report"
            'worksheet.Cells(1, 1).Style.Font.Size = 14
            'worksheet.Cells(1, 1).Style.Font.Bold = True
            'worksheet.Cells(1, 1).Style.Font.Name = "Arial"

            worksheet.Cells(3, 1).Value = "Release: " + ReleaseName
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Size = 12
            worksheet.Cells(3, 1).Style.Font.Name = "Arial"

            worksheet.Cells(4, 1).Value = "Generated on: " & System.DateTime.Now.ToString()
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Size = 8
            worksheet.Cells(4, 1).Style.Font.Name = "Arial"

            worksheet.Cells("A1:I1").Merge = True
            worksheet.Cells("A1:I1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:I3").Merge = True
            worksheet.Cells("A3:I3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:I4").Merge = True
            worksheet.Cells("A4:I4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            Dim i As Integer = 6

            'If Not HttpContext.Current.Request.QueryString("StartDate") Is Nothing AndAlso Not HttpContext.Current.Request.QueryString("EndDate") Is Nothing Then
            '    worksheet.Cells(i, 1).Value = "Date ( " + HttpContext.Current.Request.QueryString("StartDate") + " - " + HttpContext.Current.Request.QueryString("EndDate") + " )"
            '    worksheet.Cells(i, 1).Style.Font.Bold = True
            '    worksheet.Cells(i, 1).Style.Font.Size = 9
            '    worksheet.Cells(i, 1).Style.Font.Name = "Arial"

            '    worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
            '    worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            'End If
            If Not HttpContext.Current.Request.QueryString("ClientId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Client: " + HttpContext.Current.Request.QueryString("ClientName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("CategoryId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Category: " + HttpContext.Current.Request.QueryString("CategoryName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            i = i + 2


            worksheet.Cells(i, 1).Value = "Ref#"
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"

            worksheet.Cells(i, 2).Value = "Subject"
            worksheet.Cells(i, 2).Style.Font.Bold = True
            worksheet.Cells(i, 2).Style.Font.Size = 8
            worksheet.Cells(i, 2).Style.Font.Name = "Arial"

            worksheet.Cells(i, 3).Value = "Status"
            worksheet.Cells(i, 3).Style.Font.Bold = True
            worksheet.Cells(i, 3).Style.Font.Size = 8
            worksheet.Cells(i, 3).Style.Font.Name = "Arial"


            worksheet.Cells(i, 4).Value = "Due Date"
            worksheet.Cells(i, 4).Style.Font.Bold = True
            worksheet.Cells(i, 4).Style.Font.Size = 8
            worksheet.Cells(i, 4).Style.Font.Name = "Arial"


            worksheet.Cells(i, 5).Value = "SOW Approval Date"
            worksheet.Cells(i, 5).Style.Font.Bold = True
            worksheet.Cells(i, 5).Style.Font.Size = 8
            worksheet.Cells(i, 5).Style.Font.Name = "Arial"


            worksheet.Cells(i, 6).Value = "Entered on"
            worksheet.Cells(i, 6).Style.Font.Bold = True
            worksheet.Cells(i, 6).Style.Font.Size = 8
            worksheet.Cells(i, 6).Style.Font.Name = "Arial"

            worksheet.Cells(i, 7).Value = "Updated on"
            worksheet.Cells(i, 7).Style.Font.Bold = True
            worksheet.Cells(i, 7).Style.Font.Size = 8
            worksheet.Cells(i, 7).Style.Font.Name = "Arial"

            worksheet.Cells(i, 8).Value = "Assigned by"
            worksheet.Cells(i, 8).Style.Font.Bold = True
            worksheet.Cells(i, 8).Style.Font.Size = 8
            worksheet.Cells(i, 8).Style.Font.Name = "Arial"

            worksheet.Cells(i, 9).Value = "Type"
            worksheet.Cells(i, 9).Style.Font.Bold = True
            worksheet.Cells(i, 9).Style.Font.Size = 8
            worksheet.Cells(i, 9).Style.Font.Name = "Arial"

            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(204, 255, 204))
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Color.SetColor(System.Drawing.Color.Black)



            i = i + 1


            worksheet.Column(1).Width = 30
            worksheet.Column(2).Width = 30
            worksheet.Column(3).Width = 30
            worksheet.Column(4).Width = 30
            worksheet.Column(5).Width = 30
            worksheet.Column(6).Width = 30
            worksheet.Column(7).Width = 30
            worksheet.Column(8).Width = 30
            worksheet.Column(9).Width = 30

            Dim sowdate As New DateTime(1900, 1, 1, 0, 0, 0)

            If dtDashboardStats.Rows.Count >= 1 Then

                For Each row As DataRow In dtDashboardStats.Rows
                    worksheet.Cells(i, 1).Value = Functions.IfNull(row("ID"), "")
                    worksheet.Cells(i, 1).Style.Font.Size = 8
                    worksheet.Cells(i, 1).Style.Font.Name = "Arial"


                    worksheet.Cells(i, 2).Style.Font.Size = 8
                    worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 2).Value = Functions.IfNull(row("Name"), "- -")
                    worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 3).Style.Font.Size = 8
                    worksheet.Cells(i, 3).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 3).Value = Functions.IfNull(row("Status"), " - -")
                    worksheet.Cells(i, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 4).Style.Font.Size = 8
                    worksheet.Cells(i, 4).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 4).Value = Functions.IfNull(Functions.FormatShortDate(IIf(row("DueDate") > sowdate, row("DueDate"), "")), " - -")
                    worksheet.Cells(i, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 5).Style.Font.Size = 8
                    worksheet.Cells(i, 5).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 5).Value = Functions.IfNull(Functions.FormatShortDate(IIf(row("SowSignedDate") > sowdate, row("SowSignedDate"), "")), " - -")
                    worksheet.Cells(i, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 6).Style.Font.Size = 8
                    worksheet.Cells(i, 6).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 6).Value = Functions.IfNull(Functions.FormatShortDate(IIf(row("DateEntered") > sowdate, row("DateEntered"), "")), " - -")
                    worksheet.Cells(i, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 7).Style.Font.Size = 8
                    worksheet.Cells(i, 7).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 7).Value = Functions.IfNull(Functions.FormatShortDate(IIf(row("LastUpdatedOn") > sowdate, row("LastUpdatedOn"), "")), " - -")
                    worksheet.Cells(i, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 8).Style.Font.Size = 8
                    worksheet.Cells(i, 8).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 8).Value = Functions.IfNull(row("AssignedBy"), " - -")
                    worksheet.Cells(i, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 9).Style.Font.Size = 8
                    worksheet.Cells(i, 9).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 9).Value = Functions.IfNull(row("TypeName"), " - -")
                    worksheet.Cells(i, 9).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    i += 1

                Next
                i = i + 2

                worksheet.Cells(i, 1).Style.Font.Size = 8
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"
                ' worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Merge = True
                worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Value = "Total Records"


                worksheet.Cells(i, 2).Style.Font.Size = 8
                worksheet.Cells(i, 2).Style.Font.Bold = True
                worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                worksheet.Cells(i, 2).Value = dtDashboardStats.Rows.Count().ToString()
            Else
                i = i + 8



                worksheet.Cells(17, 1).Value = "NO RECORD FOUND"
                worksheet.Cells(17, 1).Style.Font.Bold = True
                worksheet.Cells(17, 1).Style.Font.Size = 8
                worksheet.Cells(17, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A17:I17").Merge = True
                worksheet.Cells("A17:I17").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            End If
            package.Save()
        End Using
        HttpContext.Current.Response.ContentType = "application/force-download"
        HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)

        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub

    Private Sub ExportPMTicketsAndFeatures()

        Dim strCurrentDir As String = HttpContext.Current.Server.MapPath("~/")
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "PMTicketsAndFeatures"&"_"& Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If

        Dim UserLogID As Integer = HttpContext.Current.Request.QueryString("UserLogID")
        Dim ClientId As Integer = HttpContext.Current.Request.QueryString("ClientId")
        Dim CategoryId As String = HttpContext.Current.Request.QueryString("CategoryId")
        Dim typeID As String = HttpContext.Current.Request.QueryString("TypeID")
        Dim Status As String = HttpContext.Current.Request.QueryString("Status")
        Dim StartDate As DateTime = HttpContext.Current.Request.QueryString("StartDate")
        Dim EndDate As DateTime = HttpContext.Current.Request.QueryString("EndDate")
        Dim SortBy As String = HttpContext.Current.Request.QueryString("SortBy")
        Dim searchtxt As String = HttpContext.Current.Request.QueryString("searchtxt")
        Dim Filter As Integer = HttpContext.Current.Request.QueryString("filter")



        Dim dtDashboardStats As DataTable = Portal.BLL.PM.PM_Ticket_Features.PM_MYTicketGetAll_Excel(ClientId, CategoryId, Status, Filter, SortBy, 1000000, 0, searchtxt, StartDate, EndDate, UserLogID, typeID)


        Using package As New ExcelPackage(newFile)
            ' add a new worksheet to the empty workbook
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("PM Tickets & Features Report")

            'worksheet.Cells(1, 1).Value = "PM My Tickets & Features Report"
            'worksheet.Cells(1, 1).Style.Font.Size = 14
            'worksheet.Cells(1, 1).Style.Font.Bold = True
            'worksheet.Cells(1, 1).Style.Font.Name = "Arial"

            worksheet.Cells(3, 1).Value = "PM Tickets & Features Report"
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Size = 12
            worksheet.Cells(3, 1).Style.Font.Name = "Arial"

            worksheet.Cells(4, 1).Value = "Generated on: " & System.DateTime.Now.ToString()
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Size = 8
            worksheet.Cells(4, 1).Style.Font.Name = "Arial"

            worksheet.Cells("A1:I1").Merge = True
            worksheet.Cells("A1:I1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:I3").Merge = True
            worksheet.Cells("A3:I3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:I4").Merge = True
            worksheet.Cells("A4:I4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            Dim i As Integer = 6

            If Not HttpContext.Current.Request.QueryString("StartDate") Is Nothing AndAlso Not HttpContext.Current.Request.QueryString("EndDate") Is Nothing Then
                worksheet.Cells(i, 1).Value = "Date ( " + HttpContext.Current.Request.QueryString("StartDate") + " - " + HttpContext.Current.Request.QueryString("EndDate") + " )"
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("ClientId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Client: " + HttpContext.Current.Request.QueryString("ClientName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("CategoryId") = "0" Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Category: " + HttpContext.Current.Request.QueryString("CategoryName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            If Not HttpContext.Current.Request.QueryString("TypeName") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Type: " + HttpContext.Current.Request.QueryString("TypeName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            If Not HttpContext.Current.Request.QueryString("Filter") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Filter: " + HttpContext.Current.Request.QueryString("FilterName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            If Not HttpContext.Current.Request.QueryString("Status") = "0" Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Status: " + HttpContext.Current.Request.QueryString("StatusName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If

            i = i + 2


            worksheet.Cells(i, 1).Value = "Ref #"
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"

            worksheet.Cells(i, 2).Value = "Subject"
            worksheet.Cells(i, 2).Style.Font.Bold = True
            worksheet.Cells(i, 2).Style.Font.Size = 8
            worksheet.Cells(i, 2).Style.Font.Name = "Arial"

            worksheet.Cells(i, 3).Value = "Status"
            worksheet.Cells(i, 3).Style.Font.Bold = True
            worksheet.Cells(i, 3).Style.Font.Size = 8
            worksheet.Cells(i, 3).Style.Font.Name = "Arial"


            worksheet.Cells(i, 4).Value = "Category"
            worksheet.Cells(i, 4).Style.Font.Bold = True
            worksheet.Cells(i, 4).Style.Font.Size = 8
            worksheet.Cells(i, 4).Style.Font.Name = "Arial"


            worksheet.Cells(i, 5).Value = "Type"
            worksheet.Cells(i, 5).Style.Font.Bold = True
            worksheet.Cells(i, 5).Style.Font.Size = 8
            worksheet.Cells(i, 5).Style.Font.Name = "Arial"



            worksheet.Cells(i, 6).Value = "Client"
            worksheet.Cells(i, 6).Style.Font.Bold = True
            worksheet.Cells(i, 6).Style.Font.Size = 8
            worksheet.Cells(i, 6).Style.Font.Name = "Arial"

            worksheet.Cells(i, 7).Value = "Due Date"
            worksheet.Cells(i, 7).Style.Font.Bold = True
            worksheet.Cells(i, 7).Style.Font.Size = 8
            worksheet.Cells(i, 7).Style.Font.Name = "Arial"

            worksheet.Cells(i, 8).Value = "Entered On"
            worksheet.Cells(i, 8).Style.Font.Bold = True
            worksheet.Cells(i, 8).Style.Font.Size = 8
            worksheet.Cells(i, 8).Style.Font.Name = "Arial"

            worksheet.Cells(i, 9).Value = "Updated On"
            worksheet.Cells(i, 9).Style.Font.Bold = True
            worksheet.Cells(i, 9).Style.Font.Size = 8
            worksheet.Cells(i, 9).Style.Font.Name = "Arial"



            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(204, 255, 204))
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Color.SetColor(System.Drawing.Color.Black)



            i = i + 1


            worksheet.Column(1).Width = 30
            worksheet.Column(2).Width = 30
            worksheet.Column(3).Width = 30
            worksheet.Column(4).Width = 30
            worksheet.Column(5).Width = 30
            worksheet.Column(6).Width = 30
            worksheet.Column(7).Width = 30
            worksheet.Column(8).Width = 30
            worksheet.Column(9).Width = 30


            If dtDashboardStats.Rows.Count >= 1 Then

                For Each row As DataRow In dtDashboardStats.Rows
                    worksheet.Cells(i, 1).Value = Functions.IfNull(row("RefNo"), "")
                    worksheet.Cells(i, 1).Style.Font.Size = 8
                    worksheet.Cells(i, 1).Style.Font.Name = "Arial"


                    worksheet.Cells(i, 2).Style.Font.Size = 8
                    worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 2).Value = Functions.IfNull(row("Name"), "- -")




                    worksheet.Cells(i, 3).Style.Font.Size = 8
                    worksheet.Cells(i, 3).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 3).Value = Functions.IfNull(row("Status"), " - -")
                    worksheet.Cells(i, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 4).Style.Font.Size = 8
                    worksheet.Cells(i, 4).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 4).Value = Functions.IfNull(row("CategoryName"), " - -")
                    worksheet.Cells(i, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 5).Style.Font.Size = 8
                    worksheet.Cells(i, 5).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 5).Value = Functions.IfNull(row("TypeName"), " - -")
                    worksheet.Cells(i, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 6).Style.Font.Size = 8
                    worksheet.Cells(i, 6).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 6).Value = Functions.IfNull(row("ClientName"), " - -")
                    worksheet.Cells(i, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 7).Style.Font.Size = 8
                    worksheet.Cells(i, 7).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 7).Value = Functions.IfNull(Functions.FormatShortDate(row("DueDate")), " - -")
                    worksheet.Cells(i, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 8).Style.Font.Size = 8
                    worksheet.Cells(i, 8).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 8).Value = Functions.IfNull(Functions.FormatShortDate(row("DateEntered")), " - -")
                    worksheet.Cells(i, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 9).Style.Font.Size = 8
                    worksheet.Cells(i, 9).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 9).Value = Functions.IfNull(Functions.FormatShortDate(row("LastUpdatedOn")), " - -")
                    worksheet.Cells(i, 9).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    i += 1

                Next
                i = i + 2

                worksheet.Cells(i, 1).Style.Font.Size = 8
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"
                ' worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Merge = True
                worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Value = "Total Records"


                worksheet.Cells(i, 2).Style.Font.Size = 8
                worksheet.Cells(i, 2).Style.Font.Bold = True
                worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                worksheet.Cells(i, 2).Value = dtDashboardStats.Rows.Count().ToString()
            Else
                i = i + 8



                worksheet.Cells(17, 1).Value = "NO RECORD FOUND"
                worksheet.Cells(17, 1).Style.Font.Bold = True
                worksheet.Cells(17, 1).Style.Font.Size = 8
                worksheet.Cells(17, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A17:I17").Merge = True
                worksheet.Cells("A17:I17").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            End If
            package.Save()
        End Using
        HttpContext.Current.Response.ContentType = "application/force-download"
        HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)

        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub

    ' mtahir 
    Private Sub ExportPMRecentTicketsAndFeatures()
        Dim strCurrentDir As String = HttpContext.Current.Server.MapPath("~/")
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "RecentTicketsAndFeatures" & "_" & Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If

        Dim UserLogID As Integer = HttpContext.Current.Request.QueryString("UserLogID")
        Dim ClientId As Integer = HttpContext.Current.Request.QueryString("ClientId")
        Dim CategoryId As String = HttpContext.Current.Request.QueryString("CategoryId")
        Dim typeID As String = HttpContext.Current.Request.QueryString("TypeID")
        Dim typeName As String = HttpContext.Current.Request.QueryString("TypeName")
        Dim Status As String = HttpContext.Current.Request.QueryString("Status")
        Dim SortBy As String = HttpContext.Current.Request.QueryString("SortBy")
        Dim searchtxt As String = HttpContext.Current.Request.QueryString("searchtxt")
        Dim Filter As Integer = HttpContext.Current.Request.QueryString("filter")
        Dim ddlWaitingForNames As Integer = HttpContext.Current.Request.QueryString("ddlWaitingForNames")



        Dim dtDashboardStats As DataTable = Portal.BLL.PM.PM_Ticket_Features.PMRecent_TicketGetAll_Excel(ClientId, CategoryId, Status, typeID, Filter, ddlWaitingForNames, 0, SortBy, 100000, 0, searchtxt, UserLogID)


        Using package As New ExcelPackage(newFile)
            ' add a new worksheet to the empty workbook
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("Recent Tickets & Features")

            worksheet.Cells(3, 1).Value = "Recent Tickets & Features Report"
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Size = 12
            worksheet.Cells(3, 1).Style.Font.Name = "Arial"

            worksheet.Cells(4, 1).Value = "Generated on: " & System.DateTime.Now.ToString()
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Size = 8
            worksheet.Cells(4, 1).Style.Font.Name = "Arial"

            worksheet.Cells("A1:H1").Merge = True
            worksheet.Cells("A1:H1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:H3").Merge = True
            worksheet.Cells("A3:H3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:H4").Merge = True
            worksheet.Cells("A4:J4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            Dim i As Integer = 6

            If Not HttpContext.Current.Request.QueryString("StartDate") Is Nothing AndAlso Not HttpContext.Current.Request.QueryString("EndDate") Is Nothing Then
                worksheet.Cells(i, 1).Value = "Date ( " + HttpContext.Current.Request.QueryString("StartDate") + " - " + HttpContext.Current.Request.QueryString("EndDate") + " )"
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("ClientId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Client: " + HttpContext.Current.Request.QueryString("ClientName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("CategoryId") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Category: " + HttpContext.Current.Request.QueryString("CategoryName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            If Not HttpContext.Current.Request.QueryString("TypeID") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Type: " + HttpContext.Current.Request.QueryString("TypeName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            If Not HttpContext.Current.Request.QueryString("Filter") = 0 Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Filter: " + HttpContext.Current.Request.QueryString("FilterName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If


            If Not HttpContext.Current.Request.QueryString("Status") = "0" Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Status: " + HttpContext.Current.Request.QueryString("StatusName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            i = i + 2
            worksheet.Cells(i, 1).Value = "Ref #"
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"

            worksheet.Cells(i, 2).Value = "Subject"
            worksheet.Cells(i, 2).Style.Font.Bold = True
            worksheet.Cells(i, 2).Style.Font.Size = 8
            worksheet.Cells(i, 2).Style.Font.Name = "Arial"

            worksheet.Cells(i, 3).Value = "Status"
            worksheet.Cells(i, 3).Style.Font.Bold = True
            worksheet.Cells(i, 3).Style.Font.Size = 8
            worksheet.Cells(i, 3).Style.Font.Name = "Arial"

            worksheet.Cells(i, 4).Value = "Type"
            worksheet.Cells(i, 4).Style.Font.Bold = True
            worksheet.Cells(i, 4).Style.Font.Size = 8
            worksheet.Cells(i, 4).Style.Font.Name = "Arial"

            worksheet.Cells(i, 5).Value = "Due Date"
            worksheet.Cells(i, 5).Style.Font.Bold = True
            worksheet.Cells(i, 5).Style.Font.Size = 8
            worksheet.Cells(i, 5).Style.Font.Name = "Arial"

            worksheet.Cells(i, 6).Value = "Entered On"
            worksheet.Cells(i, 6).Style.Font.Bold = True
            worksheet.Cells(i, 6).Style.Font.Size = 8
            worksheet.Cells(i, 6).Style.Font.Name = "Arial"

            worksheet.Cells(i, 7).Value = "Updated On"
            worksheet.Cells(i, 7).Style.Font.Bold = True
            worksheet.Cells(i, 7).Style.Font.Size = 8
            worksheet.Cells(i, 7).Style.Font.Name = "Arial"


            worksheet.Cells(i, 8).Value = "Assigned By"
            worksheet.Cells(i, 8).Style.Font.Bold = True
            worksheet.Cells(i, 8).Style.Font.Size = 8
            worksheet.Cells(i, 8).Style.Font.Name = "Arial"


            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(204, 255, 204))
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Top.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Top.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Right.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Left.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Left.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Bottom.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":H" + i.ToString()).Style.Border.Bottom.Color.SetColor(System.Drawing.Color.Black)
            i = i + 1
            worksheet.Column(1).Width = 12
            worksheet.Column(2).Width = 30
            worksheet.Column(3).Width = 20
            worksheet.Column(4).Width = 10
            worksheet.Column(5).Width = 20
            worksheet.Column(6).Width = 20
            worksheet.Column(7).Width = 20
            worksheet.Column(8).Width = 30


            If dtDashboardStats.Rows.Count >= 1 Then

                For Each row As DataRow In dtDashboardStats.Rows
                    worksheet.Cells(i, 1).Value = Functions.IfNull(row("RefNo"), "")
                    worksheet.Cells(i, 1).Style.Font.Size = 8
                    worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                    worksheet.Cells(i, 2).Style.Font.Size = 8
                    worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 2).Value = Functions.IfNull(row("Name"), "- -")

                    worksheet.Cells(i, 3).Style.Font.Size = 8
                    worksheet.Cells(i, 3).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 3).Value = Functions.IfNull(row("Status"), " - -")
                    worksheet.Cells(i, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 4).Style.Font.Size = 8
                    worksheet.Cells(i, 4).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 4).Value = Functions.IfNull(row("TypeName"), " - -")
                    worksheet.Cells(i, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 5).Style.Font.Size = 8
                    worksheet.Cells(i, 5).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 5).Value = Functions.IfNull(Functions.FormatShortDate(row("DueDate")), " - -")
                    worksheet.Cells(i, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 6).Style.Font.Size = 8
                    worksheet.Cells(i, 6).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 6).Value = Functions.IfNull(Functions.FormatShortDate(row("DateEntered")), " - -")
                    worksheet.Cells(i, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 7).Style.Font.Size = 8
                    worksheet.Cells(i, 7).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 7).Value = Functions.IfNull(Functions.FormatShortDate(row("LastUpdatedOn")), " - -")
                    worksheet.Cells(i, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    If Functions.IfNull(row("UserID"), 0) <> 0 Then
                        worksheet.Cells(i, 8).Style.Font.Size = 8
                        worksheet.Cells(i, 8).Style.Font.Name = "Arial"
                        worksheet.Cells(i, 8).Value = Functions.IfNull(row("AssignedBy"), " - -")
                        worksheet.Cells(i, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    ElseIf Functions.IfNull(row("ClientContactID"), 0) <> 0 Then
                        worksheet.Cells(i, 8).Style.Font.Size = 8
                        worksheet.Cells(i, 8).Style.Font.Name = "Arial"
                        worksheet.Cells(i, 8).Value = row("ClientContactAssignedby") & " (" & row("ClientName") & ")"
                        worksheet.Cells(i, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    End If


                    i += 1

                Next
                i = i + 2

                worksheet.Cells(i, 1).Style.Font.Size = 8
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"
                worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Value = "Total Tickets"
                worksheet.Cells(i, 2).Style.Font.Size = 8
                worksheet.Cells(i, 2).Style.Font.Bold = True
                worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                worksheet.Cells(i, 2).Value = dtDashboardStats.Rows.Count().ToString()
            Else
                i = i + 8
                worksheet.Cells(17, 1).Value = "NO RECORD FOUND"
                worksheet.Cells(17, 1).Style.Font.Bold = True
                worksheet.Cells(17, 1).Style.Font.Size = 8
                worksheet.Cells(17, 1).Style.Font.Name = "Arial"
                worksheet.Cells("A17:I17").Merge = True
                worksheet.Cells("A17:I17").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            package.Save()
        End Using
        HttpContext.Current.Response.ContentType = "application/force-download"
        HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)

        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub

    Private Sub ExportSMSxLicense()

        Dim strCurrentDir As String = HttpContext.Current.Server.MapPath("~/")
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "SMSxLicenseReport.xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If

        Dim SMSxVersionID As String = HttpContext.Current.Request.QueryString("SMSxVersionID")
        Dim SMSxVersionName As String = HttpContext.Current.Request.QueryString("SMSxVersionName")
        Dim StoreStatusValue As Integer = HttpContext.Current.Request.QueryString("StoreStatusValue")
        Dim StoreStatusText As String = HttpContext.Current.Request.QueryString("StoreStatusText")
        Dim SortedBy As String = HttpContext.Current.Request.QueryString("SortedBy")



        Dim dtDashboardStats As DataTable = Portal.BLL.SMSXLicenseManagement.GetAllSMXLicensesSMSxVersionForReporting(SMSxVersionID, SortedBy, StoreStatusValue)


        Using package As New ExcelPackage(newFile)
            ' add a new worksheet to the empty workbook
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("SMSx Licenses Report")

            worksheet.Cells(2, 1).Value = "Netsolace,Inc."
            worksheet.Cells(2, 1).Style.Font.Bold = True
            worksheet.Cells(2, 1).Style.Font.Size = 10
            worksheet.Cells(2, 1).Style.Font.Name = "Arial"

            worksheet.Cells(3, 1).Value = "SMSx Licenses"
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Size = 12
            worksheet.Cells(3, 1).Style.Font.Name = "Arial"

            worksheet.Cells(4, 1).Value = "Generated on: " & System.DateTime.Now.ToString()
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Size = 8
            worksheet.Cells(4, 1).Style.Font.Name = "Arial"

            worksheet.Cells("A1:I1").Merge = True
            worksheet.Cells("A1:I1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A2:I2").Merge = True
            worksheet.Cells("A2:I2").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:I3").Merge = True
            worksheet.Cells("A3:I3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:I4").Merge = True
            worksheet.Cells("A4:I4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            Dim i As Integer = 6
            If Not HttpContext.Current.Request.QueryString("SMSxVersionID") = "All" Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "SMSx Version : " + HttpContext.Current.Request.QueryString("SMSxVersionName")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            End If
            If Not HttpContext.Current.Request.QueryString("StoreStatusValue") = "0" Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "Store Status: " + HttpContext.Current.Request.QueryString("StoreStatusText")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            End If

            If Not HttpContext.Current.Request.QueryString("SortedBy") = "" Then
                i = i + 1
                worksheet.Cells(i, 1).Value = "SortedBy: " + HttpContext.Current.Request.QueryString("SortedBy")
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Size = 9
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Merge = True
                worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            End If


            i = i + 2


            worksheet.Cells(i, 1).Value = "St #"
            worksheet.Cells(i, 1).Style.Font.Bold = True
            worksheet.Cells(i, 1).Style.Font.Size = 8
            worksheet.Cells(i, 1).Style.Font.Name = "Arial"

            worksheet.Cells(i, 2).Value = "Store Nick"
            worksheet.Cells(i, 2).Style.Font.Bold = True
            worksheet.Cells(i, 2).Style.Font.Size = 8
            worksheet.Cells(i, 2).Style.Font.Name = "Arial"

            worksheet.Cells(i, 3).Value = "IP"
            worksheet.Cells(i, 3).Style.Font.Bold = True
            worksheet.Cells(i, 3).Style.Font.Size = 8
            worksheet.Cells(i, 3).Style.Font.Name = "Arial"


            worksheet.Cells(i, 4).Value = "SMSx Version"
            worksheet.Cells(i, 4).Style.Font.Bold = True
            worksheet.Cells(i, 4).Style.Font.Size = 8
            worksheet.Cells(i, 4).Style.Font.Name = "Arial"


            worksheet.Cells(i, 5).Value = "Last Reported"
            worksheet.Cells(i, 5).Style.Font.Bold = True
            worksheet.Cells(i, 5).Style.Font.Size = 8
            worksheet.Cells(i, 5).Style.Font.Name = "Arial"



            worksheet.Cells(i, 6).Value = "FranchiseStatus"
            worksheet.Cells(i, 6).Style.Font.Bold = True
            worksheet.Cells(i, 6).Style.Font.Size = 8
            worksheet.Cells(i, 6).Style.Font.Name = "Arial"



            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(204, 255, 204))
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Top.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Right.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Left.Color.SetColor(System.Drawing.Color.Black)
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A" + i.ToString() + ":I" + i.ToString()).Style.Border.Bottom.Color.SetColor(System.Drawing.Color.Black)



            i = i + 1


            worksheet.Column(1).Width = 30
            worksheet.Column(2).Width = 30
            worksheet.Column(3).Width = 30
            worksheet.Column(4).Width = 30
            worksheet.Column(5).Width = 30
            worksheet.Column(6).Width = 30


            If dtDashboardStats.Rows.Count >= 1 Then

                For Each row As DataRow In dtDashboardStats.Rows
                    worksheet.Cells(i, 1).Value = Functions.IfNull(row("StoreNumber"), "")
                    worksheet.Cells(i, 1).Style.Font.Size = 8
                    worksheet.Cells(i, 1).Style.Font.Name = "Arial"


                    worksheet.Cells(i, 2).Style.Font.Size = 8
                    worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 2).Value = Functions.IfNull(row("StoreNick"), "- -")




                    worksheet.Cells(i, 3).Style.Font.Size = 8
                    worksheet.Cells(i, 3).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 3).Value = IIf(row("IsDynamicIP"), "&nbsp;Dynamic IP", row("SystemIP"))
                    worksheet.Cells(i, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 4).Style.Font.Size = 8
                    worksheet.Cells(i, 4).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 4).Value = Functions.IfNull(row("CurrentVersion"), " - -")
                    worksheet.Cells(i, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left


                    worksheet.Cells(i, 5).Style.Font.Size = 8
                    worksheet.Cells(i, 5).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 5).Value = IIf(row("LastReported") Is DBNull.Value, String.Format("{0:MMM dd, yyyy}", row("IssuedOn")), String.Format("{0:MMM dd, yyyy}", row("LastReported")))
                    worksheet.Cells(i, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    worksheet.Cells(i, 6).Style.Font.Size = 8
                    worksheet.Cells(i, 6).Style.Font.Name = "Arial"
                    worksheet.Cells(i, 6).Value = Functions.IfNull(row("FranchiseStatus"), " - -")
                    worksheet.Cells(i, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    i += 1

                Next
                i = i + 2

                worksheet.Cells(i, 1).Style.Font.Size = 8
                worksheet.Cells(i, 1).Style.Font.Bold = True
                worksheet.Cells(i, 1).Style.Font.Name = "Arial"
                ' worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Merge = True
                worksheet.Cells("A" + i.ToString + ":B" + i.ToString).Value = "Total Licenses"


                worksheet.Cells(i, 2).Style.Font.Size = 8
                worksheet.Cells(i, 2).Style.Font.Bold = True
                worksheet.Cells(i, 2).Style.Font.Name = "Arial"
                worksheet.Cells(i, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                worksheet.Cells(i, 2).Value = dtDashboardStats.Rows.Count().ToString()
            Else
                i = i + 8



                worksheet.Cells(17, 1).Value = "NO RECORD FOUND"
                worksheet.Cells(17, 1).Style.Font.Bold = True
                worksheet.Cells(17, 1).Style.Font.Size = 8
                worksheet.Cells(17, 1).Style.Font.Name = "Arial"

                worksheet.Cells("A17:I17").Merge = True
                worksheet.Cells("A17:I17").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            End If
            package.Save()
        End Using
        HttpContext.Current.Response.ContentType = "application/force-download"
        HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)

        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class
