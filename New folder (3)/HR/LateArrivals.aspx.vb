Imports Portal.BLL.HR
Imports System.Data

Partial Class HR_LateArrivals
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (String.IsNullOrEmpty(Request.QueryString("Token")) = False) Then
            If (Request.QueryString("Token").ToLower() = ConfigurationManager.AppSettings("TokentoViewHRReport").ToString().ToLower()) Then
                lblCompanyName.Text = ConfigurationManager.AppSettings("CompanyName")
                lblReportTitle.Text = "Employees Absent/Late Arrival Report"
                Dim isForSupport As Boolean = False
                If (String.IsNullOrEmpty(Request.QueryString("IsSupport")) = False) Then
                    isForSupport = True
                End If
                Dim dtEmployees As DataTable = HR_UserTimeHistory.GetLateArrivalAndAbsentReportByDate(Date.Now, isForSupport)

                Dim dtFilteredEmployees As New DataTable
                Dim drFitlerEmployees() As DataRow
                dtFilteredEmployees = dtEmployees.Clone()
                'Filter report by present and late employees

                drFitlerEmployees = dtEmployees.Select("IsPresent = True")
                For Each drEmployee As DataRow In drFitlerEmployees
                    dtFilteredEmployees.ImportRow(drEmployee)
                Next


                rptEmployeesLaterArrived.DataSource = dtFilteredEmployees
                rptEmployeesLaterArrived.DataBind()

                drFitlerEmployees = Nothing
                dtFilteredEmployees.Clear()

                'Filter report by absent employees
                drFitlerEmployees = dtEmployees.Select("IsPresent = False")
                For Each drEmployee As DataRow In drFitlerEmployees
                    dtFilteredEmployees.ImportRow(drEmployee)
                Next

                rptEmployeesAbsent.DataSource = dtFilteredEmployees
                rptEmployeesAbsent.DataBind()
            Else
                Response.Redirect("~/AccessDenied.aspx", True)
            End If
        Else
            Response.Redirect("~/AccessDenied.aspx", True)
        End If
    End Sub
    
    Protected Sub rptEmployeesAbsent_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptEmployeesAbsent.PreRender
        If (rptEmployeesAbsent.Items.Count = 0) Then
            rptEmployeesAbsent.Visible = False
            trNoAbsentEmployees.Visible = True
            ltrlNoAbsentEmployees.Text = "<i>No absent employees!<i>"
        Else
            trNoAbsentEmployees.Visible = False
        End If
    End Sub

    Protected Sub rptEmployeesLaterArrived_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptEmployeesLaterArrived.PreRender
        If (rptEmployeesLaterArrived.Items.Count = 0) Then
            rptEmployeesLaterArrived.Visible = False
            trNoLateArrivedEmployees.Visible = True
            ltrlNoLateArrivedEmployees.Text = "<i>No late arrivals!<i>"
        Else
            trNoLateArrivedEmployees.Visible = False
        End If
    End Sub
End Class
