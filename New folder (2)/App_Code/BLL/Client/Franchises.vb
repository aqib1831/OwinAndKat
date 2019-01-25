Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL
    Public Class Franchises
#Region " Private Members "
        Private _id As Integer
        Private _clientid As Integer
        Private _storenumber As Integer
        Private _corporatename As String
        Private _status As Integer
        Private _storenick As String
        Private _corporateemail As String
        Private _address As String
        Private _city As String
        Private _countryid As Integer
        Private _stateid As Integer
        Private _zip As String
        Private _phone As String
        Private _fax As String
        Private _ccpaymentgateway As Integer
        Private _deleted As Boolean
        Private _timezoneid As Integer
        Private _state As String
        Private _country As String
        Private _ownername As String
        Private _statecode As String
        Private _contactdeleted As Boolean
        Private _storename As String
        Private _franchiseprimarycontactid As Integer
        Private _primarycontactid As Integer
        Private _timezone As String
        Private _contactid As Integer
        Private _licensecount As Integer
        Private _datesigned As Date
        Private _grandopening As Date
        Private _reqopeningdate As Date
        Private _clientname As String
        Private _notes As String
        Private _issuspended As Boolean
        Private _isabandon As Boolean
        Private _franchiseid As Integer
        ' should be moved to Franchise Contacts Class
        Private _primary As Boolean
        Private _IsCorporate As Boolean
        Private _IsTestStore As Boolean
        Private _FranchiseCoordinator As String
	Private _SubStatus As Integer
#End Region
#Region " Public Properties "

        Public Property ID() As Integer
            Get
                Return _id
            End Get
            Set(ByVal value As Integer)
                _id = value
            End Set
        End Property

        Public Property ClientID() As Integer
            Get
                Return _clientid
            End Get
            Set(ByVal value As Integer)
                _clientid = value
            End Set
        End Property

        Public Property StoreNumber() As Integer
            Get
                Return _storenumber
            End Get
            Set(ByVal value As Integer)
                _storenumber = value
            End Set
        End Property

        Public Property CorporateName() As String
            Get
                Return _corporatename
            End Get
            Set(ByVal value As String)
                _corporatename = value
            End Set
        End Property

        Public Property Status() As Integer
            Get
                Return _status
            End Get
            Set(ByVal value As Integer)
                _status = value
            End Set
        End Property

        Public Property StoreNick() As String
            Get
                Return _storenick
            End Get
            Set(ByVal value As String)
                _storenick = value
            End Set
        End Property

        Public Property CorporateEmail() As String
            Get
                Return _corporateemail
            End Get
            Set(ByVal value As String)
                _corporateemail = value
            End Set
        End Property

        Public Property Address() As String
            Get
                Return _address
            End Get
            Set(ByVal value As String)
                _address = value
            End Set
        End Property

        Public Property City() As String
            Get
                Return _city
            End Get
            Set(ByVal value As String)
                _city = value
            End Set
        End Property

        Public Property CountryID() As Integer
            Get
                Return _countryid
            End Get
            Set(ByVal value As Integer)
                _countryid = value
            End Set
        End Property

        Public Property StateID() As Integer
            Get
                Return _stateid
            End Get
            Set(ByVal value As Integer)
                _stateid = value
            End Set
        End Property

        Public Property ZIP() As String
            Get
                Return _zip
            End Get
            Set(ByVal value As String)
                _zip = value
            End Set
        End Property

        Public Property Phone() As String
            Get
                Return _phone
            End Get
            Set(ByVal value As String)
                _phone = value
            End Set
        End Property

        Public Property Fax() As String
            Get
                Return _fax
            End Get
            Set(ByVal value As String)
                _fax = value
            End Set
        End Property

        Public Property CCPaymentGateway() As Integer
            Get
                Return _ccpaymentgateway
            End Get
            Set(ByVal value As Integer)
                _ccpaymentgateway = value
            End Set
        End Property

        Public Property Deleted() As Boolean
            Get
                Return _deleted
            End Get
            Set(ByVal value As Boolean)
                _deleted = value
            End Set
        End Property

        Public Property TimeZoneID() As Integer
            Get
                Return _timezoneid
            End Get
            Set(ByVal value As Integer)
                _timezoneid = value
            End Set
        End Property



        Public Property State() As String
            Get
                Return _state
            End Get
            Set(ByVal value As String)
                _state = value
            End Set
        End Property

        Public Property Country() As String
            Get
                Return _country
            End Get
            Set(ByVal value As String)
                _country = value
            End Set
        End Property

        Public Property OwnerName() As String
            Get
                Return _ownername
            End Get
            Set(ByVal value As String)
                _ownername = value
            End Set
        End Property

        Public Property StateCode() As String
            Get
                Return _statecode
            End Get
            Set(ByVal value As String)
                _statecode = value
            End Set
        End Property

        Public Property ContactDeleted() As Boolean
            Get
                Return _contactdeleted
            End Get
            Set(ByVal value As Boolean)
                _contactdeleted = value
            End Set
        End Property

        Public Property StoreName() As String
            Get
                Return _storename
            End Get
            Set(ByVal value As String)
                _storename = value
            End Set
        End Property

        Public Property FranchisePrimaryContactID() As Integer
            Get
                Return _franchiseprimarycontactid
            End Get
            Set(ByVal value As Integer)
                _franchiseprimarycontactid = value
            End Set
        End Property

        Public Property PrimaryContactID() As Integer
            Get
                Return _primarycontactid
            End Get
            Set(ByVal value As Integer)
                _primarycontactid = value
            End Set
        End Property

        Public Property TimeZone() As String
            Get
                Return _timezone
            End Get
            Set(ByVal value As String)
                _timezone = value
            End Set
        End Property

        Public Property ContactID() As Integer
            Get
                Return _contactid
            End Get
            Set(ByVal value As Integer)
                _contactid = value
            End Set
        End Property

        Public Property LicenseCount() As Integer
            Get
                Return _licensecount
            End Get
            Set(ByVal value As Integer)
                _licensecount = value
            End Set
        End Property

        Public Property DateSigned() As Date
            Get
                Return _datesigned
            End Get
            Set(ByVal value As Date)
                _datesigned = value
            End Set
        End Property

        Public Property GrandOpening() As Date
            Get
                Return _grandopening
            End Get
            Set(ByVal value As Date)
                _grandopening = value
            End Set
        End Property

        Public Property ReqOpeningDate() As Date
            Get
                Return _reqopeningdate
            End Get
            Set(ByVal value As Date)
                _reqopeningdate = value
            End Set
        End Property

        Public Property IsSuspended() As Boolean
            Get
                Return _issuspended
            End Get
            Set(ByVal value As Boolean)
                _issuspended = value
            End Set
        End Property

        Public Property IsAbandon() As Boolean
            Get
                Return _isabandon
            End Get
            Set(ByVal value As Boolean)
                _isabandon = value
            End Set
        End Property

        Public Property FranchiseID() As Integer
            Get
                Return _franchiseid
            End Get
            Set(ByVal value As Integer)
                _franchiseid = value
            End Set
        End Property
        ' should be removed talk to me khurram ali.
        Public Property Primary() As Boolean
            Get
                Return _primary
            End Get
            Set(ByVal value As Boolean)
                _primary = value
            End Set
        End Property
        Public Property IsCorporate() As Boolean
            Get
                Return _IsCorporate
            End Get
            Set(ByVal value As Boolean)
                _IsCorporate = value
            End Set
        End Property
        Public Property IsTestStore() As Boolean
            Get
                Return _IsTestStore
            End Get
            Set(ByVal value As Boolean)
                _IsTestStore = value
            End Set
        End Property

        Public Property ClientName() As String
            Get
                Return _clientname
            End Get
            Set(ByVal value As String)
                _clientname = value
            End Set
        End Property
        Public Property Notes() As String
            Get
                Return _notes
            End Get
            Set(ByVal value As String)
                _notes = value
            End Set
        End Property

        Public Property FranchiseCoordinator() As String
            Get
                Return _FranchiseCoordinator
            End Get
            Set(ByVal value As String)
                _FranchiseCoordinator = value
            End Set
        End Property

	Public Property SubStatus() As Integer
            Get
                Return _SubStatus
            End Get

            Set(ByVal value As Integer)
                _SubStatus = value
            End Set

        End Property
#End Region


#Region " Constructor "
        Public Sub New()
        End Sub


        'table franchises
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ClientID As Integer, _
          ByVal StoreNumber As Integer, _
          ByVal CorporateName As String, _
          ByVal Status As Integer, _
          ByVal StoreNick As String, _
          ByVal CorporateEmail As String, _
          ByVal Address As String, _
          ByVal City As String, _
          ByVal CountryID As Integer, _
          ByVal StateID As Integer, _
          ByVal ZIP As String, _
          ByVal Phone As String, _
          ByVal Fax As String, _
          ByVal CCPaymentGateway As Integer, _
          ByVal Deleted As Boolean, _
          ByVal TimeZoneID As Integer _
         )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.StoreNumber = StoreNumber
            Me.CorporateName = CorporateName
            Me.Status = Status
            Me.StoreNick = StoreNick
            Me.CorporateEmail = CorporateEmail
            Me.Address = Address
            Me.City = City
            Me.CountryID = CountryID
            Me.StateID = StateID
            Me.ZIP = ZIP
            Me.Phone = Phone
            Me.Fax = Fax
            Me.CCPaymentGateway = CCPaymentGateway
            Me.Deleted = Deleted
            Me.TimeZoneID = TimeZoneID
        End Sub
        'viewfranchises
        Public Sub New( _
               ByVal ID As Integer, _
               ByVal ClientID As Integer, _
               ByVal StoreNick As String, _
               ByVal StoreNumber As Integer, _
               ByVal CorporateName As String, _
               ByVal Status As Integer, _
               ByVal Address As String, _
               ByVal City As String, _
               ByVal ZIP As String, _
               ByVal State As String, _
               ByVal Country As String, _
               ByVal Phone As String, _
               ByVal Fax As String, _
               ByVal OwnerName As String, _
               ByVal StateCode As String, _
               ByVal Deleted As Boolean, _
               ByVal ContactDeleted As Boolean, _
               ByVal StateID As Integer, _
               ByVal CorporateEmail As String, _
               ByVal StoreName As String, _
               ByVal CountryID As Integer, _
               ByVal FranchisePrimaryContactID As Integer, _
               ByVal PrimaryContactID As Integer, _
               ByVal TimeZone As String, _
               ByVal TimeZoneID As Integer, _
               ByVal CCPaymentGateway As Integer, _
               ByVal ContactID As Integer, _
               ByVal LicenseCount As Integer _
              )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.StoreNick = StoreNick
            Me.StoreNumber = StoreNumber
            Me.CorporateName = CorporateName
            Me.Status = Status
            Me.Address = Address
            Me.City = City
            Me.ZIP = ZIP
            Me.State = State
            Me.Country = Country
            Me.Phone = Phone
            Me.Fax = Fax
            Me.OwnerName = OwnerName
            Me.StateCode = StateCode
            Me.Deleted = Deleted
            Me.ContactDeleted = ContactDeleted
            Me.StateID = StateID
            Me.CorporateEmail = CorporateEmail
            Me.StoreName = StoreName
            Me.CountryID = CountryID
            Me.FranchisePrimaryContactID = FranchisePrimaryContactID
            Me.PrimaryContactID = PrimaryContactID
            Me.TimeZone = TimeZone
            Me.TimeZoneID = TimeZoneID
            Me.CCPaymentGateway = CCPaymentGateway
            Me.ContactID = ContactID
            Me.LicenseCount = LicenseCount


        End Sub

        ' EAI 
        Public Sub New( _
         ByVal StoreNumber As Integer, _
         ByVal GrandOpening As Date, _
         ByVal Status As Integer, _
         ByVal ReqOpeningDate As Date, _
         ByVal DateSigned As Date, _
         ByVal OwnerName As String, _
         ByVal Address As String, _
         ByVal City As String, _
         ByVal StateCode As String, _
         ByVal ZIP As String, _
         ByVal Phone As String, _
         ByVal Fax As String, _
         ByVal CorporateEmail As String, _
         ByVal CorporateName As String, _
         ByVal StoreNick As String, _
         ByVal CCPaymentGateway As Integer, _
         ByVal TimeZone As String, _
         ByVal IsCorporate As Boolean, _
         ByVal IsTestStore As Boolean, _
         ByVal ClientID As Integer, _
         ByVal ClientName As String, _
         ByVal Notes As String, _
         ByVal State As String, _
         ByVal Country As String, _
         ByVal FranchiseCoordinator As String, _
         ByVal IsSuspended As Boolean, _
         ByVal IsAbandon As Boolean, _
         ByVal FranchiseID As Integer _
        )

            Me.CorporateName = CorporateName
            Me.StoreNumber = StoreNumber
            Me.Status = Status
            Me.OwnerName = OwnerName
            Me.Address = Address
            Me.City = City
            Me.StateCode = StateCode
            Me.ZIP = ZIP
            Me.Phone = Phone
            Me.Fax = Fax
            Me.DateSigned = DateSigned
            Me.GrandOpening = GrandOpening
            Me.ReqOpeningDate = ReqOpeningDate
            Me.CorporateEmail = CorporateEmail
            Me.StoreNick = StoreNick
            Me.CCPaymentGateway = CCPaymentGateway
            Me.TimeZone = TimeZone
            Me.IsCorporate = IsCorporate
            Me.IsTestStore = IsTestStore
            Me.ClientID = ClientID
            Me.ClientName = ClientName
            Me.Notes = Notes
            Me.State = State
            Me.Country = Country
            Me.FranchiseCoordinator = FranchiseCoordinator
            Me.IsSuspended = IsSuspended
            Me.IsAbandon = IsAbandon
            Me.FranchiseID = FranchiseID
	#End Sub

        Public Sub New( _
        ByVal StoreNumber As Integer, _
        ByVal GrandOpening As Date, _
        ByVal Status As Integer, _
        ByVal ReqOpeningDate As Date, _
        ByVal DateSigned As Date, _
        ByVal OwnerName As String, _
        ByVal Address As String, _
        ByVal City As String, _
        ByVal StateCode As String, _
        ByVal ZIP As String, _
        ByVal Phone As String, _
        ByVal Fax As String, _
        ByVal CorporateEmail As String, _
        ByVal CorporateName As String, _
        ByVal StoreNick As String, _
        ByVal CCPaymentGateway As Integer, _
        ByVal TimeZone As String, _
        ByVal IsCorporate As Boolean, _
        ByVal IsTestStore As Boolean, _
        ByVal ClientID As Integer, _
        ByVal ClientName As String, _
        ByVal Notes As String, _
        ByVal State As String, _
        ByVal Country As String, _
        ByVal FranchiseCoordinator As String, _
        ByVal IsSuspended As Boolean, _
        ByVal IsAbandon As Boolean, _
        ByVal FranchiseID As Integer, _
        ByVal CountryID As Integer, _
        ByVal substatus As Integer _
       )

            Me.CorporateName = CorporateName
            Me.StoreNumber = StoreNumber
            Me.Status = Status
            Me.OwnerName = OwnerName
            Me.Address = Address
            Me.City = City
            Me.StateCode = StateCode
            Me.ZIP = ZIP
            Me.Phone = Phone
            Me.Fax = Fax
            Me.DateSigned = DateSigned
            Me.GrandOpening = GrandOpening
            Me.ReqOpeningDate = ReqOpeningDate
            Me.CorporateEmail = CorporateEmail
            Me.StoreNick = StoreNick
            Me.CCPaymentGateway = CCPaymentGateway
            Me.TimeZone = TimeZone
            Me.IsCorporate = IsCorporate
            Me.IsTestStore = IsTestStore
            Me.ClientID = ClientID
            Me.ClientName = ClientName
            Me.Notes = Notes
            Me.State = State
            Me.Country = Country
            Me.FranchiseCoordinator = FranchiseCoordinator
            Me.IsSuspended = IsSuspended
            Me.IsAbandon = IsAbandon
            Me.FranchiseID = FranchiseID
            Me.CountryID = CountryID
	    Me.SubStatus = substatus
	#End Sub

        Public Sub New( _
                               ByVal Primary As Boolean, _
                               ByVal ContactID As Integer, _
                               ByVal OwnerName As String _
                         )

            Me.Primary = Primary
            Me.ContactID = ContactID
            Me.OwnerName = OwnerName
	#End Sub
#End Region


#Region " Public Method "
        Public Shared Function FranchisesGetAll(ByVal ClientID As Integer, ByVal StatusID As Integer, ByVal StateID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Franchises)
            Return Portal.DAL.Client.DBFranchises.FranchisesGetAll(ClientID, StatusID, StateID, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function

        Public Shared Function GetContactsByClientID(ByVal ClientID As Integer) As SqlDataReader
            Dim dr_Contacts As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            dr_Contacts = db.ExecuteReader("Clients_GetContactsByID")
            Return dr_Contacts
        End Function
        Public Shared Function GetPortalFranchiseID(ByVal FranchiseID As Integer, ByVal ClientID As Integer) As Integer
            Dim returnValue As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@FranchiseID", FranchiseID)
            db.AddParameter("@ClientID", ClientID)
            returnValue = CInt(db.ExecuteScalar("Franchises_GetFranchiseID_ByClientID"))
            Return returnValue
        End Function
        Public Shared Function GetFransupportFranchiseID(ByVal PortalFranchiseID As Integer) As Integer
            Dim returnValue As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ID", PortalFranchiseID)
            returnValue = CInt(db.ExecuteScalar("Franchises_GetFranFranchiseID"))
            Return returnValue
        End Function

        Public Shared Function GetFransupportFranchiseID(ByVal PortalFranchiseID As Integer, ByVal ClientID As Integer) As Integer
            Dim returnValue As Integer = 0
            Dim db As New DBAccess
            db.AddParameter("@ID", PortalFranchiseID)
            db.AddParameter("@ClientID", ClientID)
            returnValue = CInt(db.ExecuteScalar("Franchises_GetFranFranchiseIDAndClientID"))
            Return returnValue
        End Function

        Public Shared Function GetQsContactByStoreNumberandClientID(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As SqlDataReader
            Return Portal.DAL.Client.DBFranchises.GetQsContactByStoreNumberandClientID(ClientID, StoreNumber)
        End Function

        Public Function UpdateTestStoreStatus(ByVal status As Boolean, ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Dim objFranchises As New Portal.DAL.Client.DBFranchises
            Return objFranchises.UpdateTestStoreStatus(status, StoreNumber, ClientID)
        End Function

        Public Sub LogAdminActionForTestStore(ByVal ClientID As Integer, ByVal StoreNumber As Integer, ByVal Action As String, ByVal AdminID As Integer, ByVal EntryDate As Date)
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@StoreNumber", StoreNumber)
            db.AddParameter("@ActionPerformed", Action)
            db.AddParameter("@EnteredByAdminID", AdminID)
            db.AddParameter("@EnteredOn", EntryDate)
            db.ExecuteNonQuery("TestStoreLog_Add")
        End Sub

        Public Shared Function FranchiseByStoreNumberandClientID(ByVal StoreNumber As Integer, ByVal ClientID As Integer) As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@StoreNumber", StoreNumber)
            db.AddParameter("@ClientID", ClientID)
            Return db.ExecuteReader("Franchises_GetByStoreNo_ByClientID")
        End Function		
#End Region

#Region "New Methods from EAI Franchise"
        Public Shared Function FranchiseGetByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As List(Of Franchises)
            Return Portal.DAL.Client.DBFranchises.FranchiseGetByID(ClientID, FranchiseID)
        End Function
        Public Shared Function GetStoreNickByFranchiseID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As String
            Return Portal.DAL.Client.DBFranchises.GetStoreNickByFranchiseID(ClientID, FranchiseID)
        End Function
        Public Shared Function FranchisesOwnersGetByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As List(Of Franchises)
            Return Portal.DAL.Client.DBFranchises.FranchisesOwnersGetByID(ClientID, FranchiseID)
        End Function
        'Public Shared Function OwnersOtherFranchisesGetByID(ByVal FranchiseID As Integer) As DataSet
        '    Return Portal.DAL.Client.DBFranchises.OwnersOtherFranchisesGetByID(FranchiseID)
        'End Function
        Public Shared Function OwnersOtherFranchisesGetByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As DataSet
            Return Portal.DAL.Client.DBFranchises.OwnersOtherFranchisesGetByID(ClientID, FranchiseID)
        End Function
        Public Shared Function FranchisesContactByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As SqlDataReader
            Return Portal.DAL.Client.DBFranchises.FranchisesContactByID(ClientID, FranchiseID)
        End Function
        Public Shared Function OpeningDateToEmpty(ByVal OpeningDate As Date) As String
            If OpeningDate.Date = DateTime.Now.Date Then
                Return "&nbsp;"
            Else
                Return OpeningDate
            End If
        End Function
        Public Shared Function GetStoreNickByFranchiseID(ByVal FranchiseID As Integer) As String
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            Return accessObj.ExecuteScalar("Franchises_GetStoreNick_ByFranchiseID").ToString()
        End Function

        Public Shared Function GetFranchiseContactDetail(ByVal contactId As Integer, ByVal franchiseId As Integer, ByVal clientId As Integer) As Portal.BLL.Users
            Dim accessObj As DBAccess = New DBAccess()
            Dim readerContactDetail As SqlDataReader
            Dim userObj As Portal.BLL.Users = New Portal.BLL.Users()
            accessObj.AddParameter("@ContactID", contactId)
            accessObj.AddParameter("@FranchiseID", franchiseId)
            accessObj.AddParameter("@ClientID", clientId)
            readerContactDetail = accessObj.ExecuteReader("FranchiseContacts_GetDetailByID")
            readerContactDetail.Read()
            If (readerContactDetail.HasRows) Then
                userObj.Email = readerContactDetail("Email").ToString()
                userObj.UserName = readerContactDetail("ContactName").ToString()
                userObj.ID = readerContactDetail("ID").ToString()       'ID would be taken as FranchiseContactID
            End If
            readerContactDetail.Close()
            Return userObj
        End Function

        Public Shared Function CheckFranchiseProductSupportStatus(ByVal ProductID As Integer, _
                                                                  ByVal FranchiseID As Integer, _
                                                                  ByRef Notes As String) As Enumeration.ProductStatus
            Dim ProductStatus As Enumeration.ProductStatus
            Dim dbManager As New DBAccess()
            dbManager.AddParameter("@ProductID", ProductID)
            dbManager.AddParameter("@FranchiseID", FranchiseID)
            Dim rdrSupportInfo As SqlDataReader = dbManager.ExecuteReader("NS_Products_Franchises_GetSupportInfo")

            ProductStatus = Enumeration.ProductStatus.Allowed
            If rdrSupportInfo.HasRows Then
                While rdrSupportInfo.Read()
                    If Not CBool(rdrSupportInfo("OnSupport")) Then
                        ProductStatus = Enumeration.ProductStatus.TurnedOff
                        Notes = rdrSupportInfo("Notes").ToString()
                        Exit While
                    End If

                    If Date.Compare(CDate(rdrSupportInfo("SupportEnddate")), Date.Now) <= 0 Then
                        ProductStatus = Enumeration.ProductStatus.Expired
                        Exit While
                    End If
                End While
            Else
                ProductStatus = Enumeration.ProductStatus.NotSignedUp
            End If

            Return ProductStatus
        End Function

	Public Shared Function GetStoreNickByFransupportFranchiseID(ByVal FranchiseID As Integer, ByVal ClientID As Integer) As String
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            accessObj.AddParameter("@ClientID", ClientID)
            Return accessObj.ExecuteScalar("Franchises_GetStoreNick_ByFransupportFranchiseID").ToString()
        End Function		

#End Region
    End Class
End Namespace