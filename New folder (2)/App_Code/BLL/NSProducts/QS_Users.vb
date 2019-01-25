Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.QS
    Public Class QS_Users
#Region " Private Members "
        Private _id As Integer
        Private _clientid As Integer
        Private _franchiseid As Integer
        Private _key As String
        Private _ip As String
        Private _generatedon As Date
        Private _consumedon As Date
        Private _consumed As Boolean
        Private _deleted As Boolean
        Private _isstaticip As Boolean
        Private _version As String
        Private _notes As String
        Private _updatedon As Date
        Private _updatedby As Integer
        Private _lasttimesync As Date

        Private _storenumber As Integer
        Private _storenick As String
        Private _clientcode As String
        Private _updatedbyname As String

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

        Public Property FranchiseID() As Integer
            Get
                Return _franchiseid
            End Get
            Set(ByVal value As Integer)
                _franchiseid = value
            End Set
        End Property

        Public Property KEY() As String
            Get
                Return _key
            End Get
            Set(ByVal value As String)
                _key = value
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

        Public Property GeneratedOn() As Date
            Get
                Return _generatedon
            End Get
            Set(ByVal value As Date)
                _generatedon = value
            End Set
        End Property

        Public Property ConsumedOn() As Date
            Get
                Return _consumedon
            End Get
            Set(ByVal value As Date)
                _consumedon = value
            End Set
        End Property

        Public Property Consumed() As Boolean
            Get
                Return _consumed
            End Get
            Set(ByVal value As Boolean)
                _consumed = value
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

        Public Property IsStaticIP() As Boolean
            Get
                Return _isstaticip
            End Get
            Set(ByVal value As Boolean)
                _isstaticip = value
            End Set
        End Property

        Public Property Version() As String
            Get
                Return _version
            End Get
            Set(ByVal value As String)
                _version = value
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

        Public Property UpdatedOn() As Date
            Get
                Return _updatedon
            End Get
            Set(ByVal value As Date)
                _updatedon = value
            End Set
        End Property

        Public Property UpdatedBy() As Integer
            Get
                Return _updatedby
            End Get
            Set(ByVal value As Integer)
                _updatedby = value
            End Set
        End Property

        Public Property LastTimeSync() As Date
            Get
                Return _lasttimesync
            End Get
            Set(ByVal value As Date)
                _lasttimesync = value
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

        Public Property StoreNick() As String
            Get
                Return _storenick
            End Get
            Set(ByVal value As String)
                _storenick = value
            End Set
        End Property

        Public Property ClientCode() As String
            Get
                Return _clientcode
            End Get
            Set(ByVal value As String)
                _clientcode = value
            End Set
        End Property

        Public Property UpdatedByName() As String
            Get
                Return _updatedbyname
            End Get
            Set(ByVal value As String)
                _updatedbyname = value
            End Set
        End Property

#End Region


#Region " Constructor "
        Public Sub New()
        End Sub

        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ClientID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal KEY As String, _
          ByVal IP As String, _
          ByVal GeneratedOn As Date, _
          ByVal ConsumedOn As Date, _
          ByVal Consumed As Boolean, _
          ByVal Deleted As Boolean, _
          ByVal IsStaticIP As Boolean, _
          ByVal Version As String, _
          ByVal Notes As String, _
          ByVal UpdatedOn As Date, _
          ByVal UpdatedBy As Integer, _
          ByVal LastTimeSync As Date _
         )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.FranchiseID = FranchiseID
            Me.KEY = KEY
            Me.IP = IP
            Me.GeneratedOn = GeneratedOn
            Me.ConsumedOn = ConsumedOn
            Me.Consumed = Consumed
            Me.Deleted = Deleted
            Me.IsStaticIP = IsStaticIP
            Me.Version = Version
            Me.Notes = Notes
            Me.UpdatedOn = UpdatedOn
            Me.UpdatedBy = UpdatedBy
            Me.LastTimeSync = LastTimeSync


        End Sub

        'GetAll
        Public Sub New( _
          ByVal ID As Integer, _
          ByVal ClientID As Integer, _
          ByVal FranchiseID As Integer, _
          ByVal KEY As String, _
          ByVal IP As String, _
          ByVal GeneratedOn As Date, _
          ByVal ConsumedOn As Date, _
          ByVal Consumed As Boolean, _
          ByVal Deleted As Boolean, _
          ByVal IsStaticIP As Boolean, _
          ByVal Version As String, _
          ByVal Notes As String, _
          ByVal UpdatedOn As Date, _
          ByVal UpdatedBy As Integer, _
          ByVal LastTimeSync As Date, _
          ByVal StoreNumber As Integer, _
          ByVal StoreNick As String, _
          ByVal ClientCode As String _
         )


            Me.ID = ID
            Me.ClientID = ClientID
            Me.FranchiseID = FranchiseID
            Me.KEY = KEY
            Me.IP = IP
            Me.GeneratedOn = GeneratedOn
            Me.ConsumedOn = ConsumedOn
            Me.Consumed = Consumed
            Me.Deleted = Deleted
            Me.IsStaticIP = IsStaticIP
            Me.Version = Version
            Me.Notes = Notes
            Me.UpdatedOn = UpdatedOn
            Me.UpdatedBy = UpdatedBy
            Me.LastTimeSync = LastTimeSync
            Me.StoreNumber = StoreNumber
            Me.StoreNick = StoreNick
            Me.ClientCode = ClientCode


        End Sub
#End Region

#Region " Public Method "
        Public Shared Function QS_UsersGetAll(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As List(Of QS_Users)
            Return Portal.DAL.QS.DBQS_Users.QS_UsersGetAll(search, ClientID, Inactive, StoreID, sortBy, startRowIndex, maximumRows)
        End Function
        Public Shared Function QS_UsersGetAllCount(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer) As Integer
            Return Portal.DAL.QS.DBQS_Users.QS_UsersGetAllCount(search, ClientID, Inactive, StoreID)
        End Function
        Public Shared Function QS_UsersGetByID(ByVal ID As Integer) As QS_Users
            Return Portal.DAL.QS.DBQS_Users.QS_UsersGetByID(ID)
        End Function
        'Public Shared Function QS_UsersAdd(ByVal ID As Integer, ByVal ClientID As Integer, ByVal FranchiseID As Integer, ByVal KEY As String, ByVal IP As String, ByVal GeneratedOn As Date, ByVal ConsumedOn As Date, ByVal Consumed As Boolean, ByVal Deleted As Boolean, ByVal IsStaticIP As Boolean, ByVal Version As String, ByVal Notes As String, ByVal UpdatedOn As Date, ByVal UpdatedBy As Integer, ByVal LastTimeSync As Date) As Integer
        '    Dim QS_UsersBll As Portal.BLL.QS.QS_Users = New Portal.BLL.QS.QS_Users(ID, ClientID, FranchiseID, KEY, IP, GeneratedOn, ConsumedOn, Consumed, Deleted, IsStaticIP, Version, Notes, UpdatedOn, UpdatedBy, LastTimeSync)
        '    Dim QS_UsersDal As Portal.DAL.QS.DBQS_Users = New Portal.DAL.QS.DBQS_Users()
        '    Return QS_UsersDal.Add(QS_UsersBll)
        'End Function
        Public Shared Function QS_UsersUpdate(ByVal ID As Integer, ByVal IP As String, ByVal IsStaticIP As Boolean, ByVal Notes As String, ByVal UpdatedOn As Date, ByVal UpdatedBy As Integer) As Integer
            Dim QS_UsersDal As Portal.DAL.QS.DBQS_Users = New Portal.DAL.QS.DBQS_Users()
            Return QS_UsersDal.update(ID, IP, IsStaticIP, Notes, UpdatedOn, UpdatedBy)
        End Function

#End Region

    End Class
End Namespace