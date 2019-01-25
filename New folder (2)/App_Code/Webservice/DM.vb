Imports Microsoft.VisualBasic
Imports System.Web.Services

Public Class DM
    <WebMethod()> _
Public Function AddDMLicence(ByVal StoreNo As Integer, ByVal ClientID As Integer, ByVal IsStaticIP As Boolean, ByVal SystemIP As String, ByVal InvoiceNo As String, ByVal NumberOfDisplays As Integer, ByVal Notes As String, ByVal DMVersion As String) As Integer

        Dim objLM As New Portal.BLL.LM.DMenuLicenseManagement
        Dim returnVal As Integer = 0
		Try
			objLM.InVoiceNo = InvoiceNo.Trim
			objLM.ClientID = ClientID
			objLM.ProductID = 15 'DM
			objLM.StoreNo = StoreNo
			objLM.NumberOfDisplays = NumberOfDisplays
			objLM.Notes = Notes.Trim
			objLM.IssuedByID = 0
			objLM.CurrentVersion = IIf(String.IsNullOrEmpty(DMVersion), ConfigurationManager.AppSettings("DMenuversion"), DMVersion)
			'If static ip is selected then we are going to save static ip
			'Other wise dynamic ip will be used.
			If (IsStaticIP) Then
				objLM.SystemIP = SystemIP.Trim
				objLM.IsDynamicIP = False
			Else
				objLM.SystemIP = String.Empty
				objLM.IsDynamicIP = True
			End If
			returnVal = objLM.AddDMenuLicenseFromService()
			Return returnVal
       	Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddDMLicence", String.Empty, String.Empty, String.Empty)
				Return 0
        End Try

    End Function

End Class
