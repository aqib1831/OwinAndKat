Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports Google.GData.Apps


Namespace Portal.BLL
<Serializable()> Public Class Users
#Region " Private Members "
        Private _Id As Integer
        Private _firstname As String
        Private _middlename As String
        Private _lastname As String
        Private _username As String
        Private _password As String
        Private _pincard As String
        Private _ssn As String
        Private _ip As String
        Private _ip2 As String
        Private _jobtitle As String
        Private _email As String
        Private _address As String

        Private _city As String
        Private _region As String
        Private _zip As String
        Private _countryId As Integer
        Private _stateId As Integer
        Private _homephone As String
        Private _workphone As String
        Private _cellphone As String
        Private _fax As String

        Private _remoteuser As Boolean
        Private _inactive As Boolean
        Private _deleted As Boolean
        Private _timezoneID As Integer
        Private _istimeexampted As Boolean
        Private _gender As Boolean
        Private _hiringdate As Date
        Private _dob As Date


        Private _departmentid As Integer
        Private _teamid As Integer
        Private _officeid As Integer
        Private _name As String
        Private _status As String
        Private _Type As Integer
        Private _FrutationID As Integer
        Private _FranSupportID As Integer

        Private _ChangePassword As Integer
        Private _ChangePassDate As DateTime
        Private _SecurityCode As Integer

        Private _StatusChangedBy As String
        Private _StatusChangedDate As Date
        Private _StatusNotes As String
        Private _RFID As String
        Private _FranMail_Username As String
        Private _FranMail_Password As String
        Private _ChangePasswordAccess As Boolean
        Private _PersonalEamil As String
        Private _TeamsUnder As String = String.Empty		
        Private _OfficeTimingProfileID As Integer = 0
		Private _OffSaturdayGroup As Integer = 0
        Private _isEmailWorking As Boolean = False

		
#End Region

#Region " Public Properties "

        Public Property ID() As Integer
            Get
                Return _Id
            End Get
            Set(ByVal value As Integer)
                _Id = value
            End Set
        End Property
        Public Property Firstname() As String
            Get
                Return _firstname
            End Get
            Set(ByVal value As String)
                _firstname = value
            End Set
        End Property
        Public Property Middlename() As String
            Get
                Return _middlename
            End Get
            Set(ByVal value As String)
                _middlename = value
            End Set
        End Property
        Public Property Lastname() As String
            Get
                Return _lastname
            End Get
            Set(ByVal value As String)
                _lastname = value
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
        Public Property Password() As String
            Get
                Return _password
            End Get
            Set(ByVal value As String)
                _password = value
            End Set
        End Property

        Public Property PinCard() As String
            Get
                Return _pincard
            End Get
            Set(ByVal value As String)
                _pincard = value
            End Set
        End Property
        Public Property Ssn() As String
            Get
                Return _ssn
            End Get
            Set(ByVal value As String)
                _ssn = value
            End Set
        End Property
        Public Property IP() As String
            Get
                Return _ip
            End Get
            Set(ByVal value As String)
                _ip = value
            End Set
        End Property
        Public Property IP2() As String
            Get
                Return _ip2
            End Get
            Set(ByVal value As String)
                _ip2 = value
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
        Public Property Email() As String
            Get
                Return _email
            End Get
            Set(ByVal value As String)
                _email = value
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
        Public Property Region() As String
            Get
                Return _region
            End Get
            Set(ByVal value As String)
                _region = value
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
        Public Property CountryID() As Integer
            Get
                Return _countryId
            End Get
            Set(ByVal value As Integer)
                _countryId = value
            End Set
        End Property
        Public Property StateID() As Integer
            Get
                Return _stateId
            End Get
            Set(ByVal value As Integer)
                _stateId = value
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


        Public Property RemoteUser() As Boolean
            Get
                Return _remoteuser
            End Get
            Set(ByVal value As Boolean)
                _remoteuser = value
            End Set
        End Property
        Public Property TimeZoneID() As Integer
            Get
                Return _timezoneID
            End Get
            Set(ByVal value As Integer)
                _timezoneID = value
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
        Public Property Deleted() As Boolean
            Get
                Return _deleted
            End Get
            Set(ByVal value As Boolean)

                _deleted = value
            End Set
        End Property
        Public Property IsTimeExampted() As Boolean

            Get
                Return _istimeexampted
            End Get
            Set(ByVal value As Boolean)
                _istimeexampted = value
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
        Public Property HiringDate() As Date
            Get
                Return _hiringdate
            End Get
            Set(ByVal value As Date)
                _hiringdate = value
            End Set
        End Property
        Public Property DOB() As Date
            Get
                Return _dob
            End Get
            Set(ByVal value As Date)
                _dob = value
            End Set
        End Property

        Public Property DepartmentID() As Integer
            Get
                Return _departmentid
            End Get
            Set(ByVal value As Integer)
                _departmentid = value
            End Set
        End Property
        Public Property TeamID() As Integer
            Get
                Return _teamid
            End Get
            Set(ByVal value As Integer)
                _teamid = value
            End Set
        End Property
        Public Property OfficeID() As Integer
            Get
                Return _officeid
            End Get
            Set(ByVal value As Integer)
                _officeid = value
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
        Public Property Status() As String
            Get
                Return _status
            End Get
            Set(ByVal value As String)
                _status = value
            End Set
        End Property
        Public Property Type() As Integer
            Get
                Return _Type
            End Get
            Set(ByVal value As Integer)
                _Type = value
            End Set
        End Property

        Public Property FrutationID() As Integer
            Get
                Return _FrutationID
            End Get
            Set(ByVal value As Integer)
                _FrutationID = value
            End Set
        End Property

        Public Property FranSupportID() As Integer
            Get
                Return _FranSupportID
            End Get
            Set(ByVal value As Integer)
                _FranSupportID = value
            End Set
        End Property
        Public Property ChangePasswordvar() As Integer
            Get
                Return _ChangePassword
            End Get
            Set(ByVal value As Integer)
                _ChangePassword = value
            End Set
        End Property
        Public Property ChangePassDate() As DateTime
            Get
                Return _ChangePassDate
            End Get
            Set(ByVal value As DateTime)
                _ChangePassDate = value
            End Set
        End Property
		
		Public Property SecurityCode() As Integer
            Get
                Return _SecurityCode
            End Get
            Set(ByVal value As Integer)
                _SecurityCode = value
            End Set
        End Property

        Public Property StatusChangeBy() As String
            Get
                Return _StatusChangedBy
            End Get
            Set(ByVal value As String)
                _StatusChangedBy = value
            End Set
        End Property

        Public Property StatusChangedDate() As Date
            Get
                Return _StatusChangedDate
            End Get
            Set(ByVal value As Date)
                _StatusChangedDate = value
            End Set
        End Property
        Public Property StatusNotes() As String
            Get
                Return _StatusNotes
            End Get
            Set(ByVal value As String)
                _StatusNotes = value
            End Set
        End Property

        Public Property RFID() As String
            Get
                Return _RFID
            End Get
            Set(ByVal value As String)
                _RFID = value
            End Set
        End Property

        Public Property FranMail_UserName() As String
            Get
                Return _FranMail_Username
            End Get
            Set(ByVal value As String)
                _FranMail_Username = value
            End Set
        End Property
        Public Property FranMail_Password() As String
            Get
                Return _FranMail_Password
            End Get
            Set(ByVal value As String)
                _FranMail_Password = value
            End Set
        End Property
        Public Property ChangePasswordAccess() As Boolean
            Get
                Return _ChangePasswordAccess
            End Get
            Set(ByVal value As Boolean)
                _ChangePasswordAccess = value
            End Set
        End Property
        Public Property PersonalEmail() As String
            Get
                Return _PersonalEamil
            End Get
            Set(ByVal value As String)
                _PersonalEamil = value
            End Set
        End Property
        Public Property TeamsUnder() As String
            Get
                Return _TeamsUnder
            End Get
            Set(ByVal value As String)
                _TeamsUnder = value
            End Set
        End Property

        Public Property OfficeTimingProfileID() As Integer
            Get
                Return _OfficeTimingProfileID
            End Get
            Set(ByVal value As Integer)
                _OfficeTimingProfileID = value
            End Set
        End Property
		
        Public Property OffSaturdayGroup() As Integer
            Get
                Return _OffSaturdayGroup
            End Get
            Set(ByVal value As Integer)
                _OffSaturdayGroup = value
            End Set
        End Property

        Public Property IsEmailWorking() As Boolean
            Get
                Return _isEmailWorking
            End Get
            Set(ByVal value As Boolean)
                _isEmailWorking = value
            End Set
        End Property
#End Region

#Region "Public Enum"
        Public Enum EndSessionRedirectPages
            Login = 0
            NoPage = 1
        End Enum
        Public Enum ValidationStatus
            Validated = 0
            UserNotFound = 1
            UserNotAuthorized = 2
            WrongPIN = 3
            CurrentlyLoggedIn = 4
            NoClientAccess = 5
        End Enum
        Public Enum HR_ACTIVITY_TYPE
            Time_Off = 1
            Performance = 2
            Discipline = 3
            Benefit = 4
            Other = 5
        End Enum
        Public Enum HR_ACTIVITY_SUBTYPE
            General = 1
            Notice = 2
            Complaints = 3
            Violation = 4
            StoreDuty = 5
        End Enum
#End Region

#Region "Constructors"
        Public Sub New()

        End Sub
        Public Sub New( _
                        ByVal ID As Integer, _
                        ByVal Name As String, _
                        ByVal UserName As String, _
                        ByVal Email As String, _
                        ByVal WorkPhone As String, _
                        ByVal Status As String, _
                        ByVal RFID As String _
                        )

            Me.ID = ID
            Me.Name = Name
            Me.UserName = UserName
            Me.Email = Email
            Me.WorkPhone = WorkPhone
            Me.Status = Status
            Me.RFID = RFID
        End Sub
        Public Sub New( _
                        ByVal ID As Integer, _
                        ByVal FirstName As String, _
                        ByVal MiddleName As String, _
                        ByVal LastName As String, _
                        ByVal Username As String, _
                        ByVal PassWord As String, _
                        ByVal Ssn As String, _
                        ByVal IP As String, _
                        ByVal IP2 As String, _
                        ByVal JobTitle As String, _
                        ByVal Email As String, _
                        ByVal Address As String, _
                        ByVal City As String, _
                        ByVal Region As String, _
                        ByVal Zip As String, _
                        ByVal CountryID As Integer, _
                        ByVal StateID As Integer, _
                        ByVal HomePhone As String, _
                        ByVal WorkPhone As String, _
                        ByVal CellPhone As String, _
                        ByVal Fax As String, _
                        ByVal RemoteUser As Boolean, _
                        ByVal TimeZoneID As Integer, _
                        ByVal Inactive As Boolean, _
                        ByVal Deleted As Boolean, _
                        ByVal IsTimeExampted As Boolean, _
                        ByVal Gender As Boolean, _
                        ByVal HiringDate As Date, _
                        ByVal DOB As Date, _
                        ByVal DepartmentID As Integer, _
                        ByVal TeamID As Integer, _
                        ByVal OfficeID As Integer, _
                        ByVal Type As Integer, _
                        ByVal FrutationID As Integer, _
                        ByVal FranSupportID As Integer, _
                        ByVal SecurityCode As Integer, _
                        ByVal RFID As String, _
                        ByVal ChangePasswordAccess As Boolean, _
                        ByVal PersonalEmail As String, _
                        Optional ByVal TimingProfileID As Integer = 0, _
                        Optional ByVal SaturdayGroupType As Integer = 0, _
                        Optional ByVal IsEmailWorking As Boolean = False)




            Me.ID = ID
            Me.Firstname = FirstName
            Me.Middlename = MiddleName
            Me.Lastname = LastName
            Me.UserName = Username
            Me.Password = PassWord
            Me.Ssn = Ssn
            Me.IP = IP
            Me.IP2 = IP2
            Me.JobTitle = JobTitle
            Me.Email = Email
            Me.Address = Address
            Me.City = City
            Me.Region = Region
            Me.Zip = Zip
            Me.CountryID = CountryID
            Me.StateID = StateID
            Me.HomePhone = HomePhone
            Me.WorkPhone = WorkPhone
            Me.CellPhone = CellPhone
            Me.Fax = Fax
            Me.RemoteUser = RemoteUser
            Me.TimeZoneID = TimeZoneID
            Me.Inactive = Inactive
            Me.Deleted = Deleted
            Me.IsTimeExampted = IsTimeExampted
            Me.Gender = Gender
            Me.HiringDate = HiringDate
            Me.DOB = DOB
            Me.DepartmentID = DepartmentID
            Me.TeamID = TeamID
            Me.OfficeID = OfficeID
            Me.Type = Type
            Me.FrutationID = FrutationID
            Me.FranSupportID = FranSupportID
            Me.SecurityCode = SecurityCode
            Me.RFID = RFID
            Me.ChangePasswordAccess = ChangePasswordAccess
            Me.IsEmailWorking = IsEmailWorking
            Me.PersonalEmail = PersonalEmail
            Me.OfficeTimingProfileID = TimingProfileID
            Me.OffSaturdayGroup = SaturdayGroupType

        End Sub

#End Region

#Region "Public Methods"

#Region "User Login Methods"
        Public Function ValidateUser(ByVal argUserName As String, ByVal argPassword As String, ByVal argPIN As String, ByVal argPINPassword As String, ByVal blnCreateSessionObject As Boolean, ByVal chkKey As Boolean, ByVal LoginReq As Enumeration.Login_Request) As ValidationStatus
            Dim retVal As ValidationStatus = ValidationStatus.UserNotAuthorized
            If chkKey = True Then
                If Functions.KeyCode_VerifyPass_Admin(argPIN, argPINPassword) = False Then
                    ' Invalid PIN
                    retVal = ValidationStatus.WrongPIN
                End If
            End If
            If retVal <> ValidationStatus.WrongPIN Then
                Dim db As New DBAccess
                db.AddParameter("@UserName", Trim(argUserName))
                db.AddParameter("@Password", Trim(argPassword))
                Dim rdrUserInfo As SqlDataReader = db.ExecuteReader("Portal_ValidateUser")
                If Not rdrUserInfo.Read Then
                    ' User not found
                    retVal = ValidationStatus.UserNotFound
                Else
                    If blnCreateSessionObject Then

                        Dim objUser As Users = New Users()
                        objUser.ID = rdrUserInfo("ID")
                        objUser.Name = rdrUserInfo("FirstName") & " " & rdrUserInfo("LastName")
                        objUser.JobTitle = CType(Functions.IfNull(rdrUserInfo("JobTitle"), ""), String)
                        objUser.Email = CType(Functions.IfNull(rdrUserInfo("Email"), ""), String)
                        objUser.DepartmentID = CType(Functions.IfNull(rdrUserInfo("DepartmentID"), 0), Integer)
                        objUser.UserName = rdrUserInfo("UserName")
                        objUser.FranSupportID = CInt(Functions.IfNull(rdrUserInfo("FranSupportID"), 0))
                        objUser.FrutationID = CInt(Functions.IfNull(rdrUserInfo("FrutationID"), 0))
                        objUser.RemoteUser = CBool(Functions.IfNull(rdrUserInfo("RemoteUser"), False))
                        objUser.Type = CInt(Functions.IfNull(rdrUserInfo("Type"), 0))
                        objUser.IP = CStr(Functions.IfNull(rdrUserInfo("IP"), ""))
                        objUser.IP2 = CStr(Functions.IfNull(rdrUserInfo("IP2"), ""))
                        objUser.ChangePasswordvar = CBool(Functions.IfNull(rdrUserInfo("ChangePassword"), False))
                        objUser.ChangePassDate = Convert.ToDateTime(rdrUserInfo("ChangePassDate"))
                        If (DateDiff(DateInterval.Day, objUser.ChangePassDate, DateTime.Now) > 30) Then
                            HttpContext.Current.Session.Add("Admin_ChangePassword", True)
                        Else
                            HttpContext.Current.Session.Add("Admin_ChangePassword", False)
                        End If

                        Dim ClientCount As Integer = CInt(Functions.IfNull(rdrUserInfo("ClientCount"), 0))

                        Dim objContext As HttpContext = HttpContext.Current
                        objContext.Session.Add("AdminCurrentobjUser", objUser) ' In session, we keep the logged-in User's ID with another key
                        ' because it is frequently used and we are saved from creating object                        
                        objContext.Session.Add("AdminID", objUser.ID)
                        objContext.Session.Add("AdminName", objUser.Name)
                        objContext.Session.Add("Email", objUser.Email)
                        objContext.Session.Add("RemoteUser", objUser.RemoteUser)
                        objContext.Session.Add("IstVisit", True)
                        objContext.Session.Add("Type", objUser.Type)
                        rdrUserInfo.Close()
                        rdrUserInfo = Nothing
                        retVal = ValidationStatus.Validated

                        'If LoginReq = Enumeration.Login_Request.Remote Then
                        '    If objUser.RemoteUser = True Then
                        '        retVal = ValidationStatus.Validated
                        '        HttpContext.Current.Session("Remote_LimitedAccess") = True
                        '        If CInt(objUser.ID) = 4127 Then  ' Judy Remote Access
                        '            HttpContext.Current.Session("Remote_LimitedAccess") = False
                        '        End If
                        '    ElseIf ClientCount = 0 Then
                        '        retVal = ValidationStatus.NoClientAccess
                        '    Else
                        '        retVal = ValidationStatus.UserNotAuthorized
                        '    End If
                        'ElseIf LoginReq = Enumeration.Login_Request.Launchpad Then
                        '    If objUser.RemoteUser = False AndAlso objUser.IP <> HttpContext.Current.Request.UserHostAddress.ToString() AndAlso objUser.IP2 <> HttpContext.Current.Request.UserHostAddress.ToString() Then
                        '        retVal = ValidationStatus.UserNotAuthorized
                        '    ElseIf ClientCount = 0 Then
                        '        retVal = ValidationStatus.NoClientAccess
                        '    End If
                        'End If
						
                    End If

                    If rdrUserInfo IsNot Nothing AndAlso rdrUserInfo.HasRows Then
                        rdrUserInfo.Close()
                    End If
                End If
            End If
            Return retVal
        End Function

        Public Function ValidateUserForFransupport(ByVal argUserName As String, ByVal argPassword As String) As ValidationStatus
            Dim retVal As ValidationStatus = ValidationStatus.UserNotAuthorized

            If retVal <> ValidationStatus.WrongPIN Then

                Dim db As New DBAccess
                db.AddParameter("@UserName", Trim(argUserName))
                db.AddParameter("@Password", Trim(argPassword))
                Dim rdrUserInfo As SqlDataReader = db.ExecuteReader("Portal_ValidateUserForFransupport")
                If Not rdrUserInfo.Read Then
                    ' User not found
                    retVal = ValidationStatus.UserNotFound
                Else

                    Dim objUser As Users = New Users()
                    objUser.ID = rdrUserInfo("ID")
                    objUser.Name = rdrUserInfo("FirstName") & " " & rdrUserInfo("LastName")
                    objUser.JobTitle = CType(Functions.IfNull(rdrUserInfo("JobTitle"), ""), String)
                    objUser.Email = CType(Functions.IfNull(rdrUserInfo("Email"), ""), String)
                    objUser.DepartmentID = CType(Functions.IfNull(rdrUserInfo("DepartmentID"), 0), Integer)
                    objUser.UserName = rdrUserInfo("UserName")
                    objUser.FranSupportID = CInt(Functions.IfNull(rdrUserInfo("FranSupportID"), 0))
                    objUser.FrutationID = CInt(Functions.IfNull(rdrUserInfo("FrutationID"), 0))
                    objUser.RemoteUser = CBool(Functions.IfNull(rdrUserInfo("RemoteUser"), False))
                    objUser.Type = CInt(Functions.IfNull(rdrUserInfo("Type"), 0))
                    objUser.IP = CStr(Functions.IfNull(rdrUserInfo("IP"), ""))
                    objUser.ChangePasswordvar = CBool(Functions.IfNull(rdrUserInfo("ChangePassword"), False))
                    objUser.ChangePassDate = Convert.ToDateTime(rdrUserInfo("ChangePassDate"))
                    If (DateDiff(DateInterval.Day, objUser.ChangePassDate, DateTime.Now) > 30) Then
                        HttpContext.Current.Session.Add("Admin_ChangePassword", True)
                    Else
                        HttpContext.Current.Session.Add("Admin_ChangePassword", False)
                    End If

                    Dim ClientCount As Integer = CInt(Functions.IfNull(rdrUserInfo("ClientCount"), 0))

                    Dim objContext As HttpContext = HttpContext.Current
                    objContext.Session.Add("AdminCurrentobjUser", objUser) ' In session, we keep the logged-in User's ID with another key
                    ' because it is frequently used and we are saved from creating object                        
                    objContext.Session.Add("AdminID", objUser.ID)
                    objContext.Session.Add("AdminName", objUser.Name)
                    objContext.Session.Add("Email", objUser.Email)
                    objContext.Session.Add("RemoteUser", objUser.RemoteUser)
                    objContext.Session.Add("IstVisit", False)
                    objContext.Session.Add("Type", objUser.Type)
                    rdrUserInfo.Close()
                    rdrUserInfo = Nothing
                    retVal = ValidationStatus.Validated

                    If ClientCount = 0 Then
                        retVal = ValidationStatus.NoClientAccess
                    End If
                    If rdrUserInfo IsNot Nothing AndAlso rdrUserInfo.HasRows Then
                        rdrUserInfo.Close()
                    End If
                End If
            End If
            Return retVal
        End Function


        Public Shared Sub RemoveUserFromApplication(ByVal UserID As Integer)
            Try
                HttpContext.Current.Application.Lock()
                UpdateLoginHistory()
                CType(HttpContext.Current.Application("LoggedInAdmins"), Hashtable).Remove(UserID)
            Catch ex As Exception
                Throw ex
            Finally
                HttpContext.Current.Application.UnLock()
            End Try

        End Sub
        Protected Shared Sub UpdateLoginHistory()
            Dim HR_LoginHistoryID As Integer = CType(HttpContext.Current.Session("HR_LoginHistoryID"), Integer)
            Portal.BLL.HR.HR_LoginHistory.LoginHistoryUpdate(HR_LoginHistoryID, Nothing, Nothing, Nothing, System.DateTime.Now)
        End Sub
        Public Shared Function IsUserInApplication(ByVal UserID As Integer) As Boolean

            Return IIf(String.IsNullOrEmpty(CType(HttpContext.Current.Application("LoggedInAdmins"), Hashtable).Item(UserID)) = False, True, False)

        End Function

        Public Shared Sub LogUsersInApplication(ByVal UserID As Integer, ByVal SessionID As Integer)

            Try
                HttpContext.Current.Application.Lock()
                If IsUserInApplication(UserID) Then
                    CType(HttpContext.Current.Application("LoggedInAdmins"), Hashtable).Item(UserID) = SessionID
                Else
                    CType(HttpContext.Current.Application("LoggedInAdmins"), Hashtable).Add(UserID, SessionID)
                End If
            Catch ex As Exception
                Throw ex
            Finally
                HttpContext.Current.Application.UnLock()
            End Try

        End Sub
        Public Shared Sub AuthenticateSession(ByVal RedirectPage As EndSessionRedirectPages)
            Dim objContext As HttpContext = HttpContext.Current
            If objContext.Session Is Nothing OrElse objContext.Session.Count < 1 OrElse (IsUserSessionInApplication() = False) Then
                Select Case RedirectPage
                    Case EndSessionRedirectPages.Login
                        'objContext.Response.Redirect("~/ExpireSession.aspx", True)
                        If HttpContext.Current.Request.Cookies("PortalPM") IsNot Nothing AndAlso (CStr(HttpContext.Current.Request.Cookies("PortalPM").Item("UserType")) = "FransupportUser") Then
                            HttpContext.Current.Response.Write("<" & "script>window.top.location.replace('" & Functions.GetUrlDomain() & "/Portal/PM/SucessFulLogout.htm" & "');</" & "script>")
                        Else
                            objContext.Response.Redirect("~/ExpireSession.aspx", True)
                        End If
                    Case EndSessionRedirectPages.NoPage
                        objContext.Response.Redirect("~/NoPage.aspx?Action=LogOff", True)
                End Select
            End If
        End Sub
        Public Shared Sub AuthenticateMyNetsolaceSession()
            Dim objContext As HttpContext = HttpContext.Current
            Dim Bool As Boolean = False
            If Not String.IsNullOrEmpty(objContext.Session("MyNetsolace_ClientContactID")) AndAlso Not String.IsNullOrEmpty(objContext.Session("MyNetsolace_ClientID")) Then
                Bool = True
            ElseIf Not String.IsNullOrEmpty(objContext.Session("MyNetsolace_AreaDeveloperID")) AndAlso Not String.IsNullOrEmpty(objContext.Session("MyNetsolace_ClientID")) Then
                Bool = True
            ElseIf Not String.IsNullOrEmpty(objContext.Session("FranchiseContactID")) AndAlso Not String.IsNullOrEmpty(objContext.Session("MyNetsolace_ClientID")) Then
                Bool = True
            End If
            If Bool = False Then
                Portal.BLL.Client.Client_Contacts.RemoveSessionOfMyNetsolace()
            End If
        End Sub
        Public Shared Function IsUserSessionInApplication() As Boolean
            If CType(HttpContext.Current.Session("AdminID"), Integer) = (CType(HttpContext.Current.Session("Admin_SessionID"), Integer)) Then
                Return True
            Else
                Return False
            End If
        End Function
#End Region

        Public Function InsertUser() As Integer

            Dim db As New DBAccess
            db.AddParameter("@FirstName", Me.Firstname)        '1
            db.AddParameter("@MiddleName", Me.Middlename)      '2
            db.AddParameter("@LastName", Me.Lastname)          '3
            db.AddParameter("@Username", Me.UserName)          '4
            db.AddParameter("@Password", Me.Password) 'NewUser.Password         '5
            db.AddParameter("@SSN", Me.Ssn)                    '6
            db.AddParameter("@IP", Me.IP)                      '7
            db.AddParameter("@IP2", Me.IP2)
            db.AddParameter("@JobTitle", Me.JobTitle)          '8
            db.AddParameter("@Email", Me.Email)                '9
            db.AddParameter("@Address", Me.Address)            '10
            db.AddParameter("@City", Me.City)                  '11
            db.AddParameter("@Region", Me.Region)              '12
            db.AddParameter("@Zip", Me.Zip)                    '13
            db.AddParameter("@StateID", Me.StateID)            '14
            db.AddParameter("@CountryID", Me.CountryID)        '15
            db.AddParameter("@HomePhone", Me.HomePhone)        '16
            db.AddParameter("@WorkPhone", Me.WorkPhone)        '17
            db.AddParameter("@CellPhone", Me.CellPhone)        '18 
            db.AddParameter("@Fax", Me.Fax)                    '19
            db.AddParameter("@Gender", Me.Gender)              '20
            db.AddParameter("@RemoteUser", Me.RemoteUser)      '21
            db.AddParameter("@Inactive", Me.Inactive)          '22
            db.AddParameter("@Deleted", Me.Deleted)            '23
            db.AddParameter("@TimeZoneID", Me.TimeZoneID)      '24
            db.AddParameter("@IsTimeExampted", Me.IsTimeExampted) '25
            db.AddParameter("@HiringDate", Me.HiringDate)      '26
            db.AddParameter("@DOB", Me.DOB)                    '27
            db.AddParameter("@DepartmentID", Me.DepartmentID)
            db.AddParameter("@TeamID", Me.TeamID)
            db.AddParameter("@OfficeID", Me.OfficeID)
            db.AddParameter("@Type", Me.Type)
            db.AddParameter("@RFID", Me.RFID)
            If Me.FranMail_UserName = "" Then
                db.AddParameter("@FranMail_UserName", DBNull.Value)
            Else
                db.AddParameter("@FranMail_UserName", Me.FranMail_UserName)
            End If
            If Me.FranMail_Password = "" Then
                db.AddParameter("@FranMail_Password", DBNull.Value)
            Else
                db.AddParameter("@FranMail_Password", Me.FranMail_Password)
            End If
            If Me.PersonalEmail = "" Then
                db.AddParameter("@PersonalEmail", DBNull.Value)
            Else
                db.AddParameter("@PersonalEmail", Me.PersonalEmail)
            End If
            db.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            db.AddParameter("@ChangePasswordAccess", Me.ChangePasswordAccess)
            db.AddParameter("@TimeProfileID", IIf(Me.OfficeTimingProfileID = 0, DBNull.Value, Me.OfficeTimingProfileID))			
            db.AddParameter("@OffSaturdayGroupType", IIf(Me.OffSaturdayGroup = 0, DBNull.Value, Me.OffSaturdayGroup))			
            db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)
            db.AddParameter("@IsEmailWorking", Me.IsEmailWorking)
            Dim Affected As Integer = db.ExecuteNonQuery("Insert_NewUser")
            Dim RetVal As Integer = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
            Return RetVal
        End Function
     
        Public Shared Function GetUsersEmail_ByID(ByVal ID As Integer) As String
            Dim db As New DBAccess
            Dim dr As SqlDataReader = Nothing
            Dim UserEmail As String = String.Empty
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("GetUsersEmail_ByID")
            If dr.HasRows Then
                dr.Read()
                UserEmail = dr.Item("FranMail_UserName")
                dr.Close()
            End If
            Return UserEmail
        End Function
        
        Public Shared Function GetAll(ByVal CountryID As Integer, ByVal DepartmentID As Integer, ByVal TeamID As Integer, ByVal OfficeID As Integer, ByVal Status As String, ByVal Type As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Users)
            Return Portal.DAL.DBUsers.GetAll(CountryID, DepartmentID, TeamID, OfficeID, Status, Type, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Shared Function GetAllCount(ByVal CountryID As Integer, ByVal DepartmentID As Integer, ByVal TeamID As Integer, ByVal OfficeID As Integer, ByVal Status As String, ByVal Type As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Return Portal.DAL.DBUsers.GetAllCount(CountryID, DepartmentID, TeamID, OfficeID, Status, Type, txtsearch)
        End Function
        Public Shared Function GetUsersByID(ByVal ID As Integer) As List(Of Users)
            Return Portal.DAL.DBUsers.GetUsersByID(ID)
        End Function

        Public Shared Function GetFransupportUsersByID(ByVal FransupportID As Integer) As List(Of Users)
            Return Portal.DAL.DBUsers.GetFransupportUsersByID(FransupportID)
        End Function

        Public Function Insert(ByVal FirstName As String, ByVal MiddleName As String, ByVal LastName As String, ByVal Username As String, ByVal Ssn As String, ByVal IP As String, ByVal IP2 As String, _
                          ByVal JobTitle As String, ByVal Email As String, ByVal Address As String, ByVal City As String, ByVal Zip As String, ByVal CountryID As Integer, ByVal StateID As Integer, _
                          ByVal HomePhone As String, ByVal WorkPhone As String, ByVal CellPhone As String, ByVal Fax As String, ByVal TimeZoneID As Integer, ByVal Gender As Boolean, ByVal HiringDate As Date, ByVal DOB As Date, ByVal DepartmentID As Integer, ByVal TeamID As Integer, ByVal OfficeID As Integer, ByVal RemoteUser As Boolean, ByVal IsTimeExampted As Boolean, ByVal Typeed As Integer, ByVal RFID As String) As Integer


            Dim strPass As String = GenerateNewPassWord()
            Password = strPass 'Functions.EncryptData(strPass)
            Ssn = Functions.EncryptData(Ssn)
            Dim user As Portal.BLL.Users = New Users(0, FirstName, MiddleName, LastName, Username, Password, Ssn, IP, IP2, JobTitle, Email, Address, City, "", Zip, CountryID, StateID, HomePhone, WorkPhone, CellPhone, Fax, RemoteUser, TimeZoneID, False, False, IsTimeExampted, Gender, HiringDate, DOB, DepartmentID, TeamID, OfficeID, Typeed, 0, 0, 0, RFID, False, PersonalEmail, IsEmailWorking)
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Dim Affected As Integer = dal.Insert(user)
            If Affected > 0 Then
                SendMailNewPassword(FirstName, Username, Email, strPass, PersonalEmail)
            End If
            Return Affected
        End Function

        Public Shared Function GenerateNewPassWord() As String
            Return Functions.GeneratePassword(6, 6)
        End Function

        Public Shared Sub SendMailNewPassword(ByVal FirstName As String, ByVal Username As String, ByVal email As String, ByVal password As String, ByVal PersonalEmail As String)

            Dim mail As Portal.BLL.Email
            mail = New Portal.BLL.Email()
            Dim strBody As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/ChangePassword.htm"))
            If (PersonalEmail <> String.Empty) Then
                mail.MailCC = PersonalEmail
            End If
            With mail
                .LeadID = 0
                .MailTo = email
                .MailFrom = HttpContext.Current.Session("Email")
                .DisplayName = CType(HttpContext.Current.Session("AdminName"), String)
                .MailBCC = ""
                .MailCC = PersonalEmail
                .Subject = "Netsolace User New Password"
                .TaskType = 3
                .Detail = strBody.Replace("@Fullname", FirstName).Replace("@UserName", Username).Replace("@Password", password)
                .CompletedDate = System.DateTime.Now
                .Send_mail()
            End With
        End Sub
        Public Sub SendWebMailAccess(ByVal FirstName As String, ByVal FranMailUsername As String, ByVal FranMailPassword As String, ByVal Subject As String, ByVal EmailTo As String, ByVal EmailCC As String)

            Dim mail As Portal.BLL.Email
            Dim link As String = String.Empty
            mail = New Portal.BLL.Email()
            Dim strBody As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/WebMailAccess.htm"))
            If Subject = "Netsolace Portal" Then
                link = "<a href='https://qa.netsolace.com/portal' target='_blank'>qa.netsolace.com/portal</a><br />"
            Else
                link = "<a href='http://mail.netsolace.com' target='_blank'>mail.netsolace.com</a><br />"
            End If
            If EmailCC <> String.Empty Then
                mail.MailCC = EmailCC
            End If
            With mail
                .LeadID = 0
                .MailTo = EmailTo
                .MailFrom = HttpContext.Current.Session("Email")
                .DisplayName = CType(HttpContext.Current.Session("AdminName"), String)
                .MailBCC = ""
                .Subject = Subject
                .TaskType = 3
                .Detail = strBody.Replace("@Fullname", FirstName).Replace("@UserName", FranMailUsername).Replace("@Title", Subject).Replace("@Password", FranMailPassword).Replace("@link", link)
                .CompletedDate = System.DateTime.Now
                .Send_mail()
            End With
        End Sub

        Public Shared Function Update(ByVal ID As Integer, ByVal FirstName As String, ByVal MiddleName As String, ByVal LastName As String, ByVal Username As String, ByVal Ssn As String, ByVal IP As String, ByVal IP2 As String, _
                                 ByVal JobTitle As String, ByVal Email As String, ByVal Address As String, ByVal City As String, ByVal Zip As String, ByVal CountryID As Integer, ByVal StateID As Integer, _
                                 ByVal HomePhone As String, ByVal WorkPhone As String, ByVal CellPhone As String, ByVal Fax As String, ByVal TimeZoneID As Integer, ByVal Gender As Boolean, ByVal HiringDate As Date, ByVal DOB As Date, ByVal DepartmentID As Integer, ByVal TeamID As Integer, ByVal OfficeID As Integer, ByVal RemoteUser As Boolean, ByVal IsTimeExampted As Boolean, ByVal Typeed As Integer, ByVal RFID As String, ByVal ChangePasswordAccess As Boolean, ByVal PersonalEmail As String, ByVal TimeProfileID As Integer, ByVal SaturdayGroupType As Integer, ByVal IsEmailWorking As Boolean) As Integer

            Ssn = Functions.EncryptData(Ssn)

            Dim user As Portal.BLL.Users = New Users(ID, FirstName, MiddleName, LastName, Username, "", Ssn, IP, IP2, JobTitle, Email, Address, City, "Islamabad", Zip, CountryID, StateID, HomePhone, WorkPhone, CellPhone, Fax, RemoteUser, TimeZoneID, False, False, IsTimeExampted, Gender, HiringDate, DOB, DepartmentID, TeamID, OfficeID, Typeed, 0, 0, 0, RFID, ChangePasswordAccess, PersonalEmail, TimeProfileID, SaturdayGroupType, IsEmailWorking)
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Return dal.Update(user)
        End Function

        Public Shared Function Delete(ByVal ID As Integer) As Integer
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Return dal.Delete(ID)
        End Function

        Public Shared Function ResetPassword(ByVal ID As Integer, ByVal Name As String, ByVal UserName As String, ByVal Email As String, ByVal PersonalEmail As String) As Integer
            Dim strPass As String = GenerateNewPassWord()
            'Dim strpassEncrypted As String = Functions.EncryptData(strPass)
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            If dal.ResetPassword(ID, strPass) > 0 Then
                SendMailNewPassword(Name, UserName, Email, strPass, PersonalEmail)
                Return 1
            Else
                Return 0
            End If
        End Function

        Public Shared Function ResetStatus(ByVal ID As Integer, ByVal Status As Boolean) As Integer
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Return dal.ResetStatus(ID, Status)
        End Function

        Public Function GetModules_SubModules(ByVal UserID As Integer, ByVal ClientID As Integer) As DataSet
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Return dal.GetModules_SubModules(UserID, ClientID)
        End Function

        Public Function GetClients() As String(,)
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Return dal.GetClients()
        End Function

        Public Function UsersAccess_Delete(ByVal UserID As Integer) As Integer

            Dim objUserDal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Dim Affected As Integer = objUserDal.AccessDelete(UserID)
            Return Affected
        End Function

        Public Function UsersAccess_Insert(ByVal sqlQuery As String) As Integer

            Dim objUserDal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Dim Affected As Integer = objUserDal.SQLInsert(sqlQuery)
            Return Affected
        End Function

        Public Shared Function ChangePassword(ByVal ID As Integer, ByVal OldPassword As String, ByVal NewPassword As String) As Integer
            Dim dal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Return dal.ChangePassword(ID, OldPassword, NewPassword)
        End Function

        Public Shared Function GetPasswordReservedWords(ByVal UserID As Integer) As DataTable
            Return Portal.DAL.DBUsers.GetPasswordReservedWords(UserID)
        End Function

        Public Shared Function IsPasswordAllowed(ByVal StrPassword As String) As Boolean
            Dim strwords As String = ConfigurationManager.AppSettings("PasswordReservedwords")
            Dim strWordsArray As String() = strwords.Split(",")
            For i As Integer = 0 To strWordsArray.Length - 1
                If StrPassword.ToLower().Contains(strWordsArray(i).Trim().ToLower) Then
                    Return False
                End If
            Next
            Dim dt As New System.Data.DataTable
            Dim count As Integer
            dt = (Users.GetPasswordReservedWords(CInt(HttpContext.Current.Session("AdminID"))))
            For count = 1 To dt.Columns.Count - 1
                If String.IsNullOrEmpty(dt.Rows(0)(count).ToString) = False Then
                    If (StrPassword.ToLower().Contains(dt.Rows(0)(count).ToString.ToLower())) Then
                        Return False
                    End If
                End If
            Next
            Return True
        End Function

        Public Shared Function AddEmailSignature(ByVal AdminID As Integer, ByVal EmailSignature As String) As Integer
            Dim db As New DBAccess
            Dim returnValue As Integer = 0
            db.AddParameter("@AdminID", AdminID)
            db.AddParameter("@EmailSignature", EmailSignature)
            returnValue = db.ExecuteNonQuery("Portal_User_AddEmailSignature")
            Return returnValue
        End Function

        Public Shared Function GetEmailSignature(ByVal AdminID As Integer) As String
            Dim EmailSignature As String = ""
            Dim dr As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@AdminID", AdminID)
            dr = db.ExecuteReader("Portal_User_GetEmailSignature")
            If dr.HasRows Then
                dr.Read()
                EmailSignature = dr.Item("EmailSignature")
                dr.Close()
            End If
            Return EmailSignature
        End Function

        Public Shared Function GetEmailByAdminName(ByVal AdminName As String) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@FirstName", AdminName)
            Dim ds As DataSet = db.ExecuteDataSet("franchisee_GetEmail_ByFirstName")
            Return ds.Tables(0)
        End Function

        Public Shared Function CheckUserSubModulesAccess(ByVal subModuleId As Portal.BLL.Enumeration.SubModules) As Boolean
            Dim hasAccess As Boolean = False
            If HttpContext.Current.Session("UsersSubModulesID") IsNot Nothing Then
                Dim userSubModules() As String = Convert.ToString(HttpContext.Current.Session("UsersSubModulesID")).Split(",")
                For Each userModule As String In userSubModules
                    If (CInt(userModule) = subModuleId) Then
                        hasAccess = True
                    End If
                Next
            Else
                hasAccess = False
            End If
            Return hasAccess
        End Function


        Public Shared Function CheckUserSubModulesAccessByClientID(ByVal userId As Integer, ByVal subModuleId As Portal.BLL.Enumeration.SubModules, ByVal clientId As Integer) As Boolean
            Dim hasAccess As Boolean = False
            Dim result As Object = Nothing
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@SubModuleID", subModuleId)
            objDbAccess.AddParameter("@ClientID", clientId)
            objDbAccess.AddParameter("@UserID", userId)
            result = objDbAccess.ExecuteScalar("Users_CheckSubModuleAccessByClientID")
            If (result IsNot Nothing) Then
                If (CInt(result > 0)) Then
                    hasAccess = True
                End If
            Else
                hasAccess = False
            End If
            Return hasAccess
        End Function

        Public Shared Function GetClientsByUserIDAndSubModuleIDs(ByVal userId As Integer, ByVal subModuleIds As String) As SqlDataReader
            Return Portal.DAL.DBUsers.GetClientsByUserIDAndSubModuleIDs(userId, subModuleIds)
        End Function

        Public Function GetUserNotesByID(ByVal ID As Integer) As SqlDataReader

            Dim objDBAccess As New DBAccess
            Dim rdr As SqlClient.SqlDataReader = Nothing
            objDBAccess.AddParameter("@ID", ID)
            rdr = CType(objDBAccess.ExecuteReader("Users_GetUserNotes"), SqlClient.SqlDataReader)
            If rdr.Read() Then
                StatusChangeBy = GetUserNameByChagedID(rdr("ChangedBy"))
                StatusChangedDate = rdr("ChangedDate")
                StatusNotes = Convert.ToString(rdr("Notes"))
            End If
            rdr.Close()
            objDBAccess.Dispose()
        End Function
        Private Function GetUserNameByChagedID(ByVal ID As Integer) As String
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@ID", ID)
            Return objDbAccess.ExecuteScalar("Users_GetUserName")
        End Function

        Public Shared Sub Users_UpdateNotes(ByVal ID As Integer, ByVal Status As Boolean, ByVal Notes As String)
            Dim db As New DBAccess
            db.AddParameter("@UserID", ID)
            db.AddParameter("@Status", Status)
            db.AddParameter("@ChangedBy", CInt(HttpContext.Current.Session("AdminID")))
            db.AddParameter("@Notes", Notes)
            db.ExecuteNonQuery("Users_UpdateNotes")
        End Sub
        Public Shared Function GetLoginInfo_ByUserID(ByVal UserID As Integer) As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            Return db.ExecuteReader("FranMail_GetLoginInfo_ByUserID")
        End Function
        Public Shared Function LoginToFranMail(ByVal AdminID As Integer) As String

            Dim objSecure As New us.webmail.secure.Webmail
            Dim AdministrativeUserName As String
            Dim AdministrativePassword As String
            Dim strReturn As String = String.Empty
            Dim strResponse As String = String.Empty
            Dim WebMailSessionID As String = ""
            Dim WebMailUserID As String = ""
            Dim WebMailUserName As String = ""
            Dim CountryID As String = ""
            Dim strDomain As String = "netsolace.com.pk"
            Dim db As New DBAccess
            Dim dr As SqlDataReader
            Dim strLoginUrl As String = String.Empty
            AdministrativeUserName = ConfigurationManager.AppSettings("AdministrativeUserName")
            AdministrativePassword = ConfigurationManager.AppSettings("AdministrativePassword")

            db.AddParameter("@UserID", AdminID)
            db.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            dr = db.ExecuteReader("FranMail_GetLoginInfo_ByUserID")
            If dr.Read Then
                WebMailUserName = dr("FranMail_UserName")
            End If
            dr.Close()

            WebMailUserID = Replace(WebMailUserName, "@netsolace.com.pk", "")
            objSecure.ConnectionGroupName = Guid.NewGuid().ToString
            strResponse = objSecure.LoginUserWebmail(AdministrativeUserName, AdministrativePassword, strDomain, WebMailUserID, WebMailSessionID)

            objSecure.Dispose()

            If WebMailUserID <> "" And WebMailUserID <> "" Then
                'strReturn = "https://" & strLoginUrl & "/mail/src/redirect.php?user_name=" & WebMailUserName & "&emailaddress=" & WebMailUserName & "&sessionID=" & WebMailSessionID
                strReturn = "https://webmail.dofruit.com/mail/src/redirect.php?user_name=" & WebMailUserName & "&emailaddress=" & WebMailUserName & "&sessionID=" & WebMailSessionID
            End If

            Return strReturn

        End Function
        Public Shared Function ChekLogin_ForGoogle(ByVal UserName As String, ByVal Password As String) As String
            Dim db As New DBAccess
            Dim dr As SqlDataReader
            Dim retVal As String = String.Empty
            db.AddParameter("@UserName", UserName)
            db.AddParameter("@Password", Password)
            db.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            dr = db.ExecuteReader("Users_GoogleLogin")
            If dr.Read Then
                If dr("UserName") <> "" Then
                    If dr("UserName").ToString = UserName And dr("Password").ToString = Password Then
                        retVal = UserName
                    End If
                End If
            Else
                retVal = String.Empty
            End If
            dr.Close()
            Return retVal
        End Function
        Public Shared Function CanChange_Password(ByVal AdminID As String) As Boolean
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", AdminID)
            Return CType(db.ExecuteScalar("Users_CanChangePassword"), Boolean)
        End Function
        Public Function Update_GoogleAccount(ByVal UserID As String, ByVal strPassword As String) As Boolean
            Dim result As Boolean
            Try
                Dim objDBAccess As New DBAccess
                Dim rdr As SqlDataReader = Nothing
                Dim userName As String = String.Empty
                objDBAccess.AddParameter("@UserID", UserID)
                objDBAccess.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
                rdr = objDBAccess.ExecuteReader("Users_GetEmailByUserID")
                If rdr.Read Then
                    userName = Functions.IfNull(rdr("FranmailUserName"), "")
                    Dim startIdx As Integer = -1
                    startIdx = userName.IndexOf("@")
                    If startIdx > -1 Then
                        userName = userName.Substring(0, startIdx)
                    End If
                End If
                rdr.Close()
                Dim gservice As AppsService = New AppsService(System.Configuration.ConfigurationManager.AppSettings("GoogleDomainName"), System.Configuration.ConfigurationManager.AppSettings("GoogleAdminUserName"), System.Configuration.ConfigurationManager.AppSettings("GoogleAdminPassword"))
                Dim oUserEntry As New UserEntry

                oUserEntry = gservice.RetrieveUser(userName)

                If oUserEntry IsNot Nothing Then
                    oUserEntry.Login.Password = strPassword
                    gservice.UpdateUser(oUserEntry)
                    result = True
                End If
            Catch ex As Exception
                result = False
            End Try
            Return result
        End Function

        Public Function UpdateDoFruitAccount(ByVal UserID As Integer, ByVal NewPassword As String) As Integer
            Dim ReturnVal As Integer = 0
            Dim objFranMail As New us.webmail.admin.mailaccounts
            Dim UserFranMail As String = String.Empty
            Dim OldUserPassword As String = String.Empty
            Dim UserName() As String
            Dim objDBAccess As New DBAccess
            Dim rdr As SqlDataReader = Nothing
            Dim AdministrativeUserName As String
            Dim AdministrativePassword As String

            objDBAccess.AddParameter("@UserID", UserID)
            objDBAccess.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            rdr = objDBAccess.ExecuteReader("Users_GetEmailByUserID")
            If rdr.Read Then
                UserFranMail = Functions.IfNull(rdr("FranmailUserName"), "")
                OldUserPassword = Functions.IfNull(rdr("FranMailPassword"), "")
            End If

            AdministrativeUserName = ConfigurationManager.AppSettings("AdministrativeUserName")
            AdministrativePassword = ConfigurationManager.AppSettings("AdministrativePassword")
            Dim splitChar() As Char = {"@"}
            UserName = UserFranMail.Split(splitChar)
            Dim strDomain As String = UserFranMail.Split("@")(1)
            Try
                If objFranMail.CheckUserExists(AdministrativeUserName, AdministrativePassword, strDomain, UserName(0)) = 1 Then
                    ReturnVal = objFranMail.ChangeUserPassword(AdministrativeUserName, AdministrativePassword, strDomain, UserName(0), OldUserPassword, NewPassword)
                End If
            Catch ex As Exception
                ReturnVal = 0
            End Try
            Return ReturnVal

        End Function

        Public Function UpdateFranMailPassword(ByVal UserID As Integer, ByVal FranMailPassword As String) As Boolean
            Dim objAccess As New DBAccess
            Dim intResult As Integer

            objAccess.AddParameter("@FranMail_Password", FranMailPassword)
            objAccess.AddParameter("@UserID", UserID)
            objAccess.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            intResult = objAccess.ExecuteNonQuery("Users_UpdateFranMailPassword")
            If intResult > 0 Then
                Return True
            Else
                Return False
            End If
        End Function

        Public Shared Function GetFranmail_UserName(ByVal UserID As String) As String
            Dim db As DBAccess = New DBAccess()
            Dim rdr As SqlDataReader
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            Dim userName As String = String.Empty
            rdr = db.ExecuteReader("Users_GetEmailByUserID")
            If rdr.Read Then
                userName = Functions.IfNull(rdr("FranmailUserName"), "")
            End If
            rdr.Close()
            Return userName
        End Function
        Public Function CreateUser_OnGoogle(ByVal FranMaiUserName As String, ByVal FranMailPassword As String) As Boolean
            Dim retVal As Boolean
            Try
                Dim UserName As String = FranMaiUserName
                Dim gservice As AppsService = New AppsService(System.Configuration.ConfigurationManager.AppSettings("GoogleDomainName"), System.Configuration.ConfigurationManager.AppSettings("GoogleAdminUserName"), System.Configuration.ConfigurationManager.AppSettings("GoogleAdminPassword"))
                Dim oUserEntry As New UserEntry
                Dim startIdx As Integer = -1
                startIdx = UserName.IndexOf("@")
                If startIdx > -1 Then
                    UserName = UserName.Substring(0, startIdx)
                End If
                gservice.CreateUser(UserName, Me.Firstname, Me.Lastname, FranMailPassword)
                retVal = True
            Catch ex As Exception
                retVal = False
            End Try
            Return retVal
        End Function
        Public Function Insert_googleAccount(ByVal IsAllow As Boolean) As Boolean
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@UserName", SqlDbType.VarChar, 50, ParameterDirection.Input, Me.FranMail_UserName)
            objDBAccess.AddParameter("@Password", SqlDbType.VarChar, 50, ParameterDirection.Input, Me.FranMail_Password)
            objDBAccess.AddParameter("@IsAllow", SqlDbType.VarChar, 50, ParameterDirection.Input, IsAllow)
            objDBAccess.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            objDBAccess.ExecuteNonQuery("Insert_GoogleAccounts")
        End Function

        Public Sub FranMail_UserAccess(ByVal UserID As Integer)
            Dim objDBAccess As New DBAccess
            objDBAccess.AddParameter("@UserID", SqlDbType.VarChar, 50, ParameterDirection.Input, UserID)
            objDBAccess.ExecuteNonQuery("FranMail_UserAccess")
        End Sub
        Public Function CreateDippedFruitAccount(ByVal FranMail_UserName As String, ByVal FranMail_Password As String, ByVal State As String, ByVal Country As String) As Integer
            Dim ReturnVal As Integer = 0
            Dim objFranMail As New us.webmail.admin.mailaccounts

            Dim UserName() As String

            Dim AdministrativeUserName As String
            Dim AdministrativePassword As String
            AdministrativeUserName = ConfigurationManager.AppSettings("AdministrativeUserName")
            AdministrativePassword = ConfigurationManager.AppSettings("AdministrativePassword")
            Dim splitChar() As Char = {"@"}
            UserName = FranMail_UserName.Split(splitChar)
            Dim strDomain As String = FranMail_UserName.Split("@")(1)
            Try
                If Not objFranMail.CheckUserExists(AdministrativeUserName, AdministrativePassword, strDomain, UserName(0)) = 1 Then
                    ReturnVal = objFranMail.AddUser(AdministrativeUserName, AdministrativePassword, strDomain, UserName(0), FranMail_Password, 1, Me.Firstname, Me.Lastname, Me.Address, Me.City, State, Country, Zip, Me.WorkPhone, "Netsolace", "Netsolace")
                End If
            Catch ex As Exception
                ReturnVal = 0
            End Try
            Return ReturnVal
        End Function

        Public Sub UpdateUserFranMail(ByVal UserID As Integer)
            Dim objAccess As New DBAccess
            objAccess.AddParameter("@FranMailUserName", Me.FranMail_UserName)
            objAccess.AddParameter("@FranMailPassword", Me.FranMail_Password)
            objAccess.AddParameter("@UserID", UserID)
            objAccess.AddParameter("@FranMail_EncryptPasswordKey", ConfigurationManager.AppSettings("FranMail_EncryptPasswordKey"))
            objAccess.ExecuteNonQuery("Users_UpdateFranMail")
        End Sub

        Public Function Update_WebmailAccess(ByVal UserID As String, ByVal IsAllow As Boolean) As Integer
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            db.AddParameter("@IsAllow", IsAllow)
            Return db.ExecuteNonQuery("GoogleAccounts_UpdateRemoteAccess")

        End Function
		
	    Public Shared Function GetTeamInformation(ByVal UserID As Integer) As System.Data.DataTable
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            Return db.ExecuteDataTable("Groups_GetTeamAndSupervisorInfo")
        End Function

	Public Function GetByGroupId(ByVal GroupId As Integer) As DataTable
            Dim db As New DBAccess
            db.AddParameter("@GroupId", GroupId)
            Return db.ExecuteDataTable("Users_GetByGroupId")
        End Function
        Public Function LM_UserAccessGetByUserID(ByVal UserID As Integer) As DataTable
            Dim objUserDal As Portal.DAL.DBUsers = New Portal.DAL.DBUsers()
            Return objUserDal.LM_UserAccessGetByUserID(UserID)
        End Function

        Public Function CheckForLMR_ReadWrite_rights(ByVal userID As Integer) As Boolean

            If Not Functions.IsSuperAdmin(userID) Then
                Dim count As Integer = 0

                Dim objUserAccess As New Portal.BLL.LMUserAccess
                Dim dtClientWise As DataTable = objUserAccess.GetLMRightsByUserID(userID)
                If dtClientWise.Rows.Count > 0 Then
                    For Each dr As DataRow In dtClientWise.Rows
                        If CInt(dr("SubModuleID")) = Portal.BLL.Enumeration.SubModules.LMFullAccess Then
                            count = count + 1
                        End If
                   Next
                End If
                If count > 0 Then
                    Return True

                Else
                    Return False
                End If
            Else
                Return True

            End If

        End Function


       #End Region
    End Class
End Namespace