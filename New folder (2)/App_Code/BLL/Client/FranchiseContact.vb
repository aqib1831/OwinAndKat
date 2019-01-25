Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Public Class FranchiseContact
    Public Shared Function IsValidFranchiseContact(ByVal FranchiseID As Integer, ByVal ContactID As Integer, ByVal ClientID As Integer) As Boolean
        Dim db As New DBAccess
        Dim rdr As SqlDataReader
        Dim Exists As Boolean = False

        db.AddParameter("@FranchiseID", FranchiseID)
        db.AddParameter("@ContactID", ContactID)
        db.AddParameter("@ClientID", ClientID)
        rdr = db.ExecuteReader("FranchiseContacts_getFranchiseContactByFranchiseContactAndClientID")
        If rdr.Read() Then
            Exists = True
        End If
        rdr.Close()
        rdr = Nothing
        Return Exists
    End Function
End Class
