							Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.Client
    Public Class Client_Contacts
#Region " Private Members "
        Private _id As Integer
        Private _clientid As Integer
        Private _adminid As Integer
        Private _areadeveloperid As Integer
        Private _contactid As Integer
        Private _firstname As String
        Private _name As String
        Private _middlename As String
        Private _lastname As String
        Private _gender As String
        Private _jobtitle As String
        Private _homephone As String
        Private _workphone As String
        Private _cellphone As String
        Private _fax As String
        Private _email1 As String
        Private _email2 As String
        Private _address As String
        Private _address2 As String
        Private _city As String
        Private _zip As String
        Private _stateid As Integer
        Private _countryid As Integer
        Private _contacttype As Integer
        Private _deleted As Boolean
        Private _inactive As Boolean
        Private _lastupdateddate As DateTime
        Private _lastupdatedby As Integer
        Private _isadmin As Boolean
        Private _username As String
        Private _password As String
        Private _notes As String
        Private _HasPMFullAccess As Boolean
        Private _HasTicketApprovalAccess As Boolean
        Private _StatusChangedDate As DateTime
        Private _StatusChangedBy As String
        Private _Status As Boolean
        Private _AddFromFSByAdminId As Integer
        Private _HasURLMAccess As Boolean

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

        Public Property AdminID() As Integer
            Get
                Return _adminid
            End Get
            Set(ByVal value As Integer)
                _adminid = value
            End Set
        End Property

        Public Property AreaDeveloperID() As Integer
            Get
                Return _areadeveloperid
            End Get
            Set(ByVal value As Integer)
                _areadeveloperid = value
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

        Public Property FirstName() As String
            Get
                Return _firstname
            End Get
            Set(ByVal value As String)
                _firstname = value
            End Set
        End Property

        Public Property MiddleName() As String
            Get
                Return _middlename
            End Get
            Set(ByVal value As String)
                _middlename = value
            End Set
        End Property

        Public Property LastName() As String
            Get
                Return _lastname
            End Get
            Set(ByVal value As String)
                _lastname = value
            End Set
        End Property

        Public Property Gender() As Boolean
            Get
                Return _gender
            End Get
            Set(ByVal value As Boolean)
                _gender = value
            End Set
        End Property


        Public Property JobTitle() As String
            Get
                Return _jobtitle
            End Get
            Set(ByVal value As String)
                _jobtitle = value
            End Set
        End Property

        Public Property HomePhone() As String
            Get
                Return _homephone
            End Get
            Set(ByVal value As String)
                _homephone = value
            End Set
        End Property

        Public Property WorkPhone() As String
            Get
                Return _workphone
            End Get
            Set(ByVal value As String)
                _workphone = value
            End Set
        End Property

        Public Property CellPhone() As String
            Get
                Return _cellphone
            End Get
            Set(ByVal value As String)
                _cellphone = value
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

        Public Property Email1() As String
            Get
                Return _email1
            End Get
            Set(ByVal value As String)
                _email1 = value
            End Set
        End Property

        Public Property Email2() As String
            Get
                Return _email2
            End Get
            Set(ByVal value As String)
                _email2 = value
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

        Public Property ContactType() As Integer
            Get
                Return _contacttype
            End Get
            Set(ByVal value As Integer)
                _contacttype = value
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

        Public Property Inactive() As Boolean
            Get
                Return _inactive
            End Get
            Set(ByVal value As Boolean)
                _inactive = value
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

        Public Property IsAdmin() As Boolean
            Get
                Return _isadmin
            End Get
            Set(ByVal value As Boolean)
                _isadmin = value
            End Set
        End Property

        Public Property AddFromFSByAdminId() As Integer
            Get
                Return _AddFromFSByAdminId
            End Get
            Set(ByVal value As Integer)
                _AddFromFSByAdminId = value
            End Set
        End Property

        Public Property UserName() As String
            Get
                Return _username
            End Get
            Set(ByVal value As String)
                _username = value
            End Set
        End Property

        Public Property PassWord() As String
            Get
                Return _password
            End Get
            Set(ByVal value As String)
                _password = value
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
        Public Property Notes() As String
            Get
                Return _notes
            End Get
            Set(ByVal value As String)
                _notes = value
            End Set
        End Property

        Public Property HasPMFullAccess() As Boolean
            Get
                Return _HasPMFullAccess
            End Get
            Set(ByVal value As Boolean)
                _HasPMFullAccess = value
            End Set
        End Property

        Public Property StatusChangedDate() As DateTime
            Get
                Return _StatusChangedDate
            End Get
            Set(ByVal value As DateTime)
                _StatusChangedDate = value
            End Set
        End Property

        Public Property HasTicketApprovalAccess() As Boolean
            Get
                Return _HasTicketApprovalAccess
            End Get
            Set(ByVal value As Boolean)
                _HasTicketApprovalAccess = value
            End Set
        End Property

        Public Property StatusChangedBy() As String
            Get
                Return _StatusChangedBy
            End Get
            Set(ByVal value As String)
                _StatusChangedBy = value
            End Set
        End Property

        Public Property Status() As Boolean
            Get
                Return _Status
            End Get
            Set(ByVal value As Boolean)
                _Status = value
            End Set
        End Property

        Public Property HasURLMAccess() As Boolean
            Get
                Return _HasURLMAccess
            End Get
            Set(ByVal value As Boolean)
                _HasURLMAccess = value
            End Set
        End Property
#End Region

#Region " Constructor "
        Public Sub New()
        End Sub
        Public Sub New( _
                   ByVal Notes As String _
                   )
            Me.Notes = Notes

        End Sub
        Public Sub New( _
                  ByVal ID As Integer, _
                  ByVal ClinetID As Integer, _
                  ByVal Name As String, _
                  ByVal HomePhone As String, _
                  ByVal Email1 As String, _
                  ByVal Address As String, _
                  ByVal Deleted As Boolean _
                  )

            Me.ID = ID
            Me.ClientID = ClientID
            Me.Name = Name
            Me.HomePhone = HomePhone
            Me.Email1 = Email1
            Me.Address = Address
            Me.Deleted = Deleted
        End Sub
        Public Sub New( _
                  ByVal ClientID As Integer, _
                  ByVal AdminID As Integer, _
                  ByVal AreaDeveloperID As Integer, _
                  ByVal ContactID As Integer, _
                  ByVal FirstName As String, _
                  ByVal MiddleName As String, _
                  ByVal LastName As String, _
                   ByVal Gender As Boolean, _
                  ByVal JobTitle As String, _
                  ByVal HomePhone As String, _
                  ByVal WorkPhone As String, _
                  ByVal CellPhone As String, _
                  ByVal Fax As String, _
                  ByVal Email1 As String, _
                  ByVal Email2 As String, _
                  ByVal Address As String, _
                  ByVal Address2 As String, _
                  ByVal City As String, _
                  ByVal Zip As String, _
                  ByVal StateID As Integer, _
                  ByVal CountryID As Integer, _
                  ByVal ContactType As Integer, _
                  ByVal Deleted As Boolean, _
                  ByVal UserName As String, _
                  ByVal Password As String, _
                  ByVal IsAdmin As Boolean, ByVal HasURLMAccess As Boolean)



            Me.ClientID = ClientID
            Me.AdminID = AdminID
            Me.AreaDeveloperID = AreaDeveloperID
            Me.ContactID = ContactID
            Me.FirstName = FirstName
            Me.MiddleName = MiddleName
            Me.LastName = LastName
            Me.Gender = Gender
            Me.JobTitle = JobTitle
            Me.HomePhone = HomePhone
            Me.WorkPhone = WorkPhone
            Me.CellPhone = CellPhone
            Me.Fax = Fax
            Me.Email1 = Email1
            Me.Email2 = Email2
            Me.Address = Address
            Me.Address2 = Address2
            Me.City = City
            Me.Zip = Zip
            Me.StateID = StateID
            Me.CountryID = CountryID
            Me.ContactType = ContactType
            Me.Deleted = Deleted
            Me.UserName = UserName
            Me.PassWord = Password
            Me.IsAdmin = IsAdmin
            Me.HasURLMAccess = HasURLMAccess


        End Sub
        Public Sub New( _
                  ByVal ID As Integer, _
                  ByVal ClientID As Integer, _
                  ByVal AdminID As Integer, _
                  ByVal AreaDeveloperID As Integer, _
                  ByVal ContactID As Integer, _
                  ByVal FirstName As String, _
                  ByVal MiddleName As String, _
                  ByVal LastName As String, _
                  ByVal JobTitle As String, _
                  ByVal HomePhone As String, _
                  ByVal WorkPhone As String, _
                  ByVal CellPhone As String, _
                  ByVal Fax As String, _
                  ByVal Email1 As String, _
                  ByVal Email2 As String, _
                  ByVal Address As String, _
                  ByVal City As String, _
                  ByVal Zip As String, _
                  ByVal StateID As Integer, _
                  ByVal CountryID As Integer, _
                  ByVal ContactType As Integer, _
                  ByVal Deleted As Boolean, _
                  ByVal Inactive As Boolean _
                 )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.AdminID = AdminID
            Me.AreaDeveloperID = AreaDeveloperID
            Me.ContactID = ContactID
            Me.FirstName = FirstName
            Me.MiddleName = MiddleName
            Me.LastName = LastName
            Me.JobTitle = JobTitle
            Me.HomePhone = HomePhone
            Me.WorkPhone = WorkPhone
            Me.CellPhone = CellPhone
            Me.Fax = Fax
            Me.Email1 = Email1
            Me.Email2 = Email2
            Me.Address = Address
            Me.City = City
            Me.Zip = Zip
            Me.StateID = StateID
            Me.CountryID = CountryID
            Me.ContactType = ContactType
            Me.Deleted = Deleted
            Me.Inactive = Inactive


        End Sub
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ClientID As Integer, _
          ByVal AdminID As Integer, _
          ByVal AreaDeveloperID As Integer, _
          ByVal ContactID As Integer, _
          ByVal FirstName As String, _
          ByVal MiddleName As String, _
          ByVal LastName As String, _
          ByVal Gender As Boolean, _
          ByVal JobTitle As String, _
          ByVal HomePhone As String, _
          ByVal WorkPhone As String, _
          ByVal CellPhone As String, _
          ByVal Fax As String, _
          ByVal Email1 As String, _
          ByVal Email2 As String, _
          ByVal Address As String, _
          ByVal Address2 As String, _
          ByVal City As String, _
          ByVal Zip As String, _
          ByVal StateID As Integer, _
          ByVal CountryID As Integer, _
          ByVal ContactType As Integer, _
          ByVal Deleted As Boolean, _
          ByVal UserName As String, _
          ByVal IsAdmin As Boolean, _
          ByVal HasURLMAccess As Boolean _
         )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.AdminID = AdminID
            Me.AreaDeveloperID = AreaDeveloperID
            Me.ContactID = ContactID
            Me.FirstName = FirstName
            Me.MiddleName = MiddleName
            Me.LastName = LastName
            Me.Gender = Gender
            Me.JobTitle = JobTitle
            Me.HomePhone = HomePhone
            Me.WorkPhone = WorkPhone
            Me.CellPhone = CellPhone
            Me.Fax = Fax
            Me.Email1 = Email1
            Me.Email2 = Email2
            Me.Address = Address
            Me.Address2 = Address2
            Me.City = City
            Me.Zip = Zip
            Me.StateID = StateID
            Me.CountryID = CountryID
            Me.ContactType = ContactType
            Me.Deleted = Deleted
            Me.UserName = UserName
            Me.IsAdmin = IsAdmin
            Me.HasURLMAccess = HasURLMAccess


        End Sub
#End Region

#Region " Public Method "
        Public Shared Function Client_ContactsGetByID(ByVal ID As Integer) As List(Of Client_Contacts)
            Return Portal.DAL.Client.DBClient_Contacts.Client_ContactsGetByID(ID)
        End Function
        Public Function GetClients() As String(,)
            Dim dal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Return dal.GetClients()
        End Function
        Public Shared Function ResetStatus(ByVal ID As Integer, ByVal Status As Boolean) As Integer
            Dim dal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Return dal.ResetStatus(ID, Status)
        End Function

        Public Shared Function ClientsContactsGetAllCount(ByVal ClientID As Integer, ByVal UserType As Integer, ByVal InActive As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Return Portal.DAL.Client.DBClient_Contacts.ClientsContactsGetAllCount(ClientID, UserType, InActive, sortExpression, txtsearch)
        End Function
        Public Shared Function ClientsContactsGetAll(ByVal ClientID As Integer, ByVal UserType As Integer, ByVal InActive As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Return Portal.DAL.Client.DBClient_Contacts.ClientsContactsGetAll(ClientID, UserType, InActive, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Function GetModules_SubModules(ByVal UserID As Integer, ByVal ClientID As Integer) As DataSet
            Dim dal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Return dal.GetModules_SubModules(UserID, ClientID)
        End Function
        Public Function UsersAccess_Delete(ByVal UserID As Integer) As Integer
            Dim objUserDal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Dim Affected As Integer = objUserDal.AccessDelete(UserID)
            Return Affected
        End Function
        Public Shared Function ClientsContactsGetNotes(ByVal UserID As Integer) As Portal.BLL.Client.ClientContactNotes
            Return Portal.DAL.Client.DBClient_Contacts.ClientsContactsGetNotes(UserID)
        End Function
        Public Function UsersAccess_Insert(ByVal sqlQuery As String) As Integer

            Dim objUserDal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Dim Affected As Integer = objUserDal.SQLInsert(sqlQuery)
            Return Affected
        End Function

        Public Shared Function Client_ContactsAdd(ByVal ClientID As Integer, ByVal AdminID As Integer, ByVal AreaDeveloperID As Integer, ByVal ContactID As Integer, ByVal FirstName As String, ByVal MiddleName As String, ByVal LastName As String, ByVal Gender As Boolean, ByVal JobTitle As String, ByVal HomePhone As String, ByVal WorkPhone As String, ByVal CellPhone As String, ByVal Fax As String, ByVal Email1 As String, ByVal Email2 As String, ByVal Address As String, ByVal Address2 As String, ByVal City As String, ByVal Zip As String, ByVal StateID As Integer, ByVal CountryID As Integer, ByVal ContactType As Integer, ByVal Deleted As Boolean, ByVal UserName As String, ByVal Password As String, ByVal IsAdmin As Boolean, ByVal hasURLMAccess As Boolean) As Integer
            If Password = "" Then
                Dim strPass As String = Portal.BLL.Users.GenerateNewPassWord()
                Password = strPass 'Functions.EncryptData(strPass)
            End If
            Dim Client_ContactsBll As Portal.BLL.Client.Client_Contacts = New Portal.BLL.Client.Client_Contacts(ClientID, AdminID, AreaDeveloperID, ContactID, FirstName, MiddleName, LastName, Gender, JobTitle, HomePhone, WorkPhone, CellPhone, Fax, Email1, Email2, Address, Address2, City, Zip, StateID, CountryID, ContactType, Deleted, UserName, Password, IsAdmin, hasURLMAccess)
            Dim Client_ContactsDal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Return Client_ContactsDal.Add(Client_ContactsBll)
        End Function
        Public Shared Function Client_ContactsUpdate(ByVal ID As Integer, ByVal ClientID As Integer, ByVal AdminID As Integer, ByVal AreaDeveloperID As Integer, ByVal ContactID As Integer, ByVal FirstName As String, ByVal MiddleName As String, ByVal LastName As String, ByVal Gender As Boolean, ByVal JobTitle As String, ByVal HomePhone As String, ByVal WorkPhone As String, ByVal CellPhone As String, ByVal Fax As String, ByVal Email1 As String, ByVal Email2 As String, ByVal Address As String, ByVal Address2 As String, ByVal City As String, ByVal Zip As String, ByVal StateID As Integer, ByVal CountryID As Integer, ByVal ContactType As Integer, ByVal Deleted As Boolean, ByVal UserName As String, ByVal IsAdmin As Boolean, ByVal HasURLMAccess As Boolean) As Integer
            Dim Client_ContactsBll As Portal.BLL.Client.Client_Contacts = New Portal.BLL.Client.Client_Contacts(ID, ClientID, AdminID, AreaDeveloperID, ContactID, FirstName, MiddleName, LastName, Gender, JobTitle, HomePhone, WorkPhone, CellPhone, Fax, Email1, Email2, Address, Address, City, Zip, StateID, CountryID, ContactType, Deleted, UserName, IsAdmin, HasURLMAccess)
            Dim Client_ContactsDal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Return Client_ContactsDal.Update(Client_ContactsBll)
        End Function

        Public Shared Function Client_ContactsDelete(ByVal ID As Integer, ByVal Deleted As Boolean) As Integer
            Dim Client_ContactsDal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Return Client_ContactsDal.Delete(ID, Deleted)
        End Function
        Public Shared Function ValidateMyNetsolaceUsers(ByVal UserName As String, ByVal Password As String, ByVal txtClientCode As Integer) As Boolean
            Dim colClient_Contacts As New Portal.BLL.Client.Client_Contacts
            Dim ReturnType As Boolean = True
            Dim dr As SqlClient.SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@UserName", UserName)
            db.AddParameter("@Password", Password)
            db.AddParameter("@ClientCodeID", txtClientCode)
            dr = db.ExecuteReader("MyNetsolace_ValidateUser")
            If dr.HasRows Then
                While dr.Read()
                    OnlyAddSessionOfMyNetsolace(0, 0, CInt(dr("ID")), CStr(dr("Email1")), CStr(dr("ContactName")), CStr(dr("ClientID")), dr("IsAdmin"), Nothing, True)
                    ReturnType = True
                End While
            Else
                ReturnType = False
            End If
            dr.Close()
            Return ReturnType
        End Function
        Public Shared Function ValidateAreaDeveloper(ByVal UserName As String, ByVal Password As String, ByVal txtClientCode As Integer) As Boolean
            Dim colClient_Contacts As New Portal.BLL.Client.Client_Contacts
            Dim ReturnType As Boolean = True
            Dim dr As SqlClient.SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@UserName", UserName)
            db.AddParameter("@Password", Password)
            db.AddParameter("@ClientCodeID", txtClientCode)
            dr = db.ExecuteReader("AreaDeveloper_ValidateUser")
            If dr.HasRows Then
                While dr.Read()
                    OnlyAddSessionOfMyNetsolace(0, CInt(dr("AreaDeveloperId")), CInt(dr("ID")), CStr(dr("Email1")), CStr(dr("ContactName")), CStr(dr("ClientID")), dr("IsAdmin"), Nothing, True)
                    ReturnType = True
                End While
            Else
                ReturnType = False
            End If
            dr.Close()
            Return ReturnType
        End Function
        Public Function GetUserStatusByID(ByVal ID As Integer) As Boolean
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            Dim RetVal As Integer = db.ExecuteScalar("ClientContact_GetUserStatus")
            If RetVal = 0 Then
                Return False
            Else
                Return True
            End If

        End Function

        Public Shared Sub ClientContact_UpdateNotes(ByVal ID As Integer, ByVal Status As Boolean, ByVal Notes As String)
            Dim db As New DBAccess
            db.AddParameter("@UserID", ID)
            db.AddParameter("@Status", Status)
            db.AddParameter("@ChangedBy", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            db.AddParameter("@Notes", Notes)
            db.ExecuteNonQuery("ClientContact_UpdateNotes")
        End Sub
        Public Shared Sub ClientContact_InsertNotes(ByVal ID As Integer, ByVal Status As Boolean, ByVal Notes As String)
            Dim db As New DBAccess
            db.AddParameter("@UserID", ID)
            db.AddParameter("@Status", Status)
            db.AddParameter("@ChangedBy", CInt(HttpContext.Current.Session("MyNetsolace_ClientContactID")))
            db.AddParameter("@Notes", Notes)
            db.ExecuteNonQuery("ClientContact_InsertNotes")
        End Sub

        Public Shared Function GetClientContactEmails(ByVal FranchiseID As Integer) As System.Collections.ArrayList
            Return Portal.DAL.Client.DBClient_Contacts.GetClientContactEmails(FranchiseID)
        End Function


        Public Shared Function AuthenticateCorporateUser(ByVal ClientID As Integer, ByVal AdminID As Integer) As Integer
            Dim accessObj As DBAccess = New DBAccess()
            Dim ClientContactID As Integer = 0
            Dim userObj As Portal.BLL.Users = New Portal.BLL.Users()
            Dim readerAdmin As SqlClient.SqlDataReader = Nothing
            accessObj.AddParameter("@AdminID", AdminID)
            accessObj.AddParameter("@ClientID", ClientID)
            Try
                readerAdmin = accessObj.ExecuteReader("ClientContact_VerifyAdminID")
                If (readerAdmin.HasRows = True) Then
                    readerAdmin.Read()

                    OnlyAddSessionOfMyNetsolace(AdminID, 0, CInt(readerAdmin("ID")), CStr(readerAdmin("Email1")), CStr(readerAdmin("ContactName")), ClientID, readerAdmin("IsAdmin"), Nothing, False)
                    HttpContext.Current.Session.Add("MyNetsolace_HasURLMAccess", readerAdmin("HasURLMAccess"))
                    ClientContactID = HttpContext.Current.Session("MyNetsolace_ClientContactID")
                End If
            Catch ex As Exception

            Finally
                readerAdmin.Close()
            End Try
            Return ClientContactID
        End Function


        Public Function AuthenticateAreaDeveloper(ByVal ContactID As Integer, ByVal AreaDeveloperID As Integer, ByVal ClientID As Integer) As Integer
            Dim objAccess As DBAccess = New DBAccess()
            Dim readerAreaDeveloper As SqlClient.SqlDataReader = Nothing
            Dim ClientContactID As Integer = 0
            Dim objUser As Portal.BLL.Users = New Portal.BLL.Users()
            objAccess.AddParameter("@ContactID", ContactID)
            objAccess.AddParameter("@AreaDeveloperID", AreaDeveloperID)
            objAccess.AddParameter("@ClientID", ClientID)
            Try
                readerAreaDeveloper = objAccess.ExecuteReader("ClientContacts_AuthenticateAreaDeveloper")
                If (readerAreaDeveloper.HasRows = True) Then
                    readerAreaDeveloper.Read()

                    OnlyAddSessionOfMyNetsolace(0, AreaDeveloperID, CInt(readerAreaDeveloper("ID")), CStr(readerAreaDeveloper("Email1")), CStr(readerAreaDeveloper("ContactName")), ClientID, False, Nothing, False)
                    ClientContactID = HttpContext.Current.Session("MyNetsolace_ClientContactID")
                End If
            Catch ex As Exception

            Finally
                readerAreaDeveloper.Close()
            End Try
            Return ClientContactID
        End Function
        Public Shared Sub OnlyAddSessionOfMyNetsolace(ByVal MyNetsolace_AdminID As Integer, ByVal MyNetsolace_AreaDeveloperID As Integer, ByVal MyNetsolace_ClientContactID As Integer, ByVal MyNetsolace_ClientContactEmail As String, ByVal MyNetsolace_ClientContactName As String, ByVal MyNetsolace_ClientID As Integer, ByVal MyNetsolace_ClientContactIsAdmin As Boolean, ByVal FranchiseContactID As Object, ByVal MyNetsolace_IstVisit As Boolean)
            HttpContext.Current.Session.Add("MyNetsolace_AdminID", MyNetsolace_AdminID)
            HttpContext.Current.Session.Add("MyNetsolace_AreaDeveloperID", MyNetsolace_AreaDeveloperID)
            HttpContext.Current.Session.Add("MyNetsolace_ClientContactID", MyNetsolace_ClientContactID)
            HttpContext.Current.Session.Add("MyNetsolace_ClientContactEmail", MyNetsolace_ClientContactEmail)
            HttpContext.Current.Session.Add("MyNetsolace_ClientContactName", MyNetsolace_ClientContactName)
            HttpContext.Current.Session.Add("MyNetsolace_ClientID", MyNetsolace_ClientID)
            HttpContext.Current.Session.Add("MyNetsolace_ClientContactIsAdmin", MyNetsolace_ClientContactIsAdmin)
            HttpContext.Current.Session.Add("FranchiseContactID", FranchiseContactID)
            HttpContext.Current.Session.Add("MyNetsolace_IstVisit", MyNetsolace_IstVisit)
        End Sub

        Public Shared Sub RemoveSessionOfMyNetsolace()
            Dim IstVisit As Boolean = False
            If Not String.IsNullOrEmpty(HttpContext.Current.Session("MyNetsolace_IstVisit")) Then
                IstVisit = HttpContext.Current.Session("MyNetsolace_IstVisit")
            End If

            OnlyRemoveSessionOfMyNetsolace()

            If IstVisit Then
                HttpContext.Current.Response.Redirect("~/Mynetsolace/Default.aspx")
            Else
                HttpContext.Current.Response.Redirect("~/Mynetsolace/Sessionexpired.htm")
            End If

        End Sub

        Public Shared Sub RemoveSessionOfMyNetsolaceClient()
            Dim IstVisit As Boolean = False
            If Not String.IsNullOrEmpty(HttpContext.Current.Session("MyNetsolace_IstVisit")) Then
                IstVisit = HttpContext.Current.Session("MyNetsolace_IstVisit")
            End If

            OnlyRemoveSessionOfMyNetsolace()

            If IstVisit Then
                HttpContext.Current.Response.Redirect("~/MynetsolaceClient/Default.aspx")
            Else
                HttpContext.Current.Response.Redirect("~/MynetsolaceClient/Sessionexpired.htm")
            End If

        End Sub

        Public Shared Sub RemoveSessionOfMyNetsolaceMaster()
            Dim IstVisit As Boolean = False
            If Not String.IsNullOrEmpty(HttpContext.Current.Session("MyNetsolace_IstVisit")) Then
                IstVisit = HttpContext.Current.Session("MyNetsolace_IstVisit")
            End If

            OnlyRemoveSessionOfMyNetsolace()

            If IstVisit Then
                HttpContext.Current.Response.Redirect("~/AreaDeveloper/Default.aspx")
            Else
                HttpContext.Current.Response.Redirect("~/AreaDeveloper/Sessionexpired.htm")
            End If

        End Sub

        Public Shared Sub OnlyRemoveSessionOfMyNetsolace()
            HttpContext.Current.Session.Remove("MyNetsolace_AdminID")
            HttpContext.Current.Session.Remove("MyNetsolace_AreaDeveloperID")
            HttpContext.Current.Session.Remove("MyNetsolace_ClientContactID")
            HttpContext.Current.Session.Remove("MyNetsolace_ClientContactEmail")
            HttpContext.Current.Session.Remove("MyNetsolace_ClientContactName")
            HttpContext.Current.Session.Remove("MyNetsolace_ClientID")
            HttpContext.Current.Session.Remove("MyNetsolace_ClientContactIsAdmin")
            HttpContext.Current.Session.Remove("FranchiseContactID")
            HttpContext.Current.Session.Remove("MyNetsolace_IstVisit")
        End Sub

        Public Shared Function ChangePassword(ByVal ID As Integer, ByVal OldPassword As String, ByVal NewPassword As String) As Integer
            Dim dal As Portal.DAL.Client.DBClient_Contacts = New Portal.DAL.Client.DBClient_Contacts()
            Return dal.ChangePassword(ID, OldPassword, NewPassword)
        End Function


        Public Shared Function ResetPassword(ByVal ID As Integer, ByVal NewPassword As String) As Integer
            Return Portal.DAL.Client.DBClient_Contacts.ResetPassword(ID, NewPassword)
        End Function


        Public Sub SendWebMailAccess(ByVal FullName As String, ByVal Username As String, ByVal Password As String, ByVal Subject As String, ByVal Title As String, ByVal EmailTo As String, ByVal EmailCC As String, ByVal EmailFrom As String, ByVal EmailFromName As String)

            Dim mail As Portal.BLL.Email
            Dim link As String = String.Empty
            mail = New Portal.BLL.Email()
            Dim strBody As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/ChangePasswordClientContact.htm"))


            With mail
                .LeadID = 0
                .MailTo = EmailTo
                .MailFrom = EmailFrom
                .DisplayName = EmailFromName
                .MailBCC = ""
                .MailCC = EmailCC
                .Subject = Subject
                .TaskType = 3
                .Detail = strBody.Replace("@Fullname", FullName).Replace("@UserName", Username).Replace("@Password", Password).Replace("@title", Title)
                .CompletedDate = System.DateTime.Now
                .Send_mail()
            End With
        End Sub

#End Region

    End Class
End Namespace