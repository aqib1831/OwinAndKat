Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data

Namespace Portal.DAL

    Public Class DBFunction

        Public Shared Function GetStoreStats(ByVal ClientID As Integer) As List(Of Functions)
            Dim colcom_Function As New List(Of Functions)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("FransupportConnectionString")
            If ClientID = Portal.BLL.Enumeration.ClientID.Frutation Then
                objConnectionStringSettings = ConfigurationManager.ConnectionStrings("FrutationConnectionString")
            End If
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
            dr = db.ExecuteReader("GetStoreStats")
            While dr.Read()
                colcom_Function.Add(New Functions( _
               CType(Functions.IfNull(dr("ComingSoon"), 0), Integer), _
               CType(Functions.IfNull(dr("Operating"), 0), Integer) _
               ))
            End While
            dr.Close()
            Return colcom_Function
        End Function

        Public Shared Function GetClientStats() As List(Of Functions)
            Dim colcom_Function As New List(Of Functions)()            
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@UserID", CType(HttpContext.Current.Session("AdminID"), Integer))
            dr = db.ExecuteReader("Portal_GetClientStats")
            If dr.HasRows Then
                While dr.Read()                    
                    colcom_Function.Add(New Functions( _
                    CType(Functions.IfNull(dr.Item("ActivitiesCount"), 0), Integer), _
                    CType(Functions.IfNull(dr.Item("TicketCount"), 0), Integer), _
                    CType(Functions.IfNull(dr.Item("StoreCount"), 0), Integer), _
                    CType(Functions.IfNull(dr.Item("Name"), ""), String) _
                    ))                    
                End While
                dr.Close()
            End If
            Return colcom_Function
        End Function

        'Public Shared Function GetActivitiesCount(ByVal ClientID As Integer) As Integer
        '    Dim Value As Integer
        '    Dim dr As SqlDataReader
        '    Dim AdminId As Integer = 0
        '    Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(ClientID))

        '    Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
        '    If (ClientID = Portal.BLL.Enumeration.ClientID.EA) Then
        '        db.AddParameter("@WaitingFor", "A" & Functions.GetUserIDByClient(CInt(ClientID)))
        '        db.AddParameter("@DepartmentID", Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace)
        '        dr = db.ExecuteReader("Portal_GetOpenActivityCount")
        '        If dr.Read() Then
        '            Value = CType(Functions.IfNull(dr("ActivityCount"), 0), Integer)
        '        End If
        '        dr.Close()

        '    Else
        '        AdminId = Functions.GetUserIDByClient(CInt(ClientID))
        '        db.AddParameter("@ClientID", ClientID)
        '        db.AddParameter("@UserID", AdminId)
        '        Value = db.ExecuteScalar("Portal_Activities_GetOpenActivitiesCount")
        '    End If
        '    Return Value
        'End Function

        Public Shared Function GetConnectionStringName(ByVal ClientID As Integer) As String
            Return "PortalConnectionString"
        End Function

    End Class

End Namespace
