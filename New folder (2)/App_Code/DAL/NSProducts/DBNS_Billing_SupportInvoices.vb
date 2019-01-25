Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_Billing_SupportInvoices
#Region " Public Method "
        
        Public Shared Function NS_Billing_SupportInvoicesGetAll(ByVal StateID As Integer, ByVal ClientID As Integer, ByVal Status As Integer, ByVal search As String, ByVal StartDate As Date, ByVal EndDate As Date, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@StateID", StateID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Status", IIf(Status = 1, True, IIf(Status = 2, False, DBNull.Value)))
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)
            Return db.ExecuteDataTable("NS_Billing_SupportInvoices_GetAll")
        End Function
        Public Shared Function NS_Billing_SupportInvoicesGetAllCount(ByVal StateID As Integer, ByVal ClientID As Integer, ByVal Status As Integer, ByVal search As String, ByVal StartDate As Date, ByVal EndDate As Date) As Integer
            Dim db As New DBAccess
            db.AddParameter("@StateID", StateID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Status", IIf(Status = 1, True, IIf(Status = 2, False, DBNull.Value)))
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            Return db.ExecuteScalar("NS_Billing_SupportInvoices_GetAllCount")
        End Function
        Public Shared Function NS_Billing_SupportInvoicesGetByID(ByVal ID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            Return db.ExecuteDataTable("NS_Billing_SupportInvoices_GetByID")
        End Function
        Public Shared Function NS_Billing_SupportInvoicesItemsGetBySupportInvoiceID(ByVal SupportInvoiceID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@SupportInvoiceID", SupportInvoiceID)
            Return db.ExecuteDataTable("NS_Billing_SupportInvoicesItem_GetBySupportInvoiceID")
        End Function
        Public Function UpdateStatus(ByVal ID As Integer, ByVal PaymentID As Integer, ByVal QuickBookInvoiceNo As Integer, ByVal PaymentBy As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@PaymentMethodID", PaymentID)
            db.AddParameter("@QuickBookInvoiceNo", QuickBookInvoiceNo)
            db.AddParameter("@PaymentBy", PaymentBy)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Billing_SupportInvoices_UpdateStatus")
            Return Affected
        End Function

        Public Function UpdateInvoiceStatus(ByVal IDs As String, ByVal PaymentID As Integer, ByVal PaymentBy As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@IDs", IDs)
            db.AddParameter("@PaymentMethodID", PaymentID)
            db.AddParameter("@PaymentBy", PaymentBy)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Billing_SupportInvoices_UpdateInvoiceStatus")
            Return Affected
        End Function
#End Region

    End Class
End Namespace