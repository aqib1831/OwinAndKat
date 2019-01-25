Imports System.Data.Sql
Imports System.Data.SqlClient
Imports Microsoft.VisualBasic

Public Class Home
    Public Shared Function Home_GetMyActivities(ByVal AdminID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@UserId", AdminID)
        Return db.ExecuteReader("Legal_Home_MyActivities")
    End Function
    Public Shared Function Home_TodaysActivities(ByVal AdminID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@UserId", AdminID)
        Return db.ExecuteReader("Legal_Home_TodaysActivities")
    End Function
    Public Shared Function Home_GetAlerts_Reminders() As SqlDataReader
        Return New DBAccess().ExecuteReader("Legal_GetAlerts_Reminders")
    End Function
    Public Shared Function Home_GetActiveReminders(ByVal AdminID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@UserId", AdminID)
        Return db.ExecuteReader("Legal_GetActiveReminder")
    End Function
    Public Shared Function Home_SnoozeReminder(ByVal ReminderTime As DateTime, ByVal ReminderID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ReminderTime", ReminderTime)
        db.AddParameter("@ReminderID", ReminderID)
        Return db.ExecuteNonQuery("Legal_SnoozeReminder")

    End Function
    Public Shared Function Home_DisMissReminder(ByVal ReminderID As Integer)
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ReminderID", ReminderID)
        Return db.ExecuteNonQuery("Legal_DisMissReminder")

    End Function
End Class
