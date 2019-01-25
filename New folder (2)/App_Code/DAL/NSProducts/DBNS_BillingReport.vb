Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_BillingReport
#Region " Public Method "
        
        Public Shared Function NS_BillingReportGetByID(ByVal ID As Integer) As List(Of Portal.BLL.NS.NS_BillingReport)
            Dim colNS_BillingReport As New List(Of Portal.BLL.NS.NS_BillingReport)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("NS_BillingReport_GetByID")
            While dr.Read()
                colNS_BillingReport.Add(New Portal.BLL.NS.NS_BillingReport( _
                CType(dr("ID"), Integer), _
                CType(dr("GeneratedDate"), Date), _
                CType(dr("StartDate"), Date), _
                CType(dr("EndDate"), Date) _
                ))
            End While
            dr.Close()
            Return colNS_BillingReport
        End Function
        Public Function Add(ByVal NS_BillingReportBll As Portal.BLL.NS.NS_BillingReport) As Integer
            Dim db As New DBAccess

            'db.AddParameter("@ID", NS_BillingReportBll.ID)
            db.AddParameter("@GeneratedDate", NS_BillingReportBll.GeneratedDate)
            db.AddParameter("@StartDate", NS_BillingReportBll.StartDate)
            db.AddParameter("@EndDate", NS_BillingReportBll.EndDate)
            db.AddParameter("@ReturnID", SqlDbType.Int, 4, ParameterDirection.Output, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_BillingReport_Add")
            Affected = CInt(CType(db.Parameters("@ReturnID"), System.Data.SqlClient.SqlParameter).Value)
            Return Affected
        End Function
        Public Shared Function NS_BillingReportGetForClients(ByVal StartDate As Date) As DataSet
            Dim colNS_BillingReport As New List(Of Portal.BLL.NS.NS_BillingReport)()
            Dim ds As DataSet
            Dim db As New DBAccess
            db.AddParameter("@StartDate", StartDate)
            ds = db.ExecuteDataSet("Ns_BillingReport_getByStartDate")
            If (ds.Tables.Count = 3) Then
                ds.Relations.Add("Product", ds.Tables(0).Columns("ProductID"), ds.Tables(2).Columns("ProductID"))
                ds.Relations.Add("ProductDetail", ds.Tables(1).Columns("ClientID"), ds.Tables(2).Columns("ClientID"))
            End If
            Return ds
        End Function
        Public Shared Function NS_BillingReportGetForFranchises(ByVal ReportID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal Status As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim dt As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ReportID", ReportID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@Search", Search)
            db.AddParameter("@Status", Status)
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)
            dt = db.ExecuteDataTable("Ns_BillingReport_GetDetail")
            Return dt
        End Function
        Public Shared Function NS_BillingReportGetForFranchisesCount(ByVal ReportID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal Status As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ReportID", ReportID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@Search", Search)
            db.AddParameter("@Status", Status)
            Return db.ExecuteScalar("Ns_BillingReport_GetDetailCount")
        End Function
        Public Shared Function NS_BillingReportGetForFranchisesSumAmount(ByVal ReportID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal Status As Integer) As Double
            Dim db As New DBAccess
            db.AddParameter("@ReportID", ReportID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@Search", Search)
            db.AddParameter("@Status", Status)
            Return db.ExecuteScalar("Ns_BillingReport_GetDetailSumAmount")
        End Function
        Public Shared Function NS_BillingReportGetForProcessing(ByVal ClientID As Integer, ByVal CountryID As Integer, ByVal ReportID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal sortBy As String) As DataTable
            Dim dt As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CountryID", CountryID)
            db.AddParameter("@ReportID", ReportID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@Search", Search)
            db.AddParameter("@sortExpression", sortBy)
            dt = db.ExecuteDataTable("NS_BillingReport_Products_Franchises_GetForProcessing")
            Return dt
        End Function
#End Region

    End Class
End Namespace