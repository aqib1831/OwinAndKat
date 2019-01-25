Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL
    Public Class ClientProducts
        Public Sub ClientProducts()

        End Sub

        Public Function GetClientProductsByFranchiseID(ByVal FranchiseID As Integer, ByVal ClientID As Integer) As DataSet
            Dim accessObj As DBAccess = New DBAccess()
            Dim dsClientProduct As DataSet = Nothing
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            accessObj.AddParameter("@ClientID", ClientID)
            dsClientProduct = accessObj.ExecuteDataSet("Ns_Products_GetByFranchiseID")            
            If (dsClientProduct.Tables.Count = 2) Then
                dsClientProduct.Relations.Add("ProductDetail", dsClientProduct.Tables(0).Columns("ID"), dsClientProduct.Tables(1).Columns("ProductID"))
            End If
            Return dsClientProduct
        End Function

    End Class
End Namespace


