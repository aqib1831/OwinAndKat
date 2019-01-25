Imports Microsoft.VisualBasic
Imports System.Collections.Generic

Namespace Portal.BLL.HR
    Public Class HR_LoginHistory
#Region " Private Members "
        Private _id As Integer
        Private _userid As Integer
        Private _ip As String
        Private _logintime As DateTime
        Private _logouttime As DateTime

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

        Public Property IP() As String
            Get
                Return _ip
            End Get
            Set(ByVal value As String)
                _ip = value
            End Set
        End Property

        Public Property LogInTime() As DateTime
            Get
                Return _logintime
            End Get
            Set(ByVal value As DateTime)
                _logintime = value
            End Set
        End Property

        Public Property LogOutTime() As DateTime
            Get
                Return _logouttime
            End Get
            Set(ByVal value As DateTime)
                _logouttime = value
            End Set
        End Property

#End Region
#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal UserID As Integer, _
          ByVal IP As String, _
          ByVal LogInTime As DateTime, _
          ByVal LogOutTime As DateTime _
         )


            Me.ID = ID
            Me.UserID = UserID
            Me.IP = IP
            Me.LogInTime = LogInTime
            Me.LogOutTime = LogOutTime


	#End Sub
#End Region
#Region " Public Method "
        Public Shared Function LoginHistoryGetAll() As List(Of HR_LoginHistory)
            Return Portal.DAL.HR.DBHR_LoginHistory.LoginHistoryGetAll()
        End Function
        Public Shared Function LoginHistoryGetByID(ByVal ID As Integer) As List(Of HR_LoginHistory)
            Return Portal.DAL.HR.DBHR_LoginHistory.LoginHistoryGetByID(ID)
        End Function
        Public Shared Function LoginHistoryAdd(ByVal ID As Integer, ByVal UserID As Integer, ByVal IP As String, ByVal LogInTime As DateTime, ByVal LogOutTime As DateTime) As Integer
            Dim LoginHistoryBll As Portal.BLL.HR.HR_LoginHistory = New Portal.BLL.HR.HR_LoginHistory(ID, UserID, IP, LogInTime, LogOutTime)
            Dim LoginHistoryDal As Portal.DAL.HR.DBHR_LoginHistory = New Portal.DAL.HR.DBHR_LoginHistory()
            Return LoginHistoryDal.LoginHistoryAdd(LoginHistoryBll)
        End Function
        Public Shared Function LoginHistoryUpdate(ByVal ID As Integer, ByVal UserID As Integer, ByVal IP As String, ByVal LogInTime As DateTime, ByVal LogOutTime As DateTime) As Integer
            Dim LoginHistoryBll As Portal.BLL.HR.HR_LoginHistory = New Portal.BLL.HR.HR_LoginHistory(ID, UserID, IP, LogInTime, LogOutTime)
            Dim LoginHistoryDal As Portal.DAL.HR.DBHR_LoginHistory = New Portal.DAL.HR.DBHR_LoginHistory()
            Return LoginHistoryDal.LoginHistoryUpdate(LoginHistoryBll)
        End Function

#End Region
    End Class
End Namespace