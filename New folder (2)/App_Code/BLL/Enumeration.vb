Imports Microsoft.VisualBasic
Imports System.Net

Namespace Portal.BLL
    Public Class Enumeration
        Public Enum PMStatus
            Delayed = 1
            NotStarted = 2
            Pending = 3
            InProgress = 4
            Released = 5
            WaitingFor = 6
            OnHold = 7
            FeedbackRequested = 8
            FeedbackReceived = 9
            ConfirmSolved = 10
            DevelopmentPhase = 11
            QAPhase = 12
            DesignPhase = 13
            RequirementGathering = 14
            UATPhase = 15
            LocalProductionCheckout = 16
            Readytogolive = 17
        End Enum

        Enum PMPriority
            High = 1
            Normal = 2
            Low = 3
        End Enum

        Public Enum Groups
            Departments = 1
            Teams = 2
            Offices = 3
        End Enum
        Public Enum UsersType
            AllType = 0
            Portal = 1
            Fransupport = 2
            Portal_FranSupport = 3
        End Enum
        Public Enum EAI_DepartmentID
            Netsolace = 1
        End Enum
        Public Enum ClientID
            EA = 1
            Frutation = 2
            SaladCreation = 3
            PizzaFusion = 4
            Netsolace = 5
            PercocoStone = 0
            TintWorld = 10
            NewPoint = 8
            SKFAcademy = 11
        End Enum

        Public Enum ErrorType
            NoInfoFound = 1
            NotResponding = 2
            NotRegistred = 3
            UnableToGetInfo = 4
            UrlNotFound = 5
            NoIfoInRequiredFormat = 6

        End Enum
        Public Enum AlertType As Integer
            ShowInfo = 1
            ShowError = 2
            ShowLoading = 3
            ShowCritical = 4
            ShowRight = 5
            ShowWrong = 6

        End Enum

        Structure URLPageRequest
            Dim URL As String
            Dim MetaTag As String
            Dim Title As String
            Dim HashEntry As String
            Dim Status As Boolean
            Dim ErrorString As String
            Dim AddressList() As IPAddress
            Sub Initialize()
                URL = ""
                MetaTag = ""
                Title = ""
                HashEntry = ""
                Status = True
                ErrorString = ""
            End Sub
        End Structure
        Structure SSLPageRequest
            Dim URL As String
            Dim MetaTag As String
            Dim Title As String
            Dim HashEntry As String
            Dim Status As Boolean
            Dim ErrorString As String
            Dim AddressList() As IPAddress
            Sub Initialize()
                URL = ""
                MetaTag = ""
                Title = ""
                HashEntry = ""
                Status = True
                ErrorString = ""
            End Sub
        End Structure
        Public Enum Site_Status
            UP = 1
            Down = 2
            Other = 3
        End Enum

        Public Enum ExportOptions
            MsExcel = 1
            MsWord = 2
            RichText = 3
            PDF = 4
            CSV = 5
            Tabbed = 6
        End Enum

        Public Enum SSLReporType
            SSL_List = 1
            Support_Billing_Details = 2
            Support_Checklist = 3
            Support_Billing = 4
        End Enum

        Public Enum ReporType
            Url_List = 1
            Support_Billing_Details = 2
            Support_Checklist = 3
            Support_Billing = 4
        End Enum

        Public Enum Support_Type
            Support = 1
            Backup = 2
        End Enum
        Public Enum Modules
            Home = 4
            ProjectManagement = 3
            Administration = 5
            Communication = 2
            HumanResourceManagment = 7
            URLM = 8
            KnowlegeBase = 9
            Support = 13
            SupportInfo = 13
            'StepByStep = 14
            LM = 14
            FranMail = 15
            Orders = 16
            BillingSupport = 18
            Installation = 42
            LMS = 1001
            Reports = 22
            SSLM = 23
        End Enum

        Public Enum ActivityType
            HelpDesk = 1
            Message = 2
            PhoneCall = 3
            Email = 4
            Fax = 5
            Meeting = 6
            Letter = 7
            Other = 8
            NewStoreStage = 9
            MKTCalendar = 10
            EdibleIdea = 11
            DiscussionBoard = 12
            ProfileUpdate = 13
            ProfileStoreUpdate = 14
            NSMCoordinatorChange = 15
            Finance = 16
            RequestAdditionalArea = 17
            QAR = 18
            Installation = 19
            SMS_X = 20
            Webinar = 21
            IncomingCall = 22
            OutgoingCall = 23
            EscalationfromEA = 24
            Internal = 25
        End Enum

        Public Enum LoginAccountID
            Owner = 1
            Store = 25
        End Enum

        Public Enum SubModules
            HelpDesk = 2
            TimeHistory = 11
            ManageTimeHistory = 12
            PMFullAccess = 3
            PMReadOnlyAccess = 18
            UMFullAccess = 17
            UMReadOnlyAccess = 22
            LMFullAccess = 31
            LMReadOnlyAccess = 30
        End Enum

        Public Enum CreditCardType
            VISA = 1
            Master_Card = 2
            Amex = 3
            Discover = 4
        End Enum

        Public Enum OrderStatus
            NewOrder = 1
            Pending = 2
            Hold = 3
            Processed = 4
            Shipped = 5
            Canceled = 6
        End Enum
        Public Enum ProductType
            Software = 1
            Hardware = 2
            Services = 3
            Support = 4
        End Enum

        Public Enum ActivityState
            NotStarted = 1
            InProgess = 2
            Completed = 3
            WaitingFor = 4
        End Enum
        Public Enum PlacedBy
            PortalAdmin = 1
            Corporate = 2
            Franchisee = 3
        End Enum

        Public Enum ActivitySubType
            General = 1
            Notice = 2
            Complaints = 3
            Compliments = 4
            Violation = 5
            WeeklyCall = 6
            Installation = 19
        End Enum
        Public Enum ActivityNotesType
            PublicNote = False
            PrivateNote = True
        End Enum
        Public Enum TicketsNotesType
            PublicNote = False
            PrivateNote = True
        End Enum
        Public Enum ClientContactType
            EAICorporate = 1
            AreaDeveloper = 2
        End Enum

        Public Enum ActivityPriority
            Low = 1
            Minimal = 2
            Moderate = 3
            Severe = 4
            Critical = 5
        End Enum
        Public Enum Users
            Anthony_Novitski = 3073
            Khurram_Mirza = 3030
            Chris_Lieby = 37
            Michael_Aceto = 152
            Khurram_Ali = 1
            Rana_Khurram = 3004
            Ijaz_Aslam = 249
            Mudassar_Shaikh = 3065
            Maggie_Rolon = 3033
            NS_WebServiceUser = 3773 'create a new user
            Ali_Raza = 3075 ' replaced with Saad
            Rehan_Shahab = 3072
            Catherine_Sobask = 3296
            Sohail_Qadeer_Abbasi = 3018
            Project_Manager = 3771
            Abdullah = 3277
            Tahami = 3086
            Akhtar = 3008
            Jason_Maroon = 3798
        End Enum

        Public Enum NSProductIDs
            nXstep = 7
            SMS = 1
            Qs = 2
            DMenu = 15
            BackUp = 18
            SMS_X = 20
            ESETAntiVirus = 22
            ISP = 23
            SN = 25
            SND = 26
            SNQ = 27
            SNDQ = 28
            S = 24
            DC = 35
        End Enum




        Public Enum UserManual
            Qs = 5
            nXstep = 9
            SMS = 3
            NSBS = 30
        End Enum

        Public Enum ProductFranchisesExt
            Edit = 1
            TurnOn = 2
            TurnOff = 3
            SignUP = 4
        End Enum

        Public Enum TeamType
            Fransupport = 5
            EA = 6
            SMS = 7
            Graphics = 8
            Support_Night = 22
            Office_Help = 25
        End Enum

        Public Enum StoreStatus
            ComingSoon = 1
            Operating = 2
            Corporate = 3
            Terminated = 4
            Suspended = 5
            Transferred = 6
        End Enum

        Public Enum ProductStatus
            Allowed = 0
            NotSignedUp = 1
            TurnedOff = 2
            Expired = 3
        End Enum

        Public Enum ProductNames
            nXStep = 1
            SMSX = 2
            QS = 3
        End Enum

        Public Enum PortalPMCookies
            PortalUser = 1
            FransupportUser = 2
            MyNetsolaceUserFranchisore = 3
            MyNetsolaceUserFranchisee = 4
        End Enum

        Public Enum FransupportEnd

            AdminEnd = 1
            OwnerEnd = 2
            StoreEnd = 3

        End Enum


        Public Enum Departments
            Support = 3
        End Enum



        Public Enum ContactsType
            Netsolace = 1
            Client = 2
        End Enum
        Public Enum Login_Request
            Launchpad = 1
            Remote = 2
            Office = 3
        End Enum
        Public Enum ClientStatus
            NoApprovalRequired = 0
            Pending = 1
            Approved = 2
            Rejected = 3
            QuoteRejected = 4
        End Enum

        Public Enum DayOfWeekSQLServer
            Sunday = 1
            Monday = 2
            Tuesday = 3
            Wednessday = 4
            Thursday = 5
            Friday = 6
            Saturday = 7
        End Enum

        Public Enum TimeZones
            Hawaii = 1
            Alaska = 2
            PacificTimeUSAndCanada = 3
            Calefornia = 4
            Arizona = 5
            MountainTimeUSAndCanada = 6
            CenteralAmeria = 7
            CenteralTimeUSAndCanada = 8
            EasternTimeUSAndCanada = 9
            AtlanticTimeCanada = 10
            AbuDhabiMuscat = 11
            IslamabadKarachi = 12
            GreenwichMeanTimeDublinLondon = 13
            EuropeIreland = 14
            AsiaKuwait = 16
        End Enum

        Public Enum AttendenceTypes
            TimeCorrection = 1
            ShortLeave = 2
            OutDuty = 3
        End Enum

        Public Enum ActivitySurveyRate
            Great = 1
            OK = 2
            UnHappy = 3
        End Enum

        Public Enum SMSxTerminalType
            SMSx = 5 ' SMSx other terminals
            FruitExpert = 4   ' Fruit Expert For SMSx
            SMSxOrderingApp = 6 ' SMSx Ordering App
            SMSxDeliveryApp = 7 ' SMSx Delivery App
            SMSxProductionApp = 8   ' SMSx  Production App
        End Enum
        Public Enum ResourceType
            ProjectManagerLead = 29
            QALead = 13
            DevLead = 7
            DesignLead = 8
            ProductOwnerLead = 17
            Admin = 1
        End Enum
        Public Enum ResourceIds
            ProjectManager = 1
            ProductOwner = 2
            DesignLead = 3
            DevelopmentLead = 4
            QALead = 5
        End Enum
        Public Enum AttachmentType
            SOW = 1
            BRD = 2
            General = 0
        End Enum


    End Class

End Namespace