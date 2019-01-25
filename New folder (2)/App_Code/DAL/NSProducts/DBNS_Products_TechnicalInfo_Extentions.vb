Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_Products_TechnicalInfo_Extentions
#Region " Public Method "
        'Public Shared Function NS_Products_TechnicalInfo_ExtentionsGetAll() As List(Of Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions)
        '    Dim colNS_Products_TechnicalInfo_Extentions As New List(Of Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions)()
        '    Dim dr As SqlDataReader
        '    Dim db As New DBAccess
        '    dr = db.ExecuteReader("NS_Products_TechnicalInfo_Extentions_GetAll")
        '    While dr.Read()
        '        colNS_Products_TechnicalInfo_Extentions.Add(New Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions( _
        '        CType(dr("ID"), Integer), _
        '        CType(dr("ProductTechnicalInfoID"), Integer), _
        '        CType(dr("ProductFranchiseID"), Integer), _
        '        CType(dr("ContentFilteringPrevious"), Integer), _
        '        CType(dr("ContentFilteringNew"), Integer), _
        '        CType(dr("EnteredBy"), Integer), _
        '        CType(dr("EnteredOn"), Date) _
        '        ))
        '    End While
        '    dr.Close()
        '    Return colNS_Products_TechnicalInfo_Extentions
        'End Function
        'Public Shared Function NS_Products_TechnicalInfo_ExtentionsGetByID(ByVal ID As Integer) As List(Of Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions)
        '    Dim colNS_Products_TechnicalInfo_Extentions As New List(Of Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions)()
        '    Dim dr As SqlDataReader
        '    Dim db As New DBAccess
        '    db.AddParameter("@ID", ID)
        '    dr = db.ExecuteReader("NS_Products_TechnicalInfo_Extentions_GetByID")
        '    While dr.Read()
        '        colNS_Products_TechnicalInfo_Extentions.Add(New Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions( _
        '        CType(dr("ID"), Integer), _
        '        CType(dr("ProductTechnicalInfoID"), Integer), _
        '        CType(dr("ProductFranchiseID"), Integer), _
        '        CType(dr("ContentFilteringPrevious"), Integer), _
        '        CType(dr("ContentFilteringNew"), Integer), _
        '        CType(dr("EnteredBy"), Integer), _
        '        CType(dr("EnteredOn"), Date) _
        '        ))
        '    End While
        '    dr.Close()
        '    Return colNS_Products_TechnicalInfo_Extentions
        'End Function
        Public Function Add(ByVal NS_Products_TechnicalInfo_ExtentionsBll As Portal.BLL.NS.NS_Products_TechnicalInfo_Extentions) As Integer
            Dim db As New DBAccess

            'db.AddParameter("@ID", NS_Products_TechnicalInfo_ExtentionsBll.ID)
            db.AddParameter("@ProductTechnicalInfoID", NS_Products_TechnicalInfo_ExtentionsBll.ProductTechnicalInfoID)
            db.AddParameter("@ProductFranchiseID", NS_Products_TechnicalInfo_ExtentionsBll.ProductFranchiseID)
            db.AddParameter("@ContentFilteringPrevious", NS_Products_TechnicalInfo_ExtentionsBll.ContentFilteringPrevious)
            db.AddParameter("@ContentFilteringNew", NS_Products_TechnicalInfo_ExtentionsBll.ContentFilteringNew)
            db.AddParameter("@EnteredBy", NS_Products_TechnicalInfo_ExtentionsBll.EnteredBy)
            db.AddParameter("@EnteredOn", NS_Products_TechnicalInfo_ExtentionsBll.EnteredOn)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_TechnicalInfo_Extentions_Add")
            Return Affected
        End Function

#End Region

    End Class
End Namespace