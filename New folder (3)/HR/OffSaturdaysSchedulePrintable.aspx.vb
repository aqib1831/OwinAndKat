
Partial Class HR_OffSatudaysSchedulePrintable
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Me.hdnStartDate.Value = DateTime.Now
        Me.hdnEndDate.Value = DateTime.Now.AddMonths(4)
        ltrlGeneratedOn.Text = DateTime.Now.ToString("dd/MM/yyyy hh:mm tt")
        sdsGetOffSaturdayDates.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString
        Dim db As New DBAccess()
        Dim dtList As New System.Data.DataTable()
        dtList = db.ExecuteDataTable("HR_GetOffSaturdayGroupList")
        Dim StrEmployeeName As String = String.Empty
        Dim Group As String = String.Empty
        Dim Department As String = String.Empty
        Dim StrHtmlLeft As String = String.Empty
        Dim StrHtmlRight As String = String.Empty
        Dim ListGroupA As New System.Collections.ArrayList()
        Dim ListGroupB As New System.Collections.ArrayList()
        Dim Counter As Integer = 0
        Counter = dtList.Rows.Count
        Dim TotalRowsPerSide As Integer = 0
        Dim RowsPerSide As Integer = 0
        Dim DepartmentsPerSide As Integer = 0
        Dim RowNumber As Integer = 0
        TotalRowsPerSide = (dtList.Rows.Count / 2) '- ((dtList.Rows.Count / 2) / 2)
        For Each item As System.Data.DataRow In dtList.Rows
            RowNumber = RowNumber + 1
            If String.IsNullOrEmpty(Department) Then
                Department = item("Department")

                REM StrHtmlLeft &= IIf(Counter > TotalRowsPerSide, "<div class='dvDepartmentHeading'>" & item("Department") & "</div>", "")
                REM StrHtmlRight &= IIf(Counter <= TotalRowsPerSide, "<div class='dvDepartmentHeading'>" & item("Department") & "</div>", "")

                If item("GroupType") = 1 Then
                    ListGroupA.Add(item("Employee"))
                Else
                    ListGroupB.Add(item("Employee"))
                End If
            Else
                If Department <> item("Department") Then


                    StrHtmlLeft &= IIf(Counter > TotalRowsPerSide, RenderEmployeeBoxes(ListGroupA, ListGroupB, Department), "")
                    StrHtmlRight &= IIf(Counter <= TotalRowsPerSide, RenderEmployeeBoxes(ListGroupA, ListGroupB, Department), "")
                    Department = item("Department")
                    Counter = Counter - (ListGroupA.Count + ListGroupB.Count)
                    ListGroupA.Clear()
                    ListGroupB.Clear()

                    If item("GroupType") = 1 Then
                        ListGroupA.Add(item("Employee"))
                    Else
                        ListGroupB.Add(item("Employee"))
                    End If

                    If RowNumber = dtList.Rows.Count Then
                        StrHtmlLeft &= IIf(Counter > TotalRowsPerSide, RenderEmployeeBoxes(ListGroupA, ListGroupB, Department), "")
                        StrHtmlRight &= IIf(Counter <= TotalRowsPerSide, RenderEmployeeBoxes(ListGroupA, ListGroupB, Department), "")
                        Department = item("Department")
                        Counter = Counter - (ListGroupA.Count + ListGroupB.Count)
                        ListGroupA.Clear()
                        ListGroupB.Clear()
                    End If

                ElseIf Department = item("Department") Then


                    If item("GroupType") = 1 Then
                        ListGroupA.Add(item("Employee"))
                    Else
                        ListGroupB.Add(item("Employee"))
                    End If

                    If RowNumber = dtList.Rows.Count Then
                        StrHtmlLeft &= IIf(Counter > TotalRowsPerSide, RenderEmployeeBoxes(ListGroupA, ListGroupB, Department), "")
                        StrHtmlRight &= IIf(Counter <= TotalRowsPerSide, RenderEmployeeBoxes(ListGroupA, ListGroupB, Department), "")
                        Department = item("Department")
                        Counter = Counter - (ListGroupA.Count + ListGroupB.Count)
                        ListGroupA.Clear()
                        ListGroupB.Clear()
                    End If

                End If
            End If
            REM Counter = Counter - 1
        Next
        Me.ltrlListLeft.Text = StrHtmlLeft
        Me.ltrlListRight.Text = StrHtmlRight

    End Sub

    Private Function RenderEmployeeBoxes(ByVal ListA As System.Collections.ArrayList, ByVal ListB As System.Collections.ArrayList, ByVal Department As String) As String
        Dim StrGroupA As String = String.Empty
        Dim StrGroupB As String = String.Empty
        Dim ReturnHtml As String = String.Empty

        ReturnHtml &= "<div class='dvDepartmentHeading'>" & Department & "</div>"
        ReturnHtml &= "<div style='float:left; width:50%;'>"
        For Each item As String In ListA
            StrGroupA &= "<div class='dvEmployeeLeft'><div style='overflow:hidden; width:100%; white-space:nowrap;'>" & item & "</div></div>"
        Next

        Dim Counter As Integer = 0
        If ListA.Count < ListB.Count Then
            While Counter < (ListB.Count - ListA.Count)
                StrGroupA &= "<div class='dvEmployeeLeft'>&nbsp;</div>"
                Counter = Counter + 1
            End While
        End If
        ReturnHtml &= StrGroupA

        ReturnHtml &= "</div>"
        ReturnHtml &= "<div style='float:left; width:50%;'>"
        For Each item As String In ListB
            StrGroupB &= "<div class='dvEmployeeRight'><div style='overflow:hidden; width:100%; white-space:nowrap;'>" & item & "</div></div>"
        Next

        Counter = 0
        If ListB.Count < ListA.Count Then
            While Counter < (ListA.Count - ListB.Count)
                StrGroupB &= "<div class='dvEmployeeRight'>&nbsp;</div>"
                Counter = Counter + 1
            End While
        End If
        ReturnHtml &= StrGroupB
        ReturnHtml &= "</div>"
        ReturnHtml &= "<div class='dvEmployeeFooter'>&nbsp;</div>"


        Return ReturnHtml
    End Function
End Class
