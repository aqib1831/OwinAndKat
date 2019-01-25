										 Imports Microsoft.VisualBasic
Imports Portal.BLL.PM
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports Portal.BLL

Partial Class PM_TicketsDetail
    Inherits System.Web.UI.Page
    Protected ObjTickets As PM_Ticket_Features
    Dim ClientID As Integer = 0
    Dim ddlClients As String
    Dim ddlCategories As String
    Dim ddlTypes As String
    Dim ddlFilter As String
    Dim txtSearch As String
    Dim reClient As String
    Dim reCatagory As String
    Dim colTicket_Features As New List(Of PM_Ticket_Features)()

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Overloads Overrides Sub Render(ByVal writer As HtmlTextWriter)
        Dim mem As New System.IO.MemoryStream()
        Dim twr As New System.IO.StreamWriter(mem)
        Dim myWriter As System.Web.UI.HtmlTextWriter = New HtmlTextWriter(twr)
        MyBase.Render(myWriter)

        myWriter.Flush()
        myWriter.Dispose()

        Dim strmRdr As New System.IO.StreamReader(mem)
        strmRdr.BaseStream.Position = 0
        Dim pageContent As String = strmRdr.ReadToEnd()
        strmRdr.Dispose()
        mem.Dispose()

        'modify the page content as you like
        If Not Page.IsPostBack Then
            'Modify the page content as you like :-)
            'pageContent = Functions.RemoveWhitespaceFromCss(pageContent)
            'pageContent = Functions.RemoveWhitespaceFromJavaScript(pageContent)
            pageContent = Functions.RemoveWhitespaceFromHtml(pageContent)
        End If

        writer.Write(pageContent)
    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        ViewState("update") = Session("update")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
                ViewState("ClientID") = Nothing
                Session("update") = System.DateTime.Now.ToString()

                hdnID.Value = HttpContext.Current.Request.QueryString("ID").ToString()
                If String.IsNullOrEmpty(Request.QueryString("ReleaseID")) = False AndAlso IsNumeric(Request.QueryString("ReleaseID")) AndAlso CInt(Request.QueryString("ReleaseID")) <> 0 Then
                    IsRelease.Value = True
                    hdnReleaseID.Value = HttpContext.Current.Request.QueryString("ReleaseID").ToString()
                Else
                    IsRelease.Value = False
                End If

                If String.IsNullOrEmpty(Request.QueryString("ddlClients")) = False AndAlso IsNumeric(Request.QueryString("ddlClients")) Then
                    ddlClients = Session("MyNetsolace_ClientID") 'Request.QueryString("ddlClients")
                End If
                If String.IsNullOrEmpty(Request.QueryString("ddlCategories")) = False AndAlso IsNumeric(Request.QueryString("ddlCategories")) Then
                    ddlCategories = Request.QueryString("ddlCategories")
                End If
                If String.IsNullOrEmpty(Request.QueryString("reClients")) = False AndAlso IsNumeric(Request.QueryString("reClients")) Then
                    reClient = Request.QueryString("reClients")
                End If
                If String.IsNullOrEmpty(Request.QueryString("reCategories")) = False AndAlso IsNumeric(Request.QueryString("reCategories")) Then
                    reCatagory = Request.QueryString("reCategories")
                End If
                If String.IsNullOrEmpty(Request.QueryString("ddlTypes")) = False AndAlso IsNumeric(Request.QueryString("ddlTypes")) Then
                    ddlTypes = Request.QueryString("ddlTypes")
                End If
                If String.IsNullOrEmpty(Request.QueryString("ddlFilter")) = False AndAlso IsNumeric(Request.QueryString("ddlFilter")) Then
                    ddlFilter = Request.QueryString("ddlFilter")
                End If
                If String.IsNullOrEmpty(Request.QueryString("txtSearch")) = False AndAlso IsNumeric(Request.QueryString("txtSearch")) Then
                    txtSearch = Request.QueryString("txtSearch")
                End If

                If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                    ClientID = CInt(Request.QueryString("ClientID").ToString())
                End If
                If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
                    PrevPage.Value = CInt(Request.QueryString("PrevPage"))
                    Select Case PrevPage.Value
                        Case 1 'Home
                            'btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx" & IIf(ClientID <> 0, "?ClientID=" & ClientID, "")) & "'; return false; ")
                            'btnImptoFea.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/FeaturesEdit.aspx?FeatureID=" & hdnID.Value & "&PrevPage=1") & "'; return false; ")
                        Case 2 'Feature
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/AreaDeveloper/PM/Features.aspx?ID=" & hdnReleaseID.Value) & "&ddlClients=" & Session("MyNetsolace_ClientID") & "&ddlCategories=" & ddlCategories & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "&reClients=" & reClient & "&reCategories=" & reCatagory & "'; return false; ")
                        Case 4 'Tickets
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/AreaDeveloper/PM/Tickets.aspx?ddlClients=" & ddlClients) & "&ddlCategories=" & ddlCategories & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "'; return false; ")
                            'btnImptoFea.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/MyNetsolace/PM/FeaturesEdit.aspx?FeatureID=" & hdnID.Value & "&PrevPage=3") & "'; return false; ")
                        Case 3 'MyTickets
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/AreaDeveloper/PM/MyTickets.aspx?ddlClients=" & ddlClients) & "&ddlCategories=" & ddlCategories & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "'; return false; ")
                            'btnImptoFea.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/MyNetsolace/PM/FeaturesEdit.aspx?FeatureID=" & hdnID.Value & "&PrevPage=4") & "'; return false; ")
                        Case 5 'Tickets History
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/AreaDeveloper/PM/TicketsHistory.aspx?ddlClients=" & ddlClients) & "&ddlCategories=" & ddlCategories & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "'; return false; ")
                        Case Else
                            'btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx" & IIf(String.IsNullOrEmpty(Request.QueryString("ClientID")) = False, "?ClientID=" & Request.QueryString("ClientID").ToString(), "")) & "'; return false; ")
                    End Select
                End If
            End If

            If String.IsNullOrEmpty(Request.QueryString("NewTicket")) Then Portal.BLL.PM.PM_Ticket_Features.ChangeRead(hdnID.Value, True, Nothing, Session("MyNetsolace_ClientContactID"))
            'LoadRelease()
            'FillddlStatus()
            BindControl()
            ddlActivityStatus.Style.Add("display", "none")

            If ddlActivityStatus.SelectedValue = Enumeration.PMStatus.QAPhase Or ddlActivityStatus.SelectedValue = Enumeration.PMStatus.DevelopmentPhase Then
                lblActivityStatus.Text = "In Development Phase"
            Else
                lblActivityStatus.Text = ddlActivityStatus.SelectedItem.Text
            End If

            If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released Then
                contactsTable.Visible = False
            Else
                contactsTable.Visible = True
            End If
            FillAttachmentsValidations()
            ddlActivityStatus.Attributes.Add("onchange", "javascript:if (activityStateChange()==false) return false;")
            'CType(UpdatePanel1.FindControl("CV_FutureDate"), CompareValidator).ValueToCompare = DateTime.Now.ToShortDateString()
            hdnTimeSpent.Value = "00:00:00"
            Me.lBtnPrint.NavigateUrl = "TicketsReport.aspx?TicketID=" & Request.QueryString("ID")
        End If
    End Sub

    'Private Sub LoadRelease()
    '    If IsRelease.Value = True Then
    '        Dim objReleases As Portal.BLL.PM.PM_Releases = New Portal.BLL.PM.PM_Releases()
    '        Dim colReleases As New List(Of Portal.BLL.PM.PM_Releases)()
    '        colReleases = Portal.BLL.PM.PM_Releases.PM_ReleasesGetByID(hdnReleaseID.Value)
    '        If colReleases.Count > 0 Then
    '            Me.lblReleaseName.Text = Functions.StringTruncate(colReleases.Item(0).Name, 50)
    '            Me.lblReleaseName.ToolTip = colReleases.Item(0).Name
    '        End If
    '        If (colReleases.Item(0).NewReleaseDate.ToShortDateString() <> "1/1/1900") Then
    '            Me.hdnReleaseDueDate.Value = colReleases.Item(0).NewReleaseDate.ToShortDateString()
    '        Else
    '            Me.hdnReleaseDueDate.Value = colReleases.Item(0).ReleaseDate.ToShortDateString()
    '        End If
    '        btnImptoFea.Visible = False
    '        divRelease.Attributes.Add("style", "display:inline;")
    '        DivReleaselbl.Attributes.Add("style", "display:inline;")
    '    Else
    '        Me.hdnReleaseDueDate.Value = ""
    '        btnImptoFea.Visible = False
    '        divRelease.Attributes.Add("style", "display:none;")
    '        DivReleaselbl.Attributes.Add("style", "display:none;")
    '    End If

    'End Sub

    'Private Sub FillddlStatus()
    '    Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
    '    ddlActivityStatus.Items.Add(obj)
    '    obj = New System.Web.UI.WebControls.ListItem("Completed", Portal.BLL.Enumeration.PMStatus.Released)
    '    ddlActivityStatus.Items.Add(obj)
    '    obj = New System.Web.UI.WebControls.ListItem("In Progress", Portal.BLL.Enumeration.PMStatus.InProgress)
    '    ddlActivityStatus.Items.Add(obj)
    '    obj = New System.Web.UI.WebControls.ListItem("Not Started", Portal.BLL.Enumeration.PMStatus.NotStarted)
    '    ddlActivityStatus.Items.Add(obj)
    '    obj = New System.Web.UI.WebControls.ListItem("On Hold", Portal.BLL.Enumeration.PMStatus.OnHold)
    '    ddlActivityStatus.Items.Add(obj)
    '    obj = New System.Web.UI.WebControls.ListItem("Feedback Requested", Portal.BLL.Enumeration.PMStatus.FeedbackRequested)
    '    ddlActivityStatus.Items.Add(obj)
    '    obj = New System.Web.UI.WebControls.ListItem("Feedback Received", Portal.BLL.Enumeration.PMStatus.FeedbackReceived)
    '    ddlActivityStatus.Items.Add(obj)
    '    obj = New System.Web.UI.WebControls.ListItem("Confirm Solved", Portal.BLL.Enumeration.PMStatus.ConfirmSolved)
    '    ddlActivityStatus.Items.Add(obj)
    'End Sub
    Private Sub FillAttachmentsValidations()
        REV_file1.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file1.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file2.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file2.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file3.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file3.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
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

            Dim span As String = CType(e.Item.FindControl("lblTimeSpent"), Label).Text
            Dim objTimeSpent As TimeSpan = New TimeSpan(Integer.Parse(span.Split(":")(0)), Integer.Parse(span.Split(":")(1)), 0).Add(TimeSpan.Parse(hdnTimeSpent.Value))
            hdnTimeSpent.Value = objTimeSpent.ToString()

            Dim strHours As String
            Dim strMin As String

            ''To show Date time in Format HH:MM
            objTimeSpent = New TimeSpan(Integer.Parse(span.Split(":")(0)), Integer.Parse(span.Split(":")(1)), 0)

            If Math.Truncate(objTimeSpent.TotalHours) < 10 Then
                strHours = "0" & Math.Truncate(objTimeSpent.TotalHours).ToString()
            Else
                strHours = Math.Truncate(objTimeSpent.TotalHours).ToString()
            End If
            If CType(objTimeSpent.Minutes, Integer) < 10 Then
                strMin = "0" & CType(objTimeSpent.Minutes, Integer).ToString()
            Else
                strMin = CType(objTimeSpent.Minutes, Integer).ToString()
            End If
            CType(e.Item.FindControl("lblTimeSpentModified"), Label).Text = strHours & ":" & strMin
        End If
    End Sub
    Protected Sub rptrTicket_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrTicket.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rptrTicketAttachments"), Repeater)
            SDS_TicketsAttachments.FilterExpression = "[Ticket_FeatureID] = " & Me.hdnID.Value
            rpt.DataSourceID = "SDS_TicketsAttachments"
            rpt.DataBind()
            If rpt.Items.Count <= 0 Then
                rpt.Visible = False
            End If
        End If
    End Sub

    'Protected Sub btnUpdateDueDate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateDueDate.Click
    '    Dim Result As Boolean
    '    Dim strDescription As String = String.Empty
    '    Dim ObjNotes As PM_Notes = New PM_Notes()
    '    Result = PM_Ticket_Features.UpdateDueDate(CType(hdnID.Value, Integer), CType(txtActivityDueDate.Text, Date))
    '    If Result Then
    '        With ObjNotes
    '            .Ticket_Feature_ID = CInt(hdnID.Value)
    '            .Notes = "Due Date Changed From " & hdnDueDate.Value & " To " & txtActivityDueDate.Text
    '            strDescription = .Notes
    '            .SubmittedBy = Nothing
    '            .ClientContactID = Session("MyNetsolace_ClientContactID")
    '            .DateEntered = DateTime.Now
    '            .TimeSpent = "00:00:00"
    '            .IsByAdmin = 1
    '            If .Notes_Add() > 0 Then
    '                rptrNotes.DataSourceID = sdsNotes.ID
    '                rptrNotes.DataBind()
    '                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateMessageScript", "ShowUpdateMessage();", True)
    '            End If
    '        End With
    '        'CheckEmailMailOnUpdateDueDate()
    '        SendEmailToUsers(strDescription)
    '    End If
    'End Sub

    Protected Sub ddlStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlActivityStatus.SelectedIndexChanged
        If ddlActivityStatus.SelectedValue <> 0 Then
            Dim Result As Boolean
            Dim strDescription As String = String.Empty
            Dim ObjNotes As PM_Notes = New PM_Notes()
            Result = PM_Ticket_Features.UpdateStatus(CType(hdnID.Value, Integer), CType(ddlActivityStatus.SelectedValue, Integer), hdnWaitingFor.Value)
            If Result Then
                If hdnPreValueStatus.Value <> 5 AndAlso ddlActivityStatus.SelectedValue = 5 Then
                    With ObjNotes
                        .Ticket_Feature_ID = CInt(hdnID.Value)
                        .Notes = lblActivitySubject.Text & " has been Completed On " & DateTime.Now
                        strDescription = .Notes
                        .SubmittedBy = Nothing
                        .ClientContactID = Session("MyNetsolace_ClientContactID")
                        .DateEntered = DateTime.Now
                        .TimeSpent = "00:00:00"
                        .IsByAdmin = 1
                        If .Notes_Add() > 0 Then
                            rptrNotes.DataSourceID = sdsNotes.ID
                            rptrNotes.DataBind()
                        End If
                    End With
                ElseIf hdnPreValueStatus.Value = 5 AndAlso ddlActivityStatus.SelectedValue <> 5 Then
                    With ObjNotes
                        .Ticket_Feature_ID = CInt(hdnID.Value)
                        .Notes = lblActivitySubject.Text & " has been Reopened On " & DateTime.Now & " with Status " & ddlActivityStatus.SelectedItem.Text
                        strDescription = .Notes
                        .SubmittedBy = Nothing
                        .ClientContactID = Session("MyNetsolace_ClientContactID")
                        .DateEntered = DateTime.Now
                        .TimeSpent = "00:00:00"
                        .IsByAdmin = 1
                        If .Notes_Add() > 0 Then
                            rptrNotes.DataSourceID = sdsNotes.ID
                            rptrNotes.DataBind()
                        End If
                    End With
                Else
                    With ObjNotes
                        .Ticket_Feature_ID = CInt(hdnID.Value)
                        .Notes = lblActivitySubject.Text & " has been Updated On " & DateTime.Now & " with Status " & ddlActivityStatus.SelectedItem.Text
                        strDescription = .Notes
                        .SubmittedBy = Nothing
                        .ClientContactID = Session("MyNetsolace_ClientContactID")
                        .DateEntered = DateTime.Now
                        .TimeSpent = "00:00:00"
                        .IsByAdmin = 1
                        If .Notes_Add() > 0 Then
                            rptrNotes.DataSourceID = sdsNotes.ID
                            rptrNotes.DataBind()
                        End If
                    End With
                End If
                hdnPreValueStatus.Value = ddlActivityStatus.SelectedValue
                lblActivityStatus.Text = ddlActivityStatus.SelectedItem.Text
                BindControl()


                If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released Then
                    SendEmailToUsers(strDescription)
                    contactsTable.Visible = False
                Else
                    contactsTable.Visible = True
                End If
            End If
        End If
    End Sub

    Public Sub BindControl()
        Dim objTicket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features()
        colTicket_Features = PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(hdnID.Value, Integer))

        If colTicket_Features.Count > 0 Then

            ddlActivityStatus.SelectedItem.Selected = False
            ddlActivityStatus.SelectedValue = colTicket_Features.Item(0).Status
            lblDueDate.Text = colTicket_Features.Item(0).DueDate.ToShortDateString()
            If colTicket_Features.Item(0).DueDateShowToClient = False Then
                lblDueDate.Text = "To be determined"
                lblDueDate.ToolTip = "To be determined"
            End If
            lblClientName.Text = colTicket_Features.Item(0).ClientName
            lblContactClientName.Text = colTicket_Features.Item(0).ClientName
            lblCategoryName.Text = colTicket_Features.Item(0).CatagoryName
            hdnUserID.Value = colTicket_Features.Item(0).UserID
            If Not Page.IsPostBack Then
                ViewState("ClientID") = colTicket_Features.Item(0).ClientID
                hdnClientID.Value = colTicket_Features.Item(0).ClientID
                hdnClientContactID.Value = colTicket_Features.Item(0).ClientContactID
                If hdnClientContactID.Value > 0 Then
                    FillClientContacts(hdnClientContactID.Value)
                End If
                hdnPreValueStatus.Value = colTicket_Features.Item(0).Status
                lblActivitySubject.Text = colTicket_Features.Item(0).Name
                lblActivityType.Text = colTicket_Features.Item(0).TypeName
                If colTicket_Features.Item(0).UserID > 0 Then
                    lblAssignBy.Text = colTicket_Features.Item(0).UserName
                ElseIf colTicket_Features.Item(0).ClientContactID > 0 Then
                    lblAssignBy.Text = colTicket_Features.Item(0).ClientContactName
                End If

                If colTicket_Features.Item(0).Priority = 1 Then
                    ImgPriority.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "ico_priority_high.gif"
                    ImgPriority.Attributes.Add("Title", "High Priority")
                ElseIf colTicket_Features.Item(0).Priority = 3 Then
                    ImgPriority.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "ico_priority_low.gif"
                    ImgPriority.Attributes.Add("Title", "Low Priority")
                Else
                    ImgPriority.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "spacer.gif"
                End If
                If IsRelease.Value = False Then
                    Me.lblTitle.Text = "Ticket Ref # " & colTicket_Features.Item(0).RefNo
                Else
                    Me.lblTitle.Text = "Feature Ref # " & colTicket_Features.Item(0).RefNo
                End If
                Dim strDueDate As String
                Dim strStatus As String
                strDueDate = colTicket_Features.Item(0).DueDate
                strStatus = colTicket_Features.Item(0).Status

            End If
            Me.hdnRefNo.Value = colTicket_Features.Item(0).RefNo

            hdnDueDate.Value = Functions.IfNull(colTicket_Features.Item(0).DueDate, System.DateTime.Now)

            hdnWaitingFor.Value = colTicket_Features.Item(0).WaitingForUserID
            If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.ConfirmSolved Then
                StatusConfirmation.Style.Add("display", "inline")
            Else
                StatusConfirmation.Style.Add("display", "none")
            End If
            If ddlActivityStatus.SelectedValue = 5 Then
                btnAddNotes.Visible = False
                'btnImptoFea.Visible = False
                'btnChangeRelease.Visible = False
                'DivDueDateTime.Visible = False
                btnUpdateUsers.Enabled = False
                'lblActivityDueDate.Visible = True
                'lblActivityDueDate.Text = Functions.IfNull(colTicket_Features.Item(0).DueDate, System.DateTime.Now)
            Else
                'txtActivityDueDate.Text = DateTime.Parse(Functions.IfNull(colTicket_Features.Item(0).DueDate, System.DateTime.Now)).ToShortDateString()
                Dim Time As String = DateTime.Parse(Functions.IfNull(colTicket_Features.Item(0).DueDate, System.DateTime.Now)).ToShortTimeString()
                btnAddNotes.Visible = True
                'btnUpdateDueDate.Visible = True
                If IsRelease.Value = True Then
                    'btnChangeRelease.Visible = False
                    'btnImptoFea.Visible = False
                Else
                    'btnImptoFea.Visible = False
                    'btnChangeRelease.Visible = False
                End If
                'lblActivityDueDate.Visible = False
                'DivDueDateTime.Visible = True
                btnUpdateUsers.Enabled = True
                divStatus.Attributes.Add("style", "display:inline;")
            End If
        End If

    End Sub

    'Protected Sub ddlReleases_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReleases.DataBound
    '    ddlReleases.Items.Insert(0, New ListItem("Select...", 0))
    'End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If (Session("update").ToString() = ViewState("update").ToString()) Then
            Session("update") = System.DateTime.Now.ToString()

            Dim intNewNotesID As Integer = 0
            Dim ObjNotes As PM_Notes = New PM_Notes()
            With ObjNotes
                .Ticket_Feature_ID = CInt(hdnID.Value)
                .Notes = txtNotes.Text.Trim
                .SubmittedBy = Nothing
                .ClientContactID = Session("MyNetsolace_ClientContactID")
                .DateEntered = DateTime.Now
                .IsByAdmin = 1
                .TimeSpent = "00:00:00" 'TimeSpan.Parse(ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue).ToString()
                .Type = Portal.BLL.Enumeration.TicketsNotesType.PublicNote
                intNewNotesID = .Notes_Add()
                If intNewNotesID > 0 Then

                    Dim DirectoryName As String = hdnID.Value & "\" & Functions.GetDateTimeUniqueString()
                    If IsRelease.Value = True Then
                        DirectoryName = "Ftr" & DirectoryName
                    Else
                        DirectoryName = "Tkt" & DirectoryName
                    End If
                    .NotesID = intNewNotesID
                    Dim fileuTel1 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file1.UniqueID)
                    Dim fileuTel2 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file2.UniqueID)
                    Dim fileuTel3 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file3.UniqueID)

                    If Not fileuTel1 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel1)
                    End If
                    If Not fileuTel2 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel2)
                    End If
                    If Not fileuTel3 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel3)
                    End If
                    hdnTimeSpent.Value = "00:00:00"
                    'CheckEmailMailOnTicketNoteAddToAdmin()
                    SendEmailToUsers(lblActivitySubject.Text & " has been updated")
                    rptrNotes.DataSourceID = sdsNotes.ID
                    rptrNotes.DataBind()

                End If
            End With
        End If
    End Sub

    'Protected Sub btnOk_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOk.Click
    '    Dim Result As Boolean
    '    Dim ObjNotes As PM_Notes = New PM_Notes()
    '    Result = PM_Ticket_Features.UpdateReleaseID(CType(hdnID.Value, Integer), CType(ddlReleases.SelectedValue, Integer))
    '    If Result Then
    '        With ObjNotes
    '            .Ticket_Feature_ID = CInt(hdnID.Value)
    '            .Notes = lblActivitySubject.Text & " has moved From " & lblReleaseName.Text & " Release To " & ddlReleases.SelectedItem.Text & " Release"
    '            .SubmittedBy = Nothing
    '            .ClientContactID = Session("MyNetsolace_ClientContactID")
    '            .DateEntered = DateTime.Now
    '            .TimeSpent = "00:00:00"
    '            .IsByAdmin = 1
    '            If .Notes_Add() > 0 Then
    '                rptrNotes.DataSourceID = sdsNotes.ID
    '                rptrNotes.DataBind()
    '                Me.lblReleaseName.Text = ddlReleases.SelectedItem.Text
    '            End If
    '        End With
    '        BindControl()
    '    End If
    'End Sub


    Protected Sub SendEmailToUsers(ByVal strDescription As String, Optional ByVal ClientContactIds As String = "")

        Dim objDBAccess As DBAccess = New DBAccess()
        Dim dtUsers As DataTable = Nothing
        Dim FranmailUserName As String = String.Empty
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim ClientContactId() As String

        If Not ClientContactIds Is Nothing Then
            ClientContactId = ClientContactIds.Split(",")
        End If

        objDBAccess.AddParameter("@TicketFeatureID", hdnID.Value)
        dtUsers = objDBAccess.ExecuteDataTable("PM_Ticket_Features_GetAllUsersForEmail")

        Dim strStatus As String = ""
        strStatus = ddlActivityStatus.SelectedItem.Text

        Dim strPriority As String = ""
        If Me.ImgPriority.ImageUrl.ToLower().Contains("high") Then
            strPriority = "High"
        ElseIf Me.ImgPriority.ImageUrl.ToLower().Contains("low") Then
            strPriority = "Low"
        ElseIf Me.ImgPriority.ImageUrl.ToLower().Contains("spacer") Then
            strPriority = "Normal"
        End If
        Dim ClientContactName As String = Session("MyNetsolace_ClientContactName")
        Dim ClientContactEmail As String = Session("MyNetsolace_ClientContactEmail")
        Dim subject As String = "Updated Netsolace Portal Ticket #" & hdnRefNo.Value & ": " & lblActivitySubject.Text

        If ClientContactIds <> "" Then
            For j = 0 To ClientContactId.Length - 1
                For i = 0 To dtUsers.Rows.Count - 1
                    If dtUsers.Rows(i)("ID") = ClientContactId(j) Then
                        PM_Ticket_Features.SendMailToClientContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), ClientContactEmail, ClientContactName, "", _
                                                                    subject, _
                                                                    strDescription, _
                                                                    hdnRefNo.Value, _
                                                                    Me.lblActivitySubject.Text.Trim(), _
                                                                    strStatus, _
                                                                    IIf(hdnIsDueDateShowToClient.Value = True, CDate(hdnDueDate.Value).Date, "To Be Determined"), _
                                                                    strPriority, _
                                                                    Me.lblActivityType.Text, _
                                                                    Me.lblClientName.Text, _
                                                                    Me.lblCategoryName.Text, False, "<a href=" & dtUsers.Rows(i)("Link") & ">" & dtUsers.Rows(i)("Link") & "</a>", dtUsers.Rows(i)("Link"), True)
                    End If
                Next
            Next

        Else

            For i = 0 To dtUsers.Rows.Count - 1
                If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Client Then
                    If dtUsers.Rows(i)("ID") <> Session("MyNetsolace_ClientContactID") Then

                        PM_Ticket_Features.SendMailToClientContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), ClientContactEmail, ClientContactName, "", _
                        subject, _
                        strDescription, _
                        hdnRefNo.Value, _
                        Me.lblActivitySubject.Text.Trim(), _
                        strStatus, _
                        IIf(hdnIsDueDateShowToClient.Value = True, CDate(hdnDueDate.Value).Date, "To Be Determined"), _
                        strPriority, _
                        Me.lblActivityType.Text, _
                        Me.lblClientName.Text, _
                        Me.lblCategoryName.Text, False, "<a href=" & dtUsers.Rows(i)("Link") & ">" & dtUsers.Rows(i)("Link") & "</a>", dtUsers.Rows(i)("Link"), True)

                    End If
                ElseIf dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Netsolace Then
                    PM_Ticket_Features.SendMailToClientContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), ClientContactEmail, ClientContactName, "", _
                    subject, _
                    strDescription, _
                    hdnRefNo.Value, _
                    Me.lblActivitySubject.Text.Trim(), _
                    strStatus, _
                    CDate(hdnDueDate.Value).Date, _
                    strPriority, _
                    Me.lblActivityType.Text, _
                    Me.lblClientName.Text, _
                    Me.lblCategoryName.Text, True, "<a href=" & dtUsers.Rows(i)("Link") & ">" & dtUsers.Rows(i)("Link") & "</a>", dtUsers.Rows(i)("Link"), True)

                End If
            Next
        End If

        dtUsers.Dispose()
    End Sub

    Private Function CheckValidityEmail(ByVal strEmail As String) As Boolean
        Dim ClientContactEmail As String = Session("MyNetsolace_ClientContactEmail")
        If strEmail <> Nothing AndAlso Functions.IsValidEmail(strEmail) AndAlso _
        CStr(ClientContactEmail) <> Nothing AndAlso Functions.IsValidEmail(ClientContactEmail) Then
            Return True
        End If
        Return False
    End Function


    Protected Sub btnUpdateUsers_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateUsers.Click
        If (Session("update").ToString() = ViewState("update").ToString()) Then

            Dim strClientContacts As New StringBuilder
            Dim PrevClientChecked As New StringBuilder
            Dim strClientContactID As String = ""
            Dim strClientPrevChecked As String = ""
            Dim strBeforeClientContactID As New StringBuilder
            Dim strAfterClientContactID As New StringBuilder
            Dim strBeforeUserID As New StringBuilder
            Dim strAfterUserID As New StringBuilder
            Dim HasChangeClientContact As Boolean = False
            Dim NewlyAddedContacts As String = Nothing

            Dim i As Integer = 0
            Dim j As Integer = 0
            Dim k As Integer = 0

            strClientContacts.Append("")
            PrevClientChecked.Append("")

            hdnNewClientContactIds.Value = ""
            hdnClientContactIds.Value = ""

            For i = 0 To rptClientContacts.Items.Count - 1
                Dim chkBox As HtmlInputCheckBox = CType(rptClientContacts.Items(i).FindControl("chkClientContacts"), HtmlInputCheckBox)
                If chkBox.Checked = True Then

                    j = j + 1
                    strClientContactID = chkBox.Attributes("ClientContactID").ToString()
                    hdnNewClientContactIds.Value += strClientContactID + ","
                    hdnClientContactIds.Value += strClientContactID + ","

                    If strClientContacts.ToString = "" Then
                        strClientContacts.Append(strClientContactID)
                    Else
                        strClientContacts.Append(",".ToString + strClientContactID)
                    End If


                    If strAfterClientContactID.ToString = "" Then
                        strAfterClientContactID.Append(j & ". " & chkBox.Attributes("ToolTip") + vbCrLf)
                    Else
                        strAfterClientContactID.Append(j & ". " & chkBox.Attributes("ToolTip") + vbCrLf)
                    End If

                End If
                strClientPrevChecked = chkBox.Attributes("PrevClientChecked").ToString()
                If CBool(strClientPrevChecked) = True Then
                    k = k + 1
                    If strBeforeClientContactID.ToString = "" Then
                        strBeforeClientContactID.Append(k & ". " & chkBox.Attributes("ToolTip") + vbCrLf)
                    Else
                        strBeforeClientContactID.Append(k & ". " & chkBox.Attributes("ToolTip") + vbCrLf)
                    End If
                End If

                If CBool(strClientPrevChecked) = False AndAlso chkBox.Checked = True Then
                    If NewlyAddedContacts = "" Then
                        NewlyAddedContacts = chkBox.Attributes("ClientContactID")
                    Else
                        NewlyAddedContacts += "," & chkBox.Attributes("ClientContactID")
                    End If
                End If

                If chkBox.Checked <> CBool(strClientPrevChecked) Then
                    HasChangeClientContact = True
                End If

            Next

            If strBeforeClientContactID.ToString = "" Then
                strBeforeClientContactID.Append("No Recipient")
            End If
            If strAfterClientContactID.ToString = "" Then
                strAfterClientContactID.Append("No Recipient")
            End If


            Dim strBodyForClientContacts As String = ""
            strBodyForClientContacts = " === Ticket recipient list updated. ===" + vbCrLf + vbCrLf
            strBodyForClientContacts += " --------------------------" + vbCrLf
            strBodyForClientContacts += " Previous Recipient(s):" + vbCrLf
            strBodyForClientContacts += " --------------------------" + vbCrLf
            strBodyForClientContacts += strBeforeClientContactID.ToString + vbCrLf
            strBodyForClientContacts += " ---------------------" + vbCrLf
            strBodyForClientContacts += " New Recipient(s):" + vbCrLf
            strBodyForClientContacts += " ---------------------" + vbCrLf
            strBodyForClientContacts += strAfterClientContactID.ToString

            Dim ObjNotes As PM_Notes = New PM_Notes()
            If HasChangeClientContact Then
                With ObjNotes
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = strBodyForClientContacts
                    .SubmittedBy = Nothing
                    .ClientContactID = Session("MyNetsolace_ClientContactID")
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = "00:00:00"
                    .Type = Portal.BLL.Enumeration.TicketsNotesType.PublicNote
                    .Notes_Add()
                End With
            End If

            Dim objPM_TicketUsers As New PM_Ticket_Features_Users
            objPM_TicketUsers.PM_Ticket_Features_UsersAddClientContacs(hdnID.Value, strClientContacts.ToString, CInt(Session("MyNetsolace_ClientContactID")))

            SendEmailToUsers(" has been updated", NewlyAddedContacts)

            rptClientContacts.DataBind()
            upnlClientContacts.Update()

            rptrNotes.DataSourceID = sdsNotes.ID
            rptrNotes.DataBind()

            upHiddens.Update()

            Session("update") = System.DateTime.Now.ToString()
        End If
    End Sub

    Protected Sub FillClientContacts(ByVal ClientContactID As Integer)
        Dim i As Integer

        rptClientContacts.DataBind()

        For i = 0 To rptClientContacts.Items.Count - 1
            Dim chkbox As HtmlInputCheckBox = CType(rptClientContacts.Items(i).FindControl("chkClientContacts"), HtmlInputCheckBox)
            Dim strClientContactID As String = chkbox.Attributes("ClientContactID").ToString()
            If chkbox.Checked Then
                hdnClientContactIds.Value += chkbox.Attributes("ClientContactID").ToString() + ","
                hdnNewClientContactIds.Value += chkbox.Attributes("ClientContactID").ToString() + ","
            End If
            If strClientContactID = ClientContactID Then
                If chkbox.Checked = False Then
                    chkbox.Checked = True
                    chkbox.Disabled = True
                    Dim objPM_TicketUsers As New Portal.BLL.PM.PM_Ticket_Features_Users
                    objPM_TicketUsers.PM_Ticket_Features_InserUserAccess(hdnID.Value, 0, hdnClientContactID.Value)
                Else
                    chkbox.Disabled = True
                End If
            End If
        Next

        rptClientContacts.DataBind()
        upnlClientContacts.Update()
    End Sub

    Protected Sub rptClientContacts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptClientContacts.ItemDataBound

        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim chkbox As HtmlInputCheckBox = CType(e.Item.FindControl("chkClientContacts"), HtmlInputCheckBox)
            If e.Item.DataItem("ClientContactID") = hdnClientContactID.Value Then
                chkbox.Disabled = True
            End If
        End If
    End Sub
End Class


