Imports System.Collections.Generic
Imports Microsoft.VisualBasic
Partial Class PM_ReleasesEdit
    Inherits System.Web.UI.Page
    Dim reClient As String
    Dim reCatagory As String
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    If HttpContext.Current.Request.QueryString("reClients") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("reClients")) Then
            reClient = Request.QueryString("reClients")
        End If
        If HttpContext.Current.Request.QueryString("reCategories") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("reCategories")) Then
            reCatagory = Request.QueryString("reCategories")
        End If
        If Not Page.IsPostBack Then
            If HttpContext.Current.Request.QueryString("ID") <> String.Empty AndAlso IsNumeric(HttpContext.Current.Request.QueryString("ID")) Then
                ReleaseID.Value = Request.QueryString("ID")
                FillddlStatus()
                LoadRelease()
            End If
            If CInt(Session("Type")) = Portal.BLL.Enumeration.UsersType.Fransupport Then
                ddlClients.SelectedValue = 1
                ddlClients.Enabled = False
            End If
            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Releases.aspx?reClients=" & reClient & "&reCategories=") & reCatagory & "'; return false; ")
            'CV_FutureDate.ValueToCompare = DateTime.Now.ToShortDateString()
        End If
    End Sub

    Private Sub LoadRelease()
        Dim objReleases As Portal.BLL.PM.PM_Releases = New Portal.BLL.PM.PM_Releases()
        Dim colReleases As New List(Of Portal.BLL.PM.PM_Releases)()
        colReleases = Portal.BLL.PM.PM_Releases.PM_ReleasesGetByID(ReleaseID.Value)
        If colReleases.Count > 0 Then

            Me.txtName.Text = colReleases.Item(0).Name
            Me.lblDateCreated.Text = colReleases.Item(0).DateEntered
            Me.lblReleaseDate.Text = colReleases.Item(0).ReleaseDate
            If (colReleases.Item(0).NewReleaseDate = "1/1/1900" Or colReleases.Item(0).NewReleaseDate = Nothing) Then
                Me.txtNewReleaseDate.Text = ""
            Else
                Me.txtNewReleaseDate.Text = colReleases.Item(0).NewReleaseDate
            End If
            Me.ddlStatus.SelectedValue = colReleases.Item(0).Status
            ddlClients.DataBind()
            Me.ddlClients.SelectedValue = colReleases.Item(0).ClientID
            ddlCategories.DataBind()
            Me.ddlCategories.SelectedValue = colReleases.Item(0).CategoryID
            UPCategories.Update()
            Me.txtNotes.Text = colReleases.Item(0).Notes
            Me.hdnProgress.Value = colReleases.Item(0).Progress
            'CV_GreaterDate.ValueToCompare = colReleases.Item(0).ReleaseDate

        End If


    End Sub

    Private Sub FillddlStatus()
        Dim obj As System.Web.UI.WebControls.ListItem = New System.Web.UI.WebControls.ListItem("Select...", 0)
        ddlStatus.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Delayed", Portal.BLL.Enumeration.PMStatus.Delayed)
        ddlStatus.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("In Progress", Portal.BLL.Enumeration.PMStatus.InProgress)
        ddlStatus.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Not Started", Portal.BLL.Enumeration.PMStatus.NotStarted)
        ddlStatus.Items.Add(obj)
        obj = New System.Web.UI.WebControls.ListItem("Released", Portal.BLL.Enumeration.PMStatus.Released)
        ddlStatus.Items.Add(obj)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objReleases As New Portal.BLL.PM.PM_Releases

        If Page.IsValid Then
            With objReleases
                .ID = Me.ReleaseID.Value
                .Name = Me.txtName.Text.Trim()
                .DateEntered = System.DateTime.Now.Date
                .ReleaseDate = Me.lblReleaseDate.Text
                .NewReleaseDate = IIf(Me.txtNewReleaseDate.Text.Trim() = "", Nothing, Me.txtNewReleaseDate.Text)
                .Progress = 0
                .Status = Me.ddlStatus.SelectedValue
                .Notes = Me.txtNotes.Text.Trim()
                .History = False
                .Deleted = False
                .ClientID = Me.ddlClients.SelectedValue
                .CategoryID = Me.ddlCategories.SelectedValue
                .UserID = Session("Admin_SessionID")
                .AreaDeveloperID = 0
                Dim Affected As Integer = Portal.BLL.PM.PM_Releases.PM_ReleasesUpdate(.ID, .Name, .DateEntered, .ReleaseDate, .NewReleaseDate, .Progress, .Status, .Notes, .History, .Deleted, .ClientID, .CategoryID, .UserID, .AreaDeveloperID)
                If Affected > 0 Then
                    Response.Redirect("Releases.aspx?reClients=" & reClient & "&reCategories=" & reCatagory)
                ElseIf Affected = -101 Then
                    lblErrorMessage.Text = "<br/>'" & .Name & "' Already Exists. Please Enter Different Release Name"
                    txtName.Focus()
                End If
            End With
        End If
    End Sub

    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        ddlClients.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", "" & Portal.BLL.Enumeration.SubModules.PMFullAccess)
    End Sub
End Class

