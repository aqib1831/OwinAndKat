Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_Products_TechnicalInfo
#Region " Public Method "
        
        Public Shared Function NS_Products_TechnicalInfoGetByProductFranchiseID(ByVal ProductFranchiseID As Integer) As List(Of Portal.BLL.NS.NS_Products_TechnicalInfo)
            Dim colNS_Products_TechnicalInfo As New List(Of Portal.BLL.NS.NS_Products_TechnicalInfo)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ProductFranchiseID", ProductFranchiseID)
            dr = db.ExecuteReader("NS_Products_TechnicalInfo_GetByProductFranchiseID")
            While dr.Read()
                colNS_Products_TechnicalInfo.Add(New Portal.BLL.NS.NS_Products_TechnicalInfo( _
                CType(dr("ID"), Integer), _
                CType(dr("ProductFranchiseID"), Integer), _
                CType(dr("ISPType"), String), _
                CType(dr("PrimaryDNS"), String), _
                CType(dr("SecondaryDNS"), String), _
                CType(dr("ISPPassword"), String), _
                CType(dr("ISPUserName"), String), _
                CType(dr("FirewallRouter"), String), _
                CType(dr("FirewallRouterAccess"), String), _
                CType(dr("FirewallRouterLogin"), String), _
                CType(dr("DeliveryCharge"), Decimal), _
                CType(dr("DeliveryChargeVAT"), Decimal), _
                CType(dr("MerchantNo"), String), _
                CType(dr("AuthLogin"), String), _
                CType(dr("CCLogin"), String), _
                CType(dr("CCPassword"), String), _
                CType(dr("TagPrinting"), Boolean), _
                CType(dr("HouseCharge"), Boolean), _
                CType(dr("HouseChargeAmount"), Decimal), _
                CType(dr("SMSAutoDiscount"), Decimal), _
                CType(dr("TaxRate"), Decimal), _
                CType(dr("ContentFiltering"), Integer) _
                ))
            End While
            dr.Close()
            Return colNS_Products_TechnicalInfo
        End Function
        Public Function AddOrUpdate(ByVal NS_Products_TechnicalInfoBll As Portal.BLL.NS.NS_Products_TechnicalInfo) As Integer
            Dim db As New DBAccess

            'db.AddParameter("@ID", NS_Products_TechnicalInfoBll.ID)
            db.AddParameter("@ProductFranchiseID", NS_Products_TechnicalInfoBll.ProductFranchiseID)
            db.AddParameter("@ISPType", IIf(NS_Products_TechnicalInfoBll.ISPType = "", DBNull.Value, NS_Products_TechnicalInfoBll.ISPType))
            db.AddParameter("@PrimaryDNS", IIf(NS_Products_TechnicalInfoBll.PrimaryDNS = "", DBNull.Value, NS_Products_TechnicalInfoBll.PrimaryDNS))
            db.AddParameter("@SecondaryDNS", IIf(NS_Products_TechnicalInfoBll.SecondaryDNS = "", DBNull.Value, NS_Products_TechnicalInfoBll.SecondaryDNS))
            db.AddParameter("@ISPPassword", IIf(NS_Products_TechnicalInfoBll.ISPPassword = "", DBNull.Value, NS_Products_TechnicalInfoBll.ISPPassword))
            db.AddParameter("@ISPUserName", IIf(NS_Products_TechnicalInfoBll.ISPUserName = "", DBNull.Value, NS_Products_TechnicalInfoBll.ISPUserName))
            db.AddParameter("@FirewallRouter", IIf(NS_Products_TechnicalInfoBll.FirewallRouter = "", DBNull.Value, NS_Products_TechnicalInfoBll.FirewallRouter))
            db.AddParameter("@FirewallRouterAccess", IIf(NS_Products_TechnicalInfoBll.FirewallRouterAccess = "", DBNull.Value, NS_Products_TechnicalInfoBll.FirewallRouterAccess))
            db.AddParameter("@FirewallRouterLogin", IIf(NS_Products_TechnicalInfoBll.FirewallRouterLogin = "", DBNull.Value, NS_Products_TechnicalInfoBll.FirewallRouterLogin))
            db.AddParameter("@DeliveryCharge", NS_Products_TechnicalInfoBll.DeliveryCharge)
            db.AddParameter("@DeliveryChargeVAT", NS_Products_TechnicalInfoBll.DeliveryChargeVAT)
            db.AddParameter("@MerchantNo", IIf(NS_Products_TechnicalInfoBll.MerchantNo = "", DBNull.Value, NS_Products_TechnicalInfoBll.MerchantNo))
            db.AddParameter("@AuthLogin", IIf(NS_Products_TechnicalInfoBll.AuthLogin = "", DBNull.Value, NS_Products_TechnicalInfoBll.AuthLogin))
            db.AddParameter("@CCLogin", IIf(NS_Products_TechnicalInfoBll.CCLogin = "", DBNull.Value, NS_Products_TechnicalInfoBll.CCLogin))
            db.AddParameter("@CCPassword", IIf(NS_Products_TechnicalInfoBll.CCPassword = "", DBNull.Value, NS_Products_TechnicalInfoBll.CCPassword))
            db.AddParameter("@TagPrinting", NS_Products_TechnicalInfoBll.TagPrinting)
            db.AddParameter("@HouseCharge", NS_Products_TechnicalInfoBll.HouseCharge)
            db.AddParameter("@HouseChargeAmount", NS_Products_TechnicalInfoBll.HouseChargeAmount)
            db.AddParameter("@SMSAutoDiscount", NS_Products_TechnicalInfoBll.SMSAutoDiscount)
            db.AddParameter("@TaxRate", NS_Products_TechnicalInfoBll.TaxRate)
            db.AddParameter("@ContentFiltering", NS_Products_TechnicalInfoBll.ContentFiltering)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, 0)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_TechnicalInfo_AddOrUpdate")
            Affected = CInt(CType(db.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Return Affected
        End Function

#End Region

    End Class
End Namespace