Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Namespace Portal.BLL.PM
    Public Class PM_Ticket_Features_Users
#Region " Private Members "
        Private _id As Integer
        Private _ticket_feature_id As Integer
        Private _userid As Integer
        Private _clientcontactid As Integer

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

        Public Property Ticket_Feature_ID() As Integer
            Get
                Return _ticket_feature_id
            End Get
            Set(ByVal value As Integer)
                _ticket_feature_id = value
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

#End Region

#Region " Public Method "
       
        Public Shared Function PM_Ticket_Features_UsersGetByID(ByVal ID As Integer) As DataTable
            Return Portal.DAL.PM.DBPM_Ticket_Features_Users.PM_Ticket_Features_UsersGetByID(ID)
        End Function

        Public Function PM_Ticket_Features_UsersAddClientContacs(ByVal Ticket_Feature_ID As Integer, ByVal ClientContactIDs As String, ByVal ClientContactID As Integer) As Integer
            Dim PM_Ticket_Features_UsersDal As Portal.DAL.PM.DBPM_Ticket_Features_Users = New Portal.DAL.PM.DBPM_Ticket_Features_Users()
            Return PM_Ticket_Features_UsersDal.AddClientContacs(Ticket_Feature_ID, ClientContactIDs, ClientContactID)
        End Function

        Public Function PM_Ticket_Features_UsersAddUsers(ByVal Ticket_Feature_ID As Integer, ByVal UserIDs As String, ByVal UserID As Integer) As Integer
            Dim PM_Ticket_Features_UsersDal As Portal.DAL.PM.DBPM_Ticket_Features_Users = New Portal.DAL.PM.DBPM_Ticket_Features_Users()
            Return PM_Ticket_Features_UsersDal.AddUsers(Ticket_Feature_ID, UserIDs, UserID)
        End Function

        Public Function PM_Ticket_Features_UsersAddQAUsers(ByVal Ticket_Feature_ID As Integer, ByVal UserIDs As String) As Integer
            Dim PM_Ticket_Features_UsersDal As Portal.DAL.PM.DBPM_Ticket_Features_Users = New Portal.DAL.PM.DBPM_Ticket_Features_Users()
            Return PM_Ticket_Features_UsersDal.AddQAUsers(Ticket_Feature_ID, UserIDs)
        End Function

        Public Function PM_Ticket_Features_Users_ClientContacts(ByVal ClientID As Integer, ByVal TicketID As Integer, ByVal AreaDeveloperId As Integer) As SqlClient.SqlDataReader
            Dim PM_Ticket_Features_UsersDal As Portal.DAL.PM.DBPM_Ticket_Features_Users = New Portal.DAL.PM.DBPM_Ticket_Features_Users()
            Return PM_Ticket_Features_UsersDal.PM_Ticket_Features_Users_ClientContacts(ClientID, TicketID, AreaDeveloperId)
        End Function

        Public Function PM_Ticket_Features_InserUserAccess(ByVal Ticket_Feature_ID As Integer, ByVal UserID As Integer, ByVal ClientContactID As Integer) As Integer
            Dim PM_Ticket_Features_UsersDal As Portal.DAL.PM.DBPM_Ticket_Features_Users = New Portal.DAL.PM.DBPM_Ticket_Features_Users()
            Return PM_Ticket_Features_UsersDal.InsertUserAccess(Ticket_Feature_ID, UserID, ClientContactID)
        End Function

      
#End Region

    End Class
End Namespace