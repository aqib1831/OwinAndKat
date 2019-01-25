				 <%@ WebHandler Language="VB" Class="ExcelGeneration" %>

Imports System
Imports System.Web
Imports System.IO
Imports System.Data
Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports System.Data.SqlClient
Imports System.Configuration

Public Class ExcelGeneration : Implements IHttpHandler : Implements IRequiresSessionState

    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        If HttpContext.Current.Request.QueryString("Action") = "FranchseeOpenTickets" Then
            ExportOpenTickets()
        Else
            ExportHistoricalTrackingList()
        End If

    End Sub
    Private Sub ExportHistoricalTrackingList()
        Dim FranchiseID As Int32 = HttpContext.Current.Request.QueryString("FranchiseID")
        Dim ClientID As Int32 = HttpContext.Current.Request.QueryString("ClientID")
        Dim Search As String = HttpContext.Current.Request.QueryString("Search")
        Dim Type As Int32 = HttpContext.Current.Request.QueryString("Type")
        Dim SubType As Int32 = HttpContext.Current.Request.QueryString("SubType")
        Dim DateFrom As DateTime = HttpContext.Current.Request.QueryString("DateFrom")
        Dim DateTo As DateTime = HttpContext.Current.Request.QueryString("DateTo")
        Dim AssingedBy As String = HttpContext.Current.Request.QueryString("AssingedBy")
        Dim PriorityID As Int32 = HttpContext.Current.Request.QueryString("PriorityID")
        Dim CompletedBy As Int32 = HttpContext.Current.Request.QueryString("CompletedBy")
        Dim RelatedTo As Int32 = HttpContext.Current.Request.QueryString("RelatedTo")



        Dim strCurrentDir As String = Functions.TempExcelPath
        If Directory.Exists(strCurrentDir) = False Then
            Directory.CreateDirectory(strCurrentDir)
        End If
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "Actvities_" & Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If

        Dim dtAdminHistory As DataTable = Portal.BLL.Activities.GetAdminHistoryForHelpDesk_Export(ClientID, FranchiseID, Search, "", 0, "", 0, 100, Type, SubType, DateFrom, DateTo, AssingedBy, PriorityID, CompletedBy, RelatedTo)
        'Dim dtAdminHistory As DataTable = Portal.BLL.Activities.GetAdminHistoryForHelpDesk(ClientID, FranchiseID, Search, "", 0, "", 0, 100, Type, SubType, DateFrom, DateTo, AssingedBy, PriorityID)
        Dim AdminHistoryCount As Integer = Portal.BLL.Activities.GetAdminHistoryCountForHelpDesk(ClientID, FranchiseID, Search, "", 0, Type, SubType, DateFrom, DateTo, AssingedBy, PriorityID, CompletedBy, RelatedTo)

        Dim dvAdminHistory As New DataView(dtAdminHistory)
        dvAdminHistory.RowFilter = "Subject NOT LIKE '%NSBS Backup Failed for %' AND Subject <> 'SMSx Terminal Keys Regenerated' AND Subject <> 'New SMSx Installation'"
        dtAdminHistory = dvAdminHistory.ToTable()

        Using package As New ExcelPackage(newFile)
            ' add a new worksheet to the empty workbook
            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("Closed Actvities")
            worksheet.Cells(1, 1).Value = ConfigurationManager.AppSettings("CompanyName")
            worksheet.Cells(1, 1).Style.Font.Size = 14
            worksheet.Cells(1, 1).Style.Font.Bold = True
            worksheet.Cells(1, 1).Style.Font.Name = "Calibri"

            worksheet.Cells(2, 1).Value = "Closed Actvities | " + AdminHistoryCount.ToString()
            worksheet.Cells(2, 1).Style.Font.Size = 12
            worksheet.Cells(2, 1).Style.Font.Bold = True
            worksheet.Cells(2, 1).Style.Font.Name = "Calibri"

            worksheet.Cells(3, 1).Value = DateFrom & " - " & DateTo
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Size = 12
            worksheet.Cells(3, 1).Style.Font.Name = "Calibri"

            worksheet.Cells(4, 1).Value = "Generated on: " & System.DateTime.Now & " "
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Size = 12
            worksheet.Cells(4, 1).Style.Font.Name = "Calibri"

            worksheet.Cells(6, 1).Value = " Ticket Number"
            worksheet.Cells(6, 1).Style.Font.Bold = True
            worksheet.Cells(6, 1).Style.Font.Size = 11
            worksheet.Cells(6, 1).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 1).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 2).Value = " Code"
            worksheet.Cells(6, 2).Style.Font.Bold = True
            worksheet.Cells(6, 2).Style.Font.Size = 11
            worksheet.Cells(6, 2).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 2).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 3).Value = " Store Nick"
            worksheet.Cells(6, 3).Style.Font.Bold = True
            worksheet.Cells(6, 3).Style.Font.Size = 11
            worksheet.Cells(6, 3).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 3).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 4).Value = " Store Number"
            worksheet.Cells(6, 4).Style.Font.Bold = True
            worksheet.Cells(6, 4).Style.Font.Size = 11
            worksheet.Cells(6, 4).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 4).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 5).Value = " Date"
            worksheet.Cells(6, 5).Style.WrapText = True
            worksheet.Cells(6, 5).Style.Font.Bold = True
            worksheet.Cells(6, 5).Style.Font.Size = 11
            worksheet.Cells(6, 5).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 5).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 6).Value = " Last Updated On"
            worksheet.Cells(6, 6).Style.WrapText = True
            worksheet.Cells(6, 6).Style.Font.Bold = True
            worksheet.Cells(6, 6).Style.Font.Size = 11
            worksheet.Cells(6, 6).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 6).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 7).Value = " Time Spent"
            worksheet.Cells(6, 7).Style.WrapText = True
            worksheet.Cells(6, 7).Style.Font.Bold = True
            worksheet.Cells(6, 7).Style.Font.Size = 11
            worksheet.Cells(6, 7).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 7).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 8).Value = " Created By"
            worksheet.Cells(6, 8).Style.WrapText = True
            worksheet.Cells(6, 8).Style.Font.Bold = True
            worksheet.Cells(6, 8).Style.Font.Size = 11
            worksheet.Cells(6, 8).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 8).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 9).Value = " Closed By"
            worksheet.Cells(6, 9).Style.WrapText = True
            worksheet.Cells(6, 9).Style.Font.Bold = True
            worksheet.Cells(6, 9).Style.Font.Size = 11
            worksheet.Cells(6, 9).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 9).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 10).Value = " Subject"
            worksheet.Cells(6, 10).Style.Font.Bold = True
            worksheet.Cells(6, 10).Style.Font.Size = 11
            worksheet.Cells(6, 10).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 10).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 11).Value = " Topic"
            worksheet.Cells(6, 11).Style.Font.Bold = True
            worksheet.Cells(6, 11).Style.Font.Size = 11
            worksheet.Cells(6, 11).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 11).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 12).Value = " Type"
            worksheet.Cells(6, 12).Style.Font.Bold = True
            worksheet.Cells(6, 12).Style.Font.Size = 11
            worksheet.Cells(6, 12).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 12).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 13).Value = " Survey Comments"
            worksheet.Cells(6, 13).Style.Font.Bold = True
            worksheet.Cells(6, 13).Style.Font.Size = 11
            worksheet.Cells(6, 13).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 13).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 14).Value = " Activity Rate"
            worksheet.Cells(6, 14).Style.Font.Bold = True
            worksheet.Cells(6, 14).Style.Font.Size = 11
            worksheet.Cells(6, 14).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 14).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells("A1:N1").Merge = True
            worksheet.Cells("A2:N2").Merge = True
            worksheet.Cells("A3:N3").Merge = True
            worksheet.Cells("A4:N4").Merge = True
            worksheet.Cells("A5:N5").Merge = True

            worksheet.Cells("A1:N1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A2:N2").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:N3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:N4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A5:N5").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("A6:N6").Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A6:N6").Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(66, 160, 40))
            worksheet.Cells("A6:N6").Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A6:N6").Style.Border.Right.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells("A6:N6").Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A6:N6").Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(66, 160, 40))
            worksheet.Cells("A6:N6").Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A6:N6").Style.Border.Right.Color.SetColor(System.Drawing.Color.White)

            worksheet.Column(1).Width = 15
            worksheet.Column(2).Width = 7
            worksheet.Column(3).Width = 20
            worksheet.Column(4).Width = 14
            worksheet.Column(5).Width = 17
            worksheet.Column(6).Width = 18
            worksheet.Column(7).Width = 12
            worksheet.Column(8).Width = 17
            worksheet.Column(9).Width = 17
            worksheet.Column(10).Width = 20
            worksheet.Column(11).Width = 20
            worksheet.Column(12).Width = 20
            worksheet.Column(13).Width = 25
            worksheet.Column(14).Width = 20
            Dim excelRow As Integer = 7
            For Each row As DataRow In dtAdminHistory.Rows

                worksheet.Cells(excelRow, 1).Value = row("TicketNumber")
                worksheet.Cells(excelRow, 1).Style.Font.Size = 11
                worksheet.Cells(excelRow, 1).Style.Font.Name = "Calibri"
                worksheet.Cells(excelRow, 1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                worksheet.Cells(excelRow, 2).Value = row("Code")
                worksheet.Cells(excelRow, 2).Style.Font.Size = 11
                worksheet.Cells(excelRow, 2).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 3).Value = row("StoreNick")
                worksheet.Cells(excelRow, 3).Style.Font.Size = 11
                worksheet.Cells(excelRow, 3).Style.Font.Name = "Calibri"

                '-------------------------------- Subject
                worksheet.Cells(excelRow, 4).Value = row("StoreNumber")
                worksheet.Cells(excelRow, 4).Style.Font.Size = 11
                worksheet.Cells(excelRow, 4).Style.Font.Name = "Calibri"
                worksheet.Cells(excelRow, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                '-------------------------------- Subject

                Dim strDate As String = Functions.IfNull(row("Date"), "")
                If strDate = String.Empty Then
                    worksheet.Cells(excelRow, 5).Value = String.Empty
                Else
                    worksheet.Cells(excelRow, 5).Value = Convert.ToDateTime(strDate).ToString("M/d/yy h:mm tt")
                End If
                worksheet.Cells(excelRow, 5).Style.Font.Size = 11
                worksheet.Cells(excelRow, 5).Style.Font.Name = "Calibri"

                Dim strLastUpdatedOn As String = Functions.IfNull(row("LastUpdatedOn"), "")
                If strLastUpdatedOn = String.Empty Then
                    worksheet.Cells(excelRow, 6).Value = String.Empty
                Else
                    worksheet.Cells(excelRow, 6).Value = Convert.ToDateTime(strLastUpdatedOn).ToString("M/d/yy h:mm tt")
                End If
                'worksheet.Cells(excelRow, 6).Value = Functions.IfNull(row("LastUpdatedOn"), "")
                worksheet.Cells(excelRow, 6).Style.Font.Size = 11
                worksheet.Cells(excelRow, 6).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 7).Value = Functions.IfNull(row("TimeSpent"), "")
                worksheet.Cells(excelRow, 7).Style.Font.Size = 11
                worksheet.Cells(excelRow, 7).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 8).Value = Functions.IfNull(row("CreatedBy"), "")
                worksheet.Cells(excelRow, 8).Style.Font.Size = 11
                worksheet.Cells(excelRow, 8).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 9).Value = Functions.IfNull(row("ClosedBy"), "")
                worksheet.Cells(excelRow, 9).Style.Font.Size = 11
                worksheet.Cells(excelRow, 9).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 10).Value = Functions.IfNull(row("Subject"), "")
                worksheet.Cells(excelRow, 10).Style.Font.Size = 11
                worksheet.Cells(excelRow, 10).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 11).Value = Functions.IfNull(row("Topic"), "")
                worksheet.Cells(excelRow, 11).Style.Font.Size = 11
                worksheet.Cells(excelRow, 11).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 12).Value = Functions.IfNull(row("Type"), "")
                worksheet.Cells(excelRow, 12).Style.Font.Size = 11
                worksheet.Cells(excelRow, 12).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 13).Value = Functions.IfNull(row("SurveyComments"), "")
                worksheet.Cells(excelRow, 13).Style.Font.Size = 11
                worksheet.Cells(excelRow, 13).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 14).Value = Functions.IfNull(row("ActivityRate"), "")
                worksheet.Cells(excelRow, 14).Style.Font.Size = 11
                worksheet.Cells(excelRow, 14).Style.Font.Name = "Calibri"

                excelRow += 1
            Next
            package.Save()
        End Using
        'HttpContext.Current.Response.ContentType = "application/force-download"
        'HttpContext.Current.Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
        'HttpContext.Current.Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)
        'HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        'newFile.Delete()
        'HttpContext.Current.Response.End()


        HttpContext.Current.Response.Buffer = True
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" & strFileName)
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel"
        HttpContext.Current.Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
        newFile.Delete()
        HttpContext.Current.Response.End()
    End Sub

    Private Sub ExportOpenTickets()


        Dim FranchiseID As Int32 = HttpContext.Current.Request.QueryString("FranchiseID")
        Dim ddlTopics As Int32 = HttpContext.Current.Request.QueryString("ddlTopics")
        Dim AssingedBy As String = HttpContext.Current.Request.QueryString("AssingedBy")
        Dim ddlWaitingForNames As String = HttpContext.Current.Request.QueryString("ddlWaitingForNames")
        Dim ddlPriority As Int32 = HttpContext.Current.Request.QueryString("ddlPriority")
        Dim ddlFilters As Int32 = HttpContext.Current.Request.QueryString("ddlFilters")
        Dim ClientID As Int32 = HttpContext.Current.Request.QueryString("ClientID")
        Dim PriorityID As Int32 = HttpContext.Current.Request.QueryString("PriorityID")
        Dim Search As String = HttpContext.Current.Request.QueryString("Search")


        Dim strCurrentDir As String = Functions.TempExcelPath
        If Directory.Exists(strCurrentDir) = False Then
            Directory.CreateDirectory(strCurrentDir)
        End If
        Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
        Dim strFileName As String = "OpenTickets_" & Date.Now.Ticks & ".xlsx"
        Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        If newFile.Exists Then
            newFile.Delete()
            ' ensures we create a new workbook
            newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
        End If

        Dim dtAdminHistory_Export As DataTable = Portal.BLL.Activities.GetAdminInboxForHelpDesk_ByClientIdList_Export("", FranchiseID, ClientID, ddlTopics, Search, ddlFilters, AssingedBy, ddlWaitingForNames, 0, 10000, 0, ddlPriority, "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25")
        Dim AdminHistoryCount As Integer = Portal.BLL.Activities.GetAdminInboxForHelpDeskcount_ByClientIdList_Export(FranchiseID, ClientID, ddlTopics, Search, ddlFilters, AssingedBy, ddlWaitingForNames, 0, ddlPriority, "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25")
        'Dim dvAdminHistory As New DataView(dtAdminHistory_Export)
        'dvAdminHistory.RowFilter = "Subject NOT LIKE '%NSBS Backup Failed for %' AND Subject <> 'SMSx Terminal Keys Regenerated' AND Subject <> 'New SMSx Installation'"
        'dtAdminHistory_Export = dvAdminHistory.ToTable()

        Using package As New ExcelPackage(newFile)

            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("Open Tickets")
            worksheet.Cells(3, 1).Value = ConfigurationManager.AppSettings("CompanyName")
            worksheet.Cells(3, 1).Style.Font.Size = 14
            worksheet.Cells(3, 1).Style.Font.Bold = True
            worksheet.Cells(3, 1).Style.Font.Name = "Calibri"

            worksheet.Cells(4, 1).Value = "Open Tickets | " + AdminHistoryCount.ToString()
            worksheet.Cells(4, 1).Style.Font.Size = 12
            worksheet.Cells(4, 1).Style.Font.Bold = True
            worksheet.Cells(4, 1).Style.Font.Name = "Calibri"

            worksheet.Cells(5, 1).Value = "Generated on: " & System.DateTime.Now & " "
            worksheet.Cells(5, 1).Style.Font.Bold = True
            worksheet.Cells(5, 1).Style.Font.Size = 12
            worksheet.Cells(5, 1).Style.Font.Name = "Calibri"

            worksheet.Cells(6, 1).Value = " Ticket Number"
            worksheet.Cells(6, 1).Style.Font.Bold = True
            worksheet.Cells(6, 1).Style.Font.Size = 11
            worksheet.Cells(6, 1).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 1).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 2).Value = " Store Number"
            worksheet.Cells(6, 2).Style.Font.Bold = True
            worksheet.Cells(6, 2).Style.Font.Size = 11
            worksheet.Cells(6, 2).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 2).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 3).Value = " Store Name"
            worksheet.Cells(6, 3).Style.Font.Bold = True
            worksheet.Cells(6, 3).Style.Font.Size = 11
            worksheet.Cells(6, 3).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 3).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 4).Value = " Client"
            worksheet.Cells(6, 4).Style.WrapText = True
            worksheet.Cells(6, 4).Style.Font.Bold = True
            worksheet.Cells(6, 4).Style.Font.Size = 11
            worksheet.Cells(6, 4).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 4).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 5).Value = " Subject"
            worksheet.Cells(6, 5).Style.Font.Bold = True
            worksheet.Cells(6, 5).Style.Font.Size = 11
            worksheet.Cells(6, 5).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 5).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 6).Value = " Status"
            worksheet.Cells(6, 6).Style.Font.Bold = True
            worksheet.Cells(6, 6).Style.Font.Size = 11
            worksheet.Cells(6, 6).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 6).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 7).Value = " Created On"
            worksheet.Cells(6, 7).Style.WrapText = True
            worksheet.Cells(6, 7).Style.Font.Bold = True
            worksheet.Cells(6, 7).Style.Font.Size = 11
            worksheet.Cells(6, 7).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 7).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 8).Value = " Last Updated"
            worksheet.Cells(6, 8).Style.WrapText = True
            worksheet.Cells(6, 8).Style.Font.Bold = True
            worksheet.Cells(6, 8).Style.Font.Size = 11
            worksheet.Cells(6, 8).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 8).Style.Font.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells(6, 9).Value = " Created By"
            worksheet.Cells(6, 9).Style.WrapText = True
            worksheet.Cells(6, 9).Style.Font.Bold = True
            worksheet.Cells(6, 9).Style.Font.Size = 11
            worksheet.Cells(6, 9).Style.Font.Name = "Calibri"
            worksheet.Cells(6, 9).Style.Font.Color.SetColor(System.Drawing.Color.White)
          '  worksheet.Cells(6,9).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(66, 160, 40))
            worksheet.Cells("A1:H1").Merge = True
            worksheet.Cells("A2:H2").Merge = True
            worksheet.Cells("A3:H3").Merge = True
            worksheet.Cells("A4:H4").Merge = True
            worksheet.Cells("A5:H5").Merge = True

            worksheet.Cells("A1:H1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A2:H2").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A3:H3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A4:H4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells("A5:H5").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("A6:H6").Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A6:H6").Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(66, 160, 40))
            worksheet.Cells("A6:H6").Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A6:H6").Style.Border.Right.Color.SetColor(System.Drawing.Color.White)

            worksheet.Cells("A6:H6").Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells("A6:H6").Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(66, 160, 40))
            worksheet.Cells("A6:H6").Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells("A6:H6").Style.Border.Right.Color.SetColor(System.Drawing.Color.White)
            
            worksheet.Cells(6,9).Style.Fill.PatternType = ExcelFillStyle.Solid
            worksheet.Cells(6,9).Style.Fill.BackgroundColor.SetColor(System.Drawing.Color.FromArgb(66, 160, 40))
            worksheet.Cells(6,9).Style.Border.Right.Style = ExcelBorderStyle.Thin
            worksheet.Cells(6,9).Style.Border.Right.Color.SetColor(System.Drawing.Color.White)

            worksheet.Column(1).Width = 15
            worksheet.Column(2).Width = 20
            worksheet.Column(3).Width = 40
            worksheet.Column(4).Width = 20
            worksheet.Column(5).Width = 45
            worksheet.Column(6).Width = 18
            worksheet.Column(7).Width = 18
            worksheet.Column(8).Width = 18
            worksheet.Column(9).Width = 20  
            Dim excelRow As Integer = 7
            For Each row As DataRow In dtAdminHistory_Export.Rows

                worksheet.Cells(excelRow, 1).Value = Functions.GetActivityPrefix(row("Activity_Type")) & row("Activity_ID")
                worksheet.Cells(excelRow, 1).Style.Font.Size = 11
                worksheet.Cells(excelRow, 1).Style.Font.Name = "Calibri"
                worksheet.Cells(excelRow, 1).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                worksheet.Cells(excelRow, 2).Value = row("StoreNumber")
                worksheet.Cells(excelRow, 2).Style.Font.Size = 11
                worksheet.Cells(excelRow, 2).Style.Font.Name = "Calibri"
                worksheet.Cells(excelRow, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                worksheet.Cells(excelRow, 3).Value = row("StoreNick")
                worksheet.Cells(excelRow, 3).Style.Font.Size = 11
                worksheet.Cells(excelRow, 3).Style.Font.Name = "Calibri"
                worksheet.Cells(excelRow, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                worksheet.Cells(excelRow, 4).Value = Functions.IfNull(row("ClientCode"), "")
                worksheet.Cells(excelRow, 4).Style.Font.Size = 11
                worksheet.Cells(excelRow, 4).Style.Font.Name = "Calibri"
                worksheet.Cells(excelRow, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                worksheet.Cells(excelRow, 5).Value = Functions.IfNull(row("Subject"), "")
                worksheet.Cells(excelRow, 5).Style.Font.Size = 11
                worksheet.Cells(excelRow, 5).Style.Font.Name = "Calibri"


                worksheet.Cells(excelRow, 6).Value = row("ActivityStateText") & IIf(row("ActivityState") = 4, ":" & Functions.StringTruncate(Functions.IfNull(row("WaitingForName"), ""), 15), "")
                worksheet.Cells(excelRow, 6).Style.Font.Size = 11
                worksheet.Cells(excelRow, 6).Style.Font.Name = "Calibri"



                Dim strDate As String = Functions.IfNull(row("Activity_Date"), "")
                If strDate = String.Empty Then
                    worksheet.Cells(excelRow, 7).Value = String.Empty
                Else
                    worksheet.Cells(excelRow, 7).Value = Functions.FormatDateByPattern(row("Activity_Date"), Functions.DatePattern.Format1)
                End If
                worksheet.Cells(excelRow, 7).Style.Font.Size = 11
                worksheet.Cells(excelRow, 7).Style.Font.Name = "Calibri"


                Dim strLastUpdatedOn As String = Functions.IfNull(row("LastUpdatedOn"), "")
                If strLastUpdatedOn = String.Empty Then
                    worksheet.Cells(excelRow, 8).Value = String.Empty
                Else
                    worksheet.Cells(excelRow, 8).Value =Functions.FormatDateByPattern(row("LastUpdatedOn"), Functions.DatePattern.Format1)
                End If
                worksheet.Cells(excelRow, 8).Style.Font.Size = 11
                worksheet.Cells(excelRow, 8).Style.Font.Name = "Calibri"

                worksheet.Cells(excelRow, 9).Value = Functions.IfNull(row("CreatedBy"), "")
                worksheet.Cells(excelRow, 9).Style.Font.Size = 11
                worksheet.Cells(excelRow, 9).Style.Font.Name = "Calibri"
                worksheet.Cells(excelRow, 9).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                excelRow += 1
            Next
            package.Save()
        End Using

        HttpContext.Current.Response.Buffer = True
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment; filename=" & strFileName)
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel"
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