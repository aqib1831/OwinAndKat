Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports LMS.BusinessLogicLayer
Imports System.Data

Namespace Portal.BLL.PM
    Public Class PM_Releases
#Region " Private Members "
        Private _id As Integer
        Private _name As String
        Private _dateEntered As DateTime
        Private _releaseDate As Date
        Private _newReleaseDate As Date
        Private _progress As Integer
        Private _status As String
        Private _notes As String
        Private _history As Boolean
        Private _deleted As Boolean
        Private _clientID As Integer
        Private _CategoryID As Integer
        Private _clientName As String
        Private _CategoryName As String
        Private _userid As Integer
        Private _AreaDeveloperID As Integer
        Private _SowSignedDate As Date

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
        Public Property DateEntered() As DateTime

            Get
                Return _dateEntered
            End Get
            Set(ByVal value As DateTime)
                _dateEntered = value
            End Set
        End Property
        Public Property ReleaseDate() As Date
            Get
                Return _releaseDate
            End Get
            Set(ByVal value As Date)
                _releaseDate = value
            End Set
        End Property
        Public Property NewReleaseDate() As Date
            Get
                Return _newReleaseDate
            End Get
            Set(ByVal value As Date)
                _newReleaseDate = value
            End Set
        End Property
        Public Property Progress() As Integer
            Get
                Return _progress
            End Get
            Set(ByVal value As Integer)
                _progress = value
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
        Public Property Notes() As String
            Get
                Return _notes
            End Get
            Set(ByVal value As String)
                _notes = value
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
        Public Property Deleted() As Boolean
            Get
                Return _deleted
            End Get
            Set(ByVal value As Boolean)
                _deleted = value
            End Set
        End Property
        Public Property ClientID() As Integer
            Get
                Return _clientID
            End Get
            Set(ByVal value As Integer)
                _clientID = value
            End Set
        End Property
        Public Property CategoryID() As Integer
            Get
                Return _CategoryID
            End Get
            Set(ByVal value As Integer)
                _CategoryID = value
            End Set
        End Property
        Public Property ClientName() As String
            Get
                Return _clientName
            End Get
            Set(ByVal value As String)
                _clientName = value
            End Set
        End Property
        Public Property CategoryName() As String
            Get
                Return _CategoryName
            End Get
            Set(ByVal value As String)
                _CategoryName = value
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

        Public Property AreaDeveloperID() As Integer
            Get
                Return _AreaDeveloperID
            End Get
            Set(ByVal value As Integer)
                _AreaDeveloperID = value
            End Set
        End Property

        Public Property SowSignedDate As Date
            Get
                Return _SowSignedDate
            End Get
            Set(value As Date)
                _SowSignedDate = value
            End Set
        End Property

#End Region
#Region " Constructors"
        Public Sub New()

        End Sub
        Public Sub New( _
                        ByVal ID As Integer, _
                        ByVal Name As String, _
                        ByVal DateEntered As DateTime, _
                        ByVal ReleaseDate As Date, _
                        ByVal NewReleaseDate As Date, _
                        ByVal Progress As Integer, _
                        ByVal Status As String, _
                        ByVal Notes As String, _
                        ByVal History As Boolean, _
                        ByVal Deleted As Boolean, _
                        ByVal ClientID As Integer, _
                        ByVal CategoryID As Integer, _
                        ByVal UserID As Integer, _
                        ByVal AreaDeveloperID As Integer _
                        )



            Me.ID = ID
            Me.Name = Name
            Me.DateEntered = DateEntered
            Me.ReleaseDate = ReleaseDate
            Me.NewReleaseDate = NewReleaseDate
            Me.Progress = Progress
            Me.Status = Status
            Me.Notes = Notes
            Me.History = History
            Me.Deleted = Deleted
            Me.ClientID = ClientID
            Me.CategoryID = CategoryID
            Me.UserID = UserID
            Me.AreaDeveloperID = AreaDeveloperID


        End Sub
        Public Sub New(ByVal ID As Integer, ByVal Name As String, ByVal DateEntered As DateTime, ByVal ReleaseDate As Date, ByVal NewReleaseDate As Date, ByVal Progress As Integer, ByVal Status As String, ByVal Notes As String, ByVal History As Boolean, ByVal Deleted As Boolean, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal UserID As Integer, ByVal ClientName As String, ByVal CategoryName As String, ByVal AreaDeveloperID As Integer, ByVal SowSignedDate As Date)

            Me.ID = ID
            Me.Name = Name
            Me.DateEntered = DateEntered
            Me.ReleaseDate = ReleaseDate
            Me.NewReleaseDate = NewReleaseDate
            Me.Progress = Progress
            Me.Status = Status
            Me.Notes = Notes
            Me.History = History
            Me.Deleted = Deleted
            Me.ClientID = ClientID
            Me.CategoryID = CategoryID
            Me.UserID = UserID
            Me.ClientName = ClientName
            Me.CategoryName = CategoryName
            Me.AreaDeveloperID = AreaDeveloperID
            Me.SowSignedDate = SowSignedDate


        End Sub
#End Region
#Region " Public Methods"
        Public Shared Function GetAll(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of PM_Releases)
            Return Portal.DAL.PM.DBPM_Releases.GetAll(CategoryID, ClientID, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Shared Function GetAllCount(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Return Portal.DAL.PM.DBPM_Releases.GetAllCount(CategoryID, ClientID, sortExpression, txtsearch)
        End Function
        Public Shared Function GetAllForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Releases.GetAllForMyNetsolace(CategoryID, ClientID, sortExpression, maximumRows, startRowIndex, txtsearch, AreaDeveloperId)
        End Function
        Public Shared Function GetAllCountForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As Integer
            Return Portal.DAL.PM.DBPM_Releases.GetAllCountForMyNetsolace(CategoryID, ClientID, sortExpression, txtsearch, AreaDeveloperId)
        End Function

        Public Shared Function Releases_GetAllHistory(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of PM_Releases)
            Return Portal.DAL.PM.DBPM_Releases.Releases_GetAllHistory(CategoryID, ClientID, sortExpression, maximumRows, startRowIndex, txtsearch)
        End Function
        Public Shared Function Releases_GetAllHistoryCount(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String) As Integer
            Return Portal.DAL.PM.DBPM_Releases.Releases_GetAllHistoryCount(CategoryID, ClientID, sortExpression, txtsearch)
        End Function

        Public Shared Function Releases_GetAllHistoryForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Releases.Releases_GetAllHistoryForMyNetsolace(CategoryID, ClientID, sortExpression, maximumRows, startRowIndex, txtsearch, AreaDeveloperID)
        End Function
        Public Shared Function Releases_GetAllHistoryCountForMyNetsolace(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal sortExpression As String, ByVal txtsearch As String, ByVal AreaDeveloperID As Integer) As Integer
            Return Portal.DAL.PM.DBPM_Releases.Releases_GetAllHistoryCountForMyNetsolace(CategoryID, ClientID, sortExpression, txtsearch, AreaDeveloperID)
        End Function
        Public Shared Function PM_ReleasesGetByID(ByVal ID As Integer) As List(Of PM_Releases)
            Return Portal.DAL.PM.DBPM_Releases.GetByID(ID)
        End Function
        Public Shared Function PM_ReleasesAdd(ByVal ID As Integer, ByVal Name As String, ByVal DateEntered As Date, ByVal ReleaseDate As Date, ByVal NewReleaseDate As Date, ByVal Progress As Integer, ByVal Status As String, ByVal Notes As String, ByVal History As Boolean, ByVal Deleted As Boolean, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal UserID As Integer, ByVal AreaDeveloperID As Integer) As Integer
            Dim PM_ReleasesBll As Portal.BLL.PM.PM_Releases = New Portal.BLL.PM.PM_Releases(ID, Name, DateEntered, ReleaseDate, NewReleaseDate, Progress, Status, Notes, History, Deleted, ClientID, CategoryID, UserID, AreaDeveloperID)
            Dim PM_ReleasesDal As Portal.DAL.PM.DBPM_Releases = New Portal.DAL.PM.DBPM_Releases()
            Return PM_ReleasesDal.Add(PM_ReleasesBll)
        End Function
        Public Shared Function PM_ReleasesUpdate(ByVal ID As Integer, ByVal Name As String, ByVal DateEntered As Date, ByVal ReleaseDate As Date, ByVal NewReleaseDate As Date, ByVal Progress As Integer, ByVal Status As String, ByVal Notes As String, ByVal History As Boolean, ByVal Deleted As Boolean, ByVal ClientID As Integer, ByVal CategoryID As Integer, ByVal UserID As Integer, ByVal AreaDeveloperID As Integer) As Integer
            Dim PM_ReleasesBll As Portal.BLL.PM.PM_Releases = New Portal.BLL.PM.PM_Releases(ID, Name, DateEntered, ReleaseDate, NewReleaseDate, Progress, Status, Notes, History, Deleted, ClientID, CategoryID, UserID, AreaDeveloperID)
            Dim PM_ReleasesDal As Portal.DAL.PM.DBPM_Releases = New Portal.DAL.PM.DBPM_Releases()
            Return PM_ReleasesDal.Update(PM_ReleasesBll)
        End Function
        Public Function Delete(ByVal ID As Integer) As Integer
            Dim PM_ReleasesDal As Portal.DAL.PM.DBPM_Releases = New Portal.DAL.PM.DBPM_Releases()
            Return PM_ReleasesDal.Delete(ID)
        End Function

        Public Shared Function GetAll_Excel(ByVal CategoryID As Integer, ByVal ClientID As Integer, ByVal maximumRows As Integer, ByVal StartRowIndex As Integer, ByVal txtsearch As String, ByVal UserLogID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Releases.GetAll_Excel(CategoryID, ClientID, maximumRows, StartRowIndex, txtsearch, UserLogID)
        End Function
        Public Shared Function GetAllReleasesForDropdown()
            Return Portal.DAL.PM.DBPM_Releases.GetAllReleasesForDropdown()
        End Function
        Public Shared Function GetAllSubCategoryForDropdown()
            Return Portal.DAL.PM.DBPM_Releases.GetAllSubCategoryForDropdown()
        End Function
#End Region
    End Class
End Namespace
