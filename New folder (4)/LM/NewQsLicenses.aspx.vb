
Partial Class LM_NewQsLicenses
    Inherits System.Web.UI.Page
    Public Enum Qsbubdle
        Server = 0
        Drawer1 = 1
        Drawer2 = 2
    End Enum
    Dim LicensesIdForIPExists As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'ddlProducts.Items.Insert(0, New ListItem("nXstep", Portal.BLL.Enumeration.NSProductIDs.nXstep))
            ddlStores.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Search...", "0"))
        End If
    End Sub
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Private Sub LoadStores(ByVal byvalsearch As String)
        Try
            Dim db As New DBAccess
            Dim dt As System.Data.DataTable
        db.AddParameter("@ClientID", 0)
            db.AddParameter("@FranchiseID", 0)
            db.AddParameter("@Search", byvalsearch)
        db.AddParameter("@UserID", Session("AdminID"))
        'dt = db.ExecuteDataTable("Franchises_GetByClientID_ForRadCombo") OLD
        dt = db.ExecuteDataTable("Franchises_GetByClientAndUserAccess_ForRadCombo") 'NEW
            ddlStores.DataSource = dt
            ddlStores.DataBind()

        Catch ex As Exception

        End Try


    End Sub
Private Sub LoadStores_SuperUser(ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@ClientID", 0)
        db.AddParameter("@FranchiseID", 0)
        db.AddParameter("@Search", byvalsearch)
        dt = db.ExecuteDataTable("Franchises_GetByClientID_ForRadCombo") 'OLD

        ddlStores.DataSource = dt
        ddlStores.DataBind()
    End Sub
    Dim StoreNo As Integer
    Dim ClientID As Integer



    Private Sub RadComboBox1_ItemDataBound(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemDataBoundEventArgs) Handles ddlStores.ItemDataBound
        Try
            e.Item.Text = CType(e.Item.DataItem, System.Data.DataRowView)("StoreNick").ToString() + ", " + CType(e.Item.DataItem, System.Data.DataRowView)("ClientCode").ToString()

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub ddlStores_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlStores.ItemsRequested
        Try
            If Functions.IsSuperAdmin(CInt(Session("AdminID"))) Then

                LoadStores_SuperUser(e.Text)
            Else
            LoadStores(e.Text)
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub ClearFields()
        txtQuantity.Text = ""
        txt_DynimicIP.Text = ""
        txt_StaticIP.Text = ""
        txtInvoiceNo.Text = ""
        txtNotes.Text = ""
        ddlStores.Value = ""
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim objQs As New Portal.BLL.QsLicenseManagment
        Dim LicenseID As Integer = 0
        Dim isError As Boolean = False
        Dim str As String() = ddlStores.Value.Split(",")
        Dim LicenseCount As Integer = 0
        LicenseCount = 0'Portal.BLL.SMSXLicenseManagement.GetStoreLicensesCount(str(0), str(1))
        If LicenseCount > 0 Then
            ClientScript.RegisterStartupScript(Me.GetType(), "ShowAdditionalError", "document.getElementById('trAlreadyLicense').style.display='inline'", True)
            Return
        End If
        'objLM.InVoiceNo = txtInvoiceNo.Text.Trim()
        objQs.ClientID = CInt(str(1))
        ClientID = CInt(str(1))
        'objLM.ProductID = CInt(ddlProducts.SelectedValue)
        objQs.StoreNo = CInt(str(0))
        objQs.Notes = txtNotes.Text.Trim()
        objQs.IssuedByID = CInt(Session("AdminID"))
        'objSMSXLM.FranchiseID = CInt(Session("FranchiseID"))
        'objLM.CurrentVersion = ConfigurationManager.AppSettings("nXtepversion")
        'If static ip is selected then we are going to save static ip
        'Other wise dynamic ip will be used for a particular date.
        If (rdoIP.Items(0).Selected) Then
            objQs.SystemIP = txt_StaticIP.Text.Trim()
            objQs.IsDynamicIP = False
            objQs.DynamicIPEndDate = Date.MinValue
        Else
            objQs.SystemIP = String.Empty
            objQs.IsDynamicIP = True
            objQs.DynamicIPEndDate = Request(txt_DynimicIP.UniqueID).Trim()
        End If

        If ddlProducts.SelectedValue = 1 Then
            Dim ResultIPAvaibability As Boolean
            If txt_StaticIP.Text.Trim <> "" Then
                If hdnLicensesID.Value <> "" Then
                    LicensesIdForIPExists = CInt(hdnLicensesID.Value.ToString.Trim())
                Else
                    LicensesIdForIPExists = 0
                End If
                ResultIPAvaibability = objQs.CheckSystemIPAvailability(txt_StaticIP.Text.Trim(), LicensesIdForIPExists)
            Else
                ResultIPAvaibability = False
            End If

            If ResultIPAvaibability = False Then
                Dim Result As Integer = objQs.CheckBundleAvailability(objQs.ClientID, objQs.StoreNo)
                If (Result = 0) Then
                    LicenseID = objQs.AddQsLicense()
                    Dim ReturnValue As Integer
                    If (LicenseID > 0) Then
                        If ddlProducts.SelectedValue = 1 Then
                            Dim i As Integer = 0
                            For i = 0 To 2
                                Dim TerminalNames As String() = [Enum].GetNames(GetType(Qsbubdle))
                                Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                                objQsLMs.TerminalName = TerminalNames(i)
                                objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                objQsLMs.IssuedByID = CInt(Session("AdminID"))
                                objQsLMs.LicenseID = CInt(LicenseID)
                                ReturnValue = objQsLMs.AddQSLicenseTerminals()
                            Next
                        ElseIf ddlProducts.SelectedValue = 2 Then
                            Dim Quantity As Integer = txtQuantity.Text
                            Dim i As Integer = 0
                            For i = 1 To Quantity
                                ' Dim TerminalNames As String() = [Enum].GetNames(GetType(SMSXbubdle))
                                Dim objQSMs As New Portal.BLL.QsLicenseManagment
                                objQSMs.TerminalName = "Additional"
                                objQSMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                objQSMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                objQSMs.IssuedByID = CInt(Session("AdminID"))
                                objQSMs.LicenseID = CInt(LicenseID)
                                ReturnValue = objQSMs.AddQSLicenseTerminals()
                            Next
                        End If


                        If (ReturnValue > 0) Then

                            'Dim objPortal As New WS_Fransupport.WS_Portal
                            'objPortal.WS_Portal_Franchises_HasSMSX(objQs.StoreNo)
                            ClearFields()
                            ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                            ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
                        End If

                    End If
                ElseIf (Result = 2) Then
                    isError = True
                    ClientScript.RegisterStartupScript(Me.GetType(), "ShowError", "ShowBundleError();", True)
                Else
                    Dim ReturnValue As Integer
                    If Result > 0 Then
                        LicenseID = Result
                        Dim i As Integer = 0
                        For i = 0 To 2
                            Dim TerminalNames As String() = [Enum].GetNames(GetType(Qsbubdle))
                            Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                            objQsLMs.TerminalName = TerminalNames(i)
                            objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                            objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                            objQsLMs.IssuedByID = CInt(Session("AdminID"))
                            objQsLMs.LicenseID = CInt(Result)
                            ReturnValue = objQsLMs.AddQSLicenseTerminals()
                        Next
                    End If
                    If (ReturnValue > 0) Then
                        ClearFields()
                        ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                        ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
                    End If
                End If
            Else
                isError = True
                ClientScript.RegisterStartupScript(Me.GetType(), "ShowError", "ShowSystemIPExists();", True)
            End If

        Else
            Dim intLicenseId As Integer = objQs.CheckAdditinalAvailability(objQs.ClientID, objQs.StoreNo)
            If intLicenseId < 0 Then
                ClientScript.RegisterStartupScript(Me.GetType(), "showNoserverError", "showNoserverError();", True)
                Return
            End If
            If rdoIP.SelectedValue = 0 Then

                Dim StaticIPResult = objQs.CheckStaticIPAvailability(objQs.ClientID, objQs.StoreNo, objQs.SystemIP)
                If StaticIPResult = 1 Then
                    isError = True
                    ClientScript.RegisterStartupScript(Me.GetType(), "ShowError", "ShowStaticIpExits();", True)
                End If
                If StaticIPResult = -2 Then
                    isError = True
                    ClientScript.RegisterStartupScript(Me.GetType(), "ShowError", "ShowStaticIpError();", True)
                ElseIf StaticIPResult = 2 Or StaticIPResult = -3 Then
                    Dim OutPutID As Integer = objQs.CheckAdditinalAvailability(objQs.ClientID, objQs.StoreNo)
                    If OutPutID > 0 Then
                        LicenseID = OutPutID
                        Dim Notes As String = ""
                        Dim Quantity As Integer = txtQuantity.Text
                        Dim i As Integer = 0
                        For i = 1 To Quantity
                            ' Dim TerminalNames As String() = [Enum].GetNames(GetType(SMSXbubdle))
                            Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                            objQsLMs.TerminalName = "Additional"
                            objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                            objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                            objQsLMs.IssuedByID = CInt(Session("AdminID"))
                            objQsLMs.LicenseID = CInt(OutPutID)
                            Notes = txtNotes.Text
                            objQsLMs.AddQSLicenseTerminals()
                        Next

                        Dim objQsLicenseManagement As New Portal.BLL.QsLicenseManagment
                        objQsLicenseManagement.UpdateQsLicenseLog(CInt(Session("AdminID")), CInt(OutPutID), Notes)

                        ClearFields()
                        ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                        ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)

                    Else
                        LicenseID = objQs.AddQsLicense()
                        Dim ReturnValue As Integer
                        If (LicenseID > 0) Then
                            If ddlProducts.SelectedValue = 1 Then
                                Dim i As Integer = 0
                                For i = 0 To 2
                                    Dim TerminalNames As String() = [Enum].GetNames(GetType(Qsbubdle))
                                    Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                                    objQsLMs.TerminalName = TerminalNames(i)
                                    objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                    objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                    objQsLMs.IssuedByID = CInt(Session("AdminID"))
                                    objQsLMs.LicenseID = CInt(LicenseID)
                                    ReturnValue = objQsLMs.AddQSLicenseTerminals()
                                Next
                            ElseIf ddlProducts.SelectedValue = 2 Then
                                Dim Quantity As Integer = txtQuantity.Text
                                Dim i As Integer = 0
                                For i = 1 To Quantity
                                    ' Dim TerminalNames As String() = [Enum].GetNames(GetType(SMSXbubdle))
                                    Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                                    objQsLMs.TerminalName = "Additional"
                                    objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                    objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                    objQsLMs.IssuedByID = CInt(Session("AdminID"))
                                    objQsLMs.LicenseID = CInt(LicenseID)
                                    ReturnValue = objQsLMs.AddQSLicenseTerminals()
                                Next
                            End If


                            If (ReturnValue > 0) Then
                                ClearFields()
                                ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                                ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
                            End If
                        End If
                    End If
                ElseIf StaticIPResult = -4 Then
                    'ClientScript.RegisterStartupScript(Me.GetType(), "DynamicIPExits", "DynamicIPExitsError();", True)
                    Dim OutPutID As Integer = objQs.CheckAdditinalAvailability(objQs.ClientID, objQs.StoreNo)
                    If OutPutID > 0 Then

                        Dim Quantity As Integer = txtQuantity.Text
                        Dim i As Integer = 0
                        For i = 1 To Quantity
                            ' Dim TerminalNames As String() = [Enum].GetNames(GetType(SMSXbubdle))
                            Dim objqsXLMs As New Portal.BLL.QsLicenseManagment
                            objqsXLMs.TerminalName = "Additional"
                            objqsXLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                            objqsXLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                            objqsXLMs.IssuedByID = CInt(Session("AdminID"))
                            objqsXLMs.LicenseID = CInt(OutPutID)
                            objqsXLMs.AddQSLicenseTerminals()
                        Next

                        Dim objQsIP As New Portal.BLL.QsLicenseManagment
                        objQsIP.UpdateDynamicIPToStaticIP(CInt(Session("AdminID")), CInt(OutPutID), txt_StaticIP.Text, txtNotes.Text)

                        ClearFields()
                        ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                        ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
                    Else
                        LicenseID = objQs.AddQsLicense()
                        Dim ReturnValue As Integer
                        If (LicenseID > 0) Then
                            If ddlProducts.SelectedValue = 1 Then
                                Dim i As Integer = 0
                                For i = 0 To 2
                                    Dim TerminalNames As String() = [Enum].GetNames(GetType(Qsbubdle))
                                    Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                                    objQsLMs.TerminalName = TerminalNames(i)
                                    objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                    objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                    objQsLMs.IssuedByID = CInt(Session("AdminID"))
                                    objQsLMs.LicenseID = CInt(LicenseID)
                                    ReturnValue = objQsLMs.AddQSLicenseTerminals()
                                Next
                            ElseIf ddlProducts.SelectedValue = 2 Then
                                Dim Quantity As Integer = txtQuantity.Text
                                Dim i As Integer = 0
                                For i = 1 To Quantity
                                    ' Dim TerminalNames As String() = [Enum].GetNames(GetType(SMSXbubdle))
                                    Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                                    objQsLMs.TerminalName = "Additional"
                                    objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                    objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                    objQsLMs.IssuedByID = CInt(Session("AdminID"))
                                    objQsLMs.LicenseID = CInt(LicenseID)
                                    ReturnValue = objQsLMs.AddQSLicenseTerminals()
                                Next
                            End If


                            If (ReturnValue > 0) Then
                                ClearFields()
                                ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                                ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
                            End If
                        End If
                    End If
                End If
            Else
                Dim StaticIPExits As Integer = objQs.CheckStaticIPExits(objQs.ClientID, objQs.StoreNo)
                If StaticIPExits = 1 Then
                    isError = True
                    ClientScript.RegisterStartupScript(Me.GetType(), "ShowStaticIpExits", "ShowStaticIpExits();", True)
                End If
                If StaticIPExits = 2 Then
                    Dim OutPutID As Integer = objQs.CheckAdditinalAvailability(objQs.ClientID, objQs.StoreNo)
                    If OutPutID > 0 Then
                        LicenseID = OutPutID
                        Dim Quantity As Integer = txtQuantity.Text
                        Dim i As Integer = 0
                        For i = 1 To Quantity
                            ' Dim TerminalNames As String() = [Enum].GetNames(GetType(SMSXbubdle))
                            Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                            objQsLMs.TerminalName = "Additional"
                            objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                            objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                            objQsLMs.IssuedByID = CInt(Session("AdminID"))
                            objQsLMs.LicenseID = CInt(OutPutID)
                            objQsLMs.AddQSLicenseTerminals()
                        Next

                        'Dim objSMSXLicenseManagement As New Portal.BLL.SMSXLicenseManagement
                        'objSMSXLicenseManagement.UpdateDynamicIPToStaticIP(CInt(Session("AdminID")), CInt(OutPutID), txt_StaticIP.Text, txtNotes.Text)

                        ClearFields()
                        ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                        ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
                        'isError = True
                        'ClientScript.RegisterStartupScript(Me.GetType(), "ShowStaticIpExits", "ShowStaticIpExits();", True)
                    End If
                End If
                If StaticIPExits = -2 Then

                    LicenseID = objQs.AddQsLicense()
                    Dim ReturnValue As Integer
                    If (LicenseID > 0) Then
                        If ddlProducts.SelectedValue = 1 Then
                            Dim i As Integer = 0
                            For i = 0 To 2
                                Dim TerminalNames As String() = [Enum].GetNames(GetType(Qsbubdle))
                                Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                                objQsLMs.TerminalName = TerminalNames(i)
                                objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                objQsLMs.IssuedByID = CInt(Session("AdminID"))
                                objQsLMs.LicenseID = CInt(LicenseID)
                                ReturnValue = objQsLMs.AddQSLicenseTerminals()
                            Next
                        ElseIf ddlProducts.SelectedValue = 2 Then
                            Dim Quantity As Integer = txtQuantity.Text
                            Dim i As Integer = 0
                            For i = 1 To Quantity
                                ' Dim TerminalNames As String() = [Enum].GetNames(GetType(SMSXbubdle))
                                Dim objQsLMs As New Portal.BLL.QsLicenseManagment
                                objQsLMs.TerminalName = "Additional"
                                objQsLMs.InVoiceNo = txtInvoiceNo.Text.Trim()
                                objQsLMs.CurrentVersion = ConfigurationManager.AppSettings("QsVersion")
                                objQsLMs.IssuedByID = CInt(Session("AdminID"))
                                objQsLMs.LicenseID = CInt(LicenseID)
                                ReturnValue = objQsLMs.AddQSLicenseTerminals()
                            Next
                        End If


                        If (ReturnValue > 0) Then
                            ClearFields()
                            ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
                            ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
                        End If
                    End If
                End If

            End If

        End If

        If (isError = False) Then
            If objQs.ClientID = Portal.BLL.Enumeration.ClientID.SaladCreation Then
                Dim NoOfTerminals As Integer = Portal.DAL.QsLicenseManagment.GetTotalNoOfTerminalsByStoreNumber(objQs.StoreNo)
                Dim serSaladCreation As New SaladCreation.Service
                serSaladCreation.UpdateFranchiseTerminals(objQs.StoreNo, NoOfTerminals)
            End If
        End If
        '    'Setting up the security code 
        '    Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
        '    Dim dsLicenseDetail As Data.DataSet = Portal.DAL.QsLicenseManagment.GetLicenseDetailForWebService(LicenseID)
        '    dsLicenseDetail.DataSetName = "SMSXLicense"
        '    dsLicenseDetail.Tables(0).TableName = "License"
        '    dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
        '    securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))
        '    ' SendMail(LicenseID)
        'AddActivity(objQs.StoreNo, LicenseID, objQs.StoreNick, objQs.ClientID)
        '    Try
        '        'Update the details in the sms db via webservice.
        '        Dim objSMSWebservice As New se.PortalServices
        '        Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
        '    Catch ex As Exception
        '        ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddSMSXLicense", String.Empty, String.Empty, String.Empty)
        '    End Try
        'End If
    End Sub
    'Public Function SendMail(ByVal LicenseID As Integer)
    '    Dim strText As String = GetLetterText()
    '    Dim strEmail As New StringBuilder
    '    Dim DrEmail As Data.SqlClient.SqlDataReader = Portal.BLL.QsLicenseManagment.GetAllQsLicensesTerminalForEmailByLicienceID(LicenseID)
    '    While DrEmail.Read
    '        strEmail.Append("<tr>")
    '        strEmail.Append("<td style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-weight:bold;font-size:10px;'>" & DrEmail("TerminalName") & "</td>")
    '        strEmail.Append("<td  style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-size:10px;'>" & DrEmail("GUID_Activation") & "</td>")
    '        strEmail.Append("<td  style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-size:10px;'>" & DrEmail("GUID_Installation") & "</td>")
    '        strEmail.Append("</tr>")
    '    End While
    '    DrEmail.Close()
    '    strText = strText.Replace("******Activate******", strEmail.ToString)
    '    strText = strText.Replace("*****span*****", ConfigurationManager.AppSettings("SMS-XDowloadURL") & "?span=" & Functions.EncryptData(Date.Now))
    '    strText = strText.Replace("*****RemindMe*****", ConfigurationManager.AppSettings("SMS-XRemindMe"))
    '    strText = strText.Replace("*****SMS-XIntroduction*****", ConfigurationManager.AppSettings("SMS-XIntroduction"))
    '    strText = strText.Replace("*****SMS-XUserGuide*****", ConfigurationManager.AppSettings("SMS-XIntroduction"))

    '    Dim objEmail As New Portal.BLL.Email
    '    With objEmail
    '        .DisplayName = Session("Admin_Name")
    '        .MailTo = "awakeel@netsolace.com.pk"
    '        .MailFrom = Session("Email")
    '        .Subject = "Master Login Information"
    '        .Detail = strText
    '        .Attachments = ""
    '        .Send_mail()
    '    End With

    '    objEmail = Nothing
    'End Function
    Private Function GetLetterText() As String
        Dim objStreamReader As IO.StreamReader
        Dim strReturn As String = String.Empty
        If IO.File.Exists(MapPath("../templates/SMSXActivation.htm")) Then
            objStreamReader = IO.File.OpenText(MapPath("../templates/SMSXActivation.htm"))
            strReturn = objStreamReader.ReadToEnd
            objStreamReader.Close()
        End If
        Return strReturn
    End Function
    Function AddActivity(ByVal StoreNo As String, ByVal LicenseId As Integer, ByVal StoreName As String, ByVal ClientID As Integer)
        ''Dim objTicketsBLL As New Portal.BLL.PM.PM_Ticket_Features
        Dim strTerminals As New StringBuilder

        Dim DrTerminalDetail As Data.SqlClient.SqlDataReader = Portal.BLL.QsLicenseManagment.GetAllQsLicensesTerminalForEmailByLicienceIDForActivity(LicenseId)
        strTerminals.Append("<table style='border: 2px solid #17415a' cellpadding='0' cellspacing='0'>")
        strTerminals.Append("<tr>")
        strTerminals.Append("<td style='position:relative;height:20px;padding-right:3px;padding-left:3px;font-size:10px;font-weight:bold;border-bottom:1px solid #9bb8c6;border-right:1px solid #9bb8c6;background-color:#dbedf9;text-align:left;'>Terminal Name</td>")
        strTerminals.Append("<td style='position:relative;height:20px;padding-right:3px;padding-left:3px;font-size:10px;font-weight:bold;border-bottom:1px solid #9bb8c6;border-right:1px solid #9bb8c6;background-color:#dbedf9;text-align:left;'>Activation Key</td>")
        strTerminals.Append("<td style='position:relative;height:20px;padding-right:3px;padding-left:3px;font-size:10px;font-weight:bold;border-bottom:1px solid #9bb8c6;border-right:1px solid #9bb8c6;background-color:#dbedf9;text-align:left;'>Installation Key</td>")
        strTerminals.Append("</tr>")
        While DrTerminalDetail.Read
            strTerminals.Append("<tr>")
            strTerminals.Append("<td style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-weight:bold;font-size:10px;'>" & DrTerminalDetail("TerminalName") & "</td>")
            strTerminals.Append("<td style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-weight:bold;font-size:10px;'>" & DrTerminalDetail("GUID_Activation") & "</td>")
            strTerminals.Append("<td style='border-right:1px solid #e0e7ed;border-bottom:1px solid #e0e7ed;height:22px;padding-right:3px;padding-left:3px;text-align:left;font-weight:bold;font-size:10px;'>" & DrTerminalDetail("GUID_Installation") & "</td>")
            strTerminals.Append("</tr>")
        End While
        strTerminals.Append("</table> <br>")
        DrTerminalDetail.Close()
        Dim drFranchises As Data.SqlClient.SqlDataReader = Portal.BLL.QsLicenseManagment.GETQsFranchiseIDByStoreNumber(StoreNo, ClientID)
        Dim FranchiseID As Integer
        Dim FranchiseContactID As Integer
        If drFranchises.Read Then
            FranchiseID = drFranchises("FranchiseId")
            FranchiseContactID = drFranchises("FranchiseContactsID")
        End If
        drFranchises.Close()

        Dim ObjectActivity As New Portal.BLL.Activities
        Dim ActivityID As Integer = 0
        With ObjectActivity
            .Subject = "New Qs License"
            .Type = Portal.BLL.Enumeration.ActivityType.Installation
            .SubType = Portal.BLL.Enumeration.ActivitySubType.Installation
            .TimeSpent = TimeSpan.Zero
            .FranchiseID = 0 'CInt(hdnFranchiseID.Value)
            .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
            .Description = "<strong> New Qs License terminals </strong><br><br>" & strTerminals.ToString
            .ActivityDate = DateTime.Now
            .ActivityState = Portal.BLL.Enumeration.ActivityState.NotStarted
            .RelatedTo = Portal.BLL.Enumeration.NSProductIDs.QS
            'If .RelatedTo = NotApplicable Then
            .ModuleId = Portal.BLL.Enumeration.Modules.Installation
            'Else
            '    .ModuleId = hdnSelectedModule.Value
            'End If
            .WaitingFor = "0"
            .Status = False
            .AdminInboxStatus = 0          'Making it closed in admin inbox status and status as closed.
            .PlacedBy = Portal.BLL.Enumeration.PlacedBy.PortalAdmin
            .UserID = CInt(Session("AdminID"))
            .FranchiseContactID = FranchiseContactID ' Portal.BLL.Enumeration.C
            .ClientContactID = 0
            .Priority = Portal.BLL.Enumeration.ActivityPriority.Minimal
            .ClientID = Portal.BLL.Enumeration.ClientID.EA
            .Charge = False
            .FranchiseID = FranchiseID
            .ActivitiesAdd(ObjectActivity)
        End With

    End Function


    Protected Sub ddlStores_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlStores.SelectedIndexChanged
        Try
            Dim var_staticIp As String = String.Empty
            Dim var_dynamicIp As String = String.Empty
            Dim str As String() = ddlStores.Value.Split(",")

            'objLM.InVoiceNo = txtInvoiceNo.Text.Trim()
            ClientID = CInt(Str(1))
            'objLM.ProductID = CInt(ddlProducts.SelectedValue)
            StoreNo = CInt(Str(0))
            Dim Dr As Data.SqlClient.SqlDataReader = Portal.BLL.QsLicenseManagment.GETQsIP(ClientID, StoreNo)
            If Dr.Read Then
                LicensesIdForIPExists = Dr("ID")
                var_staticIp = Dr("SystemIP")
                var_dynamicIp = Dr("DynamicIPEndDate")
            End If
            Dr.Close()
            hdnLicensesID.Value = LicensesIdForIPExists.ToString()
            If String.IsNullOrEmpty(var_staticIp) = False Or var_staticIp <> "" Then
                rdoIP.SelectedValue = "0"
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "OnChangeRadios", "OnChangeRadios(1)", True)
                txt_StaticIP.Text = ""
                txt_StaticIP.Text = var_staticIp
                txt_StaticIP.ReadOnly = True
                rdoIP.Enabled = False
            ElseIf String.IsNullOrEmpty(var_dynamicIp) = False Or var_dynamicIp <> "" Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "OnChangeRadios", "OnChangeRadios(2)", True)
                rdoIP.SelectedValue = "1"
                '  txt_StaticIP.Text = var_dynamicIp
                txt_DynimicIP.Text = var_dynamicIp
                '  txt_StaticIP.ReadOnly = True
                txt_DynimicIP.ReadOnly = True
                rdoIP.Enabled = False
            Else
                rdoIP.SelectedValue = "0"
                txt_StaticIP.Text = ""
                txt_StaticIP.ReadOnly = False
                rdoIP.Enabled = True
            End If

        Catch ex As Exception

        End Try

    End Sub

End Class