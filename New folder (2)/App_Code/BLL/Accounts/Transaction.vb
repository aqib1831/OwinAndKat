Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL.Accounts
    Public Class Transaction
        Public Function AddTransaction(ByVal orderID As Integer, _
                                           ByVal Amount As Decimal, _
                                           ByVal PaymentOption As Integer, _
                                           ByVal CCNumber As String, _
                                           ByVal Service As String, _
                                           ByVal Notes As String) As String

            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@ServiceRef", orderID)
            accessObj.AddParameter("@Amount", Amount)
            accessObj.AddParameter("@PaymentOption", PaymentOption)
            accessObj.AddParameter("@RefNo", CCNumber)
            accessObj.AddParameter("@Service", Service)
            accessObj.AddParameter("@Notes", Notes)
            accessObj.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
            Return accessObj.ExecuteNonQuery("Transactions_ADD")
        End Function
    End Class
End Namespace

