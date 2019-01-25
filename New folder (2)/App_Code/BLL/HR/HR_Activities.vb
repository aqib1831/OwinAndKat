Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Namespace Portal.BLL.HR
    Public Class HR_Activities
        Inherits Portal.BLL.Users


#Region "Local Variables"

        Private l_Type As Integer
        Private l_SubType As Integer
        Private l_Subject As String
        Private l_Description As String
        Private l_WaitingFor As Integer
        Private l_PunchinTime As DateTime
        Private l_PunchoutTime As DateTime
        Private l_PunchinDate As Date
        Private l_ID As Integer
        Private l_TeamID As Integer
        Private l_LastUpdateNotes As String
        Private l_UserIp As String

#End Region
#Region "Public Properties"

        Public Property Type() As Integer
            Get
                Return l_Type
            End Get
            Set(ByVal value As Integer)
                l_Type = value
            End Set
        End Property

        Public Property SubType() As Integer
            Get
                Return l_SubType
            End Get
            Set(ByVal value As Integer)
                l_SubType = value
            End Set
        End Property

        Public Property Subject() As String
            Get
                Return l_Subject
            End Get
            Set(ByVal value As String)
                l_Subject = value
            End Set
        End Property

        Public Property Description() As String
            Get
                Return l_Description
            End Get
            Set(ByVal value As String)
                l_Description = value
            End Set
        End Property

        Public Property WaitingFor() As Integer
            Get
                Return l_WaitingFor
            End Get
            Set(ByVal value As Integer)
                l_WaitingFor = value
            End Set
        End Property

        Public Property PunchInTime() As DateTime
            Get
                Return l_PunchinTime
            End Get
            Set(ByVal value As DateTime)
                l_PunchinTime = value
            End Set
        End Property

        Public Property PunchOutTime() As DateTime
            Get
                Return l_PunchoutTime
            End Get
            Set(ByVal value As DateTime)
                l_PunchoutTime = value
            End Set
        End Property

        Public Property PunchIndate() As Date
            Get
                Return l_PunchinDate
            End Get
            Set(ByVal value As Date)
                l_PunchinDate = value
            End Set
        End Property

        Public Shadows Property ID() As Integer
            Get
                Return l_ID
            End Get
            Set(ByVal value As Integer)
                l_ID = value
            End Set
        End Property
        Public Shadows Property TeamID() As Integer
            Get
                Return l_TeamID
            End Get
            Set(ByVal value As Integer)
                l_TeamID = value
            End Set
        End Property
        Public Property LastUpdatedNotes() As String
            Get
                Return l_LastUpdateNotes
            End Get
            Set(ByVal value As String)
                l_LastUpdateNotes = value
            End Set
        End Property

#End Region
#Region "Public funtions"

#Region "Activity_Add"

        Public Function Activity_Add() As Integer

            Dim db As DBAccess = New DBAccess

            db.AddParameter("RETURN_VALUE", ParameterDirection.ReturnValue)
            db.AddParameter("@EmployeeID", ID)
            db.AddParameter("@Type", Type)
            db.AddParameter("@SubType", SubType)
            db.AddParameter("@Subject", Subject)
            db.AddParameter("@Description", Description)
            db.AddParameter("@ActivityState", 1)
            db.AddParameter("@WaitingFor", CONSTANTS.HR_ID) 'Replace this ID with HR original ID
            db.AddParameter("@Action", DBNull.Value)
            db.AddParameter("@DeliveredDate", DBNull.Value)
            db.AddParameter("@BySystem", DBNull.Value)

            db.ExecuteNonQuery("HR_Activities_Add")
            Return db.Parameters("RETURN_VALUE").Value

        End Function
#End Region

#Region "LoginHistory_Set"


        'Public Shared Function LoginHistory_Set(ByVal UserIp As String, Optional ByVal isSigningIn As Boolean = True) As Integer
        '    Dim db As DBAccess = New DBAccess

        '    Try
        '        db.AddParameter("@UserId", Security.UserID)

        '        If isSigningIn = True Then
        '            db.AddParameter("@SignedIn", CType(General.GetTimeByZone(Security.UserTimeZone, Now), DateTime))
        '            db.AddParameter("@SignedOut", DBNull.Value)
        '        Else
        '            db.AddParameter("@SignedIn", DBNull.Value)
        '            db.AddParameter("@SignedOut", General.GetTimeByZone(Security.UserTimeZone, Now))
        '        End If
        '        db.AddParameter("@UserIP", UserIp)

        '        Return CType(db.ExecuteNonQuery("User_LoginHistory_Set"), Integer)
        '    Catch ex As Exception
        '        Throw New Exception("Error setting the History details.", ex)
        '    Finally
        '        db = Nothing
        '    End Try

        'End Function

#End Region

#End Region
#Region "Public Shared Functions"

#Region "HR_Punchin_GetTodayTime"

        Public Shared Function HR_Punchin_GetTodayTime(ByVal argEmployeeID As Integer, ByVal argToday As String) As SqlDataReader
            Dim db As DBAccess = New DBAccess
            db.AddParameter("@EmployeeID", argEmployeeID)
            db.AddParameter("@Day", argToday)
            Return CType(db.ExecuteReader("HR_UserTime_GetByID"), SqlDataReader)
        End Function

#End Region

#Region "PunchIN"

        Public Shared Function PunchIN(ByVal ID As Integer, ByVal PunchInTime As DateTime, Optional ByVal argLateReason As String = Nothing) As Integer
            Dim db As DBAccess = New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@PunchInTime", PunchInTime)
            db.AddParameter("@LateReason", IIf(argLateReason = Nothing, DBNull.Value, argLateReason))
            db.AddParameter("@UserIP", HttpContext.Current.Request.UserHostAddress.ToString().Trim())
            Return CType(db.ExecuteNonQuery("HR_UserTimeHistory_Set"), Integer)
        End Function

#End Region

#Region "PunchOUT"

        Public Overloads Shared Function PunchOUT(ByVal ID As Integer, ByVal PunchOutTime As DateTime) As Integer
            Dim db As DBAccess = New DBAccess
            db.AddParameter("@ID", ID)
            ''db.AddParameter("@PunchInTime", System.DBNull.Value)
            db.AddParameter("@PunchOutTime", PunchOutTime)
            db.AddParameter("@UserIP", HttpContext.Current.Request.UserHostAddress.ToString().Trim())
            Return CType(db.ExecuteNonQuery("HR_UserTimeHistory_Set"), Integer)
        End Function

#End Region

#Region "PunchOUT"

        Public Overloads Shared Function PunchOUT(ByVal ID As Integer, ByVal PunchOutTime As DateTime, ByVal isSigningOut As Boolean) As Integer
            Dim db As DBAccess = New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@PunchOutTime", PunchOutTime)
            db.AddParameter("@UserIP", HttpContext.Current.Request.UserHostAddress.ToString().Trim())
            Return CType(db.ExecuteNonQuery("HR_UserTimeHistory_SetSignOut"), Integer)
        End Function

#End Region

        '#Region "Get_LatestTimeHistorybyID"

        '        Public Shared Function Get_LatestTimeHistorybyID(ByVal ID As Integer) As SqlDataReader
        '            Dim db As DBAccess = New DBAccess
        '            db.AddParameter("@ID", ID)
        '            Return CType(db.ExecuteReader("HR_UserTimeHistory_Latest"), SqlDataReader)
        '        End Function

        '#End Region

#Region "isUserPunchedinToday"

        Public Shared Function isUserPunchedinToday(ByVal argEmployeeID As Integer, ByVal argToday As String) As Integer
            Dim db As DBAccess = New DBAccess

            db.AddParameter("RETURN_VALUE", ParameterDirection.ReturnValue)
            db.AddParameter("@UserID", argEmployeeID)
            db.AddParameter("@PunchinDate", argToday)

            db.ExecuteNonQuery("HR_UserTimeHistory_IsPunchedToday")
            Return db.Parameters("RETURN_VALUE").value


        End Function
#End Region

#Region "UpdatePunchinInfo"
        Public Function UpdatePunchinInfo() As Boolean
            Dim db As DBAccess = New DBAccess
            db.AddParameter("@ID", l_ID)
            db.AddParameter("@PunchInTime", l_PunchinTime)
            db.AddParameter("@PunchOutTime", l_PunchoutTime)
            db.AddParameter("@LastAccessTime", Functions.GetTimeByZone(HttpContext.Current.Session("Admin_TimeZoneOffSet"), Now))
            db.AddParameter("@LastUpdatedBy", HttpContext.Current.Session("Admin_ID"))
            db.AddParameter("@LastUpdatedNotes", l_LastUpdateNotes)

            Return CType(db.ExecuteNonQuery("USER_TimeHistory_Update"), Integer)

        End Function
#End Region

#Region "HR_Authenticate"

        Public Function HR_Authenticate() As Integer

            Dim db As DBAccess = New DBAccess
            Dim ParID As SqlParameter
            Dim ParTimeZoneOffset As SqlParameter
            Dim UserGroupID As SqlParameter
            ParID = CType(db.Parameters, SqlParameterCollection).Add("@ID", Data.SqlDbType.Int)
            ParID.Size = 4
            ParID.Direction = Data.ParameterDirection.Output

            ParTimeZoneOffset = CType(db.Parameters, SqlParameterCollection).Add("@TimeZoneOffset", Data.SqlDbType.Int)
            ParTimeZoneOffset.Size = 4
            ParTimeZoneOffset.Direction = Data.ParameterDirection.Output

            UserGroupID = CType(db.Parameters, SqlParameterCollection).Add("@UserGroupID", Data.SqlDbType.Int)
            UserGroupID.Size = 4
            UserGroupID.Direction = ParameterDirection.Output

            db.AddParameter("RETURN_VALUE", ParameterDirection.ReturnValue)
            db.AddParameter("@UserName", UserName)
            db.AddParameter("@Password", Password)
            db.ExecuteNonQuery("HR_Users_Authenticate")

            If db.Parameters("RETURN_VALUE").Value > 0 Then
                ID = ParID.Value.ToString()
                TimeZoneID = ParTimeZoneOffset.Value.ToString()
                TeamID = UserGroupID.Value.ToString()
            End If
            HR_Authenticate = db.Parameters("RETURN_VALUE").Value

        End Function
		
		Public Function HR_Authenticate_PinCard() As Integer

            Dim db As DBAccess = New DBAccess
            Dim ParID As SqlParameter
            Dim ParTimeZoneOffset As SqlParameter
            Dim UserGroupID As SqlParameter
            'Dim UserGroupTimeLimit As SqlParameter

            ParID = CType(db.Parameters, SqlParameterCollection).Add("@ID", Data.SqlDbType.Int)
            ParID.Size = 4
            ParID.Direction = Data.ParameterDirection.Output

            ParTimeZoneOffset = CType(db.Parameters, SqlParameterCollection).Add("@TimeZoneOffset", Data.SqlDbType.Int)
            ParTimeZoneOffset.Size = 4
            ParTimeZoneOffset.Direction = Data.ParameterDirection.Output

            UserGroupID = CType(db.Parameters, SqlParameterCollection).Add("@UserGroupID", Data.SqlDbType.Int)
            UserGroupID.Size = 4
            UserGroupID.Direction = ParameterDirection.Output

            'UserGroupTimeLimit = CType(db.Parameters, SqlParameterCollection).Add("@UserGroupTimeLimit", Data.SqlDbType.DateTime)
            'UserGroupTimeLimit.Direction = ParameterDirection.Output

            db.AddParameter("RETURN_VALUE", ParameterDirection.ReturnValue)
            db.AddParameter("@RFID", RFID)
            db.ExecuteNonQuery("HR_Users_Authenticate_PINMode")

            If db.Parameters("RETURN_VALUE").Value > 0 Then
                ID = ParID.Value.ToString()
                TimeZoneID = ParTimeZoneOffset.Value.ToString()
                TeamID = UserGroupID.Value.ToString()
                'GroupTimeLimit = UserGroupTimeLimit.Value
            End If
            HR_Authenticate_PinCard = db.Parameters("RETURN_VALUE").Value

        End Function
#End Region

#Region "GetTimeHistoryReport"

        Public Shared Function GetTimeHistoryReport(ByVal UserID As Integer, ByVal FromDate As Date, ByVal ToDate As Date, ByVal txtsearch As String) As DataSet
            Dim ds As DataSet
            Dim db As DBAccess = New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@FromDate", FromDate)
            db.AddParameter("@ToDate", ToDate)
            ds = db.ExecuteDataSet("HR_UserTimeHistory_GetByUserID")
            ds.Tables(0).TableName = "Users"
            ds.Tables(1).TableName = "Timings"
            ds.Relations.Add("Users_Timings", ds.Tables("Users").Columns("ID"), ds.Tables("Timings").Columns("UserID"))
            Return ds
        End Function
#End Region

#End Region

    End Class
End Namespace
