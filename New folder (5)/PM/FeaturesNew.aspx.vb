Imports System.Collections.Generic
Imports Microsoft.VisualBasic
Partial Class PM_FeaturesNew
    Inherits System.Web.UI.Page
    Dim tktClient As String
    Dim tktCatagory As String
    Dim tktreClient As String
    Dim tktreCatagory As String
    Dim tktFilter As String
    Dim tktTypes As String
    Dim tktSearch As String
    Dim tktReleaseID As String
    Dim colReleases As New List(Of Portal.BLL.PM.PM_Releases)()

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
        If Request.QueryString("ReleaseID") <> String.Empty AndAlso IsNumeric(Request.QueryString("ReleaseID")) Then
            tktReleaseID = Request.QueryString("ReleaseID")
        End If
        If Request.QueryString("reClient") <> String.Empty AndAlso IsNumeric(Request.QueryString("reClient")) Then
            tktreClient = Request.QueryString("reClient")
        End If
        If Request.QueryString("reCatagory") <> String.Empty AndAlso IsNumeric(Request.QueryString("reCatagory")) Then
            tktreCatagory = Request.QueryString("reCatagory")
        End If
        If Not IsPostBack Then
            FillddlStatus()
            txtDueDate.Text = System.DateTime.Now.AddDays(2).ToShortDateString()
            CV_FutureDate.ValueToCompare = DateTime.Now.ToShortDateString()
            FillAttachmentsValidations()

            If String.IsNullOrEmpty(Request.QueryString("ReleaseID")) = False AndAlso IsNumeric(Request.QueryString("ReleaseID")) Then
                hdnReleaseID.Value = Request.QueryString("ReleaseID")
                GetRelease()
                ddlReleases.DataBind()
                Try
                    ddlReleases.SelectedValue = hdnReleaseID.Value
                Catch ex As Exception
                    ddlReleases.SelectedValue = 0
                End Try
            End If
            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Features.aspx?ftrClients=" & tktClient & "&ftrCategories=" & tktCatagory & "&ftrFilter=" & tktFilter & "&ftrTypes=" & tktTypes & "&reClients=" & tktreClient & "&reCategories=" & tktreCatagory & "&ID=" & Request.QueryString("ReleaseID")) & "'; return false; ")
        End If
    End Sub

    Private Sub FillddlStatus()
        Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
        ddlStatus.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Completed", Portal.BLL.Enumeration.PMStatus.Released)
        ddlStatus.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("In Progress", Portal.BLL.Enumeration.PMStatus.InProgress)
        ddlStatus.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Not Started", Portal.BLL.Enumeration.PMStatus.NotStarted)
        ddlStatus.Items.Add(obj)
    End Sub

    Private Sub FillAttachmentsValidations()
        REV_file1.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file1.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file2.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file2.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file3.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file3.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
    End Sub

    Protected Sub ddlReleases_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReleases.SelectedIndexChanged
        If ddlReleases.SelectedValue > 0 Then
            hdnReleaseID.Value = ddlReleases.SelectedValue
            GetRelease()
        End If
    End Sub
    Private Sub GetRelease()
        colReleases = Portal.BLL.PM.PM_Releases.PM_ReleasesGetByID(hdnReleaseID.Value)
        If colReleases.Count > 0 Then
            Me.hdnCategoryID.Value = colReleases.Item(0).CategoryID
            Me.hdnClientID.Value = colReleases.Item(0).ClientID
            If (colReleases.Item(0).NewReleaseDate.ToShortDateString() <> "1/1/1900") Then
                Me.hdnReleaseDueDate.Value = colReleases.Item(0).NewReleaseDate.ToShortDateString()
            Else
                Me.hdnReleaseDueDate.Value = colReleases.Item(0).ReleaseDate.ToShortDateString()
            End If

        End If
    End Sub

    Protected Sub ddlReleases_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReleases.DataBound
        ddlReleases.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
        ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objFeturesBLL As New Portal.BLL.PM.PM_Ticket_Features
        Dim FeatureID As Integer
        Dim CatUserID As Integer = 0
        Dim StatusId As Integer = Me.ddlStatus.SelectedValue
        If Page.IsValid Then
            'If ddlStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.NotStarted Or _
            'ddlStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.InProgress Then
            '    CatUserID = Portal.BLL.PM.PM_Ticket_Features.PM_CategoryUserGetByID(Me.hdnCategoryID.Value)
            '    StatusId = Portal.BLL.Enumeration.PMStatus.WaitingFor
            '    'ddlWaitingFor.SelectedValue = CatUserID
            'End If
            With objFeturesBLL
                .Name = Me.txtName.Text.Trim()
                .ReleaseID = Me.ddlReleases.SelectedValue
                .DateEntered = System.DateTime.Now.Date
                .Description = Me.txtDescription.Text
                .TypeID = Me.ddlTypes.SelectedValue
                .UserID = Session("AdminID")
                .Read = False
                .Status = StatusId
                .Deleted = False
                .History = False
                .DueDate = Me.txtDueDate.Text
                .Priority = "2" ' normal just hard coding
                .CatagoryID = Me.hdnCategoryID.Value
                '.WaitingForUserID = CatUserID
                .ClientID = Me.hdnClientID.Value
                FeatureID = .PM_TicketAdd()
                If FeatureID > 0 Then
                    Dim DirectoryName As String = "Ftr" & FeatureID.ToString() & "\" & Functions.GetDateTimeUniqueString()
                    Dim fileuTel1 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file1.UniqueID)
                    Dim fileuTel2 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file2.UniqueID)
                    Dim fileuTel3 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file3.UniqueID)
                    If Not fileuTel1 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel1, FeatureID)
                    End If
                    If Not fileuTel2 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel2, FeatureID)
                    End If
                    If Not fileuTel3 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel3, FeatureID)
                    End If
                    'Response.Redirect("TicketsDetail.aspx?ID=" & FeatureID & "&PrevPage=4&NewTicket=True")
                    Response.Redirect("TicketsDetail.aspx?ID=" & FeatureID & "&PrevPage=2&NewTicket=True&ReleaseID=" & Me.ddlReleases.SelectedValue & "&ddlClients=" & hdnClientID.Value.ToString() & "&ddlCategories=" & hdnCategoryID.Value.ToString() & "&ddlTypes=" & ddlTypes.SelectedValue.ToString() & "&ddlFilter=" & tktFilter.ToString() & "&reClients=" & tktreClient & "&reCategories=" & tktreCatagory & "';")
                    'Response.Redirect("Features.aspx?ddlClients=" & tktClient & "&ddlCategories=" & tktCatagory & "&ddlFilter=" & tktFilter & "&ddlTypes=" & tktTypes & "&reClients=" & tktreClient & "&reCategories=" & tktreCatagory & "&ID=" & Me.ddlReleases.SelectedValue)
                ElseIf FeatureID = -101 Then
                    lblErrorMessage.Text = "<br/>'" & .Name & "' Already Exists. Please Enter Different Release Name"
                    txtName.Focus()
                End If
            End With
        End If

    End Sub
End Class
