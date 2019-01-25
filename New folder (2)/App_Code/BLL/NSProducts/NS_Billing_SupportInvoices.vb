Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_Billing_SupportInvoices
#Region " Private Members "
        Private _id As Integer
        Private _franchiseid As Integer
        Private _generatedon As Date
        Private _status As Integer
        Private _deleted As Boolean
        Private _paymentmethodid As Integer
        Private _quickbookinvoiceno As Integer

#End Region
#Region " Public Properties "

        Public Property ID() As Integer
            Get
                Return _id
            End Get
            Set(ByVal value As Integer)
                _id = value
            End Set
        End Property

        Public Property FranchiseID() As Integer
            Get
                Return _franchiseid
            End Get
            Set(ByVal value As Integer)
                _franchiseid = value
            End Set
        End Property

        Public Property GeneratedOn() As Date
            Get
                Return _generatedon
            End Get
            Set(ByVal value As Date)
                _generatedon = value
            End Set
        End Property

        Public Property Status() As Integer
            Get
                Return _status
            End Get
            Set(ByVal value As Integer)
                _status = value
            End Set
        End Property

        Public Property Deleted() As Boolean
            Get
                Return _deleted
            End Get
            Set(ByVal value As Boolean)
                _deleted = value
            End Set
        End Property

        Public Property PaymentMethodID() As Integer
            Get
                Return _paymentmethodid
            End Get
            Set(ByVal value As Integer)
                _paymentmethodid = value
            End Set
        End Property

        Public Property QuickBookInvoiceNo() As Integer
            Get
                Return _quickbookinvoiceno
            End Get
            Set(ByVal value As Integer)
                _quickbookinvoiceno = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal GeneratedOn As Date, _
          ByVal Status As Integer, _
          ByVal Deleted As Boolean, _
          ByVal PaymentMethodID As Integer, _
          ByVal QuickBookInvoiceNo As Integer _
         )


            Me.ID = ID
            Me.FranchiseID = FranchiseID
            Me.GeneratedOn = GeneratedOn
            Me.Status = Status
            Me.Deleted = Deleted
            Me.PaymentMethodID = PaymentMethodID
            Me.QuickBookInvoiceNo = QuickBookInvoiceNo


        End Sub
#End Region

#Region " Public Method "
        Public Shared Function NS_Billing_SupportInvoicesGetAll(ByVal StateID As Integer, ByVal ClientID As Integer, ByVal Status As Integer, ByVal search As String, ByVal StartDate As Date, ByVal EndDate As Date, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Return Portal.DAL.NS.DBNS_Billing_SupportInvoices.NS_Billing_SupportInvoicesGetAll(StateID, ClientID, Status, search, StartDate, EndDate, sortBy, startRowIndex, maximumRows)
        End Function
        Public Shared Function NS_Billing_SupportInvoicesGetAllCount(ByVal StateID As Integer, ByVal ClientID As Integer, ByVal Status As Integer, ByVal search As String, ByVal StartDate As Date, ByVal EndDate As Date) As Integer
            Return Portal.DAL.NS.DBNS_Billing_SupportInvoices.NS_Billing_SupportInvoicesGetAllCount(StateID, ClientID, Status, search, StartDate, EndDate)
        End Function
        Public Shared Function NS_Billing_SupportInvoicesGetbyID(ByVal ID As Integer) As DataTable
            Return Portal.DAL.NS.DBNS_Billing_SupportInvoices.NS_Billing_SupportInvoicesGetbyID(ID)
        End Function
        Public Shared Function NS_Billing_SupportInvoicesItemsGetBySupportInvoiceID(ByVal SupportInvoiceID As Integer) As DataTable
            Return Portal.DAL.NS.DBNS_Billing_SupportInvoices.NS_Billing_SupportInvoicesItemsGetBySupportInvoiceID(SupportInvoiceID)
        End Function
        Public Shared Function NS_Billing_SupportInvoicesUpdateStatus(ByVal ID As Integer, ByVal PaymentID As Integer, ByVal QuickBookInvoiceNo As Integer, ByVal PaymentBy As Integer) As Integer
            Dim Billing_SupportInvoicesDal As Portal.DAL.NS.DBNS_Billing_SupportInvoices = New Portal.DAL.NS.DBNS_Billing_SupportInvoices()
            Return Billing_SupportInvoicesDal.UpdateStatus(ID, PaymentID, QuickBookInvoiceNo, PaymentBy)
        End Function
        Public Shared Function NS_Billing_SupportInvoicesUpdateInvoiceStatus(ByVal IDs As String, ByVal PaymentID As Integer, ByVal PaymentBy As Integer) As Integer
            Dim Billing_SupportInvoicesDal As Portal.DAL.NS.DBNS_Billing_SupportInvoices = New Portal.DAL.NS.DBNS_Billing_SupportInvoices()
            Return Billing_SupportInvoicesDal.UpdateInvoiceStatus(IDs, PaymentID, PaymentBy)
        End Function
#End Region

    End Class
End Namespace