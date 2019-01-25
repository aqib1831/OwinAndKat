Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports Portal.DAL.HR

Namespace Portal.BLL.HR
    Public Class HR_UserTimeHistory
#Region " Private Members "
        Private _id As Integer
        Private _userid As Integer
        Private _punchintime As DateTime
        Private _punchouttime As DateTime
        Private _lastaccesstime As Date
        Private _forcedpunchout As Boolean
        Private _notes As String
        Private _deleted As Boolean
        Private _lastupdatedby As Integer
        Private _lastupdatednotes As String
        Private _creationtype As Integer

        Private _lastupdatedadmin As String
        Private _currenthours As Integer
        Private _currentminutes As Integer
        Private _totalminutes As Integer

        Private _UserOfficeTimingProfileID As Integer = 0
        Private _LateArrival As Boolean = False
        Private _EarlyDeparture As Boolean = False
        Private _LateSitting As Boolean = False
        Private _LateArrivalNotes As String = String.Empty
        Private _EarlyDepartureNotes As String = String.Empty
        Private _LateSittingNotes As String = String.Empty
        Private _AnnualLeaves As Integer = 0
        Private _AnnualLeavesTaken As Integer = 0
        Private _AnnualLeavesBalance As Integer = 0
        Private _CausalLeaves As Integer = 0
        Private _CausalLeavesTaken As Integer = 0
        Private _CausalLeavesBalance As Integer = 0
        Private _AttendenceType As Integer = 0		

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

        Public Property UserID() As Integer
            Get
                Return _userid
            End Get
            Set(ByVal value As Integer)
                _userid = value
            End Set
        End Property

        Public Property PunchInTime() As DateTime
            Get
                Return _punchintime
            End Get
            Set(ByVal value As DateTime)
                _punchintime = value
            End Set
        End Property

        Public Property PunchOutTime() As DateTime
            Get
                Return _punchouttime
            End Get
            Set(ByVal value As DateTime)
                _punchouttime = value
            End Set
        End Property

        Public Property LastAccessTime() As Date
            Get
                Return _lastaccesstime
            End Get
            Set(ByVal value As Date)
                _lastaccesstime = value
            End Set
        End Property

        Public Property ForcedPunchOut() As Boolean
            Get
                Return _forcedpunchout
            End Get
            Set(ByVal value As Boolean)
                _forcedpunchout = value
            End Set
        End Property

        Public Property Notes() As String
            Get
                Return _notes
            End Get
            Set(ByVal value As String)
                _notes = value
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

        Public Property LastUpdatedBy() As Integer
            Get
                Return _lastupdatedby
            End Get
            Set(ByVal value As Integer)
                _lastupdatedby = value
            End Set
        End Property

        Public Property LastUpdatedNotes() As String
            Get
                Return _lastupdatednotes
            End Get
            Set(ByVal value As String)
                _lastupdatednotes = value
            End Set
        End Property

        Public Property CreationType() As Integer
            Get
                Return _creationtype
            End Get
            Set(ByVal value As Integer)
                _creationtype = value
            End Set
        End Property
        Public Property LastUpdatedAdminName() As String
            Get
                Return _lastupdatedadmin
            End Get
            Set(ByVal value As String)
                _lastupdatedadmin = value
            End Set
        End Property

        Public Property CurrentHours() As Integer
            Get
                Return _currenthours
            End Get
            Set(ByVal value As Integer)
                _currenthours = value
            End Set
        End Property
        Public Property CurrentMinutes() As Integer
            Get
                Return _currentminutes
            End Get
            Set(ByVal value As Integer)
                _currentminutes = value
            End Set
        End Property
        Public Property TotalMinutes() As Integer
            Get
                Return _totalminutes
            End Get
            Set(ByVal value As Integer)
                _totalminutes = value
            End Set
        End Property
		
        Public Property UserOfficeTimingProfileID() As Integer
            Get
                Return _UserOfficeTimingProfileID
            End Get
            Set(ByVal value As Integer)
                _UserOfficeTimingProfileID = value
            End Set
        End Property

        Public Property LateArrival() As Boolean
            Get
                Return _LateArrival
            End Get
            Set(ByVal value As Boolean)
                _LateArrival = value
            End Set
        End Property

        Public Property EarlyDeparture() As Boolean
            Get
                Return _EarlyDeparture
            End Get
            Set(ByVal value As Boolean)
                _EarlyDeparture = value
            End Set
        End Property

        Public Property LateSitting() As Boolean
            Get
                Return _LateSitting
            End Get
            Set(ByVal value As Boolean)
                _LateSitting = value
            End Set
        End Property

        Public Property LateArrivalNotes() As String
            Get
                Return _LateArrivalNotes
            End Get
            Set(ByVal value As String)
                _LateArrivalNotes = value
            End Set
        End Property

        Public Property EarlyDepartureNotes() As String
            Get
                Return _EarlyDepartureNotes
            End Get
            Set(ByVal value As String)
                _EarlyDepartureNotes = value
            End Set
        End Property

        Public Property LateSittingNotes() As String
            Get
                Return _LateSittingNotes
            End Get
            Set(ByVal value As String)
                _LateSittingNotes = value
            End Set
        End Property

        Public Property AnnualLeaves() As Integer
            Get
                Return _AnnualLeaves
            End Get
            Set(ByVal value As Integer)
                _AnnualLeaves = value
            End Set
        End Property

        Public Property AnnualLeavesTaken() As Integer
            Get
                Return _AnnualLeavesTaken
            End Get
            Set(ByVal value As Integer)
                _AnnualLeavesTaken = value
            End Set
        End Property

        Public Property AnnualLeavesBalance() As Integer
            Get
                Return _AnnualLeavesBalance
            End Get
            Set(ByVal value As Integer)
                _AnnualLeavesBalance = value
            End Set
        End Property

        Public Property CausalLeaves() As Integer
            Get
                Return _CausalLeaves
            End Get
            Set(ByVal value As Integer)
                _CausalLeaves = value
            End Set
        End Property

        Public Property CausalLeavesTaken() As Integer
            Get
                Return _CausalLeavesTaken
            End Get
            Set(ByVal value As Integer)
                _CausalLeavesTaken = value
            End Set
        End Property

        Public Property CausalLeavesBalance() As Integer
            Get
                Return _CausalLeavesBalance
            End Get
            Set(ByVal value As Integer)
                _CausalLeavesBalance = value
            End Set
        End Property

        Public Property AttendenceType() As Integer
            Get
                Return _AttendenceType
            End Get
            Set(ByVal value As Integer)
                _AttendenceType = value
            End Set
        End Property
		
#End Region


#Region " Constructor "
        Public Sub New()
        End Sub



        Public Sub New( _
          ByVal ID As Integer, _
          ByVal UserID As Integer, _
          ByVal PunchInTime As DateTime, _
          ByVal PunchOutTime As DateTime, _
          ByVal LastAccessTime As Date, _
          ByVal ForcedPunchOut As Boolean, _
          ByVal Notes As String, _
          ByVal Deleted As Boolean, _
          ByVal LastUpdatedBy As Integer, _
          ByVal LastUpdatedNotes As String, _
          ByVal CreationType As Integer, _
          ByVal AttendenceRecordType As Integer _
         )


            Me.ID = ID
            Me.UserID = UserID
            Me.PunchInTime = PunchInTime
            Me.PunchOutTime = PunchOutTime
            Me.LastAccessTime = LastAccessTime
            Me.ForcedPunchOut = ForcedPunchOut
            Me.Notes = Notes
            Me.Deleted = Deleted
            Me.LastUpdatedBy = LastUpdatedBy
            Me.LastUpdatedNotes = LastUpdatedNotes
            Me.CreationType = CreationType
            Me.AttendenceType = AttendenceRecordType			
        End Sub

        'Get aLL
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal UserID As Integer, _
          ByVal PunchInTime As DateTime, _
          ByVal PunchOutTime As DateTime, _
          ByVal LastAccessTime As Date, _
          ByVal ForcedPunchOut As Boolean, _
          ByVal Notes As String, _
          ByVal Deleted As Boolean, _
          ByVal LastUpdatedBy As Integer, _
          ByVal LastUpdatedNotes As String, _
          ByVal CreationType As Integer, _
          ByVal LastUpdatedAdminName As String, _
          ByVal CurrentHours As Integer, _
          ByVal CurrentMinutes As Integer, _
          ByVal TotalMinutes As Integer _
         )


            Me.ID = ID
            Me.UserID = UserID
            Me.PunchInTime = PunchInTime
            Me.PunchOutTime = PunchOutTime
            Me.LastAccessTime = LastAccessTime
            Me.ForcedPunchOut = ForcedPunchOut
            Me.Notes = Notes
            Me.Deleted = Deleted
            Me.LastUpdatedBy = LastUpdatedBy
            Me.LastUpdatedNotes = LastUpdatedNotes
            Me.CreationType = CreationType
            Me.LastUpdatedAdminName = LastUpdatedAdminName
            Me.CurrentHours = CurrentHours
            Me.CurrentMinutes = CurrentMinutes
            Me.TotalMinutes = TotalMinutes


        End Sub

#End Region

#Region " Public Method "
        Public Shared Function HR_UserTimeHistoryGetAll(ByVal UserID As Integer, ByVal FromDate As Date, ByVal ToDate As Date, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of HR_UserTimeHistory)
            Return Portal.DAL.HR.DBHR_UserTimeHistory.HR_UserTimeHistoryGetAll(UserID, FromDate, ToDate, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Shared Function HR_UserTimeHistoryGetAllCount(ByVal UserID As Integer, ByVal FromDate As Date, ByVal ToDate As Date, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Return Portal.DAL.HR.DBHR_UserTimeHistory.HR_UserTimeHistoryGetAllCount(UserID, FromDate, ToDate, sortExpression, txtsearch)
        End Function
        Public Shared Function HR_UserTimeHistoryGetByID(ByVal ID As Integer) As List(Of HR_UserTimeHistory)
            Return Portal.DAL.HR.DBHR_UserTimeHistory.HR_UserTimeHistoryGetByID(ID)
        End Function
        
        Public Shared Function HR_UserTimeHistoryGetByUserID(ByVal UserID As Integer) As List(Of HR_UserTimeHistory)
            Return Portal.DAL.HR.DBHR_UserTimeHistory.HR_UserTimeHistoryGetByUserID(UserID)
        End Function
        Public Function HR_UserTimeHistoryAdd(ByVal ID As Integer, ByVal UserID As Integer, ByVal PunchInTime As DateTime, ByVal PunchOutTime As DateTime, ByVal LastAccessTime As Date, ByVal ForcedPunchOut As Boolean, ByVal Notes As String, ByVal Deleted As Boolean, ByVal LastUpdatedBy As Integer, ByVal LastUpdatedNotes As String, ByVal CreationType As Integer, ByVal AttendenceType As Integer) As Integer
            Dim HR_UserTimeHistoryBll As Portal.BLL.HR.HR_UserTimeHistory = New Portal.BLL.HR.HR_UserTimeHistory(ID, UserID, PunchInTime, PunchOutTime, LastAccessTime, ForcedPunchOut, Notes, Deleted, LastUpdatedBy, LastUpdatedNotes, CreationType, AttendenceType)
            Dim HR_UserTimeHistoryDal As Portal.DAL.HR.DBHR_UserTimeHistory = New Portal.DAL.HR.DBHR_UserTimeHistory()
            Return HR_UserTimeHistoryDal.Add(HR_UserTimeHistoryBll)
        End Function
        Public Function HR_UserTimeHistoryUpdate(ByVal ID As Integer, ByVal UserID As Integer, ByVal PunchInTime As DateTime, ByVal PunchOutTime As DateTime, ByVal LastAccessTime As Date, ByVal ForcedPunchOut As Boolean, ByVal Notes As String, ByVal Deleted As Boolean, ByVal LastUpdatedBy As Integer, ByVal LastUpdatedNotes As String, ByVal CreationType As Integer, ByVal AttendenceType As Integer) As Integer
            Dim HR_UserTimeHistoryBll As Portal.BLL.HR.HR_UserTimeHistory = New Portal.BLL.HR.HR_UserTimeHistory(ID, UserID, PunchInTime, PunchOutTime, LastAccessTime, ForcedPunchOut, Notes, Deleted, LastUpdatedBy, LastUpdatedNotes, CreationType, AttendenceType)
            Dim HR_UserTimeHistoryDal As Portal.DAL.HR.DBHR_UserTimeHistory = New Portal.DAL.HR.DBHR_UserTimeHistory()
            Return HR_UserTimeHistoryDal.Update(HR_UserTimeHistoryBll)
        End Function
        Public Shared Function HR_UserTimeHistoryCheckTimeDuration(ByVal ID As Integer, ByVal UserID As Integer, ByVal objDate As Date) As System.Data.DataTable
            Return Portal.DAL.HR.DBHR_UserTimeHistory.HR_UserTimeHistoryCheckTimeDuration(ID, UserID, objDate)
        End Function
        Public Shared Function HR_GetTimeZoneOffSetByUserID(ByVal ID As Integer) As Portal.BLL.Users
            Return Portal.DAL.HR.DBHR_UserTimeHistory.HR_GetTimeZoneOffSetByUserID(ID)
        End Function

		Public Shared Function GetLateArrivalAndAbsentReportByDate(ByVal reportDate As Date, ByVal isForSupport As Boolean) As DataTable
            Return DBHR_UserTimeHistory.GetLateArrivalAndAbsentReportByDate(reportDate, isForSupport)
        End Function

		Public Shared Function GetEmployeesTimeHistoryDetail(ByVal StartDate As DateTime, _
                                                             ByVal EndDate As DateTime, _
                                                             ByVal DepartmentID As Integer, _
                                                             ByVal TeamID As Integer, _
                                                             ByVal EmployeeID As Integer, _
                                                             ByVal Status As Integer) As System.Data.DataTable
            Return Portal.DAL.HR.DBHR_UserTimeHistory.GetEmployeesTimeHistoryDetail(StartDate, EndDate, DepartmentID, TeamID, EmployeeID, Status)
        End Function
		
		Public Shared Function GetEmployeesTimeHistoryDetail_Printable(ByVal StartDate As DateTime, _
                                                             ByVal EndDate As DateTime, _
                                                             ByVal DepartmentID As Integer, _
                                                             ByVal TeamID As Integer, _
                                                             ByVal EmployeeID As Integer, _
                                                             ByVal Status As Integer) As System.Data.DataSet
            Return Portal.DAL.HR.DBHR_UserTimeHistory.GetEmployeesTimeHistoryDetail_Printable(StartDate, EndDate, DepartmentID, TeamID, EmployeeID, Status)
        End Function
#End Region

    End Class
End Namespace