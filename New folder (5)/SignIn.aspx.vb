Imports System
Imports System.IO
Imports System.Xml
Imports Google.Apps.SingleSignOn
Partial Class SignIn
    Inherits System.Web.UI.Page
    Protected Url As String = String.Empty
    Protected ReadOnly Property ActionUrl() As String
        Get
            Return Url
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim username = Request.Form("UserName")
        SetupGoogleLoginForm(username)
        'Session.Remove("Admin_LogInName")
    End Sub
    Private Sub SetupGoogleLoginForm(ByVal userName As String)
        Dim samlRequest As String = Request.QueryString("SAMLRequest")
        If samlRequest Is Nothing Then
            samlRequest = Request.Form("SAMLRequest")
        End If
        Dim relayState__1 As String = Request.QueryString("RelayState")
        If relayState__1 Is Nothing Then
            relayState__1 = Request.Form("RelayState")
        End If

        If samlRequest IsNot Nothing AndAlso relayState__1 IsNot Nothing Then
            Dim samlRequestUnpacked As XmlDocument = Google.Apps.SingleSignOn.SamlParser.UnpackRequest(samlRequest)

            Dim responseXml As String
            Dim actionUrl As String
            Google.Apps.SingleSignOn.SamlParser.CreateSignedResponse(samlRequest, userName, responseXml, actionUrl)

            Me.Url = actionUrl

            LiteralAssertionUrl.Text = actionUrl
            TextAreaSamlRequestEncoded.Value = samlRequest
            TextAreaSamlRequestDecoded.Value = FormatXml(samlRequestUnpacked)

            SAMLResponse.Value = responseXml
            RelayState.Value = relayState__1
        End If
    End Sub

    Public Shared Function FormatXml(ByVal doc As XmlDocument) As String
        Dim xml As String

        Using stringWriter As New StringWriter()
            Dim xmlReader As New XmlNodeReader(doc)
            Dim xmlWriter As New XmlTextWriter(stringWriter)

            xmlWriter.Formatting = Formatting.Indented
            xmlWriter.Indentation = 2
            xmlWriter.IndentChar = " "

            xmlWriter.WriteNode(xmlReader, True)

            xml = stringWriter.ToString()
        End Using

        Return xml
    End Function

End Class
