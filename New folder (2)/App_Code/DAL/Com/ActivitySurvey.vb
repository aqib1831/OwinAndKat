Imports Microsoft.VisualBasic
Namespace Portal.DAL
    Public Class ActivitySurvey
#Region "Public Method"
        Public Shared Function Add(ByVal ActivityID As Integer, _
                                    ByVal ActivityRate As Integer, _
                                    ByVal FranContactID As Integer, _
                                    ByVal ClientContactID As Integer, _
                                    ByVal Comments As String)

            Dim db As New DBAccess()
            db.AddParameter("@ActivityID", ActivityID)
            db.AddParameter("@ActivityRate", ActivityRate)
            db.AddParameter("@EnteredByFranContactID", FranContactID)
            db.AddParameter("@EnteredByClientContactID", ClientContactID)
            If String.IsNullOrEmpty(Comments) Then
                db.AddParameter("@SurveyComments", DBNull.Value)
            Else
                db.AddParameter("@SurveyComments", Comments)
            End If
            Dim Affected As Integer = db.ExecuteNonQuery("com_Activities_Survey_Add")
            db = Nothing
            Return Affected
        End Function
#End Region
    End Class
End Namespace

