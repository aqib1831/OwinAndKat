Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Public Class Support

#Region "Local Variables"

    Private Shared l_RecCount As Integer

    Protected l_StoreNo As Integer
    Protected l_StoreName As String
    Private l_WorkPhone As String
    Private l_OnSupport As Boolean
    Private l_OnBackup As Boolean
    Private l_FromDate As Date
    Private l_ToDate As Date
    Private l_MonthlyCharges As Integer
    Private l_SupportType As Portal.BLL.Enumeration.Support_Type
    Private l_Notes As String
    Private l_CorporateName As String
    Private l_GrandOpening As Date
    Private l_Status As Integer

    Private l_SMSVersion As String
    Private l_NoOfTerminals As String
    Private l_IPAddress As String
    Private l_LoginName As String
    Private l_Password As String

    Private l_ISPType As String
    Private l_DefaultGateWay As String
    Private l_PrimaryDNS As String
    Private l_SecondaryDNS As String
    Private l_Switch As String
    Private l_Firewall As String
    Private l_FirewallLogin As String
    Private l_FirlwallAccess As String
    Private l_DialupSpeed As String
    Private l_DialupNo As String
    Private l_DialupLogin As String

    Private l_City As String
    Private l_State As String
    Private l_lastUpdated As DateTime

    Private l_total_Dues As Integer
    Private l_total_Deposits As Integer

#End Region

#Region "Public Properties"

    Public Property StoreNo() As Integer
        Get
            Return l_StoreNo
        End Get
        Set(ByVal value As Integer)
            l_StoreNo = value
        End Set
    End Property

    Public Property StoreName() As String
        Get
            Return l_StoreName
        End Get
        Set(ByVal value As String)
            l_StoreName = value
        End Set
    End Property

    Public Property WorkPhone() As String
        Get
            Return l_WorkPhone
        End Get
        Set(ByVal value As String)
            l_WorkPhone = value
        End Set
    End Property

    Public Property CorporateName() As String
        Get
            Return l_CorporateName
        End Get
        Set(ByVal value As String)
            l_CorporateName = value
        End Set
    End Property
    Public Property GrandOpening() As Date
        Get
            Return l_GrandOpening
        End Get
        Set(ByVal value As Date)
            l_GrandOpening = value
        End Set
    End Property
    Public Property Status() As Integer
        Get
            Return l_Status
        End Get
        Set(ByVal value As Integer)
            l_Status = value
        End Set
    End Property
    Public Property OnSupport() As Boolean
        Get
            Return l_OnSupport
        End Get
        Set(ByVal value As Boolean)
            l_OnSupport = value
        End Set
    End Property

    Public Property OnBackup() As Boolean
        Get
            Return l_OnBackup
        End Get
        Set(ByVal value As Boolean)
            l_OnBackup = value
        End Set
    End Property

    Public Property FromDate() As Date
        Get
            Return l_FromDate
        End Get
        Set(ByVal value As Date)
            l_FromDate = value
        End Set
    End Property

    Public Property ToDate() As Date
        Get
            Return l_ToDate
        End Get
        Set(ByVal value As Date)
            l_ToDate = value
        End Set
    End Property
    Public Property MontlyCharges() As Integer
        Get
            Return l_MonthlyCharges
        End Get
        Set(ByVal value As Integer)
            l_MonthlyCharges = value
        End Set
    End Property
    Public Property SupportyType() As Portal.BLL.Enumeration.Support_Type
        Get
            Return l_SupportType
        End Get
        Set(ByVal value As Portal.BLL.Enumeration.Support_Type)
            l_SupportType = value
        End Set
    End Property
    Public Property Notes() As String
        Get
            Return l_Notes
        End Get
        Set(ByVal value As String)
            l_Notes = value
        End Set
    End Property
    Public Property City() As String
        Get
            Return l_City
        End Get
        Set(ByVal value As String)
            l_City = value
        End Set
    End Property

    Public Property State() As String
        Get
            Return l_State
        End Get
        Set(ByVal value As String)
            l_State = value
        End Set
    End Property

    Public Property IPAddress() As String
        Get
            Return l_IPAddress
        End Get
        Set(ByVal value As String)
            l_IPAddress = value
        End Set
    End Property

    Public Property LoginName() As String
        Get
            Return l_LoginName
        End Get
        Set(ByVal value As String)
            l_LoginName = value
        End Set
    End Property

    Public Property Password() As String
        Get
            Return l_Password
        End Get
        Set(ByVal value As String)
            l_Password = value
        End Set


    End Property

    Public Property SMSVersion() As String
        Get
            Return l_SMSVersion
        End Get
        Set(ByVal value As String)
            l_SMSVersion = value
        End Set
    End Property

    Public Property NoOfTerminals() As String
        Get
            Return l_NoOfTerminals
        End Get
        Set(ByVal value As String)
            l_NoOfTerminals = value
        End Set
    End Property

    Public Property lastUpdated() As DateTime
        Get
            Return l_lastUpdated
        End Get
        Set(ByVal value As DateTime)
            l_lastUpdated = value
        End Set
    End Property

    Public Property ISPType() As String
        Get
            Return l_ISPType
        End Get
        Set(ByVal value As String)
            l_ISPType = value
        End Set
    End Property


    Public Property DefaultGateWay() As String
        Get
            Return l_DefaultGateWay
        End Get
        Set(ByVal value As String)
            l_DefaultGateWay = value
        End Set
    End Property

    Public Property PrimaryDNS() As String
        Get
            Return l_PrimaryDNS
        End Get
        Set(ByVal value As String)
            l_PrimaryDNS = value
        End Set
    End Property

    Public Property SecondaryDNS() As String
        Get
            Return l_SecondaryDNS
        End Get
        Set(ByVal value As String)
            l_SecondaryDNS = value
        End Set
    End Property

    Public Property Switch() As String
        Get
            Return l_Switch
        End Get
        Set(ByVal value As String)
            l_Switch = value
        End Set
    End Property

    Public Property Firewall() As String
        Get
            Return l_Firewall
        End Get
        Set(ByVal value As String)
            l_Firewall = value
        End Set
    End Property

    Public Property FirewallLogin() As String
        Get
            Return l_FirewallLogin
        End Get
        Set(ByVal value As String)
            l_FirewallLogin = value
        End Set
    End Property

    Public Property FirlwallAccess() As String
        Get
            Return l_FirlwallAccess
        End Get
        Set(ByVal value As String)
            l_FirlwallAccess = value
        End Set
    End Property

    Public Property DialupSpeed() As String
        Get
            Return l_DialupSpeed
        End Get
        Set(ByVal value As String)
            l_DialupSpeed = value
        End Set
    End Property

    Public Property DialupNo() As String
        Get
            Return l_DialupNo
        End Get
        Set(ByVal value As String)
            l_DialupNo = value
        End Set

    End Property

    Public Property DialupLogin() As String
        Get
            Return l_DialupLogin
        End Get
        Set(ByVal value As String)
            l_DialupLogin = value
        End Set

    End Property


    Public Property TotalDues() As Integer
        Get
            Return l_total_Dues
        End Get
        Set(ByVal value As Integer)
            l_total_Dues = value
        End Set
    End Property


    Public Property TotalDeposits() As Integer
        Get
            Return l_total_Deposits
        End Get
        Set(ByVal value As Integer)
            l_total_Deposits = value
        End Set
    End Property

#End Region

#Region "Public Shared Method"

    Public Shared Function GetAllStoresForLoginInfo(ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal Search As String, ByVal Status As Integer, ByVal Country As Integer, ByVal ReportedIP As Integer, ByVal State As Integer) As SqlDataReader
        Dim db As New DBAccess("Fransupport")
        Dim dr As SqlDataReader


        db.AddParameter("@SortExpression", sortExpression)
        db.AddParameter("@StartRowIndex", startRowIndex)
        db.AddParameter("@RowsToGet", maximumRows)

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If

        If Status = 0 Then
            db.AddParameter("@status", DBNull.Value)
        Else
            db.AddParameter("@status", Status)
        End If

        If Country = 0 Then
            db.AddParameter("@country", DBNull.Value)
        Else
            db.AddParameter("@country", Country)
        End If

        If ReportedIP = 0 Then
            db.AddParameter("@ReportedIP", DBNull.Value)
        Else
            db.AddParameter("@ReportedIP", ReportedIP)
        End If

        If State = 0 Then
            db.AddParameter("@state", DBNull.Value)
        Else
            db.AddParameter("@state", State)
        End If

        dr = db.ExecuteReader("Portal_Franchises_LoginInfo_GetAll")
        If dr.Read Then l_RecCount = dr(0)
        dr.NextResult()

        Return dr

    End Function

    Public Shared Function GetAllStoresForLoginInfo_Count(ByVal Search As String, ByVal Status As Integer, ByVal Country As Integer, ByVal ReportedIP As Integer, ByVal State As Integer) As Integer

        Return l_RecCount
    End Function


    Public Shared Function GetCountriesList() As SqlDataReader
        Dim db As New DBAccess("Fransupport")

        Return db.ExecuteReader("countries_GetDistinctCountryIDFromFranchises")

    End Function


    Public Shared Function GetAllStoresForSupporInfo(ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal Search As String, ByVal Support As Integer, ByVal Country As Integer, ByVal Backup As Integer, ByVal State As Integer) As SqlDataReader
        Dim db As New DBAccess("Fransupport")
        Dim dr As SqlDataReader
        db.AddParameter("@SortExpression", sortExpression)
        db.AddParameter("@StartRowIndex", startRowIndex)
        db.AddParameter("@RowsToGet", maximumRows)

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If

        If Support = -1 Then
            db.AddParameter("@Support", DBNull.Value)
        Else
            db.AddParameter("@Support", Support)
        End If

        If Country = 0 Then
            db.AddParameter("@country", DBNull.Value)
        Else
            db.AddParameter("@country", Country)
        End If

        If Backup = -1 Then
            db.AddParameter("@Backup", DBNull.Value)
        Else
            db.AddParameter("@Backup", Backup)
        End If

        If State = 0 Then
            db.AddParameter("@state", DBNull.Value)
        Else
            db.AddParameter("@state", State)
        End If


        dr = db.ExecuteReader("Portal_Franchises_SupportInfo_GetAll")
        If dr.Read Then l_RecCount = dr(0)
        dr.NextResult()

        Return dr

    End Function

    Public Shared Function GetAllStoresForSupporInfo_Count(ByVal Search As String, ByVal Support As Integer, ByVal Country As Integer, ByVal Backup As Integer, ByVal State As Integer) As Integer

        Return l_RecCount
    End Function


    Public Shared Function GetSupportHistoryByFranchiseID(ByVal FranchiseId As Integer, ByVal SupportType As Integer) As SqlDataReader
        Dim db As New DBAccess("Fransupport")

        db.AddParameter("@FranchiseID", FranchiseId)
        db.AddParameter("@SupportType", SupportType)

        Return db.ExecuteReader("Portal_Franchises_SupporHistory_GetByFranchiseID")


    End Function

    Public Shared Function GetBillingHistoryByFranchiseID(ByVal FranchiseId As Integer, ByVal SupportType As Integer) As SqlDataReader
        Dim db As New DBAccess("Fransupport")

        db.AddParameter("@FranchiseID", FranchiseId)

        Return db.ExecuteReader("Portal_Franchises_BillingHistory_GetByFranchiseID")


    End Function


    Public Shared Function GetBillingReport(ByVal sortExpression As String, ByVal ReportinMonthId As Integer, ByVal Search As String) As SqlDataReader
        Dim db As New DBAccess("Fransupport")
        db.AddParameter("@SortExpression", sortExpression)
        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If
        If ReportinMonthId = 0 Then
            db.AddParameter("@ReportinMonthId", DBNull.Value)
        Else
            db.AddParameter("@ReportinMonthId", ReportinMonthId)
        End If
        Return db.ExecuteReader("Portal_Franchises_Support_BillingReport")
    End Function

    Public Shared Function GetBillingReport_Count(ByVal ReportinMonthId As Integer) As Integer

        Return l_RecCount
    End Function

    Public Shared Function GetBillingReportForReportViewer(ByVal sortExpression As String, ByVal ReportinMonthId As Integer, ByVal Search As String) As DataSet
        Dim db As New DBAccess("Fransupport")
        db.AddParameter("@SortExpression", sortExpression)

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If

        If ReportinMonthId = 0 Then
            db.AddParameter("@ReportinMonthId", DBNull.Value)
        Else
            db.AddParameter("@ReportinMonthId", ReportinMonthId)
        End If

        Return db.ExecuteDataSet("Portal_Franchises_Support_BillingReport")
    End Function

    Public Shared Function GetBillingMonths() As SqlDataReader
        Dim db As New DBAccess("Fransupport")
        Return db.ExecuteReader("Portal_Franchises_Support_BillingReport_GetMonths")
    End Function


    Public Shared Function GetBillingReportDetails(ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReportinMonthId As Integer) As SqlDataReader
        Dim db As New DBAccess("Fransupport")
        Dim dr As SqlDataReader

        db.AddParameter("@SortExpression", sortExpression)
        db.AddParameter("@StartRowIndex", startRowIndex)
        db.AddParameter("@RowsToGet", maximumRows)
        If ReportinMonthId = 0 Then
            db.AddParameter("@ReportinMonthId", DBNull.Value)
        Else
            db.AddParameter("@ReportinMonthId", ReportinMonthId)
        End If
        dr = db.ExecuteReader("Portal_Franchises_Support_BillingReportDetails")
        If dr.Read Then l_RecCount = dr(0)
        dr.NextResult()

        Return dr

    End Function

    Public Shared Function GetBillingReportDetails_Count(ByVal ReportinMonthId As Integer) As Integer
        Return l_RecCount
    End Function

    Public Shared Function GetBillingReportDetailsForReportViewer(ByVal sortExpression As String, ByVal ReportinMonthId As Integer) As DataSet
        Dim db As New DBAccess("Fransupport")
        db.AddParameter("@SortExpression", sortExpression)
        If ReportinMonthId = 0 Then
            db.AddParameter("@ReportinMonthId", DBNull.Value)
        Else
            db.AddParameter("@ReportinMonthId", ReportinMonthId)
        End If
        Return db.ExecuteDataSet("Portal_Franchises_Support_BillingReportDetails_ForReport")
    End Function


    Public Shared Function GetCheckList(ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal CheckListDateID As Integer, ByVal Search As String) As SqlDataReader
        Dim db As New DBAccess("Fransupport")
        Dim dr As SqlDataReader

        db.AddParameter("@SortExpression", sortExpression)
        db.AddParameter("@StartRowIndex", startRowIndex)
        db.AddParameter("@RowsToGet", maximumRows)
        If CheckListDateID = "0" Then
            db.AddParameter("@CheckListDateID", DBNull.Value)
        Else
            db.AddParameter("@CheckListDateID", CheckListDateID)
        End If
        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If
        dr = db.ExecuteReader("Portal_Franchises_Support_CheckList_GetAll")
        If dr.Read Then l_RecCount = dr(0)
        dr.NextResult()

        Return dr

    End Function

    Public Shared Function GetCheckList_Count(ByVal CheckListDateID As Integer, ByVal Search As String) As Integer

        Return l_RecCount
    End Function

    'Public Shared Function UpdateCheckListStatus(ByVal FranchiseId As Integer) As Boolean
    '    Dim db As New DBAccess("Fransupport")

    '    db.AddParameter("@AdminID", CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID)
    '    db.AddParameter("@FranchiseID", FranchiseId)


    '    Return db.ExecuteScalar("Portal_Franchises_Support_CheckList_UpdateStatus")

    'End Function

    Public Shared Function GetCheckListForReport(ByVal CheckListDateID As Integer, ByVal Search As String, ByVal Sort As String) As DataSet
        Dim db As New DBAccess("Fransupport")

        If CheckListDateID = "0" Then
            db.AddParameter("@CheckListDateID", DBNull.Value)
        Else
            db.AddParameter("@CheckListDateID", CheckListDateID)
        End If

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If

        If Sort = "" Then
            db.AddParameter("@SortExpression", DBNull.Value)
        Else
            db.AddParameter("@SortExpression", Sort)
        End If


        Return db.ExecuteDataSet("Portal_Franchises_Support_CheckList_GetAllForReport")

    End Function

    Public Shared Function GetChecklistMonths() As SqlDataReader
        Dim db As New DBAccess("Fransupport")

        Return db.ExecuteReader("Portal_Franchises_Support_CheckList_GetMonths")
    End Function

#End Region

#Region "Public Functions"

    Public Function GetFranchiseInfoByID(ByVal FranchiseId As Integer) As Support
        Dim db As New DBAccess("Fransupport")
        Dim dr As SqlDataReader

        db.AddParameter("@FranchiseID", FranchiseId)

        dr = db.ExecuteReader("Portal_Franchises_LoginInfo_GetByFranchiseID")

        If dr.Read Then
            l_StoreName = dr("StoreName")
            l_StoreNo = dr("StoreNumber")
            l_OnSupport = dr("OnSupport")
            l_OnBackup = dr("OnBackupService")
            l_total_Dues = dr("TotalDues")
            l_total_Deposits = dr("TotalDeposits")
            If Not IsDBNull(dr("SMSVersion")) Then l_SMSVersion = dr("SMSVersion")
            If Not IsDBNull(dr("SMSLiveTerminals")) Then l_NoOfTerminals = dr("SMSLiveTerminals")
            If Not IsDBNull(dr("CurrentIP")) Then l_IPAddress = dr("CurrentIP")
            If Not IsDBNull(dr("ServerLogin")) Then l_LoginName = dr("ServerLogin")
            If Not IsDBNull(dr("ServerPwd")) Then l_Password = dr("ServerPwd")
            If Not IsDBNull(dr("ISPType")) Then l_ISPType = dr("ISPType")
            If Not IsDBNull(dr("DefaultGateway")) Then l_DefaultGateWay = dr("DefaultGateway")
            If Not IsDBNull(dr("PrimaryDNS")) Then l_PrimaryDNS = dr("PrimaryDNS")
            If Not IsDBNull(dr("SecondaryDNS")) Then l_SecondaryDNS = dr("SecondaryDNS")
            If Not IsDBNull(dr("Switch")) Then l_Switch = dr("Switch")
            If Not IsDBNull(dr("FirewallRouter")) Then l_Firewall = dr("FirewallRouter")
            If Not IsDBNull(dr("FirewallRouterLogin")) Then l_FirewallLogin = dr("FirewallRouterLogin")
            If Not IsDBNull(dr("FirewallRouterAccess")) Then l_FirlwallAccess = dr("FirewallRouterAccess")
            If Not IsDBNull(dr("DialupSpeed")) Then l_DialupSpeed = dr("DialupSpeed")
            If Not IsDBNull(dr("DialupNumber")) Then l_DialupNo = dr("DialupNumber")
            If Not IsDBNull(dr("DialupLogin")) Then l_DialupLogin = dr("DialupLogin")
            If Not IsDBNull(dr("CorporateName")) Then l_CorporateName = dr("CorporateName")
            If Not IsDBNull(dr("GrandOpening")) Then l_GrandOpening = dr("GrandOpening")
            If Not IsDBNull(dr("Status")) Then l_Status = dr("Status")



        End If

        dr.Close()
        dr = Nothing

        Return Me
    End Function

    Public Function UpdateFranchiseInformation(ByVal FranchiseId As Integer) As Boolean
        Dim db As New DBAccess("Fransupport")

        db.AddParameter("@FranchiseID", FranchiseId)
        db.AddParameter("@SMSVersion", l_SMSVersion)
        db.AddParameter("@SMSLiveTerminals", l_NoOfTerminals)
        db.AddParameter("@CurrentIP", l_IPAddress)
        db.AddParameter("@ServerLogin", l_LoginName)
        db.AddParameter("@ServerPwd", l_Password)
        db.AddParameter("@ISPType", l_ISPType)
        db.AddParameter("@DefaultGateway", l_DefaultGateWay)
        db.AddParameter("@PrimaryDNS", l_PrimaryDNS)
        db.AddParameter("@SecondaryDNS", l_SecondaryDNS)
        db.AddParameter("@Switch", l_Switch)
        db.AddParameter("@FirewallRouter", l_Firewall)
        db.AddParameter("@FirewallRouterLogin", l_FirewallLogin)
        db.AddParameter("@FirewallRouterAccess", l_FirlwallAccess)
        db.AddParameter("@DialupSpeed", l_DialupSpeed)
        db.AddParameter("@DialupLogin", l_DialupLogin)
        db.AddParameter("@DialupNumber", l_DialupNo)


        db.ExecuteNonQuery("Portal_FranchisesSupport_Update")

    End Function

    'Public Function RenewSupport(ByVal FranchiseId As Integer) As Boolean

    '    Dim db As New DBAccess("Fransupport")

    '    db.AddParameter("@FranchiseID", FranchiseId)
    '    db.AddParameter("@StartDate", l_FromDate)
    '    db.AddParameter("@EndDate", l_ToDate)
    '    db.AddParameter("@Monthly_Charges", l_MonthlyCharges)
    '    db.AddParameter("@Support_Type", l_SupportType)
    '    db.AddParameter("@Notes", l_Notes)
    '    db.AddParameter("@AdminID", CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID)

    '    db.ExecuteScalar("Portal_Franchises_SupporHistory_Renew")

    'End Function

#End Region


End Class
