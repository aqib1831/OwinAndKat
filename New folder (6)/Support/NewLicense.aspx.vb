
Partial Class Support_NewLicense
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    'Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
    '    ddlClient.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select...", "-1"))
    'End Sub
    Protected Sub ddlProducts_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.DataBound
        ddlProducts.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtStartDate.Text = Request(txtStartDate.UniqueID)
        txtEndDate.Text = Request(txtEndDate.UniqueID)


        If IsPostBack Then
            'To show the licesnses field
            If (ddlProducts.SelectedValue IsNot Nothing) Then
                If (CInt(ddlProducts.SelectedValue) = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) Then
                    rfvNoOfLicenses.Visible = True
                    rvNoOfLicenses.Visible = True
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowLicensesField", "ddlProducts_OnChange();", True)
                Else
                    rfvNoOfLicenses.Visible = False
                    rvNoOfLicenses.Visible = False
                End If
            End If
        End If
        

        If Not IsPostBack Then
            ddlProducts.Items.Insert(0, New ListItem("Select...", "0"))
            ddlStores.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Search...", "0"))

            Dim Days_to_Be_Added As Integer = Date.DaysInMonth(Date.Now.AddMonths(1).Year, Date.Now.AddMonths(1).Month) - Date.Now.Day
            'CV_StartDate.ValueToCompare = Date.Now.AddDays(-1).ToShortDateString
            'CV_StartDate.ErrorMessage = "Date Greater than " & Date.Now.AddDays(-1).ToString("M/d/yyyy")
            'CV_EndDate.ValueToCompare = Date.Now.AddDays(-1).ToShortDateString
            'CV_EndDate.ErrorMessage = "Date Greater than " & Date.Now.AddDays(-1).ToString("M/d/yyyy")


            If (Request.QueryString("FranchiseID") <> Nothing AndAlso IsNumeric(Request.QueryString("FranchiseID"))) Then
                hdnNSProductFranchiseID.Value = Request.QueryString("ID")
                LoadStores(Request.QueryString("FranchiseID"), Request.QueryString("ClientID"), "")
                ddlStores.Value = Request.QueryString("FranchiseID") & "," & Request.QueryString("ClientID")
                ddlStores_SelectedIndexChanged()
                ddlProducts.SelectedValue = CInt(Request.QueryString("ProductID"))

                If (ddlProducts.SelectedValue IsNot Nothing) Then
                    If (CInt(ddlProducts.SelectedValue) = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) Then
                        rfvNoOfLicenses.Visible = True
                        rvNoOfLicenses.Visible = True
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowLicensesField", "ddlProducts_OnChange();", True)
                    Else
                        rfvNoOfLicenses.Visible = False
                        rvNoOfLicenses.Visible = False
                    End If
                End If
                If Request.QueryString("Mode") <> Nothing Then
                    hdnMode.Value = Request.QueryString("Mode").ToLower
                    If (hdnMode.Value = "signup") Then
                        LoadSignUpMode()
                    ElseIf (hdnMode.Value = "extendsupport") Then
                        LoadEditMode()
                    ElseIf (hdnMode.Value = "turnon") Then
                        LoadTurnOn()
                    ElseIf (hdnMode.Value = "turnoff") Then
                        LoadTurnOff()
                    ElseIf (hdnMode.Value = "edit") Then
                        LoadEditMode()
                    End If
                Else
                    hdnMode.Value = ""
                End If
            End If
        End If
    End Sub

    Private Sub LoadLicence()
        If (hdnNSProductFranchiseID.Value > 0) Then
            Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
            objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetByID(hdnNSProductFranchiseID.Value)
            txtMonthlyPrice.Text = FormatNumber(objNS_Products_Franchises.Price, 2)
            txtStartDate.Text = objNS_Products_Franchises.SupportStartDate.ToString("M/d/yyyy")
            txtEndDate.Text = objNS_Products_Franchises.SupportEnddate.ToString("M/d/yyyy")
            txtNotes.Text = objNS_Products_Franchises.Notes

            If (objNS_Products_Franchises.ProductID = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) Then
                txtNofLicenses.Text = objNS_Products_Franchises.NoOfLicenses
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "ChangeDisplay", "ddlProducts_OnChange();", True)
            End If

            hdnSupportStartDate.Value = objNS_Products_Franchises.SupportStartDate.ToString("M/d/yyyy")
            hdnSupportEndDate.Value = objNS_Products_Franchises.SupportEnddate.ToString("M/d/yyyy")
            hdnFranchiseID.Value = objNS_Products_Franchises.FranchiseID
            hdnProductID.Value = objNS_Products_Franchises.ProductID
            hdnOnSupport.Value = objNS_Products_Franchises.onSupport
        End If
    End Sub
    Private Sub LoadEditMode()
        'CV_StartDate.Enabled = False
        LoadLicence()
        ddlStores.Enabled = False
        ddlProducts.Enabled = False
    End Sub
    Private Sub LoadSignUpMode()
        ddlProducts_SelectedIndexChanged()
        txtStartDate.Text = Date.Now.ToString("M/d/yyyy")
    End Sub
    Private Sub LoadTurnOn()
        'CV_StartDate.Enabled = False
        ddlProducts_SelectedIndexChanged()
        txtStartDate.Text = Date.Now.ToString("M/d/yyyy")
        LoadLicence()
        ddlStores.Enabled = False
        ddlProducts.Enabled = False
		If txtStartDate.Text = "1/1/1900" Then
            txtStartDate.Text = Date.Now.ToString("M/d/yyyy")
        End If
        If txtEndDate.Text = "1/1/1900" Then
            txtEndDate.Text = Date.Now.AddYears(10).ToString("M/d/yyyy")
        End If
        If txtMonthlyPrice.Text = "0.00" Or txtMonthlyPrice.Text = "" Then
            ddlProducts_SelectedIndexChanged()
        End If
        ' ClientScript.RegisterStartupScript(Me.GetType(), "disabledate", "disabledate();", True)
    End Sub
    Private Sub LoadTurnOff()
        'CV_StartDate.Enabled = False
        ddlProducts_SelectedIndexChanged()
        txtStartDate.Text = Date.Now.ToString("M/d/yyyy")
        LoadLicence()
        ddlStores.Enabled = False
        ddlProducts.Enabled = False
        ClientScript.RegisterStartupScript(Me.GetType(), "disabledate", "disabledate();", True)
        ClientScript.RegisterStartupScript(Me.GetType(), "disableenddate", "disableenddate();", True)
        txtMonthlyPrice.ReadOnly = True
        lblnotes.InnerText = "Reason to Turn Off"
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim returnVal As Integer = 0
        If Page.IsValid Then
            Dim onsupport As Boolean = True
            If (hdnMode.Value = "" Or hdnMode.Value = "signup") Then
                'SignUp Mode
                onsupport = True
                Dim objProductFranchises As New Portal.BLL.NS.NS_Products_Franchises
                Dim str As String() = ddlStores.Value.Split(",")
                With objProductFranchises
                    .ProductID = ddlProducts.SelectedValue
                    .FranchiseID = str(0) 'ddlStores.SelectedValue
                    .onSupport = onsupport
                    .SupportStartDate = txtStartDate.Text
                    .SupportEnddate = txtEndDate.Text
                    .UpdatedBy = Session("AdminID")
                    .UpdatedOn = DateTime.Now
                    .Inactive = False
                    .Notes = txtNotes.Text.Trim
                    .Price = txtMonthlyPrice.Text
                    If (CInt(ddlProducts.SelectedValue) = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) Then
                        .NoOfLicenses = txtNofLicenses.Text.Trim()
                    Else
                        .NoOfLicenses = Integer.MinValue
                    End If
                    returnVal = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesAdd(.ProductID, .FranchiseID, .onSupport, .SupportStartDate, .SupportEnddate, .UpdatedBy, .UpdatedOn, .Inactive, .Notes, .Price, .NoOfLicenses)
                End With
            ElseIf (hdnMode.Value = "turnon") Then
                'Turn On Support Mode
                onsupport = True
                returnVal = Portal.BLL.NS.NS_Products_Franchises_Extentions.NS_Products_Franchises_ExtentionsAdd(0, hdnProductID.Value, hdnFranchiseID.Value, txtStartDate.Text, txtEndDate.Text, hdnSupportStartDate.Value, hdnSupportEndDate.Value, Session("AdminID"), Date.Now, txtMonthlyPrice.Text, onsupport, Portal.BLL.Enumeration.ProductFranchisesExt.TurnOn, txtNotes.Text.Trim)
                If (returnVal > 0) Then
                    Dim objProductFranchises As New Portal.BLL.NS.NS_Products_Franchises
                    Dim ID As Integer = Me.hdnNSProductFranchiseID.Value
                    Dim str As String() = ddlStores.Value.Split(",")
                    With objProductFranchises
                        .ID = ID
                        .ProductID = ddlProducts.SelectedValue
                        .FranchiseID = str(0) 'ddlStores.SelectedValue
                        .onSupport = onsupport
                        .SupportStartDate = txtStartDate.Text
                        .SupportEnddate = txtEndDate.Text
                        .UpdatedBy = Session("AdminID")
                        .UpdatedOn = DateTime.Now
                        .Inactive = False
                        If (CInt(ddlProducts.SelectedValue) = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) Then
                            .NoOfLicenses = txtNofLicenses.Text.Trim()
                        Else
                            .NoOfLicenses = Integer.MinValue
                        End If
                        .Notes = txtNotes.Text.Trim
                        .Price = txtMonthlyPrice.Text
                        returnVal = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesUpdateSupport(.ID, .onSupport, .SupportStartDate, .SupportEnddate, .UpdatedBy, .UpdatedOn, .Inactive, .Notes, .Price, .NoOfLicenses)
                    End With
                End If
            ElseIf (hdnMode.Value = "turnoff") Then
                'turn off Mode
                onsupport = False
                returnVal = Portal.BLL.NS.NS_Products_Franchises_Extentions.NS_Products_Franchises_ExtentionsAdd(0, hdnProductID.Value, hdnFranchiseID.Value, txtStartDate.Text, txtEndDate.Text, hdnSupportStartDate.Value, hdnSupportEndDate.Value, Session("AdminID"), Date.Now, txtMonthlyPrice.Text, onsupport, Portal.BLL.Enumeration.ProductFranchisesExt.TurnOff, txtNotes.Text.Trim)
                If (returnVal > 0) Then
                    Dim objProductFranchises As New Portal.BLL.NS.NS_Products_Franchises
                    Dim ID As Integer = Me.hdnNSProductFranchiseID.Value
                    Dim str As String() = ddlStores.Value.Split(",")
                    With objProductFranchises
                        .ID = ID
                        .ProductID = ddlProducts.SelectedValue
                        .FranchiseID = str(0) 'ddlStores.SelectedValue
                        .onSupport = onsupport
                        .SupportStartDate = txtStartDate.Text
                        .SupportEnddate = txtEndDate.Text
                        .UpdatedBy = Session("AdminID")
                        .UpdatedOn = DateTime.Now
                        .Inactive = False                        
                        If (CInt(ddlProducts.SelectedValue) = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) Then
                            .NoOfLicenses = txtNofLicenses.Text.Trim()
                        Else
                            .NoOfLicenses = Integer.MinValue
                        End If
                        .Notes = txtNotes.Text.Trim
                        .Price = txtMonthlyPrice.Text
                        returnVal = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesUpdateSupport(.ID, .onSupport, .SupportStartDate, .SupportEnddate, .UpdatedBy, .UpdatedOn, .Inactive, .Notes, .Price, .NoOfLicenses)
                    End With
                End If
            ElseIf (hdnMode.Value = "edit") Or (hdnMode.Value = "extendsupport") Then
                'Edit Mode
                onsupport = True
                'Dim objProductFranchisesBackup As New Portal.BLL.NS.NS_Products_Franchises
                'returnVal = Portal.BLL.NS.NS_Products_Franchises.NS_Products_Franchises_Extentions_Add(me.hdnNSProductFranchiseID.Value , txtEndDate.Text)
                returnVal = Portal.BLL.NS.NS_Products_Franchises_Extentions.NS_Products_Franchises_ExtentionsAdd(0, hdnProductID.Value, hdnFranchiseID.Value, txtStartDate.Text, txtEndDate.Text, hdnSupportStartDate.Value, hdnSupportEndDate.Value, Session("AdminID"), Date.Now, txtMonthlyPrice.Text, onsupport, Portal.BLL.Enumeration.ProductFranchisesExt.Edit, txtNotes.Text.Trim)
                If (returnVal > 0) Then
                    Dim objProductFranchises As New Portal.BLL.NS.NS_Products_Franchises
                    Dim ID As Integer = Me.hdnNSProductFranchiseID.Value
                    Dim str As String() = ddlStores.Value.Split(",")
                    With objProductFranchises
                        .ID = ID
                        .ProductID = ddlProducts.SelectedValue
                        .FranchiseID = str(0) 'ddlStores.SelectedValue
                        .onSupport = onsupport
                        .SupportStartDate = txtStartDate.Text
                        .SupportEnddate = txtEndDate.Text
                        .UpdatedBy = Session("AdminID")
                        .UpdatedOn = DateTime.Now
                        .Inactive = False
                        If (CInt(ddlProducts.SelectedValue) = Portal.BLL.Enumeration.NSProductIDs.ESETAntiVirus) Then
                            .NoOfLicenses = txtNofLicenses.Text.Trim()
                        Else
                            .NoOfLicenses = Integer.MinValue
                        End If
                        .Notes = txtNotes.Text.Trim
                        .Price = txtMonthlyPrice.Text
                        returnVal = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesUpdateSupport(.ID, .onSupport, .SupportStartDate, .SupportEnddate, .UpdatedBy, .UpdatedOn, .Inactive, .Notes, .Price, .NoOfLicenses)
                    End With
                End If

            End If
            ' Now update through web services on Fransupport End.
            Dim client As String() = ddlStores.Value.Split(",")
            Dim FranFranchiseID As Integer = Portal.BLL.Franchises.GetFransupportFranchiseID(CInt(client(0))) ' client(0) is the franchise ID


            Dim srvPortal As New WS_Fransupport.WS_Portal

            'Dim authCode As String = ConfigurationManager.AppSettings("PortalServiceAuthCode").Trim
            Dim AffectedSecond As Integer = 0

            ''If client(1) = 1 AndAlso ConfigurationManager.AppSettings("SMS_SupportID") = ddlProducts.SelectedValue Then
            ''    AffectedSecond = srvPortal.Franchisee_SMSSupportInfoUpdate(authCode, FranFranchiseID, onsupport, txtStartDate.Text, txtEndDate.Text, txtMonthlyPrice.Text)
            ''ElseIf client(1) = 1 AndAlso ConfigurationManager.AppSettings("SMS_BackSupportID") = ddlProducts.SelectedValue Then
            ''    AffectedSecond = srvPortal.Franchisee_SMS_BackUp_SupportInfoUpdate(authCode, FranFranchiseID, onsupport, txtStartDate.Text)
            ''End If

            If (returnVal > 0) Then
                ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
            End If
        Else
            ClientScript.RegisterStartupScript(Me.GetType(), "CheckSelectedProduct", "ddlProducts_OnChange();", True)
        End If
    End Sub


    'Protected Sub CV_CheckReportRecord_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CV_CheckReportRecord.ServerValidate
    '    Dim str As String() = ddlStores.Value.Split(",")
    '    If (Request.QueryString("Mode") <> Nothing AndAlso Request.QueryString("Mode").ToLower = "edit") Then
    '        If Portal.BLL.NS.NS_Products_Franchises.NS_Products_CheckFranchisesInReportRecords(str(0)) = 0 Then
    '            args.IsValid = True
    '        Else
    '            args.IsValid = False
    '        End If
    '    Else
    '        args.IsValid = True
    '    End If
    'End Sub
    Protected Sub CVS_StartDate_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CVS_StartDate.ServerValidate
        Dim str As String() = ddlStores.Value.Split(",")
        If (hdnMode.Value = "edit" Or hdnMode.Value = "" Or hdnMode.Value = "signup") Then
            Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
            objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_CheckDatesInReportDeatil(str(0), ddlProducts.SelectedValue)
            If objNS_Products_Franchises.SupportStartDate <> Date.Now.ToString("M/d/yyyy") Then
                If CDate(txtStartDate.Text) <= CDate(objNS_Products_Franchises.SupportStartDate.ToString("M/d/yyyy")) Then
                    args.IsValid = True
                Else
                    args.IsValid = False
                    CVS_StartDate.ErrorMessage = "Start date must be less than " & objNS_Products_Franchises.SupportStartDate.ToString("M/d/yyyy")
                End If
            Else
                args.IsValid = True
            End If
        End If
    End Sub
    Protected Sub CVS_EndDate_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CVS_EndDate.ServerValidate
        Dim str As String() = ddlStores.Value.Split(",")
        If (hdnMode.Value = "edit" Or hdnMode.Value = "" Or hdnMode.Value = "signup") Then
            Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
            objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_CheckDatesInReportDeatil(str(0), ddlProducts.SelectedValue)
            If objNS_Products_Franchises.SupportStartDate <> Date.Now.ToString("M/d/yyyy") Then
                If CDate(txtEndDate.Text) > CDate(objNS_Products_Franchises.SupportEnddate.ToString("M/d/yyyy")) Then
                    args.IsValid = True
                Else
                    args.IsValid = False
                    CVS_EndDate.ErrorMessage = "End date must be greater than " & objNS_Products_Franchises.SupportEnddate.ToString("M/d/yyyy")
                End If
            Else
                args.IsValid = True
            End If
        End If
    End Sub
    Protected Sub CV_CheckDuplicateProduct_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CV_CheckDuplicateProduct.ServerValidate
        Dim str As String() = ddlStores.Value.Split(",")
        If Portal.BLL.NS.NS_Products_Franchises.NS_Products_CheckDuplicateProduct(ddlProducts.SelectedValue, str(0)) = 0 Then
            args.IsValid = True
        ElseIf (hdnMode.Value = "extendsupport") Then
            args.IsValid = True
        ElseIf (hdnMode.Value = "turnon") Then
            args.IsValid = True
        ElseIf (hdnMode.Value = "turnoff") Then
            args.IsValid = True
        ElseIf (hdnMode.Value = "edit") Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub
    Protected Sub CV_CheckParentProduct_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CV_CheckParentProduct.ServerValidate
        Dim str As String() = ddlStores.Value.Split(",")
        If Portal.BLL.NS.NS_Products_Franchises.NS_Products_CheckParentProduct(ddlProducts.SelectedValue, str(0)) > 0 Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    'Protected Sub ddlClient_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlClient.SelectedIndexChanged
    '    If ddlClient.SelectedValue > 0 Then
    '        ddlProducts.DataSourceID = SDS_ProductsSupport.ID
    '        ddlProducts.DataBind()
    '    Else
    '        ddlProducts.Items.Clear()
    '        ddlProducts.Items.Insert(0, New ListItem("Select...", "0"))
    '    End If
    'End Sub


    Protected Sub ddlStores_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlStores.ItemsRequested
        LoadStores(0, 0, e.Text)
    End Sub
    Private Sub LoadStores(ByVal FranchiseID As Integer, ByVal ClientID As Integer, ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@ClientID", ClientID)
        db.AddParameter("@FranchiseID", FranchiseID)
        db.AddParameter("@Search", byvalsearch)
        dt = db.ExecuteDataTable("Franchises_GetByClientID_ForRadCombo")
        ddlStores.DataSource = dt
        ddlStores.DataBind()
    End Sub
    Private Sub RadComboBox1_ItemDataBound(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemDataBoundEventArgs) Handles ddlStores.ItemDataBound
        e.Item.Text = CType(e.Item.DataItem, System.Data.DataRowView)("StoreNick").ToString() + ", " + CType(e.Item.DataItem, System.Data.DataRowView)("ClientCode").ToString()
    End Sub

    Protected Sub ddlStores_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlStores.SelectedIndexChanged
        ddlStores_SelectedIndexChanged()
    End Sub
    Protected Sub ddlStores_SelectedIndexChanged()
        Dim str As String() = ddlStores.Value.Split(",")
        If IsNumeric(str(0)) AndAlso str(0) > 0 Then
            SDS_ProductsSupport.SelectParameters("ClientID").DefaultValue = str(1)
            ddlProducts.DataSourceID = SDS_ProductsSupport.ID
            ddlProducts.DataBind()
        Else
            ddlProducts.Items.Clear()
            ddlProducts.Items.Insert(0, New ListItem("Select...", "0"))
        End If
        txtMonthlyPrice.Text = ""
    End Sub
    Protected Sub ddlProducts_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.SelectedIndexChanged
        ddlProducts_SelectedIndexChanged()
    End Sub
    Protected Sub ddlProducts_SelectedIndexChanged()
        Dim str As String() = ddlStores.Value.Split(",")
        If IsNumeric(str(0)) AndAlso str(0) > 0 Then
            Dim objNS_Products_Franchises As New Portal.BLL.NS.NS_Products_Franchises
            objNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetByFranID_ProductID(str(0), ddlProducts.SelectedValue)
            If objNS_Products_Franchises.ID > 0 Then
                hdnNSProductFranchiseID.Value = objNS_Products_Franchises.ID
                LoadLicence()
                If hdnMode.Value <> "turnoff" Then
                    If hdnOnSupport.Value Then
                        hdnMode.Value = "edit"
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SettingMode", "parent.SettingMode('edit');", True)
                    Else
                        hdnMode.Value = "turnon"
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SettingMode", "parent.SettingMode('turnon');", True)
                    End If
                End If
            Else
                Dim colNS_Products_Clients As New System.Collections.Generic.List(Of Portal.BLL.NS.NS_Products_Clients)()
                colNS_Products_Clients = Portal.BLL.NS.NS_Products_Clients.NS_Products_ClientsGetByClientID(str(1), ddlProducts.SelectedValue)
                If colNS_Products_Clients.Count = 1 Then
                    txtMonthlyPrice.Text = FormatNumber(colNS_Products_Clients.Item(0).Price, 2)
                Else
                    txtMonthlyPrice.Text = ""
                End If
                txtStartDate.Text = ""
                txtEndDate.Text = ""
                txtNotes.Text = ""
                If hdnMode.Value <> "turnoff" Then
                    hdnMode.Value = "signup"
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "SettingMode", "parent.SettingMode('signup');", True)
                End If
            End If
        End If
    End Sub
End Class
