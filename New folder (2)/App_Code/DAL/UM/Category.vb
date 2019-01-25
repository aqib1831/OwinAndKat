Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.DAL.UM

    Public Class Category

#Region "Public Methods"
        Public Function GetAllCategoriesBySearch(ByVal Search As String, ByVal SortExpression As String) As DataSet
            Dim dsCategories As DataSet = Nothing
            Dim db As New DBAccess
            db.AddParameter("@Search", IIf(Search = Nothing, DBNull.Value, Search))
            db.AddParameter("@SortExpression", SortExpression)
            dsCategories = db.ExecuteDataSet("UM_Categories_GetBySearch")
            Return dsCategories
        End Function
       

        Public Function Add(ByVal category As Portal.BLL.UM.Category) As Integer
            Dim ID As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.AddParameter("@Title", category.Title)
            db.AddParameter("@AddedBy", category.AddedBy)
            db.ExecuteNonQuery("UM_Categories_Add")
            ID = CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
            Return ID
        End Function

        Public Function Update(ByVal category As Portal.BLL.UM.Category) As Integer
            Dim ReturnValue As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", category.ID)
            db.AddParameter("@Title", category.Title)
            db.AddParameter("@LastUpdatedBy", category.LastUpdatedBy)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            db.ExecuteNonQuery("UM_Categories_Update")
            ReturnValue = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return ReturnValue
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            Return db.ExecuteNonQuery("UM_Categories_Delete")
        End Function
        Public Shared Function SearchUserManual(ByVal Search As String) As SqlDataReader
            Search = RemoveNoiseWords(Search.Replace("?", "").Replace(",", ""))
            Dim drSearchUserManual As SqlDataReader = Nothing
            Dim db As New DBAccess
            If Not Search = "" Then
                db.AddParameter("@Search", IIf(Search = "", DBNull.Value, Search))
                drSearchUserManual = db.ExecuteReader("UM_UserManualSearch")
            End If
            Return drSearchUserManual
        End Function
        Private Shared Function RemoveNoiseWords(ByVal Searchtxt As String) As String
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

        Public Shared Function GetByID(ByVal ID As Integer) As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@CategoryID", ID)
            Return db.ExecuteReader("UM_GetCategoryByID")
        End Function
        
#End Region
    End Class
End Namespace
