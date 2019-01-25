Imports Portal.BLL

Partial Class PM_ReleasesNew
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
            FillddlStatus()
            If CInt(Session("Type")) = Portal.BLL.Enumeration.UsersType.Fransupport Then
                ddlClients.SelectedValue = 1
                ddlClients.Enabled = False
            End If
            If Request.QueryString("PrevPage") <> String.Empty Then
                PrevPage.Value = Request.QueryString("PrevPage") 'when Comes from Tickets detail as Change Release.VAlUE = "ChangeRelease"'
            End If
            btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Releases.aspx?reClients=" & tktClient & "&reCategories=" & tktCatagory) & "'; return false; ")
            CV_FutureDate.ValueToCompare = DateTime.Now.ToShortDateString()
            ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> parent.ChangeTrBackGround(7);</script>")
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
        'obj = New System.Web.UI.WebControls.ListItem(Portal.BLL.Enumeration.PMStatus.Released.ToString(), Portal.BLL.Enumeration.PMStatus.Released)
        'ddlStatus.Items.Add(obj)
    End Sub

    Protected Sub ddlAreaDeveloper_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAreaDeveloper.DataBound
        If ddlAreaDeveloper.Items.FindByValue("0") Is Nothing Then
            ddlAreaDeveloper.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlClients_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClients.DataBound
        If ddlClients.Items.FindByValue("0") Is Nothing Then
            ddlClients.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlCategories.DataBound
        If ddlCategories.Items.FindByValue("0") Is Nothing Then
            ddlCategories.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objReleases As New Portal.BLL.PM.PM_Releases

        If Page.IsValid Then
            With objReleases
                .Name = Me.txtName.Text.Trim()
                .DateEntered = DateTime.Now
                .ReleaseDate = Me.txtReleaseDate.Text
                .NewReleaseDate = Nothing
                .Progress = 0
                .Status = Me.ddlStatus.SelectedValue
                .Notes = Me.txtNotes.Text.Trim()
                .History = False
                .Deleted = False
                .ClientID = Me.ddlClients.SelectedValue
                .CategoryID = Me.ddlCategories.SelectedValue
                .UserID = Session("AdminID")
                .AreaDeveloperID = ddlAreaDeveloper.SelectedValue
                Dim Affected As Integer = Portal.BLL.PM.PM_Releases.PM_ReleasesAdd(0, .Name, .DateEntered, .ReleaseDate, .NewReleaseDate, .Progress, .Status, .Notes, .History, .Deleted, .ClientID, .CategoryID, .UserID, .AreaDeveloperID)
                If Affected > 0 Then
                    If PrevPage.Value = "ChangeRelease" Then
                        Response.Redirect("TicketsDetail.aspx?ReleaseID=" & Request.QueryString("ReleaseID") & "&ID=" & Request.QueryString("FeatureID") & "&NewReleaseID=" & Affected & "&PrevPage=" & Request.QueryString("TicketDetailPrevPage") & "&reClients=" & tktClient & "&reCategories=" & tktCatagory)
                    Else
                        Response.Redirect("Releases.aspx?reClients=" & tktClient & "&reCategories=" & tktCatagory)
                    End If

                ElseIf Affected = -101 Then
                    lblErrorMessage.Text = "<br/>'" & .Name & "' Already Exists. Please Enter Different Release Name"
                    txtName.Focus()
                End If
            End With
        End If
    End Sub

    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", "" & Portal.BLL.Enumeration.SubModules.PMFullAccess)
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If ddlClients.SelectedValue = Enumeration.ClientID.EA Then
            ddlAreaDeveloper.Attributes.Add("style", "display:inline")
            spnAreaDeveloper.Style.Add("display", "inline")
        Else
            ddlAreaDeveloper.Attributes.Add("style", "display:none")
            spnAreaDeveloper.Style.Add("display", "none")
        End If
    End Sub
End Class
