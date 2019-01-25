Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.Orders
    Public Class DBSCM_OrderItems
#Region " Public Method "
        'Public Shared Function SCM_OrderItemsGetAll() As List(Of Portal.BLL.Orders.SCM_OrderItems)
        '    Dim colSCM_OrderItems As New List(Of Portal.BLL.Orders.SCM_OrderItems)()
        '    Dim dr As SqlDataReader
        '    Dim db As New DBAccess
        '    dr = db.ExecuteReader("SCM_OrderItems_GetAll")
        '    While dr.Read()
        '        colSCM_OrderItems.Add(New Portal.BLL.Orders.SCM_OrderItems( _
        '        CType(dr("ID"), Integer), _
        '        CType(dr("OrderID"), Integer), _
        '        CType(dr("ProductID"), Integer), _
        '        CType(dr("Quantity"), Integer), _
        '        CType(dr("UnitPrice"), Decimal), _
        '        CType(dr("TotalPrice"), Decimal) _
        '        ))
        '    End While
        '    dr.Close()
        '    Return colSCM_OrderItems
        'End Function
        'Public Shared Function SCM_OrderItemsGetByID(ByVal ID As Integer) As List(Of Portal.BLL.Orders.SCM_OrderItems)
        '    Dim colSCM_OrderItems As New List(Of Portal.BLL.Orders.SCM_OrderItems)()
        '    Dim dr As SqlDataReader
        '    Dim db As New DBAccess
        '    db.AddParameter("@ID", ID)
        '    dr = db.ExecuteReader("SCM_OrderItems_GetByID")
        '    While dr.Read()
        '        colSCM_OrderItems.Add(New Portal.BLL.Orders.SCM_OrderItems( _
        '        CType(dr("ID"), Integer), _
        '        CType(dr("OrderID"), Integer), _
        '        CType(dr("ProductID"), Integer), _
        '        CType(dr("Quantity"), Integer), _
        '        CType(dr("UnitPrice"), Decimal), _
        '        CType(dr("TotalPrice"), Decimal) _
        '        ))
        '    End While
        '    dr.Close()
        '    Return colSCM_OrderItems
        'End Function
        'Public Function Add(ByVal SCM_OrderItemsBll As Portal.BLL.Orders.SCM_OrderItems) As Integer
        '    Dim db As New DBAccess

        '    db.AddParameter("@ID", SCM_OrderItemsBll.ID)
        '    db.AddParameter("@OrderID", SCM_OrderItemsBll.OrderID)
        '    db.AddParameter("@ProductID", SCM_OrderItemsBll.ProductID)
        '    db.AddParameter("@Quantity", SCM_OrderItemsBll.Quantity)
        '    db.AddParameter("@UnitPrice", SCM_OrderItemsBll.UnitPrice)
        '    db.AddParameter("@TotalPrice", SCM_OrderItemsBll.TotalPrice)

        '    Dim Affected As Integer = db.ExecuteNonQuery(" ")
        '    Return Affected
        'End Function

#End Region

    End Class
End Namespace