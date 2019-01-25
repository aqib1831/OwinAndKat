Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_Products_Franchises_Extentions
#Region " Public Method "

        Public Shared Function NS_Products_Franchises_ExtentionsGetByID(ByVal ID As Integer) As List(Of Portal.BLL.NS.NS_Products_Franchises_Extentions)
            Dim colNS_Products_Franchises_Extentions As New List(Of Portal.BLL.NS.NS_Products_Franchises_Extentions)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("NS_Products_Franchises_Extentions_GetByID")
            While dr.Read()
                colNS_Products_Franchises_Extentions.Add(New Portal.BLL.NS.NS_Products_Franchises_Extentions( _
                CType(dr("ID"), Integer), _
                CType(dr("ProductID"), Integer), _
                CType(dr("FranchiseID"), Integer), _
                CType(dr("ExtendedFromDate"), Date), _
                CType(dr("ExtendedToDate"), Date), _
                CType(dr("SupportStartDate"), Date), _
                CType(dr("SupportEndDate"), Date), _
                CType(dr("UpdatedBy"), Integer), _
                CType(dr("UpdatedOn"), Date), _
                CType(dr("Price"), Decimal), _
                CType(dr("OnSupport"), Boolean), _
                CType(dr("Type"), Integer), _
                CType(dr("Notes"), String) _
                ))
            End While
            dr.Close()
            Return colNS_Products_Franchises_Extentions
        End Function
        Public Function Add(ByVal NS_Products_Franchises_ExtentionsBll As Portal.BLL.NS.NS_Products_Franchises_Extentions) As Integer
            Dim db As New DBAccess

            'db.AddParameter("@ID", NS_Products_Franchises_ExtentionsBll.ID)
            db.AddParameter("@ProductID", NS_Products_Franchises_ExtentionsBll.ProductID)
            db.AddParameter("@FranchiseID", NS_Products_Franchises_ExtentionsBll.FranchiseID)
            db.AddParameter("@ExtendedFromDate", NS_Products_Franchises_ExtentionsBll.ExtendedFromDate)
            db.AddParameter("@ExtendedToDate", NS_Products_Franchises_ExtentionsBll.ExtendedToDate)
            db.AddParameter("@SupportStartDate", NS_Products_Franchises_ExtentionsBll.SupportStartDate)
            db.AddParameter("@SupportEndDate", NS_Products_Franchises_ExtentionsBll.SupportEndDate)
            db.AddParameter("@UpdatedBy", NS_Products_Franchises_ExtentionsBll.UpdatedBy)
            db.AddParameter("@UpdatedOn", NS_Products_Franchises_ExtentionsBll.UpdatedOn)
            db.AddParameter("@Price", NS_Products_Franchises_ExtentionsBll.Price)
            db.AddParameter("@OnSupport", NS_Products_Franchises_ExtentionsBll.OnSupport)
            db.AddParameter("@Notes", NS_Products_Franchises_ExtentionsBll.Notes)
            db.AddParameter("@Type", NS_Products_Franchises_ExtentionsBll.Type)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Franchises_Extentions_Add")
            Return Affected
        End Function

#End Region

    End Class
End Namespace