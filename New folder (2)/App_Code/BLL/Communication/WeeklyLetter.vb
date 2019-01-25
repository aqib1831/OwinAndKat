Imports Microsoft.VisualBasic
Imports System.Data.Sqlclient
Imports System.Data
Namespace Portal.BLL.Communication
    Public Class WeeklyLetter

        Public subject As String
        Public Description As String
        Public ID As Integer

        Public Function GetWeeklyLetterNews_ByLetterID(ByVal LetterID As Integer, ByVal Type As Integer) As DataSet

            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@LetterID", LetterID)
            db.AddParameter("@Type", Type)

            Return CType(db.ExecuteDataSet("WeeklyLetter_News_GetByLetterID"), DataSet)

        End Function

        Public Shared Function GetWeeklyLetterNewsDescriptionByID(ByVal weeklyLetterId As Integer) As String
            Dim objDbAccess As DBAccess = New DBAccess()
            objDbAccess.AddParameter("@WeeklyLetterID", weeklyLetterId)
            Return CType(objDbAccess.ExecuteScalar("WeeklyLetter_News_GetDescriptionByID"), String)
        End Function

        Public Shared Function GetWeeklyLetterIDByWeeklyLeterNews(ByVal weeklyLetterNewsId As Integer) As Integer
            Dim objDbAccess As DBAccess = New DBAccess()
            objDbAccess.AddParameter("@WeeklyLetterNewsID", weeklyLetterNewsId)
            Return CType(objDbAccess.ExecuteScalar("WeeklyLetter_News_GetLetterID"), Integer)
        End Function




        'Use of this function in following pages
        'EditTemplate.aspx.vb BY Muhammad Zeeshan Hanif
        Public Sub WeeklyLetter_EmailTemplate_Add()
            Dim db As New DBAccess()
            db.AddParameter("@Subject", subject)
            db.AddParameter("@Description", Description)
            db.AddParameter("@ID", ID)
            db.ExecuteNonQuery("WeeklyLetter_EmailTemplate_Add")
        End Sub

        'Use of this function in following pages
        'EditTemplate.aspx.vb BY Muhammad Zeeshan Hanif
        Public Function Weeklyletter_EmailTemplate_Get() As System.Data.SqlClient.SqlDataReader
            Dim db As New DBAccess
            Return CType(db.ExecuteReader("WeeklyLetter_GetEmailTemplate"), System.Data.SqlClient.SqlDataReader)
        End Function

        Public Function GetWeeklyLetter_ByID(ByVal ID As Integer) As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", ID)
            Return CType(db.ExecuteReader("WeeklyLetter_GetByID"), SqlDataReader)
        End Function
        Public Function WeeklyLetter_GetTemplateId(ByVal LetterId As Integer) As Integer

            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@LetterId", LetterId)
            Return CInt(db.ExecuteScalar("WeeklyLetter_GetTemplateId"))

        End Function
        Public Function WeeklyLetterTemplate_GetByLetterID(ByVal LetterId As Integer) As DataTable
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@LetterId", LetterId)
            Return db.ExecuteDataTable("WeeklyLetter_Templates_GetByLetterID")
        End Function

        Public Shared Function MakePublish(ByVal LetterID As Integer) As Integer

            Dim db As New DBAccess()

            db.AddParameter("@ID", LetterID)
            Return db.ExecuteNonQuery("WeeklyLetter_MakePublish")

        End Function

        Public Shared Function UpdateDescription(ByVal LetterID As Integer, ByVal Description As String, ByVal DescriptionForStoreEmployee As String) As Integer

            Dim db As New DBAccess

            db.AddParameter("@ID", LetterID)
            db.AddParameter("@Description", Description)

            If DescriptionForStoreEmployee = String.Empty Then
                db.AddParameter("@DescriptionForStoreEmployee", DBNull.Value)
            Else
                db.AddParameter("@DescriptionForStoreEmployee", DescriptionForStoreEmployee)
            End If

            Return db.ExecuteNonQuery("WeeklyLetter_UpdateDescription")

        End Function

        Public Shared Function ContactsAdd(ByVal LetterID As Integer, ByVal ContactID As Integer) As Integer

            Dim db As New DBAccess

            db.AddParameter("@LetterID", LetterID)
            db.AddParameter("@ContactID", ContactID)
            Return db.ExecuteNonQuery("WeeklyLetter_Contacts_Add")

        End Function

        Public Shared Function AdminsAdd(ByVal LetterID As Integer, ByVal AdminID As Integer) As Integer

            Dim db As New DBAccess

            db.AddParameter("@LetterID", LetterID)
            db.AddParameter("@AdminID", AdminID)
            Return db.ExecuteNonQuery("WeeklyLetter_Admins_Add")

        End Function
        Public Shared Function WeeklyLetter_Add(ByVal Title As String, ByVal ToDate As Date, ByVal FromDate As Date, ByVal TemplateId As Integer) As Integer

            Dim db As New DBAccess
            Dim intReturnValue As Integer = 0
            Dim lastRecordId As Integer = 0
            db.AddParameter("@Title", Title)
            db.AddParameter("@ToDate", ToDate)
            db.AddParameter("@FromDate", FromDate)
            db.AddParameter("@TemplateId", TemplateId)
            db.AddParameter("@RecordID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@Return_Val", Data.ParameterDirection.ReturnValue)
            db.ExecuteNonQuery("WeeklyLetter_Add")
            intReturnValue = db.Parameters("@Return_Val").Value
            If (intReturnValue = 1) Then    'Incase the letter with this title already exists.
                Return intReturnValue
            Else
                lastRecordId = db.Parameters("@RecordID").Value 'Incase the new record has been added.
                Return lastRecordId
            End If

        End Function


        Public Shared Function WeeklyLetter_GetAll_Templates() As SqlDataReader

            Dim db As New DBAccess
            Dim reader As SqlDataReader = db.ExecuteReader("WeeklyLetter_GetAll_Templates")
            Return reader

        End Function
        Public Shared Function WeeklyLetter_Update(ByVal Title As String, ByVal ToDate As Date, ByVal FromDate As Date, ByVal TemplateId As Integer, ByVal ID As Integer) As Integer

            Dim db As New DBAccess
            Dim intReturnValue As Integer = 0
            db.AddParameter("@ID", ID)
            db.AddParameter("@Title", Title)
            db.AddParameter("@ToDate", ToDate)
            db.AddParameter("@FromDate", FromDate)
            db.AddParameter("@TemplateId", TemplateId)
            db.AddParameter("@Return_Val", Data.ParameterDirection.ReturnValue)
            db.ExecuteNonQuery("WeeklyLetter_Update")
            intReturnValue = db.Parameters("@Return_Val").Value
            Return intReturnValue
        End Function


        Public Shared Function WeeklyLetter_GetAll_PendingLetters(ByVal HasForum As Boolean) As SqlDataReader

            Dim db As New DBAccess
            db.AddParameter("@HasForum", HasForum)
            Dim reader As SqlDataReader = db.ExecuteReader("WeeklyLetter_GetAll_PendingLetters")
            Return reader

        End Function

        Public Shared Function WeeklyLetter_GetNewsCountForStore(ByVal LetterID As Integer) As Integer
            Dim db As New DBAccess
            Dim intReturnValue As Integer = 0
            db.AddParameter("@LetterID", LetterID)
            intReturnValue = db.ExecuteScalar("WeeklyLetter_NewsCount_ForStore")
            Return intReturnValue
        End Function

        Public Shared Function WeeklyLetter_GetNewsCount(ByVal LetterID As Integer) As Integer
            Dim db As New DBAccess
            Dim intReturnValue As Integer = 0
            db.AddParameter("@LetterID", LetterID)
            intReturnValue = db.ExecuteScalar("WeeklyLetter_NewsCount")
            Return intReturnValue
        End Function
        Public Shared Function GetAllWeeklyLetterForComm(ByVal isPublished As Nullable(Of Boolean), ByVal search As String, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer) As DataTable
            Dim objDbAccess As New DBAccess
            If (isPublished.HasValue) Then                              'This method is used to get weekly letter for Communication module.
                objDbAccess.AddParameter("@isPublished", isPublished)
            Else
                objDbAccess.AddParameter("@isPublished", DBNull.Value)
            End If
            If (String.IsNullOrEmpty(sortExpression)) Then
                objDbAccess.AddParameter("@sortExpression", DBNull.Value)
            Else
                objDbAccess.AddParameter("@sortExpression", sortExpression)
            End If
            objDbAccess.AddParameter("@startRowIndex", startRowIndex)
            objDbAccess.AddParameter("@maximumRows", maximumRows)
            If (String.IsNullOrEmpty(search)) Then
                objDbAccess.AddParameter("@search", DBNull.Value)
            Else
                objDbAccess.AddParameter("@search", search)
            End If
            Return objDbAccess.ExecuteDataTable("WeeklyLetter_GetAll")
        End Function
        Public Shared Function GetAllWeeklyLetterCountForComm(ByVal isPublished As Nullable(Of Boolean), ByVal search As String) As Integer
            Dim objDbAccess As New DBAccess
            If (isPublished.HasValue) Then                              'This method is used to get weekly letter count for Communication module.
                objDbAccess.AddParameter("@Published", isPublished)
            Else
                objDbAccess.AddParameter("@Published", DBNull.Value)
            End If
            If (String.IsNullOrEmpty(search)) Then
                objDbAccess.AddParameter("@search", DBNull.Value)
            Else
                objDbAccess.AddParameter("@search", search)
            End If
            Return CInt(objDbAccess.ExecuteScalar("WeeklyLetter_GetAll_Count"))
        End Function
        Public Shared Function GetAllWeeklyLetterForFranchiseeForStore(ByVal isPublished As Nullable(Of Boolean), ByVal search As String, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer) As DataTable
            Dim objDbAccess As New DBAccess
            If (isPublished.HasValue) Then                              'This method is used to get weekly letter for store letter which have atleast one news store for employees.
                objDbAccess.AddParameter("@isPublished", isPublished)
            Else
                objDbAccess.AddParameter("@isPublished", DBNull.Value)
            End If
            If (String.IsNullOrEmpty(sortExpression)) Then
                objDbAccess.AddParameter("@sortExpression", DBNull.Value)
            Else
                objDbAccess.AddParameter("@sortExpression", sortExpression)
            End If
            objDbAccess.AddParameter("@startRowIndex", startRowIndex)
            objDbAccess.AddParameter("@maximumRows", maximumRows)
            If (String.IsNullOrEmpty(search)) Then
                objDbAccess.AddParameter("@search", DBNull.Value)
            Else
                objDbAccess.AddParameter("@search", search)
            End If
            Return objDbAccess.ExecuteDataTable("WeeklyLetter_GetAll_ForFranchiseeForStore")
        End Function
        Public Shared Function GetAllWeeklyLetterCountForFranchiseeForStore(ByVal isPublished As Nullable(Of Boolean), ByVal search As String) As Integer
            Dim objDbAccess As New DBAccess
            If (isPublished.HasValue) Then                              'This method is used to get weekly letter count for Communication module.
                objDbAccess.AddParameter("@isPublished", isPublished)
            Else
                objDbAccess.AddParameter("@isPublished", DBNull.Value)
            End If
            If (String.IsNullOrEmpty(search)) Then
                objDbAccess.AddParameter("@search", DBNull.Value)
            Else
                objDbAccess.AddParameter("@search", search)
            End If
            Return CInt(objDbAccess.ExecuteScalar("WeeklyLetter_GetAll_ForFranchiseeForStore_Count"))
        End Function

        Public Shared Function WeeeklyLettersGetByUserID(ByVal UserID As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            Return db.ExecuteDataTable("WeeklyLetters_GetByUserID")
        End Function
        Public Shared Function GetAllWeeklyLetters(ByVal search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal sortBy As String) As DataTable
            Dim objDbAccess As New DBAccess
            If String.IsNullOrEmpty(sortBy) = True Then
                objDbAccess.AddParameter("@SortExpression", DBNull.Value)
            Else
                objDbAccess.AddParameter("@SortExpression", sortBy)
            End If
            If String.IsNullOrEmpty(search) = True Then
                objDbAccess.AddParameter("@Search", DBNull.Value)
            Else
                objDbAccess.AddParameter("@Search", search)
            End If
            objDbAccess.AddParameter("@StartRowIndex", startRowIndex)
            objDbAccess.AddParameter("@MaximumRows", maximumRows)
            Return objDbAccess.ExecuteDataTable("WeeklyLetter_GetAll_ForFFT")
        End Function

        Public Shared Function GetAllWeeklyLettersCount(ByVal search As String) As Integer
            Dim objDbAccess As New DBAccess
            If String.IsNullOrEmpty(search) = True Then
                objDbAccess.AddParameter("@Search", DBNull.Value)
            Else
                objDbAccess.AddParameter("@Search", search)
            End If
            Return CInt(objDbAccess.ExecuteScalar("WeeklyLetter_GetAll_ForFFT_Count"))
        End Function

    End Class
End Namespace
