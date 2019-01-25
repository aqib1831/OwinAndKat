Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports Portal.BLL

Namespace Portal.DAL
    Public Class ActivityNotes

#Region "Public Functions"
        Public Function AddNotes(ByVal objNotes As Portal.BLL.ActivityNotes) As Integer
            Dim intReturn As Integer
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ActivityID", objNotes.ActivityID)
            db.AddParameter("@Date", objNotes.NotesDate)
            db.AddParameter("@Type", objNotes.NotesType)
            db.AddParameter("@Notes", objNotes.Notes)
            db.AddParameter("@PlacedBy", objNotes.PlacedBy)
            'Checking whether the notes are from Admin, Coporate, Franchisee
            If (objNotes.AdminID <> 0) Then
                db.AddParameter("@AdminID", objNotes.AdminID)
                db.AddParameter("@ClientContactID", DBNull.Value)
                db.AddParameter("@FranchiseContactID", DBNull.Value)
            Else
                If (objNotes.ClientContactID <> 0) Then
                    db.AddParameter("@AdminID", DBNull.Value)
                    db.AddParameter("@ClientContactID", objNotes.ClientContactID)
                    db.AddParameter("@FranchiseContactID", DBNull.Value)
                Else
                    If (objNotes.FranchiseContactID <> 0) Then
                        db.AddParameter("@AdminID", DBNull.Value)
                        db.AddParameter("@ClientContactID", DBNull.Value)
                        db.AddParameter("@FranchiseContactID", objNotes.FranchiseContactID)
                    End If
                End If
            End If

            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            Try
                db.ExecuteNonQuery("Activities_Notes_Add")
                intReturn = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                db.Dispose()
            End Try
            Return intReturn
        End Function

        Public Function GetNotesByActivityID(ByVal ActivityID As Integer) As SqlDataReader
            'This function returns public and private notes against an activity ID
            Dim dr As SqlDataReader = Nothing
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ActivityID", ActivityID)
            dr = db.ExecuteReader("Activities_GetNotesByActivityID")
            Return dr
        End Function

        Public Function GetPublicNotesByActivityID(ByVal ActivityID As Integer) As SqlDataReader
            'This function returns public notes against an activity ID
            Dim dr As SqlDataReader = Nothing
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ActivityID", ActivityID)
            dr = db.ExecuteReader("Activities_GetPublicNotes_ByActivityID")
            Return dr
        End Function
#End Region

    End Class

End Namespace


