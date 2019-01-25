Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.NS
    Public Class DBNS_Products_Franchises
#Region " Public Method "
        Public Shared Function NS_Products_FranchisesGetAllForSMS(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As List(Of Portal.BLL.NS.NS_Products_Franchises)
            Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)

            dr = db.ExecuteReader("NS_Products_Franchises_GetAll")
            While dr.Read()
                colNS_Products_Franchises.Add(New Portal.BLL.NS.NS_Products_Franchises( _
                CType(dr("ID"), Integer), _
                CType(dr("ProductID"), Integer), _
                CType(dr("FranchiseID"), Integer), _
                CType(dr("IP"), String), _
                CType(dr("Version"), String), _
                CType(dr("LastUpdateDate"), DateTime), _
                CType(dr("ServerUserName"), String), _
                CType(dr("ServerPassword"), String), _
                CType(dr("NoOfLicenses"), Integer), _
                CType(dr("CCPaymentGateway"), Integer), _
                CType(dr("CCMerchantID"), Integer), _
                CType(dr("CCMerchantPassword"), String), _
                CType(dr("onSupport"), Boolean), _
                CType(dr("SupportStartDate"), DateTime), _
                CType(dr("SupportEnddate"), DateTime), _
                CType(dr("WaivedMonths"), Integer), _
                CType(dr("NoOfLiveTerminals"), Integer), _
                CType(dr("UpdatedBy"), Integer), _
                CType(dr("UpdatedOn"), DateTime), _
                CType(dr("Inactive"), Boolean), _
                CType(dr("Notes"), String), _
                CType(dr("IsStaticIP"), Boolean), _
                CType(dr("Price"), Decimal), _
                CType(dr("StoreNumber"), Integer), _
                CType(dr("StoreNick"), String), _
                CType(dr("ClientCode"), String) _
                ))
            End While
            dr.Close()
            Return colNS_Products_Franchises
        End Function
        Public Shared Function NS_Products_FranchisesGetAllForSMS_BYLMRights(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal UserID As Integer) As List(Of Portal.BLL.NS.NS_Products_Franchises)
            Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@UserID", UserID)
            dr = db.ExecuteReader("NS_Products_Franchises_GetAll_ByLMRights")
            While dr.Read()
                colNS_Products_Franchises.Add(New Portal.BLL.NS.NS_Products_Franchises( _
                CType(dr("ID"), Integer), _
                CType(dr("ProductID"), Integer), _
                CType(dr("FranchiseID"), Integer), _
                CType(dr("IP"), String), _
                CType(dr("Version"), String), _
                CType(dr("LastUpdateDate"), DateTime), _
                CType(dr("ServerUserName"), String), _
                CType(dr("ServerPassword"), String), _
                CType(dr("NoOfLicenses"), Integer), _
                CType(dr("CCPaymentGateway"), Integer), _
                CType(dr("CCMerchantID"), Integer), _
                CType(dr("CCMerchantPassword"), String), _
                CType(dr("onSupport"), Boolean), _
                CType(dr("SupportStartDate"), DateTime), _
                CType(dr("SupportEnddate"), DateTime), _
                CType(dr("WaivedMonths"), Integer), _
                CType(dr("NoOfLiveTerminals"), Integer), _
                CType(dr("UpdatedBy"), Integer), _
                CType(dr("UpdatedOn"), DateTime), _
                CType(dr("Inactive"), Boolean), _
                CType(dr("Notes"), String), _
                CType(dr("IsStaticIP"), Boolean), _
                CType(dr("Price"), Decimal), _
                CType(dr("StoreNumber"), Integer), _
                CType(dr("StoreNick"), String), _
                CType(dr("ClientCode"), String) _
                ))
            End While
            dr.Close()
            Return colNS_Products_Franchises
        End Function
        Public Shared Function NS_Products_FranchisesGetAllCountForSMS(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer) As Integer
            Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@searchtxt", search)
            Return CInt(db.ExecuteScalar("NS_Products_Franchises_GetAllCount"))
        End Function
        Public Shared Function NS_Products_FranchisesGetAllCountForSMS_ByLMRights(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal ProductID As Integer, ByVal UserID As Integer) As Integer
            Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@UserID", UserID)
            Return CInt(db.ExecuteScalar("NS_Products_Franchises_GetAllCount_ByLMRights"))
        End Function
        Public Shared Function NS_Products_FranchisesGetAllForSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer, ByVal OnSupport As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
            'Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim dt As DataTable
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@StoreStatusID", StoreStatus)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@OnSupport", OnSupport)
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)

            dt = db.ExecuteDataTable("NS_Products_Franchises_GetAllSupport")
            Return dt
        End Function
        Public Shared Function NS_Products_FranchisesGetAllCountForSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer, ByVal OnSupport As Integer) As Integer
            Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@StoreStatusID", StoreStatus)
            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@OnSupport", OnSupport)
            db.AddParameter("@searchtxt", search)
            Return CInt(db.ExecuteScalar("NS_Products_Franchises_GetAllSupportCount"))
        End Function
        'Public Shared Function NS_Products_FranchisesGetAllForNotSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataTable
        '    'Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
        '    Dim dt As DataTable
        '    Dim db As New DBAccess
        '    db.AddParameter("@ClientID", ClientID)
        '    db.AddParameter("@Inactive", Inactive)
        '    db.AddParameter("@StoreID", StoreID)
        '    db.AddParameter("@StoreStatusID", StoreStatus)
        '    db.AddParameter("@ProductID", ProductID)
        '    db.AddParameter("@searchtxt", search)
        '    db.AddParameter("@sortExpression", sortBy)
        '    db.AddParameter("@startRowIndex", startRowIndex)
        '    db.AddParameter("@maximumRows", maximumRows)
        '    dt = db.ExecuteDataTable("NS_Products_Franchises_GetAllSupport")
        '    Return dt
        'End Function
        'Public Shared Function NS_Products_FranchisesGetAllCountForNotSupport(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal StoreStatus As Integer, ByVal ProductID As Integer) As Integer
        '    Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
        '    Dim db As New DBAccess
        '    db.AddParameter("@ClientID", ClientID)
        '    db.AddParameter("@Inactive", Inactive)
        '    db.AddParameter("@StoreID", StoreID)
        '    db.AddParameter("@StoreStatusID", StoreStatus)
        '    db.AddParameter("@ProductID", ProductID)
        '    db.AddParameter("@searchtxt", search)
        '    Return CInt(db.ExecuteScalar("NS_Products_Franchises_GetAllSupportCount"))
        'End Function
        Public Shared Function NS_Products_FranchisesGetAllForNotSupportForHelpDesk(ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As List(Of Portal.BLL.NS.NS_Products_Franchises)
            Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)

            dr = db.ExecuteReader("com_NS_Product_Franchises_SupportEndDate")
            While dr.Read()
                colNS_Products_Franchises.Add(New Portal.BLL.NS.NS_Products_Franchises( _
                CType(dr("ProductsFranchisesID"), Integer), _
                CType(dr("ProductID"), Integer), _
                CType(dr("FranchiseID"), Integer), _
                CType(dr("onSupport"), Boolean), _
                CType(dr("SupportEnddate"), DateTime), _
                CType(dr("StoreNumber"), Integer), _
                CType(dr("StoreNick"), String), _
                CType(dr("ClientID"), String), _
                CType(dr("ProductName"), String) _
                ))
            End While
            dr.Close()
            Return colNS_Products_Franchises
        End Function
        Public Shared Function NS_Products_FranchisesGetAllCountForNotSupportForHelpDesk() As Integer
            Dim colNS_Products_Franchises As New List(Of Portal.BLL.NS.NS_Products_Franchises)()
            Dim db As New DBAccess
            Return CInt(db.ExecuteScalar("com_NS_Product_Franchises_SupportEndDateCount"))
        End Function
        Public Shared Function NS_Products_FranchisesGetByID(ByVal ID As Integer) As Portal.BLL.NS.NS_Products_Franchises
            Dim colNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("NS_Products_Franchises_GetByID")
            If dr.HasRows Then
                While dr.Read()
                    colNS_Products_Franchises.ID = CType(dr("ID"), Integer)
                    colNS_Products_Franchises.ProductID = CType(dr("ProductID"), Integer)
                    colNS_Products_Franchises.FranchiseID = CType(dr("FranchiseID"), Integer)
                    colNS_Products_Franchises.FransupportFranchiseID = CType(dr("FransupportFranchiseID"), Integer)
                    colNS_Products_Franchises.IP = CType(dr("IP"), String)
                    colNS_Products_Franchises.Version = CType(dr("Version"), String)
                    colNS_Products_Franchises.LastUpdateDate = CType(dr("LastUpdateDate"), DateTime)
                    colNS_Products_Franchises.ServerUserName = CType(dr("ServerUserName"), String)
                    colNS_Products_Franchises.ServerPassword = CType(dr("ServerPassword"), String)
                    colNS_Products_Franchises.NoOfLicenses = CType(dr("NoOfLicenses"), Integer)
                    colNS_Products_Franchises.CCPaymentGateway = CType(dr("CCPaymentGateway"), Integer)
                    colNS_Products_Franchises.CCMerchantID = CType(dr("CCMerchantID"), Integer)
                    colNS_Products_Franchises.CCMerchantPassword = CType(dr("CCMerchantPassword"), String)
                    colNS_Products_Franchises.onSupport = CType(dr("onSupport"), Boolean)
                    colNS_Products_Franchises.SupportStartDate = CType(dr("SupportStartDate"), DateTime)
                    colNS_Products_Franchises.SupportEnddate = CType(dr("SupportEnddate"), DateTime)
                    colNS_Products_Franchises.WaivedMonths = CType(dr("WaivedMonths"), Integer)
                    colNS_Products_Franchises.NoOfLiveTerminals = CType(dr("NoOfLiveTerminals"), Integer)
                    colNS_Products_Franchises.UpdatedBy = CType(dr("UpdatedBy"), Integer)
                    colNS_Products_Franchises.UpdatedOn = CType(dr("UpdatedOn"), DateTime)
                    colNS_Products_Franchises.Inactive = CType(dr("Inactive"), Boolean)
                    colNS_Products_Franchises.Notes = CType(dr("Notes"), String)
                    colNS_Products_Franchises.IsStaticIP = CType(dr("IsStaticIP"), Boolean)
                    colNS_Products_Franchises.Price = CType(dr("Price"), Decimal)
                    colNS_Products_Franchises.StoreNumber = CType(dr("StoreNumber"), Integer)
                    colNS_Products_Franchises.StoreNick = CType(dr("StoreNick"), String)
                    colNS_Products_Franchises.ClientCode = CType(dr("ClientName"), String)
                    colNS_Products_Franchises.ClientID = CType(dr("ClientId"), Integer)
                    colNS_Products_Franchises.UpdatedByName = CType(dr("UpdatedByName"), String)
                    colNS_Products_Franchises.InstallationDate = CType(Functions.IfNull(dr("InstallationDate"), Date.MinValue), DateTime)
                    colNS_Products_Franchises.SMTPPort = dr("SMTPPort")
                    colNS_Products_Franchises.OSVersionID = IIf(dr("OSVersionID") Is DBNull.Value, 0, CInt(dr("OSVersionID")))
                End While
            End If
            dr.Close()
            Return colNS_Products_Franchises
        End Function
        Public Shared Function NS_Products_FranchisesGetByFranID_ProductID(ByVal FranchiseID As Integer, ByVal ProductID As Integer) As Portal.BLL.NS.NS_Products_Franchises
            Dim colNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductID", ProductID)
            dr = db.ExecuteReader("NS_Products_Franchises_GetByFranID_ProductID")
            If dr.HasRows Then
                While dr.Read()
                    colNS_Products_Franchises.ID = CType(dr("ID"), Integer)
                    colNS_Products_Franchises.ProductID = CType(dr("ProductID"), Integer)
                    colNS_Products_Franchises.FranchiseID = CType(dr("FranchiseID"), Integer)
                    colNS_Products_Franchises.onSupport = CType(dr("onSupport"), Boolean)
                    colNS_Products_Franchises.SupportStartDate = CType(dr("SupportStartDate"), DateTime)
                    colNS_Products_Franchises.SupportEnddate = CType(dr("SupportEnddate"), DateTime)
                    colNS_Products_Franchises.Inactive = CType(dr("Inactive"), Boolean)
                    colNS_Products_Franchises.Notes = CType(dr("Notes"), String)
                    colNS_Products_Franchises.Price = CType(dr("Price"), Decimal)
                    'colNS_Products_Franchises.StoreNumber = CType(dr("StoreNumber"), Integer)
                End While
            End If
            dr.Close()
            Return colNS_Products_Franchises
        End Function
        Public Function Add(ByVal ProductID As Integer, ByVal FranchiseID As Integer, ByVal onSupport As Boolean, ByVal SupportStartDate As Date, ByVal SupportEnddate As Date, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date, ByVal Inactive As Boolean, ByVal Notes As String, ByVal Price As Decimal, ByVal NoOfLicenses As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ProductID", ProductID)
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@onSupport", onSupport)
            db.AddParameter("@SupportStartDate", SupportStartDate)
            db.AddParameter("@SupportEnddate", SupportEnddate)
			If (NoOfLicenses <> Integer.MinValue) Then
                db.AddParameter("@NoofLicenses", NoOfLicenses)
            End If
            db.AddParameter("@UpdatedBy", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@UpdatedOn", DateTime.Now)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@Notes", Notes)
            db.AddParameter("@Price", Price)

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Franchises_AddSupport")
            Return Affected
        End Function
        Public Function Update(ByVal ID As Integer, ByVal IP As String, ByVal ServerUserName As String, ByVal ServerPassword As String, ByVal NoOfLicenses As Integer, ByVal Notes As String, ByVal IsStaticIP As Boolean, ByVal CCPaymentGateway As Integer, ByVal CCMerchantID As Integer, ByVal CCMerchantPassword As String, ByVal InstallationDate As Date, ByVal SMTPPort As Integer, ByVal OSVersionID As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            'db.AddParameter("@ProductID", ProductID)
            'db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@IP", IP)
            'db.AddParameter("@Version", Version)
            'db.AddParameter("@LastUpdateDate", LastUpdateDate)
            db.AddParameter("@ServerUserName", ServerUserName)
            db.AddParameter("@ServerPassword", ServerPassword)
            db.AddParameter("@NoOfLicenses", NoOfLicenses)
            db.AddParameter("@CCPaymentGateway", CCPaymentGateway)
            db.AddParameter("@CCMerchantID", CCMerchantID)
            db.AddParameter("@CCMerchantPassword", CCMerchantPassword)
            'db.AddParameter("@onSupport", onSupport)
            'db.AddParameter("@SupportStartDate", SupportStartDate)
            'db.AddParameter("@SupportEnddate", SupportEnddate)
            'db.AddParameter("@WaivedMonths", WaivedMonths)
            'db.AddParameter("@NoOfLiveTerminals", NoOfLiveTerminals)
            db.AddParameter("@UpdatedBy", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@UpdatedOn", DateTime.Now)
            'db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@Notes", Notes)
            db.AddParameter("@IsStaticIP", IsStaticIP)
            db.AddParameter("@SMTPPort", SMTPPort)
			If (InstallationDate = DateTime.MinValue) Then
                db.AddParameter("@InstallationDate", DBNull.Value)
            Else
                db.AddParameter("@InstallationDate", InstallationDate)
            End If
            If OSVersionID = 0 Then
                db.AddParameter("@OSVersionID", DBNull.Value)
            Else
                db.AddParameter("@OSVersionID", OSVersionID)
            End If

            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Franchises_Update")
            Return Affected
        End Function
        Public Function UpdateSupport(ByVal ID As Integer, ByVal onSupport As Boolean, ByVal SupportStartDate As Date, ByVal SupportEnddate As Date, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date, ByVal Inactive As Boolean, ByVal Notes As String, ByVal Price As Decimal, ByVal NoOfLicenses As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@onSupport", onSupport)
            db.AddParameter("@SupportStartDate", SupportStartDate)
            db.AddParameter("@SupportEnddate", SupportEnddate)
            db.AddParameter("@UpdatedBy", UpdatedBy)
            db.AddParameter("@UpdatedOn", UpdatedOn)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@Notes", Notes)
            db.AddParameter("@Price", Price)
            If (NoOfLicenses <> Integer.MinValue) Then
                db.AddParameter("@NoofLicenses", NoOfLicenses)
            End If
            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Franchises_UpdateSupportTurnOn")
            Return Affected
        End Function
        Public Function UpdateSupport(ByVal ID As Integer, ByVal SupportEnddate As Date, ByVal UpdatedBy As Integer, ByVal UpdatedOn As Date) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@SupportEnddate", SupportEnddate)
            db.AddParameter("@UpdatedBy", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@UpdatedOn", DateTime.Now)
            
            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Franchises_UpdateSupport")
            Return Affected
        End Function
        Public Shared Function NS_Products_CheckDuplicateProduct(ByVal ID As Integer, ByVal FranchiseID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@FranchiseID", FranchiseID)
            Return CInt(db.ExecuteScalar("NS_Products_Franchises_CheckDuplicateProduct"))
        End Function
        Public Shared Function NS_Products_CheckParentProduct(ByVal ID As Integer, ByVal FranchiseID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            db.AddParameter("@FranchiseID", FranchiseID)
            Return CInt(db.ExecuteScalar("NS_Products_Franchises_CheckParentProduct"))
        End Function
        Public Shared Function NS_Products_CheckFranchisesInReportRecords(ByVal FranchiseID As Integer) As Integer
            Dim db As New DBAccess
            db.AddParameter("@FranchiseID", FranchiseID)
            Return CInt(db.ExecuteScalar("NS_Products_Franchises_CheckFranchisesInReportRecords"))
        End Function
        Public Shared Function NS_Products_CheckDatesInReportDeatil(ByVal FranchiseID As Integer, ByVal ProductID As Integer) As Portal.BLL.NS.NS_Products_Franchises
            Dim colNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ProductID", ProductID)
            dr = db.ExecuteReader("NS_Products_Franchises_CheckDatesInReportDeatil")
            If dr.HasRows Then
                While dr.Read()
                    colNS_Products_Franchises.SupportStartDate = CType(Functions.IfNull(dr("MinBillingFrom"), Date.MaxValue), DateTime)
                    colNS_Products_Franchises.SupportEnddate = CType(Functions.IfNull(dr("MaxBillingTo"), Date.MinValue), DateTime)
                End While
            End If
            dr.Close()
            Return colNS_Products_Franchises
        End Function
        
        
        ''Public Shared Function GetClientProductsReport(ByVal ReqStartDate As DateTime, ByVal ReqEndDate As DateTime, ByVal ClientID As Integer) As DataSet
        ''    Dim accessObj As DBAccess = New DBAccess()
        ''    Dim dsClientProduct As DataSet = Nothing
        ''    accessObj.AddParameter("@ReqStartDate", ReqStartDate)
        ''    accessObj.AddParameter("@ReqEndDate", ReqEndDate)
        ''    accessObj.AddParameter("@ClientID", ClientID)
        ''    dsClientProduct = accessObj.ExecuteDataSet("Ns_Products_FranchisesGetReport")
        ''    If (dsClientProduct.Tables.Count = 2) Then
        ''        dsClientProduct.Relations.Add("Product", dsClientProduct.Tables(1).Columns("ProductID"), dsClientProduct.Tables(2).Columns("ProductID"))
        ''    ElseIf (dsClientProduct.Tables.Count = 3) Then
        ''        dsClientProduct.Relations.Add("Product", dsClientProduct.Tables(1).Columns("ProductID"), dsClientProduct.Tables(2).Columns("ProductID"))
        ''        dsClientProduct.Relations.Add("StoreDetail", dsClientProduct.Tables(0).Columns("FranchiseID"), dsClientProduct.Tables(2).Columns("FranchiseID"))
        ''    End If
        ''    Return dsClientProduct
        ''End Function
        ''Public Shared Function GetClientHeaderProducts(ByVal ReqStartDate As DateTime, ByVal ReqEndDate As DateTime, ByVal ClientID As Integer) As DataTable
        ''    Dim accessObj As DBAccess = New DBAccess()
        ''    Dim dsClientProduct As DataSet = Nothing
        ''    accessObj.AddParameter("@ReqStartDate", ReqStartDate)
        ''    accessObj.AddParameter("@ReqEndDate", ReqEndDate)
        ''    accessObj.AddParameter("@ClientID", ClientID)
        ''    dsClientProduct = accessObj.ExecuteDataSet("Ns_Products_FranchisesGetReport")
        ''    If (dsClientProduct.Tables.Count = 2) Then
        ''        dsClientProduct.Relations.Add("Product", dsClientProduct.Tables(1).Columns("ProductID"), dsClientProduct.Tables(2).Columns("ProductID"))
        ''    ElseIf (dsClientProduct.Tables.Count = 3) Then
        ''        dsClientProduct.Relations.Add("Product", dsClientProduct.Tables(1).Columns("ProductID"), dsClientProduct.Tables(2).Columns("ProductID"))
        ''        dsClientProduct.Relations.Add("StoreDetail", dsClientProduct.Tables(0).Columns("FranchiseID"), dsClientProduct.Tables(2).Columns("FranchiseID"))
        ''    End If
        ''    Return dsClientProduct.Tables(1)
        ''End Function

        Public Shared Function NS_Products_FranchisesGetbyFranchiseID(ByVal FranchiseID As Integer) As DataSet
            Dim ds As DataSet
            Dim db As New DBAccess
            db.AddParameter("@FranchiseID", FranchiseID)
            ds = db.ExecuteDataSet("NS_Products_Franchises_GetByFranchiseID")
            Return ds
        End Function
        Public Shared Function NS_Products_Franchises_IsExist(ByVal ProductID As Integer, ByVal FranchiseID As Integer) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@ID", ProductID)
            db.AddParameter("@FranchiseID", FranchiseID)
            Dim result As Integer = 0
            result = CType(db.ExecuteScalar("NS_Products_Franchises_CheckProduct"), Int32)
            If result = 0 Then
                Return False
            End If
            Return True
        End Function

        Public Shared Function GetSMSInfoByFranchiseID(ByVal FranchiseID As Integer) As DataSet
            Dim ObjDBAccess As DBAccess = New DBAccess()
            ObjDBAccess.AddParameter("@FranchiseID", FranchiseID)
            Return ObjDBAccess.ExecuteDataSet("WS_NS_Products_Franchises_GetSMSInfoByFranchiseID")
        End Function

 	Public Function Update_DM(ByVal ID As Integer, ByVal IP As String, ByVal IsStaticIP As Boolean) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@IP", IP)
            db.AddParameter("@IsStaticIP", IsStaticIP)
            db.AddParameter("@UpdatedBy", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@UpdatedOn", DateTime.Now)
            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Franchises_Update_DMIPinfo")
            Return Affected
        End Function


 	Public Function Update_nxStep(ByVal ID As Integer, ByVal IP As String, ByVal IsStaticIP As Boolean) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            db.AddParameter("@IP", IP)
            db.AddParameter("@IsStaticIP", IsStaticIP)
            db.AddParameter("@UpdatedBy", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@UpdatedOn", DateTime.Now)
            Dim Affected As Integer = db.ExecuteNonQuery("NS_Products_Franchises_Update_nxStepIPinfo")
            Return Affected
        End Function

#End Region

    End Class
End Namespace