Imports Microsoft.VisualBasic
Imports Portal.BLL.PM

Namespace Portal.DAL.PM
    Public Class DBPM_Survey_Result

        Public Shared Sub ADD(ByVal objSuveyResult As PM_Survey_Result)
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@Ticket_Feature_Id", objSuveyResult.Ticket_Feature_id)
            objDBAccess.AddParameter("@ClientContactId", objSuveyResult.ClientContactid)
            objDBAccess.AddParameter("@Answer1", objSuveyResult.Answer1)
            objDBAccess.AddParameter("@Answer2", objSuveyResult.Answer2)
            objDBAccess.AddParameter("@Answer3", objSuveyResult.Answer3)
            objDBAccess.AddParameter("@Answer4", objSuveyResult.Answer4)
            objDBAccess.AddParameter("@Answer5", objSuveyResult.Answer5)
            objDBAccess.AddParameter("@Answer6", Functions.ConvertToDbNull(objSuveyResult.Answer6))
            objDBAccess.AddParameter("@Comments", Functions.ConvertToDbNull(objSuveyResult.Comments))
            objDBAccess.AddParameter("@Signature", objSuveyResult.Signature)
            objDBAccess.ExecuteNonQuery("PM_Survey_Result_Add")
        End Sub

    End Class
End Namespace

