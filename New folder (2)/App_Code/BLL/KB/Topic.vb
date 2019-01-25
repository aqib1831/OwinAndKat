Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.data

Public Class Topic
#Region " Properties "
    Public ID As Integer
    Public Name As String
    Public CategoryID As Integer
    Public CreatedDate As DateTime
    Public Description As String
    Public UpdatedDate As DateTime
    Public Keywords As String
    Public PlainDescription As String
    Public Sequence As Integer
    Public CategoryName As String
    Public AddedBy As Integer
#End Region
#Region "Public Methods"
    Public Function Add() As Integer
        Dim intReturn As Integer = 0
        Dim objAccess As DBAccess = New DBAccess()
        objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        objAccess.AddParameter("@Name", SqlDbType.NVarChar, 250, ParameterDirection.Input, Me.Name)
        objAccess.AddParameter("@CreatedDate", SqlDbType.DateTime, 8, ParameterDirection.Input, Me.CreatedDate)
        objAccess.AddParameter("@CategoryID", SqlDbType.Int, 4, ParameterDirection.Input, Me.CategoryID)
        objAccess.AddParameter("@UpdatedDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)
        objAccess.AddParameter("@Keywords", SqlDbType.NVarChar, 2000, ParameterDirection.Input, Me.Keywords)
        objAccess.AddParameter("@Sequence", SqlDbType.Int, 4, ParameterDirection.Input, Me.Sequence)
        objAccess.AddParameter("@Description", Me.Description)
        objAccess.AddParameter("@PlainDescription", Me.PlainDescription)
        objAccess.AddParameter("@Addedby", Me.AddedBy)
        objAccess.ExecuteNonQuery("KB_Add_Topic")
        intReturn = CInt(CType(objAccess.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
        ID = intReturn
        objAccess.Dispose()
        Return intReturn
    End Function
    Public Function Update() As Integer
        Dim intReturn As Integer = 0
        Dim objAccess As DBAccess = New DBAccess()
        objAccess.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, Me.ID)
        objAccess.AddParameter("@Name", SqlDbType.NVarChar, 250, ParameterDirection.Input, Me.Name)
        objAccess.AddParameter("@CategoryID", SqlDbType.Int, 4, ParameterDirection.Input, Me.CategoryID)
        objAccess.AddParameter("@UpdatedDate", SqlDbType.DateTime, 8, ParameterDirection.Input, DateTime.Now)
        objAccess.AddParameter("@Keywords", SqlDbType.NVarChar, 2000, ParameterDirection.Input, Me.Keywords)
        objAccess.AddParameter("@Description", Me.Description)
        objAccess.AddParameter("@PlainDescription", Me.PlainDescription)
        objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 8, ParameterDirection.Output, 0)
        objAccess.AddParameter("@Sequence", SqlDbType.Int, 4, ParameterDirection.Input, Me.Sequence)
        intReturn = objAccess.ExecuteNonQuery("KB_Update_Topic")
        objAccess.Dispose()
        Return intReturn
    End Function
    Public Function Delete(ByVal ID As Integer) As Integer
        Dim intReturn As Integer = 0
        Dim objAccess As DBAccess = New DBAccess()
        objAccess.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Input, ID)
        Return objAccess.ExecuteNonQuery("KB_Topic_Delete")
        objAccess.Dispose()
    End Function
    Public Function GetCategoryTopic(ByVal CategoryID As Nullable(Of Integer), ByVal Reccount As Nullable(Of Integer), ByVal SortExpression As String, ByVal Search As String) As SqlDataReader
        Dim db As New DBAccess
        If CategoryID.HasValue Then
            If CategoryID.Value = 0 Then
                db.AddParameter("@CategoryID", DBNull.Value)
            Else
                db.AddParameter("@CategoryID", CategoryID.Value)
            End If
        End If
        If String.IsNullOrEmpty(Search) Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If
        If String.IsNullOrEmpty(SortExpression) = True Then
            SortExpression = "Name"
        End If
        db.AddParameter("@SortExpression", SortExpression)
        db.AddParameter("@RecCount", SqlDbType.Int, 4, ParameterDirection.Output, Reccount)
        Return CType(db.ExecuteReader("KB_Topics_Search_Sorting"), SqlDataReader)
    End Function
    Public Function LoadTopicDetail(ByVal TopicID As Nullable(Of Integer)) As Integer
        Dim rValue As Boolean = False
        Dim db As New DBAccess
        db.AddParameter("@TopicID", TopicID)
        If db.ExecuteSingleRecordReader("KB_Get_TopicByID") Then
            ID = db.GetOrdinal("ID")
            Name = db.GetOrdinal("Name")
            If String.IsNullOrEmpty(db.GetOrdinal("CreatedDate", True)) = False Then
                CreatedDate = db.GetOrdinal("CreatedDate")
            End If
            Description = db.GetOrdinal("Description", True)
            CategoryName = db.GetOrdinal("CategoryName", True)
            Keywords = db.GetOrdinal("Keywords", True)
            CategoryID = db.GetOrdinal("CategoryID")
            Sequence = Functions.IfNull(db.GetOrdinal("Sequence"), 0)
            If String.IsNullOrEmpty(db.GetOrdinal("UpdatedDate", True)) = False Then
                UpdatedDate = db.GetOrdinal("UpdatedDate")
            End If
            rValue = True
        Else
            rValue = False
        End If
        db.Dispose()
        Return rValue
    End Function
    Public Function SearchKnowledgeBase(ByVal Search As String) As SqlDataReader
        Dim db As New DBAccess
        Search = RemoveNoiseWords(Search.Replace("?", "").Replace(",", ""))
        db.AddParameter("@Search", Search)
        Return CType(db.ExecuteReader("KB_Topics_Search"), SqlDataReader)
    End Function
    Private Function RemoveNoiseWords(ByVal Searchtxt As String) As String
        Dim noisyWord() As String = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "$", "a", "about", "after", "all", "also", "an", "and", "another", "any", "are", "as", "at", "b", "be", "because", "been", "before", "being", "between", "both", "but", "by", "c", "came", "can", "come", "could", "d", "did", "do", "does", "e", "each", "else", "f", "for", "from", "g", "get", "got", "h", "had", "has", "have", "he", "her", "here", "him", "himself", "his", "how", "i", "if", "in", "into", "is", "it", "its", "j", "just", "k", "l", "like", "m", "make", "many", "me", "might", "more", "most", "much", "must", "my", "n", "never", "now", "o", "of", "on", "only", "or", "other", "our", "out", "over", "p", "q", "r", "re", "s", "said", "same", "see", "should", "since", "so", "some", "still", "such", "t", "take", "Test", "than", "that", "the", "their", "them", "then", "there", "these", "they", "this", "those", "through", "to", "too", "u", "under", "up", "use", "v", "very", "w", "want", "was", "way", "we", "well", "were", "what", "when", "where", "which", "while", "who", "will", "with", "would", "x", "y", "you", "your", "z"}
        Dim i As Integer = 0
        For i = 0 To noisyWord.Length - 1
            If (Searchtxt.ToLower() = noisyWord(i)) Then
                Searchtxt = Searchtxt.Replace(noisyWord(i), noisyWord(i) & "0")
                Exit For
            End If
        Next
        Return Searchtxt
    End Function
#End Region
End Class
