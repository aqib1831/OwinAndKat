Imports System.Data
Imports System.Data.SqlClient
Partial Class com_VitalInformationFloatingDiv
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

	Protected Sub btnLoginCredentials_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnk As LinkButton = CType(sender, LinkButton)
        
    End Sub
    Protected Sub fvLeadVitals_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles fvLeadVitals.DataBound
        If fvLeadVitals.DefaultMode = FormViewMode.ReadOnly Then
            Dim Status As Integer
            Dim SubStatus As Integer
            Dim IsCorporate As Boolean

            Status = CType(fvLeadVitals.FindControl("hdnStoreStatus"), HiddenField).Value
            SubStatus = CType(fvLeadVitals.FindControl("hdnSubStatus"), HiddenField).Value
            IsCorporate = CType(fvLeadVitals.FindControl("hdnIsCorporate"), HiddenField).Value
            Dim IsShow As Boolean
            IsShow = ShowSynchronization(Status, SubStatus, IsCorporate)
            Dim Tr As HtmlTableRow = CType(fvLeadVitals.FindControl("trSynchronization"), HtmlTableRow)
            Tr.Visible = IsShow

            Try
                If hdnClientID.Value = "1" Then
                    Dim dr As SqlDataReader
                    Dim db As DBAccess = New DBAccess()
                    db.AddParameter("@ID", hdnFranchiseID.value)
                    dr = db.ExecuteReader("Franchises_GetDailyPinByID")
                    If (dr.HasRows) Then
                        CType(fvLeadVitals.FindControl("trDailypin"), HtmlTableRow).visible = True
                        While dr.Read()
                            CType(fvLeadVitals.FindControl("lblDailyPin"), Label).Text = dr("DailyPin")
                        End While
                    End If
                    dr.Close()
                End If
            Catch ex As Exception

            End Try
        End If
    End Sub

    Function ShowSynchronization(ByVal Status As Integer, ByVal SubStatus As Integer, ByVal IsCorporate As Boolean) As Boolean
        Dim IsShow As Boolean

        If CInt(hdnClientID.Value) = 1 Then

            If Status = Portal.BLL.Enumeration.StoreStatus.Operating Or IsCorporate = 1 Then
                IsShow = True
            ElseIf Status = Portal.BLL.Enumeration.StoreStatus.ComingSoon And SubStatus = 4 Then
                IsShow = True
            Else
                IsShow = False
            End If

        Else
            IsShow = False
        End If

        Return IsShow
    End Function
	
	Public Function IsValidUserForCredentialsArea() As Boolean
        Dim blnIsValidUser As Boolean = False
        If Session("AdminCurrentobjUser") IsNot Nothing Then
            Dim objUsers As New Portal.BLL.Users
            objUsers = CType(Session("AdminCurrentobjUser"), Portal.BLL.Users)
            If objUsers.DepartmentID = Portal.BLL.Enumeration.Departments.Support Or objUsers.ID = Portal.BLL.Enumeration.Users.Abdullah Or objUsers.ID = Portal.BLL.Enumeration.Users.Tahami Or objUsers.ID = Portal.BLL.Enumeration.Users.Akhtar Then
                blnIsValidUser = True
            End If
        End If
        Return blnIsValidUser
    End Function
    Protected Sub fvProductDetail_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim str As String = String.Empty
        Dim fvProduct As FormView = CType(sender, FormView)
        Dim productID As Integer = CType(fvProduct.FindControl("hdnProductID"), HiddenField).Value
        Dim userName As Label = CType(fvProduct.FindControl("lblUserName"), Label)
        Dim password As Label = CType(fvProduct.FindControl("lblPassword"), Label)
        Dim access As Label = CType(fvProduct.FindControl("lblAccess"), Label)


        If (productID = Portal.BLL.Enumeration.NSProductIDs.SMS Or productID = Portal.BLL.Enumeration.NSProductIDs.SMS_X Or productID = Portal.BLL.Enumeration.NSProductIDs.QS) AndAlso IsValidUserForCredentialsArea() Then
            
            Dim FranchiseId As Integer = 0
            Dim authCode As String = ConfigurationManager.AppSettings("PortalServiceAuthCode").Trim
            Dim ds As Data.DataSet = Nothing
            'If hdnClientID.Value = Portal.BLL.Enumeration.ClientID.EA Then
            '    FranchiseId = Portal.BLL.Franchises.GetFransupportFranchiseID(hdnFranchiseID.Value, hdnClientID.Value)
            '    Dim srvPortal As New WS_Fransupport.WS_Portal
            '    ds = srvPortal.Contacts_GetLoginCredentials(authCode, FranchiseId)
            'ElseIf hdnClientID.Value = Portal.BLL.Enumeration.ClientID.Frutation Then
            '    FranchiseId = Portal.BLL.Franchises.GetFransupportFranchiseID(hdnFranchiseID.Value, hdnClientID.Value)
            '    Dim serFrutation As New WS_Frutation.Service
            '    ds = serFrutation.Contacts_GetLoginCredentials(FranchiseId)
            'ElseIf hdnClientID.Value = Portal.BLL.Enumeration.ClientID.SaladCreation Then
            '    FranchiseId = Portal.BLL.Franchises.GetFransupportFranchiseID(hdnFranchiseID.Value, hdnClientID.Value)
            '    Dim serSaladCreation As New SaladCreation.Service
            '    ds = serSaladCreation.Contacts_GetLoginCredentials(FranchiseId)
            'End If
            ''''''ds = Nothing
            'If Not ds Is Nothing AndAlso ds.Tables(0).Rows.Count > 0 Then
            '    userName.Text = Functions.IfNull(ds.Tables(0).Rows(0).Item("UserName"), "&nbsp;")
            '    password.Text = Functions.IfNull(ds.Tables(0).Rows(0).Item("Password"), "&nbsp;")
            '    access.Text = IIf(Functions.IfNull(ds.Tables(0).Rows(0).Item("FranSupportUser"), False), "Yes", "No")
            'Else
            '    ScriptManager.RegisterStartupScript(Me, Me.GetType, "asas", "ShowNoLogin(" & productID & ");", True)
            'End If
        End If
    End Sub
    Protected Function IsPackageProduct(ByVal productId As Integer) As Boolean
        If productId = Portal.BLL.Enumeration.NSProductIDs.S Or productId = Portal.BLL.Enumeration.NSProductIDs.SN Or productId = Portal.BLL.Enumeration.NSProductIDs.SND Or productId = Portal.BLL.Enumeration.NSProductIDs.SNDQ Or productId = Portal.BLL.Enumeration.NSProductIDs.SNQ Or productId = Portal.BLL.Enumeration.NSProductIDs.ISP Then
            Return True
        Else
            Return False
        End If

    End Function
End Class

