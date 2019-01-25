Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports System.Web.HttpUtility

<WebService(Namespace:="https://qa.netsolace.com/portal/WebServices")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class DF
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    Public Function UpdateModifiedDFLicenses(ByVal securityCode As String, ByVal data() As Byte) As Integer

        If Not String.IsNullOrEmpty(securityCode) Then
            Dim result As Integer = Integer.MinValue
            securityCode = Functions.DecryptString128Bit(UrlDecode(securityCode), ConfigurationManager.AppSettings("DFEncryptionKey"))
            If securityCode = ConfigurationManager.AppSettings("DFServiceAuthCode") Then
                Dim ds As DataSet = Functions.DecompressDataSet(data)
                If ds IsNot Nothing Then
                    Try
                        Dim objDFLM As New Portal.DAL.DFLicenseManagement
                        result = objDFLM.UpdateLicenseDetails(ds)
                        Portal.DAL.WebServiceLog.Add(Portal.BLL.Enumeration.ProductNames.SMSX, "UpdateModifiedDFLicenses") ' Here DF Changes
                    Catch ex As Exception
                        ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "UpdateModifiedDFLicenses", String.Empty, String.Empty, ds.GetXml().ToString())
                    End Try
                    Return result
                End If
            End If
        End If
        Return Nothing
    End Function


End Class