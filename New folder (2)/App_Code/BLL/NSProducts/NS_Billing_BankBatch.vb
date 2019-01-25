Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_Billing_BankBatch
#Region " Private Members "
        Private _id As Integer
        Private _countryid As Integer
        Private _clientid As Integer
        Private _billingreportid As Integer
        Private _deleted As Boolean
        Private _generatedon As Date

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

        Public Property CountryID() As Integer
            Get
                Return _countryid
            End Get
            Set(ByVal value As Integer)
                _countryid = value
            End Set
        End Property

        Public Property ClientID() As Integer
            Get
                Return _clientid
            End Get
            Set(ByVal value As Integer)
                _clientid = value
            End Set
        End Property

        Public Property BillingReportID() As Integer
            Get
                Return _billingreportid
            End Get
            Set(ByVal value As Integer)
                _billingreportid = value
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

        Public Property GeneratedOn() As Date
            Get
                Return _generatedon
            End Get
            Set(ByVal value As Date)
                _generatedon = value
            End Set
        End Property

#End Region

#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal CountryID As Integer, _
          ByVal ClientID As Integer, _
          ByVal BillingReportID As Integer, _
          ByVal Deleted As Boolean, _
          ByVal GeneratedOn As Date _
         )


            Me.ID = ID
            Me.CountryID = CountryID
            Me.ClientID = ClientID
            Me.BillingReportID = BillingReportID
            Me.Deleted = Deleted
            Me.GeneratedOn = GeneratedOn


        End Sub
#End Region

#Region " Public Method "
        
        Public Shared Function NS_Billing_BankBatchGetAll(ByVal CountryID As Integer, ByVal ClientID As Integer, ByVal BillingReportID As Integer, ByVal search As String, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Return Portal.DAL.NS.DBNS_Billing_BankBatch.NS_Billing_BankBatchGetAll(CountryID, ClientID, BillingReportID, search, sortBy, startRowIndex, maximumRows)
        End Function
        Public Shared Function NS_Billing_BankBatchGetAllCount(ByVal CountryID As Integer, ByVal ClientID As Integer, ByVal BillingReportID As Integer, ByVal search As String) As Integer
            Return Portal.DAL.NS.DBNS_Billing_BankBatch.NS_Billing_BankBatchGetAllCount(CountryID, ClientID, BillingReportID, search)
        End Function
        Public Shared Function NS_Billing_BankBatchAdd(ByVal CountryID As Integer, ByVal ClientID As Integer, ByVal BillingReportID As Integer, ByVal BillingReportProductProcessIDs As String) As Integer
            Dim NS_Billing_BankBatchDal As Portal.DAL.NS.DBNS_Billing_BankBatch = New Portal.DAL.NS.DBNS_Billing_BankBatch()
            Return NS_Billing_BankBatchDal.Add(CountryID, ClientID, BillingReportID, BillingReportProductProcessIDs)
        End Function
        Public Shared Function NS_Billing_BankBatchUpdateConfirm(ByVal ID As Integer, ByVal ConfirmedBy As Integer) As Integer
            Dim NS_Billing_BankBatchDal As Portal.DAL.NS.DBNS_Billing_BankBatch = New Portal.DAL.NS.DBNS_Billing_BankBatch()
            Return NS_Billing_BankBatchDal.UpdateConfirm(ID, ConfirmedBy)
        End Function
#End Region

    End Class
End Namespace