Imports Microsoft.VisualBasic

Namespace Portal.BLL.HR
    Public Class OffSaturdayGroupsLogs
        Private _ID As Integer = 0
        Private _UserID As Integer = 0
        Private _DateOn As DateTime = DateTime.MinValue
        Private _GroupType As Integer = 0
        Private _UpdatedBy As Integer = 0

        Public Sub New()
            _ID = 0
            _UserID = 0
            _DateOn = DateTime.MinValue
            _GroupType = 0
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

        Public Property UserID() As Integer
            Get
                Return _UserID
            End Get
            Set(ByVal value As Integer)
                _UserID = value
            End Set
        End Property

        Public Property DateOn() As DateTime
            Get
                Return _DateOn
            End Get
            Set(ByVal value As DateTime)
                _DateOn = value
            End Set
        End Property

        Public Property GroupType() As Integer
            Get
                Return _GroupType
            End Get
            Set(ByVal value As Integer)
                _GroupType = value
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

        Public Shared Sub AddUserToOffSaturdayGroupLogs(ByVal UserID As Integer, _
                                                        ByVal DateOn As DateTime, _
                                                        ByVal GroupType As Integer)
            Portal.DAL.HR.DBOffSaturdayLogs.AddUserToOffSaturdayGroupLogs(UserID, DateOn, GroupType)
        End Sub
    End Class

End Namespace
