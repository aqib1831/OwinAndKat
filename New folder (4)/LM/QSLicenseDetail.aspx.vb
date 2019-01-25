Imports System.Web.UI.Control
Partial Class LM_QsLicenseDetail
    Inherits System.Web.UI.Page
    Dim LicenseID As Integer

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Request.QueryString("LicenseID") <> Nothing And IsNumeric(Request.QueryString("LicenseID"))) Then
            hdnLicienceID.Value = Request.QueryString("LicenseID")
            LicenseID = CInt(hdnLicienceID.Value)
            If Not IsPostBack Then
                btnBack.PostBackUrl = "QsLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                btnEdit.PostBackUrl = "QSEditLicenseDetail.aspx?LicenseID=" & Request.QueryString("LicenseID") & "&ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters")
                If (Request.QueryString("PrevPage") <> Nothing And Request.QueryString("PrevPage") = "MyNetsolace") Then
                    'btnEdit.Visible = False
                    'btnBack.PostBackUrl = "SMSXLicenseManagement.aspx?ddlClient=" & Request.QueryString("ddlClient") & "&ddlStates=" & Request.QueryString("ddlStates") & "&ddlFilters=" & Request.QueryString("ddlFilters") & "&PrevPage=MyNetsolace"
                End If
                LoadQsLicenseDetail()

            End If

        End If

    End Sub

    
    Protected Sub LoadQsLicenseDetail()
        Dim objLicenseQsDetail As New Portal.BLL.QsLicenseManagment
        objLicenseQsDetail = objLicenseQsDetail.GetQsLicenseDetail(CInt(Request.QueryString("LicenseID")))
        ltrlStoreNo.Text = objLicenseQsDetail.StoreNo
        ltrlStoreNick.Text = objLicenseQsDetail.StoreNick
        ltrlClientName.Text = objLicenseQsDetail.ClientName
        ltrlLiveTerminals.Text = "- - -"
        hdnClientID.Value = objLicenseQsDetail.ClientID
        ltrlTerminals.Text = objLicenseQsDetail.NoOfTerminals
        ltrlNotes.Text = objLicenseQsDetail.Notes.Replace(vbCrLf, "<br />")
        ltrlIssuedBy.Text = objLicenseQsDetail.IssuedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseQsDetail.IssuedOn)

        If (objLicenseQsDetail.UpdatedOn = "12:00:00 AM") Then
            ltrlUpdatedOn.Text = "- - -"
        Else
            ltrlUpdatedOn.Text = objLicenseQsDetail.LastUpdatedBy & " On " & String.Format("{0:MMM dd, yyyy}", objLicenseQsDetail.UpdatedOn)
        End If

        If objLicenseQsDetail.IsDynamicIP = True Then
            ltrlSystemIP.Text = "- - -"
        Else
            ltrlSystemIP.Text = objLicenseQsDetail.SystemIP

        End If



        If (objLicenseQsDetail.IsDynamicIP = False) Then
            ltrlStaticIP.Text = "Yes"
        Else
            ltrlStaticIP.Text = "Dynamic" & " Until " & objLicenseQsDetail.DynamicIPEndDate
        End If

        If (String.IsNullOrEmpty(objLicenseQsDetail.InVoiceNo) = True) Then
            ltrlInvoiceNo.Text = "- - -"
        Else
            ltrlInvoiceNo.Text = objLicenseQsDetail.InVoiceNo
        End If
        If (objLicenseQsDetail.IsLicenseInActive = True) Then
            ltrlActive.Text = "Inactive"
            divltrlActive.Attributes.Add("class", "darkRedColor")
        Else
            ltrlActive.Text = "Active"
            divltrlActive.Attributes.Add("class", "darkGreenColor")
        End If

    End Sub
    Protected Sub odsQsLicensesManagement_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odQSLicensesManagement.Selected
        If (IsNumeric(e.ReturnValue)) Then
            If ((e.ReturnValue Mod 2) <> 0) Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
            Else
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "SetRowStyle();", True)
            End If
        End If
    End Sub

    Protected Sub gvwQsLicienseTerminal_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvwQsLicienseTerminal.RowCommand
        If e.CommandName = "Active" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseQsDetail As New Portal.BLL.QsLicenseManagment
            objLicenseQsDetail.UserID = Session("AdminID")
            objLicenseQsDetail.LicenseTerminalID = Id
            objLicenseQsDetail.LicenseID = LicenseID
            objLicenseQsDetail.Changes = "In Active the Terminal No " & Id

            objLicenseQsDetail.MakeActive(Id, objLicenseQsDetail.UserID)
            objLicenseQsDetail.AddQsLicenseTerminalLog()
            LoadQsLicenseDetail()
            upnlTerminals.Update()
            gvwQsLicienseTerminal.DataBind()
            upKeys.Update()

            'Setting up the security code 
            'Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            'Dim dsLicenseDetail As Data.DataSet = Portal.DAL.QsLicenseManagment.GetLicenseDetailForWebService(LicenseID)
            'dsLicenseDetail.DataSetName = "SMSXLicense"
            'dsLicenseDetail.Tables(0).TableName = "License"
            'dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            'securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            Try
                If CInt(hdnClientID.Value) = Portal.BLL.Enumeration.ClientID.SaladCreation Then
                    Dim NoOfTerminals As Integer = Portal.DAL.QsLicenseManagment.GetTotalNoOfTerminalsByStoreNumber(CInt(ltrlStoreNo.Text.Trim))
                    Dim serSaladCreation As New SaladCreation.Service
                    serSaladCreation.UpdateFranchiseTerminals(CInt(ltrlStoreNo.Text.Trim), NoOfTerminals)
                End If
                'Update the details in the sms db via webservice.
                'Dim objSMSWebservice As New se.PortalServices
                'Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddQs", String.Empty, String.Empty, String.Empty)
            End Try

        ElseIf e.CommandName = "InActive" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseQsDetail As New Portal.BLL.QsLicenseManagment
            objLicenseQsDetail.UserID = Session("AdminID")
            objLicenseQsDetail.LicenseID = LicenseID
            objLicenseQsDetail.LicenseTerminalID = Id
            objLicenseQsDetail.Changes = "Active the Terminal No " & Id
            objLicenseQsDetail.AddQsLicenseTerminalLog()
            objLicenseQsDetail.MakeInActiveTerminal(Id, objLicenseQsDetail.UserID)
            LoadQsLicenseDetail()
            upnlTerminals.Update()
            gvwQsLicienseTerminal.DataBind()
            upKeys.Update()


            'Setting up the security code 
            ''Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            ''Dim dsLicenseDetail As Data.DataSet = Portal.DAL.QsLicenseManagment.GetLicenseDetailForWebService(LicenseID)
            ''dsLicenseDetail.DataSetName = "SMSXLicense"
            ''dsLicenseDetail.Tables(0).TableName = "License"
            ''dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            ''securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            Try
                If CInt(hdnClientID.Value) = Portal.BLL.Enumeration.ClientID.SaladCreation Then
                    Dim NoOfTerminals As Integer = Portal.DAL.QsLicenseManagment.GetTotalNoOfTerminalsByStoreNumber(CInt(ltrlStoreNo.Text.Trim))
                    Dim serSaladCreation As New SaladCreation.Service
                    serSaladCreation.UpdateFranchiseTerminals(CInt(ltrlStoreNo.Text.Trim), NoOfTerminals)
                End If
                'Update the details in the sms db via webservice.
                ' Dim objSMSWebservice As New se.PortalServices
                'Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddQsLicense", String.Empty, String.Empty, String.Empty)
            End Try

        End If
        If e.CommandName = "Regenerate" Then
            Dim newID As Integer
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseQsDetail As New Portal.BLL.QsLicenseManagment
            objLicenseQsDetail.UserID = Session("AdminID")
            objLicenseQsDetail.LicenseID = LicenseID
            objLicenseQsDetail.LicenseTerminalID = Id
            objLicenseQsDetail.Changes = "Regenerate the Terminal No " & Id
            objLicenseQsDetail.AddQsLicenseTerminalLog()
            newID = objLicenseQsDetail.Qs_RegenerateTerminalByID(Id, objLicenseQsDetail.UserID)
            ' AddActivity(ltrlStoreNo.Text.Trim, LicenseID, ltrlStoreNick.Text.Trim, Portal.BLL.Enumeration.ClientID.EA)
            LoadQsLicenseDetail()
            upnlTerminals.Update()
            gvwQsLicienseTerminal.DataBind()
            upKeys.Update()
            'Setting up the security code 
            'Dim securityCode As String = ConfigurationManager.AppSettings("SMSServiceAuthCode").ToString()
            'Dim dsLicenseDetail As Data.DataSet = Portal.DAL.QsLicenseManagment.GetLicenseTerminalDetailForWebService(newID, Id, LicenseID)
            'dsLicenseDetail.DataSetName = "SMSXLicense"
            'dsLicenseDetail.Tables(0).TableName = "License"
            'dsLicenseDetail.Tables(1).TableName = "LicenseTerminal"
            'securityCode = Functions.EncryptString128Bit(HttpUtility.UrlDecode(securityCode), ConfigurationManager.AppSettings("128BitDecryptionKey"))

            Try
                'Update the details in the sms db via webservice.
                'Dim objSMSWebservice As New se.PortalServices
                'Dim serviceResponse As Integer = objSMSWebservice.UpdateModifiedSMSLicenses(securityCode, Functions.CompressDataSet(dsLicenseDetail))
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddQS", String.Empty, String.Empty, String.Empty)
            End Try

        End If
        If e.CommandName = "DeleteLicense" Then
            Dim Id As Integer = e.CommandArgument
            Dim objLicenseQsDetail As New Portal.BLL.QsLicenseManagment
            objLicenseQsDetail.UserID = Session("AdminID")
            objLicenseQsDetail.LicenseID = LicenseID
            objLicenseQsDetail.LicenseTerminalID = Id
            objLicenseQsDetail.Changes = "Delete the Terminal No " & Id
            objLicenseQsDetail.AddQsLicenseTerminalLog()
            Portal.BLL.QsLicenseManagment.DeleteQsLicense(Id)
            LoadQsLicenseDetail()
            upnlTerminals.Update()
            gvwQsLicienseTerminal.DataBind()
            upKeys.Update()

            Try
            Catch ex As Exception
                ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "DeleteQSLicense", String.Empty, String.Empty, String.Empty)
            End Try

        End If
    End Sub

    Protected Function FormatDate(ByVal Dates As Date)
        Return Dates.ToString("dd:mm:yyy")
    End Function
    Protected Sub MakeActiveInactive(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub gvwQsLicienseTerminal_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwQsLicienseTerminal.RowDataBound
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
        Dim drFranchises As System.Data.SqlClient.SqlDataReader = Portal.BLL.QsLicenseManagment.GETQsFranchiseIDByStoreNumber(StoreNo, ClientID)
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
            .Subject = "<b>Qs License</b>"
            .Type = Portal.BLL.Enumeration.ActivityType.Installation
            .SubType = Portal.BLL.Enumeration.ActivitySubType.Installation
            .TimeSpent = TimeSpan.Zero
            .FranchiseID = 0 'CInt(hdnFranchiseID.Value)
            .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
            .Description = "<strong>New Qs License generated</strong><br><br>" & strTerminals.ToString
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
End Class