Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.NS
    Public Class NS_BillingReport
#Region " Private Members "
        Private _id As Integer
        Private _generateddate As Date
        Private _startdate As Date
        Private _enddate As Date

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

        Public Property GeneratedDate() As Date
            Get
                Return _generateddate
            End Get
            Set(ByVal value As Date)
                _generateddate = value
            End Set
        End Property

        Public Property StartDate() As Date
            Get
                Return _startdate
            End Get
            Set(ByVal value As Date)
                _startdate = value
            End Set
        End Property

        Public Property EndDate() As Date
            Get
                Return _enddate
            End Get
            Set(ByVal value As Date)
                _enddate = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal GeneratedDate As Date, _
          ByVal StartDate As Date, _
          ByVal EndDate As Date _
         )


            Me.ID = ID
            Me.GeneratedDate = GeneratedDate
            Me.StartDate = StartDate
            Me.EndDate = EndDate


        End Sub
#End Region

#Region " Public Method "

        Public Shared Function NS_BillingReportGetByID(ByVal ID As Integer) As List(Of NS_BillingReport)
            Return Portal.DAL.NS.DBNS_BillingReport.NS_BillingReportGetByID(ID)
        End Function
        Public Shared Function NS_BillingReportAdd(ByVal ID As Integer, ByVal GeneratedDate As Date, ByVal StartDate As Date, ByVal EndDate As Date) As Integer
            Dim NS_BillingReportBll As Portal.BLL.NS.NS_BillingReport = New Portal.BLL.NS.NS_BillingReport(ID, GeneratedDate, StartDate, EndDate)
            Dim NS_BillingReportDal As Portal.DAL.NS.DBNS_BillingReport = New Portal.DAL.NS.DBNS_BillingReport()
            Return NS_BillingReportDal.Add(NS_BillingReportBll)
        End Function

        Public Shared Function NS_BillingReportGetForClients(ByVal StartDate As Date) As DataSet
            Return Portal.DAL.NS.DBNS_BillingReport.NS_BillingReportGetForClients(StartDate)
        End Function
        Public Shared Function NS_BillingReportGetForFranchises(ByVal ReportID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal Status As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            Return Portal.DAL.NS.DBNS_BillingReport.NS_BillingReportGetForFranchises(ReportID, ClientID, FranchiseID, ProductID, Search, Status, sortBy, startRowIndex, maximumRows)
        End Function
        Public Shared Function NS_BillingReportGetForFranchisesCount(ByVal ReportID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal Status As Integer) As Integer
            Return Portal.DAL.NS.DBNS_BillingReport.NS_BillingReportGetForFranchisesCount(ReportID, ClientID, FranchiseID, ProductID, Search, Status)
        End Function
        Public Shared Function NS_BillingReportGetForFranchisesSumAmount(ByVal ReportID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal Status As Integer) As Double
            Return Portal.DAL.NS.DBNS_BillingReport.NS_BillingReportGetForFranchisesSumAmount(ReportID, ClientID, FranchiseID, ProductID, Search, Status)
        End Function
        Public Shared Function NS_BillingReportGetForProcessing(ByVal ClientID As Integer, ByVal CountryID As Integer, ByVal ReportID As Integer, ByVal ProductID As Integer, ByVal Search As String, ByVal sortBy As String) As DataTable
            Return Portal.DAL.NS.DBNS_BillingReport.NS_BillingReportGetForProcessing(ClientID, CountryID, ReportID, ProductID, Search, sortBy)
        End Function
#End Region

    End Class
End Namespace