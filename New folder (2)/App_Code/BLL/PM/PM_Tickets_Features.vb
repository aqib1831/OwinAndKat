
Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Namespace Portal.BLL.PM
    Public Class PM_Ticket_Features
#Region " Private Members "
        Private _id As Integer
        Private _name As String
        Private _username As String
        Private _releaseid As Integer
        Private _dateentered As DateTime
        Private _description As String
        Private _typeid As Integer
        Private _userid As Integer
        Private _clientcontactid As Integer
        Private _read As Boolean
        Private _status As String
        Private _deleted As Boolean
        Private _history As Boolean
        Private _duedate As Date
        'Private _sowSignedDate? As Date
        Private _sowSignedDate As Nullable(Of Date) = Nothing
        Private _duedateshowtoclient As Boolean
        Private _priority As String
        Private _catagoryid As Integer
        Private _subCatagoryid As Integer
        Private _subCatagoryName As String = String.Empty
        Private _waitingForUserID As Integer
        Private _clientid As Integer
        Private _no As Integer
        Private _catagoryname As String
        Private _typename As String
        Private _clientname As String
        Private _datecompleted As Date
        Private _releasename As String
        Private _clientcontactname As String
        Private _ShowDueDateFlag As Boolean
        Private _ClientStatusId As Enumeration.ClientStatus
        Private _RequiredDate As DateTime
        Private _AreaDeveloperID As Integer
        Private _CorporateName As String
        Private _ConfirmedSolvedDate As DateTime
        Private _type As Integer
        Private _isFeedbackRequired As Boolean = False
        Private _ticketOwner As Integer
        Private _ticketOwnerName As String
        Private _ProjectManager As String
        Private _ProductOwner As String
        Private _DesignLead As String
        Private _DevelopmentLead As String
        Private _QALead As String
        Private _DocumentName As String
        Private _Posted As String
        Private _BRDDocumentName As String
        Private _BRDPosted As String
        Private _CRBApprovalDate As Nullable(Of Date) = Nothing
        Private _SOWApprovalDate As String
        Private _TotalEstimates As String
        Private _Title As String
        Private _RoleId As String
        Private _AttachmentID As Integer
        Private _dtProjectResources As DataTable
        Private _Resources As String
        Private _Estimates As String
        Private _Notes As String
        Private _ResourcesDeleted As String
        Private _ListResources As List(Of KeyValuePair(Of String, String))
        Private _AttachmentType As Integer
        Private _Flag As Boolean
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


        Public Property UserName() As String
            Get
                Return _username
            End Get
            Set(ByVal value As String)
                _username = value
            End Set
        End Property

        Public Property ReleaseID() As Integer
            Get
                Return _releaseid
            End Get
            Set(ByVal value As Integer)
                _releaseid = value
            End Set
        End Property

        Public Property DateEntered() As DateTime
            Get
                Return _dateentered
            End Get
            Set(ByVal value As DateTime)
                _dateentered = value
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

        Public Property TypeID() As Integer
            Get
                Return _typeid
            End Get
            Set(ByVal value As Integer)
                _typeid = value
            End Set
        End Property
        Public Property TypeName() As String
            Get
                Return _typename
            End Get
            Set(ByVal value As String)
                _typename = value
            End Set
        End Property

        Public Property UserID() As Integer
            Get
                Return _userid
            End Get
            Set(ByVal value As Integer)
                _userid = value
            End Set
        End Property

        Public Property ClientContactID() As Integer
            Get
                Return _clientcontactid
            End Get
            Set(ByVal value As Integer)
                _clientcontactid = value
            End Set
        End Property
        Public Property Read() As Boolean
            Get
                Return _read
            End Get
            Set(ByVal value As Boolean)
                _read = value
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

        Public Property Deleted() As Boolean
            Get
                Return _deleted
            End Get
            Set(ByVal value As Boolean)
                _deleted = value
            End Set
        End Property

        Public Property History() As Boolean
            Get
                Return _history
            End Get
            Set(ByVal value As Boolean)
                _history = value
            End Set
        End Property

        Public Property DueDate() As Date
            Get
                Return _duedate
            End Get
            Set(ByVal value As Date)
                _duedate = value
            End Set
        End Property

        Public Property SowSignedDate() As Nullable(Of Date)
            Get
                Return _sowSignedDate
            End Get
            Set(ByVal value As Nullable(Of Date))
                _sowSignedDate = value
            End Set
        End Property



        Public Property RequiredDate() As DateTime
            Get
                Return _RequiredDate
            End Get
            Set(ByVal value As DateTime)
                _RequiredDate = value
            End Set
        End Property

        Public Property DueDateShowToClient() As Boolean
            Get
                Return _duedateshowtoclient
            End Get
            Set(ByVal value As Boolean)
                _duedateshowtoclient = value
            End Set
        End Property


        Public Property Priority() As String
            Get
                Return _priority
            End Get
            Set(ByVal value As String)
                _priority = value
            End Set
        End Property

        Public Property CatagoryID() As Integer
            Get
                Return _catagoryid
            End Get
            Set(ByVal value As Integer)
                _catagoryid = value
            End Set
        End Property
        Public Property SubCatagoryID() As Integer
            Get
                Return _subCatagoryid
            End Get
            Set(ByVal value As Integer)
                _subCatagoryid = value
            End Set
        End Property

        Public Property SubCatagoryName() As String
            Get
                Return _subCatagoryName
            End Get
            Set(ByVal value As String)
                _subCatagoryName = value
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
        Public Property RefNo() As Integer
            Get
                Return _no
            End Get
            Set(ByVal value As Integer)
                _no = value
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
        Public Property CatagoryName() As String
            Get
                Return _catagoryname
            End Get
            Set(ByVal value As String)
                _catagoryname = value
            End Set
        End Property
        Public Property WaitingForUserID() As Integer
            Get
                Return _waitingForUserID
            End Get
            Set(ByVal value As Integer)
                _waitingForUserID = value
            End Set
        End Property

        Public Property DateCompleted() As DateTime
            Get
                Return _datecompleted
            End Get
            Set(ByVal value As DateTime)
                _datecompleted = value
            End Set
        End Property

        Public Property ReleaseName() As String
            Get
                Return _releasename
            End Get
            Set(ByVal value As String)
                _releasename = value
            End Set
        End Property

        Public Property ClientContactName() As String
            Get
                Return _clientcontactname
            End Get
            Set(ByVal value As String)
                _clientcontactname = value
            End Set
        End Property

        Public Property ShowDueDateFlag() As Boolean
            Get
                Return _ShowDueDateFlag
            End Get
            Set(ByVal value As Boolean)
                _ShowDueDateFlag = value
            End Set
        End Property

        Public Property ClientStatusId() As Enumeration.ClientStatus
            Get
                Return _ClientStatusId
            End Get
            Set(ByVal value As Enumeration.ClientStatus)
                _ClientStatusId = value
            End Set
        End Property

        Public Property AreaDeveloperId() As Integer
            Get
                Return _AreaDeveloperID
            End Get
            Set(ByVal value As Integer)
                _AreaDeveloperID = value
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

        Public Property ConfirmedSolvedDate() As DateTime
            Get
                Return _ConfirmedSolvedDate
            End Get
            Set(ByVal value As DateTime)
                _ConfirmedSolvedDate = value
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


        Public Property IsFeedbackRequired() As Boolean
            Get
                Return _isFeedbackRequired
            End Get
            Set(ByVal value As Boolean)
                _isFeedbackRequired = value
            End Set
        End Property

        Public Property TicketOwner() As Integer
            Get
                Return _ticketOwner
            End Get
            Set(ByVal value As Integer)
                _ticketOwner = value
            End Set
        End Property

        Public Property TicketOwnerName() As String
            Get
                Return _ticketOwnerName
            End Get
            Set(ByVal value As String)
                _ticketOwnerName = value
            End Set
        End Property

        Public Property ProjectManager As String
            Get
                Return _ProjectManager
            End Get
            Set(value As String)
                _ProjectManager = value
            End Set
        End Property

        Public Property DesignLead As String
            Get
                Return _DesignLead
            End Get
            Set(value As String)
                _DesignLead = value
            End Set
        End Property

        Public Property DevelopmentLead As String
            Get
                Return _DevelopmentLead
            End Get
            Set(value As String)
                _DevelopmentLead = value
            End Set
        End Property

        Public Property QALead As String
            Get
                Return _QALead
            End Get
            Set(value As String)
                _QALead = value
            End Set
        End Property

        Public Property ProductOwner As String
            Get
                Return _ProductOwner
            End Get
            Set(value As String)
                _ProductOwner = value
            End Set
        End Property

        Public Property DocumentName As String
            Get
                Return _DocumentName
            End Get
            Set(value As String)
                _DocumentName = value
            End Set
        End Property

        Public Property Posted As String
            Get
                Return _Posted
            End Get
            Set(value As String)
                _Posted = value
            End Set
        End Property

        Public Property BRDDocumentName As String
            Get
                Return _BRDDocumentName
            End Get
            Set(value As String)
                _BRDDocumentName = value
            End Set
        End Property

        Public Property BRDPosted As String
            Get
                Return _BRDPosted
            End Get
            Set(value As String)
                _BRDPosted = value
            End Set
        End Property

        Public Property SOWApprovalDate As String
            Get
                Return _SOWApprovalDate
            End Get
            Set(value As String)
                _SOWApprovalDate = value
            End Set
        End Property

        Public Property TotalEstimates As String
            Get
                Return _TotalEstimates
            End Get
            Set(value As String)
                _TotalEstimates = value
            End Set
        End Property

        Public Property Title As String
            Get
                Return _Title
            End Get
            Set(value As String)
                _Title = value
            End Set
        End Property

        Public Property RoleId As String
            Get
                Return _RoleId
            End Get
            Set(value As String)
                _RoleId = value
            End Set
        End Property

        Public Property AttachmentID As Integer
            Get
                Return _AttachmentID
            End Get
            Set(value As Integer)
                _AttachmentID = value
            End Set
        End Property

        Public Property DtProjectResources As DataTable
            Get
                Return _dtProjectResources
            End Get
            Set(value As DataTable)
                _dtProjectResources = value
            End Set
        End Property

        Public Property Resources As String
            Get
                Return _Resources
            End Get
            Set(value As String)
                _Resources = value
            End Set
        End Property

        Public Property Estimates As String
            Get
                Return _Estimates
            End Get
            Set(value As String)
                _Estimates = value
            End Set
        End Property

        Public Property CRBApprovalDate As Nullable(Of Date)
            Get
                Return _CRBApprovalDate
            End Get
            Set(ByVal value As Nullable(Of Date))
                _CRBApprovalDate = value
            End Set
        End Property

        Public Property Notes As String
            Get
                Return _Notes
            End Get
            Set(value As String)
                _Notes = value
            End Set
        End Property

        Public Property ResourcesDeleted As String
            Get
                Return _ResourcesDeleted
            End Get
            Set(value As String)
                _ResourcesDeleted = value
            End Set
        End Property

        Public Property ListResources As List(Of KeyValuePair(Of String, String))
            Get
                Return _ListResources
            End Get
            Set(value As List(Of KeyValuePair(Of String, String)))
                _ListResources = value
            End Set
        End Property

        Public Property AttachmentType As Integer
            Get
                Return _AttachmentType
            End Get
            Set(value As Integer)
                _AttachmentType = value
            End Set
        End Property

        Public Property Flag As Boolean
            Get
                Return _Flag
            End Get
            Set(value As Boolean)
                _Flag = value
            End Set
        End Property
#End Region

#Region " Constructor "

        Public Sub New()

        End Sub
        Public Sub New(ByVal ID As Integer, ByVal Name As String, ByVal ReleaseID As Integer, ByVal DateEntered As DateTime, ByVal Description As String, _
          ByVal TypeID As Integer, ByVal UserID As Integer, ByVal Read As Boolean, ByVal Status As String, ByVal Deleted As Boolean, ByVal History As Boolean, _
          ByVal DueDate As Date, ByVal Priority As String, ByVal CatagoryID As Integer, ByVal WaitingForUserID As Integer, ByVal ClientID As Integer, _
          ByVal RefNo As Integer, Optional ByVal ShowDueDateFlag As Boolean = False, Optional AreadeveloperID As Integer = 0)
            Me.ID = ID
            Me.Name = Name
            Me.ReleaseID = ReleaseID
            Me.DateEntered = DateEntered
            Me.Description = Description
            Me.TypeID = TypeID
            Me.UserID = UserID
            Me.Read = Read
            Me.Status = Status
            Me.Deleted = Deleted
            Me.History = History
            Me.DueDate = DueDate
            Me.Priority = Priority
            Me.CatagoryID = CatagoryID
            Me.WaitingForUserID = WaitingForUserID
            Me.ClientID = ClientID
            Me.RefNo = RefNo
            Me.ShowDueDateFlag = ShowDueDateFlag
            Me.AreaDeveloperId = AreadeveloperID
        End Sub

        Public Sub New(ByVal ID As Integer, ByVal Name As String, ByVal ReleaseID As Integer, ByVal DateEntered As DateTime, ByVal Description As String, _
          ByVal TypeID As Integer, ByVal UserID As Integer, ByVal Read As Boolean, ByVal Status As String, ByVal Deleted As Boolean, ByVal History As Boolean, _
          ByVal DueDate As Date, ByVal Priority As String, ByVal CatagoryID As Integer, ByVal WaitingForUserID As Integer, ByVal ClientID As Integer, _
          ByVal RefNo As Integer, ByVal TypeName As String, ByVal CatagoryName As String, ByVal AssignedBy As String, Optional ByVal ShowDueDateFlag As Boolean = False)

            Me.ID = ID
            Me.Name = Name
            Me.ReleaseID = ReleaseID
            Me.DateEntered = DateEntered
            Me.Description = Description
            Me.TypeID = TypeID
            Me.UserID = UserID
            Me.Read = Read
            Me.Status = Status
            Me.Deleted = Deleted
            Me.History = History
            Me.DueDate = DueDate.ToShortDateString()
            Me.Priority = Priority
            Me.CatagoryID = CatagoryID
            Me.WaitingForUserID = WaitingForUserID
            Me.ClientID = ClientID
            Me.RefNo = RefNo
            Me.TypeName = TypeName
            Me.CatagoryName = CatagoryName
            Me.UserName = AssignedBy
            Me.ShowDueDateFlag = ShowDueDateFlag
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal Name As String, _
          ByVal ReleaseID As Integer, _
          ByVal DateEntered As DateTime, _
          ByVal Description As String, _
          ByVal TypeID As Integer, _
          ByVal UserID As Integer, _
          ByVal Read As Boolean, _
          ByVal Status As String, _
          ByVal Deleted As Boolean, _
          ByVal History As Boolean, _
          ByVal DueDate As Date, _
          ByVal Priority As String, _
          ByVal CatagoryID As Integer, _
          ByVal WaitingForUserID As Integer, _
          ByVal ClientID As Integer, _
          ByVal RefNo As Integer, _
          ByVal TypeName As String, _
          ByVal CatagoryName As String, _
          ByVal AssignedBy As String, _
          ByVal ClientName As String, _
          Optional ByVal ShowDueDateFlag As Boolean = False)

            Me.ID = ID
            Me.Name = Name
            Me.ReleaseID = ReleaseID
            Me.DateEntered = DateEntered
            Me.Description = Description
            Me.TypeID = TypeID
            Me.UserID = UserID
            Me.Read = Read
            Me.Status = Status
            Me.Deleted = Deleted
            Me.History = History
            Me.DueDate = DueDate.ToShortDateString()
            Me.Priority = Priority
            Me.CatagoryID = CatagoryID
            Me.WaitingForUserID = WaitingForUserID
            Me.ClientID = ClientID
            Me.RefNo = RefNo
            Me.TypeName = TypeName
            Me.CatagoryName = CatagoryName
            Me.UserName = AssignedBy
            Me.ClientName = ClientName
            Me.ShowDueDateFlag = ShowDueDateFlag
        End Sub

        Public Sub New( _
         ByVal ID As Integer, _
         ByVal Name As String, _
         ByVal ReleaseID As Integer, _
         ByVal DateEntered As DateTime, _
         ByVal Description As String, _
         ByVal TypeID As Integer, _
         ByVal UserID As Integer, _
         ByVal Read As Boolean, _
         ByVal Status As String, _
         ByVal History As Boolean, _
         ByVal DueDate As Date, _
         ByVal DueDateShowToClient As Boolean, _
         ByVal Priority As String, _
         ByVal CatagoryID As Integer, _
         ByVal WaitingForUserID As Integer, _
         ByVal ClientID As Integer, _
         ByVal RefNo As Integer, _
         ByVal UserName As String, _
         ByVal TypeName As String, _
         ByVal ClientName As String, _
         ByVal CatagoryName As String, _
         ByVal ClientContactName As String, _
         ByVal ClientContactID As Integer, _
         Optional ByVal ShowDueDateFlag As Boolean = False)

            Me.ID = ID
            Me.Name = Name
            Me.ReleaseID = ReleaseID
            Me.DateEntered = DateEntered
            Me.Description = Description
            Me.TypeID = TypeID
            Me.UserID = UserID
            Me.Read = Read
            Me.Status = Status
            Me.History = History
            Me.DueDate = DueDate
            Me.DueDateShowToClient = DueDateShowToClient
            Me.Priority = Priority
            Me.CatagoryID = CatagoryID
            Me.WaitingForUserID = WaitingForUserID
            Me.ClientID = ClientID
            Me.RefNo = RefNo
            Me.UserName = UserName
            Me.TypeName = TypeName
            Me.ClientName = ClientName
            Me.CatagoryName = CatagoryName
            Me.ClientContactName = ClientContactName
            Me.ClientContactID = ClientContactID
            Me.ShowDueDateFlag = ShowDueDateFlag
        End Sub
#End Region

#Region " Public Method "
        Public Shared Function PM_TicketGetAll(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal TypeID As String, ByVal FilterID As Integer, ByVal WaitingForUserID As Integer, ByVal ReleaseId As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal Search As String) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketGetAll(ClientID, CategoryID, StatusID, ReleaseId, TypeID, FilterID, WaitingForUserID, SortExpression, MaximumRows, StartRowIndex, Search)
        End Function
        Public Shared Function PM_TicketGetAllCount(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal ReleaseId As Integer, ByVal StatusID As String, ByVal TypeID As String, ByVal FilterID As Integer, ByVal WaitingForUserID As Integer, ByVal Search As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketGetAllCount(ClientID, CategoryID, StatusID, ReleaseId, TypeID, FilterID, WaitingForUserID, Search)
        End Function
        Public Shared Function PM_FeaturesGetAll(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal StatusID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_FeaturesGetAll(ReleaseID, ClientID, CategoryID, StatusID, TypeID, FilterID, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Shared Function PM_FeaturesGetAllCount(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal StatusID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_FeaturesGetAllCount(ReleaseID, ClientID, CategoryID, StatusID, TypeID, FilterID, sortExpression, txtsearch)
        End Function
        Public Shared Function PM_FeaturesGetAllForMyNetsolace(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_FeaturesGetAllForMyNetsolace(ReleaseID, ClientID, CategoryID, TypeID, FilterID, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Shared Function PM_FeaturesGetAllCountForMyNetsolace(ByVal ReleaseID As Integer, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_FeaturesGetAllCountForMyNetsolace(ReleaseID, ClientID, CategoryID, TypeID, FilterID, sortExpression, txtsearch)
        End Function
        Public Shared Function PM_TicketGetAllHistory(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketGetAllHistory(ClientID, CategoryID, TypeID, FilterID, SortExpression, MaximumRows, StartRowIndex, txtsearch)
        End Function
        Public Shared Function PM_TicketGetAllHistoryCount(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal txtsearch As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketGetAllHistoryCount(ClientID, CategoryID, TypeID, FilterID, txtsearch)
        End Function
        Public Shared Function PM_TicketGetAllHistoryForMyNetsolace(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketGetAllHistoryForMyNetsolace(ClientID, CategoryID, TypeID, FilterID, sortExpression, maximumRows, startRowIndex, txtsearch, AreaDeveloperID)
        End Function
        Public Shared Function PM_TicketGetAllHistoryCountForMyNetsolace(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal sortExpression As String, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketGetAllHistoryCountForMyNetsolace(ClientID, CategoryID, TypeID, FilterID, sortExpression, txtsearch, AreaDeveloperID)
        End Function
        Public Shared Function PM_Ticket_FeaturesGetByID(ByVal ID As Integer) As List(Of PM_Ticket_Features)
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_Ticket_FeaturesGetByID(ID)
        End Function
        Public Shared Function PM_FeaturesAdd(ByVal ID As Integer, ByVal Name As String, ByVal ReleaseID As Integer, ByVal DateEntered As Date, ByVal Description As String, ByVal TypeID As Integer, ByVal UserID As Integer, ByVal Read As Boolean, ByVal Status As Integer, ByVal Deleted As Boolean, ByVal History As Boolean, ByVal DueDate As Date, ByVal Priority As String, ByVal CategoryID As Integer, ByVal WaitingForUserID As Integer, ByVal ClientID As Integer, ByVal RefNo As Integer) As Integer
            Dim PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features(ID, Name, ReleaseID, DateEntered, Description, TypeID, UserID, Read, Status, Deleted, History, DueDate, Priority, CategoryID, WaitingForUserID, ClientID, RefNo)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.FeaturesAdd(PM_Ticket_FeaturesBll)
        End Function
        Public Shared Function PM_FeaturesUpdate(ByVal ID As Integer, ByVal Name As String, ByVal ReleaseID As Integer, ByVal DateEntered As Date, ByVal Description As String, ByVal TypeID As Integer, ByVal UserID As Integer, ByVal Read As Boolean, ByVal Status As Integer, ByVal Deleted As Boolean, ByVal History As Boolean, ByVal DueDate As Date, ByVal Priority As String, ByVal CategoryID As Integer, ByVal WaitingForUserID As Integer, ByVal ClientID As Integer, ByVal RefNo As Integer) As Integer
            Dim PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features(ID, Name, ReleaseID, DateEntered, Description, TypeID, UserID, Read, Status, Deleted, History, DueDate, Priority, CategoryID, WaitingForUserID, ClientID, RefNo)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.FeaturesUpdate(PM_Ticket_FeaturesBll)
        End Function
        Public Shared Function PM_TicketAdd(ByVal ID As Integer, ByVal Name As String, ByVal ReleaseID As Integer, ByVal DateEntered As Date, ByVal Description As String, ByVal TypeID As Integer, ByVal UserID As Integer, ByVal Read As Boolean, ByVal Status As Integer, ByVal Deleted As Boolean, ByVal History As Boolean, ByVal DueDate As Date, ByVal Priority As String, ByVal CategoryID As Integer, ByVal WaitingForUserID As Integer, ByVal ClientID As Integer, ByVal RefNo As Integer) As Integer
            Dim PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features(ID, Name, ReleaseID, DateEntered, Description, TypeID, UserID, Read, Status, Deleted, History, DueDate, Priority, CategoryID, WaitingForUserID, ClientID, RefNo)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_TicketAdd(PM_Ticket_FeaturesBll)
        End Function
        Public Function PM_TicketAdd() As Integer
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.Add(Me)
        End Function

        Public Shared Function PM_TicketUpdate(ByVal ID As Integer, ByVal Name As String, ByVal ReleaseID As Integer, ByVal DateEntered As Date, ByVal Description As String, ByVal TypeID As Integer, ByVal UserID As Integer, ByVal Read As Boolean, ByVal Status As Integer, ByVal Deleted As Boolean, ByVal History As Boolean, ByVal DueDate As Date, ByVal Priority As String, ByVal CategoryID As Integer, ByVal WaitingForUserID As Integer, ByVal ClientID As Integer, ByVal RefNo As Integer) As Integer
            Dim PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features(ID, Name, ReleaseID, DateEntered, Description, TypeID, UserID, Read, Status, Deleted, History, DueDate, Priority, CategoryID, WaitingForUserID, ClientID, RefNo)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_TicketUpdate(PM_Ticket_FeaturesBll)
        End Function

        Public Shared Function PM_MYTicketGetAll(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal FilterID As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String, ByVal StartDate As DateTime, ByVal EndDate As DateTime, Optional ByVal TypeID As String = "0") As DataTable
            Dim UserlLogID As Integer = CType(HttpContext.Current.Session("AdminID"), Integer)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_MYTicketGetAll(ClientID, CategoryID, StatusID, FilterID, UserlLogID, SortExpression, MaximumRows, StartRowIndex, txtsearch, StartDate, EndDate, TypeID)
        End Function
        Public Shared Function PM_MYTicketGetAllCount(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal FilterID As Integer, ByVal txtsearch As String, ByVal StartDate As DateTime, ByVal EndDate As DateTime, Optional ByVal TypeID As String = "0") As Integer
            Dim UserlLogID As Integer = CType(HttpContext.Current.Session("AdminID"), Integer)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_MYTicketGetAllCount(ClientID, CategoryID, StatusID, FilterID, UserlLogID, txtsearch, StartDate, EndDate, TypeID)
        End Function
        Public Shared Function PM_MYTicketGetAll_Excel(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal FilterID As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String, ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal UserLogID As Integer, Optional ByVal TypeID As String = "0") As DataTable
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_MYTicketGetAll(ClientID, CategoryID, StatusID, FilterID, UserLogID, SortExpression, MaximumRows, StartRowIndex, txtsearch, StartDate, EndDate, TypeID)
        End Function
        ' mtahir 
        Public Shared Function PMRecent_TicketGetAll_Excel(ByVal ClientID As Integer, ByVal CategoryID As String, ByVal StatusID As String, ByVal TypeID As String, ByVal FilterID As Integer, ByVal WaitingForUserID As Integer, ByVal ReleaseId As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal Search As String, ByVal UserLogID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PMRecent_MYTicketGetAll_Excel(ClientID, CategoryID, StatusID, ReleaseId, TypeID, FilterID, WaitingForUserID, SortExpression, MaximumRows, StartRowIndex, Search, UserLogID)
        End Function

        Public Shared Function PM_MYTicketGetAllForMyNetsolaceCorporate(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal FilterID As Integer, ByVal txtsearch As String, ByVal ClientStatusId As Integer, ByVal AreaDeveloperID As Integer, ByVal sortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer) As DataTable
            Dim ClientContactID As Integer = CType(HttpContext.Current.Session("MyNetsolace_ClientContactID"), Integer)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.MyTicketGetAllForMyNetsolaceCorporate(ClientID, CategoryID, FilterID, ClientContactID, sortExpression, MaximumRows, StartRowIndex, txtsearch, ClientStatusId, AreaDeveloperID)
        End Function
        Public Shared Function PM_MYTicketGetAllCountForMyNetsolaceCorporate(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal FilterID As Integer, ByVal txtsearch As String, ByVal ClientStatusId As Integer, ByVal AreaDeveloperID As Integer) As Integer
            Dim ClientContactID As Integer = CType(HttpContext.Current.Session("MyNetsolace_ClientContactID"), Integer)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.MyTicketGetAllCountForMyNetsolaceCorporate(ClientID, CategoryID, FilterID, ClientContactID, txtsearch, ClientStatusId, AreaDeveloperID)
        End Function

        Public Shared Function PM_TicketSearchForMyNetsolaceCorporate(ByVal txtsearch As String) As DataTable
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_TicketSearchForMyNetsolaceCorporate(txtsearch)
        End Function
        Public Shared Function PM_TicketSearch(ByVal txtsearch As String) As List(Of PM_Ticket_Features)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_TicketSearch(txtsearch)
        End Function

        Public Shared Function UpdateDueDate(ByVal ID As Integer, ByVal DueDate As DateTime) As Integer
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.UpdateDueDate(ID, DueDate)
        End Function
        Public Shared Function UpdateDueDateShowToClient(ByVal ID As Integer, ByVal DueDateShowToClient As Boolean) As Integer
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.UpdateDueDateShowToClient(ID, DueDateShowToClient)
        End Function
        Public Shared Function UpdateAssingTo(ByVal ID As Integer, ByVal AssingTo As Integer) As Integer
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.UpdateAssingTo(ID, AssingTo)
        End Function
        Public Shared Function UpdateReleaseID(ByVal ID As Integer, ByVal ReleaseID As Integer) As Integer
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.UpdateReleaseID(ID, ReleaseID)
        End Function

        Public Shared Function UpdateStatus(ByVal ID As Integer, ByVal StatusID As Integer, ByVal WaitingForID As Integer) As Integer
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.UpdateStatus(ID, StatusID, WaitingForID)
        End Function
        Public Shared Function PM_CategoryUserGetByID(ByVal CategoryID As Integer) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_CategoryUserGetByID(CategoryID)
        End Function
        Public Shared Function GetByID(ByVal intID As Integer) As SqlDataReader

            Dim objAccess As DBAccess = New DBAccess()
            objAccess.AddParameter("@TicketID", intID)

            Return objAccess.ExecuteReader("PM_GetTicket_Feature_DetailByID")
        End Function
        Public Function SaveAttachments(ByVal DirectoryName As String, ByVal Attachment As FileUpload, ByVal TicketID As Integer) As Integer
            Dim strAlbumPath As String = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings("PMAttachmentPath") & DirectoryName)
            If strAlbumPath.Contains("\MyNetsolace\") Then
                strAlbumPath = strAlbumPath.Replace("\MyNetsolace\", "\")
            End If
            If My.Computer.FileSystem.DirectoryExists(strAlbumPath) = False Then
                My.Computer.FileSystem.CreateDirectory(strAlbumPath)
            End If
            If Attachment.FileName.Trim() <> String.Empty Then
                Attachment.SaveAs(strAlbumPath & "\" & Functions.MakeFileNameValid(Attachment.FileName))
                Return Me.AddAttachments(Functions.MakeFileNameValid(Attachment.FileName), DirectoryName & "\" & Functions.MakeFileNameValid(Attachment.FileName), TicketID)
            End If
        End Function
        Public Function SaveAttachmentsTelerik(ByVal DirectoryName As String, ByVal Attachment As Telerik.WebControls.UploadedFile, ByVal TicketID As Integer) As Integer
            Dim strAlbumPath As String = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings("PMAttachmentPath") & DirectoryName)
            If strAlbumPath.Contains("\MyNetsolace\") Then
                strAlbumPath = strAlbumPath.Replace("\MyNetsolace\", "\")
            End If
            If My.Computer.FileSystem.DirectoryExists(strAlbumPath) = False Then
                My.Computer.FileSystem.CreateDirectory(strAlbumPath)
            End If
            If Attachment.GetName.Trim() <> String.Empty Then
                Attachment.SaveAs(strAlbumPath & "\" & Functions.MakeFileNameValid(Attachment.GetName))
                Return Me.AddAttachments(Functions.MakeFileNameValid(Attachment.GetName), DirectoryName & "\" & Functions.MakeFileNameValid(Attachment.GetName), TicketID)
            End If
        End Function

        Public Function SaveAttachmentsTelerik(ByVal DirectoryName As String, ByVal Attachment As Telerik.WebControls.UploadedFile, ByVal TicketID As Integer, ByVal Type As Integer) As Integer
            Dim strAlbumPath As String = HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings("PMAttachmentPath") & DirectoryName)
            If strAlbumPath.Contains("\MyNetsolace\") Then
                strAlbumPath = strAlbumPath.Replace("\MyNetsolace\", "\")
            End If
            If My.Computer.FileSystem.DirectoryExists(strAlbumPath) = False Then
                My.Computer.FileSystem.CreateDirectory(strAlbumPath)
            End If
            If Attachment.GetName.Trim() <> String.Empty Then
                AttachmentType = Type
                Attachment.SaveAs(strAlbumPath & "\" & Functions.MakeFileNameValid(Attachment.GetName))
                Return Me.AddAttachments(Functions.MakeFileNameValid(Attachment.GetName), DirectoryName & "\" & Functions.MakeFileNameValid(Attachment.GetName), TicketID)
            End If
        End Function

        Public Function AddAttachments(ByVal FileName As String, ByVal FilePath As String, ByVal TicketID As Integer) As Integer

            Dim intReturn As Integer = 0
            Dim objAccess As DBAccess = New DBAccess()
            objAccess.AddParameter("@TicketID", SqlDbType.Int, 4, ParameterDirection.Input, TicketID)
            objAccess.AddParameter("@Filename", SqlDbType.VarChar, 200, ParameterDirection.Input, FileName)
            objAccess.AddParameter("@Filepath", SqlDbType.VarChar, 1000, ParameterDirection.Input, FilePath)
            objAccess.AddParameter("@AttachmentType", SqlDbType.Int, 4, ParameterDirection.Input, AttachmentType)
            objAccess.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, intReturn)
            Try
                objAccess.ExecuteNonQuery("PM_TicketAttachment_Add")
                intReturn = CInt(CType(objAccess.Parameters("@ReturnValue"), System.Data.SqlClient.SqlParameter).Value)
            Catch ex As Exception
                intReturn = 0
            Finally
                objAccess.Dispose()
            End Try
            Return intReturn

        End Function
        Public Shared Sub ChangeRead(ByVal ID As Integer, ByVal Read As Boolean, ByVal UserID As Integer, ByVal ClientContactID As Integer)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            PM_Ticket_FeaturesDal.ChangeRead(ID, Read, UserID, ClientContactID)
        End Sub
        Public Shared Function CheckToComplete(ByVal TicketID As Integer, ByVal UserID As Integer) As Integer
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.CheckToComplete(TicketID, UserID)
        End Function

        Public Shared Sub SendMailToNetsolaceContacts(ByVal ToName As String, ByVal ToEmail As String, ByVal ToCCEmail As String, ByVal MailSubject As String, ByVal CreatedORUpdatedORWaiting As String, ByVal TicketNo As String, ByVal TicketName As String, ByVal Status As String, ByVal DueDate As String, ByVal Priority As String, ByVal Type As String, ByVal Client As String, ByVal Category As String, Optional ByVal Action As String = "")

            Dim mail As Portal.BLL.Email
            mail = New Portal.BLL.Email()
            Dim strBody As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/NetsolaceContactsTicket.htm"))
            With mail
                'If Action = "SOW ready for review/approval" Then
                '    MailSubject = "Action Required - Netsolace Portal Ticket #" + TicketNo
                'ElseIf Action = "Question/ feedback needed" Then
                '    MailSubject = "Action Required - Netsolace Portal Ticket #" + TicketNo
                'ElseIf String.IsNullOrEmpty(Action) Then
                '    MailSubject = "Status Update - Netsolace Portal Ticket #" + TicketNo
                'Else
                '    .Subject = MailSubject
                'End If




                '     <tr>
                '    <td>Action Item:</td>
                '    <td>@Action</td>
                '</tr>
                strBody = strBody.Replace("@OwnerName", ToName).Replace("@CreatedORUpdatedORWaiting", CreatedORUpdatedORWaiting).Replace("@TicketNo", TicketNo).Replace("@OpenTicketNo", Functions.EncryptData(TicketNo)).Replace("@TicketName", TicketName).Replace("@Status", Status).Replace("@DueDate", DueDate).Replace("@Priority", Priority).Replace("@Type", Type).Replace("@Client", Client).Replace("@Category", Category)
                If String.IsNullOrEmpty(Action) Then
                    strBody = strBody.Replace("@Action", "")
                Else
                    strBody = strBody.Replace("@Action", "<tr><td><b> Action Item: </b></td><td>" + "<b>" + Action + "</b>" + "</td></tr>")
                End If
                .LeadID = 0
                .MailTo = ToEmail
                .MailFrom = CStr(HttpContext.Current.Session("Email"))
                .DisplayName = CStr(HttpContext.Current.Session("AdminName"))
                .MailBCC = ""
                .MailCC = ToCCEmail
                .Subject = MailSubject
                .TaskType = 3
                .Detail = strBody
                .CompletedDate = System.DateTime.Now
                .Send_mail()
            End With
        End Sub
        Public Shared Sub SendMailToClientContacts(ByVal ToName As String, ByVal ToEmail As String, ByVal FromEmail As String, ByVal DisplayName As String, ByVal ToCCEmail As String, ByVal MailSubject As String, ByVal CreatedORUpdatedORWaiting As String, ByVal TicketNo As String, ByVal TicketName As String, ByVal Status As String, ByVal DueDate As String, ByVal Priority As String, ByVal Type As String, ByVal Client As String, ByVal Category As String, ByVal IsNetsolaceUser As Boolean, Optional ByVal Link As String = "", Optional ByVal NonVisitedLink As String = "", Optional ByVal IsAreaDeveloperUser As Boolean = False, Optional ByVal Action As String = "")

            'remove from template also
            Dim mail As Portal.BLL.Email
            mail = New Portal.BLL.Email()

            Dim strBodyForUser As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/NetsolaceContactsTicket.htm"))
            Dim strBodyForClientContact As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/ClientContactsTicket.htm"))
            Dim strBodyForEAContact As String = My.Computer.FileSystem.ReadAllText(HttpContext.Current.Server.MapPath("~/templates/EAContactsTicket.htm"))

            Dim strBody As String = ""

            If IsNetsolaceUser Then
                strBody = strBodyForUser ' for AdminId or Portal User or Is Netsolace User
            Else
                If Client.Contains("Edible") Then
                    If Not IsAreaDeveloperUser Then
                        strBody = strBodyForEAContact
                    Else
                        strBody = strBodyForClientContact
                    End If
                Else
                    strBody = strBodyForClientContact ' for CleintContactId or MyNetsolace User
                End If


            End If

            '    If FromEmail.ToLower.Contains("@netsolace.com.pk") OR ToEmail.ToLower.Contains("@netsolace.com.pk") Then
            '    With mail
            '        .LeadID = 0
            '        .MailTo = ToEmail
            '		 .MailFrom = "support@netsolace.com"
            '            .DisplayName = DisplayName
            '            .MailBCC = ""
            '            .MailCC = ToCCEmail
            '            .Subject = MailSubject
            '            .TaskType = 3
            '            .Detail = strBody.Replace("@OwnerName", ToName).Replace("@CreatedORUpdatedORWaiting", CreatedORUpdatedORWaiting).Replace("@TicketNo", TicketNo).Replace("@TicketName", TicketName).Replace("@Status", Status).Replace("@DueDate", DueDate).Replace("@Priority", Priority).Replace("@Type", Type).Replace("@Client", Client).Replace("@Category", Category).Replace("@Link", Link).Replace("@NonVisitedLink", NonVisitedLink)
            '            .CompletedDate = System.DateTime.Now
            '            .Send_mail()
            '        End With
            '
            '   Else

            With mail

                If Action = "SOW ready for review/approval" Then
                    MailSubject = "Action Required - Netsolace Portal Ticket #" + TicketNo
                ElseIf Action = "Question/ feedback needed" Then
                    MailSubject = "Action Required - Netsolace Portal Ticket #" + TicketNo
                ElseIf String.IsNullOrEmpty(Action) Then
                    MailSubject = "Status Update - Netsolace Portal Ticket #" + TicketNo
                Else
                    .Subject = MailSubject
                End If

                strBody = strBody.Replace("@OwnerName", ToName).Replace("@CreatedORUpdatedORWaiting", CreatedORUpdatedORWaiting).Replace("@TicketNo", TicketNo).Replace("@OpenTicketNo", Functions.EncryptData(TicketNo)).Replace("@TicketName", TicketName).Replace("@Status", Status).Replace("@DueDate", DueDate).Replace("@Priority", Priority).Replace("@Type", Type).Replace("@Client", Client).Replace("@Category", Category).Replace("@Link", Link).Replace("@NonVisitedLink", NonVisitedLink)
                If String.IsNullOrEmpty(Action) Then
                    strBody = strBody.Replace("@Action", "")
                Else
                    strBody = strBody.Replace("@Action", "<tr><td><b> Action Item: </b></td><td>" + "<b>" + Action + "</b>" + "</td></tr>")
                End If

                .LeadID = 0
                .MailTo = ToEmail
                .MailFrom = FromEmail
                .DisplayName = DisplayName
                .MailBCC = ""
                .MailCC = ToCCEmail
                .Subject = MailSubject
                .TaskType = 3
                .Detail = strBody



                .CompletedDate = System.DateTime.Now
                .Send_mail()
            End With
            'End If
        End Sub

        Public Shared Function GetPMDashBoardStats(ByVal ClientId As Integer, ByVal CategoryId As Integer, ByVal Type As Integer, ByVal TeamId As Integer, ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal SortBy As String) As DataTable
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.GetPMDashBoardStats(ClientId, CategoryId, Type, TeamId, StartDate, EndDate, SortBy)
        End Function
        Public Shared Function GetPMDashBoardTickets(ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal Type As Integer, ByVal TeamId As Integer, ByVal UserId As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetPMDashBoardTickets(StartDate, EndDate, ClientID, CategoryID, Type, TeamId, UserId, SortExpression, MaximumRows, StartRowIndex, txtsearch)
        End Function
        Public Shared Function GetPMDashBoardTicketsCount(ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal Type As Integer, ByVal TeamId As Integer, ByVal UserId As Integer, ByVal txtsearch As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetPMDashBoardTicketsCount(StartDate, EndDate, ClientID, CategoryID, Type, TeamId, UserId, txtsearch)
        End Function

        Public Shared Function PMTicketUpdate(ByVal ID As Integer, ByVal Name As String, ByVal TypeID As Integer, ByVal UserID As Integer, ByVal SowSignedDate As Nullable(Of Date), ByVal Priority As String, ByVal CategoryID As Integer, ByVal SubCategoryID As Integer, ByVal ClientID As Integer, ByVal AreaDeveloperId As Integer, ByVal Resources As String, ByVal ResourcesDeleted As String, ByVal Estimates As String, ByVal CRBApprovalDate As Nullable(Of Date), ByVal Notes As String, ByVal NewResources As String, ByVal NewEstimates As String, Optional ByVal ticketOwnerID As Integer = 0) As Integer
            ''Dim PM_Ticket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features(ID, Name, TypeID, UserID, SowSignedDate, Priority, CategoryID, ClientID, AreaDeveloperId)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PMTicketUpdate(ID, Name, TypeID, UserID, SowSignedDate, Priority, CategoryID, SubCategoryID, ClientID, AreaDeveloperId, Resources, ResourcesDeleted, Estimates, CRBApprovalDate, Notes, NewResources, NewEstimates, ticketOwnerID)
        End Function

        Public Shared Function PM_MYTicketGetAll_Paging(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal StatusID As Integer, ByVal FilterID As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String, ByVal StartDate As DateTime, ByVal EndDate As DateTime, ByVal TicketNo As Integer) As DataTable
            Dim UserlLogID As Integer = CType(HttpContext.Current.Session("AdminID"), Integer)
            Dim PM_Ticket_FeaturesDal As Portal.DAL.PM.DBPM_Ticket_Features = New Portal.DAL.PM.DBPM_Ticket_Features()
            Return PM_Ticket_FeaturesDal.PM_Tickets_Features_MyTickets_GetAll_Paging(ClientID, CategoryID, StatusID, FilterID, UserlLogID, SortExpression, MaximumRows, StartRowIndex, txtsearch, StartDate, EndDate, TicketNo)
        End Function

        Public Shared Function PM_SubCategories_CategoryID(ByVal CategoryID As Integer) As SqlDataReader
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_SubCategories_CategoryID(CategoryID)
        End Function

        Public Shared Function PM_Project_Information_GetByTicketID(ByVal ID As Integer) As List(Of PM_Ticket_Features)
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_Project_Information_GetByTicketID(ID)
        End Function

        Public Shared Function PM_MYTicket_Attachment_GetByTicketID_GetByAttachmentType(ByVal ID As Integer, ByVal AttachmentType As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_MYTicket_Attachment_GetByTicketID_GetByAttachmentType(ID, AttachmentType)
        End Function

        Public Shared Function PM_MYTicket_Estimates_GetByTicketID(ByVal ID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_MYTicket_Estimates_GetByTicketID(ID)
        End Function

        Public Shared Function PM_ProjectResources_GetByTicketID(ByVal ID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_ProjectResources_GetByTicketID(ID)
        End Function

        Public Shared Function PM_Users_GetByGroupId(ByVal ID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_Users_GetByGroupId(ID)
        End Function

        Public Shared Function PM_Roles_GetAll(ByVal ID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_Roles_GetAll(ID)
        End Function

        Public Shared Function PM_EstimatesType_GetAll(ByVal ID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_EstimatesType_GetAll(ID)
        End Function

        Public Shared Function PM_Users_GetAll() As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_Users_GetAll()
        End Function

        Public Shared Function PM_GetGroupID_ByUserID(ByVal ID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_GetGroupID_ByUserID(ID)
        End Function
        Public Shared Function PM_TicketGetAll(ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal StatusID As Integer, ByVal TypeID As Integer, ByVal FilterID As Integer, ByVal WaitingForUserID As Integer, ByVal ReleaseId As Integer, ByVal SortExpression As String, ByVal MaximumRows As Integer, ByVal StartRowIndex As Integer, ByVal Search As String, ByVal UserID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketGetAll(ClientID, CategoryID, StatusID, ReleaseId, TypeID, FilterID, WaitingForUserID, SortExpression, MaximumRows, StartRowIndex, Search, UserID)
        End Function
        Public Shared Function PM_TicketFeature_TicketLink_GetByTicketID(ByVal TicketID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketFeature_TicketLink_GetByTicketID(TicketID)
        End Function
        Public Shared Function PM_TicketFeature_TicketLink_Add(ByVal TicketID As Integer, ByVal TicketRefID As Integer,ByVal Subject As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketFeature_TicketLink_Add(TicketID, TicketRefID,Subject)
        End Function

        Public Shared Function PM_TicketFeature_TicketLink_Search(ByVal TicketID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketFeature_TicketLink_Search(TicketID)
        End Function
        Public Shared Function PM_TicketFeature_UpdateFlag(ByVal TicketID As Integer, ByVal Flag As Boolean, ByVal UserID As Integer, ByVal Comments As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketFeature_UpdateFlag(TicketID, Flag, UserID, Comments)
        End Function

        Public Shared Function PM_TicketFeature_Search_Category() As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketFeature_Search_Category()
        End Function
        Public Shared Function PM_TicketFeature_Search_Type() As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.PM_TicketFeature_Search_Type()
        End Function
        Public Shared Function DisplayQuestion() As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.DisplayQuestion()
        End Function
        Public Shared Function AddAnswer(ByVal Data As DataTable) As Boolean
            Return Portal.DAL.PM.DBPM_Ticket_Features.AddAnswer(Data)
        End Function
        Public Shared Function GetAllUserForAssignTo() As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetAllUserForAssignTo()
        End Function
        Public Shared Function GetAllTeams(ByVal type As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetAllTeams(type)
        End Function
        Public Shared Function RunAndSaveReport(ByVal reportName As String, ByVal Subject As String, ByVal createdBy As String, ByVal Columns As String, ByVal bit As Boolean, ByVal ClientID As String, ByVal TypeId As String, ByVal CategoryId As String, ByVal SubCategoryId As String, ByVal Priority As String, ByVal status As String, ByVal TeamId As String, ByVal ReleaseId As String, ByVal CSOL As Integer, ByVal AssignedTo As String, ByVal ProductOwner As String, ByVal ProjectManager As String, ByVal DesignLead As String, ByVal DevLead As String, ByVal QALead As String, ByVal CreationDateInDay As String, ByVal CreationDateStart As String, ByVal CreationDateEnd As String, ByVal LastestActivityInDays As String, ByVal LastestActivityStartDate As String, ByVal LastestActivityEndDate As String, ByVal SowSignDays As String, ByVal SowSignDateStart As String, ByVal SowSignDateEnd As String, ByVal DueDays As String, ByVal DueDateStart As String, ByVal DueDateEnd As String, ByVal ReportFilters As DataTable) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.RunAndSaveReport(reportName, Subject, createdBy, Columns, bit, ClientID, TypeId, CategoryId, SubCategoryId, Priority, status, TeamId, ReleaseId, CSOL, AssignedTo, ProductOwner, ProjectManager, DesignLead, DevLead, QALead, CreationDateInDay, CreationDateStart, CreationDateEnd, LastestActivityInDays, LastestActivityStartDate, LastestActivityEndDate, SowSignDays, SowSignDateStart, SowSignDateEnd, DueDays, DueDateStart, DueDateEnd, ReportFilters)
        End Function

        Public Shared Function GetMyReport(ByVal UserId As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetMyReport(UserId)
        End Function
        Public Shared Function DeleteReport(ByVal IDs As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.DeleteReport(IDs)
        End Function
        Public Shared Function GetReportById(ByVal ReportId As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetReportById(ReportId)
        End Function

        Public Shared Function ShareReport(ByVal ReportIDs As String, ByVal UserIDs As String) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.ShareReport(ReportIDs, UserIDs)
        End Function

        Public Shared Function GetPMName(ByVal ID As Integer, ByVal GID As Integer, ByVal PageNumber As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetPMName(ID, GID, PageNumber)
        End Function
          Public Shared Function GeTReportPMName(ByVal ID As Integer, ByVal GID As Integer) As DataTable
              Return Portal.DAL.PM.DBPM_Ticket_Features.GeTReportPMName(ID, GID)
          End Function
        Public Shared Function GET_REPORT_BY_ID() As DataTable

            Return Portal.DAL.PM.DBPM_Ticket_Features.GET_REPORT_BY_ID()
        End Function
        Public Shared Function GET_Report_Detail(ByVal ReportID As Integer) As DataSet
            Return Portal.DAL.PM.DBPM_Ticket_Features.GET_Report_Detail(ReportID)
        End Function

        Public Shared Function UpdateReport(ByVal reportID As Integer, ByVal reportName As String, ByVal Subject As String, ByVal createdBy As String, ByVal Columns As String, ByVal ClientID As String, ByVal TypeId As String, ByVal CategoryId As String, ByVal SubCategoryId As String, ByVal Priority As String, ByVal status As String, ByVal TeamId As String, ByVal ReleaseId As String, ByVal CSOL As Integer, ByVal AssignedTo As String, ByVal ProductOwner As String, ByVal ProjectManager As String, ByVal DesignLead As String, ByVal DevLead As String, ByVal QALead As String, ByVal CreationDateInDay As String, ByVal CreationDateStart As String, ByVal CreationDateEnd As String, ByVal LastestActivityInDays As String, ByVal LastestActivityStartDate As String, ByVal LastestActivityEndDate As String, ByVal SowSignDays As String, ByVal SowSignDateStart As String, ByVal SowSignDateEnd As String, ByVal DueDays As String, ByVal DueDateStart As String, ByVal DueDateEnd As String, ByVal ReportFilters As DataTable) As DataTable

            Return Portal.DAL.PM.DBPM_Ticket_Features.UpdateReport(reportID, reportName, Subject, createdBy, Columns, ClientID, TypeId, CategoryId, SubCategoryId, Priority, status, TeamId, ReleaseId, CSOL, AssignedTo, ProductOwner, ProjectManager, DesignLead, DevLead, QALead, CreationDateInDay, CreationDateStart, CreationDateEnd, LastestActivityInDays, LastestActivityStartDate, LastestActivityEndDate, SowSignDays, SowSignDateStart, SowSignDateEnd, DueDays, DueDateStart, DueDateEnd, ReportFilters)
        End Function

        Public Shared Function GetReportNameForExcel(ByVal ReportID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.GetReportNameForExcel(ReportID)
        End Function
        Public Shared Function RemoveLinkedTicket(ByVal TicketID As Integer, ByVal LinkedTicketID As Integer ) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.RemoveLinkedTicket(TicketID,LinkedTicketID)
        End Function
        Public Shared Function DeleteResources(ByVal TicketID As Integer, ByVal RoleID As Integer ) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.DeleteResources(TicketID,RoleID)
        End Function
        Public Shared Function AddNewResource(ByVal TicketID As Integer, ByVal ResourceName As String) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.AddNewResource(TicketID, ResourceName)
        End Function
        Public Shared Function UpdateTicketResource(ByVal TicketID As Integer, ByVal RoleID As Integer, ByVal UserID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.UpdateTicketResource(TicketID, RoleID, UserID)
        End Function
        
        Public Shared Function AddNewEstimate(ByVal TicketID As Integer, ByVal RoleName As String) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features.AddNewEstimate(TicketID, RoleName)
        End Function
        Public Shared Function DeleteEstimate(ByVal TicketID As Integer, ByVal EstimateTypeID As integer) As Integer
            Return Portal.DAL.PM.DBPM_Ticket_Features.DeleteEstimate(TicketID, EstimateTypeID)
        End Function
#End Region
    End Class
End Namespace
