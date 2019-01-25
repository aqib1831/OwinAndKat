Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Imports Portal.DAL
Namespace Portal.BLL.HR
    Public Class Jobs
#Region " Private Members "
        Private _id As Integer
        Private _stateid As Integer
        Private _locationid As Integer
        Private _jobtitle As String
        Private _description As String
        Private _postingdate As Date
        Public _lastdate As Nullable(Of DateTime)
        Private _inactive As Boolean
        Private _deleted As Boolean
        Private _statecode As String
        Private _locationnick As String
        Private _statename As String
        Private _mainItems As JobDetailList
        Private _sequence As Integer
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

        Public Property StateID() As Integer
            Get
                Return _stateid
            End Get
            Set(ByVal value As Integer)
                _stateid = value
            End Set
        End Property

        Public Property LocationID() As Integer
            Get
                Return _locationid
            End Get
            Set(ByVal value As Integer)
                _locationid = value
            End Set
        End Property
        Public Property Sequence() As Integer
            Get
                Return _sequence
            End Get
            Set(ByVal value As Integer)
                _sequence = value
            End Set
        End Property

        Public Property JobTitle() As String
            Get
                Return _jobtitle
            End Get
            Set(ByVal value As String)
                _jobtitle = value
            End Set
        End Property

        Public Property Description() As String
            Get
                Return _description
            End Get
            Set(ByVal value As String)
                _description = value
            End Set
        End Property

        Public Property PostingDate() As Date
            Get
                Return _postingdate
            End Get
            Set(ByVal value As Date)
                _postingdate = value
            End Set
        End Property

        Public Property LastDate() As Date
            Get
                Return _lastdate
            End Get
            Set(ByVal value As Date)
                _lastdate = value
            End Set
        End Property

        Public Property InActive() As Boolean
            Get
                Return _inactive
            End Get
            Set(ByVal value As Boolean)
                _inactive = value
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

        Public Property StateCode() As String
            Get
                Return _statecode
            End Get
            Set(ByVal value As String)
                _statecode = value
            End Set
        End Property

        Public Property LocationNick() As String
            Get
                Return _locationnick
            End Get
            Set(ByVal value As String)
                _locationnick = value
            End Set
        End Property
        Public Property StateName() As String
            Get
                Return _statename
            End Get
            Set(ByVal value As String)
                _statename = value
            End Set
        End Property
        Public Property JobDetailList() As JobDetailList
            Get
                Return _mainItems
            End Get
            Set(ByVal value As JobDetailList)
                _mainItems = value
            End Set
        End Property
#End Region


#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal StateID As Integer, _
          ByVal LocationID As Integer, _
          ByVal JobTitle As String, _
          ByVal Description As String, _
          ByVal PostingDate As Date, _
          ByVal LastDate As Date, _
          ByVal InActive As Boolean, _
          ByVal Deleted As Boolean _
         )


            Me.ID = ID
            Me.StateID = StateID
            Me.LocationID = LocationID
            Me.JobTitle = JobTitle
            Me.Description = Description
            Me.PostingDate = PostingDate
            Me.LastDate = LastDate
            Me.InActive = InActive
            Me.Deleted = Deleted


        End Sub

        'Gell All By location
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal JobTitle As String, _
          ByVal Description As String, _
          ByVal PostingDate As Date, _
          ByVal LastDate As Date, _
          ByVal LocationNick As String, _
          ByVal InActive As Boolean, _
          ByVal Sequence As Integer _
          )

            Me.ID = ID
            Me.JobTitle = JobTitle
            Me.Description = Description
            Me.PostingDate = PostingDate
            Me.LastDate = LastDate
            Me.LocationNick = LocationNick
            Me.InActive = InActive
            Me.Sequence = Sequence

        End Sub
        Public Sub New( _
         ByVal ID As Integer, _
         ByVal JobTitle As String, _
         ByVal Description As String, _
         ByVal PostingDate As Date, _
         ByVal LastDate As Date, _
         ByVal LocationNick As String, _
         ByVal InActive As Boolean _
         )

            Me.ID = ID
            Me.JobTitle = JobTitle
            Me.Description = Description
            Me.PostingDate = PostingDate
            Me.LastDate = LastDate
            Me.LocationNick = LocationNick
            Me.InActive = InActive

        End Sub
#End Region

#Region " Public Method "
        Public Shared Function JobsGetAllByLocation(ByVal StatusID As Integer, ByVal countryId As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Jobs)

            Return Portal.DAL.HR.DBJobs.JobsGetAllByLocation(StatusID, countryId, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Shared Function JobsGetAllByLocationCount(ByVal StatusID As Integer, ByVal countryId As Integer, ByVal txtsearch As String) As Integer
            Return Portal.DAL.HR.DBJobs.JobsGetAllByLocationCount(StatusID, countryId, txtsearch)
        End Function
        Public Shared Function JobsGetByID(ByVal ID As Integer) As List(Of Jobs)
            Return Portal.DAL.HR.DBJobs.JobsGetByID(ID)
        End Function
        Public Shared Function GetJobByID(ByVal ID As Integer) As DataTable
            Return Portal.DAL.HR.DBJobs.GetJobByID(ID)
        End Function
        Public Shared Function JobsGetAll() As List(Of Jobs)
            Return Portal.DAL.HR.DBJobs.JobsGetAll()
        End Function
        Public Shared Function JobsAdd(ByVal ID As Integer, ByVal StateID As Integer, ByVal LocationID As Integer, ByVal JobTitle As String, ByVal Description As String, ByVal PostingDate As Date, ByVal LastDate As Date, ByVal InActive As Boolean, ByVal Deleted As Boolean) As Integer
            Dim JobsBll As Portal.BLL.HR.Jobs = New Portal.BLL.HR.Jobs(ID, StateID, LocationID, JobTitle, Description, PostingDate, LastDate, InActive, Deleted)
            Dim JobsDal As Portal.DAL.HR.DBJobs = New Portal.DAL.HR.DBJobs()
            Return JobsDal.Add(JobsBll)
        End Function

        Public Function AddJob() As Integer
            Dim returnValue As Integer = 0
            Dim ObjJobDal As Portal.DAL.HR.DBJobs = New Portal.DAL.HR.DBJobs()
            Return ObjJobDal.Add(Me)
        End Function
        Public Function UpdateJob() As Integer
            Dim returnValue As Integer = 0
            Dim ObjJobDal As Portal.DAL.HR.DBJobs = New Portal.DAL.HR.DBJobs()
            Return ObjJobDal.Update(Me)
        End Function
        Public Shared Function GetJobTemplateDetailByID(ByVal ID As Integer) As SqlDataReader
            Dim dr As SqlDataReader = Nothing
            dr = Portal.DAL.HR.DBJobs.GetJobTemplateDetailByID(ID)
            Return dr
        End Function
        Public Shared Function Jobs_DeleteByID(ByVal ID As Integer) As Integer
            Return Portal.DAL.HR.DBJobs.Jobs_DeleteByID(ID)
        End Function
        Public Shared Function LoadJobDetailListFromDictionary(ByVal ObjJobDetail As Object()) As JobDetailList
            Dim ObjJobDetailList As New JobDetailList()

            For Each obj As Object In ObjJobDetail
                Dim dicMainItems As Dictionary(Of String, Object) = CType(obj, Dictionary(Of String, Object))
                Dim objMainItem As New JobDetail
                objMainItem.Name = dicMainItems.Item("Name")
                objMainItem.AttributeID = dicMainItems.Item("JobAttributeID")
                Dim objSubDetail As Object() = CType(obj.Item("subItems"), Object())
                objMainItem.SubItemsList = Jobs.LoadJobDetailSubItemsFromDictionary(objSubDetail)
                ObjJobDetailList.Add(objMainItem)
            Next
            Return ObjJobDetailList
        End Function
        Public Shared Function LoadJobDetailSubItemsFromDictionary(ByVal ObjJobDetail As Object()) As JobDetailList
            Dim ObjJobDetailList As New JobDetailList()

            For Each obj As Object In ObjJobDetail
                Dim dicSubItems As Dictionary(Of String, Object) = CType(obj, Dictionary(Of String, Object))
                Dim objSubItem As New JobDetail
                objSubItem.Name = dicSubItems.Item("Name")
                objSubItem.AttributeID = dicSubItems.Item("JobAttributeID")
                ObjJobDetailList.Add(objSubItem)
            Next
            Return ObjJobDetailList
        End Function
        Public Shared Function AddNewJob(ByVal objJob As Jobs) As Integer
            Dim objDBManager As New DbManager
            Dim jobId As Integer
            Try
                objDBManager.BeginTransaction()
                jobId = DAL.HR.DBJobs.AddNewJob(objJob)
                If Not (objJob.JobDetailList Is Nothing) And objJob.JobDetailList.Count > 0 Then
                    For Each objJobDetail As JobDetail In objJob.JobDetailList
                        objJobDetail.JobID = jobId
                        Dim parentId As Integer = DAL.HR.DBJobs.AddJobDetail(objJobDetail)
                        If Not (objJobDetail.SubItemsList Is Nothing) And objJobDetail.SubItemsList.Count > 0 Then
                            For Each objsubItem As JobDetail In objJobDetail.SubItemsList
                                objsubItem.JobID = jobId
                                objsubItem.ParentID = parentId
                                DAL.HR.DBJobs.AddJobDetail(objsubItem)
                            Next
                        End If
                    Next
                End If
                objDBManager.CommitTransaction()
            Catch ex As Exception
                objDBManager.RollBackTransaction()
                Throw ex
            Finally
                objDBManager = Nothing
            End Try
            Return jobId
        End Function
        Public Shared Function UpdateJob(ByVal objJob As Jobs) As Integer
            Dim objDBManager As New DbManager
            Try
                objDBManager.BeginTransaction()
                DAL.HR.DBJobs.UpdateNetsolaceJob(objJob)
                If Not (objJob.JobDetailList Is Nothing) And objJob.JobDetailList.Count > 0 Then
                    For Each objJobDetail As JobDetail In objJob.JobDetailList
                        objJobDetail.JobID = objJob.ID
                        Dim parentId As Integer = DAL.HR.DBJobs.AddJobDetail(objJobDetail)
                        If Not (objJobDetail.SubItemsList Is Nothing) And objJobDetail.SubItemsList.Count > 0 Then
                            For Each objsubItem As JobDetail In objJobDetail.SubItemsList
                                objsubItem.JobID = objJob.ID
                                objsubItem.ParentID = parentId
                                DAL.HR.DBJobs.AddJobDetail(objsubItem)
                            Next
                        End If
                    Next
                End If
                objDBManager.CommitTransaction()
            Catch ex As Exception
                objDBManager.RollBackTransaction()
                Throw ex
            Finally
                objDBManager = Nothing
            End Try
            Return objJob.ID
        End Function
        Public Shared Sub UpdateJobSequence(ByVal jobId As Integer, ByVal sequence As Integer)
            DAL.HR.DBJobs.UpdateJobSequence(jobId, sequence)
        End Sub

#End Region

    End Class
End Namespace