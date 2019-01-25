Imports System.Data
Imports System.Web
Partial Class LM_SmsxLicenseDetails
    Inherits System.Web.UI.Page
    Dim LicenseID As Integer

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
                hdnLicienceID.Value = Request.QueryString("LicenseID")
                LicenseID = CInt(hdnLicienceID.Value)
                If Not IsPostBack Then
                    btnBack.PostBackUrl = "DFLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                    btnEdit.PostBackUrl = "EditDFLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                    If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                        'btnEdit.Visible = False
                        'btnBack.PostBackUrl = "SMSXLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                    End If
                    LoadDFLicenseDetail()

                End If

            End If
        End If
    End Sub

    Protected Sub LoadDFLicenseDetail()
        Dim objLicenseDFDetail As New Portal.BLL.DFLicenseManagement
        objLicenseDFDetail = objLicenseDFDetail.GetDFLicenseDetail(CInt(Request.QueryString("LicenseID")))
        ltrlStoreNo.Text = objLicenseDFDetail.StoreNo
        ltrlStoreNick.Text = objLicenseDFDetail.StoreNick
        ltrlClientName.Text = objLicenseDFDetail.ClientName
        ltrlLiveTerminals.Text = "- - -"
        ltrlTerminals.Text = objLicenseDFDetail.NoOfTerminals
        ltrlNotes.Text = objLicenseDFDetail.Notes.Replace(vbCrLf, "<br />")
        ltrlIssuedBy.Text = objLicenseDFDetail.IssuedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseDFDetail.IssuedOn)

        If (objLicenseDFDetail.UpdatedOn = "12:00:00 AM") Then
            ltrlUpdatedOn.Text = "- - -"
        Else
            ltrlUpdatedOn.Text = objLicenseDFDetail.LastUpdatedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseDFDetail.UpdatedOn)
        End If

        If (objLicenseDFDetail.InstallationDate = DateTime.MinValue) Then
            ltrlInstallationDate.Text = "- - -"
        Else
            ltrlInstallationDate.Text = objLicenseDFDetail.InstallationDate.ToString("MMM dd, yyyy")
        End If

        If objLicenseDFDetail.IsDynamicIP = True Then
            ltrlSystemIP.Text = "- - -"
        Else
            ltrlSystemIP.Text = objLicenseDFDetail.SystemIP

        End If



        If (objLicenseDFDetail.IsDynamicIP = False) Then
            ltrlStaticIP.Text = "Yes"
        Else
            ltrlStaticIP.Text = "Dynamic" & " Until " & objLicenseDFDetail.DynamicIPEndDate
        End If

        If (String.IsNullOrEmpty(objLicenseDFDetail.InVoiceNo) = True) Then
            ltrlInvoiceNo.Text = "- - -"
        Else
            ltrlInvoiceNo.Text = objLicenseDFDetail.InVoiceNo
        End If
        If (objLicenseDFDetail.IsLicenseInActive = True) Then
            ltrlActive.Text = "Inactive"
            divltrlActive.Attributes.Add("class", "darkRedColor")
        Else
            ltrlActive.Text = "Active"
            divltrlActive.Attributes.Add("class", "darkGreenColor")
        End If
    End Sub
    

    Protected Sub gvwSMSXLicienseTerminal_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvwSMSXLicienseTerminal.RowCommand
        If e.CommandName = "Active" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseDFDetail As New Portal.BLL.DFLicenseManagement
            objLicenseDFDetail.UserID = Session("AdminID")
            objLicenseDFDetail.LicenseTerminalID = Id
            objLicenseDFDetail.LicenseID = hdnLicienceID.Value
            objLicenseDFDetail.Changes = "In Active the Terminal No " & Id

            objLicenseDFDetail.MakeActive(Id, objLicenseDFDetail.UserID)
            objLicenseDFDetail.AddDFLicenseTerminalLog()
            LoadDFLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()

            'Setting up the security code 
            Dim securityCode As String = ConfigurationManager.AppSettings("DFServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.DFLicenseManagement.GetLicenseDetailForWebService(hdnLicienceID.Value)
            dsLicenseDetail.DataSetName = "DFLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("DFEncryptionKey"))

            Try
                'Update the details in the sms db via webservice.
                Dim objDFWebservice As New DippedFruit.PortalService
                objDFWebservice.UpdateModifiedLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail), 1, True)

            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddDFLicense", String.Empty, String.Empty, String.Empty)
            End Try

        ElseIf e.CommandName = "InActive" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseDFDetail As New Portal.BLL.DFLicenseManagement
            objLicenseDFDetail.UserID = Session("AdminID")
            objLicenseDFDetail.LicenseID = hdnLicienceID.Value
            objLicenseDFDetail.LicenseTerminalID = Id
            objLicenseDFDetail.Changes = "Active the Terminal No " & Id
            objLicenseDFDetail.AddDFLicenseTerminalLog()
            objLicenseDFDetail.MakeInActiveTerminal(Id, objLicenseDFDetail.UserID)
            LoadDFLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()


            'Setting up the security code 
            Dim securityCode As String = ConfigurationManager.AppSettings("DFServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.DFLicenseManagement.GetLicenseDetailForWebService(hdnLicienceID.Value)
            dsLicenseDetail.DataSetName = "DFLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("DFEncryptionKey"))

            Try
                'Update the details in the sms db via webservice.                

                Dim objDFWebservice As New DippedFruit.PortalService
                objDFWebservice.UpdateModifiedLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail), 1, True)
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddDFLicense", String.Empty, String.Empty, String.Empty)
            End Try
           
        End If
        If e.CommandName = "Regenerate" Then
            Dim newID As Integer
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseDFDetail As New Portal.BLL.DFLicenseManagement
            objLicenseDFDetail.UserID = Session("AdminID")
            objLicenseDFDetail.LicenseID = hdnLicienceID.Value
            objLicenseDFDetail.LicenseTerminalID = Id
            objLicenseDFDetail.Changes = "Regenerate the Terminal No " & Id
            objLicenseDFDetail.AddDFLicenseTerminalLog()
            newID = objLicenseDFDetail.DF_RegenerateTerminalByID(Id, objLicenseDFDetail.UserID)
            AddActivity(ltrlStoreNo.Text.Trim, hdnLicienceID.Value, ltrlStoreNick.Text.Trim, Portal.BLL.Enumeration.ClientID.EA)
            LoadDFLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()
            'Setting up the security code 
            Dim securityCode As String = ConfigurationManager.AppSettings("DFServiceAuthCode").ToString()
            Dim dsLicenseDetail As DataSet = Portal.DAL.DFLicenseManagement.GetLicenseTerminalDetailForWebService(newID, Id, hdnLicienceID.Value)
            dsLicenseDetail.DataSetName = "DFLicense"
            dsLicenseDetail.Tables(0).TableName = "License"
            dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("DFEncryptionKey"))

            Try
                'Update the details in the sms db via webservice.
                
                Dim objDFWebservice As New DippedFruit.PortalService
                objDFWebservice.UpdateModifiedLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail), 1, True)
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddDFLicense", String.Empty, String.Empty, String.Empty)
            End Try
            
        End If
        If e.CommandName = "DeleteLicense" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseDFDetail As New Portal.BLL.DFLicenseManagement
            objLicenseDFDetail.UserID = Session("AdminID")
            objLicenseDFDetail.LicenseID = hdnLicienceID.Value
            objLicenseDFDetail.LicenseTerminalID = Id
            objLicenseDFDetail.Changes = "Delete the Terminal No " & Id
            objLicenseDFDetail.AddDFLicenseTerminalLog()
            Portal.BLL.DFLicenseManagement.DeleteDFLicense(Id)
            LoadDFLicenseDetail()
            upnlTerminals.Update()
            gvwSMSXLicienseTerminal.DataBind()
            upKeys.Update()

            Try
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "DeleteDFLicense", String.Empty, String.Empty, String.Empty)
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
            If CInt(Session("AdminID")) <> Portal.BLL.Enumeration.Users.Khurram_Ali Then
                e.Row.Cells(11).Text = String.Empty
            End If
        End If

    End Sub
    Function AddActivity(ByVal StoreNo As String, ByVal LicenseId As Integer, ByVal StoreName As String, ByVal ClientID As Integer)
        ''Dim objTicketsBLL As New Portal.BLL.PM.PM_Ticket_Features
        Dim strTerminals As New StringBuilder

        Dim DrTerminalDetail As SqlClient.SqlDataReader = Portal.BLL.DFLicenseManagement.GetAllDFLicensesTerminalForEmailByLicienceIDForActivity(LicenseId)
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
        Dim drFranchises As System.Data.SqlClient.SqlDataReader = Portal.BLL.DFLicenseManagement.GETDFFranchiseIDByStoreNumber(StoreNo, ClientID)
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
            '.Subject = ConfigurationManager.AppSettings("DF-RegenerateSubject")
	    .Subject = "DFT License"
            .Type = Portal.BLL.Enumeration.ActivityType.Installation
            .SubType = Portal.BLL.Enumeration.ActivitySubType.Installation
            .TimeSpent = TimeSpan.Zero
            .FranchiseID = 0 'CInt(hdnFranchiseID.Value)
            .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
            .Description = "<strong>" & ConfigurationManager.AppSettings("DF-RegenerateDescription") & "</strong><br><br>" & strTerminals.ToString
            .ActivityDate = DateTime.Now
            .ActivityState = Portal.BLL.Enumeration.ActivityState.NotStarted
            .RelatedTo = Portal.BLL.Enumeration.NSProductIDs.SMS_X ' Here DF Product ID 
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

    Protected Sub odsDFLicensesManagement_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsDFLicensesManagement.Selected
        If (IsNumeric(e.ReturnValue)) Then
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub
   
End Class