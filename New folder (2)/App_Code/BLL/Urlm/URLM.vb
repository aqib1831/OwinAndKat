Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data

Public Class URLM

#Region "local variables"

    Private l_NameServer1 As String
    Private l_NameServer2 As String
    Private l_ReferralUrl As String
    Private l_WhoisServer As String
    Private l_ExpirationDate As Date
    Private l_UpdateDate As Date
    Private l_Status As Portal.BLL.Enumeration.Site_Status
    Private l_UrlID As Integer
    Private l_URL As String
    Private l_AccountId As Integer
    Private l_CategoryId As Integer
    Private l_RegistrarId As Integer
    Private l_ActivationDate As Date = Nothing
    Private l_RegistrationDate As Date = Nothing
    Private l_CountryID As Integer = 0


#End Region

#Region "Public Propeties"


    Public Property URL() As String
        Get
            Return l_URL
        End Get
        Set(ByVal value As String)
            l_URL = value
        End Set
    End Property

    Public Property UrlId() As Integer
        Get
            Return l_UrlID
        End Get
        Set(ByVal value As Integer)
            l_UrlID = value
        End Set
    End Property

    Public Property AccountId() As Integer
        Get
            Return l_AccountId
        End Get
        Set(ByVal value As Integer)
            l_AccountId = value
        End Set
    End Property
    Public Property CategoryId() As Integer
        Get
            Return l_CategoryId
        End Get
        Set(ByVal value As Integer)
            l_CategoryId = value
        End Set
    End Property
    Public Property RegistrarId() As Integer
        Get
            Return l_RegistrarId
        End Get
        Set(ByVal value As Integer)
            l_RegistrarId = value
        End Set
    End Property

    Public Property NameServer1() As String
        Get
            Return l_NameServer1
        End Get
        Set(ByVal value As String)
            l_NameServer1 = value
        End Set
    End Property

    Public Property NameServer2() As String
        Get
            Return l_NameServer2
        End Get
        Set(ByVal value As String)
            l_NameServer2 = value
        End Set
    End Property

    Public Property ReferralUrl() As String
        Get
            Return l_ReferralUrl
        End Get
        Set(ByVal value As String)
            l_ReferralUrl = value
        End Set
    End Property
    Public Property WhoisServer() As String
        Get
            Return l_WhoisServer
        End Get
        Set(ByVal value As String)
            l_WhoisServer = value
        End Set
    End Property

    Public Property ExpirationDate() As Date
        Get
            Return l_ExpirationDate
        End Get
        Set(ByVal value As Date)
            l_ExpirationDate = value
        End Set
    End Property

    Public Property UpdateDate() As Date
        Get
            Return l_UpdateDate
        End Get
        Set(ByVal value As Date)
            l_UpdateDate = value
        End Set
    End Property

    Public Property Status() As Portal.BLL.Enumeration.Site_Status
        Get
            Return l_Status
        End Get
        Set(ByVal value As Portal.BLL.Enumeration.Site_Status)
            l_Status = value
        End Set
    End Property

    Public Property ActivationDate() As Date
        Get
            Return l_ActivationDate
        End Get
        Set(ByVal value As Date)
            l_ActivationDate = value
        End Set
    End Property

    Public Property RegistrationDate() As Date
        Get
            Return l_RegistrationDate
        End Get
        Set(ByVal value As Date)
            l_RegistrationDate = value
        End Set
    End Property

    Public Property CountryID() As Integer
        Get
            Return l_CountryID
        End Get
        Set(ByVal value As Integer)
            l_CountryID = value
        End Set
    End Property

#End Region

#Region "Public Shared functions"

#Region "GetAllURLs"

    Public Shared Function GetAllURLs(ByVal AccountID As Integer, ByVal CategoryID As Integer, ByVal RegistrarId As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal CommingExpries As Integer) As SqlDataReader
        Dim db As New DBAccess

        If AccountID = 0 Then
            db.AddParameter("@AccountID", DBNull.Value)
        Else
            db.AddParameter("@AccountID", AccountID)
        End If

        If CategoryID = 0 Then
            db.AddParameter("@CategoryID", DBNull.Value)
        Else
            db.AddParameter("@CategoryID", CategoryID)
        End If

        If RegistrarId = 0 Then
            db.AddParameter("@RegistrarId", DBNull.Value)
        Else
            db.AddParameter("@RegistrarId", RegistrarId)
        End If

        If CommingExpries = 0 Then
            db.AddParameter("@CommingExpries", DBNull.Value)
        Else
            db.AddParameter("@CommingExpries", CommingExpries)
        End If


        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If


        db.AddParameter("@SortExpression", sortExpression)
        db.AddParameter("@StartRowIndex", startRowIndex)
        db.AddParameter("@RowsToGet", maximumRows)

        Return db.ExecuteReader("URLM_URLs_GetAll")
    End Function

Public Shared Function GetAllURLsMyNetsolaceClient(ByVal AccountID As Integer, ByVal CategoryID As Integer, ByVal RegistrarId As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal CommingExpries As Integer) As SqlDataReader
        Dim db As New DBAccess

        If AccountID = 0 Then
            db.AddParameter("@AccountID", DBNull.Value)
        Else
            db.AddParameter("@AccountID", AccountID)
        End If

        
        db.AddParameter("@CategoryID", 1)
        

        If RegistrarId = 0 Then
            db.AddParameter("@RegistrarId", DBNull.Value)
        Else
            db.AddParameter("@RegistrarId", RegistrarId)
        End If

        If CommingExpries = 0 Then
            db.AddParameter("@CommingExpries", DBNull.Value)
        Else
            db.AddParameter("@CommingExpries", CommingExpries)
        End If


        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If


        If String.IsNullOrEmpty(sortExpression) = True Then
            db.AddParameter("@SortExpression", "URL")
        Else
            db.AddParameter("@SortExpression", sortExpression)
        End If

        db.AddParameter("@StartRowIndex", startRowIndex)
        db.AddParameter("@RowsToGet", maximumRows)

        Return db.ExecuteReader("URLM_URLs_GetAll")
    End Function

#End Region

#Region "GetTotalRecords"

    Public Shared Function GetTotalRecords(ByVal AccountID As Integer, ByVal CategoryID As Integer, ByVal RegistrarId As Integer, ByVal Search As String, ByVal CommingExpries As Integer) As Integer
        Dim db As New DBAccess
        If AccountID = 0 Then
            db.AddParameter("@AccountID", DBNull.Value)
        Else
            db.AddParameter("@AccountID", AccountID)
        End If

        If CategoryID = 0 Then
            db.AddParameter("@CategoryID", DBNull.Value)
        Else
            db.AddParameter("@CategoryID", CategoryID)
        End If

        If RegistrarId = 0 Then
            db.AddParameter("@RegistrarId", DBNull.Value)
        Else
            db.AddParameter("@RegistrarId", RegistrarId)
        End If

        If CommingExpries = 0 Then
            db.AddParameter("@CommingExpries", DBNull.Value)
        Else
            db.AddParameter("@CommingExpries", CommingExpries)
        End If

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If



        Return CType(db.ExecuteScalar("URLM_URLs_GetTotalRecords"), Integer)

    End Function

Public Shared Function GetTotalRecordsMyNetsolaceClient(ByVal AccountID As Integer, ByVal CategoryID As Integer, ByVal RegistrarId As Integer, ByVal Search As String, ByVal CommingExpries As Integer) As Integer
        Dim db As New DBAccess
        If AccountID = 0 Then
            db.AddParameter("@AccountID", DBNull.Value)
        Else
            db.AddParameter("@AccountID", AccountID)
        End If

        
        db.AddParameter("@CategoryID", 1) ' FOR EA
        

        If RegistrarId = 0 Then
            db.AddParameter("@RegistrarId", DBNull.Value)
        Else
            db.AddParameter("@RegistrarId", RegistrarId)
        End If

        If CommingExpries = 0 Then
            db.AddParameter("@CommingExpries", DBNull.Value)
        Else
            db.AddParameter("@CommingExpries", CommingExpries)
        End If

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If



        Return CType(db.ExecuteScalar("URLM_URLs_GetTotalRecords"), Integer)

    End Function
#End Region

#Region "GetAllAccounts"

    Public Shared Function GetAllAccounts() As SqlDataReader
        Dim db As New DBAccess

        Return db.ExecuteReader("URLM_Accounts_GetAll")
    End Function

    Public Shared Function GetAllAccountsForList(ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As SqlDataReader
        Dim db As New DBAccess
        Return db.ExecuteReader("URLM_Accounts_GetAll")
    End Function

    Public Shared Function DeleteAccount(ByVal ID As Integer) As Boolean
        Dim db As New DBAccess
        db.AddParameter("@ID", ID)
        db.ExecuteNonQuery("URLM_Account_Delete")
        Return True
    End Function

    Public Shared Function CheckDuplicateAccounts(ByVal ID As Integer, ByVal Title As String) As Integer
        Dim db As New DBAccess
        If ID = 0 Then
            db.AddParameter("@ID", DBNull.Value)
        Else
            db.AddParameter("@ID", ID)
        End If
        If Title = "" Then
            db.AddParameter("@Title", DBNull.Value)
        Else
            db.AddParameter("@Title", Title)
        End If
        Return CType(db.ExecuteScalar("URLM_Accounts_CheckDuplicate"), Integer)
    End Function

    Public Shared Function GetAllCountries() As SqlDataReader
        Dim db As New DBAccess

        Return db.ExecuteReader("Countries_GetAllCountries")
    End Function

#End Region

#Region "GetAllCategories"

    Public Shared Function GetAllCategories() As DataSet
        Dim db As New DBAccess
        Dim ds As New DataSet
        ds = db.ExecuteDataSet("URLM_Category_GetAll")
        Return ds
    End Function

    Public Shared Function GetAllCategoriesForList(ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As DataSet
        Dim db As New DBAccess
        Dim ds As New DataSet
        ds = db.ExecuteDataSet("URLM_CategoryGetAllForList")
        Return ds
    End Function

    Public Shared Function CheckDuplicateCategory(ByVal ID As Integer, ByVal Title As String) As Integer
        Dim db As New DBAccess
        If ID = 0 Then
            db.AddParameter("@ID", DBNull.Value)
        Else
            db.AddParameter("@ID", ID)
        End If
        If Title = "" Then
            db.AddParameter("@Title", DBNull.Value)
        Else
            db.AddParameter("@Title", Title)
        End If
        Return CType(db.ExecuteScalar("URLM_Category_CheckDuplicate"), Integer)
    End Function

#End Region

#Region "GetAllRegistrars"

    Public Shared Function GetAllRegistrars() As SqlDataReader
        Dim db As New DBAccess

        Return db.ExecuteReader("URLM_Registrar_GetAll")
    End Function

    Public Shared Function CheckDuplicateRegistrar(ByVal ID As Integer, ByVal Title As String) As Integer
        Dim db As New DBAccess
        If ID = 0 Then
            db.AddParameter("@ID", DBNull.Value)
        Else
            db.AddParameter("@ID", ID)
        End If
        If Title = "" Then
            db.AddParameter("@Title", DBNull.Value)
        Else
            db.AddParameter("@Title", Title)
        End If
        Return CType(db.ExecuteScalar("URLM_Registrar_CheckDuplicate"), Integer)
    End Function

#End Region

#Region "UpdateStatus"
    Public Shared Sub UpdateStatus(ByVal argStatus As Portal.BLL.Enumeration.Site_Status, ByVal argUrlName As String)

        Dim db As New DBAccess

        db.AddParameter("@Status", argStatus)
        db.AddParameter("@URL", argUrlName)

        db.ExecuteNonQuery("URLM_URLs_UpdateStatus")


    End Sub
#End Region

#Region "Delete"
    Public Shared Function Delete(ByVal argUrlName As String) As Boolean
        Dim db As New DBAccess
        db.AddParameter("@URL", argUrlName)
        db.ExecuteNonQuery("URLM_URLs_Delete")
        Return True
    End Function
#End Region

#Region "GetAllURLsForReport"

    Public Shared Function GetAllURLsForReport(ByVal AccountID As Integer, ByVal CategoryID As Integer, ByVal RegistrarId As Integer, ByVal Search As String, ByVal sortExpression As String, ByVal CommingExpries As Integer) As DataSet
        Dim db As New DBAccess

        If AccountID = 0 Then
            db.AddParameter("@AccountID", DBNull.Value)
        Else
            db.AddParameter("@AccountID", AccountID)
        End If

        If CategoryID = 0 Then
            db.AddParameter("@CategoryID", DBNull.Value)
        Else
            db.AddParameter("@CategoryID", CategoryID)
        End If

        If RegistrarId = 0 Then
            db.AddParameter("@RegistrarId", DBNull.Value)
        Else
            db.AddParameter("@RegistrarId", RegistrarId)
        End If

        If CommingExpries = 0 Then
            db.AddParameter("@CommingExpries", DBNull.Value)
        Else
            db.AddParameter("@CommingExpries", CommingExpries)
        End If

        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If


        db.AddParameter("@SortExpression", sortExpression)

        Return db.ExecuteDataSet("URLM_URLs_GetAllForReport")
    End Function

#End Region

#Region "GetUrlByName"

    Public Shared Function GetUrlByName(ByVal argUrlName As String) As URLM

        Dim db As New DBAccess
        Dim objUrlm As New URLM
        Dim dr As SqlDataReader

        db.AddParameter("@Url", argUrlName)

        dr = db.ExecuteReader("URLM_URLs_GetByName")

        If dr.Read Then
            If Not IsDBNull(dr("AccountId")) Then objUrlm.AccountId = dr("AccountId")
            If Not IsDBNull(dr("RegistrarId")) Then objUrlm.RegistrarId = dr("RegistrarId")
            If Not IsDBNull(dr("CategoryId")) Then objUrlm.CategoryId = dr("CategoryId")
            If Not IsDBNull(dr("Nameserver1")) Then objUrlm.NameServer1 = dr("Nameserver1")
            If Not IsDBNull(dr("Nameserver2")) Then objUrlm.NameServer2 = dr("Nameserver2")
            If Not IsDBNull(dr("WhoisServer")) Then objUrlm.WhoisServer = dr("WhoisServer")
            If Not IsDBNull(dr("referralUrl")) Then objUrlm.ReferralUrl = dr("referralUrl")

            If Not IsDBNull(dr("Expiration_Date")) Then
                objUrlm.ExpirationDate = dr("Expiration_Date")
            End If

            dr.Close()
        End If


        Return objUrlm
    End Function

#End Region

#Region "GetUrlByName"

    Public Shared Function GetUrlByID(ByVal argUrlID As String) As URLM

        Dim db As New DBAccess
        Dim objUrlm As New URLM
        Dim dr As SqlDataReader

        db.AddParameter("@URLID", argUrlID)

        dr = db.ExecuteReader("URLM_URLs_GetByID")

        If dr.Read Then
            If Not IsDBNull(dr("URL")) Then objUrlm.URL = dr("URL")
            If Not IsDBNull(dr("AccountId")) Then objUrlm.AccountId = dr("AccountId")
            If Not IsDBNull(dr("RegistrarId")) Then objUrlm.RegistrarId = dr("RegistrarId")
            If Not IsDBNull(dr("CategoryId")) Then objUrlm.CategoryId = dr("CategoryId")
            If Not IsDBNull(dr("Nameserver1")) Then objUrlm.NameServer1 = dr("Nameserver1")
            If Not IsDBNull(dr("Nameserver2")) Then objUrlm.NameServer2 = dr("Nameserver2")
            If Not IsDBNull(dr("WhoisServer")) Then objUrlm.WhoisServer = dr("WhoisServer")
            If Not IsDBNull(dr("referralUrl")) Then objUrlm.ReferralUrl = dr("referralUrl")

            If Not IsDBNull(dr("Expiration_Date")) Then
                objUrlm.ExpirationDate = dr("Expiration_Date")
            End If
            If Not IsDBNull(dr("Activation_Date")) Then
                objUrlm.ActivationDate = dr("Activation_Date")
            Else
                objUrlm.ActivationDate = Date.MinValue
            End If
            If Not IsDBNull(dr("Registration_Date")) Then
                objUrlm.RegistrationDate = dr("Registration_Date")
            Else
                objUrlm.RegistrationDate = Date.MinValue
            End If
            If Not IsDBNull(dr("CountryID")) Then
                objUrlm.CountryID = dr("CountryID")
            End If
            dr.Close()
        End If


        Return objUrlm
    End Function

#End Region

#Region "GetUpdatedUrlStatus"

    Public Shared Function GetUpdatedUrlStatus() As ArrayList
        Dim objSession As New System.Web.UI.Page
        Dim objUrls As New ArrayList

        objUrls = CType(objSession.Session("UpdatedUrlInfo"), ArrayList)

        Return objUrls
    End Function

#End Region

#Region "CheckURL"

    Public Function CheckURL(ByVal UrlName As String) As Portal.BLL.Enumeration.URLPageRequest
        Dim _PageRequest As New Portal.BLL.Enumeration.URLPageRequest
        _PageRequest.Initialize()

        GetPageRequest(_PageRequest, UrlName)
        Return _PageRequest

    End Function
#End Region

#Region "GetPageRequest"

    Private Sub GetPageRequest(ByRef PageRequest As Portal.BLL.Enumeration.URLPageRequest, ByVal UrlName As String)
        Dim req As System.Net.HttpWebRequest
        Dim res As System.Net.HttpWebResponse
        Dim Reader As System.IO.StreamReader
        Dim URLPage As String
        'set up error trapping 
        Try
            'display request url 
            req = System.Net.HttpWebRequest.Create("http://www." & UrlName)

            'set the user agent 
            'some site might brush you off if it is not set 
            'to stop bots and scrapers 
            req.UserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.0.3705)"

            'get page 
            res = req.GetResponse()
            Reader = New System.IO.StreamReader(res.GetResponseStream())
            URLPage = Reader.ReadToEnd
            Reader.Close()

            res.Close()

            'display respondent url 
            PageRequest.URL = res.ResponseUri.AbsoluteUri

            'extract and display meta refresh tag, if it exists 
            PageRequest.MetaTag = System.Text.RegularExpressions.Regex.Match(URLPage, "URL=(?<href>[^""]+)""").Groups("href").Value()

            'extract and display page title 
            PageRequest.Title = System.Text.RegularExpressions.Regex.Match(URLPage, "<title>(?<title>[^<]+)</title>", System.Text.RegularExpressions.RegexOptions.IgnoreCase).Groups("title").Value

            Dim SHhash As New System.Security.Cryptography.SHA1Managed

            'convert the page to a byte array 
            Dim BytePage As Byte() = System.Text.Encoding.ASCII.GetBytes(URLPage)

            'get the hash as a byte array 
            Dim hashvalue As Byte() = SHhash.ComputeHash(BytePage)

            'display the hash as a string 
            Dim b As Byte

            For Each b In hashvalue
                PageRequest.HashEntry += Right("0" + Hex$(b), 2)
            Next
            PageRequest.Status = True
            PageRequest.ErrorString = ""
        Catch ex As Exception
            'display any error message 
            PageRequest.Status = False
            PageRequest.ErrorString = ex.Message

        End Try
    End Sub
#End Region


#End Region

#Region "Public Functions"

#Region "UpdateInformation"
    Public Sub UpdateInformation()

        Dim db As New DBAccess

        db.AddParameter("@NameServer1", l_NameServer1)
        db.AddParameter("@NameServer2", l_NameServer2)
        db.AddParameter("@ExpirationDate", l_ExpirationDate)
        db.AddParameter("@Status", l_Status)
        db.AddParameter("@URL", l_URL)

        db.ExecuteNonQuery("URLM_URLs_UpdateInformation")


    End Sub
    Public Function UpdateURLExpirayDate() As Integer

        Dim db As New DBAccess
        Dim rtValue As Integer
        db.AddParameter("@ExpirationDate", l_ExpirationDate)
        db.AddParameter("@UrlID", l_UrlID)
        db.AddParameter("@Url", l_URL)
        rtValue = db.ExecuteNonQuery("UpdateURLExpirayDate")
        Return rtValue
    End Function
    Public Function GetURLInfoforUpdateExpiray() As DataTable
        Dim db As New DBAccess
        Return db.ExecuteDataTable("GetURLInfoforUpdateExpiray")
    End Function

#End Region

#Region "AddUrl"


    Public Function AddUrl() As Integer

        Dim db As New DBAccess
        Dim rtValue As Integer
        If l_UrlID = 0 Then
            db.AddParameter("@URLID", DBNull.Value)
        Else
            db.AddParameter("@URLID", l_UrlID)
        End If
        db.AddParameter("@URL", l_URL)
        db.AddParameter("@AccountID", l_AccountId)
        db.AddParameter("@CategoryID", l_CategoryId)
        db.AddParameter("@RegistrarID", l_RegistrarId)
        db.AddParameter("@Expiration_Date", l_ExpirationDate)
        db.AddParameter("@NameServer1", l_NameServer1)
        db.AddParameter("@NameServer2", l_NameServer2)
        db.AddParameter("@WhoisServer", l_WhoisServer)
        db.AddParameter("@ReferralURL", l_ReferralUrl)
        If l_RegistrationDate <> Nothing Then
            db.AddParameter("@Registration_Date", l_RegistrationDate)
        End If
        If l_ActivationDate <> Nothing Then
            db.AddParameter("@Activation_Date", l_ActivationDate)
        End If

        db.AddParameter("@Country_ID", l_CountryID)
        rtValue = CType(db.ExecuteScalar("URLM_URLs_Add"), Integer)
        Return rtValue
    End Function

#End Region

    


#End Region



End Class
