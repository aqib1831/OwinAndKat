Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.PM
    Public Class DBPM_Ticket_Features
#Region " Public Method "
        Public Shared Function PM_TicketGetAll(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal ReleaseId As Integer, ByVal TypeID As String, ByVal FilterID As Integer, ByVal WaitingForUserID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, Optional ByVal UserID As Integer = 0) As DataTable
            Dim db As New DBAccess

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            If ReleaseId <> 0 Then
                db.AddParameter("@ReleaseId", ReleaseId)
            Else
                db.AddParameter("@ReleaseId", DBNull.Value)
            End If
            db.AddParameter("@WaitingForUserID", WaitingForUserID)
            If UserID > 0 Then
                db.AddParameter("@UserID", UserID)
            Else
                db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            End If

            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Ticket_Features_GetAll")
        End Function
        Public Shared Function PM_TicketGetAllCount(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal ReleaseId As Integer, ByVal TypeID As String, ByVal FilterID As Integer, ByVal WaitingForUserID As Integer, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@TypeID", TypeID)
            If ReleaseId <> 0 Then
                db.AddParameter("@ReleaseId", ReleaseId)
            Else
                db.AddParameter("@ReleaseId", DBNull.Value)
            End If
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@WaitingForUserID", WaitingForUserID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@Search", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Ticket_Features_GetAllCount"))
        End Function
        Public Shared Function PM_FeaturesGetAll(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal StatusID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ReleaseID", ReleaseID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Ticket_Features_GetAll")
        End Function
        Public Shared Function PM_FeaturesGetAllCount(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal StatusID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ReleaseID", ReleaseID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Ticket_Features_GetAllCount"))
        End Function

        Public Shared Function PM_FeaturesGetAllForMyNetsolace(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ReleaseID", ReleaseID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@ClientContactID", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)

            Return db.ExecuteDataTable("PM_Ticket_Features_GetAllForMyNetsolace")
        End Function
        Public Shared Function PM_FeaturesGetAllCountForMyNetsolace(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ReleaseID", ReleaseID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@ClientContactID", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Ticket_Features_GetAllCountForMyNetsolace"))
        End Function

        Public Shared Function PM_Ticket_FeaturesGetByID(ByVal ID As Integer) As List(Of Portal.BLL.PM.PM_Ticket_Features)
            Dim objPMTicketFeatures As New Portal.BLL.PM.PM_Ticket_Features
            Dim lstPMFeatures As New List(Of Portal.BLL.PM.PM_Ticket_Features)
            Dim drTicketDetails As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@TicketID", ID)
            drTicketDetails = db.ExecuteReader("PM_GetTicket_Feature_DetailByID")
            Try
                If drTicketDetails.Read() Then
                    With objPMTicketFeatures
                        .ID = drTicketDetails("ID")
                        .Name = drTicketDetails("Name")
                        .ReleaseID = Functions.IfNull(drTicketDetails("ReleaseID"), "0")
                        .DateEntered = drTicketDetails("DateEntered")
                        .Description = Functions.IfNull(drTicketDetails("Description"), "")
                        .TypeID = drTicketDetails("TypeID")
                        .UserID = Functions.IfNull(drTicketDetails("UserID"), 0)
                        .Read = drTicketDetails("Read")
                        .Status = drTicketDetails("Status")
                        .History = drTicketDetails("History")
                        .DueDate = Functions.IfNull(drTicketDetails("DueDate"), DateTime.MinValue)
                        .DueDateShowToClient = drTicketDetails("DueDateShowToClient")
                        .Priority = Functions.IfNull(drTicketDetails("Priority"), "")
                        .CatagoryID = Functions.IfNull(drTicketDetails("CategoryID"), 0)
                        .WaitingForUserID = Functions.IfNull(drTicketDetails("WaitingForUserID"), "0")
                        .ClientID = Functions.IfNull(drTicketDetails("ClientID"), 0)
                        .RefNo = Functions.IfNull(drTicketDetails("RefNo"), "0")
                        .UserName = Functions.IfNull(drTicketDetails("UserName"), "")
                        .TypeName = Functions.IfNull(drTicketDetails("TaskName"), "")
                        .ClientName = Functions.IfNull(drTicketDetails("ClientName"), "")
                        .CatagoryName = Functions.IfNull(drTicketDetails("CategoryName"), "")
                        .ClientContactName = Functions.IfNull(drTicketDetails("ClientContactName"), "")
                        .ClientContactID = Functions.IfNull(drTicketDetails("ClientContactID"), 0)
                        .ShowDueDateFlag = Functions.IfNull(drTicketDetails("ShowDueDateFlag"), 0)
                        .ClientStatusId = Functions.IfNull(drTicketDetails("ClientStatusId"), 0)
                        .RequiredDate = Functions.IfNull(drTicketDetails("RequiredDate"), DateTime.MinValue)
                        .CorporateName = drTicketDetails("CorporateName")
                        .AreaDeveloperId = drTicketDetails("AreaDeveloperID")
                        .ConfirmedSolvedDate = Functions.IfNull(drTicketDetails("ConfirmSolvedDate"), DateTime.MinValue)
                        '.SowSignedDate = Functions.IfNull(drTicketDetails("SowSignedDate"), CType(Nothing, Date))
                        .SowSignedDate = Functions.IfNull(drTicketDetails("SowSignedDate"), Nothing)
                        .CRBApprovalDate = Functions.IfNull(drTicketDetails("CRBApprovalDate"), Nothing)
                        .IsFeedbackRequired = Functions.IfNull(drTicketDetails("IsClientFeedback"), 0)
                        .TicketOwnerName = Functions.IfNull(drTicketDetails("TicketOwner"), "")
                        .TicketOwner = Functions.IfNull(drTicketDetails("TicketOwnerID"), "")
                        .SubCatagoryID = Functions.IfNull(drTicketDetails("SubCategoryID"), 0)
                        .SubCatagoryName = Functions.IfNull(drTicketDetails("SubCatagoryName"), "")
                        .Notes = Functions.IfNull(drTicketDetails("Notes"), "")
                        .Flag = Functions.IfNull(drTicketDetails("Flag"), 0)

                    End With
                End If

                lstPMFeatures.Add(objPMTicketFeatures)
            Catch ex As Exception
                Throw ex
            Finally
                If drTicketDetails.IsClosed = False Then
                    drTicketDetails.Close()
                End If
            End Try

            Return lstPMFeatures

        End Function
        Public Shared Function PM_TicketGetAllHistory(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@sortExpression", SortExpression)
            db.AddParameter("@maximumRows", MaximumRows)
            db.AddParameter("@startRowIndex", StartRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Ticket_Features_GetAllHistory")
        End Function
        Public Shared Function PM_TicketGetAllHistoryCount(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Ticket_Features_GetAllHistoryCount"))
        End Function

        Public Shared Function PM_TicketGetAllHistoryForMyNetsolace(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As DataTable
            Dim db As New DBAccess

            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@ClientContactID", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperId", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperId", DBNull.Value)
            End If
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)

            Return db.ExecuteDataTable("PM_Ticket_Features_GetAllHistoryForMyNetsolace")
        End Function
        Public Shared Function PM_TicketGetAllHistoryCountForMyNetsolace(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@ClientContactID", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperId", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperId", DBNull.Value)
            End If
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Ticket_Features_GetAllHistoryCountForMyNetsolace"))
        End Function

        Public Function UpdateDueDate(ByVal ID As Integer, ByVal DueDate As DateTime) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@DueDate", DueDate)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Update_Ticket_Features_DueDate")
            Return Affected
        End Function

        Public Function UpdateDueDateShowToClient(ByVal ID As Integer, ByVal DueDateShowToClient As Boolean) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@DueDateShowToClient", DueDateShowToClient)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_UpdateShowDueDate")
            Return Affected
        End Function

        Public Function UpdateAssingTo(ByVal ID As Integer, ByVal AssingTo As Integer) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@AssignedTo", AssingTo)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Update_Ticket_Features_AssignedTo")
            Return Affected
        End Function

        Public Function UpdateReleaseID(ByVal ID As Integer, ByVal ReleaseID As Integer) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            If ReleaseID = 0 Then
                db.AddParameter("@ReleaseID", DBNull.Value)
            Else
                db.AddParameter("@ReleaseID", ReleaseID)
            End If
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_UpdateRelease")
            Return Affected
        End Function
        Public Function UpdateStatus(ByVal ID As Integer, ByVal StatusID As Integer, ByVal WaitingForID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Status", StatusID)
            If StatusID = 5 Then
                db.AddParameter("@DateCompleted", System.DateTime.Now.ToShortDateString())
            End If
            db.AddParameter("@WaitingForUserID", IIf(WaitingForID = 0, DBNull.Value, WaitingForID))
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Update_Ticket_Features_Status")
            Return Affected
        End Function
        Public Shared Function PM_CategoryUserGetByID(ByVal CategoryID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            Dim UserID As Integer = db.ExecuteScalar("PM_CategoryUserID_GetByID")
            Return UserID
        End Function

        Public Function FeaturesAdd(ByVal PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features) As Integer
            Dim db As New DBAccess
            db.AddParameter("@Name", PM_Ticket_FeaturesBll.Name)
            db.AddParameter("@ReleaseID", PM_Ticket_FeaturesBll.ReleaseID)
            db.AddParameter("@DateEntered", PM_Ticket_FeaturesBll.DateEntered)
            db.AddParameter("@Description", PM_Ticket_FeaturesBll.Description)
            db.AddParameter("@TypeID", PM_Ticket_FeaturesBll.TypeID)
            db.AddParameter("@UserID", PM_Ticket_FeaturesBll.UserID)
            db.AddParameter("@Read", PM_Ticket_FeaturesBll.Read)
            db.AddParameter("@Status", PM_Ticket_FeaturesBll.Status)
            db.AddParameter("@Deleted", PM_Ticket_FeaturesBll.Deleted)
            db.AddParameter("@History", PM_Ticket_FeaturesBll.History)
            db.AddParameter("@DueDate", PM_Ticket_FeaturesBll.DueDate)
            db.AddParameter("@Priority", PM_Ticket_FeaturesBll.Priority)
            db.AddParameter("@CategoryID", PM_Ticket_FeaturesBll.CatagoryID)
            db.AddParameter("@WaitingForUserID", PM_Ticket_FeaturesBll.WaitingForUserID)
            db.AddParameter("@ClientID", PM_Ticket_FeaturesBll.ClientID)
            db.AddParameter("@RefNo", PM_Ticket_FeaturesBll.RefNo)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)
            db.ExecuteNonQuery("PM_Ticket_Features_Insert")
            Dim FeatureID As Integer = CInt(Functions.IfNull(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value, "0"))
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then FeatureID = -101
            Return FeatureID
        End Function
        Public Function FeaturesUpdate(ByVal PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", PM_Ticket_FeaturesBll.ID)
            db.AddParameter("@Name", PM_Ticket_FeaturesBll.Name)
            db.AddParameter("@ReleaseID", IIf(PM_Ticket_FeaturesBll.ReleaseID = 0, PM_Ticket_FeaturesBll.ReleaseID, String.Empty))
            db.AddParameter("@Description", PM_Ticket_FeaturesBll.Description)
            db.AddParameter("@TypeID", PM_Ticket_FeaturesBll.TypeID)
            db.AddParameter("@Read", PM_Ticket_FeaturesBll.Read)
            db.AddParameter("@DueDate", PM_Ticket_FeaturesBll.DueDate)
            db.AddParameter("@CategoryID", PM_Ticket_FeaturesBll.CatagoryID)
            db.AddParameter("@ClientID", PM_Ticket_FeaturesBll.ClientID)
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Update")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then Affected = -101
            Return Affected
        End Function
        Public Function PM_TicketAdd(ByVal PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features) As Integer
            Dim db As New DBAccess
            Dim p As New SqlParameter

            db.AddParameter("@Name", PM_Ticket_FeaturesBll.Name)
            db.AddParameter("@DateEntered", PM_Ticket_FeaturesBll.DateEntered)
            db.AddParameter("@Description", PM_Ticket_FeaturesBll.Description)
            db.AddParameter("@TypeID", PM_Ticket_FeaturesBll.TypeID)
            db.AddParameter("@UserID", PM_Ticket_FeaturesBll.UserID)
            db.AddParameter("@Read", PM_Ticket_FeaturesBll.Read)
            db.AddParameter("@Status", PM_Ticket_FeaturesBll.Status)
            db.AddParameter("@Deleted", PM_Ticket_FeaturesBll.Deleted)
            db.AddParameter("@History", PM_Ticket_FeaturesBll.History)
            db.AddParameter("@DueDate", PM_Ticket_FeaturesBll.DueDate)
            db.AddParameter("@Priority", PM_Ticket_FeaturesBll.Priority)
            db.AddParameter("@CategoryID", PM_Ticket_FeaturesBll.CatagoryID)
            db.AddParameter("@WaitingForUserID", PM_Ticket_FeaturesBll.WaitingForUserID)
            db.AddParameter("@ClientID", PM_Ticket_FeaturesBll.ClientID)
            db.AddParameter("@RefNo", PM_Ticket_FeaturesBll.RefNo)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)
            db.ExecuteNonQuery("PM_Ticket_Features_Insert")
            Dim TicketID As Integer = CInt(Functions.IfNull(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value, "0"))
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then TicketID = -101
            Return TicketID

        End Function

        Public Function Add(ByVal objPMTicket As Portal.BLL.PM.PM_Ticket_Features) As Integer
            Dim db As New DBAccess

            db.AddParameter("@Name", objPMTicket.Name)
            db.AddParameter("@ReleaseID", IIf(objPMTicket.ReleaseID = 0, DBNull.Value, objPMTicket.ReleaseID))
            db.AddParameter("@DateEntered", objPMTicket.DateEntered)
            db.AddParameter("@Description", objPMTicket.Description)
            db.AddParameter("@TypeID", objPMTicket.TypeID)
            db.AddParameter("@UserID", IIf(objPMTicket.UserID = 0, DBNull.Value, objPMTicket.UserID))
            db.AddParameter("@ClientContactID", IIf(objPMTicket.ClientContactID = 0, DBNull.Value, objPMTicket.ClientContactID))
            db.AddParameter("@Read", objPMTicket.Read)
            db.AddParameter("@Status", objPMTicket.Status)
            db.AddParameter("@Deleted", objPMTicket.Deleted)
            db.AddParameter("@History", objPMTicket.History)
            db.AddParameter("@DueDate", objPMTicket.DueDate)
            db.AddParameter("@Priority", objPMTicket.Priority)
            db.AddParameter("@CategoryID", objPMTicket.CatagoryID)
            db.AddParameter("@SubcategoryID", objPMTicket.SubCatagoryID)
            db.AddParameter("@ClientID", objPMTicket.ClientID)
            db.AddParameter("@ClientStatusId", IIf(objPMTicket.ClientStatusId <> Short.MinValue, objPMTicket.ClientStatusId, DBNull.Value))
            db.AddParameter("@RequiredDate", IIf(objPMTicket.RequiredDate = Date.MinValue, DBNull.Value, objPMTicket.RequiredDate))
            db.AddParameter("@DateCompleted", IIf(objPMTicket.DateCompleted = Nothing, DBNull.Value, objPMTicket.DateCompleted))
            db.AddParameter("@AreaDeveloperID", IIf(objPMTicket.AreaDeveloperId = 0, DBNull.Value, objPMTicket.AreaDeveloperId))
            db.AddParameter("@TicketOwnerID", objPMTicket.TicketOwner)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Add")
            Dim TicketID As Integer = CInt(Functions.IfNull(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value, "0"))
            Return TicketID
        End Function
        Public Function PM_TicketUpdate(ByVal PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features) As Integer
            Dim db As New DBAccess
            Dim p As New SqlParameter
            db.AddParameter("@ID", PM_Ticket_FeaturesBll.ID)
            db.AddParameter("@Name", PM_Ticket_FeaturesBll.Name)
            db.AddParameter("@Description", PM_Ticket_FeaturesBll.Description)
            db.AddParameter("@TypeID", PM_Ticket_FeaturesBll.TypeID)
            db.AddParameter("@Read", PM_Ticket_FeaturesBll.Read)
            db.AddParameter("@DueDate", PM_Ticket_FeaturesBll.DueDate)
            db.AddParameter("@Priority", PM_Ticket_FeaturesBll.Priority)
            db.AddParameter("@CategoryID", PM_Ticket_FeaturesBll.CatagoryID)
            db.AddParameter("@ClientID", PM_Ticket_FeaturesBll.ClientID)
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_Update")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then Affected = -101
            Return Affected

        End Function
        Public Function PM_MYTicketGetAll(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal FilterID As Integer, ByVal UserID As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String, ByVal StartDate As DateTime, ByVal EndDate As DateTime, Optional ByVal TypeID As String = "0") As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@SortExpression", SortExpression)
            db.AddParameter("@MaximumRows", MaximumRows)
            db.AddParameter("@StartRowIndex", StartRowIndex)
            If txtsearch <> String.Empty Then
                db.AddParameter("@searchtxt", txtsearch)
            Else
                db.AddParameter("@searchtxt", DBNull.Value)
            End If
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            'If TypeID > 0 Then
            db.AddParameter("@TypeID", TypeID)
            'End If
            Return db.ExecuteDataTable("PM_Tickets_Features_MyTickets_GetAll")
        End Function
        Public Function PM_MYTicketGetAllCount(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal FilterID As Integer, ByVal UserID As Integer, ByVal txtsearch As String, ByVal StartDate As DateTime, ByVal EndDate As DateTime, Optional ByVal TypeID As String = "0") As Integer
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FilterID", FilterID)
            If txtsearch <> String.Empty Then
                db.AddParameter("@searchtxt", txtsearch)
            Else
                db.AddParameter("@searchtxt", DBNull.Value)
            End If
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)

            'If TypeID > 0 Then
            db.AddParameter("@TypeID", TypeID)
            'End If
            Return CInt(db.ExecuteScalar("PM_Tickets_Features_MyTickets_GetAllCount"))
        End Function



        Public Shared Function PMRecent_MYTicketGetAll_Excel(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal ReleaseId As Integer, ByVal TypeID As String, ByVal FilterID As Integer, ByVal WaitingForUserID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal UserLogID As Integer) As DataTable
            Dim db As New DBAccess
            ' mtahir 
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@TypeID", TypeID)
            db.AddParameter("@FilterID", FilterID)
            If ReleaseId <> 0 Then
                db.AddParameter("@ReleaseId", ReleaseId)
            Else
                db.AddParameter("@ReleaseId", DBNull.Value)
            End If
            db.AddParameter("@WaitingForUserID", WaitingForUserID)
            db.AddParameter("@UserID", UserLogID)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Ticket_Features_GetAll")
        End Function


        Public Function PM_Tickets_Features_MyTickets_GetAll_Paging(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal StatusID As Integer, ByVal FilterID As Integer, ByVal UserID As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String, ByVal StartDate As DateTime, ByVal EndDate As DateTime, TicketNo As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@SortExpression", SortExpression)
            db.AddParameter("@MaximumRows", MaximumRows)
            db.AddParameter("@StartRowIndex", StartRowIndex)
            If txtsearch <> String.Empty Then
                db.AddParameter("@searchtxt", txtsearch)
            Else
                db.AddParameter("@searchtxt", DBNull.Value)
            End If
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            db.AddParameter("@TicketNo", TicketNo)
            Return db.ExecuteDataTable("PM_Tickets_Features_MyTickets_GetAll_Paging")
        End Function

        Public Function MyTicketGetAllForMyNetsolaceCorporate(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal FilterID As Integer, ByVal ClientContactId As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal ClientStatusId As Int16, ByVal AreaDeveloperID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ClientContactID", ClientContactId)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FilterID", FilterID)
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperId", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperId", DBNull.Value)
            End If
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            If ClientStatusId <> 0 Then
                db.AddParameter("@ClientStatusId", ClientStatusId)
            Else
                db.AddParameter("@ClientStatusId", DBNull.Value)
            End If
            Return db.ExecuteDataTable("PM_Tickets_Features_MyTickets_GetAllForMyNetsolaceCorporate")
        End Function
        Public Function MyTicketGetAllForMyNetsolaceCorporateForPrint(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal ClientStatusId As Int16, ByVal AreaDeveloperID As Integer) As SqlClient.SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientContactID", HttpContext.Current.Session("MyNetsolace_ClientContactID"))
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            If ClientStatusId <> 0 Then
                db.AddParameter("@ClientStatusId", ClientStatusId)
            Else
                db.AddParameter("@ClientStatusId", DBNull.Value)
            End If
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperId", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperId", DBNull.Value)
            End If
            Return db.ExecuteReader("PM_Tickets_Features_MyTickets_GetAllForMyNetsolaceCorporate")
        End Function

        Public Function MyTicketGetAllCountForMyNetsolaceCorporate(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal FilterID As Integer, ByVal ClientContactId As Integer, ByVal txtsearch As String, ByVal ClientStatusId As Int16, ByVal AreaDeveloperID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ClientContactID", ClientContactId)
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@searchtxt", txtsearch)

            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperId", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperId", DBNull.Value)
            End If

            If ClientStatusId <> 0 Then
                db.AddParameter("@ClientStatusId", ClientStatusId)
            Else
                db.AddParameter("@ClientStatusId", DBNull.Value)
            End If
            Return CInt(db.ExecuteScalar("PM_Tickets_Features_MyTickets_GetAllCountForMyNetsolaceCorporate"))
        End Function

        Public Function PM_TicketSearch(ByVal txtsearch As String) As List(Of Portal.BLL.PM.PM_Ticket_Features)
            Dim colPM_Ticket_Features As New List(Of Portal.BLL.PM.PM_Ticket_Features)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@searchtxt", txtsearch)
            dr = db.ExecuteReader("PM_Ticket_Features_Search")
            While dr.Read()
                colPM_Ticket_Features.Add(New Portal.BLL.PM.PM_Ticket_Features(CType(dr("ID"), Integer), CType(dr("Name"), String), CType(Functions.IfNull(dr("ReleaseID"), 0), Integer), CType(Functions.IfNull(dr("DateEntered"), Nothing), DateTime), CType(Functions.IfNull(dr("Description"), ""), String), CType(Functions.IfNull(dr("TypeID"), 0), Integer), CType(Functions.IfNull(dr("UserID"), 0), Integer), CType(dr("Read"), Boolean), CType(Functions.IfNull(dr("Status"), ""), String), CType(dr("Deleted"), Boolean), CType(dr("History"), Boolean), CType(Functions.IfNull(dr("DueDate"), Nothing), Date), CType(Functions.IfNull(dr("Priority"), ""), String), CType(Functions.IfNull(dr("CategoryID"), 0), Integer), CType(Functions.IfNull(dr("WaitingForUserID"), 0), Integer), CType(Functions.IfNull(dr("ClientID"), 0), Integer), CType(Functions.IfNull(dr("RefNo"), "0"), Integer), CType(Functions.IfNull(dr("TypeName"), ""), String), CType(Functions.IfNull(dr("CategoryName"), ""), String), CType(Functions.IfNull(dr("AssingedBy"), ""), String), CType(Functions.IfNull(dr("ClientName"), ""), String))) 'CategoryName
            End While
            dr.Close()
            Return colPM_Ticket_Features
        End Function
        Public Function PM_TicketSearchForMyNetsolaceCorporate(ByVal txtsearch As String) As DataTable
            Dim colPM_Ticket_Features As New List(Of Portal.BLL.PM.PM_Ticket_Features)()
            Dim db As New DBAccess
            db.AddParameter("@ClientID", CInt(HttpContext.Current.Session("MyNetsolace_ClientID")))
            If HttpContext.Current.Session("MyNetsolace_AreaDeveloperId") <> 0 Then
                db.AddParameter("@AreaDeveloperId", HttpContext.Current.Session("MyNetsolace_AreaDeveloperId"))
            Else
                db.AddParameter("@AreaDeveloperId", DBNull.Value)
            End If
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Ticket_Features_SearchForMyNetsolaceCorporate")
        End Function
        Public Sub ChangeRead(ByVal ID As Integer, ByVal Read As Boolean, ByVal UserID As Integer, ByVal ClientContactID As Integer)
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Read", Read)
            If UserID <> 0 And UserID <> Nothing Then
                db.AddParameter("@UserID", UserID)
            Else
                db.AddParameter("@UserID", DBNull.Value)
            End If
            If ClientContactID <> 0 And ClientContactID <> Nothing Then
                db.AddParameter("@ClientContactID", ClientContactID)
            Else
                db.AddParameter("@ClientContactID", DBNull.Value)
            End If
            db.ExecuteNonQuery("PM_Ticket_Features_UpdateRead")
        End Sub
        Public Function CheckToComplete(ByVal TicketID As Integer, ByVal UserID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@TicketID", TicketID)
            db.AddParameter("@UserID", UserID)
            Return CInt(db.ExecuteScalar("PM_Ticket_Features_CheckToComplete"))
        End Function

        Public Function PM_MYTicketGetAllForMyNetsolaceCorporateXLS(ByVal CategoryID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientContactID", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", HttpContext.Current.Session("MyNetsolace_ClientID"))
            db.AddParameter("@FilterID", FilterID)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", 1000000)
            db.AddParameter("@startRowIndex", 0)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteReader("PM_Tickets_Features_MyTickets_GetAllForMyNetsolaceCorporate")
        End Function
        Public Function GetDetailByID(ByVal TicketId As Integer) As DataSet
            Dim objDbManager As New DbManager()
            Dim ds As New DataSet
            objDbManager.AddParameter("@TicketId", TicketId)
            ds = objDbManager.ExecuteDataSet("PM_GetTicket_Feature_DetailByID")
            ds.Tables(0).TableName = "Tickets"
            ds.Tables(1).TableName = "Attachments"
            ds.Relations.Add("Tickets_Attachments", ds.Tables("Tickets").Columns("ID"), ds.Tables("Attachments").Columns("Ticket_FeatureID"), False)
            Return ds
        End Function
        Public Function GetPMDashBoardStats(ByVal ClientId As Integer, ByVal CategoryId As Integer, ByVal Type As Integer, ByVal TeamId As Integer, ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal SortBy As String) As DataTable
            Dim db As New DBAccess
            If ClientId > 0 Then
                db.AddParameter("@ClientId", ClientId)
            End If
            If CategoryId > 0 Then
                db.AddParameter("@CategoryId", CategoryId)
            Else
                db.AddParameter("@CategoryId", DBNull.Value)
            End If

            If TeamId > 0 Then
                db.AddParameter("@TeamId", TeamId)
            Else
                db.AddParameter("@TeamId", DBNull.Value)
            End If

            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            If String.IsNullOrEmpty(SortBy) Then
                db.AddParameter("@SortBy", DBNull.Value)
            Else
                db.AddParameter("@SortBy", SortBy)
            End If
            If Type > 0 Then
                db.AddParameter("@Type", Type)
            Else
                db.AddParameter("@Type", DBNull.Value)
            End If
            Return db.ExecuteDataTable("PM_Ticket_Features_GetTimeSpent")
        End Function
        Public Shared Function GetPMDashBoardTickets(ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal Type As Integer, ByVal TeamId As Integer, ByVal UserId As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            If ClientID > 0 Then
                db.AddParameter("@ClientID", ClientID)
            End If
            If CategoryID > 0 Then
                db.AddParameter("@CategoryID", CategoryID)
            End If
            If Type > 0 Then
                db.AddParameter("@Type", Type)
            End If
            If TeamId > 0 Then
                db.AddParameter("@TeamID", TeamId)
            End If
            If UserId > 0 Then
                db.AddParameter("@UserID", UserId)
            End If
            db.AddParameter("@sortExpression", SortExpression)
            db.AddParameter("@maximumRows", MaximumRows)
            db.AddParameter("@startRowIndex", StartRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Ticket_Features_GetDashBoardTickets")
        End Function
        Public Shared Function GetPMDashBoardTicketsCount(ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal Type As Integer, ByVal TeamId As Integer, ByVal UserId As Integer, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            If ClientID > 0 Then
                db.AddParameter("@ClientID", ClientID)
            End If
            If CategoryID > 0 Then
                db.AddParameter("@CategoryID", CategoryID)
            End If
            If Type > 0 Then
                db.AddParameter("@Type", Type)
            End If
            If TeamId > 0 Then
                db.AddParameter("@TeamID", TeamId)
            End If
            If UserId > 0 Then
                db.AddParameter("@UserID", UserId)
            End If
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Ticket_Features_GetDashBoardTicketsCount"))
        End Function
        Public Function PMTicketUpdate(ByVal ID As Integer, ByVal Name As String, ByVal TypeID As Integer, ByVal UserID As Integer, ByVal SowSignedDate As Nullable(Of Date), ByVal Priority As String, ByVal CategoryID As Integer, ByVal SubCategoryID As Integer, ByVal ClientID As Integer, ByVal AreaDeveloperId As Integer, ByVal Resources As String, ByVal ResourcesDeleted As String, ByVal Estimates As String, ByVal CRBApprovalDate As Nullable(Of Date), ByVal Notes As String, ByVal NewResources As String, ByVal NewEstimates As String, Optional ByVal ticketOwnerID As Integer = 0) As Integer

            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Name", Name)
            'db.AddParameter("@Description", Description)
            db.AddParameter("@TypeID", TypeID)
            If IsNothing(SowSignedDate) Then
                db.AddParameter("@SowSignedDate", DBNull.Value)
            Else
                db.AddParameter("@SowSignedDate", SowSignedDate)
            End If
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@SubCategoryID", SubCategoryID)
            db.AddParameter("@Priority", Priority)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@UserID", UserID)
            'db.AddParameter("@Status", PM_Ticket_FeaturesBll.Status)
            db.AddParameter("@AreaDeveloperId", AreaDeveloperId)
            If ticketOwnerID > 0 Then
                db.AddParameter("@ticketOwnerID", ticketOwnerID)
            End If
            If (String.IsNullOrEmpty(Resources)) Then
                db.AddParameter("@Resources", DBNull.Value)
            Else
                db.AddParameter("@Resources", Resources)
            End If
            If (String.IsNullOrEmpty(ResourcesDeleted)) Then
                db.AddParameter("@ResourcesDeleted", DBNull.Value)
            Else
                db.AddParameter("@ResourcesDeleted", ResourcesDeleted)
            End If
            If (String.IsNullOrEmpty(Estimates)) Then
                db.AddParameter("@Estimates", DBNull.Value)
            Else
                db.AddParameter("@Estimates", Estimates)
            End If

            If IsNothing(CRBApprovalDate) Then
                db.AddParameter("@CRBApprovalDate", DBNull.Value)
            Else
                db.AddParameter("@CRBApprovalDate", CRBApprovalDate)
            End If

            If String.IsNullOrEmpty(NewResources) Then 'update
                db.AddParameter("@NewResources", DBNull.Value)
            Else
                db.AddParameter("@NewResources", NewResources)
            End If

            If String.IsNullOrEmpty(NewEstimates) Then
                db.AddParameter("@NewEstimates", DBNull.Value)
            Else
                db.AddParameter("@NewEstimates", NewEstimates)
            End If
            db.AddParameter("@Notes", Notes)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Update")
            Return Affected
        End Function

        Public Shared Function PM_SubCategories_CategoryID(ByVal CategoryID As Integer) As SqlDataReader
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@CategoryID", CategoryID)
            Return objDbAccess.ExecuteReader("PM_SubCategories_CategoryID")
        End Function

        Public Shared Function PM_Project_Information_GetByTicketID(ByVal ID As Integer) As List(Of Portal.BLL.PM.PM_Ticket_Features)
            Dim objPMTicketFeatures As New Portal.BLL.PM.PM_Ticket_Features
            Dim lstPMFeatures As New List(Of Portal.BLL.PM.PM_Ticket_Features)
            Dim drTicketDetails As DataSet 'DataTable
            Dim db As New DBAccess
            db.AddParameter("@TicketID", ID)
            'drTicketDetails = db.ExecuteReader("PM_ProjectInformation_GetByTicketID")
            'drTicketDetails = db.ExecuteDataTable("PM_ProjectInformation_GetByTicketID")
            drTicketDetails = db.ExecuteDataSet("PM_ProjectInformation_GetByTicketID")
            Try
                If drTicketDetails.Tables.Count > 0 Then
                    If drTicketDetails.Tables(0).Rows.Count > 0 Then
                        objPMTicketFeatures.DtProjectResources = drTicketDetails.Tables(0)
                        Dim RoleId As String
                        Dim resourceList As List(Of KeyValuePair(Of String, String)) = New List(Of KeyValuePair(Of String, String))
                        For Each row As DataRow In drTicketDetails.Tables(0).Rows
                            RoleId = row("RoleID")
                            objPMTicketFeatures.Title = row("Title")
                            objPMTicketFeatures.RoleId = row("RoleID")
                            Select Case RoleId
                                Case 1
                                    objPMTicketFeatures.ProjectManager = row("ResourceNames")
                                Case 2
                                    objPMTicketFeatures.ProductOwner = row("ResourceNames")
                                Case 3
                                    objPMTicketFeatures.DesignLead = row("ResourceNames")
                                Case 4
                                    objPMTicketFeatures.DevelopmentLead = row("ResourceNames")
                                Case 5
                                    objPMTicketFeatures.QALead = row("ResourceNames")
                                Case Else
                                    resourceList.Add(New KeyValuePair(Of String, String)(row("Title"), row("ResourceNames")))
                            End Select
                        Next row
                        objPMTicketFeatures.ListResources = resourceList
                    End If
                    If drTicketDetails.Tables(1).Rows.Count > 0 Then
                        Dim dt As DateTime
                        For Each row As DataRow In drTicketDetails.Tables(1).Rows
                            objPMTicketFeatures.AttachmentID = row("ID")
                            objPMTicketFeatures.DocumentName = row("FileName")
                            objPMTicketFeatures.Posted = Functions.IfNull(DateTime.Parse(row("DateAttached").ToString()).ToString("d"), "")

                            If Functions.IfNull(row("CRBApprovalDate").ToString(), "") <> "" Then
                                objPMTicketFeatures.CRBApprovalDate = DateTime.Parse(row("CRBApprovalDate").ToString()).ToString("d")
                            End If

                            If Functions.IfNull(row("SOWApprovalDate").ToString(), "") <> "" Then
                                objPMTicketFeatures.SOWApprovalDate = DateTime.Parse(row("SOWApprovalDate").ToString()).ToString("d")
                            End If

                        Next
                    End If
                    If drTicketDetails.Tables(2).Rows.Count > 0 Then
                        For Each row As DataRow In drTicketDetails.Tables(2).Rows
                            objPMTicketFeatures.BRDDocumentName = row("FileName")
                            objPMTicketFeatures.BRDPosted = row("DateAttached")
                        Next
                    End If
                    If drTicketDetails.Tables(3).Rows.Count > 0 Then
                        For Each row As DataRow In drTicketDetails.Tables(3).Rows
                            objPMTicketFeatures.TotalEstimates = Functions.IfNull(row("TotalEstimates"), "")
                        Next
                    End If
                End If

                lstPMFeatures.Add(objPMTicketFeatures)
            Catch ex As Exception
                Throw ex
            Finally

            End Try

            Return lstPMFeatures
        End Function

        Public Shared Function PM_MYTicket_Attachment_GetByTicketID_GetByAttachmentType(ByVal ID As Integer, ByVal AttachmentType As Integer) As DataTable
            Dim dtAttachmentList As DataTable
            Dim db As New DBAccess
            db.AddParameter("@Ticket_FeatureID", ID)
            db.AddParameter("@Attachment_TypeID", AttachmentType)
            dtAttachmentList = db.ExecuteDataTable("PM_Ticket_Features_Attachments_GetByTicketID_GetByAttachmentType")

            Return dtAttachmentList
        End Function

        Public Shared Function PM_MYTicket_Estimates_GetByTicketID(ByVal ID As Integer) As DataTable
            Dim objPMTicketFeatures As New Portal.BLL.PM.PM_Ticket_Features
            'Dim dsEstimates As DataSet
            Dim dtEstimates As DataTable
            Dim db As New DBAccess
            db.AddParameter("@Ticket_FeatureID", ID)
            dtEstimates = db.ExecuteDataTable("PM_Ticket_Features_Estimates_GetByTicketID")
            'If dtEstimates.Tables.Count > 0 Then
            '    dtEstimates = dsEstimates.Tables(0)
            'End If

            'If dsEstimates.Tables(1).Rows.Count > 0 Then
            '    For Each row As DataRow In dsEstimates.Tables(1).Rows
            '        objPMTicketFeatures.TotalEstimates = row("TotalEstimates")
            '    Next
            'End If
            Return dtEstimates
        End Function

        Public Shared Function PM_ProjectResources_GetByTicketID(ByVal ID As Integer) As DataTable
            Dim dtProjectResources As DataTable
            Dim db As New DBAccess
            db.AddParameter("@TicketID", ID)
            dtProjectResources = db.ExecuteDataTable("PM_ProjectResources_GetByTicketID")
            Return dtProjectResources
        End Function

        Public Shared Function PM_Users_GetByGroupId(ByVal ID As Integer) As DataTable
            Dim dtUsers As DataTable
            Dim db As New DBAccess
            db.AddParameter("@GroupId", ID)
            dtUsers = db.ExecuteDataTable("Users_GetByGroupId")
            Return dtUsers
        End Function

        Public Shared Function PM_Roles_GetAll(ByVal ID As Integer) As DataTable
            Dim dtRoles As DataTable
            Dim db As New DBAccess
            db.AddParameter("@TicketID", ID)
            dtRoles = db.ExecuteDataTable("PM_Roles_GetAll")
            Return dtRoles
        End Function

        Public Shared Function PM_EstimatesType_GetAll(ByVal ID As Integer) As DataTable
            Dim dtEstimatesType As DataTable
            Dim db As New DBAccess
            db.AddParameter("@TicketID", ID)
            dtEstimatesType = db.ExecuteDataTable("PM_EstimatesType_GetAll")
            Return dtEstimatesType
        End Function

        Public Shared Function PM_Users_GetAll() As DataTable
            Dim dtUsers As DataTable
            Dim db As New DBAccess
            db.AddParameter("@Status", 0)
            db.AddParameter("@Type", DBNull.Value)
            dtUsers = db.ExecuteDataTable("Users_GetAll")
            Return dtUsers
        End Function

        Public Shared Function PM_GetGroupID_ByUserID(ByVal ID As Integer) As DataTable
            Dim dtGroup As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", ID)
            dtGroup = db.ExecuteDataTable("GetGroupID_ByUserID")
            Return dtGroup
        End Function
        Public Shared Function PM_TicketFeature_TicketLink_GetByTicketID(ByVal TicketID As Integer) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@Ticket_Feature_Id", TicketID)
            dtTickets = db.ExecuteDataTable("PM_Ticket_Features_TicketLink_GetByTicketID")
            Return dtTickets
        End Function
        Public Shared Function PM_TicketFeature_TicketLink_Add(ByVal TicketID As Integer, ByVal TicketRefID As Integer,ByVal Subject As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@Ticket_Feature_Id", TicketID)
            db.AddParameter("@Link_Ticket_Feature_ID", TicketRefID)
            db.AddParameter("@Subject", Subject)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Ticket_Features_TicketLink_Add")
            Return Affected
        End Function

        Public Shared Function PM_TicketFeature_TicketLink_Search(ByVal TicketID As Integer) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@searchtxt", TicketID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            dtTickets = db.ExecuteDataTable("PM_Ticket_Features_TicketLink_Search")
            Return dtTickets
        End Function

        Public Shared Function PM_TicketFeature_UpdateFlag(ByVal TicketID As Integer, ByVal Flag As Boolean, ByVal UserID As Integer, ByVal Comments As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@TicketID", TicketID)
            db.AddParameter("@Flag", Flag)
            db.AddParameter("@UserId", UserID)
            db.AddParameter("@Comments", Comments)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Tickets_Feature_UpdateFlag")
            Return Affected
        End Function
#End Region
        Public Shared Function PM_TicketFeature_Search_Category() As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            dtTickets = db.ExecuteDataTable("PM_Categories_GetAll")
            Return dtTickets
        End Function
        Public Shared Function PM_TicketFeature_Search_Type() As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            dtTickets = db.ExecuteDataTable("PM_TaskTypes_GetAll")
            Return dtTickets
        End Function
        Public Shared Function DisplayQuestion() As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            dtTickets = db.ExecuteDataTable("Survery_Display_Questions")
            Return dtTickets
        End Function
        Public Shared Function AddAnswer(ByVal Data As DataTable) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@myTableType", Data)
            Dim Affected As Integer = db.ExecuteNonQuery("Survey_Answers")
            Return Affected
        End Function
        Public Shared Function GetAllUserForAssignTo() As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            dtTickets = db.ExecuteDataTable("PM_GetAssignToUserList")
            Return dtTickets
        End Function
        Public Shared Function GetAllTeams(ByVal type As Integer) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@Type", type)
            dtTickets = db.ExecuteDataTable("Groups_GetGroupsbyType")
            Return dtTickets
        End Function
        Public Shared Function GetMyReport(ByVal UserID As Integer) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            dtTickets = db.ExecuteDataTable("GetMyReport")
            Return dtTickets
        End Function
        Public Shared Function RunAndSaveReport(ByVal reportName As String, ByVal Subject As String, ByVal createdBy As String, ByVal Columns As String, ByVal bit As Boolean, ByVal ClientID As String, ByVal TypeId As String, ByVal CategoryId As String, ByVal SubCategoryId As String, ByVal Priority As String, ByVal status As String, ByVal TeamId As String, ByVal ReleaseId As String, ByVal CSOL As Integer, ByVal AssignedTo As String, ByVal ProductOwner As String, ByVal ProjectManager As String, ByVal DesignLead As String, ByVal DevLead As String, ByVal QALead As String, ByVal CreationDateInDay As String, ByVal CreationDateStart As String, ByVal CreationDateEnd As String, ByVal LastestActivityInDays As String, ByVal LastestActivityStartDate As String, ByVal LastestActivityEndDate As String, ByVal SowSignDays As String, ByVal SowSignDateStart As String, ByVal SowSignDateEnd As String, ByVal DueDays As String, ByVal DueDateStart As String, ByVal DueDateEnd As String, ByVal ReportFilters As DataTable) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ReportName", reportName)
            If (String.IsNullOrEmpty(Subject)) Then
                db.AddParameter("@Subject", DBNull.Value)
            Else
                db.AddParameter("@Subject", Subject)
            End If
            db.AddParameter("@CreadtedBy", createdBy)
            db.AddParameter("@CreateDate", System.DateTime.Now)
            db.AddParameter("@Columns", Columns)
            db.AddParameter("@MyBit", bit)

            If (String.IsNullOrEmpty(ClientID)) Then
                db.AddParameter("@ClientID", DBNull.Value)
            Else
                db.AddParameter("@ClientID", ClientID)
            End If
            If (String.IsNullOrEmpty(TypeId)) Then
                db.AddParameter("@TypeID", DBNull.Value)
            Else
                db.AddParameter("@TypeID", TypeId)
            End If
            If (String.IsNullOrEmpty(CategoryId)) Then
                db.AddParameter("@CategoryID", DBNull.Value)
            Else
                db.AddParameter("@CategoryID", CategoryId)
            End If

            If (String.IsNullOrEmpty(SubCategoryId)) Then
                db.AddParameter("@SubCategoryID", DBNull.Value)
            Else
                db.AddParameter("@SubCategoryID", SubCategoryId)
            End If

            If (String.IsNullOrEmpty(Priority)) Then
                db.AddParameter("@PriorityID", DBNull.Value)
            Else
                db.AddParameter("@PriorityID", Priority)
            End If

            If (String.IsNullOrEmpty(status)) Then
                db.AddParameter("@StatusID", DBNull.Value)
            Else
                db.AddParameter("@StatusID", status)
            End If

            If (String.IsNullOrEmpty(TeamId)) Then
                db.AddParameter("@TeamID", DBNull.Value)
            Else
                db.AddParameter("@TeamID", TeamId)
            End If
            If (String.IsNullOrEmpty(ReleaseId)) Then
                db.AddParameter("@ReleaseID", DBNull.Value)
            Else
                db.AddParameter("@ReleaseID", ReleaseId)
            End If
            If (CSOL = 0) Then
                db.AddParameter("@CompletedSurvay", DBNull.Value)
            Else
                db.AddParameter("@CompletedSurvay", "1")
            End If

            If (String.IsNullOrEmpty(ProductOwner)) Then
                db.AddParameter("@ProductOwnerID", DBNull.Value)
            Else
                db.AddParameter("@ProductOwnerID", ProductOwner)
            End If

            If (String.IsNullOrEmpty(ProjectManager)) Then
                db.AddParameter("@ProjectManagerID", DBNull.Value)
            Else
                db.AddParameter("@ProjectManagerID", ProjectManager)
            End If


            If (String.IsNullOrEmpty(DesignLead)) Then
                db.AddParameter("@DesignLeadID", DBNull.Value)
            Else
                db.AddParameter("@DesignLeadID", DesignLead)
            End If


            If (String.IsNullOrEmpty(DevLead)) Then
                db.AddParameter("@DevelopmentLeadID", DBNull.Value)
            Else
                db.AddParameter("@DevelopmentLeadID", DevLead)
            End If

            If (String.IsNullOrEmpty(QALead)) Then
                db.AddParameter("@QALeadID", DBNull.Value)
            Else
                db.AddParameter("@QALeadID", QALead)
            End If
            If (String.IsNullOrEmpty(AssignedTo)) Then
                db.AddParameter("@AssignToID", DBNull.Value)
            Else
                db.AddParameter("@AssignToID", AssignedTo)
            End If

            If (String.IsNullOrEmpty(CreationDateInDay)) Then
                db.AddParameter("@CreationDateInt", DBNull.Value)
            Else
                db.AddParameter("@CreationDateInt", CreationDateInDay)
            End If

            If (String.IsNullOrEmpty(CreationDateStart)) Then
                db.AddParameter("@CreationDateStart", DBNull.Value)
            Else
                db.AddParameter("@CreationDateStart", CreationDateStart)
            End If

            If (String.IsNullOrEmpty(CreationDateEnd)) Then
                db.AddParameter("@CreationDateEnd", DBNull.Value)
            Else
                db.AddParameter("@CreationDateEnd", CreationDateEnd)
            End If

            If (String.IsNullOrEmpty(LastestActivityInDays)) Then
                db.AddParameter("@LastestActivityDateInt", DBNull.Value)
            Else
                db.AddParameter("@LastestActivityDateInt", LastestActivityInDays)
            End If
            If (String.IsNullOrEmpty(LastestActivityStartDate)) Then
                db.AddParameter("@LastestActivityDateStart", DBNull.Value)
            Else
                db.AddParameter("@LastestActivityDateStart", LastestActivityStartDate)
            End If

            If (String.IsNullOrEmpty(LastestActivityEndDate)) Then
                db.AddParameter("@LastestActivityDateEnd", DBNull.Value)
            Else
                db.AddParameter("@LastestActivityDateEnd", LastestActivityEndDate)
            End If
            If (String.IsNullOrEmpty(SowSignDays)) Then
                db.AddParameter("@SOWSignDateInt", DBNull.Value)
            Else
                db.AddParameter("@SOWSignDateInt", SowSignDays)
            End If

            If (String.IsNullOrEmpty(SowSignDateStart)) Then
                db.AddParameter("@SOWSignDateStart", DBNull.Value)
            Else
                db.AddParameter("@SOWSignDateStart", SowSignDateStart)
            End If

            If (String.IsNullOrEmpty(SowSignDateEnd)) Then
                db.AddParameter("@SOWSignDateEnd", DBNull.Value)
            Else
                db.AddParameter("@SOWSignDateEnd", SowSignDateEnd)
            End If
            If (String.IsNullOrEmpty(DueDays)) Then
                db.AddParameter("@DueDateInt", DBNull.Value)
            Else
                db.AddParameter("@DueDateInt", DueDays)
            End If

            If (String.IsNullOrEmpty(DueDateStart)) Then
                db.AddParameter("@DueDateStart", DBNull.Value)
            Else
                db.AddParameter("@DueDateStart", DueDateStart)
            End If

            If (String.IsNullOrEmpty(DueDateEnd)) Then
                db.AddParameter("@DueDateEnd", DBNull.Value)
            Else
                db.AddParameter("@DueDateEnd", DueDateEnd)
            End If

            If (ReportFilters Is Nothing) Then
                db.AddParameter("@ReportFilters", DBNull.Value)
            Else
                db.AddParameter("@ReportFilters", ReportFilters)
            End If

            'db.AddParameter("@ReportFilters", ReportFilters)

            dtTickets = db.ExecuteDataTable("PM_Ticket_Reports_temp_2")
            Return dtTickets
        End Function

        Public Shared Function DeleteReport(ByVal IDs As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@IDs", IDs)
            db.AddParameter("@UserId", CType(HttpContext.Current.Session("AdminID"), Integer))
            Dim Affected As Integer = db.ExecuteNonQuery("DeleteReport")
            Return Affected
        End Function
        Public Shared Function GetReportById(ByVal ReportId As Integer) As DataTable
            Dim db As New DBAccess
            Dim dtTickets As DataTable
            db.AddParameter("@ReportId", ReportId)
            db.AddParameter("@UserId", CType(HttpContext.Current.Session("AdminID"), Integer))
            dtTickets = db.ExecuteDataTable("PM_ReportDetail")
            Return dtTickets
        End Function
        Public Shared Function GetReportById(ByVal ReportId As Integer, ByVal UserID As Integer) As DataTable
            Dim db As New DBAccess
            Dim dtTickets As DataTable
            db.AddParameter("@ReportId", ReportId)
            db.AddParameter("@UserId", UserID)
            dtTickets = db.ExecuteDataTable("PM_ReportDetail")
            Return dtTickets
        End Function

        Public Shared Function ShareReport(ByVal ReportIDs As String, ByVal UserIDs As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ReportID", ReportIDs)
            db.AddParameter("@UserIDs", UserIDs)
            db.AddParameter("@PrimaryUser", CType(HttpContext.Current.Session("AdminID"), Integer))
            Dim Affected As Integer = db.ExecuteNonQuery("ShareReport")
            Return Affected
        End Function

        Public Shared Function GetPMName(ByVal ID As Integer, ByVal GID As Integer, ByVal PageNumber As Integer) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", ID)
            db.AddParameter("@GroupId", GID)
            db.AddParameter("@PageNumber", PageNumber)
            dtTickets = db.ExecuteDataTable("PM_SHARE")
            Return dtTickets
        End Function

        Public Shared Function GeTReportPMName(ByVal ID As Integer, ByVal GID As Integer) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", ID)
            db.AddParameter("@GroupId", GID)
          
            dtTickets = db.ExecuteDataTable("REPORT_PM_SHARE")
            Return dtTickets
        End Function
        Public Shared Function GET_REPORT_BY_ID() As DataTable
            Dim db As New DBAccess
            Return db.ExecuteDataTable("GET_REPORT_ID")
        End Function

        Public Shared Function GET_Report_Detail(ByVal ReportID As Integer) As DataSet
            Dim db As New DBAccess
            db.AddParameter("@ReportId", ReportID)
            Return db.ExecuteDataSet("GetReportDetail")
        End Function

        Public Shared Function GetReportNameForExcel(ByVal ReportID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ReportId", ReportID)
            Return db.ExecuteDataTable("GetReportNameForExcel")

        End Function
        Public Shared Function UpdateReport(ByVal reportID As Integer, ByVal reportName As String, ByVal Subject As String, ByVal createdBy As String, ByVal Columns As String, ByVal ClientID As String, ByVal TypeId As String, ByVal CategoryId As String, ByVal SubCategoryId As String, ByVal Priority As String, ByVal status As String, ByVal TeamId As String, ByVal ReleaseId As String, ByVal CSOL As Integer, ByVal AssignedTo As String, ByVal ProductOwner As String, ByVal ProjectManager As String, ByVal DesignLead As String, ByVal DevLead As String, ByVal QALead As String, ByVal CreationDateInDay As String, ByVal CreationDateStart As String, ByVal CreationDateEnd As String, ByVal LastestActivityInDays As String, ByVal LastestActivityStartDate As String, ByVal LastestActivityEndDate As String, ByVal SowSignDays As String, ByVal SowSignDateStart As String, ByVal SowSignDateEnd As String, ByVal DueDays As String, ByVal DueDateStart As String, ByVal DueDateEnd As String, ByVal ReportFilters As DataTable) As DataTable
            Dim dtTickets As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ReportID", reportID)
            db.AddParameter("@ReportName", reportName)
            If (String.IsNullOrEmpty(Subject)) Then
                db.AddParameter("@Subject", DBNull.Value)
            Else
                db.AddParameter("@Subject", Subject)
            End If
            db.AddParameter("@CreadtedBy", createdBy)
            db.AddParameter("@CreateDate", System.DateTime.Now)
            db.AddParameter("@Columns", Columns)

            If (String.IsNullOrEmpty(ClientID)) Then
                db.AddParameter("@ClientID", DBNull.Value)
            Else
                db.AddParameter("@ClientID", ClientID)
            End If
            If (String.IsNullOrEmpty(TypeId)) Then
                db.AddParameter("@TypeID", DBNull.Value)
            Else
                db.AddParameter("@TypeID", TypeId)
            End If
            If (String.IsNullOrEmpty(CategoryId)) Then
                db.AddParameter("@CategoryID", DBNull.Value)
            Else
                db.AddParameter("@CategoryID", CategoryId)
            End If

            If (String.IsNullOrEmpty(SubCategoryId)) Then
                db.AddParameter("@SubCategoryID", DBNull.Value)
            Else
                db.AddParameter("@SubCategoryID", SubCategoryId)
            End If

            If (String.IsNullOrEmpty(Priority)) Then
                db.AddParameter("@PriorityID", DBNull.Value)
            Else
                db.AddParameter("@PriorityID", Priority)
            End If

            If (String.IsNullOrEmpty(status)) Then
                db.AddParameter("@StatusID", DBNull.Value)
            Else
                db.AddParameter("@StatusID", status)
            End If

            If (String.IsNullOrEmpty(TeamId)) Then
                db.AddParameter("@TeamID", DBNull.Value)
            Else
                db.AddParameter("@TeamID", TeamId)
            End If
            If (String.IsNullOrEmpty(ReleaseId)) Then
                db.AddParameter("@ReleaseID", DBNull.Value)
            Else
                db.AddParameter("@ReleaseID", ReleaseId)
            End If
            If (CSOL = 0) Then
                db.AddParameter("@CompletedSurvay", DBNull.Value)
            Else
                db.AddParameter("@CompletedSurvay", "1")
            End If

            If (String.IsNullOrEmpty(ProductOwner)) Then
                db.AddParameter("@ProductOwnerID", DBNull.Value)
            Else
                db.AddParameter("@ProductOwnerID", ProductOwner)
            End If

            If (String.IsNullOrEmpty(ProjectManager)) Then
                db.AddParameter("@ProjectManagerID", DBNull.Value)
            Else
                db.AddParameter("@ProjectManagerID", ProjectManager)
            End If


            If (String.IsNullOrEmpty(DesignLead)) Then
                db.AddParameter("@DesignLeadID", DBNull.Value)
            Else
                db.AddParameter("@DesignLeadID", DesignLead)
            End If


            If (String.IsNullOrEmpty(DevLead)) Then
                db.AddParameter("@DevelopmentLeadID", DBNull.Value)
            Else
                db.AddParameter("@DevelopmentLeadID", DevLead)
            End If

            If (String.IsNullOrEmpty(QALead)) Then
                db.AddParameter("@QALeadID", DBNull.Value)
            Else
                db.AddParameter("@QALeadID", QALead)
            End If
            If (String.IsNullOrEmpty(AssignedTo)) Then
                db.AddParameter("@AssignToID", DBNull.Value)
            Else
                db.AddParameter("@AssignToID", AssignedTo)
            End If

            If (String.IsNullOrEmpty(CreationDateInDay)) Then
                db.AddParameter("@CreationDateInt", DBNull.Value)
            Else
                db.AddParameter("@CreationDateInt", CreationDateInDay)
            End If

            If (String.IsNullOrEmpty(CreationDateStart)) Then
                db.AddParameter("@CreationDateStart", DBNull.Value)
            Else
                db.AddParameter("@CreationDateStart", CreationDateStart)
            End If

            If (String.IsNullOrEmpty(CreationDateEnd)) Then
                db.AddParameter("@CreationDateEnd", DBNull.Value)
            Else
                db.AddParameter("@CreationDateEnd", CreationDateEnd)
            End If

            If (String.IsNullOrEmpty(LastestActivityInDays)) Then
                db.AddParameter("@LastestActivityDateInt", DBNull.Value)
            Else
                db.AddParameter("@LastestActivityDateInt", LastestActivityInDays)
            End If
            If (String.IsNullOrEmpty(LastestActivityStartDate)) Then
                db.AddParameter("@LastestActivityDateStart", DBNull.Value)
            Else
                db.AddParameter("@LastestActivityDateStart", LastestActivityStartDate)
            End If

            If (String.IsNullOrEmpty(LastestActivityEndDate)) Then
                db.AddParameter("@LastestActivityDateEnd", DBNull.Value)
            Else
                db.AddParameter("@LastestActivityDateEnd", LastestActivityEndDate)
            End If
            If (String.IsNullOrEmpty(SowSignDays)) Then
                db.AddParameter("@SOWSignDateInt", DBNull.Value)
            Else
                db.AddParameter("@SOWSignDateInt", SowSignDays)
            End If

            If (String.IsNullOrEmpty(SowSignDateStart)) Then
                db.AddParameter("@SOWSignDateStart", DBNull.Value)
            Else
                db.AddParameter("@SOWSignDateStart", SowSignDateStart)
            End If

            If (String.IsNullOrEmpty(SowSignDateEnd)) Then
                db.AddParameter("@SOWSignDateEnd", DBNull.Value)
            Else
                db.AddParameter("@SOWSignDateEnd", SowSignDateEnd)
            End If
            If (String.IsNullOrEmpty(DueDays)) Then
                db.AddParameter("@DueDateInt", DBNull.Value)
            Else
                db.AddParameter("@DueDateInt", DueDays)
            End If

            If (String.IsNullOrEmpty(DueDateStart)) Then
                db.AddParameter("@DueDateStart", DBNull.Value)
            Else
                db.AddParameter("@DueDateStart", DueDateStart)
            End If

            If (String.IsNullOrEmpty(DueDateEnd)) Then
                db.AddParameter("@DueDateEnd", DBNull.Value)
            Else
                db.AddParameter("@DueDateEnd", DueDateEnd)
            End If

            If (ReportFilters Is Nothing) Then
                db.AddParameter("@ReportFilters", DBNull.Value)
            Else
                db.AddParameter("@ReportFilters", ReportFilters)
            End If

            'db.AddParameter("@ReportFilters", ReportFilters)

            dtTickets = db.ExecuteDataTable("PM_UpDate_Report")
            Return dtTickets
        End Function

        Public Shared Function RemoveLinkedTicket(ByVal TicketID As Integer, ByVal LinkedTicketID As Integer ) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ticketID", TicketID)
            db.AddParameter("@linkedTicketID", LinkedTicketID)
            Return db.ExecuteNonQuery("removeLinkedTicket")
        End Function
        Public Shared Function DeleteResources(ByVal TicketID As Integer, ByVal RoleID As Integer ) As Integer
            Dim db As New DBAccess
            db.AddParameter("@RoleID", RoleID)
            db.AddParameter("@TicketID", TicketID)
            Return db.ExecuteNonQuery("deleteRole")
           
        End Function

        Public Shared Function AddNewResource(ByVal TicketID As Integer, ByVal ResourceName As String ) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@TicketID", TicketID)
            db.AddParameter("@ResourceName", ResourceName)
            Return db.ExecuteDataTable("AddTicketResource")
        End Function
        Public Shared Function UpdateTicketResource(ByVal TicketID As Integer, ByVal RoleID As Integer, ByVal UserID As Integer ) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ticketID", TicketID)
            db.AddParameter("@RoleID", RoleID)
            db.AddParameter("@UserID", UserID)
            Return db.ExecuteDataTable("UpdateTicketResource")
        End Function

        Public Shared Function AddNewEstimate(ByVal TicketID As Integer, ByVal RoleID As String) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@TicketID", TicketID)
            db.AddParameter("@ResourceName", RoleID)
            Return db.ExecuteDataTable("AddEstimates")
        End Function
        Public Shared Function DeleteEstimate(ByVal TicketID As Integer, ByVal EstimateTypeID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@TicketId", TicketID)
            db.AddParameter("@EstimateTypeID", EstimateTypeID)
            Return db.ExecuteNonQuery("deleteEstimate")
        End Function
    End Class
End Namespace
