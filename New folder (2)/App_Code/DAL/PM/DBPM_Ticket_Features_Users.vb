Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.PM
    Public Class DBPM_Ticket_Features_Users
#Region " Public Method "


        Public Shared Function PM_Ticket_Features_UsersGetByID(ByVal ID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            Return db.ExecuteDataTable("PM_Ticket_Features_Users_GetByID")
        End Function
        Public Function AddClientContacs(ByVal Ticket_Feature_ID As Integer, ByVal ClientContactIDs As String, ByVal ClientContactID As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@Ticket_Feature_ID", Ticket_Feature_ID)
            db.AddParameter("@ClientContactIDs", ClientContactIDs)
            db.AddParameter("@ClientContactID", ClientContactID)

            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Users_AddClientContacs")
            Return Affected
        End Function


        Public Function AddUsers(ByVal Ticket_Feature_ID As Integer, ByVal UserIDs As String, ByVal UserID As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@Ticket_Feature_ID", Ticket_Feature_ID)
            db.AddParameter("@UserIDs", UserIDs)
            db.AddParameter("@UserID", UserID)

            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Users_AddUsers")
            Return Affected
        End Function

        Public Function AddQAUsers(ByVal Ticket_Feature_ID As Integer, ByVal UserIDs As String) As Integer
            Dim db As New DBAccess

            db.AddParameter("@Ticket_Feature_ID", Ticket_Feature_ID)
            db.AddParameter("@UserIDs", UserIDs)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Users_AddQAUsers")
            Return Affected
        End Function

        Public Function InsertUserAccess(ByVal Ticket_Feature_ID As Integer, ByVal UserID As Integer, ByVal ClientContactID As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@Ticket_Feature_ID", Ticket_Feature_ID)
            If UserID = 0 Then
                db.AddParameter("@UserID", DBNull.Value)
            Else
                db.AddParameter("@UserID", UserID)
            End If
            If ClientContactID = 0 Then
                db.AddParameter("@ClientContactID", DBNull.Value)
            Else
                db.AddParameter("@ClientContactID", ClientContactID)
            End If

            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Users_InsertNewAccess")
            Return Affected
        End Function

        Public Function PM_Ticket_Features_Users_ClientContacts(ByVal ClientID As Integer, ByVal TicketID As Integer, ByVal AreaDeveloperId As Integer) As SqlClient.SqlDataReader
            Dim db As New DBAccess

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@TicketID", TicketID)
            If AreaDeveloperId <> 0 Then
                db.AddParameter("@AreaDeveloperId", AreaDeveloperId)
            Else
                db.AddParameter("@AreaDeveloperId", DBNull.Value)
            End If

            Return db.ExecuteReader("PM_Ticket_Features_Users_ClientContacts")

        End Function

#End Region

    End Class
End Namespace