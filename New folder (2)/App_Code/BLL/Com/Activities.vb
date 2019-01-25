Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.BLL

    Public Class Activities

#Region " Private Members "
        Private Const TicketNoRegex As String = "^[a-zA-Z]{1}[\d]{3,10}$"
        Private _ID As Integer
        Private _ClientID As Integer
		Private _ContactEmail As String
        Private _FranchiseID As Integer
        Private _AdminID As Integer
        Private _Storename As String
        Private _Storenumber As String
        Private _OpenActivities As Integer
        Private _UserID As Integer
        Private _CategoryID As Integer
        Private _SubCategoryID As Integer
        Private _DepartmentID As Integer
        Private _Departmentname As String
        Private _Adminname As String
        Private _LastUpdate As Date
        Private _FranchiseContactID As Integer
        Private _TicketNumber As Integer
        Private _TimeSpent As TimeSpan
        Private _Date As Date
        Private _Type As Integer
        Private _SubType As Integer
        Private _Subject As String
        Private _Description As String
        Private _Status As Boolean
        Private _Deleted As Boolean
        Private _PlacedBy As Integer
        Private _ActivityState As Integer
        Private _WaitingFor As String
        Private _Waitingforname As String
        Private _LastWaitingFor As String
        Private _Charge As Boolean
        Private _ChargeAmount As Decimal
        Private _Paid As Boolean
        Private _AdminReadStatus As Boolean
        Private _FranchiseeReadStatus As Boolean
        Private _AdminInboxStatus As Integer
        Private _Category As Integer
        Private _FranchiseInboxStatus As Integer
        Private _ForManagementOnly As Boolean
        Private _Name As String
        Private _Address As String
        Private _Phone As String
        Private _CorporateName As String
        Private _WaitingForID As String
        Private _IsClose As Boolean
        Private _Topic As String 'Added By Farooq Azam
        Private _FranchiseeContactName As String
        Private _ClientContactID As Integer
        Private _ClientContactName As String
        Private _Priority As Integer
        Private _Rate As Integer
        Private _RateComments As String
        Private _LastUpdatedBy As Integer
		Private _RelatedTo As Integer
        Private _ModuleId As Integer
        Private _ModuleName As String
        Private _RelatedTitle As String

        Public Enum ActivityEmailType
            WaitingFor = 1
            PublicNotes = 2
        End Enum


#End Region

#Region " Public Properties "

        Public Property ID() As Integer
            Get
                Return _ID
            End Get
            Set(ByVal value As Integer)
                _ID = value
            End Set
        End Property

        Public Property ClientID() As Integer
            Get
                Return _ClientID
            End Get
            Set(ByVal value As Integer)
                _ClientID = value
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

        Public Property AdminID() As Integer
            Get
                Return _AdminID
            End Get
            Set(ByVal value As Integer)
                _AdminID = value
            End Set
        End Property

        Public Property StoreName() As String
            Get
                Return _Storename
            End Get
            Set(ByVal value As String)
                _Storename = value
            End Set
        End Property

        Public Property StoreNumber() As String
            Get
                Return _Storenumber
            End Get
            Set(ByVal value As String)
                _Storenumber = value
            End Set
        End Property

        Public Property UserID() As Integer
            Get
                Return _UserID
            End Get
            Set(ByVal value As Integer)
                _UserID = value
            End Set
        End Property

        Public Property CategoryID() As Integer
            Get
                Return _categoryid
            End Get
            Set(ByVal value As Integer)
                _categoryid = value
            End Set
        End Property

        Public Property SubCategoryID() As Integer
            Get
                Return _subcategoryid
            End Get
            Set(ByVal value As Integer)
                _subcategoryid = value
            End Set
        End Property

        Public Property LastUpdate() As Date
            Get
                Return _lastupdate
            End Get
            Set(ByVal value As Date)
                _lastupdate = value
            End Set
        End Property

        Public Property DepartmentID() As Integer
            Get
                Return _DepartmentID
            End Get
            Set(ByVal value As Integer)
                _DepartmentID = value
            End Set
        End Property

        Public Property DepartmentName() As String
            Get
                Return _Departmentname
            End Get
            Set(ByVal value As String)
                _Departmentname = value
            End Set
        End Property

        Public Property AdminName() As String
            Get
                Return _adminname
            End Get
            Set(ByVal value As String)
                _adminname = value
            End Set
        End Property

        Public Property OpenActivities() As Integer
            Get
                Return _OpenActivities
            End Get
            Set(ByVal value As Integer)
                _OpenActivities = value
            End Set
        End Property
        Public Property FranchiseContactID() As Integer
            Get
                Return _franchisecontactid
            End Get
            Set(ByVal value As Integer)
                _franchisecontactid = value
            End Set
        End Property

        Public Property TicketNumber() As Integer
            Get
                Return _ticketnumber
            End Get
            Set(ByVal value As Integer)
                _ticketnumber = value
            End Set
        End Property

        Public Property ActivityDate() As Date
            Get
                Return _date
            End Get
            Set(ByVal value As Date)
                _date = value
            End Set
        End Property

        Public Property Type() As Integer
            Get
                Return _type
            End Get
            Set(ByVal value As Integer)
                _type = value
            End Set
        End Property

        Public Property SubType() As Integer
            Get
                Return _subtype
            End Get
            Set(ByVal value As Integer)
                _subtype = value
            End Set
        End Property

        Public Property Subject() As String
            Get
                Return _subject
            End Get
            Set(ByVal value As String)
                _subject = value
            End Set
        End Property

        Public Property Description() As String
            Get
                Return _description
            End Get
            Set(ByVal value As String)
                _description = value
            End Set
        End Property

        Public Property Status() As Boolean
            Get
                Return _status
            End Get
            Set(ByVal value As Boolean)
                _status = value
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

        Public Property PlacedBy() As Integer
            Get
                Return _PlacedBy
            End Get
            Set(ByVal value As Integer)
                _PlacedBy = value
            End Set
        End Property

        Public Property ActivityState() As Integer
            Get
                Return _activitystate
            End Get
            Set(ByVal value As Integer)
                _activitystate = value
            End Set
        End Property

        Public Property WaitingFor() As String
            Get
                Return _waitingfor
            End Get
            Set(ByVal value As String)
                _waitingfor = value
            End Set
        End Property

        Public Property WaitingForName() As String
            Get
                Return _Waitingforname
            End Get
            Set(ByVal value As String)
                _Waitingforname = value
            End Set
        End Property

        Public Property LastWaitingFor() As String
            Get
                Return _LastWaitingFor
            End Get
            Set(ByVal value As String)
                _LastWaitingFor = value
            End Set
        End Property

        Public Property Charge() As Boolean
            Get
                Return _charge
            End Get
            Set(ByVal value As Boolean)
                _charge = value
            End Set
        End Property

        Public Property ChargeAmount() As Decimal
            Get
                Return _chargeamount
            End Get
            Set(ByVal value As Decimal)
                _chargeamount = value
            End Set
        End Property

        Public Property Paid() As Boolean
            Get
                Return _paid
            End Get
            Set(ByVal value As Boolean)
                _paid = value
            End Set
        End Property

        Public Property AdminReadStatus() As Boolean
            Get
                Return _adminreadstatus
            End Get
            Set(ByVal value As Boolean)
                _adminreadstatus = value
            End Set
        End Property

        Public Property FranchiseeReadStatus() As Boolean
            Get
                Return _franchiseereadstatus
            End Get
            Set(ByVal value As Boolean)
                _franchiseereadstatus = value
            End Set
        End Property

        Public Property AdminInboxStatus() As Integer
            Get
                Return _admininboxstatus
            End Get
            Set(ByVal value As Integer)
                _admininboxstatus = value
            End Set
        End Property

        Public Property Category() As Integer
            Get
                Return _category
            End Get
            Set(ByVal value As Integer)
                _category = value
            End Set
        End Property

        Public Property FranchiseInboxStatus() As Integer
            Get
                Return _franchiseinboxstatus
            End Get
            Set(ByVal value As Integer)
                _franchiseinboxstatus = value
            End Set
        End Property

        Public Property ForManagementOnly() As Boolean
            Get
                Return _formanagementonly
            End Get
            Set(ByVal value As Boolean)
                _formanagementonly = value
            End Set
        End Property

        Public Property TimeSpent() As TimeSpan
            Get
                Return _TimeSpent
            End Get
            Set(ByVal value As TimeSpan)
                _TimeSpent = value
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
        Public Property Address() As String
            Get
                Return _Address
            End Get
            Set(ByVal value As String)
                _Address = value
            End Set
        End Property


        Public Property Phone() As String
            Get
                Return _Phone
            End Get
            Set(ByVal value As String)
                _Phone = value
            End Set
        End Property


        Public Property CorporateName() As String
            Get
                Return _CorporateName
            End Get
            Set(ByVal value As String)
                _CorporateName = value
            End Set
        End Property

        Public Property WaitingForID() As String
            Get
                Return _WaitingForID
            End Get
            Set(ByVal value As String)
                _WaitingForID = value
            End Set
        End Property

        Public Property IsClose() As Boolean
            Get
                Return _IsClose
            End Get
            Set(ByVal value As Boolean)
                _IsClose = value
            End Set
        End Property
        Public Property ActivityTopic() As String
            Get
                Return _Topic
            End Get
            Set(ByVal value As String)
                _Topic = value
            End Set
        End Property
        Public Property FranchiseeContactName() As String
            Get
                Return _FranchiseeContactName
            End Get
            Set(ByVal value As String)
                _FranchiseeContactName = value
            End Set
        End Property
        Public Property ClientContactID() As String
            Get
                Return _ClientContactID
            End Get
            Set(ByVal value As String)
                _ClientContactID = value
            End Set
        End Property
        Public Property ClientContactName() As String
            Get
                Return _ClientContactName
            End Get
            Set(ByVal value As String)
                _ClientContactName = value
            End Set
        End Property
        Public Property Priority() As Integer
            Get
                Return _Priority
            End Get
            Set(ByVal value As Integer)
                _Priority = value
            End Set
        End Property

        Public Property Rate() As Integer
            Get
                Return _Rate
            End Get
            Set(ByVal value As Integer)
                _Rate = value
            End Set
        End Property

        Public Property RateComments() As String
            Get
                Return _RateComments
            End Get
            Set(ByVal value As String)
                _RateComments = value
            End Set
        End Property

        Public Property LastUpdatedBy() As Integer
            Get
                Return _LastUpdatedBy
            End Get
            Set(ByVal value As Integer)
                _LastUpdatedBy = value
            End Set
        End Property
		

        Public Property RelatedTo() As Integer
            Get
                Return _RelatedTo
            End Get
            Set(ByVal value As Integer)
                _RelatedTo = value
            End Set
        End Property

        Public Property RelatedTitle() As String
            Get
                Return _RelatedTitle
            End Get
            Set(ByVal value As String)
                _RelatedTitle = value
            End Set
        End Property

        Public Property ModuleId() As Integer
            Get
                Return _ModuleId
            End Get
            Set(ByVal value As Integer)
                _ModuleId = value
            End Set
        End Property

        Public Property ModuleName() As String
            Get
                Return _ModuleName
            End Get
            Set(ByVal value As String)
                _ModuleName = value
            End Set
        End Property

        Public Property ContactEmail() As String
            Get
                Return _ContactEmail
            End Get
            Set(ByVal value As String)
                _ContactEmail = value
            End Set
        End Property

#End Region

#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal UserID As Integer, _
          ByVal CategoryID As Integer, _
          ByVal SubCategoryID As Integer, _
          ByVal DepartmentID As Integer, _
          ByVal FranchiseContactID As Integer, _
          ByVal TicketNumber As Integer, _
          ByVal TimeSpent As TimeSpan, _
          ByVal ActivityDate As Date, _
          ByVal Type As Integer, _
          ByVal SubType As Integer, _
          ByVal Subject As String, _
          ByVal Description As String, _
          ByVal Status As Boolean, _
          ByVal Deleted As Boolean, _
          ByVal PlacedBy As Integer, _
          ByVal ActivityState As Integer, _
          ByVal WaitingFor As String, _
          ByVal LastWaitingFor As String, _
          ByVal Charge As Boolean, _
          ByVal ChargeAmount As Decimal, _
          ByVal Paid As Boolean, _
          ByVal AdminReadStatus As Boolean, _
          ByVal FranchiseeReadStatus As Boolean, _
          ByVal AdminInboxStatus As Integer, _
          ByVal Category As Integer, _
          ByVal FranchiseInboxStatus As Integer, _
          ByVal ForManagementOnly As Boolean _
         )

            Me.ID = ID

            Me.FranchiseID = FranchiseID
            Me.UserID = UserID
            Me.CategoryID = CategoryID
            Me.SubCategoryID = SubCategoryID
            Me.DepartmentID = DepartmentID
            Me.FranchiseContactID = FranchiseContactID
            Me.TicketNumber = TicketNumber
            Me.TimeSpent = TimeSpent
            Me.ActivityDate = ActivityDate
            Me.Type = Type
            Me.SubType = SubType
            Me.Subject = Subject
            Me.Description = Description
            Me.Status = Status
            Me.Deleted = Deleted
            Me.PlacedBy = PlacedBy
            Me.ActivityState = ActivityState
            Me.WaitingFor = WaitingFor
            Me.LastWaitingFor = LastWaitingFor
            Me.Charge = Charge
            Me.ChargeAmount = ChargeAmount
            Me.Paid = Paid
            Me.AdminReadStatus = AdminReadStatus
            Me.FranchiseeReadStatus = FranchiseeReadStatus
            Me.AdminInboxStatus = AdminInboxStatus
            Me.Category = Category
            Me.FranchiseInboxStatus = FranchiseInboxStatus
            Me.ForManagementOnly = ForManagementOnly

	#End Sub

        Public Sub New( _
         ByVal FranchiseID As Integer, _
         ByVal UserID As Integer, _
         ByVal DepartmentID As Integer, _
         ByVal FranchiseContactID As Integer, _
         ByVal TimeSpent As TimeSpan, _
         ByVal ActivityDate As Date, _
         ByVal Type As Integer, _
         ByVal SubType As Integer, _
         ByVal Subject As String, _
         ByVal Description As String, _
         ByVal Status As Boolean, _
         ByVal PlacedBy As Integer, _
         ByVal ActivityState As Integer, _
         ByVal WaitingFor As String, _
         ByVal AdminInboxStatus As Integer, _
         ByVal Charge As Boolean, _
         ByVal ClientContactID As Integer, _
		 ByVal RelatedTo As Integer, _
         ByVal ModuleId As Integer _
        )

            Me.FranchiseID = FranchiseID
            Me.UserID = UserID
            Me.DepartmentID = DepartmentID
            Me.FranchiseContactID = FranchiseContactID
            Me.TimeSpent = TimeSpent
            Me.ActivityDate = ActivityDate
            Me.Type = Type
            Me.SubType = SubType
            Me.Subject = Subject
            Me.Description = Description
            Me.Status = Status
            Me.PlacedBy = PlacedBy
            Me.ActivityState = ActivityState
            Me.WaitingFor = WaitingFor
            Me.AdminInboxStatus = AdminInboxStatus
            Me.Charge = Charge
            Me.ClientContactID = ClientContactID
            Me.RelatedTo = RelatedTo
            Me.ModuleId = ModuleId

	#End Sub

        Public Sub New( _
                      ByVal ID As Integer, _
                      ByVal FranchiseID As Integer, _
                      ByVal ActivityDate As Date, _
                      ByVal Type As Integer, _
                      ByVal Subject As String, _
                      ByVal ActivityState As Integer, _
                      ByVal WaitingForName As String, _
                      ByVal WaitingFor As String, _
                      ByVal StoreName As String, _
                      ByVal DepartmentName As String, _
                      ByVal AdminReadStatus As Boolean _
                     )

            Me.ID = ID
            Me.FranchiseID = FranchiseID
            Me.ActivityDate = ActivityDate
            Me.Type = Type
            Me.Subject = Subject
            Me.ActivityState = ActivityState
            Me.WaitingFor = WaitingFor
            Me.WaitingForName = WaitingForName
            Me.StoreName = StoreName
            Me.DepartmentName = DepartmentName
            Me.AdminReadStatus = AdminReadStatus
	#End Sub

        Public Sub New( _
           ByVal ID As Integer, _
           ByVal Subject As String, _
           ByVal Status As Boolean, _
           ByVal ActivityState As Integer, _
           ByVal ActivityDate As Date, _
           ByVal Type As Integer, _
           ByVal SubType As Integer, _
           ByVal DepartmentName As String, _
           ByVal WaitingFor As String, _
           ByVal TimeSpent As TimeSpan, _
           ByVal AdminName As String, _
           ByVal Description As String _
          )

            Me.ID = ID
            Me.Subject = Subject
            Me.ActivityState = ActivityState
            Me.Status = Status
            Me.ActivityDate = ActivityDate
            Me.Type = Type
            Me.SubType = SubType
            Me.DepartmentName = DepartmentName
            Me.WaitingFor = WaitingFor
            Me.TimeSpent = TimeSpent
            Me.AdminName = AdminName
            Me.Description = Description

	#End Sub

        Public Sub New( _
                      ByVal ID As Integer, _
                      ByVal FranchiseID As Integer, _
                      ByVal ActivityDate As Date, _
                      ByVal Type As Integer, _
                      ByVal Subject As String, _
                      ByVal ActivityState As Integer, _
                      ByVal WaitingForName As String, _
                      ByVal WaitingFor As String, _
                      ByVal StoreNumber As String, _
                      ByVal StoreName As String, _
                      ByVal DepartmentName As String, _
                      ByVal AdminReadStatus As Boolean _
                     )

            Me.ID = ID
            Me.FranchiseID = FranchiseID
            Me.ActivityDate = ActivityDate
            Me.Type = Type
            Me.Subject = Subject
            Me.ActivityState = ActivityState
            Me.WaitingFor = WaitingFor
            Me.WaitingForName = WaitingForName
            Me.DepartmentName = DepartmentName
            Me.StoreName = StoreName
            Me.StoreNumber = StoreNumber
            Me.AdminReadStatus = AdminReadStatus
	#End Sub
        Public Sub New( _
                   ByVal ID As Integer, _
                   ByVal Status As Integer, _
                   ByVal OpenActivities As Integer, _
                   ByVal StoreNumber As String, _
                   ByVal LastUpdate As Date, _
                   ByVal StoreName As String, _
                   ByVal Address As String, _
                   ByVal phone As String, _
                   ByVal CorporateName As String, _
                   ByVal ClientID As Integer _
                  )

            Me.ID = ID
            Me.ActivityState = Status
            Me.StoreName = StoreName
            Me.StoreNumber = StoreNumber
            Me.OpenActivities = OpenActivities
            Me.LastUpdate = LastUpdate
            Me.Address = Address
            Me.Phone = phone
            Me.CorporateName = CorporateName
            Me.ClientID = ClientID

	#End Sub
        Public Sub New( _
                         ByVal ID As Integer, _
                         ByVal FranchiseID As Integer, _
                         ByVal ActivityDate As Date, _
                         ByVal ActivityType As Integer, _
                         ByVal Subject As Date, _
                         ByVal ActivityState As Integer, _
                         ByVal StoreName As String)

            Me.ID = ID
            Me.FranchiseID = FranchiseID
            Me.ActivityDate = ActivityDate
            Me.Type = ActivityType
            Me.Subject = Subject
            Me.ActivityState = ActivityState
            Me.StoreName = StoreName
#end sub
        'Added By Farooq Azam
        Public Sub New( _
         ByVal ID As Integer, _
         ByVal Subject As String, _
         ByVal Status As Boolean, _
         ByVal ActivityState As Integer, _
         ByVal ActivityDate As Date, _
         ByVal Type As Integer, _
         ByVal SubType As Integer, _
         ByVal DepartmentName As String, _
         ByVal WaitingFor As String, _
         ByVal TimeSpent As TimeSpan, _
         ByVal AdminName As String, _
         ByVal Description As String, _
         ByVal ActivityTopic As String _
        )

            Me.ID = ID
            Me.Subject = Subject
            Me.ActivityState = ActivityState
            Me.Status = Status
            Me.ActivityDate = ActivityDate
            Me.Type = Type
            Me.SubType = SubType
            Me.DepartmentName = DepartmentName
            Me.WaitingFor = WaitingFor
            Me.TimeSpent = TimeSpent
            Me.AdminName = AdminName
            Me.Description = Description
            Me.ActivityTopic = ActivityTopic

	#End Sub

        'Added By Muhammad Sajjad
        Public Sub New( _
         ByVal ID As Integer, _
         ByVal Subject As String, _
         ByVal Status As Boolean, _
         ByVal ActivityState As Integer, _
         ByVal ActivityDate As Date, _
         ByVal Type As Integer, _
         ByVal SubType As Integer, _
         ByVal PlacedBy As Integer, _
         ByVal WaitingFor As String, _
         ByVal TimeSpent As TimeSpan, _
         ByVal AdminName As String, _
         ByVal Description As String, _
         ByVal ActivityTopic As String, _
         ByVal FranchiseContactName As String, _
         ByVal AdminInboxStatus As Boolean, _
         ByVal Priority As Integer, _
         ByVal Rate As Integer, _
         ByVal RateComments As String, _
         ByVal LastUpdatedBy As Integer, _
         ByVal RelatedTo As Integer, _
         ByVal RelatedTitle As String, _
         ByVal ModuleName As String, _
         ByVal ModuleId As String, _
         ByVal ContactEmail As String _
        )

            Me.ID = ID
            Me.Subject = Subject
            Me.ActivityState = ActivityState
            Me.Status = Status
            Me.ActivityDate = ActivityDate
            Me.Type = Type
            Me.SubType = SubType
            Me.PlacedBy = PlacedBy
            Me.WaitingFor = WaitingFor
            Me.TimeSpent = TimeSpent
            Me.AdminName = AdminName
            Me.Description = Description
            Me.ActivityTopic = ActivityTopic
            Me.FranchiseeContactName = FranchiseContactName
            Me.AdminInboxStatus = AdminInboxStatus
            Me.Priority = Priority
            Me.Rate = Rate
            Me.RateComments = RateComments
            Me.LastUpdatedBy = LastUpdatedBy
            Me.RelatedTo = RelatedTo
            Me.RelatedTitle = RelatedTitle
            Me.ModuleName = ModuleName
            Me.ModuleId = ModuleId
			Me.ContactEmail = ContactEmail

	#End Sub

#End Region

#Region " Public Method "
        Public Shared Function GetAdminInboxForMyNetsolace(ByVal sortExpression As String, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal ClientID As Integer, ByVal Search As String, ByVal Filter As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable
			If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)		
            Return Portal.DAL.Activities.GetAdminInboxForMyNetsolace(ClientID, FranchiseID, ProductId, Search, sortExpression, Filter, startRowIndex, maximumRows, ReturnValue)
        End Function
        Public Shared Function GetAdminInboxCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer) As Integer
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)		
            Return Portal.DAL.Activities.GetAdminInboxCountForMyNetsolace(ClientID, FranchiseID, ProductId, Search, Filter, ReturnValue)
        End Function
        Public Shared Function GetAdminInboxForHelpDesk(ByVal sortExpression As String, ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal PriorityID As Integer) As DataTable
            If CInt(WaitingFor) > 0 Then WaitingFor = "A" & WaitingFor
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminInboxForHelpDesk(ClientID, FranchiseID, TopicID, Search, sortExpression, Filter, AssingedBy, WaitingFor, startRowIndex, maximumRows, ReturnValue, PriorityID)
        End Function
        Public Shared Function GetAdminInboxForHelpDeskcount(ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal ReturnValue As Integer, ByVal PriorityID As Integer) As Integer
            If CInt(WaitingFor) > 0 Then WaitingFor = "A" & WaitingFor
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminInboxForHelpDeskCount(ClientID, FranchiseID, TopicID, Search, Filter, AssingedBy, WaitingFor, PriorityID)
        End Function
        Public Shared Function GetAdminInboxForHelpDesk_ByClientIdList(ByVal sortExpression As String, ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As DataTable
            If CInt(WaitingFor) > 0 Then WaitingFor = "A" & WaitingFor
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminInboxForHelpDesk_ByClientIdList(ClientID, FranchiseID, TopicID, Search, sortExpression, Filter, AssingedBy, WaitingFor, startRowIndex, maximumRows, ReturnValue, PriorityID, ClientIDList, TicketType)
        End Function
        Public Shared Function GetAdminInboxForHelpDeskcount_ByClientIdList(ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal ReturnValue As Integer, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As Integer
            If CInt(WaitingFor) > 0 Then WaitingFor = "A" & WaitingFor
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminInboxForHelpDeskCount_ByClientIdList(ClientID, FranchiseID, TopicID, Search, Filter, AssingedBy, WaitingFor, PriorityID, ClientIDList, TicketType)
        End Function
        Public Shared Function GetAdminInboxForHelpDesk_ByClientIdList_Export(ByVal sortExpression As String, ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As DataTable
            If CInt(WaitingFor) > 0 Then WaitingFor = "A" & WaitingFor
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminInboxForHelpDesk_ByClientIdList_Export(ClientID, FranchiseID, TopicID, Search, sortExpression, Filter, AssingedBy, WaitingFor, startRowIndex, maximumRows, ReturnValue, PriorityID, ClientIDList, TicketType)
        End Function
        Public Shared Function GetAdminInboxForHelpDeskcount_ByClientIdList_Export(ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal TopicID As Integer, ByVal Search As String, ByVal Filter As Integer, ByVal AssingedBy As Integer, ByVal WaitingFor As String, ByVal ReturnValue As Integer, ByVal PriorityID As Integer, ByVal ClientIDList As String, Optional TicketType As String = "") As Integer
            If CInt(WaitingFor) > 0 Then WaitingFor = "A" & WaitingFor
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminInboxForHelpDeskCount_ByClientIdList_Export(ClientID, FranchiseID, TopicID, Search, Filter, AssingedBy, WaitingFor, PriorityID, ClientIDList, TicketType)
        End Function


        Public Shared Function GetCompletedActivitiesForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal sortExpression As String) As DataSet
            Return Portal.DAL.Activities.GetCompletedActivitiesForMyNetsolace(ClientID, FranchiseID, sortExpression)
        End Function

        Public Shared Function GetCompletedActivitiesForMyNetsolaceHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal sortExpression As String) As DataSet
            Return Portal.DAL.Activities.GetCompletedActivitiesForMyNetsolaceHelpDesk(ClientID, FranchiseID, sortExpression)
        End Function
        Public Shared Function GetCompletedActivitiesForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal sortExpression As String) As DataSet
            Return Portal.DAL.Activities.GetCompletedActivitiesForHelpDesk(ClientID, FranchiseID, sortExpression)
        End Function

       

        Public Shared Function GetActivityByID(ByVal ClientID As Integer, ByVal ID As Integer) As List(Of Activities)
            'Dim com_ActivitiesDal As Portal.DAL.DBActivities = New Portal.DAL.DBActivities()
            Return Portal.DAL.Activities.GetActivityByID(ClientID, ID)
            'Return Portal.DAL.DBActivities.GetActivityByID(ID)
        End Function
        Public Shared Function UpdateTimeSpent(ByVal ClientID As Integer, ByVal ObjActivity As Activities) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return com_ActivitiesDal.UpdateTimeSpent(ClientID, ObjActivity)
        End Function

'        Public Shared Function UpdateDepartment(ByVal ClientID As Integer, ByVal ObjActivity As Activities) As Integer
'            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
'            Return com_ActivitiesDal.UpdateDepartment(ClientID, ObjActivity)
'        End Function
        Public Function ActivitiesAdd(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal AdminID As Integer, ByVal DepartmentID As Integer, ByVal FranchiseContactID As Integer, ByVal TimeSpent As String, ByVal ActivityDate As Date, ByVal Type As Integer, ByVal SubType As Integer, ByVal Subject As String, ByVal Description As String, ByVal Status As Boolean, ByVal PlacedBy As Integer, ByVal ActivityState As Integer, ByVal WaitingFor As String, ByVal AdminInboxStatus As Integer, ByVal charge As Boolean, ByVal ClientContactID As Integer, ByVal RelatedTo As Integer, ByVal ModuleId As Integer) As Integer
            Dim com_ActivitiesBll As Activities = New Activities(FranchiseID, AdminID, DepartmentID, FranchiseContactID, TimeSpan.Parse(TimeSpent), ActivityDate, Type, SubType, Subject, Description, Status, PlacedBy, ActivityState, WaitingFor, AdminInboxStatus, charge, ClientContactID, RelatedTo, ModuleId)
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return com_ActivitiesDal.Add(ClientID, com_ActivitiesBll)
        End Function
        Public Function ActivitiesAdd(ByVal ObjActivity As Activities) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return com_ActivitiesDal.Add(ObjActivity)
        End Function
        Public Shared Function GetFranchiseeInboxForMyNetsolace(ByVal sortExpression As String, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)		
            Return Portal.DAL.Activities.GetFranchiseeInboxForMyNetsolace(ClientID, FranchiseID, Search, sortExpression, startRowIndex, maximumRows, ReturnValue)
        End Function
        Public Shared Function GetFranchiseeInboxCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer) As Integer
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)		
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return Portal.DAL.Activities.GetFranchiseeInboxCountForMyNetsolace(ClientID, FranchiseID, Search, ReturnValue)
        End Function

        Public Shared Function GetHelpDeskInboxForMyNetsolace(ByVal sortExpression As String, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal Search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetHelpDeskInboxForMyNetsolace(ClientID, FranchiseID, ProductId, Search, sortExpression, startRowIndex, maximumRows, ReturnValue)
        End Function
        Public Shared Function GetHelpDeskInboxCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ProductId As Integer, ByVal Search As String, ByVal ReturnValue As Integer) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetHelpDeskInboxCountForMyNetsolace(ClientID, FranchiseID, ProductId, Search, ReturnValue)
        End Function
        Public Shared Function GetFranchiseeInboxForHelpDesk(ByVal sortExpression As String, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer) As DataTable
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetFranchiseeInboxForHelpDesk(ClientID, FranchiseID, Search, sortExpression, startRowIndex, maximumRows, ReturnValue)
        End Function
        Public Shared Function GetFranchiseeInboxCountForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetFranchiseeInboxCountForHelpDesk(ClientID, FranchiseID, Search, ReturnValue)
        End Function

        Public Shared Function GetAdminHistoryForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)		
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return Portal.DAL.Activities.GetAdminHistoryForMyNetsolace(ClientID, FranchiseID, Search, ReturnValue, sortExpression, startRowIndex, maximumRows, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetAdminHistoryCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)		
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return Portal.DAL.Activities.GetAdminHistoryCountForMyNetsolace(ClientID, FranchiseID, Search, ReturnValue, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetAdminHistoryForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AssingedBy As Integer, ByVal PriorityID As Integer, ByVal CompletedBy As Integer, ByVal RelatedTo As Integer) As DataTable
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminHistoryForHelpDesk(ClientID, FranchiseID, Search, Filter, ReturnValue, sortExpression, startRowIndex, maximumRows, Type, SubType, DateFrom, DateTo.AddDays(1), AssingedBy, PriorityID, CompletedBy, RelatedTo)
        End Function
	Public Shared Function GetAdminHistoryForHelpDesk_Export(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AssingedBy As Integer, ByVal PriorityID As Integer, ByVal CompletedBy As Integer, ByVal RelatedTo As Integer) As DataTable
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminHistoryForHelpDesk_Export(ClientID, FranchiseID, Search, Filter, ReturnValue, sortExpression, startRowIndex, maximumRows, Type, SubType, DateFrom, DateTo.AddDays(1), AssingedBy, PriorityID, CompletedBy, RelatedTo)
        End Function


        Public Shared Function GetAdminHistoryCountForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AssingedBy As Integer, ByVal PriorityID As Integer, ByVal CompletedBy As Integer, ByVal RelatedTo As Integer) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetAdminHistoryCountForHelpDesk(ClientID, FranchiseID, Search, Filter, ReturnValue, Type, SubType, DateFrom, DateTo.AddDays(1), AssingedBy, PriorityID, CompletedBy, RelatedTo)
        End Function
        Public Shared Function GetFranchiseeHistoryForMyNetsolace(ByVal sortExpression As String, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)			
            Return Portal.DAL.Activities.GetFranchiseeHistoryForMyNetsolace(ClientID, FranchiseID, Search, sortExpression, startRowIndex, maximumRows, ReturnValue, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetFranchiseeHistoryCountForMyNetsolace(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)			
            Return Portal.DAL.Activities.GetFranchiseeHistoryCountForMyNetsolace(ClientID, FranchiseID, Search, ReturnValue, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetFranchiseeHistoryForHelpDesk(ByVal sortExpression As String, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetFranchiseeHistoryForHelpDesk(ClientID, FranchiseID, Search, sortExpression, startRowIndex, maximumRows, ReturnValue, Type, SubType, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetFranchiseeHistoryCountForHelpDesk(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal ReturnValue As Integer, ByVal Type As Integer, ByVal SubType As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetFranchiseeHistoryCountForHelpDesk(ClientID, FranchiseID, Search, ReturnValue, Type, SubType, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetFranchiseeSurveyReportForHelpDesk(ByVal sortExpression As String, ByVal ClientID As Integer, ByVal Search As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As DataTable
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetFranchiseeSurveyReportForHelpDesk(sortExpression, ClientID, Search, startRowIndex, maximumRows, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetFranchiseeSurveyReportCountForHelpDesk(ByVal ClientID As Integer, ByVal Search As String, ByVal DateFrom As DateTime, ByVal DateTo As DateTime) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            If Search <> Nothing AndAlso Regex.IsMatch(Search, TicketNoRegex) Then Search = Search.Substring(1)
            Return Portal.DAL.Activities.GetFranchiseeSurveyReportCountForHelpDesk(ClientID, Search, DateFrom, DateTo.AddDays(1))
        End Function
        Public Shared Function GetStoreByActivities(ByVal ClientID As Integer, ByVal Search As String, ByVal StateID As Integer) As SqlDataReader
            Return Portal.DAL.Activities.GetStoreByActivities(ClientID, Search, StateID)
        End Function
        Public Shared Function SearchStores_ByClientIdList(ByVal Search As String, ByVal StateID As Integer, ByVal ClientIDList As String) As SqlDataReader
            'This function will be used to search stores on the base of Client Access.
            Return Portal.DAL.Activities.SearchStores_ByClientIdList(Search, StateID, ClientIDList)
        End Function
        Public Shared Function SearchStores(ByVal ClientID As Integer, ByVal Search As String, ByVal StateID As Integer) As SqlDataReader
            'This function will be used to search stores from Portal franchises table.
            Return Portal.DAL.Activities.SearchStores(ClientID, Search, StateID)
        End Function
        Public Shared Function UpdateActivityState(ByVal ClientID As Integer, ByVal ObjActivity As Activities) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return com_ActivitiesDal.UpdateActivityState(ClientID, ObjActivity)
        End Function
        Public Shared Function UpdateActivityStatus(ByVal ClientID As Integer, ByVal ObjActivity As Activities) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return com_ActivitiesDal.UpdateActivityStatus(ClientID, ObjActivity)
        End Function
        Public Shared Function UpdateLastActivityStateForHelpDeskOnRejection(ByVal ClientID As Integer, ByVal ObjActivity As Activities) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return com_ActivitiesDal.UpdateLastActivityStateForHelpDeskOnRejection(ClientID, ObjActivity)
        End Function
        Public Shared Function ActivitiesGetAllBySearch(ByVal ClientID As Integer, ByVal WaitingFor As String, ByVal SortExpression As Integer) As SqlDataReader
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return Portal.DAL.Activities.ActivitiesGetAllBySearch(ClientID, WaitingFor, SortExpression)
        End Function
        Public Shared Function GetAreaDeveloperActivitiesInbox(ByVal sortExpression As String, ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal Search As String, ByVal Filter As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal ReturnValue As Integer, ByVal AreaDeveloperID As Integer) As DataTable
            Return Portal.DAL.Activities.GetAreaDeveloperActivitiesInbox(sortExpression, FranchiseID, ClientID, Search, Filter, startRowIndex, maximumRows, ReturnValue, AreaDeveloperID)
        End Function
        Public Shared Function GetAreaDeveloperActivitiesInboxCount(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal AreaDeveloperID As Integer) As Integer
            Return Portal.DAL.Activities.GetAreaDeveloperActivitiesInboxCount(ClientID, FranchiseID, Search, Filter, ReturnValue, AreaDeveloperID)
        End Function
        Public Shared Function GetAreaDeveloperHistory(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal sortExpression As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AreaDeveloperID As Integer) As DataTable
            Return Portal.DAL.Activities.GetAreaDeveloperHistory(ClientID, FranchiseID, Search, Filter, ReturnValue, sortExpression, startRowIndex, maximumRows, DateFrom, DateTo, AreaDeveloperID)
        End Function
        Public Shared Function GetAreaDeveloperHistoryCount(ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal Search As String, ByVal Filter As String, ByVal ReturnValue As Integer, ByVal DateFrom As DateTime, ByVal DateTo As DateTime, ByVal AreaDeveloperID As Integer) As Integer
            Return Portal.DAL.Activities.GetAreaDeveloperHistoryCount(ClientID, FranchiseID, Search, Filter, ReturnValue, DateFrom, DateTo, AreaDeveloperID)
        End Function
        Public Shared Function UpdateActivityPriority(ByVal ActivityID As Integer, ByVal PriorityID As Integer) As Integer
            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
            Return com_ActivitiesDal.UpdateActivityPriority(ActivityID, PriorityID)
        End Function
        Public Shared Sub SendMail(ByVal ToName As String, ByVal ToEmail As String, ByVal MailSubject As String, ByVal Message As String, ByVal TicketNo As String, ByVal Subject As String, ByVal StoreName As String)
            Dim mail As Portal.BLL.Email
            mail = New Portal.BLL.Email()
            Dim strBody As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/EmailHelpDeskActivity.htm"))
            With mail
                .LeadID = 0
                .MailTo = ToEmail
                .MailFrom = CStr(HttpContext.Current.Session("Email"))
                .DisplayName = CStr(HttpContext.Current.Session("AdminName"))
                .MailBCC = ""
                .MailCC = ""
                .Subject = MailSubject
                .TaskType = 3
                .Detail = strBody.Replace("@OwnerName", ToName). _
                                  Replace("@Message", Message). _
                                  Replace("@TicketNo", TicketNo). _
                                  Replace("@Subject", Subject). _
                                  Replace("@Store", StoreName)
                .CompletedDate = System.DateTime.Now
                .Send_mail()
            End With
        End Sub
        Public Shared Sub SendActivityMail(ByVal ToID As String, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ActEmailType As Integer, ByVal TicketNo As String, ByVal Subject As String, ByVal StoreName As String)

            If ActEmailType = ActivityEmailType.WaitingFor Then
                If ToID.Substring(0, 1) = "F" Then
                    Dim colFranchises As New List(Of Portal.BLL.Franchises)()
                    colFranchises = Portal.BLL.Franchises.FranchiseGetByID(ClientID, ToID.Substring(1))
                    If colFranchises.Count > 0 Then
                        If (colFranchises.Item(0).CorporateEmail.Trim <> "") Then
                            'colFranchises.Item(0).OwnerName
                            SendMail(StoreName, colFranchises.Item(0).CorporateEmail, _
                            "My Netsolace Ticket", "The following ticket has been updated. To view the ticket please logon to Socket ncompass on MyNetsolace section.", TicketNo, Subject, StoreName)
                        End If
                    End If
                ElseIf ToID.Substring(0, 1) = "A" Then
                    Dim colUsers As New List(Of Portal.BLL.Users)()
                    colUsers = Portal.BLL.Users.GetUsersByID(ToID.Substring(1))
                    If (colUsers.Count > 0) Then
                        If (colUsers.Item(0).Email.Trim <> "") Then
                            SendMail(colUsers.Item(0).Firstname & " " & colUsers.Item(0).Lastname, colUsers.Item(0).Email, _
                            "Netsolace HelpDesk Ticket", "The following ticket is waiting for You. To view the ticket please logon to Netsolace Portal on HelpDesk section.", TicketNo, Subject, StoreName)
                        End If
                    End If
                ElseIf ToID.Substring(0, 1) = "C" Then
                    Dim colClientContacts As New List(Of Portal.BLL.Client.Client_Contacts)()
                    colClientContacts = Portal.BLL.Client.Client_Contacts.Client_ContactsGetByID(ToID.Substring(1))
                    If (colClientContacts.Count > 0) Then
                        If (colClientContacts.Item(0).Email1.Trim <> "") Then
                            SendMail(colClientContacts.Item(0).FirstName & " " & colClientContacts.Item(0).LastName, colClientContacts.Item(0).Email1.Trim, _
                                "My Netsolace Ticket", "The following ticket has been updated. To view the ticket please logon to Socket ncompass on MyNetsolace section.", TicketNo, Subject, StoreName)

                        End If
                    End If
                End If
            ElseIf ActEmailType = ActivityEmailType.PublicNotes Then
                Dim colFranchises As New List(Of Portal.BLL.Franchises)()
                colFranchises = Portal.BLL.Franchises.FranchiseGetByID(ClientID, FranchiseID)
                If colFranchises.Count > 0 Then
                    If (colFranchises.Item(0).CorporateEmail.Trim <> "") Then
                        'colFranchises.Item(0).OwnerName
                        SendMail(StoreName, colFranchises.Item(0).CorporateEmail, _
                        "My Netsolace Ticket", "The following ticket has been updated. To view the ticket please logon to Socket ncompass on MyNetsolace section.", TicketNo, Subject, StoreName)
                    End If
                End If
            End If
        End Sub
'        Public Shared Function UpdateActivityRate(ByVal ActivityID As Integer, ByVal RateID As Integer, ByVal RateComments As String) As Integer
'            Dim com_ActivitiesDal As Portal.DAL.Activities = New Portal.DAL.Activities()
'            Return com_ActivitiesDal.UpdateActivityRate(ActivityID, RateID, RateComments)
'        End Function
        Public Shared Sub SendActivityMail(ByVal ToID As String, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal ActEmailType As Integer, ByVal TicketNo As String, ByVal Subject As String, ByVal storename As String, ByVal TicketType As String)

            If ActEmailType = ActivityEmailType.WaitingFor Then
                If ToID.Substring(0, 1) = "F" Then
                    Dim colFranchises As New List(Of Portal.BLL.Franchises)()
                    colFranchises = Portal.BLL.Franchises.FranchiseGetByID(ClientID, ToID.Substring(1))
                    If colFranchises.Count > 0 Then
                        If (colFranchises.Item(0).CorporateEmail.Trim <> "") Then
                            'colFranchises.Item(0).OwnerName
                            SendMail(storename, colFranchises.Item(0).CorporateEmail, ActivityMailTo.Owner, TicketNo, Subject, TicketType)
                        End If
                    End If
                ElseIf ToID.Substring(0, 1) = "A" Then
                    Dim colUsers As New List(Of Portal.BLL.Users)()
                    colUsers = Portal.BLL.Users.GetUsersByID(ToID.Substring(1))
                    If (colUsers.Count > 0) Then
                        If (colUsers.Item(0).Email.Trim <> "") Then
                            SendMail(colUsers.Item(0).Firstname & " " & colUsers.Item(0).Lastname, colUsers.Item(0).Email, ActivityMailTo.Netsoalce, TicketNo, Subject, TicketType)
                        End If
                    End If
                ElseIf ToID.Substring(0, 1) = "C" Then
                    Dim colClientContacts As New List(Of Portal.BLL.Client.Client_Contacts)()
                    colClientContacts = Portal.BLL.Client.Client_Contacts.Client_ContactsGetByID(ToID.Substring(1))
                    If (colClientContacts.Count > 0) Then
                        If (colClientContacts.Item(0).Email1.Trim <> "") Then
                            SendMail(colClientContacts.Item(0).FirstName & " " & colClientContacts.Item(0).LastName, colClientContacts.Item(0).Email1.Trim, ActivityMailTo.Franchisor, TicketNo, Subject, TicketType)
                        End If
                    End If
                End If
            ElseIf ActEmailType = ActivityEmailType.PublicNotes Then
                Dim colFranchises As New List(Of Portal.BLL.Franchises)()
                colFranchises = Portal.BLL.Franchises.FranchiseGetByID(ClientID, FranchiseID)
                If colFranchises.Count > 0 Then
                    If (colFranchises.Item(0).CorporateEmail.Trim <> "") Then
                        'colFranchises.Item(0).OwnerName
                        SendMail(storename, colFranchises.Item(0).CorporateEmail, ActivityMailTo.Owner, TicketNo, Subject, TicketType)
                    End If
                End If
            End If
        End Sub

        Public Shared Sub SendMail(ByVal ToName As String, ByVal ToEmail As String, ByVal mailType As ActivityMailTo, ByVal TicketNo As String, ByVal Subject As String, ByVal TicketType As String)
            Dim mail As Portal.BLL.Email
            mail = New Portal.BLL.Email()
			Dim tmpSubject As String = String.Empty
            If (TicketType.Contains("updated")) Then
                tmpSubject = "Updated Support Ticket " & TicketNo
            ElseIf TicketType.Contains("created") Then
                tmpSubject = "Created Support Ticket " & TicketNo
            End If
            mail.LeadID = 0
            mail.MailTo = ToEmail
            mail.MailFrom = CStr(HttpContext.Current.Session("Email"))
            mail.DisplayName = CStr(HttpContext.Current.Session("AdminName"))
            mail.MailBCC = ""
            mail.MailCC = ""
             mail.Subject = tmpSubject & ": " & Subject
            mail.TaskType = 3
            mail.CompletedDate = System.DateTime.Now

            Dim strBody As String = String.Empty
            Select Case mailType
                Case ActivityMailTo.Owner
                    strBody = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/EmailOwnerTicket.htm"))
                    mail.Detail = strBody.Replace("@OwnerName", ToName). _
                        Replace("@CreatedORUpdatedORWaiting", TicketType). _
                        Replace("@TicketNo", TicketNo). _
                        Replace("@TicketName", Subject)
                    Exit Select
                Case ActivityMailTo.Franchisor
                    strBody = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/EmailFranchisorTicket.htm"))
                    mail.Detail = strBody.Replace("@OwnerName", ToName). _
                        Replace("@CreatedORUpdatedORWaiting", TicketType). _
                        Replace("@TicketNo", TicketNo). _
                        Replace("@TicketName", Subject)
                    Exit Select
                Case ActivityMailTo.Netsoalce
                    strBody = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/EmailNetsoalceTicket.htm"))
                    mail.Detail = strBody.Replace("@OwnerName", ToName). _
                        Replace("@CreatedORUpdatedORWaiting", TicketType). _
                        Replace("@TicketNo", TicketNo). _
                        Replace("@TicketName", Subject)
                    Exit Select
            End Select
            mail.Send_mail()
        End Sub

#End Region
        Public Enum ActivityMailTo
            Owner = 1
            Netsoalce = 2
            Franchisor = 3
        End Enum
    End Class

End Namespace