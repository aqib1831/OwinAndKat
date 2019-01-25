Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Data.OleDb

Partial Class _Default2
    Inherits System.Web.UI.Page
    Protected HTMLString As New System.Text.StringBuilder
    Dim HeaderString() As String
    Dim ColumnString() As String
    Dim TotalString() As Double
    Private l_ReportName As String
    Private l_FoorterText As String
    Private ReportType As Portal.BLL.Enumeration.SSLReporType

    Public Enum TotalRequired
        YES = 0
        NO = -1
    End Enum

#Region "local Constants, Variables and Portal.BLL.Enumeration.ReporType"

    'Public Enum ReportType
    '    AGREEMENT = 1
    '    AREAOFINTREST = 2
    '    FRANCHISEFEE = 3
    'End Enum
    Public Enum ExportTypes
        MsExcel = 1
        MsWord = 2
        RichText = 3
        PDF = 4
        CSV = 5
        Tabbed = 6
    End Enum

    Private l_Period As String
    Private DateTo, DateFrom
    Private Const l_LinesPerPage As Integer = 38
    Private l_ReportPath As String = Server.MapPath("~") & "\reports\PhysicalReports"

#End Region

    Private Sub ConfigureReportSettings()
        Dim ds As DataSet
        Dim ExportFormat As ExportTypes
        Dim CurrentLineNo As Integer = 0
        Dim isTotalRequired = False, isAveragRequired As Boolean = False
        Dim GroupBy As String
        Dim GroupByIndex = -1, GroupByRecordCount As Integer
        Dim GroupByTotal As Double


        If Not IsNothing(Request("Format")) Then ExportFormat = CType(Request("Format"), Portal.BLL.Enumeration.ExportOptions)

        ReportType = CType(Request("ReportType"), Portal.BLL.Enumeration.SSLReporType)
        l_FoorterText = GetFooterText()

        l_ReportName = Replace(ReportType.ToString, "_", " ")
        l_Period = "Printed On " & DateTime.Today

        'Check which Report to show
        If ReportType = Portal.BLL.Enumeration.SSLReporType.SSL_List Then
            ds = LoadURLs()
        ElseIf ReportType = Portal.BLL.Enumeration.SSLReporType.Support_Billing_Details Then
            ds = LoadSupportBillingDetailsData()
        ElseIf ReportType = Portal.BLL.Enumeration.SSLReporType.Support_Billing Then
            ds = LoadSupportBillingData()
        ElseIf ReportType = Portal.BLL.Enumeration.SSLReporType.Support_Checklist Then
            ds = LoadDataForSupportCheckList()
        Else
            Response.End()
        End If

        'If DateTo = "" And DateFrom = "" Then
        '    l_Period = "Reporting Period: All"
        'Else
        '    l_Period = "Reporting Period: " & DateFrom & " To " & DateTo
        'End If

        HTMLString.Append("<table border='0' cellpadding='0' cellspacing='0' width='670' align='center'>" & Chr(10) & Chr(13))

        'Create Header For ReportS
        PrintReportHeading()

        Dim rw As DataRowView
        Dim clm As New DataColumn

        'Create Header for Table
        '---------------------------------------------------------------------------------
        ReDim TotalString(0 To ColumnString.Length - 1)
        HTMLString.Append("<tr>")
        For a As Integer = 0 To ColumnString.Length - 1

            'Set total fields which are required
            If InStr(ColumnString(a), "@Total") > 0 Or InStr(ColumnString(a), "@GroupTotal") > 0 Or InStr(ColumnString(a), "@AvgGroupTotal") > 0 Then
                TotalString(a) = TotalRequired.YES
                If InStr(ColumnString(a), "@GroupTotal") > 0 Then GroupByIndex = a
                If InStr(ColumnString(a), "@AvgGroupTotal") > 0 Then
                    isAveragRequired = True
                    GroupByIndex = a
                End If

                ColumnString(a) = Replace(ColumnString(a), "@Total", "")
                ColumnString(a) = Replace(ColumnString(a), "@GroupTotal", "")
                ColumnString(a) = Replace(ColumnString(a), "@AvgGroupTotal", "")
                If isTotalRequired = False Then isTotalRequired = True

            Else
                TotalString(a) = TotalRequired.NO
            End If
            'Set Group by Information
            If InStr(ColumnString(a), "@Group") > 0 Then
                ColumnString(a) = Replace(ColumnString(a), "@Group", "")
                GroupBy = ColumnString(a)
            End If

            If ds.Tables(0).Columns(ColumnString(a)).DataType.ToString = GetType(Integer).ToString Then
                HTMLString.Append("     <td class='TableHeading' Align='Right' style='padding-right:4px;'>" & HeaderString(a) & "</td>" & Chr(10) & Chr(13))
            ElseIf ds.Tables(0).Columns(ColumnString(a)).DataType.ToString = GetType(Decimal).ToString Then
                HTMLString.Append("     <td class='TableHeading' Align='Right' style='padding-right:4px;'>" & HeaderString(a) & "</td>" & Chr(10) & Chr(13))
            Else
                HTMLString.Append("     <td class='TableHeading'>" & HeaderString(a) & "</td>" & Chr(10) & Chr(13))
            End If
        Next
        HTMLString.Append("</tr>" & Chr(10) & Chr(13))
        '---------------------------------------------------------------------------------

        '---------------------------------------------------------------------------------
        'if there is not record print no record message
        If ds.Tables(0).Rows.Count = 0 Then
            HTMLString.Append("<tr><td align='center' class='ReportingPeriod' colspan='" & HeaderString.Length & "'> <br>No Record(s) Found!</td></tr>" & Chr(10) & Chr(13))
        End If
        '---------------------------------------------------------------------------------

        'Sort data on the base of GroupBy Clause if Defined
        '---------------------------------------------------------------------------------
        Dim dv As New DataView
        dv = ds.Tables(0).DefaultView


        If Not GroupBy = "" Then
            dv.Sort = GroupBy
        End If

        Dim PreviousGroupByString As String

        Dim strRowDuplicatedata As String
        'Create Table of Data
        For Each rw In dv

            'Print Total for Group By
            '---------------------------------------------------------------------------------
            PrintGroupByTotals(PreviousGroupByString, GroupBy, GroupByTotal, GroupByIndex, rw, CurrentLineNo, GroupByRecordCount, isAveragRequired)
            '---------------------------------------------------------------------------------

            HTMLString.Append("<tr class='TableRow'>")
            CurrentLineNo += 1
            GroupByRecordCount += 1

            For i As Integer = 0 To ColumnString.Length - 1
                'Create Details information
                '---------------------------------------------------------------------------------


                'Create Details information
                If rw.Item(ColumnString(i)).GetType.ToString = GetType(DateTime).ToString Then
                    HTMLString.Append("     <td class='DetailText' style='height:20px;padding-right:4px;'>" & Format(rw.Item(ColumnString(i)), "MM/dd/yyyy") & "</td>" & Chr(10) & Chr(13))
                ElseIf rw.Item(ColumnString(i)).GetType.ToString = GetType(Integer).ToString Then
                    HTMLString.Append("     <td class='DetailText' align='Right'  style='height:20px;padding-right:4px;' >" & rw.Item(ColumnString(i)) & "</td>" & Chr(10) & Chr(13))
                ElseIf rw.Item(ColumnString(i)).GetType.ToString = GetType(Decimal).ToString Then
                    HTMLString.Append("     <td class='DetailText' align='Right'  style='height:20px;padding-right:4px;' >" & Format(rw.Item(ColumnString(i)), "0.00") & "</td>" & Chr(10) & Chr(13))
                Else
                    If rw.Item(ColumnString(i)) Is DBNull.Value Then
                        HTMLString.Append("     <td class='DetailText' align='Center' style='height:20px;padding-right:4px;'>-</td>" & Chr(10) & Chr(13))
                    Else
                        HTMLString.Append("     <td class='DetailText' style='height:20px;padding-right:4px;'>" & rw.Item(ColumnString(i)) & "</td>" & Chr(10) & Chr(13))
                    End If


                End If

                '---------------------------------------------------------------------------------
                'Calculate Total for Fields
                '---------------------------------------------------------------------------------
                If Not TotalString(i) = TotalRequired.NO Then
                    TotalString(i) += IIf(rw.Item(ColumnString(i)) Is DBNull.Value, 0, rw.Item(ColumnString(i)))
                End If
                '---------------------------------------------------------------------------------

            Next
            HTMLString.Append("</tr>" & Chr(10) & Chr(13))

            'If Records have filled the page space then again print the header
            '---------------------------------------------------------------------------------
            If CurrentLineNo = l_LinesPerPage Then
                CurrentLineNo = 0
                HTMLString.Append("<tr height='40px;'><td>&nbsp;</td></tr>")
                'Create Header For ReportS
                PrintReportHeading()
                'Create Header for Table
                PrintTableHearder()
            End If
            '---------------------------------------------------------------------------------

        Next

        'Print SubTotal for Last Record if Required
        PreviousGroupByString = "temp"
        PrintGroupByTotals(PreviousGroupByString, GroupBy, GroupByTotal, GroupByIndex, rw, CurrentLineNo, GroupByRecordCount, isAveragRequired)

        'Print Totals if required
        If isTotalRequired = True Then
            PrintGrandTotals()
        End If

        PrintFooter()

        HTMLString.Append("</table>")

        ' Response.Write(HTMLString)


    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        ConfigureReportSettings()

    End Sub

#Region "Load data for Reports"


    Private Function LoadURLs() As DataSet
        Dim ds As New DataSet
        Dim AccountId, RegistrarId, CategoryId, Expiry As Integer
        Dim SearchBy, Sort As String

        AccountId = CType(Val(Request("AccountId")), Integer)
        CategoryId = CType(Val(Request("CategoryId")), Integer)
        RegistrarId = CType(Val(Request("RegistrarId")), Integer)
        Expiry = CType(Val(Request("Exp")), Integer)
        SearchBy = CType(Request("SearchBy"), String)
        If Session("SortExpression") = Nothing Then Session("SortExpression") = " "
        Sort = CType(Session("SortExpression"), String)
        Session("SortExpression") = Nothing


        ds = SSLM.GetAllURLsForReport(AccountId, CategoryId, RegistrarId, SearchBy, Sort, Expiry)
        ds.Tables(0).TableName = "URLs"


        ReDim ColumnString(0 To 4)
        ColumnString(0) = "URL"
        ColumnString(1) = "Registrar"
        ColumnString(2) = "Category"
        ColumnString(3) = "Account"
        ColumnString(4) = "Expiration_Date"
        '  ColumnString(5) = "LastUpdate_Date"
        'ColumnString(5) = "Status"

        ReDim HeaderString(0 To 4)
        HeaderString(0) = "SSL"
        HeaderString(1) = "Registrar"
        HeaderString(2) = "Category"
        HeaderString(3) = "Account"
        HeaderString(4) = "Expiration"
        ' HeaderString(5) = "Updated"
        'HeaderString(5) = "Status"


        Return ds
    End Function

    Private Function LoadSupportBillingDetailsData() As DataSet
        Dim ds As New DataSet
        Dim ReportMontId As Integer
        Dim SortExpression As String
        ReportMontId = CType(Val(Request("ReportMontId")), Integer)
        SortExpression = Request("SortExpression")

        ds = Support.GetBillingReportDetailsForReportViewer(SortExpression, ReportMontId)
        ds.Tables(0).TableName = "SupportBilling"


        ReDim ColumnString(0 To 5)
        ColumnString(0) = "StoreNumber"
        ColumnString(1) = "StoreName"
        ColumnString(2) = "From"
        ColumnString(3) = "To"
        ColumnString(4) = "Amount@Total"
        ColumnString(5) = "Remarks"

        ReDim HeaderString(0 To 5)
        HeaderString(0) = "Store #"
        HeaderString(1) = "Store Name"
        HeaderString(2) = "From"
        HeaderString(3) = "To"
        HeaderString(4) = "Amount"
        HeaderString(5) = "Remarks"


        Return ds
    End Function

    Private Function LoadSupportBillingData() As DataSet
        Dim ds As New DataSet
        Dim ReportMontId As Integer
        Dim SortExpression, SearchString As String
        ReportMontId = CType(Val(Request("ReportMontId")), Integer)
        SortExpression = Request("SortExpression")
        SearchString = Request("Search")

        ds = Support.GetBillingReportForReportViewer(SortExpression, ReportMontId, SearchString)
        ds.Tables(0).TableName = "SupportBilling"


        ReDim ColumnString(0 To 5)
        ColumnString(0) = "StoreNumber"
        ColumnString(1) = "CorporateName"
        ColumnString(2) = "StoreName"
        ColumnString(3) = "SupportCharges@Total"
        ColumnString(4) = "BackupCharges@Total"
        ColumnString(5) = "Total@Total"

        ReDim HeaderString(0 To 5)
        HeaderString(0) = "Store #"
        HeaderString(1) = "Corporate Name"
        HeaderString(2) = "Location Name"
        HeaderString(3) = "Support"
        HeaderString(4) = "Backup"
        HeaderString(5) = "Total"

        Return ds
    End Function

    Private Function LoadDataForSupportCheckList() As DataSet
        Dim ds As New DataSet
        Dim CheckListDateId As Integer
        Dim SearchString, SortExpression As String
        SortExpression = Request("SortExpression")
        CheckListDateId = CType(Val(Request("CheckListDateId")), Integer)
        SearchString = Request("Search")


        ds = Support.GetCheckListForReport(CheckListDateId, SearchString, SortExpression)
        ds.Tables(0).TableName = "Checklist"

        ReDim ColumnString(0 To 4)
        ColumnString(0) = "StoreNumber"
        ColumnString(1) = "StoreName"
        ColumnString(2) = "CorporateName"
        ColumnString(3) = "CheckedDate"
        ColumnString(4) = "CheckedBy"

        ReDim HeaderString(0 To 4)
        HeaderString(0) = "Store #"
        HeaderString(1) = "Location Name"
        HeaderString(2) = "Corporate Name"
        HeaderString(3) = "Checked Date"
        HeaderString(4) = "Checked By"


        Return ds

    End Function

#End Region

#Region "Pirvate functions "

    Private Sub DownloadDataForExport(ByVal ds As DataSet, ByVal Delimiter As String, ByVal filename As String)

        Dim completeURLtext As String
        Dim rw As Integer
        Dim cl As Integer
        Dim exportDelimeter As String = Delimiter

        If Delimiter = "," Then filename &= ".Csv"
        If Delimiter = vbTab Then filename &= ".Xls"

        completeURLtext = "URL" & exportDelimeter & "Category" & exportDelimeter & "Registrar" & exportDelimeter & "Account" & exportDelimeter & "Expiration Date " & exportDelimeter & "Last Updated" & exportDelimeter & "Status" & Chr(13) & Chr(10)

        For rw = 0 To ds.Tables(0).Rows.Count - 1
            Dim rowString As String = ""

            For cl = 1 To ds.Tables(0).Columns.Count - 2
                rowString &= ds.Tables(0).Rows.Item(rw).Item(cl).ToString & exportDelimeter
            Next

            rowString = Left$(rowString, Len(rowString) - 1) & Chr(13) & Chr(10)
            completeURLtext &= rowString
        Next

        Response.Clear()
        Response.AddHeader("content-disposition", "attachment;filename=" & filename)
        Response.Charset = ""
        Response.ContentType = "application/vnd.xls"
        Response.Write(completeURLtext)
        Response.End()

    End Sub

    'Private Sub CrystalReportExport(ByVal FileName As String, ByVal Format As ExportTypes)

    '    Dim rs As NonHTTPCachedReportSource = CType(myCrystalReportViewer.ReportSource, NonHTTPCachedReportSource)

    '    Dim exp As ExportOptions = New ExportOptions()
    '    Dim req As ExportRequestContext = New ExportRequestContext()
    '    Dim exported As System.IO.MemoryStream

    '    Select Case Format
    '        Case ExportTypes.MsExcel
    '            exp.ExportFormatType = CrystalDecisions.Shared.ExportFormatType.Excel
    '            FileName &= ".xls"
    '        Case ExportTypes.MsWord
    '            exp.ExportFormatType = ExportFormatType.WordForWindows
    '            FileName &= ".doc"
    '        Case ExportTypes.RichText
    '            exp.ExportFormatType = ExportFormatType.RichText
    '            FileName &= ".rtf"
    '            'Case Portal.BLL.Enumeration.ReporType.ExportOptions.Tabbed

    '            '    exp.ExportFormatType = ExportFormatType.Excel
    '            '    Dim objexecloption As ExcelFormatOptions = New ExcelFormatOptions
    '            '    objexecloption.ExcelUseConstantColumnWidth = False
    '            '    exp.ExportFormatOptions = objexecloption
    '            '    FileName &= ".xls"

    '        Case ExportTypes.PDF
    '            exp.ExportFormatType = ExportFormatType.PortableDocFormat
    '            FileName &= ".pdf"
    '            Response.AddHeader("Content-Type", "application/pdf")
    '    End Select



    '    req.ExportInfo = exp
    '    req.ViewContext = myCrystalReportViewer.ViewInfo.ViewContext
    '    exported = CType(rs.ExportToStream(req), System.IO.MemoryStream)
    '    Response.Charset = "UTF-8"
    '    Response.ContentEncoding = System.Text.Encoding.GetEncoding(1252)
    '    Response.AddHeader("content-disposition", "Attachment;filename=" & FileName)
    '    Response.AddHeader("Cache-Control", "no-store")
    '    Response.AddHeader("Pragma", "no-cache")
    '    Response.Expires = -1
    '    Response.Clear()

    '    Dim b(exported.Length) As Byte

    '    exported.Read(b, 0, CType(exported.Length, Integer))
    '    Response.BinaryWrite(b)
    '    Response.Flush()
    '    Response.End()

    'End Sub

    'Private Sub AddParametertoReport()
    '    Dim PrmRpt As New ParameterField
    '    Dim disVal As New ParameterDiscreteValue
    '    Dim prmfields As New ParameterFields

    '    PrmRpt.Name = "CompanyName"
    '    disVal.Value = ConfigurationManager.AppSettings("CompanyName")

    '    PrmRpt.CurrentValues.Add(disVal)
    '    prmfields.Add(PrmRpt)

    '    PrmRpt = Nothing
    '    disVal = Nothing

    '    PrmRpt = New ParameterField
    '    disVal = New ParameterDiscreteValue

    '    PrmRpt.Name = "Period"
    '    If DateTo = "" And DateFrom = "" Then
    '        disVal.Value = "Reporting Period: All"
    '    Else
    '        disVal.Value = "Reporting Period: " & DateTo & " To " & DateFrom
    '    End If

    '    PrmRpt.CurrentValues.Add(disVal)
    '    prmfields.Add(PrmRpt)

    '    myCrystalReportViewer.ParameterFieldInfo = prmfields

    'End Sub

    Private Function GetFooterText() As String
        Dim footerText As String

        If ReportType = Portal.BLL.Enumeration.SSLReporType.Support_Billing Then
            Dim ReportMontId As Integer
            Dim SearchString As String

            ReportMontId = CType(Val(Request("ReportMontId")), Integer)
            SearchString = Request("Search")
            footerText = "dasdasd"  'Payments.GetPaymentSummary(ReportMontId, SearchString)
        End If
        Return footerText
    End Function

#End Region

#Region "Printing Report Functions"

    Private Sub PrintReportHeading()
        HTMLString.Append("<tr height='20px;'><td align='Center' class='CompanyName' colspan='" & HeaderString.Length & "'>" & "<br>Netsolace, Inc" & "</td></tr>" & Chr(10) & Chr(13))
        HTMLString.Append("<tr height='30px;'><td align='Center' class='ReportName' colspan='" & HeaderString.Length & "'>" & l_ReportName & "</td></tr>" & Chr(10) & Chr(13))
        HTMLString.Append("<tr height='20px;'><td align='Center' class='ReportingPeriod' colspan='" & HeaderString.Length & "'>" & l_Period & "</td></tr>" & Chr(10) & Chr(13))
        'HTMLString.Append("<tr height='20px;'><td colspan='" & HeaderString.Length & "'>&nbsp;</td></tr>")
    End Sub

    Private Sub PrintTableHearder()
        HTMLString.Append("<tr>")
        For i As Integer = 0 To HeaderString.Length - 1
            HTMLString.Append("     <td class='TableHeading' >" & HeaderString(i) & "</td>" & Chr(10) & Chr(13))
        Next
        HTMLString.Append("</tr>" & Chr(10) & Chr(13))
    End Sub

    Private Sub PrintGrandTotals()
        'Create Totals For Table

        HTMLString.Append("<tr><td style='height:15px;'></td></tr>")
        HTMLString.Append("<tr>")

        For a As Integer = 0 To HeaderString.Length - 1
            If Not TotalString(a) = TotalRequired.NO Then
                HTMLString.Append("     <td class='TableHeading' Align='Right' style='Padding-right:4px'>" & Format(TotalString(a), "0.00") & "</td>" & Chr(10) & Chr(13))
            Else
                HTMLString.Append(IIf(a = 0, "     <td class='TableHeading' >Total</td>" & Chr(10) & Chr(13), "     <td class='TableHeading'>&nbsp;</td>" & Chr(10) & Chr(13)))
            End If
        Next
        HTMLString.Append("</tr>" & Chr(10) & Chr(13))
    End Sub

    Private Sub PrintGroupByTotals(ByRef PreviousGroupByString As String, ByVal GroupBy As String, ByRef GroupByTotal As Double, ByVal GroupByIndex As Integer, ByVal rw As DataRowView, ByRef CurrentLineNo As Integer, ByRef GroupByRecordCount As Integer, ByRef isAveragRequired As Boolean)

        If rw Is Nothing Then Exit Sub

        If Not GroupBy = "" Then
            If Not PreviousGroupByString = "" And Not PreviousGroupByString = rw.Item(GroupBy) Then
                HTMLString.Append("<tr>")

                If GroupByTotal = 0 Then
                    GroupByTotal = TotalString(GroupByIndex)
                Else
                    GroupByTotal = TotalString(GroupByIndex) - GroupByTotal
                End If

                For b As Integer = 0 To HeaderString.Length - 1
                    If b = GroupByIndex Then
                        If isAveragRequired = True Then
                            HTMLString.Append("<td class='TableHeading' align='right' style='Padding-right:4px'> Total &nbsp;" & GroupByRecordCount & "<td>" & Chr(10) & Chr(13))
                        Else
                            HTMLString.Append("<td class='TableHeading' align='right' style='Padding-right:4px' >" & Format(GroupByTotal, "0.00") & "<td>" & Chr(10) & Chr(13))
                        End If

                    Else
                        If isAveragRequired = True And b = 0 Then
                            HTMLString.Append("<td class='TableHeading'> Average " & HeaderString(GroupByIndex) & " " & Format(GroupByTotal / GroupByRecordCount, "##.##") & "</td>" & Chr(10) & Chr(13))
                        Else
                            HTMLString.Append("<td>&nbsp;</td>")
                        End If

                    End If
                Next

                GroupByTotal = TotalString(GroupByIndex)
                HTMLString.Append("</tr>" & Chr(10) & Chr(13))
                HTMLString.Append("<tr><td></td></tr>" & Chr(10) & Chr(13))
                GroupByRecordCount = 0
                CurrentLineNo += 2
            End If
            PreviousGroupByString = rw.Item(GroupBy)
        End If
    End Sub

    Private Sub PrintFooter()
        HTMLString.Append("<tr height='20px;'><td align='right' class='ReportingPeriod' colspan='" & HeaderString.Length & "'>" & l_FoorterText & "</td></tr>" & Chr(10) & Chr(13))
    End Sub

#End Region



End Class
