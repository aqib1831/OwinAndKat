Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Imports Portal.BLL

Namespace Portal.DAL

    Public Class Activities

        Public Shared Function GetAdminInboxForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal Filter As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable

            Dim dtAdminInbox As DataTable = Nothing

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", Filter)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductId", ProductId)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@ClientID", ClientID)
            If Not HttpContext.Current.Session("AdminID") Is Nothing Then
                If HttpContext.Current.Session("AdminID") <> 0 Then
                    db.AddParameter("@AdminID", "A" & CType(HttpContext.Current.Session("AdminID"), Integer))
                Else
                    If Not HttpContext.Current.Session("MyNetsolace_ClientContactID") Is Nothing Then
                        db.AddParameter("@AdminID", "C" & CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
                    End If
                End If
            Else
                db.AddParameter("@AdminID", String.Empty)
            End If

            dtAdminInbox = db.ExecuteDataTable("Activities_GetOpenActivities")

            Return dtAdminInbox
        End Function
        Public Shared Function GetAdminInboxCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer) As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Filter", Filter)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductId", ProductId)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@ClientID", ClientID)
            If Not HttpContext.Current.Session("AdminID") Is Nothing Then
                If HttpContext.Current.Session("AdminID") <> 0 Then
                    db.AddParameter("@AdminID", "A" & CType(HttpContext.Current.Session("AdminID"), Integer))
                Else
                    If Not HttpContext.Current.Session("MyNetsolace_ClientContactID") Is Nothing Then
                        db.AddParameter("@AdminID", "C" & CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
                    End If
                End If
            Else
                db.AddParameter("@AdminID", String.Empty)
            End If

            Return CType(db.ExecuteScalar("Activities_GetOpenActivitiesCount"), Integer)

        End Function
        Public Shared Function GetAdminInboxForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal PriorityID As Integer) As DataTable

            Dim dtAdminInbox As DataTable = Nothing

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = -1, DBNull.Value, Filter))
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@WaitingFor", WaitingFor)
            db.AddParameter("@TopicID", TopicID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, 100)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@PriorityID", PriorityID)
            dtAdminInbox = db.ExecuteDataTable("Activities_GetOpenActivitiesForHelpDesk")
            Return dtAdminInbox
        End Function
        Public Shared Function GetAdminInboxForHelpDeskCount(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal PriorityID As Integer) As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = -1, DBNull.Value, Filter))
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@WaitingFor", WaitingFor)
            db.AddParameter("@TopicID", TopicID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, 100)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@PriorityID", PriorityID)
            Return db.ExecuteScalar("Activities_GetOpenActivitiesForHelpDeskCount")
        End Function

        Public Shared Function GetAdminInboxForHelpDesk_ByClientIdList(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As DataTable

            Dim dtAdminInbox As DataTable = Nothing

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = -1, DBNull.Value, Filter))
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@WaitingFor", WaitingFor)
            db.AddParameter("@TopicID", TopicID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, 100)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@ClientIDList", ClientIDList)

            If TicketType = "" Then
                db.AddParameter("@Type", DBNull.Value)
            Else
                db.AddParameter("@Type", TicketType)
            End If

            dtAdminInbox = db.ExecuteDataTable("Activities_GetOpenActivitiesForHelpDesk_ByClientIdList")
            Return dtAdminInbox
        End Function
        Public Shared Function GetAdminInboxForHelpDeskCount_ByClientIdList(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = -1, DBNull.Value, Filter))
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@WaitingFor", WaitingFor)
            db.AddParameter("@TopicID", TopicID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, 100)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@ClientIDList", ClientIDList)
            If TicketType = "" Then
                db.AddParameter("@Type", DBNull.Value)
            Else
                db.AddParameter("@Type", TicketType)
            End If

            Return db.ExecuteScalar("Activities_GetOpenActivitiesForHelpDeskCount_ByClientIdList")
        End Function

Public Shared Function GetAdminInboxForHelpDesk_ByClientIdList_Export(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As DataTable

            Dim dtAdminInbox As DataTable = Nothing

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = -1, DBNull.Value, Filter))
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@WaitingFor", WaitingFor)
            db.AddParameter("@TopicID", TopicID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, 1000000)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@ClientIDList", ClientIDList)

            If TicketType = "" Then
                db.AddParameter("@Type", DBNull.Value)
            Else
                db.AddParameter("@Type", TicketType)
            End If

            dtAdminInbox = db.ExecuteDataTable("Activities_GetOpenActivitiesForHelpDesk_ByClientIdList")
            Return dtAdminInbox
        End Function
        Public Shared Function GetAdminInboxForHelpDeskCount_ByClientIdList_Export(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As Integer

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = -1, DBNull.Value, Filter))
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@WaitingFor", WaitingFor)
            db.AddParameter("@TopicID", TopicID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, 1000000)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@ClientIDList", ClientIDList)
            If TicketType = "" Then
                db.AddParameter("@Type", DBNull.Value)
            Else
                db.AddParameter("@Type", TicketType)
            End If

            Return db.ExecuteScalar("Activities_GetOpenActivitiesForHelpDeskCount_ByClientIdList")
        End Function
        Public Shared Function GetCompletedActivitiesForMyNetsolaceHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal sortExpression As String) As DataSet
            Dim colcom_Activities As New List(Of Portal.BLL.Activities)()
            Dim ds As DataSet
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            If sortExpression = "" Then
                db.AddParameter("@sortExpression", DBNull.Value)
            Else
                db.AddParameter("@sortExpression", sortExpression)
            End If
            'To be executed from Portal
            ds = db.ExecuteDataSet("com_Activities_GetCompletedForMynetsolaceHelpDesk")
            Return ds
        End Function
        Public Shared Function GetCompletedActivitiesForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal sortExpression As String) As DataSet
            Dim colcom_Activities As New List(Of Portal.BLL.Activities)()
            Dim ds As DataSet
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            If sortExpression = "" Then
                db.AddParameter("@sortExpression", DBNull.Value)
            Else
                db.AddParameter("@sortExpression", sortExpression)
            End If
            'To be executed from Portal
            ds = db.ExecuteDataSet("Activities_GetCompletedActivitiesForMyNetsolace")
            Return ds
        End Function
        Public Shared Function GetCompletedActivitiesForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal sortExpression As String) As DataSet
            Dim colcom_Activities As New List(Of Portal.BLL.Activities)()
            Dim ds As DataSet
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            If sortExpression = "" Then
                db.AddParameter("@sortExpression", DBNull.Value)
            Else
                db.AddParameter("@sortExpression", sortExpression)
            End If
            'To be executed from Portal
            ds = db.ExecuteDataSet("Activities_GetCompletedActivities")
            Return ds
        End Function

        

        Public Shared Function GetActivityByID(ByVal ClientID As Integer, ByVal ID As Integer) As List(Of Portal.BLL.Activities)
            Dim col_Activities As New List(Of Portal.BLL.Activities)()
            Dim dr As SqlDataReader            
            Dim db As DBAccess = New DBAccess()            
            db.AddParameter("@ActivityID", ID)

            dr = db.ExecuteReader("Activities_GetByID")

            While dr.Read()

                col_Activities.Add(New Portal.BLL.Activities( _
                 CType(Functions.IfNull(dr("Activity_ID"), ""), Integer), _
                 CType(Functions.IfNull(dr("Subject"), ""), String), _
                 CType(Functions.IfNull(dr("Activity_Status"), 0), Boolean), _
                 CType(Functions.IfNull(dr("ActivityState"), 0), Integer), _
                 CType(Functions.IfNull(dr("Activity_Date"), System.DateTime.Now), Date), _
                 CType(Functions.IfNull(dr("Activity_Type"), 0), Integer), _
                 CType(Functions.IfNull(dr("Activity_SubType"), 0), Integer), _
                 CInt(dr("PlacedBy")), _
                 Functions.IfNull(dr("WaitingFor"), ""), _
                 TimeSpan.Parse(Functions.IfNull(dr("TimeSpent"), "00:00:00")), _
                 CStr(Functions.IfNull(dr("ContactName"), "")), _
                 CType(Functions.IfNull(dr("Description"), ""), String), _
                CType(Functions.IfNull(dr("Topic"), ""), String), _
                CType(Functions.IfNull(dr("FranchiseContactName"), ""), String), _
                CType(Functions.IfNull(dr("AdminInboxStatus"), False), Boolean), _
                CInt(dr("Priority")), _
                CType(Functions.IfNull(0, 0), Integer), _
                CType(Functions.IfNull("", ""), String), _
                CType(Functions.IfNull(dr("LastUpdatedBy"), 0), Integer), _
                CType(Functions.IfNull(dr("RelatedTo"), 0), Integer), _
                CType(Functions.IfNull(dr("RelatedTitle"), ""), String), _
                CType(Functions.IfNull(dr("ProductModule"), ""), String), _
                CType(Functions.IfNull(dr("ModuleId"), 0), Integer), _
                CType(Functions.IfNull(dr("ContactEmail"), ""), String) _
                 ))
                
            End While
            dr.Close()
            Return col_Activities
        End Function
        

        Public Function UpdateTimeSpent(ByVal ClientID As Integer, ByVal com_ActivitiesBll As Portal.BLL.Activities) As Integer
            Dim intReturn As Integer = 0            
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", com_ActivitiesBll.ID)
            db.AddParameter("@TimeSpent", SqlDbType.VarChar, 10, ParameterDirection.Input, com_ActivitiesBll.TimeSpent.ToString().Substring(0, com_ActivitiesBll.TimeSpent.ToString().Length - 3))
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            Try
                db.ExecuteNonQuery("Activities_Time_Update")
                intReturn = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                db.Dispose()
            End Try
            Return intReturn

        End Function

        'Public Function UpdateDepartment(ByVal ClientID As Integer, ByVal com_ActivitiesBll As Portal.BLL.Activities) As Integer
        '    Dim intReturn As Integer = 0
        '    Dim db As DBAccess = New DBAccess()
        '    db.AddParameter("@ID", com_ActivitiesBll.ID)
        '    db.AddParameter("@DepartmentID", com_ActivitiesBll.DepartmentID)
        '    db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        '    Try
        '        'db.ExecuteNonQuery("Portal_Activity_Department_Update")
        '        'intReturn = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
        '        intReturn = 0
        '    Catch ex As Exception
        '        intReturn = 0
        '    Finally
        '        db.Dispose()
        '    End Try
        '    Return intReturn
        'End Function

        Public Function Add(ByVal ClientID As Integer, ByVal com_ActivitiesBll As Portal.BLL.Activities) As Integer
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(ClientID))
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@FranchiseID", com_ActivitiesBll.FranchiseID)
            db.AddParameter("@ClientID", ClientID)

            'To check whether the activity is added from Portal or Else Where
            If (com_ActivitiesBll.UserID = 0) Then
                'Incase the activity is not entered by Portal Admin
                db.AddParameter("@AdminID", DBNull.Value)
            Else
                'Incase the activity is added Portal Admin
				db.AddParameter("@AdminID", com_ActivitiesBll.UserID)
            End If

            'To check whether the activity is added by coporate or Else Where
            If (com_ActivitiesBll.ClientContactID = 0) Then
                'Incase the activity is not entered by corporate
                db.AddParameter("@ClientContactID", DBNull.Value)
            Else
                'Incase the activity is added by corporate
                db.AddParameter("@ClientContactID", com_ActivitiesBll.ClientContactID)
            End If
            'Frnachise contact will be added in all the cases
            db.AddParameter("@FranchiseContactID", com_ActivitiesBll.FranchiseContactID)
            db.AddParameter("@TimeSpent", com_ActivitiesBll.TimeSpent.ToString())
            db.AddParameter("@Date", com_ActivitiesBll.ActivityDate)
            db.AddParameter("@Type", com_ActivitiesBll.Type)
            db.AddParameter("@SubType", com_ActivitiesBll.SubType)
            db.AddParameter("@Subject", com_ActivitiesBll.Subject)
            db.AddParameter("@Description", com_ActivitiesBll.Description)
            db.AddParameter("@AdminInboxStatus", com_ActivitiesBll.AdminInboxStatus)
            db.AddParameter("@Status", com_ActivitiesBll.Status)
            'Placed by must be specified to ensure who has added the activity
            db.AddParameter("@PlacedBy", com_ActivitiesBll.PlacedBy)
            db.AddParameter("@Charge", com_ActivitiesBll.Charge)
            db.AddParameter("@ActivityState", com_ActivitiesBll.ActivityState)
            db.AddParameter("@WaitingFor", com_ActivitiesBll.WaitingFor)
            If com_ActivitiesBll.RelatedTo <> Integer.MaxValue Then
                db.AddParameter("@RelatedTo", com_ActivitiesBll.RelatedTo)
                If com_ActivitiesBll.ModuleId <> Integer.MaxValue Then
                    db.AddParameter("@ModuleId", com_ActivitiesBll.ModuleId)
                End If
            End If
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)

            db.ExecuteNonQuery("Activities_Add")

            Dim Affected As Integer = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return Affected
        End Function
        Public Function Add(ByVal com_ActivitiesBll As Portal.BLL.Activities) As Integer
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(com_ActivitiesBll.ClientID))
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@FranchiseID", com_ActivitiesBll.FranchiseID)
            db.AddParameter("@ClientID", com_ActivitiesBll.ClientID)

            'To check whether the activity is added from Portal or Else Where
            If (com_ActivitiesBll.UserID = 0) Then
                'Incase the activity is not entered by Portal Admin
                db.AddParameter("@AdminID", DBNull.Value)
            Else
                'Incase the activity is added Portal Admin
                db.AddParameter("@AdminID", com_ActivitiesBll.UserID)
            End If

            'To check whether the activity is added by coporate or Else Where
            If (com_ActivitiesBll.ClientContactID = 0) Then
                'Incase the activity is not entered by corporate
                db.AddParameter("@ClientContactID", DBNull.Value)
            Else
                'Incase the activity is added by corporate
                db.AddParameter("@ClientContactID", com_ActivitiesBll.ClientContactID)
            End If
            'Frnachise contact will be added in all the cases
            db.AddParameter("@FranchiseContactID", com_ActivitiesBll.FranchiseContactID)
            db.AddParameter("@TimeSpent", com_ActivitiesBll.TimeSpent.ToString().Substring(0, com_ActivitiesBll.TimeSpent.ToString().Length - 3))
            db.AddParameter("@Date", com_ActivitiesBll.ActivityDate)
            db.AddParameter("@Type", com_ActivitiesBll.Type)
            db.AddParameter("@SubType", com_ActivitiesBll.SubType)
            db.AddParameter("@Subject", com_ActivitiesBll.Subject)
            db.AddParameter("@Description", com_ActivitiesBll.Description)
            db.AddParameter("@AdminInboxStatus", com_ActivitiesBll.AdminInboxStatus)
            db.AddParameter("@Status", com_ActivitiesBll.Status)
            'Placed by must be specified to ensure who has added the activity
            db.AddParameter("@PlacedBy", com_ActivitiesBll.PlacedBy)
            db.AddParameter("@Charge", com_ActivitiesBll.Charge)
            db.AddParameter("@ActivityState", com_ActivitiesBll.ActivityState)
            db.AddParameter("@WaitingFor", com_ActivitiesBll.WaitingFor)
            db.AddParameter("@Priority", com_ActivitiesBll.Priority)

            If com_ActivitiesBll.RelatedTo <> Integer.MaxValue Then
                db.AddParameter("@RelatedTo", com_ActivitiesBll.RelatedTo)
                If com_ActivitiesBll.ModuleId <> Integer.MaxValue Then
                    db.AddParameter("@ModuleId", com_ActivitiesBll.ModuleId)
                End If
            End If

            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)

            db.ExecuteNonQuery("Activities_Add")

            Dim Affected As Integer = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return Affected
        End Function

        Public Shared Function GetFranchiseeInboxForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable
            Dim dtFranchiseOpenActivities As DataTable
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)

            dtFranchiseOpenActivities = db.ExecuteDataTable("Activities_GetFranchiseOpenActivitiesForMyNetsolace")
            Return dtFranchiseOpenActivities
        End Function

        Public Shared Function GetFranchiseeInboxCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer) As Integer
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(ClientID))
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@FranchiseID", FranchiseID)

            Return CType(db.ExecuteScalar("Activities_GetFranchiseOpenActivitiesCountForMyNetsolace"), Integer)

        End Function

        Public Shared Function GetHelpDeskInboxForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable
            Dim dtFranchiseOpenActivities As DataTable
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductId", ProductId)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)

            dtFranchiseOpenActivities = db.ExecuteDataTable("com_Activities_MyNetsolaceHelpDesk_GetAll")
            Return dtFranchiseOpenActivities
        End Function

        Public Shared Function GetHelpDeskInboxCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal Search As String, ByVal ReturnValue As Integer) As Integer
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(ClientID))
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@ProductId", ProductId)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@FranchiseID", FranchiseID)

            Return CType(db.ExecuteScalar("com_Activities_MyNetsolaceHelpDesk_GetAllCount"), Integer)

        End Function
        Public Shared Function GetFranchiseeInboxForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable
            Dim dtFranchiseOpenActivities As DataTable
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)

            dtFranchiseOpenActivities = db.ExecuteDataTable("Activities_GetFranchiseOpenActivities")
            Return dtFranchiseOpenActivities
        End Function

        Public Shared Function GetFranchiseeInboxCountForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer) As Integer
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings(Portal.DAL.DBFunction.GetConnectionStringName(ClientID))
            Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@FranchiseID", FranchiseID)

            Return CType(db.ExecuteScalar("Activities_GetFranchiseOpenActivitiesCount"), Integer)

        End Function

        Public Shared Function GetAdminHistoryForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable

            Dim dtAdminHistory As DataTable
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@AdminID", HttpContext.Current.Session("MyNetsolace_ClientContactID"))
            dtAdminHistory = db.ExecuteDataTable("Activities_GetHistoryActivitiesForMyNetsolace")
            Return dtAdminHistory
        End Function

        Public Shared Function GetAdminHistoryCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@AdminID", HttpContext.Current.Session("MyNetsolace_ClientContactID"))
            Return CType(db.ExecuteScalar("Activities_GetHistoryActivitiesCountForMyNetsolace"), Integer)

        End Function

	Public Shared Function GetAdminHistoryForHelpDesk_Export(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AssingedBy As Integer, ByVal PriorityID As Integer, ByVal CompletedBy As Integer, ByVal ReletedTo As Integer) As DataTable

            Dim dtAdminHistory As DataTable
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = String.Empty, DBNull.Value, Filter))
            db.AddParameter("@Type", IIf(Type = 0, DBNull.Value, Type))
            db.AddParameter("@SubType", IIf(SubType = 0, DBNull.Value, SubType))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@CompletedBy", CompletedBy)
            db.AddParameter("@RelatedTo", ReletedTo)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@AdminID", HttpContext.Current.Session("AdminID"))
            dtAdminHistory = db.ExecuteDataTable("Activities_GetHistoryActivities_Export")
            Return dtAdminHistory
        End Function


        Public Shared Function GetAdminHistoryForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AssingedBy As Integer, ByVal PriorityID As Integer, ByVal CompletedBy As Integer, ByVal ReletedTo As Integer) As DataTable

            Dim dtAdminHistory As DataTable
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = String.Empty, DBNull.Value, Filter))
            db.AddParameter("@Type", IIf(Type = 0, DBNull.Value, Type))
            db.AddParameter("@SubType", IIf(SubType = 0, DBNull.Value, SubType))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@CompletedBy", CompletedBy)
            db.AddParameter("@RelatedTo", ReletedTo)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@AdminID", HttpContext.Current.Session("AdminID"))
            dtAdminHistory = db.ExecuteDataTable("Activities_GetHistoryActivities")
            Return dtAdminHistory
        End Function

        Public Shared Function GetAdminHistoryCountForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AssingedBy As Integer, ByVal PriorityID As Integer, ByVal CompletedBy As Integer, ByVal RelatedTo As Integer) As Integer

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = String.Empty, DBNull.Value, Filter))
            db.AddParameter("@Type", IIf(Type = 0, DBNull.Value, Type))
            db.AddParameter("@SubType", IIf(SubType = 0, DBNull.Value, SubType))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@AssingedBy", AssingedBy)
            db.AddParameter("@CompletedBy", CompletedBy)
            db.AddParameter("@RelatedTo", RelatedTo)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@AdminID", HttpContext.Current.Session("AdminID"))
            Return CType(db.ExecuteScalar("Activities_GetHistoryActivitiesCount"), Integer)

        End Function

        Public Shared Function GetFranchiseeHistoryForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable

            Dim dtFranchiseHistory As DataTable = Nothing
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)

            dtFranchiseHistory = db.ExecuteDataTable("Activities_FranchiseHistoryActivitiesForMyNetsolace")
            Return dtFranchiseHistory
        End Function

        Public Shared Function GetFranchiseeHistoryCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@FranchiseID", FranchiseID)

            Return CType(db.ExecuteScalar("Activities_FranchiseHistoryActivitiesCountForMyNetsolace"), Integer)

        End Function

        Public Shared Function GetFranchiseeHistoryForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable

            Dim dtFranchiseHistory As DataTable = Nothing
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Type", IIf(Type = 0, DBNull.Value, Type))
            db.AddParameter("@SubType", IIf(SubType = 0, DBNull.Value, SubType))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)

            dtFranchiseHistory = db.ExecuteDataTable("Activities_FranchiseHistoryActivities")
            Return dtFranchiseHistory
        End Function

        Public Shared Function GetFranchiseeHistoryCountForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Type", IIf(Type = 0, DBNull.Value, Type))
            db.AddParameter("@SubType", IIf(SubType = 0, DBNull.Value, SubType))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@FranchiseID", FranchiseID)

            Return CType(db.ExecuteScalar("Activities_FranchiseHistoryActivitiesCount"), Integer)

        End Function

        Public Shared Function GetFranchiseeSurveyReportForHelpDesk(ByVal sortExpression As String, ByVal ClientID As Integer, ByVal Search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable

            Dim dtFranchiseHistory As DataTable = Nothing
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@RowsToGet", maximumRows)

            dtFranchiseHistory = db.ExecuteDataTable("Activities_FranchiseSurveyReportForHelpDesk")
            Return dtFranchiseHistory
        End Function

        Public Shared Function GetFranchiseeSurveyReportCountForHelpDesk(ByVal ClientID As Integer, ByVal Search As String, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@DateTo", DateTo)

            Return CType(db.ExecuteScalar("Activities_FranchiseSurveyReportCountForHelpDesk"), Integer)
        End Function

        Public Shared Function SearchStores(ByVal ClientID As Integer, ByVal Search As String, ByVal StateID As Integer) As SqlDataReader
            'This stored procedure will be used to search stores.

            Dim dr As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            If String.IsNullOrEmpty(Search) = True Then
                db.AddParameter("@Search", DBNull.Value)
            Else
                db.AddParameter("@Search", Search)
            End If
            If String.IsNullOrEmpty(CType(StateID, String)) = True Then
                db.AddParameter("@StateID", DBNull.Value)
            Else
                db.AddParameter("@StateID", StateID)
            End If

            dr = db.ExecuteReader("Activities_GetStoresBySearch")
            Return dr
        End Function
        Public Shared Function SearchStores_ByClientIdList(ByVal Search As String, ByVal StateID As Integer, ByVal ClientIDList As String) As SqlDataReader
            'This stored procedure will be used to search stores.
            Dim dr As SqlDataReader
            Dim db As DBAccess = New DBAccess()

            If String.IsNullOrEmpty(Search) = True Then
                db.AddParameter("@Search", DBNull.Value)
            Else
                db.AddParameter("@Search", Search)
            End If
            If String.IsNullOrEmpty(CType(StateID, String)) = True Then
                db.AddParameter("@StateID", DBNull.Value)
            Else
                db.AddParameter("@StateID", StateID)
            End If
            db.AddParameter("@ClientIdList", ClientIDList)
            dr = db.ExecuteReader("Activities_GetStoresBySearch_ByClientIdList")
            Return dr
        End Function
        Public Shared Function GetStoreByActivities(ByVal ClientID As Integer, ByVal Search As String, ByVal StateID As Integer) As SqlDataReader

            Dim dr As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)

            If String.IsNullOrEmpty(Search) = True Then
                db.AddParameter("@Search", DBNull.Value)
            Else
                db.AddParameter("@Search", Search)
            End If

            If String.IsNullOrEmpty(CType(StateID, String)) = True Then
                db.AddParameter("@StateID", 0)
            Else
                db.AddParameter("@StateID", StateID)
            End If

            dr = db.ExecuteReader("Activities_GetStoresBySearch")

            Return dr
        End Function

        Public Function UpdateActivityState(ByVal ClientID As Integer, ByVal com_ActivitiesBll As Portal.BLL.Activities) As Integer
            Dim intReturn As Integer = 0
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, com_ActivitiesBll.ID)
            db.AddParameter("@ActivityState", SqlDbType.Int, 4, ParameterDirection.Input, com_ActivitiesBll.ActivityState)
            If com_ActivitiesBll.WaitingForID <> "0" AndAlso com_ActivitiesBll.ActivityState = 4 Then
                db.AddParameter("@WaitingforID", SqlDbType.NVarChar, 200, ParameterDirection.Input, com_ActivitiesBll.WaitingForID)
            Else
                db.AddParameter("@WaitingforID", SqlDbType.NVarChar, 200, ParameterDirection.Input, DBNull.Value)
            End If
            db.AddParameter("@AdminInboxStatus", com_ActivitiesBll.AdminInboxStatus)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, intReturn)
            Try
                db.ExecuteNonQuery("Activities_State_Update")
                intReturn = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                db.Dispose()
            End Try
            Return intReturn
        End Function

        Public Function UpdateActivityStatus(ByVal ClientID As Integer, ByVal com_ActivitiesBll As Portal.BLL.Activities) As Integer
            Dim intReturn As Integer = 0

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", com_ActivitiesBll.ID)
            db.AddParameter("@WaitingforID", IIf(com_ActivitiesBll.WaitingForID = "0", DBNull.Value, com_ActivitiesBll.WaitingForID))
            db.AddParameter("@ActivityStatus", SqlDbType.Bit, 1, ParameterDirection.Input, com_ActivitiesBll.IsClose)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            Try
                db.ExecuteNonQuery("Activities_Status_Update")

                intReturn = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                db.Dispose()
            End Try
            Return intReturn
        End Function

        Public Function UpdateLastActivityStateForHelpDeskOnRejection(ByVal ClientID As Integer, ByVal com_ActivitiesBll As Portal.BLL.Activities) As Integer
            Dim intReturn As Integer = 0

            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", com_ActivitiesBll.ID)
            db.AddParameter("@ActivityState", com_ActivitiesBll.ActivityState)
            db.AddParameter("@ActivityStatus", com_ActivitiesBll.IsClose)
            Try
                intReturn = db.ExecuteNonQuery("Activities_State_UpdateLastStateOnRejection")
            Catch ex As Exception
                intReturn = 0
            Finally
                db.Dispose()
            End Try
            Return intReturn
        End Function

        Public Shared Function ActivitiesGetAllBySearch(ByVal ClientID As Integer, ByVal WaitingFor As String, ByVal SortExpression As Integer) As SqlDataReader
            Dim dr As SqlDataReader = Nothing
            Dim db As DBAccess = New DBAccess()
            If WaitingFor = "0" Then
                db.AddParameter("@WaitingFor", DBNull.Value)
            Else
                db.AddParameter("@WaitingFor", WaitingFor)
            End If

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@SortExpression", SortExpression)

            Return db.ExecuteReader("Portal_GetActivityBySearch")
        End Function
        
        Public Shared Function GetAreaDeveloperActivitiesInbox(ByVal sortExpression As String, ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal Search As String, ByVal Filter As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal AreaDeveloperID As Integer) As DataTable
            Dim dtAdminInbox As DataTable = Nothing
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(String.IsNullOrEmpty(Search) = True, String.Empty, Search))
            db.AddParameter("@Filter", IIf(String.IsNullOrEmpty(Filter) = True, DBNull.Value, Filter))
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@ClientID", ClientID)
            If Not HttpContext.Current.Session("MyNetsolace_ClientContactID") Is Nothing Then
                db.AddParameter("@AdminID", "C" & CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            Else
                db.AddParameter("@AdminID", String.Empty)
            End If
            If Not HttpContext.Current.Session("MyNetsolace_AreaDeveloperID") Is Nothing Then
                db.AddParameter("@AreaDeveloperID", CInt(HttpContext.Current.Session("MyNetsolace_AreaDeveloperID")))
            Else
                db.AddParameter("@AreaDeveloperID", 0)
            End If
            dtAdminInbox = db.ExecuteDataTable("Activities_GetOpenActivities_ForAD")

            Return dtAdminInbox
        End Function
        Public Shared Function GetAreaDeveloperActivitiesInboxCount(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal AreaDeveloperID As Integer) As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = String.Empty, DBNull.Value, Filter))
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            db.AddParameter("@ClientID", ClientID)
            If Not HttpContext.Current.Session("MyNetsolace_ClientContactID") Is Nothing Then
                db.AddParameter("@AdminID", "C" & CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            Else
                db.AddParameter("@AdminID", String.Empty)
            End If
            If Not HttpContext.Current.Session("MyNetsolace_AreaDeveloperID") Is Nothing Then
                db.AddParameter("@AreaDeveloperID", CInt(HttpContext.Current.Session("MyNetsolace_AreaDeveloperID")))
            Else
                db.AddParameter("@AreaDeveloperID", 0)
            End If
            Return CType(db.ExecuteScalar("Activities_GetOpenActivitiesCount_ForAD"), Integer)
        End Function

        Public Shared Function GetAreaDeveloperHistory(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AreaDeveloperID As Integer) As DataTable
            Dim dtAdminHistory As DataTable
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = String.Empty, DBNull.Value, Filter))            
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@SortIndex", sortExpression)
            db.AddParameter("@DateTo", DateTo)            
            db.AddParameter("@startRowIndex", SqlDbType.Int, 4, ParameterDirection.Input, startRowIndex)
            db.AddParameter("@RowsToGet", SqlDbType.Int, 4, ParameterDirection.Input, maximumRows)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            If Not HttpContext.Current.Session("MyNetsolace_ClientContactID") Is Nothing Then
                db.AddParameter("@AdminID", "C" & CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            Else
                db.AddParameter("@AdminID", String.Empty)
            End If
            If Not HttpContext.Current.Session("MyNetsolace_AreaDeveloperID") Is Nothing Then
                db.AddParameter("@AreaDeveloperID", CInt(HttpContext.Current.Session("MyNetsolace_AreaDeveloperID")))
            Else
                db.AddParameter("@AreaDeveloperID", 0)
            End If
            dtAdminHistory = db.ExecuteDataTable("Activities_GetHistoryActivities_ForAD")
            Return dtAdminHistory
        End Function
        Public Shared Function GetAreaDeveloperHistoryCount(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AreaDeveloperID As Integer) As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Search", IIf(Search = String.Empty, String.Empty, Search))
            db.AddParameter("@Filter", IIf(Filter = String.Empty, DBNull.Value, Filter))            
            db.AddParameter("@DateFrom", DateFrom)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@DateTo", DateTo)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, ReturnValue)
            If Not HttpContext.Current.Session("MyNetsolace_ClientContactID") Is Nothing Then
                db.AddParameter("@AdminID", "C" & CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            Else
                db.AddParameter("@AdminID", String.Empty)
            End If
            If Not HttpContext.Current.Session("MyNetsolace_AreaDeveloperID") Is Nothing Then
                db.AddParameter("@AreaDeveloperID", CInt(HttpContext.Current.Session("MyNetsolace_AreaDeveloperID")))
            Else
                db.AddParameter("@AreaDeveloperID", 0)
            End If
            Return CType(db.ExecuteScalar("Activities_GetHistoryActivitiesCount_ForAD"), Integer)
        End Function
        Public Function UpdateActivityPriority(ByVal ActivityID As Integer, ByVal PriorityID As Integer) As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ActivityID", ActivityID)
            db.AddParameter("@PriorityID", PriorityID)
            db.AddParameter("@LastUpdatedOn", DateTime.Now)
            Return db.ExecuteNonQuery("Activities_Priority_Update")
        End Function

	Public Function GetActivtiesForDMWebService(ByVal Search As String, Optional ByVal ClientId As Integer = 0, Optional ByVal FranchiseId As Integer = 0) As Data.DataSet
            Dim ds As Data.DataSet = Nothing
            Dim db As DBAccess = New DBAccess()

            If ClientId <> 0 Then
                db.AddParameter("@ClientId", ClientId)
            Else
                db.AddParameter("@ClientId", DBNull.Value)
            End If

            If FranchiseId <> 0 Then
                db.AddParameter("@FranchiseId", FranchiseId)
            Else
                db.AddParameter("@FranchiseId", DBNull.Value)
            End If

            db.AddParameter("@Search", Search)
            Return db.ExecuteDataSet("Portal_GetHelpDeskActivtiesForDM")
        End Function

    End Class

End Namespace
