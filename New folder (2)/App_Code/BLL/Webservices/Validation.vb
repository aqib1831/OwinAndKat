Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class Validation
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function FranchiseContactExists( _
                                            ByVal SecurityCode As String, _
                                            ByVal FranchiseID As Integer, _
                                            ByVal ContactID As Integer, _
                                            ByVal ClientID As Integer _
                                           ) As Boolean
        If SecurityCode <> ConfigurationManager.AppSettings("PortalSecurityCode") Then
            Return False
        End If

        Return FranchiseContact.IsValidFranchiseContact(FranchiseID, ContactID, ClientID)
    End Function
End Class
