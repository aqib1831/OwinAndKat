Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Collections.Generic
Imports System.Data.SqlClient
Partial Class MyNetsolace_AddActivity
    Inherits System.Web.UI.Page
       
    Dim WaitingForID As String = "0"
    Dim doBindControl As Boolean = False
    Dim objConnectionStringSettings As ConnectionStringSettings
    Const GeneralTicket As Integer = Integer.MaxValue

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtDueDate.Text = DateTime.Now.ToString(" MMMM dd,yyyy hh:mm:ss tt")
        If Page.IsPostBack = False Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeSelected", "parent.SetTrBackGround(3);", True)
            ddlStores.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Search...", "0"))
            If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
                hdnID.Value = HttpContext.Current.Request.QueryString("ID").ToString()
            End If
            If Session("FranchiseContactID") Is Nothing Then
                If Not Session("MyNetsolace_ClientContactID") Is Nothing Then
                    trContactList.Style.Add("display", "inline")
                End If
            End If

            If Not Session("MyNetsolace_AreaDeveloperID") Is Nothing Then
                hdnAreaDeveloperID.Value = Session("MyNetsolace_AreaDeveloperID")
            Else
                hdnAreaDeveloperID.Value = 0        'Setting default value as 0 to ingore area developer
            End If

            If (String.IsNullOrEmpty(Request.QueryString("New")) = False) Then
                trStoreList.Style.Add("Display", "Inline")
            End If
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDiv", "showHideVital();", True)
            If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
                hdnFranchiseID.Value = HttpContext.Current.Request.QueryString("FranchiseID").ToString()
            End If
            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                hdnClientID.Value = Request.QueryString("ClientID")
            End If

            If (String.IsNullOrEmpty(Request.QueryString("FranchiseId")) = False) Then
                lblFranchiseName.Text = Portal.BLL.Franchises.GetStoreNickByFranchiseID(CInt(hdnFranchiseID.Value))
                trStoreName.Style.Add("Display", "Inline")
            End If

            doBindControl = True
            FillAttachmentsValidations()
        End If

        If Not String.IsNullOrEmpty(Request.QueryString("FranchiseId")) Then
            sdsContacts.SelectParameters.Item("FranchiseID").DefaultValue = Request.QueryString("FranchiseId")
        Else
            sdsContacts.SelectParameters.Item("FranchiseID").DefaultValue = ddlStores.Value
        End If

    End Sub
    Private Sub FillAttachmentsValidations()
        REV_file1.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file1.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file2.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file2.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file3.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file3.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
    End Sub
    Protected Sub ddlWaitingFor_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWaitingFor.DataBound
        If Not ddlWaitingFor.Items.Contains(New ListItem("Select...", "0")) Then
            ddlWaitingFor.Items.Insert(0, New ListItem("Select...", "0"))
        End If        
    End Sub
    Protected Sub ddlFranchiseContact_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFranchiseContact.DataBound
        ddlFranchiseContact.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub
    
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim Client As Integer = hdnClientID.Value
        Dim ObjectActivity As New Portal.BLL.Activities()
        Dim ActivityID As Integer = 0
        If Page.IsValid Then
            With ObjectActivity
                .Subject = txtActivitySubject.Text.Trim
                .Type = Enumeration.ActivityType.HelpDesk
                .SubType = Enumeration.ActivitySubType.General
                .TimeSpent = TimeSpan.Parse("00:00")
                .AdminID = 0                
                If Not Session("FranchiseContactID") Is Nothing Then
                    .PlacedBy = Enumeration.PlacedBy.Franchisee
                    .ClientContactID = 0
                    .FranchiseContactID = Session("FranchiseContactID")
                Else
                    If Not Session("MyNetsolace_ClientContactID") Is Nothing Then
                        .FranchiseContactID = ddlFranchiseContact.SelectedValue
                        .PlacedBy = Enumeration.PlacedBy.Corporate
                        .ClientContactID = CInt(Session("MyNetsolace_ClientContactID"))
                    End If
                End If
                .WaitingFor = 0
                .FranchiseID = CInt(hdnFranchiseID.Value)
                .DepartmentID = Enumeration.EAI_DepartmentID.Netsolace      'Specify the department id for netsolace.
                .ActivityState = Enumeration.ActivityState.NotStarted
                .Description = txtDescription.Text.Trim
                .ActivityDate = DateTime.Now
                .Status = False
                .AdminInboxStatus = 0
                .RelatedTo = ddlProducts.SelectedValue
                .ModuleId = ddlModule.SelectedValue

                ActivityID = .ActivitiesAdd(CInt(hdnClientID.Value), .FranchiseID, .AdminID, .DepartmentID, .FranchiseContactID, .TimeSpent.ToString(), .ActivityDate, .Type, .SubType, .Subject, .Description, .Status, .PlacedBy, .ActivityState, .WaitingFor, .AdminInboxStatus, False, .ClientContactID, .RelatedTo, .ModuleId)
                hdnID.Value = ActivityID.ToString()
            End With
            If ActivityID > 0 Then
                Dim intNewNotesID As Integer = 0
                Dim objActivityAttachement As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
                With objActivityAttachement
                    .ActivityID = ActivityID        'Specifying the activity ID for Which the attachements Are                    
                    .NotesID = 0                    'Specifying the Notes ID as 0 in case the attachement is for activity

                    Dim DirectoryName As String = Functions.GetDateTimeUniqueString()
                    If file1.FileName <> Nothing Then
                        .SaveAttachments(DirectoryName, file1)
                    End If
                    If file2.FileName <> Nothing Then
                        .SaveAttachments(DirectoryName, file2)
                    End If
                    If file3.FileName <> Nothing Then
                        .SaveAttachments(DirectoryName, file3)
                    End If
                    'Returning back to the page.
                    Dim PreviousPage As Integer = CInt(Request.QueryString("PrevPage"))
                    Select Case PreviousPage
                        Case 2
                            Response.Redirect("Franchisor_StoreInbox.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value)
                            Exit Select
                        Case 3
                            Response.Redirect("FranchisorInbox.aspx?ClientID=" & hdnClientID.Value)
                            Exit Select
                        Case 5
                            Response.Redirect("FranchisorInbox.aspx?ClientID=" & hdnClientID.Value)
                            Exit Select
                        Case Else
                            Response.Redirect("ActivityDetail.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value & "&PrevPage=2" & "&ID=" & ActivityID)
                            Exit Select
                    End Select
                End With
            End If
        End If
    End Sub

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Dim PreviousPage As Integer = CInt(Request.QueryString("PrevPage"))
        Select Case PreviousPage
            Case 2
                Response.Redirect("Franchisor_StoreInbox.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value)
                Exit Select
            Case 3
                Response.Redirect("FranchisorInbox.aspx?ClientID=" & hdnClientID.Value)
                Exit Select
            Case 5                
                Response.Redirect("FranchisorHistory.aspx?ClientID=" & hdnClientID.Value)
                Exit Select
        End Select
    End Sub

    'Protected Sub ddlStores_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlStores.DataBound
    '    ddlStores.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select...", "0"))
    'End Sub
    Protected Sub ddlStores_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlStores.ItemsRequested
        LoadStores(e.Text)
    End Sub

    Protected Sub ddlProducts_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.DataBound
        ddlProducts.Items.Insert(0, New ListItem("Select..", "0"))
        ddlProducts.Items.Add(New ListItem("General Ticket", GeneralTicket))
    End Sub

    Private Sub LoadStores(ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@ClientID", hdnClientID.Value)
        db.AddParameter("@AreaDeveloperID", hdnAreaDeveloperID.Value)
        db.AddParameter("@Search", byvalsearch)
        dt = db.ExecuteDataTable("Franchises_GetAll_ByClientID")
        ddlStores.DataSource = dt
        ddlStores.DataBind()
    End Sub

    Protected Sub ddlStores_SelectedIndexChanged(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxSelectedIndexChangedEventArgs) Handles ddlStores.SelectedIndexChanged
        If ddlStores.Value <> "" Then
            ddlFranchiseContact.DataBind()
            hdnFranchiseID.Value = ddlStores.Value
        Else
            ddlFranchiseContact.Items.Clear()
            ddlFranchiseContact.Items.Insert(0, New ListItem("Select...", "0"))
        End If
    End Sub

    Protected Sub ddlModule_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlModule.DataBound
        If ddlProducts.SelectedValue <> 0 AndAlso ddlModule.Items.Count = 0 Then
            ddlModule.Items.Add(New ListItem("Not Applicable", GeneralTicket))
        End If

        If ddlProducts.SelectedValue <> GeneralTicket Then
            ddlModule.Items.Insert(0, New ListItem("Select..", "0"))
        End If
    End Sub

    Protected Sub ddlProducts_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.SelectedIndexChanged
        If ddlProducts.SelectedValue = GeneralTicket Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "HideTr_Module", "SetModuleDisplay('none');", True)
        Else
            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ShowTr_Module", "SetModuleDisplay('inline');", True)
        End If
    End Sub

    Protected Sub sdsContacts_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles sdsContacts.Selecting
       
    End Sub

End Class
