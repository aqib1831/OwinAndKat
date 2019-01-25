Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.HR
    Public Class DBJobs
#Region " Public Method "
        Public Shared Function JobsGetAllByLocation(ByVal StatusID As Integer, ByVal countryId As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Portal.BLL.HR.Jobs)
            Dim colJobs As New List(Of Portal.BLL.HR.Jobs)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            'Dim db As New DBAccess(objConnectionStringSettings)
            Dim db As New DBAccess
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            db.AddParameter("@CountryID", countryId)
            dr = db.ExecuteReader("Jobs_GetAllByLocationID")
            While dr.Read()
                colJobs.Add(New Portal.BLL.HR.Jobs( _
                CType(dr("ID"), Integer), _
                CType(dr("JobTitle"), String), _
                CType(dr("Description"), String), _
                CType(dr("PostingDate"), Date), _
                CType(dr("LastDate"), Date), _
                CType(dr("LocationNick"), String), _
                CType(dr("InActive"), Boolean), _
                CType(dr("Sequence"), Integer) _
                ))
            End While
            dr.Close()
            Return colJobs
        End Function
        Public Shared Function JobsGetAllByLocationCount(ByVal StatusID As Integer, ByVal countryId As Integer, ByVal txtsearch As String) As Integer
            Dim colJobs As New List(Of Portal.BLL.HR.Jobs)()
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            'Dim db As New DBAccess(objConnectionStringSettings)
            Dim db As New DBAccess
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@searchtxt", txtsearch)
            db.AddParameter("@CountryID", countryId)
            Return CInt(db.ExecuteScalar("Jobs_GetAllByLocationIDCount"))
        End Function
        Public Shared Function JobsGetByID(ByVal ID As Integer) As List(Of Portal.BLL.HR.Jobs)
            Dim colJobs As New List(Of Portal.BLL.HR.Jobs)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            Dim db As New DBAccess'(objConnectionStringSettings)
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("Jobs_GetByID")
            While dr.Read()
                colJobs.Add(New Portal.BLL.HR.Jobs( _
                CType(Functions.IfNull(dr("ID"), 0), Integer), _
                CType(Functions.IfNull(dr("StateID"), 0), Integer), _
                CType(Functions.IfNull(dr("LocationID"), 0), Integer), _
                CType(Functions.IfNull(dr("JobTitle"), ""), String), _
                CType(Functions.IfNull(dr("Description"), ""), String), _
                CType(Functions.IfNull(dr("PostingDate"), DateTime.MinValue), Date), _
                CType(Functions.IfNull(dr("LastDate"), DateTime.MinValue), Date), _
                CType(Functions.IfNull(dr("InActive"), False), Boolean), _
                CType(Functions.IfNull(dr("Deleted"), False), Boolean) _
                ))
            End While
            dr.Close()
            Return colJobs
        End Function
        Public Shared Function JobsGetAll() As List(Of Portal.BLL.HR.Jobs)
            Dim colJobs As New List(Of Portal.BLL.HR.Jobs)()
            Dim dr As SqlDataReader
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            Dim db As New DBAccess'(objConnectionStringSettings)
            dr = db.ExecuteReader("GetAllJobs")
            While dr.Read()
                colJobs.Add(New Portal.BLL.HR.Jobs( _
                  CType(Functions.IfNull(dr("ID"), 0), Integer), _
                 CType(Functions.IfNull(dr("JobTitle"), ""), String), _
                CType(Functions.IfNull(dr("Description"), ""), String), _
               CType(Functions.IfNull(dr("PostingDate"), DateTime.MinValue), Date), _
                  CType(Functions.IfNull(dr("LastDate"), DateTime.MinValue), Date), _
                  CType(Functions.IfNull(dr("Location"), ""), String), _
               CType(Functions.IfNull(dr("InActive"), False), Boolean) _
                ))
            End While
            dr.Close()
            Return colJobs
        End Function

        Public Function Add(ByVal JobsBll As Portal.BLL.HR.Jobs) As Integer
            Dim ID As Integer = 0
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            Dim db As New DBAccess'(objConnectionStringSettings)
            db.AddParameter("@ID", DbType.Int16, 4, ParameterDirection.Output, 0)
            If JobsBll.StateID = 0 Then
                db.AddParameter("@StateID", DBNull.Value)
            Else
                db.AddParameter("@StateID", JobsBll.StateID)
            End If
            If JobsBll.LocationID = 0 Then
                db.AddParameter("@LocationID", DBNull.Value)
            Else
                db.AddParameter("@LocationID", JobsBll.LocationID)
            End If
            db.AddParameter("@JobTitle", JobsBll.JobTitle)
            db.AddParameter("@Description", JobsBll.Description)
            db.AddParameter("@PostingDate", JobsBll.PostingDate)
            db.AddParameter("@LastDate", IIf(JobsBll.LastDate = Date.MinValue, DBNull.Value, JobsBll.LastDate))
            db.AddParameter("@InActive", JobsBll.InActive)
            Try
                db.ExecuteNonQuery("Jobs_Add")
                ID = CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                ID = 0
            Finally
                db.Dispose()
            End Try
            Return ID
        End Function
        Public Function Update(ByVal JobsBll As Portal.BLL.HR.Jobs) As Integer
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            Dim db As New DBAccess'(objConnectionStringSettings)
            db.AddParameter("@ID", JobsBll.ID)
            db.AddParameter("@StateID", JobsBll.StateID)
            db.AddParameter("@LocationID", IIf(JobsBll.LocationID = 0, DBNull.Value, JobsBll.LocationID))
            db.AddParameter("@JobTitle", JobsBll.JobTitle)
            db.AddParameter("@Description", JobsBll.Description)
            db.AddParameter("@PostingDate", JobsBll.PostingDate)
            db.AddParameter("@LastDate", IIf(JobsBll.LastDate = Date.MinValue, DBNull.Value, JobsBll.LastDate))
            db.AddParameter("@InActive", JobsBll.InActive)
            Dim Affected As Integer = db.ExecuteNonQuery("Jobs_Update")
            Return Affected
        End Function

        Public Shared Function GetJobTemplateDetailByID(ByVal ID As Integer) As SqlDataReader
            Dim dr As SqlDataReader = Nothing
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            Dim db As New DBAccess'(objConnectionStringSettings)
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("JobTemplates_GetByID")
            Return dr
        End Function

        Public Shared Function Jobs_DeleteByID(ByVal ID As Integer) As Integer
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            Dim db As New DBAccess'(objConnectionStringSettings)
            db.AddParameter("@ID", ID)
            Dim Affected As Integer = db.ExecuteNonQuery("Jobs_Delete")
            Return Affected
        End Function
        Public Shared Function AddNewJob(ByVal objJob As BLL.HR.Jobs) As Integer
            Dim objDBManager As New DBAccess
            objDBManager.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBManager.AddParameter("@JobTitle", SqlDbType.VarChar, 200, ParameterDirection.Input, objJob.JobTitle)
            objDBManager.AddParameter("@Description", SqlDbType.VarChar, 4000, ParameterDirection.Input, objJob.Description)
            objDBManager.AddParameter("@StateID", SqlDbType.Int, 4, ParameterDirection.Input, objJob.StateID)
            objDBManager.AddParameter("@LocationID", SqlDbType.TinyInt, 1, ParameterDirection.Input, objJob.LocationID)
            objDBManager.AddParameter("@InActive", SqlDbType.Bit, 1, ParameterDirection.Input, objJob.InActive)
            objDBManager.ExecuteNonQuery("Jobs_Add")
            Return objDBManager.Parameters("@ID").Value
        End Function
        Public Shared Function AddJobDetail(ByVal objJobItem As Portal.BLL.HR.JobDetail) As Integer
            Dim objDBManager As New DBAccess
            objDBManager.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            objDBManager.AddParameter("@JobID", SqlDbType.Int, 4, ParameterDirection.Input, objJobItem.JobID)
            objDBManager.AddParameter("@Name", SqlDbType.VarChar, 500, ParameterDirection.Input, objJobItem.Name)
            objDBManager.AddParameter("@JobAttributeID", SqlDbType.Int, 4, ParameterDirection.Input, objJobItem.AttributeID)
            objDBManager.AddParameter("@ParentID", SqlDbType.Int, 4, ParameterDirection.Input, objJobItem.ParentID)
            objDBManager.ExecuteNonQuery("Jobs_AddDetails")
            Return objDBManager.Parameters("@ID").Value
        End Function
        Public Shared Function GetJobByID(ByVal ID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@JobID", ID)
            Return db.ExecuteDataTable("GetJobByID")
        End Function
        Public Shared Sub UpdateNetsolaceJob(ByVal objJob As BLL.HR.Jobs)
            Dim objDBManager As New DBAccess
            objDBManager.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, objJob.ID)
            objDBManager.AddParameter("@JobTitle", SqlDbType.VarChar, 200, ParameterDirection.Input, objJob.JobTitle)
            objDBManager.AddParameter("@Description", SqlDbType.VarChar, 4000, ParameterDirection.Input, objJob.Description)
            objDBManager.AddParameter("@StateID", SqlDbType.Int, 4, ParameterDirection.Input, objJob.StateID)
            objDBManager.AddParameter("@LocationID", SqlDbType.TinyInt, 1, ParameterDirection.Input, objJob.LocationID)
            objDBManager.AddParameter("@InActive", SqlDbType.Bit, 1, ParameterDirection.Input, objJob.InActive)
            objDBManager.ExecuteNonQuery("Jobs_Netsolace_Update")
        End Sub
        Public Shared Sub UpdateJobSequence(ByVal jobId As Integer, ByVal sequence As Integer)
            Dim objDBManager As New DBAccess
            objDBManager.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, jobId)
            objDBManager.AddParameter("@Sequence", SqlDbType.TinyInt, 1, ParameterDirection.Input, sequence)
            objDBManager.ExecuteNonQuery("Jobs_UpdateSequence")
        End Sub
#End Region

    End Class
End Namespace