Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.Orders
    Public Class DBSCM_Orders
#Region " Public Method "
        Public Shared Function SCM_OrdersGetAll(ByVal ClientID As Integer, ByVal OrdersStatusID As Integer, ByVal StateID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Portal.BLL.Orders.SCM_Orders)
            Dim colSCM_Orders As New List(Of Portal.BLL.Orders.SCM_Orders)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@StatusID", OrdersStatusID)
            db.AddParameter("@StateID", StateID)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            dr = db.ExecuteReader("SCM_Orders_GetAll")
            While dr.Read()
                colSCM_Orders.Add(New Portal.BLL.Orders.SCM_Orders( _
                                   CType(dr("ID"), Integer), _
                                   CType(dr("StoreNumber"), Integer), _
                                   CType(dr("OrderDate"), Date), _
                                   CType(dr("GrandTotal"), Decimal), _
                                   CType(dr("StatusID"), Integer), _
                                   CType(dr("ClientName"), String), _
                                   CType(dr("StoreName"), String), _
                                   CType(dr("OrderStatus"), String)))
            End While
            dr.Close()
            Return colSCM_Orders
        End Function


        Public Shared Function SCM_OrdersHistory_Add(ByVal UserID As Integer, ByVal OrderID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@OrderID", OrderID)
            Return db.ExecuteNonQuery("SCM_Orders_History_Add")
        End Function

        'Public Shared Function SCM_OrdersGetByID(ByVal ID As Integer) As List(Of Portal.BLL.Orders.SCM_Orders)
        '    Dim colSCM_Orders As New List(Of Portal.BLL.Orders.SCM_Orders)()
        '    Dim dr As SqlDataReader
        '    Dim db As New DBAccess
        '    db.AddParameter("@ID", ID)
        '    dr = db.ExecuteReader("SCM_Orders_GetByID")
        '    While dr.Read()
        '        colSCM_Orders.Add(New Portal.BLL.Orders.SCM_Orders( _
        '        CType(dr("ID"), Integer), _
        '        CType(dr("ClientID"), Integer), _
        '        CType(dr("FranchiseID"), Integer), _
        '        CType(dr("StoreNumber"), Integer), _
        '        CType(dr("Address"), String), _
        '        CType(dr("City"), String), _
        '        CType(dr("StateID"), Integer), _
        '        CType(dr("CountryID"), Integer), _
        '        CType(dr("Zip"), String), _
        '        CType(dr("Phone"), String), _
        '        CType(dr("Email"), String), _
        '        CType(dr("OrderDate"), Date), _
        '        CType(dr("PaymentType"), Integer), _
        '        CType(dr("CCType"), Integer), _
        '        CType(dr("BankAccountType"), Integer), _
        '        CType(dr("CCName"), String), _
        '        CType(dr("CCVNumber"), String), _
        '        CType(dr("CCNumber"), String), _
        '        CType(dr("CCExpirationDate"), Date), _
        '        CType(dr("BankName"), String), _
        '        CType(dr("BankAccount"), String), _
        '        CType(dr("BankRouting"), String), _
        '        CType(dr("PrintName"), String), _
        '        CType(dr("GrandTotal"), Decimal), _
        '        CType(dr("TotalWithoutTax"), Decimal), _
        '        CType(dr("TaxAmount"), Decimal), _
        '        CType(dr("StatusID"), Integer) _
        '        ))
        '    End While
        '    dr.Close()
        '    Return colSCM_Orders
        'End Function
        'Public Function Add(ByVal SCM_OrdersBll As Portal.BLL.Orders.SCM_Orders) As Integer
        '    Dim db As New DBAccess

        '    db.AddParameter("@ID", SCM_OrdersBll.ID)
        '    db.AddParameter("@ClientID", SCM_OrdersBll.ClientID)
        '    db.AddParameter("@FranchiseID", SCM_OrdersBll.FranchiseID)
        '    db.AddParameter("@StoreNumber", SCM_OrdersBll.StoreNumber)
        '    db.AddParameter("@Address", SCM_OrdersBll.Address)
        '    db.AddParameter("@City", SCM_OrdersBll.City)
        '    db.AddParameter("@StateID", SCM_OrdersBll.StateID)
        '    db.AddParameter("@CountryID", SCM_OrdersBll.CountryID)
        '    db.AddParameter("@Zip", SCM_OrdersBll.Zip)
        '    db.AddParameter("@Phone", SCM_OrdersBll.Phone)
        '    db.AddParameter("@Email", SCM_OrdersBll.Email)
        '    db.AddParameter("@OrderDate", SCM_OrdersBll.OrderDate)
        '    db.AddParameter("@PaymentType", SCM_OrdersBll.PaymentType)
        '    db.AddParameter("@CCType", SCM_OrdersBll.CCType)
        '    db.AddParameter("@BankAccountType", SCM_OrdersBll.BankAccountType)
        '    db.AddParameter("@CCName", SCM_OrdersBll.CCName)
        '    db.AddParameter("@CCVNumber", SCM_OrdersBll.CCVNumber)
        '    db.AddParameter("@CCNumber", SCM_OrdersBll.CCNumber)
        '    db.AddParameter("@CCExpirationDate", SCM_OrdersBll.CCExpirationDate)
        '    db.AddParameter("@BankName", SCM_OrdersBll.BankName)
        '    db.AddParameter("@BankAccount", SCM_OrdersBll.BankAccount)
        '    db.AddParameter("@BankRouting", SCM_OrdersBll.BankRouting)
        '    db.AddParameter("@PrintName", SCM_OrdersBll.PrintName)
        '    db.AddParameter("@GrandTotal", SCM_OrdersBll.GrandTotal)
        '    db.AddParameter("@TotalWithoutTax", SCM_OrdersBll.TotalWithoutTax)
        '    db.AddParameter("@TaxAmount", SCM_OrdersBll.TaxAmount)
        '    db.AddParameter("@StatusID", SCM_OrdersBll.StatusID)

        '    Dim Affected As Integer = db.ExecuteNonQuery(" ")
        '    Return Affected
        'End Function
#End Region

    End Class
End Namespace