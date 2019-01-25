Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.Client
    Public Class Clients
#Region " Private Members "
        Private _id As Integer
        Private _name As String
        Private _code As String
        Private _phone As String
        Private _fax As String
        Private _email As String
        Private _address1 As String
        Private _address2 As String
        Private _city As String
        Private _zip As String
        Private _stateid As Integer
        Private _countryid As Integer
        Private _deleted As Boolean
        Private _detail As String
        Private _billssendoption As Integer
        Private _preferredmodepayment As Integer
        Private _isfeatured As Boolean
        Private _image As String
        Private _url As String
        Private _logo As String
        Private _hasfransupport As Boolean
        Private _fransupportconnectionstring As String
        Private _lastupdateddate As DateTime
        Private _lastupdatedby As Integer

        Private _statecode As String
        Private _countrycode As String


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

        Public Property Name() As String
            Get
                Return _name
            End Get
            Set(ByVal value As String)
                _name = value
            End Set
        End Property

        Public Property Code() As String
            Get
                Return _code
            End Get
            Set(ByVal value As String)
                _code = value
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

        Public Property Email() As String
            Get
                Return _email
            End Get
            Set(ByVal value As String)
                _email = value
            End Set
        End Property

        Public Property Address1() As String
            Get
                Return _address1
            End Get
            Set(ByVal value As String)
                _address1 = value
            End Set
        End Property

        Public Property Address2() As String
            Get
                Return _address2
            End Get
            Set(ByVal value As String)
                _address2 = value
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

        Public Property Zip() As String
            Get
                Return _zip
            End Get
            Set(ByVal value As String)
                _zip = value
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

        Public Property CountryID() As Integer
            Get
                Return _countryid
            End Get
            Set(ByVal value As Integer)
                _countryid = value
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

        Public Property detail() As String
            Get
                Return _detail
            End Get
            Set(ByVal value As String)
                _detail = value
            End Set
        End Property

        Public Property BillsSendOption() As Integer
            Get
                Return _billssendoption
            End Get
            Set(ByVal value As Integer)
                _billssendoption = value
            End Set
        End Property

        Public Property PreferredModePayment() As Integer
            Get
                Return _preferredmodepayment
            End Get
            Set(ByVal value As Integer)
                _preferredmodepayment = value
            End Set
        End Property

        Public Property Isfeatured() As Boolean
            Get
                Return _isfeatured
            End Get
            Set(ByVal value As Boolean)
                _isfeatured = value
            End Set
        End Property

        Public Property Image() As String
            Get
                Return _image
            End Get
            Set(ByVal value As String)
                _image = value
            End Set
        End Property

        Public Property url() As String
            Get
                Return _url
            End Get
            Set(ByVal value As String)
                _url = value
            End Set
        End Property

        Public Property logo() As String
            Get
                Return _logo
            End Get
            Set(ByVal value As String)
                _logo = value
            End Set
        End Property

        Public Property HasFransupport() As Boolean
            Get
                Return _hasfransupport
            End Get
            Set(ByVal value As Boolean)
                _hasfransupport = value
            End Set
        End Property

        Public Property FransupportConnectionString() As String
            Get
                Return _fransupportconnectionstring
            End Get
            Set(ByVal value As String)
                _fransupportconnectionstring = value
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
        Public Property CountryCode() As String
            Get
                Return _countrycode
            End Get
            Set(ByVal value As String)
                _countrycode = value
            End Set
        End Property

        Public Property LastUpdatedDate() As DateTime
            Get
                Return _lastupdateddate
            End Get
            Set(ByVal value As DateTime)
                _lastupdateddate = value
            End Set
        End Property

        Public Property LastUpdatedBy() As Integer
            Get
                Return _lastupdatedby
            End Get
            Set(ByVal value As Integer)
                _lastupdatedby = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub

        'GetByID
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal Name As String, _
          ByVal Code As String, _
          ByVal Phone As String, _
          ByVal Fax As String, _
          ByVal Email As String, _
          ByVal Address1 As String, _
          ByVal Address2 As String, _
          ByVal City As String, _
          ByVal Zip As String, _
          ByVal StateID As Integer, _
          ByVal CountryID As Integer, _
          ByVal Deleted As Boolean, _
          ByVal detail As String, _
          ByVal BillsSendOption As Integer, _
          ByVal PreferredModePayment As Integer, _
          ByVal Isfeatured As Boolean, _
          ByVal Image As String, _
          ByVal url As String, _
          ByVal logo As String, _
          ByVal StateCode As String, _
          ByVal CountryCode As String _
         )


            Me.ID = ID
            Me.Name = Name
            Me.Code = Code
            Me.Phone = Phone
            Me.Fax = Fax
            Me.Email = Email
            Me.Address1 = Address1
            Me.Address2 = Address2
            Me.City = City
            Me.Zip = Zip
            Me.StateID = StateID
            Me.CountryID = CountryID
            Me.Deleted = Deleted
            Me.detail = detail
            Me.BillsSendOption = BillsSendOption
            Me.PreferredModePayment = PreferredModePayment
            Me.Isfeatured = Isfeatured
            Me.Image = Image
            Me.url = url
            Me.logo = logo
            Me.StateCode = StateCode
            Me.CountryCode = CountryCode

        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal Name As String, _
          ByVal Code As String, _
          ByVal Phone As String, _
          ByVal Fax As String, _
          ByVal Email As String, _
          ByVal Address1 As String, _
          ByVal Address2 As String, _
          ByVal City As String, _
          ByVal Zip As String, _
          ByVal StateID As Integer, _
          ByVal CountryID As Integer, _
          ByVal Deleted As Boolean, _
          ByVal detail As String, _
          ByVal BillsSendOption As Integer, _
          ByVal PreferredModePayment As Integer, _
          ByVal Isfeatured As Boolean, _
          ByVal Image As String, _
          ByVal url As String, _
          ByVal logo As String _
         )


            Me.ID = ID
            Me.Name = Name
            Me.Code = Code
            Me.Phone = Phone
            Me.Fax = Fax
            Me.Email = Email
            Me.Address1 = Address1
            Me.Address2 = Address2
            Me.City = City
            Me.Zip = Zip
            Me.StateID = StateID
            Me.CountryID = CountryID
            Me.Deleted = Deleted
            Me.detail = detail
            Me.BillsSendOption = BillsSendOption
            Me.PreferredModePayment = PreferredModePayment
            Me.Isfeatured = Isfeatured
            Me.Image = Image
            Me.url = url
            Me.logo = logo

        End Sub
#End Region

#Region " Public Method "
        Public Shared Function ClientsGetAll() As List(Of Clients)
            Return Portal.DAL.Client.DBClients.ClientsGetAll()
        End Function
        Public Shared Function ClientsGetByID(ByVal ID As Integer) As List(Of Clients)
            Return Portal.DAL.Client.DBClients.ClientsGetByID(ID)
        End Function
        Public Shared Function ClientsAdd(ByVal ID As Integer, ByVal Name As String, ByVal Code As String, ByVal Phone As String, ByVal Fax As String, ByVal Email As String, ByVal Address1 As String, ByVal Address2 As String, ByVal City As String, ByVal Zip As String, ByVal StateID As Integer, ByVal CountryID As Integer, ByVal Deleted As Boolean, ByVal detail As String, ByVal BillsSendOption As Integer, ByVal PreferredModePayment As Integer, ByVal Isfeatured As Boolean, ByVal Image As String, ByVal url As String, ByVal logo As String) As Integer
            Dim ClientsBll As Portal.BLL.Client.Clients = New Portal.BLL.Client.Clients(ID, Name, Code, Phone, Fax, Email, Address1, Address2, City, Zip, StateID, CountryID, Deleted, detail, BillsSendOption, PreferredModePayment, Isfeatured, Image, url, logo)
            Dim ClientsDal As Portal.DAL.Client.DBClients = New Portal.DAL.Client.DBClients()
            Return ClientsDal.Add(ClientsBll)
        End Function
        Public Shared Function ClientsUpdate(ByVal ID As Integer, ByVal Name As String, ByVal Code As String, ByVal Phone As String, ByVal Fax As String, ByVal Email As String, ByVal Address1 As String, ByVal Address2 As String, ByVal City As String, ByVal Zip As String, ByVal StateID As Integer, ByVal CountryID As Integer, ByVal Deleted As Boolean, ByVal detail As String, ByVal BillsSendOption As Integer, ByVal PreferredModePayment As Integer, ByVal Isfeatured As Boolean, ByVal Image As String, ByVal url As String, ByVal logo As String) As Integer
            Dim ClientsBll As Portal.BLL.Client.Clients = New Portal.BLL.Client.Clients(ID, Name, Code, Phone, Fax, Email, Address1, Address2, City, Zip, StateID, CountryID, Deleted, detail, BillsSendOption, PreferredModePayment, Isfeatured, Image, url, logo)
            Dim ClientsDal As Portal.DAL.Client.DBClients = New Portal.DAL.Client.DBClients()
            Return ClientsDal.Update(ClientsBll)
        End Function
        Public Shared Function Client_Delete(ByVal ID As Integer, ByVal Deleted As Boolean) As Integer
            Dim ClientsDal As Portal.DAL.Client.DBClients = New Portal.DAL.Client.DBClients()
            Return ClientsDal.Delete(ID, Deleted)
        End Function
        Public Shared Function ClientDuplicateName(ByVal ID As Integer, ByVal Name As String) As Integer
            Return Portal.DAL.Client.DBClients.ClientDuplicateName(ID, Name)
        End Function
		Public Shared Function GetFransupportConnectionStringByClientID(ByVal ID As Integer) As String
            Return Portal.DAL.Client.DBClients.GetFransupportConnectionStringByClientID(ID)
        End Function
#End Region

    End Class
End Namespace