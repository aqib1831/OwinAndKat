Imports System.Data
Imports System.Web
Partial Class LM_SmsxLicenseDetails
    Inherits System.Web.UI.Page
    Dim LicenseID As Integer
    Dim CountryID As Integer = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
                hdnLicienceID.Value = Request.QueryString("LicenseID")
                LicenseID = CInt(hdnLicienceID.Value)
                If Not IsPostBack Then
                    btnBack.PostBackUrl = "SMSXLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                    btnEdit.PostBackUrl = "EditSMSXLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                    If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                        'btnEdit.Visible = False
                        'btnBack.PostBackUrl = "SMSXLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                    End If
                    LoadSMSXLicenseDetail()

                End If




            End If
        End If

    End Sub

    Protected Sub LoadSMSXLicenseDetail()
        Dim objLicenseSMXDetail As New Portal.BLL.SMSXLicenseManagement
        objLicenseSMXDetail = objLicenseSMXDetail.GetSMSXLicenseDetail(CInt(Request.QueryString("LicenseID")))
        ltrlStoreNo.Text = objLicenseSMXDetail.StoreNo
        ltrlStoreNick.Text = objLicenseSMXDetail.StoreNick
        ltrlClientName.Text = objLicenseSMXDetail.ClientName
        ltrlLiveTerminals.Text = "- - -"
        ltrlTerminals.Text = objLicenseSMXDetail.NoOfTerminals
        ltrlNotes.Text = objLicenseSMXDetail.Notes.Replace(vbCrLf, "<br />")
        ltrlIssuedBy.Text = objLicenseSMXDetail.IssuedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseSMXDetail.IssuedOn)

        If (objLicenseSMXDetail.UpdatedOn = "12:00:00 AM") Then
            ltrlUpdatedOn.Text = "- - -"
        Else
            ltrlUpdatedOn.Text = objLicenseSMXDetail.LastUpdatedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseSMXDetail.UpdatedOn)
        End If

 If (objLicenseSMXDetail.InstallationDate = Date.MinValue) Then
            ltrlInstallationDate.Text = "- - -"
        Else
            ltrlInstallationDate.Text = objLicenseSMXDetail.InstallationDate.ToString("MMM dd, yyyy")
        End If
        If objLicenseSMXDetail.IsDynamicIP = True Then
            ltrlSystemIP.Text = "- - -"
        Else
            ltrlSystemIP.Text = objLicenseSMXDetail.SystemIP

        End If



        If (objLicenseSMXDetail.IsDynamicIP = False) Then
            ltrlStaticIP.Text = "Yes"
        Else
            ltrlStaticIP.Text = "Dynamic" & " Until " & objLicenseSMXDetail.DynamicIPEndDate
        End If

        If (String.IsNullOrEmpty(objLicenseSMXDetail.InVoiceNo) = True) Then
            ltrlInvoiceNo.Text = "- - -"
        Else
            ltrlInvoiceNo.Text = objLicenseSMXDetail.InVoiceNo
        End If
        If (objLicenseSMXDetail.IsLicenseInActive = True) Then
            ltrlActive.Text = "Inactive"
            divltrlActive.Attributes.Add("class", "darkRedColor")
        Else
            ltrlActive.Text = "Active"
            divltrlActive.Attributes.Add("class", "darkGreenColor")
        End If
    End Sub
    Protected Sub odsSMSXLicensesManagement_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsSMSXLicensesManagement.Selected
        If (IsNumeric(e.ReturnValue)) Then
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub

    Protected Sub gvwSMSXLicienseTerminal_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvwSMSXLicienseTerminal.RowCommand
        If e.CommandName = "Active" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseSMXDetail As New Portal.BLL.SMSXLicenseManagement
            objLicenseSMXDetail.UserID = Session("AdminID")
            objLicenseSMXDetail.LicenseTerminalID = Id
            objLicenseSMXDetail.LicenseID = hdnLicienceID.Value
            objLicenseSMXDetail.Changes = "In Active the Terminal No " & Id

            objLicenseSMXDetail.MakeActive(Id, objLicenseSMXDetail.UserID)
            objLicenseSMXDetail.AddSMSXLicenseTerminalLog()
            LoadSMSXLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()

            'Setting up the security code 
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(hdnLicienceID.Value)
            dsLicenseDetail.DataSetName = "SMSXLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

           If dsLicenseDetail.Tables(0).Rows.Count > 0 Then
                CountryID = dsLicenseDetail.Tables(0).Rows(0).Item("CountryID")
            End If
            Try
                Dim serviceResponse As Integer
                If CountryID = "45" Then        ' on Index 2 contain country ID , 45 is the China ID
                    'Dim objSMSWebserviceforChina As New com.netsolace.sms.qa.PortalServices      ' QA 
                    Dim objSMSWebserviceforChina As New cn.com.ediblearrangements.sms.PortalServices ' Live 
                    serviceResponse = objSMSWebserviceforChina.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                Else
                    Dim objSMSWebservice As New se.PortalServices
                    serviceResponse = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                End If

            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddSMSXLicense Active", String.Empty, String.Empty, String.Empty)
            End Try

        ElseIf e.CommandName = "InActive" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseSMXDetail As New Portal.BLL.SMSXLicenseManagement
            objLicenseSMXDetail.UserID = Session("AdminID")
            objLicenseSMXDetail.LicenseID = hdnLicienceID.Value
            objLicenseSMXDetail.LicenseTerminalID = Id
            objLicenseSMXDetail.Changes = "Active the Terminal No " & Id
            objLicenseSMXDetail.AddSMSXLicenseTerminalLog()
            objLicenseSMXDetail.MakeInActiveTerminal(Id, objLicenseSMXDetail.UserID)
            LoadSMSXLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()


            'Setting up the security code 
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseDetailForWebService(hdnLicienceID.Value)
            dsLicenseDetail.DataSetName = "SMSXLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            If dsLicenseDetail.Tables(0).Rows.Count > 0 Then
                CountryID = dsLicenseDetail.Tables(0).Rows(0).Item("CountryID")
            End If

            Try
                Dim serviceResponse As Integer
                If CountryID = "45" Then        ' on Index 2 contain country ID , 45 is the China ID
                    'Dim objSMSWebserviceforChina As New com.netsolace.sms.qa.PortalServices      ' QA 
                    Dim objSMSWebserviceforChina As New cn.com.ediblearrangements.sms.PortalServices ' Live 
                    serviceResponse = objSMSWebserviceforChina.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                Else
                    Dim objSMSWebservice As New se.PortalServices
                    serviceResponse = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                End If

            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddSMSXLicense InActive", String.Empty, String.Empty, String.Empty)
            End Try

        End If
        If e.CommandName = "Regenerate" Then
            Dim newID As Integer
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseSMXDetail As New Portal.BLL.SMSXLicenseManagement
            objLicenseSMXDetail.UserID = Session("AdminID")
            objLicenseSMXDetail.LicenseID = hdnLicienceID.Value
            objLicenseSMXDetail.LicenseTerminalID = Id
            objLicenseSMXDetail.Changes = "Regenerate the Terminal No " & Id
            objLicenseSMXDetail.AddSMSXLicenseTerminalLog()
            newID = objLicenseSMXDetail.SMSX_RegenerateTerminalByID(Id, objLicenseSMXDetail.UserID)
            AddActivity(ltrlStoreNo.Text.Trim, hdnLicienceID.Value, ltrlStoreNick.Text.Trim, Portal.BLL.Enumeration.ClientID.EA)
            LoadSMSXLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()
            'Setting up the security code 
            Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.SMSXLicenseManagement.GetLicenseTerminalDetailForWebService(newID, Id, hdnLicienceID.Value)
            dsLicenseDetail.DataSetName = "SMSXLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))
            If dsLicenseDetail.Tables(0).Rows.Count > 0 Then
                CountryID = dsLicenseDetail.Tables(0).Rows(0).Item("CountryID")
            End If

            Try
                Dim serviceResponse As Integer
                If CountryID = "45" Then        ' on Index 2 contain country ID , 45 is the China ID
                    'Dim objSMSWebserviceforChina As New com.netsolace.sms.qa.PortalServices      ' QA 
                    Dim objSMSWebserviceforChina As New cn.com.ediblearrangements.sms.PortalServices ' Live 
                    serviceResponse = objSMSWebserviceforChina.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                Else
                    Dim objSMSWebservice As New se.PortalServices
                    serviceResponse = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
                End If

            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddSMSXLicense", String.Empty, String.Empty, String.Empty)
            End Try
            
        End If
        If e.CommandName = "DeleteLicense" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseSMXDetail As New Portal.BLL.SMSXLicenseManagement
            objLicenseSMXDetail.UserID = Session("AdminID")
            objLicenseSMXDetail.LicenseID = hdnLicienceID.Value
            objLicenseSMXDetail.LicenseTerminalID = Id
            objLicenseSMXDetail.Changes = "Delete the Terminal No " & Id
            objLicenseSMXDetail.AddSMSXLicenseTerminalLog()
            Portal.BLL.SMSXLicenseManagement.DeleteSMSXLicense(Id)
            LoadSMSXLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()
            Try
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "DeleteSMSXLicense", String.Empty, String.Empty, String.Empty)
            End Try
        End If
    End Sub

    Protected Function FormatDate(ByVal Dates As Date)
        Return Dates.ToString("dd:mm:yyy")
    End Function
    Protected Sub MakeActiveInactive(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub gvwSMSXLicienseTerminal_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwSMSXLicienseTerminal.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("Inactive") = True Then
                Dim imgbtnActive As ImageButton = CType(e.Row.FindControl("imgbtnActive"), ImageButton)
                imgbtnActive.Visible = True
            Else
                
                Dim btnInactive As ImageButton = CType(e.Row.FindControl("btnInactive"), ImageButton)
                btnInactive.Visible = True
            End If
            If e.Row.DataItem("TerminalName").ToString.ToUpper = "SERVER" Then
                e.Row.Cells(11).Text = String.Empty

            Else

                e.Row.Cells(11).Attributes.Add("onclick", "return EditAdditionTerminal('" & e.Row.DataItem("ID") & "','" & e.Row.DataItem("TerminalName") & "');")
            End If
            If CInt(Session("AdminID")) = Portal.BLL.Enumeration.Users.Khurram_Ali Then
                Dim imgbtnDelete As ImageButton = CType(e.Row.FindControl("btnDelete"), ImageButton)
                imgbtnDelete.Visible = True
            End If
        End If

    End Sub

    Function AddActivity(ByVal StoreNo As String, ByVal LicenseId As Integer, ByVal StoreName As String, ByVal ClientID As Integer)
        ''Dim objTicketsBLL As New Portal.BLL.PM.PM_Ticket_Features
        Dim strTerminals As New StringBuilder

        Dim DrTerminalDetail As SqlClient.SqlDataReader = Portal.BLL.SMSXLicenseManagement.GetAllSMSXLicensesTerminalForEmailByLicienceIDForActivity(LicenseId)
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
        Dim drFranchises As System.Data.SqlClient.SqlDataReader = Portal.BLL.SMSXLicenseManagement.GETSMSXFranchiseIDByStoreNumber(StoreNo, ClientID)
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
            .Subject = ConfigurationManager.AppSettings("SMS-XRegenerateSubject")
            .Type = Portal.BLL.Enumeration.ActivityType.Installation
            .SubType = Portal.BLL.Enumeration.ActivitySubType.Installation
            .TimeSpent = TimeSpan.Zero
            .FranchiseID = 0 'CInt(hdnFranchiseID.Value)
            .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
            .Description = "<strong>" & ConfigurationManager.AppSettings("SMS-XRegenerateDescription") & "</strong><br><br>" & strTerminals.ToString
            .ActivityDate = DateTime.Now
            .ActivityState = Portal.BLL.Enumeration.ActivityState.NotStarted
            .RelatedTo = Portal.BLL.Enumeration.NSProductIDs.SMS_X
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

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If Portal.BLL.SMSXLicenseManagement.IsTerminalNameExist(hdnEditLicenseID.Value, txtTerminalName.Text.Trim, hdnLicienceID.Value) Then
            cvName.IsValid = False
        Else
            cvName.IsValid = True
            Dim id As Integer = hdnEditLicenseID.Value
            Portal.BLL.SMSXLicenseManagement.UpdateTerminalName(id, txtTerminalName.Text.Trim)
            ScriptManager.RegisterStartupScript(Me, Me.GetType, "hide", "HideAdditionalTerminalDiv();", True)
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()
        End If
    End Sub

End Class