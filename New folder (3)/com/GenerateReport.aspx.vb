					 																								   					  
						 								  										 																		 						 									   												  			 								 														 		   				  															 												  Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.Office.Interop.Excel
Imports System.Globalization
Imports System.IO
Imports OfficeOpenXml
Imports OfficeOpenXml.Style
Imports Microsoft.VisualBasic


Partial Class com_GenerateReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'StoreSelectionCtrl.AddItem("Item0", "0")
        'StoreSelectionCtrl.AddItem("Item1", "1")
        'StoreSelectionCtrl.AddItem("Item2", "2")
        'StoreSelectionCtrl.AddItem("Item3", "3")
        'StoreSelectionCtrl.AddItem("Item4", "4")
        If Not IsPostBack Then
            Dim dateTo As New DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day)
            Dim dateFrom As DateTime = dateTo.AddMonths(-1)
            SDR_txtFromDate.Text = dateFrom.ToShortDateString()
            SDR_txtToDate.Text = dateTo.ToShortDateString()
            SSR_txtFromDate.Text = dateFrom.ToShortDateString()
            SSR_txtToDate.Text = dateTo.ToShortDateString()
            TR_txtFromDate.Text = dateFrom.ToShortDateString()
            TR_txtToDate.Text = dateTo.ToShortDateString()
        End If


    End Sub


    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        'Dim arg As New DataSourceSelectArguments()
        'Dim dv As DataView = CType(sdsStores.Select(arg), DataView)
        'If (dv Is Nothing) Then
        '    Return
        'End If

        'Dim dt As System.Data.DataTable = dv.ToTable()
        'Dim count As Integer = dt.Rows.Count
        'For i As Integer = 0 To count - 1
        '    Dim dataRow As DataRow = dt.Rows(i)
        '    Dim storeName As String = dataRow("storeNumber").ToString()
        '    Dim storeID As String = dataRow("ID")
        '    StoreSelectionCtrl.AddItem(storeName, storeID)
        'Next
        StoreSelectionCtrl.ClearSelected()
        Dim reader As SqlDataReader = SQLDataSourceToDataReader(sdsStores)
        Dim storeNick As String = Nothing
        Dim storeNo As String = Nothing
        While reader.Read()
            storeNick = reader("StoreNick").ToString()
            storeNo = reader("StoreNumber").ToString()
            StoreSelectionCtrl.AddItem(storeNo & " - " & storeNick, reader("ID"))
        End While

    End Sub

    Protected Sub GenerateReport()
       

        'System.Diagnostics.Debugger.Launch()
        Dim fileName As String = "Report_" + DateTime.Now.ToString("dd-MM-yy_H-mm-ss") + ".xls"
        Dim filePath As String = MapPath("tempReports/" + fileName)
        Dim newFile As New FileInfo(filePath)
        'If (File.Exists(MapPath(fileName))) Then
        '    File.Delete(MapPath(fileName))
        'End If
        Dim excelPackg As New ExcelPackage(newFile)
        Dim reader As SqlDataReader = Nothing
        Dim worksheet As ExcelWorksheet = Nothing

        Dim fromDate As DateTime = Nothing
        Dim toDate As DateTime = Nothing
        '=================================================Survey Summery Report==============================================
        If (radioSSR.Checked) Then
            Dim selectedValue As String = SSR_ddlPeriod.SelectedValue
            If (selectedValue = "6") Then
                fromDate = DateTime.Parse(SSR_txtFromDate.Text)
                toDate = DateTime.Parse(SSR_txtToDate.Text)
            Else
                GetDatesFromValue(selectedValue, fromDate, toDate)
            End If
            Dim storeIDs As String = StoreSelectionCtrl.GetSelectedCSValues
            Dim clientID As String = ddlClient.SelectedValue
            sdsGetSurveySummeryReport.SelectParameters.Clear()
            sdsGetSurveySummeryReport.SelectParameters.Add("dateFrom", TypeCode.DateTime, fromDate.ToString())
            sdsGetSurveySummeryReport.SelectParameters.Add("dateTo", TypeCode.DateTime, toDate.ToString())
            sdsGetSurveySummeryReport.SelectParameters.Add("clientID", clientID)
            sdsGetSurveySummeryReport.SelectParameters.Add("storeIDs", storeIDs)

            reader = SQLDataSourceToDataReader(sdsGetSurveySummeryReport)
            worksheet = excelPackg.Workbook.Worksheets.Add("Survey Summary Report")
            worksheet.Cells("D2:F2").Value = "Netsolace, Inc."
            worksheet.Cells("D2:F2").Merge = True
            worksheet.Cells("D2:F2").Style.Font.Bold = True
            worksheet.Cells("D2:F2").Style.Font.Size = 16
            worksheet.Cells("D2:F2").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("D3:F3").Value = "Survey Summary Report"
            worksheet.Cells("D3:F3").Merge = True
            worksheet.Cells("D3:F3").Style.Font.Bold = True
            worksheet.Cells("D3:F3").Style.Font.Size = 14
            worksheet.Cells("D3:F3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("D4:F4").Value = "Generated On: " + Date.Now.ToString("MM/dd/yyyy")
            worksheet.Cells("D4:F4").Merge = True
            worksheet.Cells("D4:F4").Style.Font.Bold = False
            worksheet.Cells("D4:F4").Style.Font.Size = 12
            worksheet.Cells("D4:F4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("D7:F7").Value = "Date: " + fromDate.ToShortDateString() + " - " + toDate.ToShortDateString()
            worksheet.Cells("D7:F7").Merge = True
            worksheet.Cells("D7:F7").Style.Font.Bold = True
            worksheet.Cells("D7:F7").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells(10, 2).Value = "Client"
            worksheet.Cells(10, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells(10, 3).Value = "Store Number"
            worksheet.Cells(10, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells(10, 4).Value = "Store Nick"
            worksheet.Cells(10, 4).Style.ShrinkToFit = True
            worksheet.Cells(10, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells(10, 5).Value = "Great"
            worksheet.Cells(10, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(10, 6).Value = "Okay"
            worksheet.Cells(10, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(10, 7).Value = "Not Happy"
            worksheet.Cells(10, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(10, 8).Value = "Total"
            worksheet.Cells(10, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            Dim rowNumber As Integer = 11
            If (Not reader Is Nothing) Then
                While reader.Read()
                    worksheet.Cells(rowNumber, 2).Value = reader("Code")
                    worksheet.Cells(rowNumber, 3).Value = reader("StoreNumber")
                    worksheet.Cells(rowNumber, 4).Value = reader("StoreNick")
                    worksheet.Cells(rowNumber, 5).Value = reader("Great")
                    worksheet.Cells(rowNumber, 6).Value = reader("Okay")
                    worksheet.Cells(rowNumber, 7).Value = reader("NotHappy")
                    worksheet.Cells(rowNumber, 8).Value = reader("Total")
                    rowNumber = rowNumber + 1
                End While
            End If
            rowNumber = rowNumber + 1
            worksheet.Cells(rowNumber, 4).Value = "Grand Total"
            worksheet.Cells(rowNumber, 5).Formula = String.Format("Sum(E11:E{0})", rowNumber - 1)
            worksheet.Cells(rowNumber, 6).Formula = String.Format("Sum(F11:F{0})", rowNumber - 1)
            worksheet.Cells(rowNumber, 7).Formula = String.Format("Sum(G11:G{0})", rowNumber - 1)
            worksheet.Cells(rowNumber, 8).Formula = String.Format("Sum(H11:H{0})", rowNumber - 1)

            
            'worksheet.Cells(String.Format("B10:G{0}", rowNumber)).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            'GranTotal cell style
            worksheet.Cells(String.Format("C{0}", rowNumber)).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
            'setting cells Width
            worksheet.Cells("B1").AutoFitColumns(10)
            worksheet.Cells("C1").AutoFitColumns(25)
            worksheet.Cells("D1:G1").AutoFitColumns(20)
            '==================================================================================================================

            '============================================Survey Detail Report==================================================
        ElseIf (radioSDR.Checked) Then
            Dim selectedValue As String = SDR_ddlPeriod.SelectedValue
            If (selectedValue = "6") Then
                fromDate = DateTime.Parse(SDR_txtFromDate.Text)
                toDate = DateTime.Parse(SDR_txtToDate.Text)
            Else
                GetDatesFromValue(selectedValue, fromDate, toDate)
            End If
            Dim storeIDs As String = StoreSelectionCtrl.GetSelectedCSValues
            'If (StoreSelectionCtrl.SelectedValues.Length = 0) Then
            '    storeIDs = "0"
            'End If
            Dim priority As Integer = Integer.Parse(SDR_ddlPriority.SelectedValue)
            Dim feedback As Integer = Integer.Parse(SDR_ddlFeedback.SelectedValue)
            sdsGetSurveyDetailReport.SelectParameters.Clear()
            sdsGetSurveyDetailReport.SelectParameters.Add("dateFrom", TypeCode.DateTime, fromDate.ToString())
            sdsGetSurveyDetailReport.SelectParameters.Add("dateTo", TypeCode.DateTime, toDate.ToString())
            sdsGetSurveyDetailReport.SelectParameters.Add("priority", priority)
            sdsGetSurveyDetailReport.SelectParameters.Add("feedback", feedback)
            sdsGetSurveyDetailReport.SelectParameters.Add("storeIDs", storeIDs)

            reader = SQLDataSourceToDataReader(sdsGetSurveyDetailReport)
            worksheet = excelPackg.Workbook.Worksheets.Add("Survey Detail Report")

            worksheet.Cells("H2:J2").Value = "Netsolace, Inc"
            worksheet.Cells("H2:J2").Merge = True
            worksheet.Cells("H2:J2").Style.Font.Bold = True
            worksheet.Cells("H2:J2").Style.Font.Size = 16
            worksheet.Cells("H2:J2").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            worksheet.Cells("H3:J3").Value = "Survey Detail Report"
            worksheet.Cells("H3:J3").Merge = True
            worksheet.Cells("H3:J3").Style.Font.Bold = True
            worksheet.Cells("H3:J3").Style.Font.Size = 14
            worksheet.Cells("H3:J3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("H4:J4").Value = "Generated On: " + Date.Now.ToString("MM/dd/yyyy")
            worksheet.Cells("H4:J4").Merge = True
            worksheet.Cells("H4:J4").Style.Font.Bold = False
            worksheet.Cells("H4:J4").Style.Font.Size = 12
            worksheet.Cells("H4:J4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("H7:J7").Value = "Date: " + fromDate.ToShortDateString() + " - " + toDate.ToShortDateString()
            worksheet.Cells("H7:J7").Merge = True
            worksheet.Cells("H7:J7").Style.Font.Bold = True
            worksheet.Cells("H7:J7").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            'worksheet.Cells(4, 8).Value = fromDate.ToShortDateString()
            'worksheet.Cells(4, 9).Value = toDate.ToShortDateString()

            worksheet.Cells(9, 2).Value = "Ticket Number"
            worksheet.Cells(9, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 3).Value = "Client"
            worksheet.Cells(9, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells(9, 4).Value = "Store Number"
            worksheet.Cells(9, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells(9, 5).Value = "Store Nick"
            worksheet.Cells(9, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 6).Value = "Date Created"
            worksheet.Cells(9, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 7).Value = "Date Closed"
            worksheet.Cells(9, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 8).Value = "Created By"
            worksheet.Cells(9, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 9).Value = "Closed By"
            worksheet.Cells(9, 9).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 10).Value = "Subject"
            worksheet.Cells(9, 10).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 11).Value = "Priority"
            worksheet.Cells(9, 11).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 12).Value = "Type"
            worksheet.Cells(9, 12).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 13).Value = "Topic"
            worksheet.Cells(9, 13).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 14).Value = "Related To"
            worksheet.Cells(9, 14).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 15).Value = "Issue"
            worksheet.Cells(9, 15).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 16).Value = "Survey Rating"
            worksheet.Cells(9, 16).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(9, 17).Value = "Survey Feedback"
            worksheet.Cells(9, 17).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            Dim rowNumber As Integer = 10
            If (Not reader Is Nothing) Then
                While reader.Read()
                    worksheet.Cells(rowNumber, 2).Value = reader("ticketNumber")
                    worksheet.Cells(rowNumber, 2).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                    worksheet.Cells(rowNumber, 3).Value = reader("code")
                    worksheet.Cells(rowNumber, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 4).Value = reader("StoreNumber")
                    worksheet.Cells(rowNumber, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right

                    worksheet.Cells(rowNumber, 5).Value = reader("StoreNick")
                        worksheet.Cells(rowNumber, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left

                    If (Not IsDBNull(reader("date"))) Then
                        worksheet.Cells(rowNumber, 6).Value = CType(reader("date"), DateTime).ToShortDateString()
                        worksheet.Cells(rowNumber, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    End If
                    If (Not IsDBNull(reader("lastUpdatedOn"))) Then
                        worksheet.Cells(rowNumber, 7).Value = CType(reader("lastUpdatedOn"), DateTime).ToShortDateString()
                    worksheet.Cells(rowNumber, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    End If

                    worksheet.Cells(rowNumber, 8).Value = reader("createdBy")
                    worksheet.Cells(rowNumber, 8).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 9).Value = reader("closedBy")
                    worksheet.Cells(rowNumber, 9).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 10).Value = reader("subject")
                    worksheet.Cells(rowNumber, 10).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 11).Value = Functions.GetActivityPriorityByID(Integer.Parse(reader("priority")))
                    worksheet.Cells(rowNumber, 11).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    Dim type As Portal.BLL.Enumeration.ActivityType = Integer.Parse(reader("type"))
                    worksheet.Cells(rowNumber, 12).Value = type.ToString()
                    worksheet.Cells(rowNumber, 12).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 13).Value = reader("topic")
                    worksheet.Cells(rowNumber, 13).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 14).Value = reader("title")
                    worksheet.Cells(rowNumber, 14).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 15).Value = reader("issue")
                    worksheet.Cells(rowNumber, 15).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 16).Value = reader("activityrate")
                    worksheet.Cells(rowNumber, 16).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 17).Value = reader("surveyComments")
                    worksheet.Cells(rowNumber, 17).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    rowNumber = rowNumber + 1
                End While
            End If


            
            ' header and values cell
            'worksheet.Cells(String.Format("B9:P{0}", rowNumber)).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            'setting cells Width
            worksheet.Cells("B1:P1").AutoFitColumns(15)
            worksheet.Cells("D1").AutoFitColumns(25)
            worksheet.Cells("M1").AutoFitColumns(25)


            '==================================================================================================================

            '=========================================Technician Report=========================================================
        ElseIf (radioTR.Checked) Then
            Dim selectedValue As String = TR_ddlPeriod.SelectedValue
            Dim storeIDs As String = StoreSelectionCtrl.GetSelectedCSValues
            If (selectedValue = "6") Then
                fromDate = DateTime.Parse(TR_txtFromDate.Text)
                toDate = DateTime.Parse(TR_txtToDate.Text)
            Else
                GetDatesFromValue(selectedValue, fromDate, toDate)
            End If
            Dim technicianID As Integer = TR_ddlTechnician.SelectedValue
            sdsGetTechnicianReport.SelectParameters.Clear()
            sdsGetTechnicianReport.SelectParameters.Add("dateFrom", TypeCode.DateTime, fromDate.ToString())
            sdsGetTechnicianReport.SelectParameters.Add("dateTo", TypeCode.DateTime, toDate.ToString())
            sdsGetTechnicianReport.SelectParameters.Add("technicianID", technicianID)
            sdsGetTechnicianReport.SelectParameters.Add("storeIDs", storeIDs)

            reader = SQLDataSourceToDataReader(sdsGetTechnicianReport)
            worksheet = excelPackg.Workbook.Worksheets.Add("Technician Report")

            worksheet.Cells("D2:F2").Value = "Netsolace, Inc"
            worksheet.Cells("D2:F2").Merge = True
            worksheet.Cells("D2:F2").Style.Font.Bold = True
            worksheet.Cells("D2:F2").Style.Font.Size = 16
            worksheet.Cells("D2:F2").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("D3:F3").Value = "Technician Report"
            worksheet.Cells("D3:F3").Merge = True
            worksheet.Cells("D3:F3").Style.Font.Bold = True
            worksheet.Cells("D3:F3").Style.Font.Size = 14
            worksheet.Cells("D3:F3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("D4:F4").Value = "Generated On: " + Date.Now.ToString("MM/dd/yyyy")
            worksheet.Cells("D4:F4").Merge = True
            worksheet.Cells("D4:F4").Style.Font.Bold = False
            worksheet.Cells("D4:F4").Style.Font.Size = 12
            worksheet.Cells("D4:F4").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells("D7:F7").Value = "Date: " + fromDate.ToShortDateString() + " - " + toDate.ToShortDateString()
            worksheet.Cells("D7:F7").Merge = True
            worksheet.Cells("D7:F7").Style.Font.Bold = True
            worksheet.Cells("D7:F7").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

            worksheet.Cells(10, 3).Value = "Technician"
            worksheet.Cells(10, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(10, 4).Value = "Great"
            worksheet.Cells(10, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(10, 5).Value = "Okay"
            worksheet.Cells(10, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(10, 6).Value = "Not Happy"
            worksheet.Cells(10, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
            worksheet.Cells(10, 7).Value = "Total"
            worksheet.Cells(10, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Center


            Dim rowNumber As Integer = 11
            If (Not reader Is Nothing) Then
                While reader.Read()
                    worksheet.Cells(rowNumber, 3).Value = reader("FullName")
                    worksheet.Cells(rowNumber, 3).Style.HorizontalAlignment = ExcelHorizontalAlignment.Left
                    worksheet.Cells(rowNumber, 4).Value = reader("Great")
                    worksheet.Cells(rowNumber, 4).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                    worksheet.Cells(rowNumber, 5).Value = reader("Okay")
                    worksheet.Cells(rowNumber, 5).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                    worksheet.Cells(rowNumber, 6).Value = reader("NotHappy")
                    worksheet.Cells(rowNumber, 6).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                    worksheet.Cells(rowNumber, 7).Value = reader("Total")
                    worksheet.Cells(rowNumber, 7).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
                    rowNumber = rowNumber + 1
                End While
            End If
            rowNumber = rowNumber + 1
            worksheet.Cells(rowNumber, 3).Value = "Grand Total"
            worksheet.Cells(rowNumber, 4).Formula = String.Format("Sum(D11:D{0})", rowNumber - 1)
            worksheet.Cells(rowNumber, 5).Formula = String.Format("Sum(E11:E{0})", rowNumber - 1)
            worksheet.Cells(rowNumber, 6).Formula = String.Format("Sum(F11:F{0})", rowNumber - 1)
            worksheet.Cells(rowNumber, 7).Formula = String.Format("Sum(G11:G{0})", rowNumber - 1)

            'GranTotal cell style
            worksheet.Cells(String.Format("C{0}", rowNumber)).Style.HorizontalAlignment = ExcelHorizontalAlignment.Right
            'setting cells Width
            worksheet.Cells("C1").AutoFitColumns(25)
            worksheet.Cells("D1:G1").AutoFitColumns(20)
            '=================================================================================================================
        End If

        excelPackg.Save()
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "filters", "showFiltersOnPostBack()", True)
        'download

        Response.Clear()
        Context.ClearError()
        Response.AddHeader("Content-disposition", "attachment; filename=" + fileName)
        Response.ContentType = "application/vnd.ms-excel"
        Response.TransmitFile(filePath)
        Response.Flush()
        File.Delete(filePath)
        Response.End()
        'Filters
    End Sub

    Protected Function SQLDataSourceToDataReader(ByRef sqlDataSource As SqlDataSource) As SqlDataReader
        Dim arg As New DataSourceSelectArguments()
        Dim reader As SqlDataReader = CType(sqlDataSource.Select(arg), SqlDataReader)
        If (reader Is Nothing) Then
            Return Nothing
        End If
        Return reader
    End Function

    Protected Sub GetDatesFromValue(ByVal value As String, ByRef fromDate As DateTime, ByRef toDate As DateTime)
        Dim now As New DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day)
        'this week
        If (value = "0") Then
            Dim dayOfWeek As Integer = now.DayOfWeek
            fromDate = now.AddDays(0 - dayOfWeek)
            toDate = now
            'Last Week
        ElseIf (value = "1") Then
            Dim dayOfWeek As Integer = now.DayOfWeek
            toDate = now.AddDays(0 - dayOfWeek - 1)
            fromDate = toDate.AddDays(-6)
            'this month
        ElseIf (value = "2") Then
            Dim dayOfMonth As Integer = now.Day
            fromDate = now.AddDays(0 - dayOfMonth)
            toDate = now
            'last month
        ElseIf (value = "3") Then
            Dim dayOfMonth As Integer = now.Day
            toDate = now.AddDays(0 - dayOfMonth)
            fromDate = New DateTime(toDate.Year, toDate.Month, 1)
            'this year
        ElseIf (value = "4") Then
            Dim dayOfYear As Integer = now.DayOfYear
            fromDate = now.AddDays(1 - dayOfYear)
            toDate = now
            'last year
        ElseIf (value = "5") Then
            Dim dayOfYear As Integer = now.DayOfYear
            toDate = now.AddDays(0 - dayOfYear)
            fromDate = New DateTime(toDate.Year, 1, 1)
        End If

    End Sub

    Protected Sub btnGenerateReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerateReport.Click
        GenerateReport()

    End Sub
    'Public Sub GenerateExcelWithEPPlus()

    '    If Not String.IsNullOrEmpty(Request.QueryString("SupplierID")) Then
    '        hdnSupplierID.Value = Request.QueryString("SupplierID")
    '    Else
    '        hdnSupplierID.Value = 0
    '    End If

    '    If Not String.IsNullOrEmpty(Request.QueryString("Status")) Then
    '        hdnStatus.Value = Request.QueryString("Status")
    '    Else
    '        hdnStatus.Value = 0
    '    End If
    '    If Not String.IsNullOrEmpty(Request.QueryString("CategoryID")) Then
    '        hdnCategoryID.Value = Request.QueryString("CategoryID")
    '    Else
    '        hdnCategoryID.Value = 0
    '    End If
    '    If Not String.IsNullOrEmpty(Request.QueryString("Search")) Then
    '        hdnSearch.Value = Request.QueryString("Search")
    '    Else
    '        hdnSearch.Value = ""
    '    End If

    '    Dim strCurrentDir As String = ConfigurationManager.AppSettings("ExcelPath")
    '    Dim outputDir As DirectoryInfo = New DirectoryInfo(strCurrentDir)
    '    Dim strFileName As String = "SCM_ProductsReport_" & Functions.GetDateTimeUniqueString() & ".xlsx"
    '    Dim newFile As New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
    '    Dim rdrSupplierDetail As SqlDataReader

    '    Dim ProductCount As Integer = 0
    '    Dim myReader As SqlDataReader = Nothing
    '    Dim i As Integer = 6

    '    If newFile.Exists Then
    '        newFile.Delete()
    '        ' ensures we create a new workbook
    '        newFile = New FileInfo(Convert.ToString(outputDir.FullName) & strFileName)
    '    End If

    '    Try
    '        myReader = Fransupport.SCM.Products.GetProductsForSupplierIDForExcelSheet(hdnSupplierID.Value, hdnStatus.Value, hdnCategoryID.Value, hdnSearch.Value)
    '        rdrSupplierDetail = Fransupport.SCM.Supplier.GetSupplierbyID(hdnSupplierID.Value)

    '        Using package As New ExcelPackage(newFile)
    '            ' add a new worksheet to the empty workbook
    '            Dim worksheet As ExcelWorksheet = package.Workbook.Worksheets.Add("SCM ProductsReport")

    '            'Add the headers
    '            worksheet.Cells("A1:H1").Merge = True
    '            worksheet.Cells("A1:H1").Value = "Supplier Products"
    '            worksheet.Cells("A1:H1").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
    '            worksheet.Cells("A1:H1").Style.Font.Bold = True
    '            worksheet.Cells("A1:H1").Style.Font.Size = 15

    '            If rdrSupplierDetail.Read() Then
    '                worksheet.Cells("A2:H2").Merge = True
    '                worksheet.Cells("A2:H2").Value = rdrSupplierDetail.Item("Name")
    '                worksheet.Cells("A2:H2").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center
    '                worksheet.Cells("A2:H2").Style.Font.Bold = True
    '                worksheet.Cells("A2:H2").Style.Font.Size = 15
    '            End If

    '            worksheet.Cells("A3:H3").Merge = True
    '            worksheet.Cells("A3:H3").Value = "Generated On:" & DateTime.Today.ToShortDateString()
    '            worksheet.Cells("A3:H3").Style.Font.Italic = True
    '            worksheet.Cells("A3:H3").Style.HorizontalAlignment = ExcelHorizontalAlignment.Center

    '            worksheet.Cells("A4:H4").Merge = True
    '            worksheet.Cells("A4:H4").Value = ""

    '            worksheet.Cells(5, 1).Value = "Code"
    '            worksheet.Cells(5, 1).AutoFitColumns(15)
    '            worksheet.Cells(5, 1).Style.Font.Bold = True

    '            worksheet.Cells(5, 2).Value = "Product"
    '            worksheet.Cells(5, 2).AutoFitColumns(60)
    '            worksheet.Cells(5, 2).Style.Font.Bold = True

    '            worksheet.Cells(5, 3).Value = "Pack Size"
    '            worksheet.Cells(5, 3).AutoFitColumns(20)
    '            worksheet.Cells(5, 3).Style.Font.Bold = True

    '            worksheet.Cells(5, 4).Value = "Price($)"
    '            worksheet.Cells(5, 4).AutoFitColumns(15)
    '            worksheet.Cells(5, 4).Style.Font.Bold = True

    '            worksheet.Cells(5, 5).Value = "Stock"
    '            worksheet.Cells(5, 5).AutoFitColumns(8.43)
    '            worksheet.Cells(5, 5).Style.Font.Bold = True

    '            worksheet.Cells(5, 6).Value = "Threshold"
    '            worksheet.Cells(5, 6).AutoFitColumns(13)
    '            worksheet.Cells(5, 6).Style.Font.Bold = True

    '            worksheet.Cells(5, 7).Value = "Actual Stock"
    '            worksheet.Cells(5, 7).AutoFitColumns(13)
    '            worksheet.Cells(5, 7).Style.Font.Bold = True

    '            worksheet.Cells(5, 8).Value = "Availability"
    '            worksheet.Cells(5, 8).AutoFitColumns(13)
    '            worksheet.Cells(5, 8).Style.Font.Bold = True

    '            While myReader.Read()
    '                worksheet.Cells(i, 1).Value = myReader.Item("Code")
    '                worksheet.Cells(i, 2).Value = myReader.Item("Name")
    '                worksheet.Cells(i, 3).Value = myReader.Item("QuantityInPack")
    '                worksheet.Cells(i, 4).Value = myReader.Item("Price")
    '                worksheet.Cells(i, 5).Value = myReader.Item("QuantityInStock")
    '                worksheet.Cells(i, 6).Value = myReader.Item("Threshold")
    '                worksheet.Cells(i, 7).Value = myReader.Item("ActualStock")
    '                worksheet.Cells(i, 8).Value = myReader.Item("Available")
    '                i += 1
    '                ProductCount += 1
    '            End While

    '            worksheet.Cells(i, 7).Value = "Total Products"
    '            worksheet.Cells(i, 7).Style.Font.Bold = True

    '            worksheet.Cells(i, 8).Value = ProductCount
    '            worksheet.Cells(i, 8).Style.Font.Bold = True

    '            package.Save()
    '        End Using
    '    Catch ex As Exception
    '        Throw ex
    '    Finally
    '        myReader.Close()
    '        rdrSupplierDetail.Close()
    '    End Try

    '    Response.AppendHeader("Content-Type", "application/vnd.ms-excel")
    '    Response.AppendHeader("Content-disposition", "attachment; filename=" & strFileName)
    '    Me.EnableViewState = False
    '    Response.BinaryWrite(My.Computer.FileSystem.ReadAllBytes(strCurrentDir & strFileName))
    '    newFile.Delete()
    '    Response.End()
    'End Sub
    Protected Sub ddlState_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlState.DataBound
        If ddlState.Items.FindByValue(0) Is Nothing Then
            ddlState.Items.Insert(0, New ListItem("All", 0))
            ddlState.SelectedIndex = 0
        End If
    End Sub
End Class