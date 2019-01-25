Imports System.Data.SqlClient
Imports Microsoft.Office.Interop.Excel
Imports System.Reflection
Imports System.IO
Partial Class Support_SupportReport
    Inherits System.Web.UI.Page
    Protected TotalOrderCount As Integer = 0
    Protected TotalOrderTotal As Decimal = 0
    Protected TotalOrderDiscount As Decimal = 0
    Protected TotalMerchandiseCount As Integer = 0
    Protected TotalMerchandiseTotal As Decimal = 0
    Protected TotalMerchandiseDiscount As Decimal = 0
    Protected TotalDeliveryCharges As Decimal = 0
    Protected TotalVoids As Decimal = 0
    Protected TotalTaxes As Decimal = 0

    Declare Function EndTask Lib "user32.dll" (ByVal hWnd As IntPtr) As Integer
    Declare Function FindWindow Lib "user32.dll" Alias "FindWindowA" _
           (ByVal lpClassName As String, ByVal lpWindowName As String) As IntPtr
    Declare Function GetWindowThreadProcessId Lib "user32.dll" _
           (ByVal hWnd As IntPtr, ByRef lpdwProcessId As Integer) As Integer
    Declare Function SetLastError Lib "kernel32.dll" (ByVal dwErrCode As Integer) As IntPtr


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DateFrom.Text = Request(DateFrom.UniqueID)
        DateTo.Text = Request(DateTo.UniqueID)
        If IsPostBack = False Then
            Dim datStartOfCurWeek As Date
            Dim datEndOfCurWeek As Date
            datStartOfCurWeek = FormatDateTime(DateAdd("d", 1, DateAdd("d", -1 * Weekday(Now(), vbSunday), Now())), DateFormat.ShortDate)
            datEndOfCurWeek = FormatDateTime(DateAdd("d", 6, datStartOfCurWeek), DateFormat.ShortDate)

            DateFrom.Text = datStartOfCurWeek
            DateTo.Text = datEndOfCurWeek
            hdnFromDate.Value = datStartOfCurWeek
            hdnToDate.Value = datEndOfCurWeek
            If String.IsNullOrEmpty(Request.QueryString("FromDate")) = False Then
                Me.hdnFromDate.Value = Request.QueryString("FromDate")
                Me.hdnToDate.Value = Request.QueryString("ToDate")
                DateFrom.Text = Request.QueryString("FromDate")
                DateTo.Text = Request.QueryString("ToDate")
            End If
        End If
    End Sub

    Protected Sub gvOrders_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvOrders.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedReportRowSMS';")
            e.Row.Attributes.Add("onmouseout", "this.className='rptGridRowClickableSMS';")
            Dim lnkState As LinkButton = CType(e.Row.FindControl("lnkState"), LinkButton)
            lnkState.Attributes.Add("onclick", "javascript:ShowReport(" & e.Row.DataItem("ID") & ",'" & Request(Me.DateFrom.UniqueID) & "','" & Request(Me.DateTo.UniqueID) & "');return false;")
            TotalOrderCount += e.Row.DataItem("OrderCount")
            TotalOrderTotal += e.Row.DataItem("OrdersTotal")
            TotalOrderDiscount += e.Row.DataItem("Discount")
            TotalMerchandiseCount += e.Row.DataItem("MerchandiseCount")
            TotalMerchandiseTotal += e.Row.DataItem("MerchandiseTotal")
            TotalMerchandiseDiscount += e.Row.DataItem("MerchandiseDiscount")
            TotalDeliveryCharges += e.Row.DataItem("DeliveryCharges")
            TotalTaxes += e.Row.DataItem("Taxes")
            TotalVoids += e.Row.DataItem("Void")
        End If

        If e.Row.RowType = DataControlRowType.Footer Then

            Dim lblTotalOrderCount As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalOrderCount"), System.Web.UI.WebControls.Label)
            Dim lblTotalOrdersTotal As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalOrdersTotal"), System.Web.UI.WebControls.Label)
            Dim lblOrderDiscount As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblOrderDiscount"), System.Web.UI.WebControls.Label)
            Dim lblTotalMerchandiseCount As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalMerchandiseCount"), System.Web.UI.WebControls.Label)
            Dim lblTotalMerchandiseTotal As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalMerchandiseTotal"), System.Web.UI.WebControls.Label)
            Dim lblTotalMerchandiseDiscount As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalMerchandiseDiscount"), System.Web.UI.WebControls.Label)
            Dim lblTotalDeliveryCharges As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalDeliveryCharges"), System.Web.UI.WebControls.Label)
            Dim lblTotalTaxes As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalTaxes"), System.Web.UI.WebControls.Label)
            Dim lblTotalVoids As System.Web.UI.WebControls.Label = CType(e.Row.FindControl("lblTotalVoids"), System.Web.UI.WebControls.Label)
            If Not lblTotalOrderCount Is Nothing Then
                lblTotalOrderCount.Text = TotalOrderCount
                lblTotalOrdersTotal.Text = FormatNumber(TotalOrderTotal, 2)
                lblOrderDiscount.Text = FormatNumber(TotalOrderDiscount, 2)
                lblTotalMerchandiseCount.Text = TotalMerchandiseCount
                lblTotalMerchandiseTotal.Text = FormatNumber(TotalMerchandiseTotal, 2)
                lblTotalMerchandiseDiscount.Text = FormatNumber(TotalMerchandiseDiscount, 2)
                lblTotalDeliveryCharges.Text = FormatNumber(TotalDeliveryCharges, 2)
                lblTotalTaxes.Text = FormatNumber(TotalTaxes, 2)
                lblTotalVoids.Text = FormatNumber(TotalVoids, 2)
            End If
        End If
    End Sub

    Protected Sub gvOrders_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvOrders.Sorting
        Dim Script As String = "setValues('" & e.SortExpression & IIf(e.SortDirection = 1, " DESC", "") & "');"
        ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "AssignValues", Script, True)
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSearch.Click
        hdnFromDate.Value = Request(DateFrom.UniqueID)
        hdnToDate.Value = Request(DateTo.UniqueID)
    End Sub

    Protected Sub lnkExportExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkExportExcel.Click
        GenerateExcel()
    End Sub
    Public Sub GenerateExcel()
        Dim strCurrentDir As String = Server.MapPath("./ExcelReport") + "\"
        Dim oXL As Microsoft.Office.Interop.Excel.Application
        Dim oWB As Microsoft.Office.Interop.Excel._Workbook
        Dim oSheet As Microsoft.Office.Interop.Excel._Worksheet
        Dim TitleRow1 As Integer = 1
        Dim TitleRow2 As Integer = 2
        Dim TitleRow3 As Integer = 3
        Dim TitleRow4 As Integer = 4
        Dim HeaderRow1 As Integer = 5
        Dim HeaderRow2 As Integer = 6
        Dim ItemRow As Integer = 7
        Dim FooterRow As Integer = 0
        Dim j As Integer = 0
        Dim k As Integer = 0
        Dim myReader As SqlDataReader
        Try
            GC.Collect() ';// clean up any other excel guys hangin' around...
            oXL = New Microsoft.Office.Interop.Excel.Application()
            oXL.Visible = False
            oXL.Caption = System.Guid.NewGuid.ToString().ToUpper()
            'Get a new workbook.
            oWB = oXL.Workbooks.Add(strCurrentDir + "Template\ReportTemplate.xls") ', Microsoft.Office.Interop.Excel._Workbook)
            oSheet = CType(oWB.ActiveSheet, Microsoft.Office.Interop.Excel._Worksheet)
            'get our Data  
            If Me.hdnFromDate.Value = "" Then
                Me.hdnFromDate.Value = "1/1/2000"
            End If
            If Me.hdnToDate.Value = "" Then
                Me.hdnToDate.Value = "12/31/2099"
            End If
            'myReader = SMS_OrderDetail.GenerateExcelForGeneralReport(Request(Me.DateFrom.UniqueID), Request(Me.DateTo.UniqueID), "")
            ' Create Header and sheet...
            oSheet.Range("A1", "J1").Merge()
            oSheet.Cells(TitleRow1, 1) = "Edible Arrangements"
            oSheet.Cells(TitleRow1, 1).Font.Bold = True
            oSheet.Range("A1", "J1").HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter   '- 4108

            oSheet.Range("A2", "J2").Merge()
            oSheet.Cells(TitleRow2, 1) = "SMS Sales Analysis Report By State"
            oSheet.Cells(TitleRow2, 1).Font.Bold = True
            oSheet.Range("A2", "J2").HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter   '- 4108

            oSheet.Range("A3", "J3").Merge()
            If Request(Me.DateFrom.UniqueID) = "1/1/2000" And Request(Me.DateTo.UniqueID) = "12/31/2099" Then
                oSheet.Cells(TitleRow3, 1) = "Period " + " - All "
            Else
                oSheet.Cells(TitleRow3, 1) = "Period " + Request(Me.DateFrom.UniqueID) + " to " + Request(Me.DateTo.UniqueID)
            End If
            oSheet.Cells(TitleRow3, 1).Font.Bold = True
            oSheet.Range("A3", "J3").HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter   '- 4108

            oSheet.Range("A4", "J4").Merge()
            oSheet.Cells(TitleRow4, 1) = "Generated on " + DateTime.Now()
            oSheet.Cells(TitleRow4, 1).Font.Bold = True
            oSheet.Range("A4", "J4").HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter   '- 4108


            oSheet.Range("A5", "J5").Interior.Color = RGB(204, 255, 204)
            oSheet.Range("A6", "J6").Interior.Color = RGB(204, 255, 204)

            oSheet.Range("A5", "J5").Borders.Color = RGB(0, 0, 0)
            oSheet.Range("A6", "J6").Borders.Color = RGB(0, 0, 0)

            oSheet.Range("A5", "J5").Borders.Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlThin
            oSheet.Range("A6", "J6").Borders.Weight = Microsoft.Office.Interop.Excel.XlBorderWeight.xlThin

            oSheet.Range("A5", "J5").Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous
            oSheet.Range("A6", "J6").Borders.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous
            For j = 0 To myReader.FieldCount - 1
                Select Case j
                    Case 0
                        oSheet.Cells(HeaderRow1, j + 1) = "Store"
                        oSheet.Range("A5", "A5").Merge()
                        oSheet.Range("A5", "A5").ColumnWidth = 30
                        oSheet.Range("A5", "A5").HorizontalAlignment = -4108
                    Case 1
                        oSheet.Cells(HeaderRow1, j + 1) = "Order"
                        oSheet.Range("B5", "C5").Merge()
                        oSheet.Range("C5", "D5").Merge()
                        oSheet.Range("C5").HorizontalAlignment = -4108
                    Case 4
                        oSheet.Cells(HeaderRow1, j + 1) = "Merchandise"
                        oSheet.Range("E5", "F5").Merge()
                        oSheet.Range("F5", "G5").Merge()
                        oSheet.Range("F5").HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter   '- 4108
                    Case 7
                        oSheet.Cells(HeaderRow1, j + 1) = "Delivery Charges"
                        oSheet.Range("H5:H5").ColumnWidth = 15   '- 4108
                        oSheet.Range("H5", "H5").HorizontalAlignment = -4108
                    Case 8
                        oSheet.Cells(HeaderRow1, j + 1) = "Tax"
                        oSheet.Range("I5", "I5").HorizontalAlignment = -4108
                    Case 9
                        oSheet.Cells(HeaderRow1, j + 1) = "Voided"
                        oSheet.Range("J5", "J5").HorizontalAlignment = -4108
                    Case Else
                End Select
            Next
            For j = 0 To myReader.FieldCount - 1

                Select Case j
                    Case 0
                        oSheet.Cells(HeaderRow2, j + 1) = ""
                    Case 1
                        oSheet.Cells(HeaderRow2, j + 1) = "Total"
                        oSheet.Range("B6:B6").HorizontalAlignment = -4108
                    Case 2
                        oSheet.Cells(HeaderRow2, j + 1) = "Amount"
                        oSheet.Range("C6:C6").HorizontalAlignment = -4108
                    Case 3
                        oSheet.Cells(HeaderRow2, j + 1) = "Disc."
                        oSheet.Range("D6:D6").HorizontalAlignment = -4108
                    Case 4
                        oSheet.Cells(HeaderRow2, j + 1) = "Total"
                        oSheet.Range("E6:E6").HorizontalAlignment = -4108
                    Case 5
                        oSheet.Cells(HeaderRow2, j + 1) = "Amount"
                        oSheet.Range("F6:F6").HorizontalAlignment = -4108
                    Case 6
                        oSheet.Cells(HeaderRow2, j + 1) = "Disc."
                        oSheet.Range("G6:G6").HorizontalAlignment = -4108
                    Case Else
                End Select
            Next
            ' build the sheet contents
            While (myReader.Read())

                For k = 0 To myReader.FieldCount - 1
                    If k = 1 Then
                        oSheet.Cells(ItemRow, k + 1) = myReader.GetValue(k + 1).ToString()
                    ElseIf k = 10 Then
                        oSheet.Cells(ItemRow, k) = myReader.GetValue(k + 1).ToString()
                    ElseIf k = 0 Then
                        oSheet.Cells(ItemRow, k + 1) = myReader.GetValue(k).ToString()
                    ElseIf k = 11 Then
                        oSheet.Cells(ItemRow, k + 1) = ""
                    Else
                        oSheet.Cells(ItemRow, k) = myReader.GetValue(k).ToString()
                    End If
                    Select Case k
                        Case 1
                            TotalOrderCount = TotalOrderCount + myReader.GetValue(k + 1)
                        Case 2
                            TotalOrderTotal = TotalOrderTotal + myReader.GetValue(k + 1)
                        Case 3
                            TotalOrderDiscount = TotalOrderDiscount + myReader.GetValue(k + 1)
                        Case 4
                            TotalMerchandiseCount = TotalMerchandiseCount + myReader.GetValue(k + 1)
                        Case 5
                            TotalMerchandiseTotal = TotalMerchandiseTotal + myReader.GetValue(k + 1)
                        Case 6
                            TotalMerchandiseDiscount = TotalMerchandiseDiscount + myReader.GetValue(k + 1)
                        Case 7
                            TotalDeliveryCharges = TotalDeliveryCharges + myReader.GetValue(k + 1)
                        Case 8
                            TotalTaxes = TotalTaxes + myReader.GetValue(k + 1)
                        Case 11
                            TotalVoids = TotalVoids + myReader.GetValue(k)
                        Case Else
                    End Select
                Next
                ItemRow = ItemRow + 1
            End While ' end while
            myReader.Close()
            myReader = Nothing
            Dim FooterRange1 As String = ""
            Dim FooterRange2 As String = ""
            FooterRange1 = "A" + Convert.ToString(ItemRow)
            FooterRange2 = "J" + Convert.ToString(ItemRow)
            oSheet.Range(FooterRange1, FooterRange2).Borders(XlBordersIndex.xlEdgeTop).Color = RGB(0, 0, 0)
            oSheet.Range(FooterRange1, FooterRange2).Borders(XlBordersIndex.xlEdgeBottom).Color = RGB(0, 0, 0)
            FooterRow = ItemRow
            oSheet.Cells(FooterRow, 1) = "Total:"
            oSheet.Cells(FooterRow, 2) = TotalOrderCount
            oSheet.Cells(FooterRow, 3) = TotalOrderTotal
            oSheet.Cells(FooterRow, 4) = TotalOrderDiscount
            oSheet.Cells(FooterRow, 5) = TotalMerchandiseCount
            oSheet.Cells(FooterRow, 6) = TotalMerchandiseTotal
            oSheet.Cells(FooterRow, 7) = TotalMerchandiseDiscount
            oSheet.Cells(FooterRow, 8) = TotalDeliveryCharges
            oSheet.Cells(FooterRow, 9) = TotalTaxes
            oSheet.Cells(FooterRow, 10) = TotalVoids
            FooterRange1 = "A" + Convert.ToString(ItemRow + 2)
            FooterRange2 = "J" + Convert.ToString(ItemRow + 2)
            oSheet.Range(FooterRange1, FooterRange2).Merge()
            oSheet.Cells(ItemRow + 2, 1).Font.Bold = True
            oSheet.Cells(ItemRow + 2, 1).HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter   '- 4108
            oSheet.Cells(ItemRow + 2, 1) = "Disclaimer : Accuracy of data on this report is not guaranteed, Please verify all numbers before processing. "
            oXL.Visible = False
            oXL.UserControl = False
            Dim strFile As String = "report" + System.DateTime.Now.Ticks.ToString() + ".xls"
            oWB.SaveAs(strCurrentDir + strFile, Microsoft.Office.Interop.Excel.XlFileFormat.xlWorkbookNormal, Nothing, Nothing, False, False, Microsoft.Office.Interop.Excel.XlSaveAsAccessMode.xlNoChange, False, False, Nothing, Nothing, Nothing)
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ' Need all following code to clean up and extingush all references!!!
            oWB.Close(Nothing, Nothing, Nothing)
            oXL.Workbooks.Close()
            Dim sVer As String = oXL.Version
            Dim iHandle As IntPtr = IntPtr.Zero
            If Val(sVer) >= 10 Then ''this code will run for Excel version equal to or greater then 10
                iHandle = New IntPtr(CType(oXL.Parent.Hwnd, Integer))
                EnsureProcessKilled(iHandle, oXL.Caption)
            Else
                If Not oXL.Workbooks Is Nothing Then
                    Dim wb As Microsoft.Office.Interop.Excel.Workbook
                    Dim ws As Microsoft.Office.Interop.Excel.Worksheet
                    For Each wb In oXL.Workbooks
                        For Each ws In wb.Worksheets
                            System.Runtime.InteropServices.Marshal.ReleaseComObject(ws)
                            ws = Nothing
                        Next
                        wb.Close(False)
                        System.Runtime.InteropServices.Marshal.ReleaseComObject(wb)
                        wb = Nothing
                    Next
                    oXL.Workbooks.Close()
                End If
                oXL.DisplayAlerts = False
                oXL.Quit()
            End If
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            Dim strMachineName As String = Request.ServerVariables("SERVER_NAME")
            Dim FolderPath As String = Request.ApplicationPath + "/admin/SMS/ExcelReport/"
            strMachineName = strMachineName + FolderPath

            Dim file As New System.IO.FileInfo(strCurrentDir + strFile)
            Dim ExcelStream As New System.IO.FileStream(strCurrentDir + strFile, IO.FileMode.Open)
            Dim lBytes As Long = ExcelStream.Length
            Response.AddHeader("content-disposition", "attachment; filename=" & strFile)
            Response.ContentType = "application/x-msexcel"
            If (lBytes > 0) Then
                Dim ByteArray(lBytes - 1) As Byte
                ExcelStream.Read(ByteArray, 0, lBytes)
                ExcelStream.Close()
                Response.BinaryWrite(ByteArray)
            End If
            If file.Exists = True Then
                file.Delete()
            End If
        Catch theException As Exception
            Dim errorMessage As String
            errorMessage = "Error: "
            errorMessage = String.Concat(errorMessage, theException.Message)
            errorMessage = String.Concat(errorMessage, " Line: ")
            errorMessage = String.Concat(errorMessage, theException.Source)
            'errLabel.Text = errorMessage
            ClientScript.RegisterStartupScript(Me.GetType(), "ShowErrora", "ShowErrorMessage();", True)
        End Try
    End Sub
    Public Sub EnsureProcessKilled(ByVal MainWindowHandle As IntPtr, ByVal Caption As String)
        SetLastError(0)
        ' for Excel versions <10, this won't be set yet
        If IntPtr.Equals(MainWindowHandle, IntPtr.Zero) Then _
            MainWindowHandle = FindWindow(Nothing, Caption)
        If IntPtr.Equals(MainWindowHandle, IntPtr.Zero) Then _
      Exit Sub ' at this point, presume the window has been closed.
        Dim iRes, iProcID As Integer
        iRes = GetWindowThreadProcessId(MainWindowHandle, iProcID)
        If iProcID = 0 Then ' can’t get Process ID
            If EndTask(MainWindowHandle) <> 0 Then Exit Sub ' success
            Throw New ApplicationException("Failed to close.")
        End If
        Dim proc As System.Diagnostics.Process
        proc = System.Diagnostics.Process.GetProcessById(iProcID)
        proc.CloseMainWindow()
        proc.Refresh()
        If proc.HasExited Then Exit Sub
        proc.Kill()
    End Sub
End Class
