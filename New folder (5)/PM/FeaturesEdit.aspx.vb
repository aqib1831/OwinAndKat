Imports System.Collections.Generic
Partial Class PM_FeaturesEdit
    Inherits System.Web.UI.Page
    Dim colFeature As New List(Of Portal.BLL.PM.PM_Ticket_Features)()

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If HttpContext.Current.Request.QueryString("FeatureID") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("FeatureID")) Then
                hdnFeatureID.Value = Request.QueryString("FeatureID")
                LoadFeature()
                If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
                    Select Case CInt(Request.QueryString("PrevPage"))
                        Case 1 'TicketsDetail from Home
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/TicketsDetail.aspx?ID=" & hdnFeatureID.Value & "&PrevPage=1") & "'; return false; ")
                        Case 2 'Feature
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Features.aspx?ID=" & colFeature.Item(0).ReleaseID) & "'; return false; ")
                        Case 3 'TicketsDetail from Tickets
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/TicketsDetail.aspx?ID=" & hdnFeatureID.Value & "&PrevPage=3") & "'; return false; ")
                        Case 4 'TicketsDetail from MyTickets
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/TicketsDetail.aspx?ID=" & hdnFeatureID.Value & "&PrevPage=4") & "'; return false; ")
                        Case Else
                            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Features.aspx?ID=" & colFeature.Item(0).ReleaseID) & "'; return false; ")
                    End Select
                End If
            End If
            FillAttachmentsValidations()
        End If
    End Sub
    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not Page.IsPostBack Then
            Me.ddlReleases.SelectedValue = colFeature.Item(0).ReleaseID
        End If
    End Sub
    Protected Sub ddlReleases_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReleases.DataBound
        ddlReleases.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    Protected Sub ddlTypes_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTypes.DataBound
        ddlTypes.Items.Insert(0, New ListItem("Select...", 0))
    End Sub
    Private Sub LoadFeature()
        Dim objTicketsBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features()
        colFeature = Portal.BLL.PM.PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(Me.hdnFeatureID.Value, Integer))
        Me.txtName.Text = colFeature.Item(0).Name
        'Me.ddlReleases.SelectedValue = colFeature.Item(0).ReleaseID *** Page_PreRenderComplete
        Me.ddlTypes.SelectedValue = colFeature.Item(0).TypeID
        Me.txtDueDate.Text = colFeature.Item(0).DueDate
        Me.txtDescription.Text = colFeature.Item(0).Description
        Me.hdnCategoryID.Value = colFeature.Item(0).CatagoryID
        Me.hdnClientID.Value = colFeature.Item(0).ClientID

        If colFeature.Item(0).ReleaseID = 0 Then
            lblTitle.Text = "Import As Feature (Ticket # " & colFeature.Item(0).RefNo & ")"
        Else
            lblTitle.Text = "Edit Feature Ref # " & colFeature.Item(0).RefNo
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

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objFeturesBLL As New Portal.BLL.PM.PM_Ticket_Features

        If Page.IsValid Then
            With objFeturesBLL
                .ID = Me.hdnFeatureID.Value
                .Name = Me.txtName.Text.Trim()
                .ReleaseID = Me.ddlReleases.SelectedValue
                .DateEntered = System.DateTime.Now.Date
                .Description = Me.txtDescription.Text
                .TypeID = Me.ddlTypes.SelectedValue
                .UserID = Session("AdminID")
                .Read = False
                .Status = 0
                .Deleted = False
                .History = False
                .DueDate = Me.txtDueDate.Text
                .Priority = "2" ' normal just hard coding
                .CatagoryID = Me.hdnCategoryID.Value
                .WaitingForUserID = 0
                .ClientID = Me.hdnClientID.Value
                Dim Affected As Integer = Portal.BLL.PM.PM_Ticket_Features.PM_FeaturesUpdate(.ID, .Name, .ReleaseID, .DateEntered, .Description, .TypeID, .UserID, .Read, .Status, .Deleted, .History, .DueDate, .Priority, .CatagoryID, .WaitingForUserID, .ClientID, .RefNo)
                If Affected > 0 Then
                    Dim DirectoryName As String = "Tkt" & Me.hdnFeatureID.Value.ToString() & "\" & Functions.GetDateTimeUniqueString()
                    Dim fileuTel1 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file1.UniqueID)
                    Dim fileuTel2 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file2.UniqueID)
                    Dim fileuTel3 As Telerik.WebControls.UploadedFile = Telerik.WebControls.RadUploadContext.Current.UploadedFiles(file3.UniqueID)
                    If Not fileuTel1 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel1, Me.hdnFeatureID.Value)
                    End If
                    If Not fileuTel2 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel2, Me.hdnFeatureID.Value)
                    End If
                    If Not fileuTel3 Is Nothing Then
                        .SaveAttachmentsTelerik(DirectoryName, fileuTel3, Me.hdnFeatureID.Value)
                    End If
                    Response.Redirect("Features.aspx?ID=" & Me.ddlReleases.SelectedValue)
                ElseIf Affected = -101 Then
                    lblErrorMessage.Text = "<br/>'" & .Name & "' Already Exists. Please Enter Different Release Name"
                    txtName.Focus()
                End If
            End With
        End If

    End Sub
    
    Protected Sub ddlReleases_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReleases.SelectedIndexChanged
        If ddlReleases.SelectedValue > 0 Then
            GetRelease()
        End If
    End Sub
    Private Sub GetRelease()
        Dim colReleases As New List(Of Portal.BLL.PM.PM_Releases)()
        colReleases = Portal.BLL.PM.PM_Releases.PM_ReleasesGetByID(ddlReleases.SelectedValue)
        If colReleases.Count > 0 Then
            Me.hdnCategoryID.Value = colReleases.Item(0).CategoryID
            Me.hdnClientID.Value = colReleases.Item(0).ClientID
        End If
    End Sub
End Class
