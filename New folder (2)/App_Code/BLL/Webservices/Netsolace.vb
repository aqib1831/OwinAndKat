Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Portal.BLL

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class Netsolace
     Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod()> _
    Public Function Com_AddNewHelpDeskTicket(ByVal securityCode As String, ByVal ClientID As Enumeration.ClientID, ByVal StoreNumber As Integer, ByVal Subject As String, ByVal Description As String, ByVal Type As Enumeration.ActivityType, ByVal SubType As Enumeration.ActivitySubType, ByVal RelatedTo As Integer, ByVal ModuleID As Integer, ByVal Priority As Integer, ByVal ActivityState As Enumeration.ActivityState) As Integer
        Dim ActivityID As Integer = 0
        Dim franchiseid As Integer = 0
        If Not String.IsNullOrEmpty(securityCode) Then
            securityCode = Functions.DecryptString128Bit(System.Web.HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))
            If securityCode = ConfigurationManager.AppSettings("SMSServiceAuthCode") Then
                Dim ObjectActivity As New Portal.BLL.Activities

                Dim objDatareader As System.Data.SqlClient.SqlDataReader = Portal.BLL.Franchises.FranchiseByStoreNumberandClientID(StoreNumber, ClientID)
                If objDatareader.HasRows Then
                    If objDatareader.Read() Then
                        franchiseid = objDatareader("FranchiseID")
                    End If
                    If franchiseid > 0 Then
                        With ObjectActivity
                            .Subject = Subject
                            .Description = Description
                            .Type = IIf(Type = 0, Enumeration.ActivityType.Other, Type)
                            .SubType = IIf(SubType = 0, Enumeration.ActivitySubType.General, SubType)
                            .ClientID = ClientID 'Portal.BLL.Enumeration.ClientID.EA
                            .FranchiseID = franchiseid

                            .ActivityDate = DateTime.Now
                            .ActivityState = ActivityState 'Portal.BLL.Enumeration.ActivityState.InProgess
                            .RelatedTo = RelatedTo
                            .ModuleId = ModuleID
                            .Priority = Priority
                            .PlacedBy = Enumeration.PlacedBy.PortalAdmin

                            .UserID = Enumeration.Users.NS_WebServiceUser
                            .FranchiseContactID = 0
                            .ClientContactID = 0


                            If ActivityState = Enumeration.ActivityState.WaitingFor Then
                                .WaitingFor = "A" & CInt(Enumeration.Users.Ali_Raza).ToString()
                            Else
                                .WaitingFor = "0"
                            End If

                            .TimeSpent = TimeSpan.Parse(0 & ":" & 0)
                            .Status = False
                            .AdminInboxStatus = 0
                            .Charge = False
                            ActivityID = .ActivitiesAdd(ObjectActivity)
                        End With
                    End If
                End If
                objDatareader.Close()
            End If
        End If
		Activities.SendActivityMail("F" & franchiseid, ClientID, franchiseid, Activities.ActivityEmailType.WaitingFor, ActivityID, Subject, Portal.BLL.Franchises.GetStoreNickByFranchiseID(franchiseid), "has been created")
        Return ActivityID
    End Function


    '<WebMethod()> _
    'Public Function Com_AddNotes(ByVal ActivityID As Int32, ByVal NotesType As Int32, ByVal Notes As String, ByVal ClientContactID As Int32, ByVal FranchiseContactID As Int32, ByVal AdminID As Int32, ByVal PlacedBy As Int32, ByVal NotesDate As DateTime, ByVal strFile As String) As Boolean
    '    Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
    '    Dim intNewNotesID As Integer = 0
    '    With objActivityNotes
    '        .ActivityID = ActivityID
    '        .NotesType = CType(NotesType, Portal.BLL.Enumeration.ActivityNotesType)
    '        .Notes = Notes
    '        .ClientContactID = ClientContactID
    '        .FranchiseContactID = FranchiseContactID
    '        .AdminID = AdminID
    '        .PlacedBy = CType(PlacedBy, Portal.BLL.Enumeration.PlacedBy)
    '        .NotesDate = DateTime.Now
    '        intNewNotesID = .AddNotes()
    '    End With

    '    If intNewNotesID > 0 Then
    '        Dim DirectoryName As String = Functions.GetDateTimeUniqueString()
    '        Dim objActivityAttahcments As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
    '        With objActivityAttahcments
    '            .NotesID = intNewNotesID
    '            .ActivityID = 0
    '            .SaveAttachments(DirectoryName, strFile)
    '        End With
    '    End If

    'End Function

End Class
