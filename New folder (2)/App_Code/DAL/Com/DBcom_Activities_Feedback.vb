Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.Com
    Public Class DBcom_Activities_Feedback
#Region " Public Method "



        Public Shared Function com_Activities_FeedbackGetByID(ByVal ActivityID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ActivityID", ActivityID)
            Return db.ExecuteDataTable("com_Activities_Feedback_GetByID")
        End Function
        'Public Function Add(ByVal SupportFeedBackBll As Portal.BLL.Com.com_Activities_Feedback) As Integer
        '    Dim db As New DBAccess

        '    db.AddParameter("@ID", SupportFeedBackBll.ID)
        '    db.AddParameter("@ActivityID", SupportFeedBackBll.ActivityID)
        '    db.AddParameter("@EnteredBy", SupportFeedBackBll.EnteredBy)
        '    db.AddParameter("@EnteredOn", SupportFeedBackBll.EnteredOn)
        '    db.AddParameter("@Promptness", SupportFeedBackBll.Promptness)
        '    db.AddParameter("@Courteousness", SupportFeedBackBll.Courteousness)
        '    db.AddParameter("@Clarity", SupportFeedBackBll.Clarity)
        '    db.AddParameter("@Knowledgeable", SupportFeedBackBll.Knowledgeable)
        '    db.AddParameter("@Rate", SupportFeedBackBll.Rate)
        '    db.AddParameter("@RateComments", SupportFeedBackBll.RateComments)

        '    Dim Affected As Integer = db.ExecuteNonQuery("SupportFeedBack_Add")
        '    SupportFeedBackBll.ID = CInt(CType(db.Parameters("@id"), System.Data.SqlClient.SqlParameter).Value)
        '    Return Affected
        'End Function

        Public Function UpdateActivityRate(ByVal ObjActivity As Portal.BLL.Com.com_Activities_Feedback) As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ActivityID", ObjActivity.ActivityID)
            db.AddParameter("@Rate", ObjActivity.Rate)
            db.AddParameter("@Knowledgeable", ObjActivity.Knowledgeable)
            db.AddParameter("@Clarity", ObjActivity.Clarity)
            db.AddParameter("@Courteousness", ObjActivity.Courteousness)
            db.AddParameter("@Promptness", ObjActivity.Promptness)
            db.AddParameter("@RateComments", ObjActivity.RateComments)
            db.AddParameter("@LastUpdatedOn", ObjActivity.EnteredOn)
            db.AddParameter("@EnteredBy", ObjActivity.EnteredBy)

            Return db.ExecuteNonQuery("Activities_Rate_Update")
        End Function

        Public Function GetActivityRateByType(ByVal Type As Integer, ByVal StartDate As Date, ByVal EndDate As Date, ByVal ClientID As Integer) As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Type", Type)
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            db.AddParameter("@ClientID", ClientID)
            Return db.ExecuteReader("Com_Activities_GetRating")
        End Function

        Public Function GetActivityStats(ByVal StartDate As Date, ByVal EndDate As Date, ByVal ClientID As Integer) As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@StartDate", StartDate)
            db.AddParameter("@EndDate", EndDate)
            db.AddParameter("@ClientID", ClientID)
            Return db.ExecuteReader("Com_Activities_GetStats")
        End Function
      

#End Region

    End Class
End Namespace