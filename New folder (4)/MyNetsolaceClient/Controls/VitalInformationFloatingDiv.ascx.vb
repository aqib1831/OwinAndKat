Imports System.Data

Partial Class MyNetsolace_Controls_VitalInformationFloatingDiv
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
            hdnFranchiseID.Value = HttpContext.Current.Request.QueryString("FranchiseID").ToString()
        End If
        If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
            hdnClientID.Value = Request.QueryString("ClientID").ToString()
        End If
    End Sub

    Protected Sub btnRebind_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRebind.Click
        fvLeadVitals.DataBind()
    End Sub

    Public Function IsValidUserForCredentialsArea() As Boolean
        Dim blnIsValidUser As Boolean = False
        If Session("AdminCurrentobjUser") IsNot Nothing Then
            Dim objUsers As New Portal.BLL.Users
            objUsers = CType(Session("AdminCurrentobjUser"), Portal.BLL.Users)
            If objUsers.DepartmentID = Portal.BLL.Enumeration.Departments.Support Then
                blnIsValidUser = True
            End If
        End If
        Return blnIsValidUser
    End Function
    Protected Sub fvProductDetail_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim str As String = String.Empty
        Dim fvProduct As FormView = CType(sender, FormView)
        Dim productID As Integer = CType(fvProduct.FindControl("hdnProductID"), HiddenField).Value

        If (productID = Portal.BLL.Enumeration.NSProductIDs.SMS Or productID = Portal.BLL.Enumeration.NSProductIDs.SMS_X Or productID = Portal.BLL.Enumeration.NSProductIDs.QS) AndAlso IsValidUserForCredentialsArea() Then

            Dim FranchiseId As Integer = 0
            Dim authCode As String = ConfigurationManager.AppSettings("PortalServiceAuthCode").Trim
            Dim ds As Data.DataSet = Nothing
            If hdnClientID.Value = Portal.BLL.Enumeration.ClientID.EA Then
                FranchiseId = Portal.BLL.Franchises.GetFransupportFranchiseID(hdnFranchiseID.Value, hdnClientID.Value)
                Dim srvPortal As New WS_Fransupport.WS_Portal
                ds = srvPortal.Contacts_GetLoginCredentials(authCode, FranchiseId)
            ElseIf hdnClientID.Value = Portal.BLL.Enumeration.ClientID.Frutation Then
                FranchiseId = Portal.BLL.Franchises.GetFransupportFranchiseID(hdnFranchiseID.Value, hdnClientID.Value)
                Dim serFrutation As New WS_Frutation.Service
                ds = serFrutation.Contacts_GetLoginCredentials(FranchiseId)
            ElseIf hdnClientID.Value = Portal.BLL.Enumeration.ClientID.SaladCreation Then
                FranchiseId = Portal.BLL.Franchises.GetFransupportFranchiseID(hdnFranchiseID.Value, hdnClientID.Value)
                Dim serSaladCreation As New SaladCreation.Service
                ds = serSaladCreation.Contacts_GetLoginCredentials(FranchiseId)
            End If
        End If
    End Sub

End Class
