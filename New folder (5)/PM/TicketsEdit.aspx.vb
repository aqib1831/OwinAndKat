Imports System.Collections.Generic
Imports Microsoft.VisualBasic
Imports System.Data
Partial Class PM_TicketsEdit
    Inherits System.Web.UI.Page
    Dim colTickets As New List(Of Portal.BLL.PM.PM_Ticket_Features)()
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If HttpContext.Current.Request.QueryString("TicketID") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("TicketID")) Then
                TicketID.Value = Request.QueryString("TicketID")
                FillddlPriority()
                LoadTicket()
                If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
                    Select Case CInt(Request.QueryString("PrevPage"))
                        Case 3 'Tickets
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Tickets.aspx") & "'; return false; ")
                        Case Else
                            btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx") & "'; return false; ")
                    End Select
                End If
            End If
            FillAttachmentsValidations()
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
    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        ddlClients.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
        ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
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
    Private Sub LoadTicket()
        Dim objTicketsBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features()
        colTickets = Portal.BLL.PM.PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(Me.TicketID.Value, Integer))
        Me.lblTicketNo.Text = " # " & colTickets.Item(0).RefNo
        Me.txtName.Text = colTickets.Item(0).Name
        Me.ddlTypes.SelectedValue = colTickets.Item(0).TypeID
        Me.txtDueDate.Text = colTickets.Item(0).DueDate.Date
        Me.ddlClients.SelectedValue = colTickets.Item(0).ClientID
        Me.ddlCategories.SelectedValue = colTickets.Item(0).CatagoryID
        Me.ddlPriority.SelectedValue = colTickets.Item(0).Priority
        Me.txtDescription.Text = colTickets.Item(0).Description
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not Page.IsPostBack Then
            Me.ddlCategories.SelectedValue = colTickets.Item(0).CatagoryID
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objTicketsBLL As New Portal.BLL.PM.PM_Ticket_Features

        If Page.IsValid Then
            With objTicketsBLL
                .ID = TicketID.Value
                .Name = Me.txtName.Text.Trim()
                .ReleaseID = 0
                .DateEntered = System.DateTime.Now.Date
                .Description = Me.txtDescription.Text
                .TypeID = Me.ddlTypes.SelectedValue
                .UserID = Session("AdminID")
                .Read = False
                .Status = 2
                .Deleted = False
                .History = False
                .DueDate = Me.txtDueDate.Text
                .Priority = Me.ddlPriority.SelectedValue
                .CatagoryID = Me.ddlCategories.SelectedValue
                .WaitingForUserID = 0
                .ClientID = Me.ddlClients.SelectedValue
                Dim Affected As Integer = Portal.BLL.PM.PM_Ticket_Features.PM_TicketUpdate(.ID, .Name, .ReleaseID, .DateEntered, .Description, .TypeID, .UserID, .Read, .Status, .Deleted, .History, .DueDate, .Priority, .CatagoryID, .WaitingForUserID, .ClientID, .RefNo)
                If Affected > 0 Then
                    Dim DirectoryName As String = "Tkt" & TicketID.ToString() & "\" & Functions.GetDateTimeUniqueString()
                    If file1.FileName <> Nothing Then
                        .SaveAttachments(DirectoryName, file1, TicketID.Value)
                    End If
                    If file2.FileName <> Nothing Then
                        .SaveAttachments(DirectoryName, file2, TicketID.Value)
                    End If
                    If file3.FileName <> Nothing Then
                        .SaveAttachments(DirectoryName, file3, TicketID.Value)
                    End If
                    Response.Redirect("Tickets.aspx")
                ElseIf Affected = -101 Then
                    lblErrorMessage.Text = "<br/>'" & .Name & "' Already Exists. Please Enter Different Release Name"
                    txtName.Focus()
                End If


            End With
        End If
    End Sub
End Class
