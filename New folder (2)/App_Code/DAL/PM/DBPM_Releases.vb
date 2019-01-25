Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data

Namespace Portal.DAL.PM
    Public Class DBPM_Releases
        Public Shared Function GetAll(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Portal.BLL.PM.PM_Releases)

            Dim colUsers As New List(Of Portal.BLL.PM.PM_Releases)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            dr = db.ExecuteReader("PM_Releases_GetAll")
            While dr.Read()
                colUsers.Add(New Portal.BLL.PM.PM_Releases(CType(dr("ID"), Integer), CType(dr("Name"), String), CType(dr("DateEntered"), Date), CType(dr("ReleaseDate"), Date), CType(dr("NewReleaseDate"), Date), CType(dr("Progress"), Integer), CType(dr("Status"), String), CType(dr("Notes"), String), CType(dr("History"), Boolean), CType(dr("Deleted"), Boolean), CType(dr("ClientID"), Integer), CType(dr("CategoryID"), Integer), CType(dr("UserID"), Integer), CType(dr("ClientName"), String), CType(dr("CategoryName"), String), CType(dr("AreaDeveloperID"), Integer), CType(dr("SowSignedDate"), Date)))
            End While
            dr.Close()
            Return colUsers

        End Function
        Public Shared Function GetAllCount(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Releases_GetAllcount"))
        End Function

        Public Shared Function GetAllForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperID", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperID", DBNull.Value)
            End If
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Releases_GetAllForMyNetsolace")
        End Function
        Public Shared Function GetAllCountForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperID", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperID", DBNull.Value)
            End If
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Releases_GetAllcountForMyNetsolace"))
        End Function

        Public Shared Function Releases_GetAllHistory(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Portal.BLL.PM.PM_Releases)

            Dim colUsers As New List(Of Portal.BLL.PM.PM_Releases)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            dr = db.ExecuteReader("PM_Releases_GetAllHistory")
            While dr.Read()
                colUsers.Add(New Portal.BLL.PM.PM_Releases( _
                                                    CType(dr("ID"), Integer), _
                                                    CType(dr("Name"), String), _
                                                    CType(dr("DateEntered"), Date), _
                                                    CType(dr("ReleaseDate"), Date), _
                                                    CType(dr("NewReleaseDate"), Date), _
                                                    CType(dr("Progress"), Integer), _
                                                    CType(dr("Status"), String), _
                                                    CType(dr("Notes"), String), _
                                                    CType(dr("History"), Boolean), _
                                                    CType(dr("Deleted"), Boolean), _
                                                    CType(dr("ClientID"), Integer), _
                                                    CType(dr("CategoryID"), Integer), _
                                                    CType(dr("UserID"), Integer), _
                                                    CType(dr("ClientName"), String), _
                                                    CType(dr("CategoryName"), String), _
                                                    CType(dr("AreaDeveloperID"), Integer), _
                                                    CType(dr("SowSignedDate"), Date) _
                                                    ))
            End While
            dr.Close()
            Return colUsers

        End Function
        Public Shared Function Releases_GetAllHistoryCount(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@UserID", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@searchtxt", txtsearch)
            Return CInt(db.ExecuteScalar("PM_Releases_GetAllHistoryCount"))
        End Function
        Public Shared Function Releases_GetAllHistoryForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As DataTable

            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@ClientContactID", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperID", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperID", DBNull.Value)
            End If
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            Return db.ExecuteDataTable("PM_Releases_GetAllHistoryForMyNetsolace")

        End Function
        Public Shared Function Releases_GetAllHistoryCountForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@ClientContactID", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            db.AddParameter("@searchtxt", txtsearch)
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperID", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperID", DBNull.Value)
            End If
            Return CInt(db.ExecuteScalar("PM_Releases_GetAllHistoryCountForMyNetsolace"))
        End Function

        Public Shared Function GetByID(ByVal ID As Integer) As List(Of Portal.BLL.PM.PM_Releases)
            Dim colPM_Releases As New List(Of Portal.BLL.PM.PM_Releases)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("PM_Releases_GetByID")
            While dr.Read()
                colPM_Releases.Add(New Portal.BLL.PM.PM_Releases( _
                                                    CType(dr("ID"), Integer), _
                                                    CType(dr("Name"), String), _
                                                    CType(dr("DateEntered"), Date), _
                                                    CType(dr("ReleaseDate"), Date), _
                                                    CType(dr("NewReleaseDate"), Date), _
                                                    CType(dr("Progress"), Integer), _
                                                    CType(dr("Status"), String), _
                                                    CType(dr("Notes"), String), _
                                                    CType(dr("History"), Boolean), _
                                                    CType(dr("Deleted"), Boolean), _
                                                    CType(dr("ClientID"), Integer), _
                                                    CType(dr("CategoryID"), Integer), _
                                                    CType(dr("UserID"), Integer), _
                                                    CType(dr("ClientName"), String), _
                                                    CType(dr("CategoryName"), String), _
                                                    CType(dr("AreaDeveloperID"), Integer), _
                                                    New DateTime() _
                                                    ))
            End While
            dr.Close()
            Return colPM_Releases
        End Function
        Public Function Add(ByVal PM_ReleasesBll As Portal.BLL.PM.PM_Releases) As Integer
            Dim db As New DBAccess

            db.AddParameter("@Name", PM_ReleasesBll.Name)
            db.AddParameter("@DateEntered", PM_ReleasesBll.DateEntered)
            db.AddParameter("@ReleaseDate", PM_ReleasesBll.ReleaseDate)
            db.AddParameter("@Progress", PM_ReleasesBll.Progress)
            db.AddParameter("@Status", PM_ReleasesBll.Status)
            db.AddParameter("@Notes", PM_ReleasesBll.Notes)
            db.AddParameter("@History", PM_ReleasesBll.History)
            db.AddParameter("@Deleted", PM_ReleasesBll.Deleted)
            db.AddParameter("@ClientID", PM_ReleasesBll.ClientID)
            db.AddParameter("@CategoryID", PM_ReleasesBll.CategoryID)
            db.AddParameter("@UserID", PM_ReleasesBll.UserID)
            If PM_ReleasesBll.AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperID", PM_ReleasesBll.AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperID", DBNull.Value)
            End If

            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.Output, 0)

            db.ExecuteNonQuery("PM_Releases_Add")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            Return RetVal
        End Function
        Public Function Update(ByVal PM_ReleasesBll As Portal.BLL.PM.PM_Releases) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", PM_ReleasesBll.ID)
            db.AddParameter("@Name", PM_ReleasesBll.Name)
            db.AddParameter("@NewReleaseDate", IIf(PM_ReleasesBll.NewReleaseDate = "12:00:00 AM", System.DBNull.Value, PM_ReleasesBll.NewReleaseDate))
            db.AddParameter("@Progress", PM_ReleasesBll.Progress)
            db.AddParameter("@Status", PM_ReleasesBll.Status)
            db.AddParameter("@Notes", PM_ReleasesBll.Notes)
            db.AddParameter("@History", PM_ReleasesBll.History)
            db.AddParameter("@Deleted", PM_ReleasesBll.Deleted)
            db.AddParameter("@ClientID", PM_ReleasesBll.ClientID)
            db.AddParameter("@CategoryID", PM_ReleasesBll.CategoryID)
            db.AddParameter("@UserID", PM_ReleasesBll.UserID)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("PM_Releases_Update")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            If RetVal = 1 Then Affected = -101
            Return Affected
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@Deleted", True)
            Dim Affected As Integer = db.ExecuteNonQuery("PM_Releases_DeleteByID")
            Return Affected
        End Function

        Public Function GetAllForList(ByVal ClientID As Integer, ByVal AreaDeveloperID As Integer) As SqlClient.SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            If AreaDeveloperID <> 0 Then
                db.AddParameter("@AreaDeveloperID", AreaDeveloperID)
            Else
                db.AddParameter("@AreaDeveloperID", DBNull.Value)
            End If
            Return db.ExecuteReader("PM_Releases_GetAllForList")
        End Function

        Public Shared Function GetAll_Excel(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal maximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String, ByVal UserLogID As Integer) As DataTable
            Dim colUsers As New List(Of Portal.BLL.PM.PM_Releases)()
            Dim dr As DataTable
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", CategoryID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@UserID", UserLogID)
            'db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", StartRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            dr = db.ExecuteDataTable("PM_Releases_GetAll")
            Return dr
        End Function
        Public Shared Function GetAllReleasesForDropdown()
            Dim dr As DataTable
            Dim db As New DBAccess
            dr = db.ExecuteDataTable("GetReleases")
            Return dr
        End Function
        Public Shared Function GetAllSubCategoryForDropdown()
            Dim dr As DataTable
            Dim db As New DBAccess
            dr = db.ExecuteDataTable("getAllSubCategory")
            Return dr
        End Function
    End Class
End Namespace

