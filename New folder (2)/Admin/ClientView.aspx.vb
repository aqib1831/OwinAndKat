Imports Telerik.WebControls

Partial Class Admin_ManageClients
    Inherits System.Web.UI.Page
    Private itemcount As Integer = 0
    'Private dtNS_Products_Clients As New Data.DataTable("NS_Products_Clients")

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlClientCountry.DataBind()
            ddlContactCountry.DataBind()
            'CreateTableColumns()
            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                hdnClientID.Value = Request.QueryString("ClientID")
                EditMode()
            Else
                hdnClientID.Value = 0
                NewMode()
                lblTitle.Text = "Add New Client"
            End If
        End If
    End Sub
    'Private Sub CreateTableColumns()
    '    dtNS_Products_Clients.Columns.Add("ID", System.Type.GetType("System.Int32"))
    '    dtNS_Products_Clients.Columns.Add("ProductID", System.Type.GetType("System.Int32"))
    '    dtNS_Products_Clients.Columns.Add("ClientID", System.Type.GetType("System.Int32"))
    '    dtNS_Products_Clients.Columns.Add("BillTo", System.Type.GetType("System.Int32"))
    '    dtNS_Products_Clients.Columns.Add("CorporatePay", System.Type.GetType("System.Decimal"))
    '    dtNS_Products_Clients.Columns.Add("Deleted", System.Type.GetType("System.Boolean"))
    '    dtNS_Products_Clients.Columns.Add("Price", System.Type.GetType("System.Decimal"))
    '    dtNS_Products_Clients.Columns.Add("CorporatePayType", System.Type.GetType("System.Int32"))
    'End Sub

    Private Sub NewMode()
        'Client
        tblClientView.Visible = False
        tblClientNoRecord.Visible = True
        Me.lblClientViewTitle.Text = "Client Information"
        btnClientEdit.ImageUrl = "../images/btn_newBlue.gif"
        'Contact
        LoadContacts()
        'Subscribtion
        LoadSubscribtion()
    End Sub

    Private Sub EditMode()
        tblClientContactView.Visible = True
        LoadClient()
        LoadContacts()
        LoadSubscribtion()
    End Sub

#Region " Client "

    Private Sub LoadClient()
        Dim colClients As New System.Collections.Generic.List(Of Portal.BLL.Client.Clients)()
        colClients = Portal.BLL.Client.Clients.ClientsGetByID(CInt(hdnClientID.Value))
        If (colClients.Count > 0) Then
            tblClientView.Visible = True
            tblClientNoRecord.Visible = False
            Me.imgClientLogo.ImageUrl = ResolveClientUrl(ConfigurationManager.AppSettings("ClientImagesPath") & colClients.Item(0).logo)
            Me.hdnClientImagePath.Value = colClients.Item(0).logo
            Me.lblClientViewTitle.Text = colClients.Item(0).Name
            Me.lblTitle.Text = colClients.Item(0).Name
            Me.lblClientCode.Text = colClients.Item(0).Code
            Me.lblClientBillSendOption.Text = IIf(colClients.Item(0).BillsSendOption = 1, "By Post", "Email")
            Me.lblClientPrefPaymentMode.Text = IIf(colClients.Item(0).PreferredModePayment = 1, "Credit Card", IIf(colClients.Item(0).PreferredModePayment = 2, "Debit", "Bill"))
            Me.lblClientURL.Text = colClients.Item(0).url
            Me.lblClientCorporateEmail.Text = colClients.Item(0).Email
            Me.lblClientGeneralInformation.Text = colClients.Item(0).Address1 & ", " & colClients.Item(0).Address2 & ", " & colClients.Item(0).City & ", " & colClients.Item(0).StateCode & " " & colClients.Item(0).Zip & ", " & colClients.Item(0).CountryCode _
             & "<br />Tel: " & colClients.Item(0).Phone & _
            IIf(colClients.Item(0).Fax = "", "", " Fax: ") & colClients.Item(0).Fax
            btnClientEdit.ImageUrl = "../images/btn_edit.jpg"
        Else
            tblClientView.Visible = False
            tblClientNoRecord.Visible = True
        End If
    End Sub

    Protected Sub btnClientEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnClientEdit.Click
        tblClientContactView.Visible = False
        tblClientEdit.Visible = True
        tblContactEdit.Visible = False
        If hdnClientID.Value = 0 Then

        Else
            FillClient()
        End If
    End Sub

    Private Sub FillClient()
        Dim colClients As New System.Collections.Generic.List(Of Portal.BLL.Client.Clients)()
        colClients = Portal.BLL.Client.Clients.ClientsGetByID(CInt(hdnClientID.Value))
        If (colClients.Count > 0) Then
            Me.chkShowLogoNetWeb.Checked = colClients.Item(0).Isfeatured
            Me.imgClientEditLogo.ImageUrl = ResolveClientUrl(ConfigurationManager.AppSettings("ClientImagesPath") & colClients.Item(0).logo)
            Me.hdnClientImagePath.Value = colClients.Item(0).logo
            Me.lblClientEditTitle.Text = "Edit " & colClients.Item(0).Name
            Me.txtClientName.Text = colClients.Item(0).Name
            Me.txtClientCode.Text = colClients.Item(0).Code
            Me.txtAddress1.Text = colClients.Item(0).Address1
            Me.txtAddress2.Text = colClients.Item(0).Address2
            Me.txtCity.Text = colClients.Item(0).City
            Me.txtZip.Text = colClients.Item(0).Zip
            'ddlClientCountry.DataBind()
            Me.ddlClientCountry.SelectedValue = colClients.Item(0).CountryID
            ddlClientStates.DataBind()
            Me.ddlClientStates.SelectedValue = colClients.Item(0).StateID
            Me.txtPhone.Text = colClients.Item(0).Phone
            Me.txtFax.Text = colClients.Item(0).Fax
            Me.txtURL.Text = colClients.Item(0).url
            Me.txtCorporateEmail.Text = colClients.Item(0).Email
            Me.ddlBillSendOption.SelectedValue = colClients.Item(0).BillsSendOption
            Me.ddlPrefPaymentMode.SelectedValue = colClients.Item(0).PreferredModePayment

        End If
    End Sub

    Protected Sub btnClientSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnClientSave.Click
        If Page.IsValid Then
            Dim ClientsBll As New Portal.BLL.Client.Clients
            With ClientsBll
                .ID = hdnClientID.Value
                .Name = txtClientName.Text
                .Code = txtClientCode.Text
                .Phone = txtPhone.Text
                .Fax = txtFax.Text
                .Email = txtCorporateEmail.Text
                .Address1 = txtAddress1.Text
                .Address2 = txtAddress2.Text
                .City = txtCity.Text
                .Zip = txtZip.Text
                .StateID = ddlClientStates.SelectedValue
                .CountryID = ddlClientCountry.SelectedValue
                .Deleted = False
                .detail = ""
                .BillsSendOption = ddlBillSendOption.SelectedValue
                .PreferredModePayment = ddlPrefPaymentMode.SelectedValue
                .Isfeatured = chkShowLogoNetWeb.Checked
                .Image = ""
                .url = txtURL.Text
                .logo = hdnClientImagePath.Value
                If (hdnClientID.Value = 0) Then
                    hdnClientID.Value = Portal.BLL.Client.Clients.ClientsAdd(.ID, .Name, .Code, .Phone, .Fax, .Email, .Address1, .Address2, .City, .Zip, .StateID, .CountryID, .Deleted, .detail, .BillsSendOption, .PreferredModePayment, .Isfeatured, .Image, .url, .logo)
                Else
                    Portal.BLL.Client.Clients.ClientsUpdate(.ID, .Name, .Code, .Phone, .Fax, .Email, .Address1, .Address2, .City, .Zip, .StateID, .CountryID, .Deleted, .detail, .BillsSendOption, .PreferredModePayment, .Isfeatured, .Image, .url, .logo)
                End If
            End With
            LoadClient()
            tblClientContactView.Visible = True
            tblClientEdit.Visible = False
            tblContactEdit.Visible = False
        End If
    End Sub

    Protected Sub btnClientCancle_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnClientCancle.Click
        tblClientContactView.Visible = True
        tblClientEdit.Visible = False
        tblContactEdit.Visible = False
    End Sub

    Protected Sub ddlClientCountry_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlClientCountry.SelectedIndexChanged
        ddlClientStates.Items.Clear()
        ddlClientStates.DataBind()
    End Sub

    Protected Sub ddlClientStates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClientStates.DataBound
        ddlClientStates.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select State", 0))
    End Sub

    Protected Sub CV_ClientDuplicateName_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs) Handles CV_ClientDuplicateName.ServerValidate
        If Portal.BLL.Client.Clients.ClientDuplicateName(CInt(hdnClientID.Value), txtClientName.Text.Trim) = 0 Then
            args.IsValid = True
        Else
            args.IsValid = False
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowAlertDiv", "ShowAlertDiv('Please Enter another Client name. This name already exist.');", True)
        End If
    End Sub

#End Region

#Region " Contacts "

    Private Sub LoadContacts()
        rptrContactInfo.DataBind()
    End Sub

    Protected Sub rptrContactInfo_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptrContactInfo.ItemCommand
        If e.CommandName = "Edit" Then
            hdnClientContactID.Value = e.CommandArgument.ToString()
            Me.lblContactEditTitle.Text = "Edit Contact"
            FillContact()
            tblClientContactView.Visible = False
            tblClientEdit.Visible = False
            tblContactEdit.Visible = True
        ElseIf e.CommandName = "Delete" Then
            hdnClientContactID.Value = e.CommandArgument.ToString()
            Portal.BLL.Client.Client_Contacts.Client_ContactsDelete(CInt(hdnClientContactID.Value), True)
            rptrContactInfo.DataBind()
        End If
    End Sub

    Protected Sub rptrContactInfo_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrContactInfo.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If rptrContactInfo.Items.Count = 0 Then
                CType(e.Item.FindControl("trContacts_NoRecord"), HtmlTableRow).Visible = True
            Else
                CType(e.Item.FindControl("trContacts_NoRecord"), HtmlTableRow).Visible = False
            End If
        End If
    End Sub

    Private Sub FillContact()
        Dim colClientContact As New System.Collections.Generic.List(Of Portal.BLL.Client.Client_Contacts)()
        colClientContact = Portal.BLL.Client.Client_Contacts.Client_ContactsGetByID(CInt(hdnClientContactID.Value))
        If (colClientContact.Count > 0) Then
            Me.txtContactJobTitle.Text = colClientContact.Item(0).JobTitle
            Me.txtContactFirstName.Text = colClientContact.Item(0).FirstName
            Me.txtContactMiddleName.Text = colClientContact.Item(0).MiddleName
            Me.txtContactLastName.Text = colClientContact.Item(0).LastName
            'ddlContactCountry.DataBind()
            Me.ddlContactCountry.SelectedValue = colClientContact.Item(0).CountryID
            ddlContactState.DataBind()
            Me.ddlContactState.SelectedValue = colClientContact.Item(0).StateID
            Me.txtContactAddress.Text = colClientContact.Item(0).Address
            Me.txtContactCity.Text = colClientContact.Item(0).City
            Me.txtContactZip.Text = colClientContact.Item(0).Zip
            Me.txtContactEmail1.Text = colClientContact.Item(0).Email1
            Me.txtContactEmail2.Text = colClientContact.Item(0).Email2
            Me.txtContactWorkPhone.Text = colClientContact.Item(0).WorkPhone
            Me.txtContactHomePhone.Text = colClientContact.Item(0).HomePhone
            Me.txtContactCellPhone.Text = colClientContact.Item(0).CellPhone
            Me.txtContactFax.Text = colClientContact.Item(0).Fax
            Me.ddlUserType.SelectedValue = colClientContact.Item(0).IsAdmin
            Me.txtUserName.Text = colClientContact.Item(0).UserName
            Me.txtContactAddress2.Text = colClientContact.Item(0).Address2
            Me.ddlGender.SelectedValue = colClientContact.Item(0).Gender
            Me.ddlURLMType.SelectedValue = colClientContact.Item(0).HasURLMAccess
        Else
            ResetFillContact()
        End If
    End Sub

    Private Sub ResetFillContact()
        Me.txtContactJobTitle.Text = ""
        Me.txtContactFirstName.Text = ""
        Me.txtContactMiddleName.Text = ""
        Me.txtContactLastName.Text = ""
        'ddlContactCountry.DataBind()
        Me.ddlContactCountry.SelectedIndex = 0
        ddlContactState.DataBind()
        Me.ddlContactState.SelectedValue = 0
        Me.txtContactAddress.Text = ""
        Me.txtContactCity.Text = ""
        Me.txtContactZip.Text = ""
        Me.txtContactEmail1.Text = ""
        Me.txtContactEmail2.Text = ""
        Me.txtContactWorkPhone.Text = ""
        Me.txtContactHomePhone.Text = ""
        Me.txtContactCellPhone.Text = ""
        Me.txtContactFax.Text = ""
    End Sub


    Protected Sub btnContactNew_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContactNew.Click
        hdnClientContactID.Value = 0
        ResetFillContact()
        Me.lblContactEditTitle.Text = "New Contact"
        tblClientContactView.Visible = False
        tblClientEdit.Visible = False
        tblContactEdit.Visible = True
    End Sub

    Protected Sub btnContactSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContactSave.Click
        If Page.IsValid Then
            Dim objClientContact As New Portal.BLL.Client.Client_Contacts()
            With objClientContact
                .ID = CInt(hdnClientContactID.Value)
                .ClientID = CInt(hdnClientID.Value)
                '.AdminID 
                '.AreaDeveloperID
                '.ContactID
                .FirstName = txtContactFirstName.Text
                .MiddleName = txtContactMiddleName.Text
                .LastName = txtContactLastName.Text
                .Gender = ddlGender.SelectedValue
                .JobTitle = txtContactJobTitle.Text
                .HomePhone = txtContactHomePhone.Text
                .WorkPhone = txtContactWorkPhone.Text
                .CellPhone = txtContactCellPhone.Text
                .Fax = txtContactFax.Text
                .Email1 = txtContactEmail1.Text
                .Email2 = txtContactEmail2.Text
                .Address = txtContactAddress.Text
                .Address2 = txtContactAddress2.Text
                .City = txtContactCity.Text
                .Zip = txtContactZip.Text
                .StateID = ddlContactState.SelectedValue
                .CountryID = ddlContactCountry.SelectedValue
                '.ContactType  = txtContactFirstName.Text
                .Deleted = False
                .Inactive = False
                .IsAdmin = ddlUserType.SelectedValue
                .UserName = txtUserName.Text.Trim
                .PassWord = ""
                .HasURLMAccess = ddlURLMType.SelectedValue
                If hdnClientContactID.Value = 0 Then
                    Portal.BLL.Client.Client_Contacts.Client_ContactsAdd(.ClientID, .AdminID, .AreaDeveloperID, .ContactID, .FirstName, .MiddleName, .LastName, .Gender, .JobTitle, .HomePhone, .WorkPhone, .CellPhone, .Fax, .Email1, .Email2, .Address, .Address2, .City, .Zip, .StateID, .CountryID, .ContactType, .Deleted, .UserName, .PassWord, .IsAdmin, .HasURLMAccess)
                ElseIf hdnClientContactID.Value > 0 Then
                    Portal.BLL.Client.Client_Contacts.Client_ContactsUpdate(.ID, .ClientID, .AdminID, .AreaDeveloperID, .ContactID, .FirstName, .MiddleName, .LastName, .Gender, .JobTitle, .HomePhone, .WorkPhone, .CellPhone, .Fax, .Email1, .Email2, .Address, .Address2, .City, .Zip, .StateID, .CountryID, .ContactType, .Deleted, .UserName, .IsAdmin, .HasURLMAccess)
                End If
            End With

            rptrContactInfo.DataBind()
            tblClientContactView.Visible = True
            tblClientEdit.Visible = False
            tblContactEdit.Visible = False
        End If
    End Sub

    Protected Sub btnContactCancle_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnContactCancle.Click
        tblClientContactView.Visible = True
        tblClientEdit.Visible = False
        tblContactEdit.Visible = False
    End Sub

    Protected Sub ddlContactCountry_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlContactCountry.SelectedIndexChanged
        ddlContactState.Items.Clear()
        ddlContactState.DataBind()
    End Sub

    Protected Sub ddlContactState_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlContactState.DataBound
        ddlContactState.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select State", 0))
    End Sub


#End Region

#Region " Subscribtion "

    Private Sub LoadSubscribtion()
        rptProductTypesView.DataBind()
        If (itemcount = 0) Then
            rptProductTypesView.Visible = False
            tblSubscribtionEmpty.Visible = True
        Else
            rptProductTypesView.Visible = True
            tblSubscribtionEmpty.Visible = False
        End If
    End Sub

    Private Sub FillSubscribtion()
        rptProductTypesEdit.DataBind()
    End Sub

    Protected Sub btnSubscribtionEdit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubscribtionEdit.Click
        FillSubscribtion()
        tblSubscribtionView.Visible = False
        tblSubscribtionEdit.Visible = True
    End Sub
    Protected Sub btnSubscribtionSave_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubscribtionSave.Click
        If Page.IsValid Then
            If (CInt(hdnClientID.Value) > 0) Then
                Dim colNS_Products_Clients As New System.Collections.Generic.List(Of Portal.BLL.NS.NS_Products_Clients)()
                'Portal.BLL.NS.NS_Products_Clients.NS_Products_ClientsDeleteByClientID(CInt(hdnClientID.Value))
                For Each row As System.Web.UI.WebControls.RepeaterItem In rptProductTypesEdit.Items
                    Dim rptProducts As Repeater = CType(row.FindControl("rptProducts"), Repeater)
                    For Each rowProducts As System.Web.UI.WebControls.RepeaterItem In rptProducts.Items
                        Dim chkProducts As CheckBox = CType(rowProducts.FindControl("chkProducts"), CheckBox)
                        If (chkProducts.Checked) Then
                            Dim lblProductID As Label = CType(rowProducts.FindControl("lblProductID"), Label)
                            Dim txtProductPrice As RadNumericTextBox = CType(rowProducts.FindControl("txtProductPrice"), RadNumericTextBox)
                            Dim txtCorporatePercentage As RadNumericTextBox = CType(rowProducts.FindControl("txtCorporatePercentage"), RadNumericTextBox)
                            Dim chkCorporatePercentageType As RadioButtonList = CType(rowProducts.FindControl("chkCorporatePercentageType"), RadioButtonList)
                            Dim ddlBillTo As RadComboBox = CType(rowProducts.FindControl("ddlBillTo"), RadComboBox)
                            'Portal.BLL.NS.NS_Products_Clients.NS_Products_ClientsAdd(0, CInt(lblProductID.Text), CInt(hdnClientID.Value), ddlBillTo.SelectedValue, CDec(txtCorporatePercentage.Text), False, CDec(txtProductPrice.Text), chkCorporatePercentageType.SelectedValue)
                            'AddRowToTable(0, CInt(lblProductID.Text), CInt(hdnClientID.Value), ddlBillTo.SelectedValue, CDec(txtCorporatePercentage.Text), False, CDec(txtProductPrice.Text), chkCorporatePercentageType.SelectedValue)
                            colNS_Products_Clients.Add(New Portal.BLL.NS.NS_Products_Clients(0, CInt(lblProductID.Text), CInt(hdnClientID.Value), ddlBillTo.SelectedValue, CDec(txtCorporatePercentage.Text), False, CDec(txtProductPrice.Text), chkCorporatePercentageType.SelectedValue))
                        End If
                        Dim rptModules As Repeater = CType(rowProducts.FindControl("rptModules"), Repeater)
                        For Each rowModules As System.Web.UI.WebControls.RepeaterItem In rptModules.Items
                            Dim chkModules As CheckBox = CType(rowModules.FindControl("chkModules"), CheckBox)
                            If (chkModules.Checked) Then
                                Dim lblModuleID As Label = CType(rowModules.FindControl("lblModuleID"), Label)
                                Dim txtModulePrice As RadNumericTextBox = CType(rowModules.FindControl("txtModulePrice"), RadNumericTextBox)
                                Dim txtCorporatePercentage As RadNumericTextBox = CType(rowModules.FindControl("txtCorporatePercentage"), RadNumericTextBox)
                                Dim chkCorporatePercentageType As RadioButtonList = CType(rowModules.FindControl("chkCorporatePercentageType"), RadioButtonList)
                                Dim ddlBillTo As RadComboBox = CType(rowModules.FindControl("ddlBillTo"), RadComboBox)
                                'Portal.BLL.NS.NS_Products_Clients.NS_Products_ClientsAdd(0, CInt(lblModuleID.Text), CInt(hdnClientID.Value), ddlBillTo.SelectedValue, CDec(txtCorporatePercentage.Text), False, CDec(txtModulePrice.Text), chkCorporatePercentageType.SelectedValue)
                                'AddRowToTable(0, CInt(lblModuleID.Text), CInt(hdnClientID.Value), ddlBillTo.SelectedValue, CDec(txtCorporatePercentage.Text), False, CDec(txtModulePrice.Text), chkCorporatePercentageType.SelectedValue)
                                colNS_Products_Clients.Add(New Portal.BLL.NS.NS_Products_Clients(0, CInt(lblModuleID.Text), CInt(hdnClientID.Value), ddlBillTo.SelectedValue, CDec(txtCorporatePercentage.Text), False, CDec(txtModulePrice.Text), chkCorporatePercentageType.SelectedValue))
                            End If
                        Next

                    Next

                Next

                Portal.BLL.NS.NS_Products_Clients.NS_Products_ClientsAddWithTranction(colNS_Products_Clients, CInt(hdnClientID.Value))

            End If
            LoadSubscribtion()
            tblSubscribtionView.Visible = True
            tblSubscribtionEdit.Visible = False
        End If
        '/*********************
        'colNS_Products_Clients.Add(New Portal.BLL.NS.NS_Products_Clients(0, CType(dr("ProductID"), Integer), CType(dr("ClientID"), Integer), CType(dr("BillTo"), Integer), CType(dr("CorporatePay"), Decimal), CType(dr("Deleted"), Boolean), CType(dr("Price"), Decimal), CType(dr("CorporatePayType"), Integer)))


        '/***********************
    End Sub
    'Private Sub AddRowToTable(ByVal ID As Integer, ByVal ProductID As Integer, ByVal ClientID As Integer, ByVal BillTo As Integer, ByVal CorporatePay As Decimal, ByVal Deleted As Boolean, ByVal Price As Decimal, ByVal CorporatePayType As Integer)
    '    Dim dataRow As Data.DataRow
    '    dataRow = dtNS_Products_Clients.NewRow()
    '    dataRow("ID") = ID
    '    dataRow("ProductID") = ProductID
    '    dataRow("ClientID") = ClientID
    '    dataRow("BillTo") = BillTo
    '    dataRow("CorporatePay") = CorporatePay
    '    dataRow("Deleted") = Deleted
    '    dataRow("Price") = Price
    '    dataRow("CorporatePayType") = CorporatePayType
    '    dtNS_Products_Clients.Rows.Add(dataRow)
    'End Sub


    Protected Sub btnSubscribtionCancle_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnSubscribtionCancle.Click
        tblSubscribtionView.Visible = True
        tblSubscribtionEdit.Visible = False
    End Sub

    Protected Sub rptProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim chkProducts As CheckBox = CType(e.Item.FindControl("chkProducts"), CheckBox)
            Dim txtProductPrice As RadNumericTextBox = CType(e.Item.FindControl("txtProductPrice"), RadNumericTextBox)
            Dim ddlBillTo As RadComboBox = CType(e.Item.FindControl("ddlBillTo"), RadComboBox)
            Dim txtCorporatePercentage As RadNumericTextBox = CType(e.Item.FindControl("txtCorporatePercentage"), RadNumericTextBox)
            chkProducts.Attributes.Add("atttxtProductPriceID", txtProductPrice.ClientID)
            chkProducts.Attributes.Add("attddlBillToID", ddlBillTo.ClientID)
            chkProducts.Attributes.Add("atttxtCorporatePercentageID", txtCorporatePercentage.ClientID)
        End If
    End Sub

    Protected Sub rptModules_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim chkModules As CheckBox = CType(e.Item.FindControl("chkModules"), CheckBox)
            Dim txtModulePrice As RadNumericTextBox = CType(e.Item.FindControl("txtModulePrice"), RadNumericTextBox)
            Dim ddlBillTo As RadComboBox = CType(e.Item.FindControl("ddlBillTo"), RadComboBox)
            Dim txtCorporatePercentage As RadNumericTextBox = CType(e.Item.FindControl("txtCorporatePercentage"), RadNumericTextBox)
            chkModules.Attributes.Add("atttxtProductPriceID", txtModulePrice.ClientID)
            chkModules.Attributes.Add("attddlBillToID", ddlBillTo.ClientID)
            chkModules.Attributes.Add("atttxtCorporatePercentageID", txtCorporatePercentage.ClientID)
        End If
    End Sub

    Protected Sub rptProductsView_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim checked As Boolean = CType(e.Item.DataItem("checked"), Boolean)
            If (checked) Then
                itemcount = itemcount + 1
            End If
        End If
    End Sub

    Protected Sub rptModulesView_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        Dim checked As Boolean = CType(e.Item.DataItem("checked"), Boolean)
        If (checked) Then
            itemcount = itemcount + 1
        End If
    End Sub
#End Region

End Class