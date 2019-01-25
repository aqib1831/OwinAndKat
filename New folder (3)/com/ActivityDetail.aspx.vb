Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Collections.Generic
Imports System.Data.SqlClient

Partial Class ActivityDetail
    Inherits System.Web.UI.Page

    Dim WaitingForID As String = "0"
    Dim colEAFranchise As New List(Of Franchises)()
    'Dim colFrutationFranchise As New List(Of FR_Franchise)()
    Dim doBindControl As Boolean = False
    Dim objActivity As New List(Of Portal.BLL.Activities)()
    Dim objConnectionStringSettings As ConnectionStringSettings



    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        'IIf(String.IsNullOrEmpty(Request.QueryString("FranchiseID")), "0", Request.QueryString("FranchiseID").ToString())
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            hdnHasSupportAccess.Value = HasSupportAccess()
            If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
                hdnID.Value = HttpContext.Current.Request.QueryString("ID").ToString()
            End If
            '.RegisterStartupScript(Me, Me.GetType(), "ShowDiv", "showHideVital();", True)
            If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
                hdnFranchiseID.Value = HttpContext.Current.Request.QueryString("FranchiseID").ToString()
            End If
            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                hdnClientID.Value = Request.QueryString("ClientID").ToString()
                Dim colClients As New System.Collections.Generic.List(Of Portal.BLL.Client.Clients)()
                colClients = Portal.BLL.Client.Clients.ClientsGetByID(CInt(hdnClientID.Value))
                If (colClients.Count > 0) Then
                    lblClient.Text = colClients.Item(0).Name
                End If
            End If
            ddlWaitingFor.DataBind()
            If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
                Select Case CInt(Request.QueryString("PrevPage"))
                    Case 1 'Home
                        btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx?ClientID=" & hdnClientID.Value) & "'; return false; ")
                    Case 2 'Admin In Box Page
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("Admin_History.aspx?" & Request.QueryString().ToString()) & "'; return false; ")
                    Case 3 'Franchisee History Page
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("Franchise_History.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value) & "'; return false; ")
                    Case 4 'Admin History Page
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("Admin_Inbox.aspx?" & Request.QueryString().ToString()) & "'; return false; ")
                    Case 5 'Franchisee History Page
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("Franchise_Inbox.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value) & "'; return false; ")
                    Case Else
                        btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx?ClientID=" & hdnClientID.Value) & "'; return false; ")
                End Select
            End If
            MakePriorityVisible()
            doBindControl = True
            ddlActivityStatus.Attributes.Add("onchange", "javascript:if (activityStateChange()==false) return false;")
            FillAttachmentsValidations()

            lblPBPRemainingCharacters.Text = 4000 - Me.txtNotes.Text.Length
        End If
    End Sub
    Private Sub MakePriorityVisible()
        If CInt(Session("AdminID")) = Portal.BLL.Enumeration.Users.Mudassar_Shaikh _
            Or CInt(Session("AdminID")) = Portal.BLL.Enumeration.Users.Maggie_Rolon _
	    Or CInt(Session("AdminID")) = Portal.BLL.Enumeration.Users.Ali_Raza _
            Or CInt(Session("AdminID")) = Portal.BLL.Enumeration.Users.Michael_Aceto Then
            'spanddlPriority.Visible = True
            'spanlblPriority.Visible = False
        Else
            'spanlblPriority.Visible = True
            'spanddlPriority.Visible = False
        End If
        spanlblPriority.Visible = False
    End Sub
    Private Sub FillAttachmentsValidations()
        REV_file1.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file1.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file2.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file2.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file3.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file3.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        hdnRegularExprssion.Value = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
    End Sub
    Private Function HasSupportAccess() As Boolean
        Dim str As String() = CStr(Session("UsersModulesID")).Split(",")
        For i As Integer = 0 To str.Length - 1
            If IsNumeric(str(i)) AndAlso CInt(str(i)) = CInt(Portal.BLL.Enumeration.Modules.BillingSupport) Then
                Return True
            End If
        Next
        Return False
    End Function
    Protected Sub ddlWaitingFor_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWaitingFor.DataBound
        If Not ddlWaitingFor.Items.Contains(New ListItem("Select...", 0)) Then
            ddlWaitingFor.Items.Insert(0, New ListItem("Select...", 0))
        End If

        BindEAFranchise()

    End Sub

    Protected Sub rptrNotes_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrNotes.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rptrAttachments"), Repeater)
            Dim NotesID As Integer = CType(CType(e.Item.FindControl("lblID"), Label).Text, Integer)
            sdsAttachments.FilterExpression = "[NoteID] = " & NotesID.ToString
            rpt.DataSource = sdsAttachments
            rpt.DataBind()
            If rpt.Items.Count <= 0 Then
                rpt.Visible = False
            End If
        End If
    End Sub

    Protected Sub btnCloseNo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCloseNo.Click
        ddlClose.SelectedValue = 0
        Me.AddNotes()
        If ddlNotesType.SelectedValue = Portal.BLL.Enumeration.ActivityNotesType.PublicNote Then
            If (CInt(hdnType.Value) = Enumeration.ActivityType.HelpDesk) Or (CInt(hdnType.Value) = Enumeration.ActivityType.Message) Then
                Portal.BLL.Activities.SendActivityMail(0, CInt(hdnClientID.Value), CInt(hdnFranchiseID.Value), Portal.BLL.Activities.ActivityEmailType.PublicNotes, lblTicketNumber.Text, lblActivitySubject.Text, lblFranchiseName.Text, "has been updated")
            End If
        End If
    End Sub

    Protected Sub AddNotes()
        Dim ObjectActivity As New Portal.BLL.Activities()
        Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
        Dim intNewNotesID As Integer = 0
        With objActivityNotes
            .ActivityID = CInt(hdnID.Value)
            .NotesType = CType(ddlNotesType.SelectedValue, Portal.BLL.Enumeration.ActivityNotesType)
            .Notes = txtNotes.Text.Trim
            'Both should be zero coz the notes are submitted by admin
            .ClientContactID = 0
            .FranchiseContactID = 0
            .PlacedBy = Enumeration.PlacedBy.PortalAdmin
            .AdminID = CInt(Session("AdminID"))
            .NotesDate = DateTime.Now
            intNewNotesID = .AddNotes()
        End With

        'Updating the Time spent
        ObjectActivity.ID = CType(hdnID.Value, Integer)
        ObjectActivity.TimeSpent = TimeSpan.Parse(lblTimeSpent.ToolTip).Add(TimeSpan.Parse(ddlHours.SelectedValue & ":" & ddlMinutes.SelectedValue))

        If intNewNotesID > 0 AndAlso ObjectActivity.UpdateTimeSpent(CInt(hdnClientID.Value), ObjectActivity) Then
            Dim DirectoryName As String = Functions.GetDateTimeUniqueString()
            Dim objActivityAttahcments As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
            With objActivityAttahcments
                .NotesID = intNewNotesID
                .ActivityID = 0
                If file1.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file1)
                End If
                If file2.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file2)
                End If
                If file3.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file3)
                End If
            End With
            txtNotes.Text = ""
            ddlHours.SelectedValue = 0
            ddlMinutes.SelectedValue = 0
            rptrNotes.DataSourceID = sdsNotes.ID
            rptrNotes.DataBind()
            doBindControl = True
        End If

    End Sub

    Protected Sub btnUpdateDueDate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateDueDate.Click
        'Dim Client As Integer = CInt(IIf(hdnClientID.Value = "0", "1", hdnClientID.Value))
        'ObjectActivity = New Portal.BLL.Activities()
        'ObjectActivity.ID = CType(hdnID.Value, Integer)
        'ObjectActivity.TimeSpent = TimeSpan.Parse(ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue)
        'If ObjectActivity.UpdateTimeSpent(Client, ObjectActivity) Then
        '    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateMessageScript", "ShowUpdateMessage();", True)
        'End If
    End Sub

    Public Sub BindControl()

        objActivity = Portal.BLL.Activities.GetActivityByID(CInt(hdnClientID.Value), CInt(hdnID.Value))

        If objActivity.Count > 0 Then            
            ' Bind Notes Data 
			If objActivity.Item(0).Type = Portal.BLL.Enumeration.ActivityType.SMS_X Then
                SMSXLink.Visible = False
            Else
                SMSXLink.Visible = False
            End If
            lbladminName.Text = objActivity.Item(0).AdminName
            ViewState("PlacedBy") = objActivity.Item(0).PlacedBy
            lblDate.Text = CDate(Functions.IfNull(objActivity.Item(0).ActivityDate, Date.Now)).ToString("MMMM dd, yyyy hh:mm:ss tt") & "<i> ( EST )</i>"
            'lblDescription.Text = objActivity.Item(0).Description.ToString().Replace(vbCrLf, "</br>")

	If objActivity.Item(0).Type = Enumeration.ActivityType.HelpDesk Then
	    If objActivity.Item(0).Description.ToString().Contains("<") Then
                lblDescription.Text = objActivity.Item(0).Description.ToString()
            Else
                lblDescription.Text = objActivity.Item(0).Description.ToString().Replace(vbCrLf, "<br/>")
            End If
        Else
	    lblDescription.Text = objActivity.Item(0).Description.ToString().Replace(vbCrLf, "</br>")
        End If


	    lblSMSXDescription.Text = GetLetterText(objActivity.Item(0).Description.ToString())
            ' Bind Activity Data
            lblPriority.Text = Functions.GetActivityPriorityByID(objActivity.Item(0).Priority)
            ddlPriority.SelectedValue = objActivity.Item(0).Priority
            ddlActivityStatus.SelectedValue = objActivity.Item(0).ActivityState
            lblContactName.Text = Functions.StringTruncate(objActivity.Item(0).FranchiseeContactName, 20)
            lblContactName.ToolTip = objActivity.Item(0).FranchiseeContactName
            lblActivitySubject.Text = Functions.StringTruncate(objActivity.Item(0).Subject, 100)
			hdnSubject.Value = lblActivitySubject.Text
            lblActivityType.Text = Functions.getActivityCaption(objActivity.Item(0).Type)
            lblRelatedTo.Text = objActivity.Item(0).RelatedTitle
			hdnRelatedTo.Value = objActivity.Item(0).RelatedTo
            lblTo.Text = objActivity.Item(0).ContactEmail
            txtSubject.Text = objActivity.Item(0).Subject.ToString
            If objActivity.Item(0).ModuleId = 0 Then
                TD_Module.InnerHtml = String.Empty
                lblProductModule.Visible = False
            Else
                lblProductModule.Text = objActivity.Item(0).ModuleName
            End If

            If CType(hdnClientID.Value, Integer) = Portal.BLL.Enumeration.ClientID.EA Then
                lblSubType.Text = Functions.GetSubTypeCaption(objActivity.Item(0).SubType)
            Else
                lblSubType.Text = Functions.IfNull(objActivity.Item(0).ActivityTopic.ToString(), "")
            End If
            lblTicketNumber.Text = Functions.GetActivityPrefix(objActivity.Item(0).Type) & objActivity.Item(0).ID
			hdnTicket.Value = lblTicketNumber.Text
            hdnType.Value = objActivity.Item(0).Type
            If CInt(objActivity.Item(0).Type) = 1 Or CInt(objActivity.Item(0).Type) = 2 Or CInt(objActivity.Item(0).Type) = 17 Then
                ddlNotesType.Visible = True
                ddlNotesType.SelectedValue = 0
                lblNotesType.Visible = False
            End If
            lblAssignBy.Text = objActivity.Item(0).AdminName
            Dim Item As ListItem = Nothing
            'ddlHoursNotes.SelectedValue = objActivity.Item(0).TimeSpent.Hours
            'ddlMinutesNotes.SelectedValue = objActivity.Item(0).TimeSpent.Minutes
            lblActivityDueDate.Text = DateTime.Parse(Functions.IfNull(objActivity.Item(0).ActivityDate, System.DateTime.Now)).ToString("MMMM dd, yyyy")
            hdnDueDate.Value = Functions.IfNull(objActivity.Item(0).ActivityDate, System.DateTime.Now)
            If (CInt(ddlActivityStatus.SelectedValue) = Portal.BLL.Enumeration.ActivityState.WaitingFor) Then
                waitingfor.Attributes.Add("style", "display:inline;")
                WaitingForID = objActivity.Item(0).WaitingFor
            Else
                waitingfor.Attributes.Add("style", "display:none;")
            End If
            hdnIsClose.Value = objActivity.Item(0).Status
            If objActivity.Item(0).Status = True Then
                divStatus.Attributes.Add("style", "display:none;")
                divClose.Attributes.Add("style", "display:inline;")
                waitingfor.Attributes.Add("style", "display:none;")
                btnAddNotes.Style.Add("Display", "None")
                'divTime.Visible = False
                lblActivityDueDate.Visible = True
                'lblTimeSpent.Visible = True
            Else
                divStatus.Attributes.Add("style", "display:inline;")
                divClose.Attributes.Add("style", "display:none;")

                btnAddNotes.Style.Add("Display", "Inline")
                'lblTimeSpent.Visible = False
                'divTime.Visible = True
            End If
            If objActivity.Item(0).Status = True Then
                Dim dt As Data.DataTable = Portal.BLL.Com.com_Activities_Feedback.com_Activities_FeedbackGetByID(hdnID.Value)

                If dt.Rows.Count > 0 Then
                    Dim Promptness As Integer = Functions.IfNull(dt.Rows(0).Item("Promptness"), 0)
                    Dim Courteousness As Integer = Functions.IfNull(dt.Rows(0).Item("Courteousness"), 0)
                    Dim Clarity As Integer = Functions.IfNull(dt.Rows(0).Item("Clarity"), 0)
                    Dim Knowledgeable As Integer = Functions.IfNull(dt.Rows(0).Item("Knowledgeable"), 0)
                    Dim Rate As Integer = Functions.IfNull(dt.Rows(0).Item("Rate"), 0)
                    Dim RateComments As String = Functions.IfNull(dt.Rows(0).Item("RateComments"), "")
                    If Rate > 0 Then
                        'tblRating.Visible = True
                        tblRating.Style.Add("display", "block")
                        lblPromptness.Text = IIf(Promptness = 0, "Not Rated", IIf(Promptness = 1, "Poor", IIf(Promptness = 2, "Fair", IIf(Promptness = 3, "Good", "Excellent"))))
                        lblCourteousness.Text = IIf(Courteousness = 0, "Not Rated", IIf(Courteousness = 1, "Poor", IIf(Courteousness = 2, "Fair", IIf(Courteousness = 3, "Good", "Excellent"))))
                        lblClarity.Text = IIf(Clarity = 0, "Not Rated", IIf(Clarity = 1, "Poor", IIf(Clarity = 2, "Fair", IIf(Clarity = 3, "Good", "Excellent"))))
                        lblKnowledgeable.Text = IIf(Knowledgeable = 0, "Not Rated", IIf(Knowledgeable = 1, "Poor", IIf(Knowledgeable = 2, "Fair", IIf(Knowledgeable = 3, "Good", "Excellent"))))
                        lblOverallExperience.Text = IIf(Rate = 0, "Not Rated", IIf(Rate = 1, "Poor", IIf(Rate = 2, "Fair", IIf(Rate = 3, "Good", "Excellent"))))

                        If (RateComments.Trim = "") Then
                            spancomments.Visible = False
                        Else
                            lblComments.Text = RateComments.Replace(vbCrLf, "</br>")
                        End If

                    Else
                        'tblRating.Visible = False
                        tblRating.Style.Add("display", "none")
                    End If
                Else
                    'tblRating.Visible = False
                    tblRating.Style.Add("display", "none")
                End If
            Else
                'tblRating.Visible = False
                tblRating.Style.Add("display", "none")
            End If
            UpdatePanel2.Update()
            If (objActivity.Item(0).TimeSpent.ToString().Remove(5, 3) = "00:00") Then
                ltrlTimeSpent.Visible = False
                lblTimeSpent.Style.Add("Display", "none")
                lblTimeSpent.ToolTip = objActivity.Item(0).TimeSpent.ToString().Substring(0, objActivity.Item(0).TimeSpent.ToString().Length - 3)
                lblTimeSpent.Text = FormatNumber(objActivity.Item(0).TimeSpent.TotalHours, 0).PadLeft(2, "0") & ":" & objActivity.Item(0).TimeSpent.Minutes.ToString.PadLeft(2, "0")
            Else
                ltrlTimeSpent.Visible = True
                lblTimeSpent.Style.Add("Display", "inline")
                lblTimeSpent.ToolTip = objActivity.Item(0).TimeSpent.ToString().Substring(0, objActivity.Item(0).TimeSpent.ToString().Length - 3)
                lblTimeSpent.Text = FormatNumber(objActivity.Item(0).TimeSpent.TotalHours, 0).PadLeft(2, "0") & ":" & objActivity.Item(0).TimeSpent.Minutes.ToString.PadLeft(2, "0")
            End If


            Item = ddlWaitingFor.Items.FindByValue(WaitingForID)
            If Not Item Is Nothing Then
                ddlWaitingFor.SelectedItem.Selected = False
                ddlWaitingFor.Items.FindByValue(WaitingForID).Selected = True
            End If
        End If

    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not IsPostBack Then
            BindControl()
        Else
            If doBindControl Then                
                BindControl()
            End If
        End If
    End Sub
    Protected Sub ddlClose_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClose.SelectedIndexChanged
        CloseActivity()
    End Sub

    Protected Sub ddlWaitingFor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWaitingFor.SelectedIndexChanged
        Dim Client As Integer = hdnClientID.Value
        Dim intNewNotesID As Integer = 0
        Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
        Dim ObjectActivity As New Portal.BLL.Activities()
        ' set waiting for franchise means the ticket has been close
        If ddlWaitingFor.SelectedValue.Substring(0, 1) = "F" Then
            ddlClose.SelectedValue = 1
            CloseActivity()
            Portal.BLL.Activities.SendActivityMail(ddlWaitingFor.SelectedValue, CInt(hdnClientID.Value), CInt(hdnFranchiseID.Value), Portal.BLL.Activities.ActivityEmailType.WaitingFor, lblTicketNumber.Text, lblActivitySubject.Text, lblFranchiseName.Text, "has been updated")
            Return ' do not execute further code
        End If
        'Adding notes every time the activity status is being changed.
        With objActivityNotes
            .ActivityID = CInt(hdnID.Value)
            .NotesType = Portal.BLL.Enumeration.ActivityNotesType.PrivateNote
            .Notes = "Activity has been set " & ddlActivityStatus.SelectedItem.Text & " <b>" & ddlWaitingFor.SelectedItem.Text & "</b>"
            .PlacedBy = Enumeration.PlacedBy.PortalAdmin
            .AdminID = CInt(Session("AdminID"))
            .ClientContactID = 0
            .FranchiseContactID = 0
            .NotesDate = DateTime.Now
            intNewNotesID = .AddNotes()
        End With
        'Changing the state of the Activity to waiting for in DB
        ObjectActivity.ID = CType(hdnID.Value, Integer)
        ObjectActivity.ActivityState = CInt(ddlActivityStatus.SelectedValue)
        ObjectActivity.WaitingForID = ddlWaitingFor.SelectedValue
        If ObjectActivity.UpdateActivityState(Client, ObjectActivity) Then
            doBindControl = True
        End If
        If ddlWaitingFor.SelectedValue.Substring(0, 1) = "A" Then
            'send email to any admin of portal of any type of ticket
            Portal.BLL.Activities.SendActivityMail(ddlWaitingFor.SelectedValue, CInt(hdnClientID.Value), CInt(hdnFranchiseID.Value), Portal.BLL.Activities.ActivityEmailType.WaitingFor, lblTicketNumber.Text, lblActivitySubject.Text, lblFranchiseName.Text, "has been updated")
        ElseIf (CInt(hdnType.Value) = Enumeration.ActivityType.HelpDesk) Or (CInt(hdnType.Value) = Enumeration.ActivityType.Message) Then
            'send email to client contact of helpdesk and message type only
            Portal.BLL.Activities.SendActivityMail(ddlWaitingFor.SelectedValue, CInt(hdnClientID.Value), CInt(hdnFranchiseID.Value), Portal.BLL.Activities.ActivityEmailType.WaitingFor, lblTicketNumber.Text, lblActivitySubject.Text, lblFranchiseName.Text, "has been updated")
        End If
        rptrNotes.DataBind()
        UpdatePanel2.Update()
    End Sub


    Protected Sub ddlActivityStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlActivityStatus.SelectedIndexChanged
        Dim intNewNotesID As Integer = 0
        Dim Client = CInt(hdnClientID.Value)
        Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
        Dim ObjectActivity As New Portal.BLL.Activities()
        If (CInt(ddlActivityStatus.SelectedValue) = Enumeration.ActivityState.Completed) Then     'Incase the activity status is completed
            With objActivityNotes
                .ActivityID = CInt(hdnID.Value)
                .NotesType = Portal.BLL.Enumeration.ActivityNotesType.PrivateNote
                .Notes = "Ticket has been closed."
                .PlacedBy = Enumeration.PlacedBy.PortalAdmin
                .AdminID = CInt(Session("AdminID"))
                .ClientContactID = 0
                .FranchiseContactID = 0
                .NotesDate = DateTime.Now
                intNewNotesID = .AddNotes()                
            End With
            With ObjectActivity
                .ID = CType(hdnID.Value, Integer)
                .ActivityState = Enumeration.ActivityState.Completed
                .WaitingForID = "0"
                .IsClose = True
                If ObjectActivity.UpdateActivityStatus(Client, ObjectActivity) Then
                    doBindControl = True
                End If
            End With
            rptrNotes.DataBind()
            UpdatePanel2.Update()
        Else
            'Incase the activity status is changed to other than Waiting For
            If (CInt(ddlActivityStatus.SelectedValue) <> Portal.BLL.Enumeration.ActivityState.WaitingFor) Then
                With objActivityNotes
                    .ActivityID = CInt(hdnID.Value)
                    .ClientContactID = 0
                    .FranchiseContactID = 0
                    .NotesType = Portal.BLL.Enumeration.ActivityNotesType.PrivateNote
                    .PlacedBy = Enumeration.PlacedBy.PortalAdmin
                    .Notes = "Activity has been set " & ddlActivityStatus.SelectedItem.Text
                    .AdminID = CInt(Session("AdminID"))
                    .NotesDate = DateTime.Now
                    intNewNotesID = .AddNotes()                    
                End With
                'Changing the activity State if it is not completed
                With ObjectActivity
                    .ID = CType(hdnID.Value, Integer)
                    .ActivityState = ddlActivityStatus.SelectedValue
                    .WaitingForID = "0"
                    .AdminInboxStatus = 0
                    If ObjectActivity.UpdateActivityState(Client, ObjectActivity) Then
                        doBindControl = True
                    End If
                End With
                rptrNotes.DataBind()
                UpdatePanel2.Update()
            End If
        End If        
    End Sub

    Protected Sub btnCloseYes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCloseYes.Click
        ddlClose.SelectedValue = 1
        Me.AddNotes()
        If ddlNotesType.SelectedValue = Portal.BLL.Enumeration.ActivityNotesType.PublicNote Then
            If (CInt(hdnType.Value) = Enumeration.ActivityType.HelpDesk) Or (CInt(hdnType.Value) = Enumeration.ActivityType.Message) Then
                Portal.BLL.Activities.SendActivityMail(0, CInt(hdnClientID.Value), CInt(hdnFranchiseID.Value), Portal.BLL.Activities.ActivityEmailType.PublicNotes, lblTicketNumber.Text, lblActivitySubject.Text, lblFranchiseName.Text, "has been updated")
            End If
        End If
        CloseActivity()
    End Sub

    Protected Sub CloseActivity()
        Dim intNewNotesID As Integer = 0
        Dim Client As Integer = CInt(hdnClientID.Value)
        Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
        Dim ObjectActivity As New Portal.BLL.Activities()
        ObjectActivity.ID = CType(hdnID.Value, Integer)
        If CInt(ddlClose.SelectedValue) = 0 Then
            hdnIsClose.Value = "False"
            With objActivityNotes
                .ActivityID = CInt(hdnID.Value)
                .NotesType = Portal.BLL.Enumeration.ActivityNotesType.PrivateNote
                .Notes = "Ticket has been reopened"
                .PlacedBy = Enumeration.PlacedBy.PortalAdmin
                .AdminID = CInt(Session("AdminID"))
                .ClientContactID = 0
                .FranchiseContactID = 0
                .NotesDate = DateTime.Now
                intNewNotesID = .AddNotes()
            End With
            ObjectActivity.IsClose = False
            ObjectActivity.WaitingForID = "0"
            If ObjectActivity.UpdateActivityStatus(Client, ObjectActivity) Then
                doBindControl = True
            End If
            rptrNotes.DataBind()
            UpdatePanel2.Update()
        Else
            hdnIsClose.Value = "True"
            If (CInt(hdnType.Value) = Enumeration.ActivityType.HelpDesk) Then
                If (CInt(ViewState("PlacedBy")) = Enumeration.PlacedBy.Franchisee Or CInt(ViewState("PlacedBy")) = Enumeration.PlacedBy.Corporate) Then
                    With objActivityNotes
                        .ActivityID = CInt(hdnID.Value)
                        .NotesType = Portal.BLL.Enumeration.ActivityNotesType.PrivateNote
                        .Notes = "Ticket close request is sent to franchisee."
                        .PlacedBy = Enumeration.PlacedBy.PortalAdmin
						.AdminID = Session("AdminID")
                        .ClientContactID = 0
                        .FranchiseContactID = 0
                        .NotesDate = DateTime.Now
                        intNewNotesID = .AddNotes()
                    End With

                    'Set the activity Waiting For Franchisee
                    With ObjectActivity
                        .ID = CType(hdnID.Value, Integer)
                        .AdminInboxStatus = 1
                        .ActivityState = Enumeration.ActivityState.WaitingFor
                        ObjectActivity.WaitingForID = "F" & hdnFranchiseID.Value
                        If ObjectActivity.UpdateActivityState(Client, ObjectActivity) Then
                            doBindControl = True
                        End If
                    End With
                End If
            Else
                With objActivityNotes
                    .ActivityID = CInt(hdnID.Value)
                    .NotesType = Portal.BLL.Enumeration.ActivityNotesType.PrivateNote
                    .Notes = "Ticket has been closed."
                    .PlacedBy = Enumeration.PlacedBy.PortalAdmin
					.AdminID = Session("AdminID")
                    .ClientContactID = 0
                    .FranchiseContactID = 0
                    .NotesDate = DateTime.Now
                    intNewNotesID = .AddNotes()

                End With
                'Close the activity
                With ObjectActivity
                    .ID = CType(hdnID.Value, Integer)
                    .ActivityState = Enumeration.ActivityState.Completed
                    .WaitingForID = "0"
                    .IsClose = True
                    If ObjectActivity.UpdateActivityStatus(Client, ObjectActivity) Then
                        doBindControl = True
                    End If
                End With
        End If
        rptrNotes.DataBind()
        UpdatePanel2.Update()
        End If
    End Sub

    Protected Sub BindEAFranchise()
        lblFranchiseName.Text = Portal.BLL.Franchises.GetStoreNickByFranchiseID(CInt(hdnFranchiseID.Value))
    End Sub

    Protected Sub rptrStartActivityAttachments_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrStartActivityAttachments.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If rptrStartActivityAttachments.Items.Count <= 0 Then
                rptrStartActivityAttachments.Visible = False
            End If
        End If
    End Sub

    Protected Sub ddlPriority_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPriority.SelectedIndexChanged
        If ddlPriority.SelectedValue > 0 Then
            Portal.BLL.Activities.UpdateActivityPriority(hdnID.Value, ddlPriority.SelectedValue)
            If ddlPriority.SelectedValue = "5" Then
                Portal.BLL.Activities.SendMail("Support", "support@netsolace.com", lblActivitySubject.Text.Trim, "A ticket has been updated with cirtical priority", lblTicketNumber.Text, lblActivitySubject.Text.Trim, lblFranchiseName.Text)
	        'Portal.BLL.Activities.SendMail("Support", "sraza@broadpeakit.com", lblActivitySubject.Text.Trim, "A ticket has been updated with cirtical priority", lblTicketNumber.Text, lblActivitySubject.Text.Trim, lblFranchiseName.Text)

            End If
            Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
            objActivityNotes.ActivityID = CInt(hdnID.Value)
            objActivityNotes.NotesType = Portal.BLL.Enumeration.ActivityNotesType.PrivateNote
            objActivityNotes.Notes = "Priority has been changed to " & ddlPriority.SelectedItem.Text
            objActivityNotes.PlacedBy = Enumeration.PlacedBy.PortalAdmin
			objActivityNotes.AdminID = Session("AdminID")
            objActivityNotes.ClientContactID = 0
            objActivityNotes.FranchiseContactID = 0
            objActivityNotes.NotesDate = DateTime.Now
            objActivityNotes.AddNotes()
            rptrNotes.DataBind()
            UpdatePanel2.Update()
        End If
    End Sub
	
	    Public Function SendMail(ByVal Description As String, ByVal email As String)

        '   Dim strText As String = GetLetterText()
       
        Dim objEmail As New Portal.BLL.Email
        With objEmail
            .DisplayName = Session("Admin_Name")
            .MailTo = email
            .MailFrom = Session("Email")
            .Subject = txtSubject.Text.Trim
            .Detail = Description
            .Attachments = ""
            .Send_mail()
        End With

        objEmail = Nothing
    End Function

    Private Function GetLetterText(ByVal Description) As String

        Dim objStreamReader As IO.StreamReader
        Dim strReturn As String = String.Empty
        If IO.File.Exists(MapPath("../templates/SMS-XDownloadLink.htm")) Then
            objStreamReader = IO.File.OpenText(MapPath("../templates/SMS-XDownloadLink.htm"))
            strReturn = objStreamReader.ReadToEnd
            objStreamReader.Close()
        End If
        Dim strText As String = strReturn
        strText = strText.Replace("*****span*****", ConfigurationManager.AppSettings("SMS-XDowloadURL") & "?span=" & Functions.EncryptData(Date.Now))
        strText = strText.Replace("***Installation***", Description)
        Return strText
    End Function

    Protected Sub btnSendSMSX_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendSMSX.Click
        SendMail(lblSMSXDescription.Text.ToString.Trim(), lblTo.Text.Trim.ToString())
        SMSXAddNotes()
    End Sub
    Public Function SMSXAddNotes()
        Dim ObjectActivity As New Portal.BLL.Activities()
        Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
        Dim intNewNotesID As Integer = 0
        With objActivityNotes
            .ActivityID = CInt(hdnID.Value)
            .NotesType = Enumeration.ActivityNotesType.PublicNote
            .Notes = "SMSx Download link regenerated."
            'Both should be zero coz the notes are submitted by admin
            .ClientContactID = 0
            .FranchiseContactID = 0
            .PlacedBy = Enumeration.PlacedBy.PortalAdmin
            .AdminID = CInt(Session("AdminID"))
            .NotesDate = DateTime.Now
            intNewNotesID = .AddNotes()
        End With
        'Updating the Time spent
        ObjectActivity.ID = CType(hdnID.Value, Integer)
        ObjectActivity.TimeSpent = TimeSpan.Parse(lblTimeSpent.ToolTip).Add(TimeSpan.Parse(ddlHours.SelectedValue & ":" & ddlMinutes.SelectedValue))

        If intNewNotesID > 0 AndAlso ObjectActivity.UpdateTimeSpent(CInt(hdnClientID.Value), ObjectActivity) Then
            Dim DirectoryName As String = Functions.GetDateTimeUniqueString()
            Dim objActivityAttahcments As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
            With objActivityAttahcments
                .NotesID = intNewNotesID
                .ActivityID = 0
                If file1.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file1)
                End If
                If file2.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file2)
                End If
                If file3.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file3)
                End If
            End With
            txtNotes.Text = ""
            ddlHours.SelectedValue = 0
            ddlMinutes.SelectedValue = 0
            rptrNotes.DataSourceID = sdsNotes.ID
            rptrNotes.DataBind()
            doBindControl = True
        End If
        'Updating the Time spent
    End Function

End Class