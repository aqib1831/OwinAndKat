Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports System.Collections.Generic
Imports System.Data.SqlClient
Partial Class AddActivity
    Inherits System.Web.UI.Page

    Const NotApplicable As Integer = Integer.MaxValue
    Dim WaitingForID As String = "0"    
    Dim doBindControl As Boolean = False


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
            ddlActivityStatus.Attributes.Add("onchange", "javascript:return activityStateChange();")
            FillAttachmentsValidations()
            FillddlTopicDataSource()
            ConstructJSModuleArray()
            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ShowProductSelectorDiv", "ShowAndSetDivDimentions('ProductSelectorDiv')", True)
            'ddlTopic.SelectedValue = ActivityTopic.com_Activities_Topic_GetTopicIDByUserID(Session("AdminID"))
        End If
    End Sub

    Private Sub ConstructJSModuleArray()
        Dim strModules As New StringBuilder()
        strModules.Append("var arrModules = new Array();")

        Dim objModuleMgr As New Portal.DAL.NSProductModuleManager()
        Dim tblModules As Data.DataTable = objModuleMgr.GetAll(0, 0, String.Empty)
        Dim index As Integer = 0
        For Each row As Data.DataRow In tblModules.Rows
            strModules.Append("arrModules[" & index & "] = '" & row("ProductID") & "_" & row("ID") & "_" & row("Name") & "';")
            index += 1
        Next

        ltrlModulesArray.Text = strModules.ToString()
        ltrlNotApplicable.Text = NotApplicable
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
        BindEAFranchise()
    End Sub

    Protected Sub BindEAFranchise()
        lblFranchiseName.ToolTip = Portal.BLL.Franchises.GetStoreNickByFranchiseID(CInt(hdnFranchiseID.Value))
        lblFranchiseName.Text = Functions.StringTruncate(lblFranchiseName.ToolTip, 30)
    End Sub

    Protected Sub ddlFranchiseContact_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFranchiseContact.DataBound
        ddlFranchiseContact.Items.Insert(0, New ListItem("Select..", "0"))
    End Sub

    Protected Sub ddlProducts_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.DataBound
        ddlProducts.Items.Insert(0, New ListItem("Select..", "0"))
        ddlProducts.Items.Add(New ListItem("Not Applicable", NotApplicable))
    End Sub



    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim Client As Integer = CInt(IIf(hdnClientID.Value = "0", "1", hdnClientID.Value))
        Dim ObjectActivity As New Portal.BLL.Activities
        Dim ActivityID As Integer = 0
        If Page.IsValid Then
            With ObjectActivity
                .Subject = txtActivitySubject.Text.Trim
                .Type = ddlType.SelectedValue
                .SubType = ddlTopic.SelectedValue
                .TimeSpent = TimeSpan.Parse(ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue)
                .FranchiseID = CInt(hdnFranchiseID.Value)
                .DepartmentID = Portal.BLL.Enumeration.EAI_DepartmentID.Netsolace
                .Description = txtDescription.Text.Trim
                .ActivityDate = DateTime.Now
                .ActivityState = ddlActivityStatus.SelectedValue
                .RelatedTo = ddlProducts.SelectedValue
                If .RelatedTo = NotApplicable Then
                    .ModuleId = NotApplicable
                Else
                    .ModuleId = hdnSelectedModule.Value
                End If

                If CInt(ddlActivityStatus.SelectedValue) = Enumeration.ActivityState.WaitingFor Then
                    .WaitingFor = ddlWaitingFor.SelectedValue
                Else
                    .WaitingFor = "0"
                End If
                If CInt(ddlActivityStatus.SelectedValue) = Enumeration.ActivityState.Completed Then
                    .Status = True
                    .AdminInboxStatus = 1           'Making it closed in admin inbox status and status as closed.
                Else
                    .Status = False
                    .AdminInboxStatus = 0
                End If
                .PlacedBy = Enumeration.PlacedBy.PortalAdmin
                .UserID = CInt(Session("AdminID"))
                .FranchiseContactID = ddlFranchiseContact.SelectedValue
                .ClientContactID = 0
                .Priority = ddlPriority.SelectedValue
                .ClientID = CInt(hdnClientID.Value)
                .Charge = False
                ActivityID = .ActivitiesAdd(ObjectActivity)
                hdnID.Value = ActivityID.ToString()
                If ddlPriority.SelectedValue = "5" Then
                    Activities.SendMail("Support", "support@netsolace.com", txtActivitySubject.Text.Trim, "A ticket has been created with cirtical priority", Functions.GetActivityPrefix(ObjectActivity.Type) & ActivityID, txtActivitySubject.Text.Trim, lblFranchiseName.Text)
		    'Activities.SendMail("Support", "sraza@broadpeakit.com", txtActivitySubject.Text.Trim, "A ticket has been created with cirtical priority", Functions.GetActivityPrefix(ObjectActivity.Type) & ActivityID, txtActivitySubject.Text.Trim, lblFranchiseName.Text)

                End If

            End With
            If ActivityID > 0 Then
                Dim objActivityAttachement As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
                With objActivityAttachement
                    .ActivityID = ActivityID            'The activity against which notes are to be added.                    
                    .NotesID = 0                        'If the attachement is not for a note then notes id must be zero
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
                    Response.Redirect("Franchise_Inbox.aspx?FranchiseID=" & hdnFranchiseID.Value & "&ClientID=" & hdnClientID.Value)
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
    End Sub

    Protected Sub ddlDivProducts_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDivProducts.DataBound
        ddlDivProducts.Items.Insert(0, New ListItem("Select..", "0"))
        ddlDivProducts.Items.Add(New ListItem("Not Applicable", NotApplicable))
    End Sub

    Protected Sub btnDivProductSelect_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDivProductSelect.Click
        ProcessProductSupportStatus()
    End Sub

    Private Function ProcessProductSupportStatus() As Enumeration.ProductStatus
        If ddlProducts.SelectedValue = NotApplicable OrElse Portal.BLL.NSProducts.ShouldCheckForSupport(ddlProducts.SelectedValue) = False Then
            HideProductDiv()
            SetModulesDisplay(ddlDivProducts)
            Return Enumeration.ProductStatus.Allowed
        End If

        Dim ProductStatus As Enumeration.ProductStatus
        Dim Notes As String = String.Empty
        ProductStatus = Portal.BLL.Franchises.CheckFranchiseProductSupportStatus(ddlDivProducts.SelectedValue, hdnFranchiseID.Value, Notes)
        If ProductStatus = Enumeration.ProductStatus.Allowed Then
            HideProductDiv()
        Else
            If ProductStatus = Enumeration.ProductStatus.Expired Then
                DivProductStatusMessage.InnerHtml = "Support has been expired for " & ddlProducts.SelectedItem.Text
                DivProductStatusMessageDeatil.InnerHtml = "Please advise store to contact Netsolace Support Manager"
            ElseIf ProductStatus = Enumeration.ProductStatus.NotSignedUp Then
                DivProductStatusMessage.InnerHtml = "Store has not signed up for support for " & ddlProducts.SelectedItem.Text
                DivProductStatusMessageDeatil.InnerHtml = "Please advise store to contact Netsolace Support Manager"
            ElseIf ProductStatus = Enumeration.ProductStatus.TurnedOff Then
                DivProductStatusMessage.InnerHtml = "Support has been turned off for " & ddlProducts.SelectedItem.Text
                DivProductStatusMessageDeatil.InnerHtml = "Please advise store to contact Netsolace Accounts Manager"
                DivProductStatusMessageDeatil.InnerHtml &= "<br/><b>Reason</b>: " & Notes
            End If
            ProductSelectorDiv.Style.Add("display", "none")
            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ShowAndSetDiv", "ShowAndSetDivDimentions('DivProductStatus')", True)
        End If
    End Function

    Private Sub HideProductDiv()
        modalBackgroundDiv.Style.Add("display", "none")
        ProductSelectorDiv.Style.Add("display", "none")

        ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "LoadProductModulesByProductID", "LoadProductModulesByProductID(" & ddlDivProducts.SelectedValue & "," & hdnSelectedModule.Value & ");", True)
    End Sub

    Protected Sub ddlProducts_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlProducts.SelectedIndexChanged
        SetModulesDisplay(ddlProducts)
    End Sub

    Private Sub SetModulesDisplay(ByVal ddlProduct As DropDownList)
        If ddlProduct.SelectedValue = NotApplicable Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "HideModules", "SetModulesDisplay('none');", True)
        Else
            ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "ShowModules", "SetModulesDisplay('inline');", True)
        End If
    End Sub
End Class