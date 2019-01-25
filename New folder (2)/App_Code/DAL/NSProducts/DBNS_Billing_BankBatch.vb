Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_Billing_BankBatch
#Region " Public Method "
        Public Shared Function NS_Billing_BankBatchGetAll(ByVal CountryID As Integer, ByVal ClientID As Integer, ByVal BillingReportID As Integer, ByVal search As String, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@CountryID", CountryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@BillingReportID", BillingReportID)
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)
            Return db.ExecuteDataTable("NS_Billing_BankBatch_GetAll")
        End Function
        Public Shared Function NS_Billing_BankBatchGetAllCount(ByVal CountryID As Integer, ByVal ClientID As Integer, ByVal BillingReportID As Integer, ByVal search As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@CountryID", CountryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@BillingReportID", BillingReportID)
            db.AddParameter("@searchtxt", search)
            Return db.ExecuteScalar("NS_Billing_BankBatch_GetAllCount")
        End Function
        Public Function Add(ByVal CountryID As Integer, ByVal ClientID As Integer, ByVal BillingReportID As Integer, ByVal BillingReportProductProcessIDs As String) As Integer
            Dim db As New DBAccess

            db.AddParameter("@CountryID", CountryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@BillingReportID", BillingReportID)
            db.AddParameter("@BilingReportDetailIDs", BillingReportProductProcessIDs)
            db.AddParameter("@GUID", Guid.NewGuid())

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Billing_BankBatch_Add")
            Return Affected
        End Function
        Public Function UpdateConfirm(ByVal ID As Integer, ByVal ConfirmedBy As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@ConfirmedBy", ConfirmedBy)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Billing_BankBatch_UpdateConfirm")
            Return Affected
        End Function

#End Region

    End Class
End Namespace