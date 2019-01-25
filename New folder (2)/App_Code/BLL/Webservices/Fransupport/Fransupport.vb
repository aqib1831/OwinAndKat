Imports System.Data
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Net

<WebService(Namespace:="http://Fransupport.com/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class Fransupport
    Inherits System.Web.Services.WebService

    Protected Overloads Function GetWebRequest(ByVal uri As Uri) As WebRequest
        Dim webRequest As HttpWebRequest = DirectCast(Net.WebRequest.Create(uri), HttpWebRequest)
        webRequest.KeepAlive = False
        webRequest.ProtocolVersion = HttpVersion.Version10

        Return webRequest
    End Function

    <WebMethod()> _
    Public Sub InactiveProducts(ByVal FranchiseID As Integer)
        Portal.DAL.DBNSProducts.InactiveProductsByFranchiseID(FranchiseID)
    End Sub

    <WebMethod()> _
    Public Sub ActivateProducts(ByVal FranchiseID As Integer)
        Portal.DAL.DBNSProducts.ActiveProductsByFranchiseID(FranchiseID)
    End Sub
    <WebMethod()> _
    Public Function Check_Has_nXstep(ByVal FranchiseID As Integer) As Boolean
        Return Portal.DAL.DBNSProducts.Check_Has_Product(FranchiseID, Portal.BLL.Enumeration.NSProductIDs.nXstep)
    End Function
	
	<WebMethod()> _
    Public Function CheckHasUpdatePin(ByVal clientId As Integer, ByVal franchiseId As Integer) As Integer
        Dim objnXstepLicenses As New Portal.DAL.LicenseManagement
        Return objnXstepLicenses.CheckHasUpdatedPin(clientId, franchiseId)
    End Function
    <WebMethod()> _
    Public Function UpdatenXstepIPAndPin(ByVal LicenseId As Integer, ByVal nXstepPin As String, ByVal systemIp As String, ByVal notes As String) As Integer
        Dim objnXstepLicenses As New Portal.DAL.LicenseManagement
        Return objnXstepLicenses.UpdatenXstepIPAndPin(LicenseId, nXstepPin, systemIp, notes)
    End Function
    <WebMethod()> _
    Public Function GetnXstepPinAndIP(ByVal LicenseId As Integer) As DataSet
        Dim objnXstepLicenses As New Portal.DAL.LicenseManagement
        Return objnXstepLicenses.GetnXstepPinAndIP(LicenseId)
    End Function
    <WebMethod()> _
    Public Function GetDMenu_FranchisesAndDisplayNoByClientID(ByVal ClientID As Integer, ByVal CountryID As Integer) As DataSet
        Return Portal.DAL.LM.DBDMenuLicenseManagement.DMenuLicenses_GetDisplayNoByClientIDForWebService(ClientID, CountryID)
    End Function
    <WebMethod()> _
    Public Function GETSMSXLicenseByFranchiseID(ByVal FranchiseId As Integer) As DataSet
        Return Portal.BLL.SMSXLicenseManagement.GETSMSXLicenseByFranchiseID(FranchiseId)
    End Function
    <WebMethod()> _
    Public Function SMSX_LicensesChangeStatusByFranchiseID(ByVal FranchiseId As Integer, ByVal Status As Integer) As Integer
        Return Portal.DAL.SMSXLicenseManagement.SMSX_LicensesChangeStatusByFranchiseID(FranchiseId, Status)
    End Function
	<WebMethod()> _
    Public Function GetSMSInfoByFranchiseID(ByVal FranchiseId As Integer) As DataSet
        Return Portal.DAL.NS.DBNS_Products_Franchises.GetSMSInfoByFranchiseID(FranchiseId)
    End Function
    <WebMethod()> _
      Public Function UpdateFranchiseStatus(ByVal FranchiseID As Integer, ByVal Status As Integer)
        Dim objnDBFranchises As New Portal.DAL.Client.DBFranchises
        Return objnDBFranchises.UpdateFranchiseStatus(FranchiseID, Status)
    End Function	
  <WebMethod()> _
          Public Function Update_NS_Products_TechnicalInfo(ByVal FranchiseID As Integer, ByVal HouseCharge As Boolean, ByVal HouseChargeAmount As String)
        Dim objnDBFranchises As New Portal.DAL.Client.DBFranchises
        Return objnDBFranchises.Update_NS_Products_TechnicalInfo(FranchiseID, HouseCharge, HouseChargeAmount)
    End Function

    <WebMethod()> _
      Public Sub ClientContact_SyncWithFransupport(ByVal ClientId As Integer, ByVal FransupportAdminId As Integer, ByVal FirstName As String, ByVal MiddleName As String, _
                                                   ByVal LastName As String, ByVal Gender As Boolean, ByVal JobTitle As String, ByVal HomePhone As String, _
                                                   ByVal WorkPhone As String, ByVal CellPhone As String, ByVal Fax As String, ByVal Email1 As String, _
                                                   ByVal Email2 As String, ByVal Address As String, ByVal Address2 As String, ByVal City As String, ByVal Zip As String, _
                                                   ByVal State As String, ByVal CountryId As Integer, ByVal ContactType As Integer, ByVal UserName As String, _
                                                   ByVal Password As String, ByVal IsAdmin As Boolean, ByVal HasMynetsolaceAccess As Boolean, ByVal AddFromFSByAdminId As Integer, ByVal FransupportAdminName As String)
        Dim objDBClientContacts As New Portal.DAL.Client.DBClient_Contacts
        Dim objClientContacts As New Portal.BLL.Client.Client_Contacts
        objClientContacts.ClientID = ClientId
        objClientContacts.AdminID = FransupportAdminId
        objClientContacts.FirstName = FirstName
        objClientContacts.MiddleName = MiddleName
        objClientContacts.LastName = LastName
        objClientContacts.Gender = Gender
        objClientContacts.JobTitle = JobTitle
        objClientContacts.HomePhone = HomePhone
        objClientContacts.WorkPhone = WorkPhone
        objClientContacts.CellPhone = CellPhone
        objClientContacts.Fax = Fax
        objClientContacts.Email1 = Email1
        objClientContacts.Email2 = Email2
        objClientContacts.Address = Address
        objClientContacts.Address2 = Address2
        objClientContacts.City = City
        objClientContacts.Zip = Zip
        objClientContacts.CountryID = CountryId
        objClientContacts.ContactType = ContactType
        objClientContacts.UserName = UserName
        objClientContacts.PassWord = Password
        objClientContacts.IsAdmin = IsAdmin
        objClientContacts.AddFromFSByAdminId = AddFromFSByAdminId
        objDBClientContacts.AddFromFransupport(objClientContacts, HasMynetsolaceAccess, FransupportAdminName, State)
    End Sub

<WebMethod()> _
    Public Function GetHelpDeskActivitiesForDM(ByVal Search As String) As Data.DataSet
        Dim objActivities As New Portal.DAL.Activities
        Return objActivities.GetActivtiesForDMWebService(Search)
    End Function

    <WebMethod()> _
    Public Function GetHelpDeskActivitiesForDMByClientId(ByVal Search As String, ByVal ClientId As Integer) As Data.DataSet
        Dim objActivities As New Portal.DAL.Activities
        Return objActivities.GetActivtiesForDMWebService(Search, ClientId)
    End Function

    <WebMethod()> _
    Public Function GetHelpDeskActivitiesForDMByClientIdAndFranchiseId(ByVal Search As String, ByVal ClientId As Integer, ByVal FranchiseId As Integer) As Data.DataSet
        Dim objActivities As New Portal.DAL.Activities
        Return objActivities.GetActivtiesForDMWebService(Search, ClientId, FranchiseId)
    End Function
End Class