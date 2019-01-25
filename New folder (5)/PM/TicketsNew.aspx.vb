Imports Portal.BLL.PM
Imports Portal.BLL
Imports System.Data

Partial Class PM_TicketsNew
    Inherits System.Web.UI.Page
    Dim tktClient As String
    Dim tktCatagory As String
    Dim tktFilter As String
    Dim tktTypes As String
    Dim tktSearch As String

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("ddlClients") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlClients")) Then
            tktClient = Request.QueryString("ddlClients")
        End If
        If Request.QueryString("ddlCategories") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlCategories")) Then
            tktCatagory = Request.QueryString("ddlCategories")
        End If
        If Request.QueryString("ddlFilter") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlFilter")) Then
            tktFilter = Request.QueryString("ddlFilter")
        End If
        If Request.QueryString("ddlTypes") <> String.Empty AndAlso IsNumeric(Request.QueryString("ddlTypes")) Then
            tktTypes = Request.QueryString("ddlTypes")
        End If
        If Request.QueryString("txtSearch") <> String.Empty AndAlso IsNumeric(Request.QueryString("txtSearch")) Then
            tktSearch = Request.QueryString("txtSearch")
        End If
        If Not IsPostBack Then
            FillddlPriority()
            txtName.Focus()
            'FillddlStatus()
            If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
                Select Case CInt(Request.QueryString("PrevPage"))
                    Case 3 'Tickets
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Tickets.aspx?ddlClients=" & tktClient & "&ddlCategories=" & tktCatagory & "&ddlFilter=" & tktFilter & "&ddlTypes=" + tktTypes) & "'; return false; ")
                    Case 4 'MyTickets
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/MyTickets.aspx?ddlClients=" & tktClient & "&ddlCategories=" & tktCatagory & "&ddlFilter=" & tktFilter) & "'; return false; ")
                    Case 5 'Tickets History
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/TicketsHistory.aspx?ddlClients=" & tktClient & "&ddlCategories=" & tktCatagory & "&ddlFilter=" & tktFilter) & "'; return false; ")
                    Case Else
                        btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx") & "'; return false; ")
                End Select
                If CInt(Session("Type")) = Portal.BLL.Enumeration.UsersType.Fransupport Then
                    ddlClients.SelectedValue = 1
                    ddlClients.Enabled = False
                End If
            End If
            CV_FutureDate.ValueToCompare = DateTime.Now.ToShortDateString()
            txtDueDate.Text = DateTime.Now.AddDays(7).ToShortDateString()
            FillAttachmentsValidations()
        End If
    End Sub

    Private Sub FillddlPriority()
        Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
        ddlPriority.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem(Portal.BLL.Enumeration.PMPriority.High.ToString(), Portal.BLL.Enumeration.PMPriority.High)
        ddlPriority.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem(Portal.BLL.Enumeration.PMPriority.Normal.ToString(), Portal.BLL.Enumeration.PMPriority.Normal)
        ddlPriority.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem(Portal.BLL.Enumeration.PMPriority.Low.ToString(), Portal.BLL.Enumeration.PMPriority.Low)
        ddlPriority.Items.Add(obj)

    End Sub

    Private Sub FillddlStatus()
        'Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
        'ddlStatus.Items.Add(obj)
        'obj = New System.Web.UI.WebControls.ListItem("Feedback Requested", Portal.BLL.Enumeration.PMStatus.FeedbackRequested)
        'ddlStatus.Items.Add(obj)
        ''obj = New System.Web.UI.WebControls.ListItem("Completed", Portal.BLL.Enumeration.PMStatus.Released)
        ''ddlStatus.Items.Add(obj)
        'obj = New System.Web.UI.WebControls.ListItem("In Progress", Portal.BLL.Enumeration.PMStatus.InProgress)
        'ddlStatus.Items.Add(obj)
        'obj = New System.Web.UI.WebControls.ListItem("Not Started", Portal.BLL.Enumeration.PMStatus.NotStarted)
        'ddlStatus.Items.Add(obj)
        ''obj = New System.Web.UI.WebControls.ListItem("Waiting For", Portal.BLL.Enumeration.PMStatus.WaitingFor)
        ''ddlStatus.Items.Add(obj)
        'obj = New System.Web.UI.WebControls.ListItem("On Hold", Portal.BLL.Enumeration.PMStatus.OnHold)
        'ddlStatus.Items.Add(obj)

    End Sub

    Private Sub FillAttachmentsValidations()
        REV_file1.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file1.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file2.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file2.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file3.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file3.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
    End Sub


    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        If ddlClients.Items.FindByValue("0") Is Nothing Then
            ddlClients.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlAreaDeveloper_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAreaDeveloper.DataBound
        If ddlAreaDeveloper.Items.FindByValue("0") Is Nothing Then
            ddlAreaDeveloper.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        If ddlCategories.Items.FindByValue("0") Is Nothing Then
            ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
        End If
        ddlSubCategories.DataSource = PM.PM_Ticket_Features.PM_SubCategories_CategoryID(ddlCategories.SelectedValue)
        ddlSubCategories.DataBind()
        UpdatePanel1.Update()

    End Sub

    Protected Sub ddlSubCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSubCategories.DataBound
        If ddlSubCategories.Items.FindByValue("0") Is Nothing Then
            ddlSubCategories.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
        ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlTicketOwner_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTicketOwner.DataBound
        ddlTicketOwner.Items.Insert(0, New ListItem("Select...", 0))
    End Sub


    'Protected Sub ddlWaitingFor_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWaitingFor.DataBound
    '    ddlWaitingFor.Items.Insert(0, New ListItem("Select...", 0))
    'End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objTicketsBLL As New Portal.BLL.PM.PM_Ticket_Features
        Dim TicketID As Integer
        If Page.IsValid Then
            'If ddlStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.NotStarted Or _
            'ddlStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.InProgress Then
            '    Dim CatUserID As Integer = Portal.BLL.PM.PM_Ticket_Features.PM_CategoryUserGetByID(Me.ddlCategories.SelectedValue)
            '    ddlStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.WaitingFor
            '    'ddlWaitingFor.SelectedValue = CatUserID
            'End If
            With objTicketsBLL
                .Name = Me.txtName.Text.Trim()
                .DateEntered = DateTime.Now.ToString()
                .Description = Me.txtDescription.Value
                .TypeID = Me.ddlTypes.SelectedValue
                .UserID = Session("AdminID")
                .Read = False
                .Status = ddlStatus.SelectedValue
                .Deleted = False
                .History = False
                .DueDate = Me.txtDueDate.Text
                .Priority = Me.ddlPriority.SelectedValue
                .CatagoryID = Me.ddlCategories.SelectedValue

                'If ddlStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.WaitingFor Then
                '    .WaitingForUserID = Me.ddlWaitingFor.SelectedValue
                'Else
                '    .WaitingForUserID = 0
                'End If
                .ClientID = Me.ddlClients.SelectedValue
                .RefNo = 0
                If ddlAreaDeveloper.SelectedValue <> 0 Then
                    .AreaDeveloperId = ddlAreaDeveloper.SelectedValue
                Else
                    .AreaDeveloperId = 0
                End If

                If ddlSubCategories.SelectedValue <> 0 Then
                    .SubCatagoryID = ddlSubCategories.SelectedValue
                Else
                    .SubCatagoryID = 0
                End If

                .TicketOwner = ddlTicketOwner.SelectedValue
                TicketID = .PM_TicketAdd()
                If TicketID > 0 Then
                    Dim DirectoryName As String = "Tkt" & TicketID.ToString() & "\" & Functions.GetDateTimeUniqueString()
                    Dim fileuTel1 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file1.UniqueID)
                    Dim fileuTel2 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file2.UniqueID)
                    Dim fileuTel3 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file3.UniqueID)

                    Dim Type As Integer = 0
                    Dim Type1 As Integer = 0
                    Dim Type2 As Integer = 0

                    If (SOW.Checked) Then
                        Type = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "SOW"), Integer)
                    ElseIf BRD.Checked Then
                        Type = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "BRD"), Integer)
                    End If
                    If (RadioButton2.Checked) Then
                        Type1 = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "SOW"), Integer)
                    ElseIf RadioButton4.Checked Then
                        Type1 = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "BRD"), Integer)
                    End If
                    If (RadioButton5.Checked) Then
                        Type2 = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "SOW"), Integer)
                    ElseIf RadioButton6.Checked Then
                        Type2 = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.AttachmentType), "BRD"), Integer)
                    End If



                    If Not fileuTel1 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel1, TicketID, Type)
                    End If
                    If Not fileuTel2 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel2, TicketID, Type1)
                    End If
                    If Not fileuTel3 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel3, TicketID, Type2)
                    End If
                    CheckToMail(TicketID)
                    Response.Redirect("TicketsDetail.aspx?ID=" & TicketID & "&PrevPage=4&NewTicket=True")
                    'Response.Redirect("Tickets.aspx?ddlClients=" & tktClient & "&ddlCategories=" & tktCatagory & "&ddlFilter=" & tktFilter & "&ddlTypes=" + tktTypes)
                ElseIf TicketID = -101 Then
                    lblErrorMessage.Text = "<br/>'" & .Name & "' Already Exists. Please Enter Different Release Name"
                    txtName.Focus()
                End If
            End With
        End If
    End Sub

    Private Sub CheckToMail(ByVal TicketID As Integer)
        Dim objDBAccess As DBAccess = New DBAccess()
        Dim dtUsers As Data.DataTable = Nothing
        Dim FranmailUserName As String = String.Empty
        Dim i As Integer = 0
        objDBAccess.AddParameter("@TicketFeatureID", TicketID)
        dtUsers = objDBAccess.ExecuteDataTable("PM_Ticket_Features_GetAllUsersForEmail")


        Dim strStatus As String = ""
        strStatus = ddlStatus.SelectedItem.Text

        Dim strPriority As String = ""
        If Me.ddlPriority.SelectedValue = Portal.BLL.Enumeration.PMPriority.High Then
            strPriority = "High"
        ElseIf Me.ddlPriority.SelectedValue = Portal.BLL.Enumeration.PMPriority.Low Then
            strPriority = "Low"
        ElseIf Me.ddlPriority.SelectedValue = Portal.BLL.Enumeration.PMPriority.Normal Then
            strPriority = "Normal"
        End If

        Dim subject As String = "Created Netsolace Portal Ticket #" & TicketID & ": " & txtName.Text
        For i = 0 To dtUsers.Rows.Count - 1
            If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Client Then 'Client Contacts
                If dtUsers.Rows(i)("ID") <> Session("MyNetsolace_ClientContactID") Then

                    PM_Ticket_Features.SendMailToClientContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), Session("Email"), Session("AdminName"), "", _
                    subject, _
                    "has been created", _
                    TicketID, _
                    Me.txtName.Text.Trim(), _
                    strStatus, _
                    Me.txtDueDate.Text, _
                    strPriority, _
                    Me.ddlTypes.SelectedItem.Text, _
                    Me.ddlClients.SelectedItem.Text, _
                    Me.ddlCategories.SelectedItem.Text, False)

                End If
            ElseIf dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Netsolace Then 'Netsolace Contacts
                If dtUsers.Rows(i)("ID") <> Session("AdminID") Then

                    PM_Ticket_Features.SendMailToNetsolaceContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), "", _
                    subject, _
                    "has been created", _
                    TicketID, _
                    Me.txtName.Text.Trim(), _
                    strStatus, _
                    Me.txtDueDate.Text, _
                    strPriority, _
                    Me.ddlTypes.SelectedItem.Text, _
                    Me.ddlClients.SelectedItem.Text, _
                    Me.ddlCategories.SelectedItem.Text)

                End If
            End If
        Next
        dtUsers.Dispose()

    End Sub
    Private Function CheckValidityEmail(ByVal strEmail As String) As Boolean
        If strEmail <> Nothing AndAlso Functions.IsValidEmail(strEmail) AndAlso _
        CStr(HttpContext.Current.Session("Email")) <> Nothing AndAlso Functions.IsValidEmail(CStr(HttpContext.Current.Session("Email"))) Then
            Return True
        End If
        Return False
    End Function

    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", "" & Portal.BLL.Enumeration.SubModules.PMFullAccess)
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        'If ddlClients.SelectedValue = Enumeration.ClientID.EA Then
        '    ddlAreaDeveloper.Attributes.Add("style", "display:inline")
        '    spnAreaDeveloper.Style.Add("display", "inline")
        'Else
        '    ddlAreaDeveloper.Attributes.Add("style", "display:none")
        '    spnAreaDeveloper.Style.Add("display", "none")
        'End If



    End Sub

    Private Sub ddlCategories_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlCategories.SelectedIndexChanged
        ddlSubCategories.DataSource = PM.PM_Ticket_Features.PM_SubCategories_CategoryID(ddlCategories.SelectedValue)
        ddlSubCategories.DataBind()
        UpdatePanel1.Update()
    End Sub
End Class

