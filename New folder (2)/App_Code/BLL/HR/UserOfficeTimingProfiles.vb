Imports Microsoft.VisualBasic
Namespace Portal.BLL.HR
    Public Class UserOfficeTimingProfiles
        Private _ID As Integer
        Private _Name As String
        Private _GraceStartTime As Integer
        Private _GraceEndTime As Integer
        Private _BreakStartTime As DateTime
        Private _BreakEndTime As DateTime
        Private _BreakGraceTimeStart As Integer
        Private _BreakGraceTimeEnd As Integer
        Private _IsActive As Boolean
        Private _Deleted As Boolean
        Private _StartDateTime As DateTime
        Private _EndDateTime As DateTime
        Private _SaturdayOfficeStartTime As DateTime
        Private _SaturdayOfficeEndTime As DateTime
        Private _SaturdayGraceStartTime As Integer
        Private _SaturdayGraceEndTime As Integer
        Private _UpdatedBy As Integer

        Public Sub New()
            _ID = 0
            _Name = String.Empty
            _GraceStartTime = 0
            _GraceEndTime = 0
            _BreakStartTime = DateTime.MinValue
            _BreakEndTime = DateTime.MinValue
            _BreakGraceTimeStart = 0
            _BreakGraceTimeEnd = 0
            _IsActive = False
            _Deleted = False
            _StartDateTime = DateTime.MinValue
            _EndDateTime = DateTime.MinValue
            _SaturdayOfficeStartTime = DateTime.MinValue
            _SaturdayOfficeEndTime = DateTime.MinValue
            _SaturdayGraceStartTime = 0
            _SaturdayGraceEndTime = 0
            _UpdatedBy = 0
        End Sub

        Public Property ID() As Integer
            Get
                Return _ID
            End Get
            Set(ByVal value As Integer)
                _ID = value
            End Set
        End Property

        Public Property Name() As String
            Get
                Return _Name
            End Get
            Set(ByVal value As String)
                _Name = value
            End Set
        End Property

        Public Property StartDateTime() As DateTime
            Get
                Return _StartDateTime
            End Get
            Set(ByVal value As DateTime)
                _StartDateTime = value
            End Set
        End Property

        Public Property EndDateTime() As DateTime
            Get
                Return _EndDateTime
            End Get
            Set(ByVal value As DateTime)
                _EndDateTime = value
            End Set
        End Property

        Public Property IsActive() As Boolean
            Get
                Return _IsActive
            End Get
            Set(ByVal value As Boolean)
                _IsActive = value
            End Set
        End Property

        Public Property Deleted() As Boolean
            Get
                Return _Deleted
            End Get
            Set(ByVal value As Boolean)
                _Deleted = value
            End Set
        End Property

        Public Property BreakGraceTimeStart() As Integer
            Get
                Return _BreakGraceTimeStart
            End Get
            Set(ByVal value As Integer)
                _BreakGraceTimeStart = value
            End Set
        End Property

        Public Property BreakEndTime() As DateTime
            Get
                Return _BreakEndTime
            End Get
            Set(ByVal value As DateTime)
                _BreakEndTime = value
            End Set
        End Property

        Public Property BreakStartTime() As DateTime
            Get
                Return _BreakStartTime
            End Get
            Set(ByVal value As DateTime)
                _BreakStartTime = value
            End Set
        End Property

        Public Property BreakGraceTimeEnd() As String
            Get
                Return _BreakGraceTimeEnd
            End Get
            Set(ByVal value As String)
                _BreakGraceTimeEnd = value
            End Set
        End Property

        Public Property GraceEndTime() As Integer
            Get
                Return _GraceEndTime
            End Get
            Set(ByVal value As Integer)
                _GraceEndTime = value
            End Set
        End Property

        Public Property GraceStartTime() As Integer
            Get
                Return _GraceStartTime
            End Get
            Set(ByVal value As Integer)
                _GraceStartTime = value
            End Set
        End Property

        Public Property SaturdayOfficeStartTime() As DateTime
            Get
                Return _SaturdayOfficeStartTime
            End Get
            Set(ByVal value As DateTime)
                _SaturdayOfficeStartTime = value
            End Set
        End Property

        Public Property SaturdayOfficeEndTime() As DateTime
            Get
                Return _SaturdayOfficeEndTime
            End Get
            Set(ByVal value As DateTime)
                _SaturdayOfficeEndTime = value
            End Set
        End Property


        Public Property SaturdayGraceStartTime() As Integer
            Get
                Return _SaturdayGraceStartTime
            End Get
            Set(ByVal value As Integer)
                _SaturdayGraceStartTime = value
            End Set
        End Property

        Public Property SaturdayGraceEndTime() As Integer
            Get
                Return _SaturdayGraceEndTime
            End Get
            Set(ByVal value As Integer)
                _SaturdayGraceEndTime = value
            End Set
        End Property
        Public Property UpdatedBy() As Integer
            Get
                Return _UpdatedBy
            End Get
            Set(ByVal value As Integer)
                _UpdatedBy = value
            End Set
        End Property

        Public Shared Function AddOfficeTimingProfile(ByVal objOfficeTimingProfile As UserOfficeTimingProfiles) As Integer
            Return Portal.DAL.HR.DBUserOfficeTimingProfile.AddOfficeTimingProfile(objOfficeTimingProfile)
        End Function

        Public Shared Function UpdateOfficeTimingProfile(ByVal objOfficeTimingProfile As UserOfficeTimingProfiles) As Integer
            Return Portal.DAL.HR.DBUserOfficeTimingProfile.UpdateOfficeTimingProfile(objOfficeTimingProfile)
        End Function

        Public Shared Function DeleteOfficeTimingProfile(ByVal ProfileID As Integer) As Integer
            Return Portal.DAL.HR.DBUserOfficeTimingProfile.DeleteOfficeTimingProfile(ProfileID)
        End Function

        Public Shared Function ViewAllOfficeTimingProfile() As System.Data.DataTable
            Return Portal.DAL.HR.DBUserOfficeTimingProfile.ViewAllOfficeTimingProfile()
        End Function

        Public Shared Function OfficeTimingProfileGetByID(ByVal objOfficeTimingProfile As UserOfficeTimingProfiles) As System.Data.DataTable
            Return Portal.DAL.HR.DBUserOfficeTimingProfile.GetOfficeTimingProfileByID(objOfficeTimingProfile)
        End Function

        Public Function OfficeTimingProfileGetByUserID(ByVal UserID As Integer) As System.Data.DataTable
            Return Portal.DAL.HR.DBUserOfficeTimingProfile.OfficeTimingProfileGetByUserID(UserID)
        End Function



    End Class

End Namespace
