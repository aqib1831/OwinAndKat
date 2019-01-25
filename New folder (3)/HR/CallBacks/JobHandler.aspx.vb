Imports Portal.BLL.HR
Imports System.Collections.Generic
Imports System.Web.Script.Serialization

Partial Class HR_CallBacks_JobHandler
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Dim objJob As New Jobs
            Dim jobId As Integer = 0
            If Not String.IsNullOrEmpty(Request.Form("values")) Then
                Dim values() As String = Request.Form("values").Split(",")
                If values.Length > 0 Then
                    For Each value As String In values
                        Jobs.UpdateJobSequence(value.Split("-")(0), value.Split("-")(1))
                    Next
                End If
            ElseIf Not String.IsNullOrEmpty(Request.Form("Job")) Then
                If Not String.IsNullOrEmpty(Request.Form("JobID")) Then
                    jobId = CInt(Request.Form("JobID"))
                End If

                Dim JobDetails As Dictionary(Of String, Object) = CType(New JavaScriptSerializer().DeserializeObject(Server.UrlDecode(Request.Form("Job"))), Dictionary(Of String, Object))
                With objJob
                    .JobTitle = JobDetails.Item("JobTitle")
                    .InActive = JobDetails.Item("InActive")
                    .LocationID = JobDetails.Item("LocationID")
                    .StateID = JobDetails.Item("StateID")
                    .Description = JobDetails.Item("Description")
                End With

                Dim objJobDetail As Object() = CType(JobDetails.Item("JobDetail"), Object())
                objJob.JobDetailList = Jobs.LoadJobDetailListFromDictionary(objJobDetail)
                If jobId > 0 Then
                    objJob.ID = jobId
                    Jobs.UpdateJob(objJob)
                Else
                    jobId = Jobs.AddNewJob(objJob)
                End If
            End If
            Context.Response.Write("Success")

        Catch ex As Exception
            'ErrorLogManager.Add(ex.Message.ToString(), ex.StackTrace.ToString(), "NA", "PageLoad", "Mozilla", "", "")
        End Try

    End Sub
End Class
