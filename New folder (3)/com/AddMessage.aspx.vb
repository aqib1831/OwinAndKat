Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Collections.Generic
Imports System.Data.SqlClient
Partial Class AddActivity
    Inherits System.Web.UI.Page
    Protected ObjTickets As PM.PM_Ticket_Features
    'Dim WaitingForID As String = "0"
    Dim colEAFranchise As New List(Of Franchises)()
    'Dim colFrutationFranchise As New List(Of FR_Franchise)()
    'Dim colTicket_Features As New List(Of PM.PM_Ticket_Features)()
    Dim doBindControl As Boolean = False
    Dim objActivity As New List(Of Portal.BLL.Activities)()
    Dim objConnectionStringSettings As ConnectionStringSettings


    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtDueDate.Text = DateTime.Now.ToString("MMM dd, yyyy hh:mm:ss tt")
        If Not Page.IsPostBack Then
            If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
                hdnID.Value = HttpContext.Current.Request.QueryString("ID").ToString()
            End If
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDiv", "showHideVital();", True)
            If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
                hdnFranchiseID.Value = HttpContext.Current.Request.QueryString("FranchiseID").ToString()
            End If
            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                hdnClientID.Value = Request.QueryString("ClientID").ToString()
            End If

            doBindControl = True
            FillAttachmentsValidations()
            FillddlTopicDataSource()
            ddlTopic.SelectedValue = ActivityTopic.com_Activities_Topic_GetTopicIDByUserID(Session("AdminID"))
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not IsPostBack Then
            BindEAFranchise()
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
    Protected Sub BindEAFranchise()
        lblFranchiseName.Text = Portal.BLL.Franchises.GetStoreNickByFranchiseID(CInt(hdnFranchiseID.Value))
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'Dim Client As Integer = CInt(hdnClientID.Value)
        Dim ObjMail As Portal.BLL.Email = New Email()

        Dim ObjectActivity As New Portal.BLL.Activities
        Dim ActivityID As Integer = 0
        If Page.IsValid Then
            With ObjectActivity
                .Subject = txtActivitySubject.Text.Trim
                .Type = Portal.BLL.Enumeration.ActivityType.Message
                .SubType = ddlTopic.SelectedValue
                .TimeSpent = TimeSpan.Parse(ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue)
                .FranchiseContactID = ddlFranchiseContact.SelectedValue
                .FranchiseID = CInt(hdnFranchiseID.Value)
                .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
                .Description = txtDescription.Text.Trim
                .ActivityDate = DateTime.Now
                .ActivityState = Portal.BLL.Enumeration.ActivityState.NotStarted
                .WaitingFor = "0"
                .Charge = chkCharge.Checked
                .Status = False
                .AdminInboxStatus = 0
                .ClientContactID = 0
                .PlacedBy = Enumeration.PlacedBy.PortalAdmin
                .UserID = CInt(Session("AdminID"))
                .Priority = ddlPriority.SelectedValue
                .ClientID = CInt(hdnClientID.Value)
                .Charge = False
                ActivityID = .ActivitiesAdd(ObjectActivity)
                'ActivityID = .ActivitiesAdd(Client, .FranchiseID, .AdminID, .DepartmentID, .FranchiseContactID, .TimeSpent.ToString(), .ActivityDate, .Type, .SubType, .Subject, .Description, .Status, True, .ActivityState, .WaitingFor, .AdminInboxStatus, .Charge, .ClientContactID)
                hdnID.Value = ActivityID.ToString()
            End With
            If ActivityID > 0 Then
                Dim objActivityAttachement As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
                Dim intNewNotesID As Integer = 0
                With objActivityAttachement
                    .ActivityID = ActivityID     'The activity against which notes are to be added.               
                    .NotesID = 0         'If the attachement is not for a note then notes id must be zero
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
                    If ChkEmail.Checked = False Then
                        Response.Redirect("Franchise_Inbox.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value)
                    Else
                        Dim strMail As String = ""
                        With ObjMail
                            strMail = .GetNewMessageContent()
                            strMail = strMail.Replace("***Subject***", txtActivitySubject.Text.Trim)
                            strMail = strMail.Replace("***MessageID***", hdnID.Value)
                            strMail = strMail.Replace("***Date***", DateTime.Now.ToShortDateString())

                            colEAFranchise = Portal.BLL.Franchises.FranchiseGetByID(hdnClientID.Value, CInt(hdnFranchiseID.Value))
                            If colEAFranchise.Count > 0 Then
                                strMail = strMail.Replace("***OwnerName***", colEAFranchise.Item(0).OwnerName)
                                strMail = strMail.Replace("***Client***", "Edible Arrangements Corporate Team")
                                .MailTo = colEAFranchise.Item(0).CorporateEmail
                            End If

                            .DisplayName = CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).Firstname & " " & CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).Lastname
                            .MailFrom = CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).Email
                            .Subject = "Fransupport New Message Notification"
                            .Detail = strMail
                            .Send_mail()
                        End With
                        Response.Redirect("Franchise_Inbox.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value)
                    End If

                End With
            End If
        End If
    End Sub

    Protected Sub ddlTopic_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTopic.DataBound
        ddlTopic.Items.Insert(0, New ListItem("Select..", "0"))
    End Sub
    Private Sub FillddlTopicDataSource()
        Me.ddlTopic.DataValueField = "ID"
        Me.ddlTopic.DataTextField = "Topic"
        Me.ddlTopic.DataSourceID = Me.sdsTopics.ID
        Me.ddlTopic.DataBind()
        If CType(hdnClientID.Value, Integer) = Portal.BLL.Enumeration.ClientID.EA Then
            For i As Integer = ddlTopic.Items.Count - 1 To 0 Step -1
                If ddlTopic.Items(i).Text.Trim.ToLower = "select.." Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "general" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "notice" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "complaint" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "compliment" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "violation" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "weekly call" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "left message" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "hardware" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "accounts" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "management" Or _
                ddlTopic.Items(i).Text.Trim.ToLower = "support" Then
                    'Do Nothing
                Else
                    ddlTopic.Items.RemoveAt(i)
                End If
            Next
        End If
    End Sub
End Class
