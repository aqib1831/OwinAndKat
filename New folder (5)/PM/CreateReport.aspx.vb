
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection

Partial Class PM_CreateReport
    Inherits System.Web.UI.Page
    Private userId As Integer
    Protected ClientDataTable As DataTable
    Protected ClientRowCount As Integer = 0
    Protected TypeDataTable As DataTable
    Protected TypeRowCount As Integer = 0
    Protected CategoryDataTable As DataTable
    Protected CategoryRowCount As Integer = 0
    Protected CategorySubDataTable As DataTable
    Protected CategorySubRowCount As Integer = 0
    Protected SubCategoryDataTable As DataTable
    Protected SubCategoryRowCount As Integer = 0
    Protected PriorityDataTable As DataTable
    Protected PriortyRowCount As Integer = 0
    Protected StatusDataTable As DataTable
    Protected StatusRowCount As Integer = 0
    Protected TeamDataTable As DataTable
    Protected TeamRowCount As Integer = 0
    Protected ReleasesDataTable As DataTable
    Protected ReleasesRowCount As Integer = 0
    Protected SuveryDataTable As DataTable
    Protected SuveryRowCount As Integer = 0
    Protected ProductOwnerDataTable As DataTable
    Protected ProductOwnerRowCount As Integer = 0
    Protected ProjectManagerDataTable As DataTable
    Protected ProjectManagerRowCount As Integer = 0
    Protected DesignLeadDataTable As DataTable
    Protected DesignLeadRowCount As Integer = 0
    Protected DevLeadDataTable As DataTable
    Protected DevLeadRowCount As Integer = 0
    Protected QALeadDataTable As DataTable
    Protected QALeadRowCount As Integer = 0
    Protected ReportedByDataTable As DataTable
    Protected ReportedRowCount As Integer = 0
    Protected AssignedToDataTable As DataTable
    Protected AssignedToRowCount As Integer = 0
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        userId = CType(HttpContext.Current.Session("AdminID"), Integer)
        BindCkeckBox()
        LoadDataForDropDown()
        BindIDs()
    End Sub


    Private Sub BindCkeckBox()
        lstMultipleValues.Attributes.Add("onclick", "FindSelectedItems (this," + txtSelectedMLValues.ClientID + ");")
        TypeList.Attributes.Add("onclick", "FindSelectedItems (this," + txtTypeList.ClientID + ");")
        ddlCategory.Attributes.Add("onclick", "FindSelectedItems (this," + txtCategory.ClientID + ");")
        ddlPriority.Attributes.Add("onclick", "FindSelectedItems (this," + txtPriority.ClientID + ");")
        ddlStatus.Attributes.Add("onclick", "FindSelectedItems (this," + txtStatus.ClientID + ");")
        ddlTeams.Attributes.Add("onclick", "FindSelectedItems (this," + txtTeam.ClientID + ");")
        ddlReleases.Attributes.Add("onclick", "FindSelectedItems (this," + txtRelease.ClientID + ");")
        ddlProductOwner.Attributes.Add("onclick", "FindSelectedItems (this," + txtProductOwner.ClientID + ");")
        ddlManager.Attributes.Add("onclick", "FindSelectedItems (this," + txtProjectManager.ClientID + ");")
        ddlDesignLead.Attributes.Add("onclick", "FindSelectedItems (this," + txtDesignLead.ClientID + ");")
        ddlDevelopmentLead.Attributes.Add("onclick", "FindSelectedItems (this," + txtDevLead.ClientID + ");")
        ddlQALead.Attributes.Add("onclick", "FindSelectedItems (this," + txtQALead.ClientID + ");")
        ddlReportedBy.Attributes.Add("onclick", "FindSelectedItems (this," + txtReportedBy.ClientID + ");")
        ddlAssignTo.Attributes.Add("onclick", "FindSelectedItems (this," + txtAssignedTo.ClientID + ");")
        ddlSurvey.Attributes.Add("onclick", "FindSelectedItems (this," + txtSurvey.ClientID + ");")
        ddlSubCategory.Attributes.Add("onclick", "FindSelectedItems (this," + txtSubCategory.ClientID + ");")
    End Sub
    Private Sub LoadDataForDropDown()
        LoadData(userId)
        LoadTypes()
        LoadCategory()
        LoadSubCategory()
        loadStatus()
        LoadPriority()
        LoadProjectManager()
        LoadProductOwner()
        LoadDesignLead()
        LoadDevelopmentLead()
        LoadQALead()
        LoadAllUser()
        LoadSurvey()
        LoadReleases()
        LoadTeams()
    End Sub
    Private Sub BindIDs()
        BindClientSpanvalues()
        BindTypeSpanvalues()
        BindCatSpanvalues()
        BindSubCatSpanvalues()
        BindPriortySpanvalues()
        'BindStatusSpanvalues()
        BindTeamSpanvalues()
        BindReleaseSpanvalues()
        BindAssignedToSpanvalues()
        BindProductOwnerSpanvalues()
        BindStatusSpanvalues()
        BindProjectManagerSpanvalues()
        BindDevLeadSpanvalues()
        BindDesignLeadSpanvalues()
        BindQALeadSpanvalues()
        BindSuverySpanvalues()
        BindReportedBySpanvalues()

    End Sub

    Protected Sub BindClientSpanvalues()
        Dim checkbox As CheckBoxList = lstMultipleValues
        For Each item As ListItem In checkbox.Items
            Dim Id As String = ClientDataTable.Rows(ClientRowCount).Item(0).ToString()

            checkbox.Items(ClientRowCount).Attributes.Add("data-value", Id)
            ClientRowCount = ClientRowCount + 1
        Next
    End Sub

    Protected Sub BindTypeSpanvalues()
        Dim checkbox As CheckBoxList = TypeList
        For Each item As ListItem In checkbox.Items
            Dim Id As String = TypeDataTable.Rows(TypeRowCount).Item(0).ToString()

            checkbox.Items(TypeRowCount).Attributes.Add("data-value", Id)
            TypeRowCount = TypeRowCount + 1
        Next
    End Sub

    Protected Sub BindCatSpanvalues()
        Dim checkbox As CheckBoxList = ddlCategory
        For Each item As ListItem In checkbox.Items
            Dim Id As String = CategoryDataTable.Rows(CategoryRowCount).Item(0).ToString()

            checkbox.Items(CategoryRowCount).Attributes.Add("data-value", Id)
            CategoryRowCount = CategoryRowCount + 1
        Next
    End Sub

    Protected Sub BindSubCatSpanvalues()
        Dim checkbox As CheckBoxList = ddlSubCategory
        For Each item As ListItem In checkbox.Items
            Dim Id As String = SubCategoryDataTable.Rows(SubCategoryRowCount).Item(0).ToString()

            checkbox.Items(SubCategoryRowCount).Attributes.Add("data-value", Id)
            SubCategoryRowCount = SubCategoryRowCount + 1
        Next
    End Sub
    Protected Sub BindPriortySpanvalues()
        Dim checkbox As CheckBoxList = ddlPriority
        For Each item As ListItem In checkbox.Items
            Dim Id As String = PriorityDataTable.Rows(PriortyRowCount).Item(0).ToString()

            checkbox.Items(PriortyRowCount).Attributes.Add("data-value", Id)
            PriortyRowCount = PriortyRowCount + 1
        Next
    End Sub
    Protected Sub BindStatusSpanvalues()
        Dim checkbox As CheckBoxList = ddlStatus
        For Each item As ListItem In checkbox.Items
            Dim Id As String = StatusDataTable.Rows(StatusRowCount).Item(0).ToString()

            checkbox.Items(StatusRowCount).Attributes.Add("data-value", Id)
            StatusRowCount = StatusRowCount + 1
        Next
    End Sub
    Protected Sub BindTeamSpanvalues()
        Dim checkbox As CheckBoxList = ddlTeams
        For Each item As ListItem In checkbox.Items
            Dim Id As String = TeamDataTable.Rows(TeamRowCount).Item(0).ToString()

            checkbox.Items(TeamRowCount).Attributes.Add("data-value", Id)
            TeamRowCount = TeamRowCount + 1
        Next
    End Sub

    Protected Sub BindReleaseSpanvalues()
        Dim checkbox As CheckBoxList = ddlReleases
        For Each item As ListItem In checkbox.Items
            Dim Id As String = ReleasesDataTable.Rows(ReleasesRowCount).Item(0).ToString()

            checkbox.Items(ReleasesRowCount).Attributes.Add("data-value", Id)
            ReleasesRowCount = ReleasesRowCount + 1
        Next
    End Sub


    Protected Sub BindProductOwnerSpanvalues()
        Dim checkbox As CheckBoxList = ddlProductOwner
        For Each item As ListItem In checkbox.Items
            Dim Id As String = ProductOwnerDataTable.Rows(ProductOwnerRowCount).Item(0).ToString()

            checkbox.Items(ProductOwnerRowCount).Attributes.Add("data-value", Id)
            ProductOwnerRowCount = ProductOwnerRowCount + 1
        Next
    End Sub

    Protected Sub BindProjectManagerSpanvalues()
        Dim checkbox As CheckBoxList = ddlManager
        For Each item As ListItem In checkbox.Items
            Dim Id As String = ProjectManagerDataTable.Rows(ProjectManagerRowCount).Item(0).ToString()

            checkbox.Items(ProjectManagerRowCount).Attributes.Add("data-value", Id)
            ProjectManagerRowCount = ProjectManagerRowCount + 1
        Next
    End Sub

    Protected Sub BindDesignLeadSpanvalues()
        Dim checkbox As CheckBoxList = ddlDesignLead
        For Each item As ListItem In checkbox.Items
            Dim Id As String = DesignLeadDataTable.Rows(DesignLeadRowCount).Item(0).ToString()

            checkbox.Items(DesignLeadRowCount).Attributes.Add("data-value", Id)
            DesignLeadRowCount = DesignLeadRowCount + 1
        Next
    End Sub

    Protected Sub BindDevLeadSpanvalues()
        Dim checkbox As CheckBoxList = ddlDevelopmentLead
        For Each item As ListItem In checkbox.Items
            Dim Id As String = DevLeadDataTable.Rows(DevLeadRowCount).Item(0).ToString()

            checkbox.Items(DevLeadRowCount).Attributes.Add("data-value", Id)
            DevLeadRowCount = DevLeadRowCount + 1
        Next
    End Sub

    Protected Sub BindQALeadSpanvalues()
        Dim checkbox As CheckBoxList = ddlQALead
        For Each item As ListItem In checkbox.Items
            Dim Id As String = QALeadDataTable.Rows(QALeadRowCount).Item(0).ToString()

            checkbox.Items(QALeadRowCount).Attributes.Add("data-value", Id)
            QALeadRowCount = QALeadRowCount + 1
        Next
    End Sub

    Protected Sub BindReportedBySpanvalues()
        Dim checkbox As CheckBoxList = ddlReportedBy
        For Each item As ListItem In checkbox.Items
            Dim Id As String = AssignedToDataTable.Rows(ReportedRowCount).Item(0).ToString()

            checkbox.Items(ReportedRowCount).Attributes.Add("data-value", Id)
            ReportedRowCount = ReportedRowCount + 1
        Next
    End Sub

    Protected Sub BindAssignedToSpanvalues()
        Dim checkbox As CheckBoxList = ddlAssignTo
        For Each item As ListItem In checkbox.Items
            Dim Id As String = AssignedToDataTable.Rows(AssignedToRowCount).Item(0).ToString()

            checkbox.Items(AssignedToRowCount).Attributes.Add("data-value", Id)
            AssignedToRowCount = AssignedToRowCount + 1
        Next
    End Sub
    Protected Sub BindSuverySpanvalues()
        Dim checkbox As CheckBoxList = ddlSurvey
        For Each item As ListItem In checkbox.Items
            Dim Id As String = SuveryDataTable.Rows(SuveryRowCount).Item(0).ToString()

            checkbox.Items(SuveryRowCount).Attributes.Add("data-value", Id)
            SuveryRowCount = SuveryRowCount + 1
        Next
    End Sub
    Private Sub LoadTeams()
        TeamDataTable = Portal.BLL.PM.PM_Ticket_Features.GetAllTeams(1)
        Me.ddlTeams.DataSource = TeamDataTable

        Me.ddlTeams.DataTextField = "Name"
        Me.ddlTeams.DataValueField = "ID"

        Me.ddlTeams.AutoPostBack = False
        Me.ddlTeams.DataBind()
    End Sub

    Private Sub LoadReleases()
        ReleasesDataTable = Portal.BLL.PM.PM_Releases.GetAllReleasesForDropdown()
        Me.ddlReleases.DataSource = ReleasesDataTable

        Me.ddlReleases.DataTextField = "Name"
        Me.ddlReleases.DataValueField = "ID"

        Me.ddlReleases.AutoPostBack = False
        Me.ddlReleases.DataBind()
    End Sub

    Private Sub LoadSurvey()
        SuveryDataTable = GetSurveyValues()

        Me.ddlSurvey.DataSource = SuveryDataTable

        Me.ddlSurvey.DataTextField = "Name"
        Me.ddlSurvey.DataValueField = "ID"

        Me.ddlSurvey.AutoPostBack = False
        Me.ddlSurvey.DataBind()
    End Sub

    Private Sub LoadAllUser()
        AssignedToDataTable = Portal.BLL.PM.PM_Ticket_Features.GetAllUserForAssignTo()

        Me.ddlAssignTo.DataSource = AssignedToDataTable

        Me.ddlAssignTo.DataTextField = "UserName"
        Me.ddlAssignTo.DataValueField = "ID"

        Me.ddlAssignTo.AutoPostBack = False
        Me.ddlAssignTo.DataBind()
        Me.ddlReportedBy.DataSource = AssignedToDataTable

        Me.ddlReportedBy.DataTextField = "UserName"
        Me.ddlReportedBy.DataValueField = "ID"

        Me.ddlReportedBy.AutoPostBack = False
        Me.ddlReportedBy.DataBind()
    End Sub

    Private Sub LoadQALead()
        QALeadDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "QALead"), String))

        Me.ddlQALead.DataSource = QALeadDataTable

        Me.ddlQALead.DataTextField = "Name"
        Me.ddlQALead.DataValueField = "ID"

        Me.ddlQALead.AutoPostBack = False
        Me.ddlQALead.DataBind()
    End Sub

    Private Sub LoadDevelopmentLead()
        DevLeadDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "DevLead"), String))
        Me.ddlDevelopmentLead.DataSource = DevLeadDataTable

        Me.ddlDevelopmentLead.DataTextField = "Name"
        Me.ddlDevelopmentLead.DataValueField = "ID"

        Me.ddlDevelopmentLead.AutoPostBack = False
        Me.ddlDevelopmentLead.DataBind()
    End Sub

    Private Sub LoadDesignLead()
        DesignLeadDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "DesignLead"), String))
        Me.ddlDesignLead.DataSource = DesignLeadDataTable

        Me.ddlDesignLead.DataTextField = "Name"
        Me.ddlDesignLead.DataValueField = "ID"

        Me.ddlDesignLead.AutoPostBack = False
        Me.ddlDesignLead.DataBind()
    End Sub

    Private Sub LoadProductOwner()
        ProductOwnerDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProductOwnerLead"), String))
        Me.ddlProductOwner.DataSource = ProductOwnerDataTable

        Me.ddlProductOwner.DataTextField = "Name"
        Me.ddlProductOwner.DataValueField = "ID"

        Me.ddlProductOwner.AutoPostBack = False
        Me.ddlProductOwner.DataBind()
    End Sub

    Private Sub LoadProjectManager()
        ProjectManagerDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String))
        Me.ddlManager.DataSource = ProjectManagerDataTable

        Me.ddlManager.DataTextField = "Name"
        Me.ddlManager.DataValueField = "ID"

        Me.ddlManager.AutoPostBack = False
        Me.ddlManager.DataBind()
    End Sub

    Private Sub LoadData(userId As Integer)
        Dim sqldt As SqlDataReader = Portal.BLL.Users.GetClientsByUserIDAndSubModuleIDs(CType(HttpContext.Current.Session("AdminID"), Integer), "3")
        ClientDataTable = New DataTable()
        ClientDataTable.Load(sqldt)
        Me.lstMultipleValues.DataSource = ClientDataTable

        Me.lstMultipleValues.DataTextField = "Name"
        Me.lstMultipleValues.DataValueField = "ID"

        Me.lstMultipleValues.AutoPostBack = False
        Me.lstMultipleValues.DataBind()
    End Sub
    Private Sub LoadTypes()
        Me.TypeDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_Search_Type()
        Me.TypeList.DataSource = TypeDataTable
        Me.TypeList.DataTextField = "Name"
        Me.TypeList.DataValueField = "ID"
        Me.TypeList.AutoPostBack = False
        Me.TypeList.DataBind()
    End Sub
    Private Sub LoadCategory()
        Me.CategoryDataTable = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_Search_Category()
        Me.ddlCategory.DataSource = CategoryDataTable

        Me.ddlCategory.DataTextField = "Name"
        Me.ddlCategory.DataValueField = "ID"

        Me.ddlCategory.AutoPostBack = False
        Me.ddlCategory.DataBind()
    End Sub
    Private Sub LoadSubCategory()
        Me.SubCategoryDataTable = Portal.BLL.PM.PM_Releases.GetAllSubCategoryForDropdown()
        Me.ddlSubCategory.DataSource = SubCategoryDataTable

        Me.ddlSubCategory.DataTextField = "Name"
        Me.ddlSubCategory.DataValueField = "ID"

        Me.ddlSubCategory.AutoPostBack = False
        Me.ddlSubCategory.DataBind()
    End Sub
    Private Sub loadStatus()
        Me.StatusDataTable = GetStatusValues()
        Me.ddlStatus.DataSource = StatusDataTable
        Me.ddlStatus.DataTextField = "Name"
        Me.ddlStatus.DataValueField = "ID"
        Me.ddlStatus.AutoPostBack = False
        Me.ddlStatus.DataBind()
    End Sub
    Private Sub LoadPriority()
        Me.PriorityDataTable = GetPriorityValues()
        Me.ddlPriority.DataSource = PriorityDataTable
        Me.ddlPriority.DataTextField = "Name"
        Me.ddlPriority.DataValueField = "ID"
        Me.ddlPriority.AutoPostBack = False
        Me.ddlPriority.DataBind()
    End Sub
    Private Function GetStatusValues() As DataTable
        Dim dt As New DataTable("DataTable")

        Dim dr As DataRow = Nothing
        dt.Columns.AddRange(New DataColumn() {New DataColumn("ID"), New DataColumn("Name")})
        dr = dt.NewRow()

        dr("ID") = "2"
        dr("Name") = "Not Started"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "14"
        dr("Name") = "In Requirement Gathering"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "13"
        dr("Name") = "In Design Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "11"
        dr("Name") = "In Development Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "12"
        dr("Name") = "In QA Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "7"
        dr("Name") = "On Hold"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "10"
        dr("Name") = "Confirm Solved"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "16"
        dr("Name") = "UAT Phase"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "17"
        dr("Name") = "Local Production Checkout"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "18"
        dr("Name") = "Ready to go live"
        dt.Rows.Add(dr)

        Return dt
    End Function
    Private Function GetPriorityValues() As DataTable
        Dim dt As New DataTable("DataTable")

        Dim dr As DataRow = Nothing
        dt.Columns.AddRange(New DataColumn() {New DataColumn("ID"), New DataColumn("Name")})
        dr = dt.NewRow()

        dr("ID") = "1"
        dr("Name") = "High"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "2"
        dr("Name") = "Normal"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "3"
        dr("Name") = "Low"
        dt.Rows.Add(dr)
        Return dt
    End Function
    Private Function GetSurveyValues() As DataTable
        Dim dt As New DataTable("DataTable")

        Dim dr As DataRow = Nothing
        dt.Columns.AddRange(New DataColumn() {New DataColumn("ID"), New DataColumn("Name")})
        dr = dt.NewRow()

        dr("ID") = "1"
        dr("Name") = "Yes"
        dt.Rows.Add(dr)

        dr = dt.NewRow()
        dr("ID") = "2"
        dr("Name") = "No"
        dt.Rows.Add(dr)


        Return dt
    End Function
    Public Function ConvertToDataTable(Of T)(ByVal list As IList(Of T)) As DataTable
        Dim table As New DataTable()
        Dim fields() As FieldInfo = GetType(T).GetFields()
        For Each field As FieldInfo In fields
            table.Columns.Add(field.Name, field.FieldType)
        Next
        For Each item As T In list
            Dim row As DataRow = table.NewRow()
            For Each field As FieldInfo In fields
                row(field.Name) = field.GetValue(item)
            Next
            table.Rows.Add(row)
        Next
        Return table
    End Function


    Protected Sub btnRunSave_Click(sender As Object, e As EventArgs)
        Dim Col As String = GetColumn()


        If String.IsNullOrEmpty(Col) Then

            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "ColoumnValid();", True)

        Else

            Dim dt As DataTable = GetFilterTable()
            Dim S As Integer
            If String.IsNullOrEmpty(hdnlistOfSurveyIds.Value) Then
                S = 0
            Else
                S = 1
            End If
            Dim result As DataTable = Portal.BLL.PM.PM_Ticket_Features.RunAndSaveReport(txtReportName.Text, txtSubject.Text, userId, Col, True, hdnlistOfClientsIds.Value, hdnlistOfTypeIds.Value, hdnlistOfCategoryIds.Value, hdnlistOfSubCategoryIds.Value, hdnlistOfPriortyIds.Value, hdnlistOfStatusIds.Value, hdnlistOfTeamIds.Value, hdnlistOfRelaseseIds.Value, S, hdnlistOfAssignToIds.Value, hdnlistOfProductOwnerIds.Value, hdnlistOfProjectManagers.Value, hdnlistOfDesignLeadIds.Value, hdnlistOfDevLeadIds.Value, hdnlistOfQALeadIds.Value, txtCreationdays.Text, txtCreationDateFrom.Value, txtCreationDateto.Value, txtLatestDays.Text, txtLastestActivity.Value, txtLastestActivityTo.Value, txtSowSignDays.Text, txtSOWSignDate.Value, txtSOWSignDateTo.Value, txtDueDays.Text, txtDueDate.Value, txtDueDateTo.Value, dt)
            Session("dtCart") = result
            Response.Redirect("~/PM/MyReportDetail.aspx?Name=" & txtReportName.Text & "&key=1")

        End If

    End Sub
    Private Function GetColumn() As String
        Dim Columns As String
        If SelectAll.Checked Then
            Columns = "1,14, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 17, 18, 19, 20, 21"
        Else
            For Each item As ListItem In chklstStates.Items
                If item.Selected Then
                    If String.IsNullOrEmpty(Columns) Then
                        Columns = item.Value
                    Else
                        Columns = Columns & ", " & item.Value
                    End If


                End If
            Next
            For Each item As ListItem In CheckBoxResources.Items
                If item.Selected Then
                    If String.IsNullOrEmpty(Columns) Then
                        Columns = item.Value
                    Else
                        Columns = Columns & ", " & item.Value
                    End If


                End If
            Next
            For Each item As ListItem In CheckBoxtimeline.Items
                If item.Selected Then
                    If String.IsNullOrEmpty(Columns) Then
                        Columns = item.Value
                    Else
                        Columns = Columns & ", " & item.Value
                    End If


                End If
            Next
        End If

        Return Columns
    End Function

    Private Function GetFilterTable() As DataTable
        Dim table As New DataTable
        table.Columns.Add("ReportID", GetType(Integer))
        table.Columns.Add("Key", GetType(String))
        table.Columns.Add("Values", GetType(String))
        If Not String.IsNullOrEmpty(hdnlistOfClientsIds.Value) Then
            table.Rows.Add(1, "ClientId", hdnlistOfClientsIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfTypeIds.Value) Then
            table.Rows.Add(1, "TypeIds", hdnlistOfTypeIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfCategoryIds.Value) Then
            table.Rows.Add(1, "CategoryIds", hdnlistOfCategoryIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfSubCategoryIds.Value) Then
            table.Rows.Add(1, "SubCategoryIds", hdnlistOfSubCategoryIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfPriortyIds.Value) Then
            table.Rows.Add(1, "PriorityIds", hdnlistOfPriortyIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfStatusIds.Value) Then
            table.Rows.Add(1, "StatusIds", hdnlistOfStatusIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfTeamIds.Value) Then
            table.Rows.Add(1, "TeamIds", hdnlistOfTeamIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfRelaseseIds.Value) Then
            table.Rows.Add(1, "ReleaseIds", hdnlistOfRelaseseIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfSurveyIds.Value) Then
            table.Rows.Add(1, "SuveryIds", hdnlistOfSurveyIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfProductOwnerIds.Value) Then
            table.Rows.Add(1, "ProductOwnerIds", hdnlistOfProductOwnerIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfProjectManagers.Value) Then
            table.Rows.Add(1, "ProjectManagerIds", hdnlistOfProjectManagers.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfDevLeadIds.Value) Then
            table.Rows.Add(1, "DevelopmentLeadIds", hdnlistOfDevLeadIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfDesignLeadIds.Value) Then
            table.Rows.Add(1, "DesignLeadIds", hdnlistOfDesignLeadIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfQALeadIds.Value) Then
            table.Rows.Add(1, "QALeadIds", hdnlistOfQALeadIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfreportedByIds.Value) Then
            table.Rows.Add(1, "ReporteByIds", hdnlistOfreportedByIds.Value)
        End If
        If Not String.IsNullOrEmpty(hdnlistOfAssignToIds.Value) Then
            table.Rows.Add(1, "AssignToIds", hdnlistOfAssignToIds.Value)
        End If
        Return table
    End Function



    Protected Sub btnRun_Click(sender As Object, e As EventArgs)
        Dim Col As String = GetColumn()

        If String.IsNullOrEmpty(Col) Then

            Page.ClientScript.RegisterStartupScript(Me.GetType(), "myScript", "ColoumnValid();", True)

        Else
            Dim S As Integer
            If String.IsNullOrEmpty(hdnlistOfSurveyIds.Value) Then
                S = 0
            Else
                S = 1
            End If
            Dim dt As DataTable = GetFilterTable()
            Dim result As DataTable = Portal.BLL.PM.PM_Ticket_Features.RunAndSaveReport(txtReportName.Text, txtSubject.Text, userId, Col, False, hdnlistOfClientsIds.Value, hdnlistOfTypeIds.Value, hdnlistOfCategoryIds.Value, hdnlistOfSubCategoryIds.Value, hdnlistOfPriortyIds.Value, hdnlistOfStatusIds.Value, hdnlistOfTeamIds.Value, hdnlistOfRelaseseIds.Value, S, hdnlistOfAssignToIds.Value, hdnlistOfProductOwnerIds.Value, hdnlistOfProjectManagers.Value, hdnlistOfDesignLeadIds.Value, hdnlistOfDevLeadIds.Value, hdnlistOfQALeadIds.Value, txtCreationdays.Text, txtCreationDateFrom.Value, txtCreationDateto.Value, txtLatestDays.Text, txtLastestActivity.Value, txtLastestActivityTo.Value, txtSowSignDays.Text, txtSOWSignDate.Value, txtSOWSignDateTo.Value, txtDueDays.Text, txtDueDate.Value, txtDueDateTo.Value, dt)
            Session("dtCart") = result
            Response.Redirect("~/PM/MyReportDetail.aspx?ID= 0")
        End If

    End Sub

    Protected Sub btnYes_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/PM/MyPMReports.aspx")
    End Sub
    'Protected Sub rbtLstRating_SelectedIndexChanged(sender As Object, e As EventArgs)
    '    If (rbtLstRating.SelectedItem.Text = "Enable Text") Then

    '        txtCreationdays.Enabled = True
    '        txtCreationDateFrom.Enabled = False

    '    ElseIf (rbtLstRating.SelectedItem.Text = "Enable DDL") Then

    '        txtCreationdays.Enabled = False

    '        txtCreationDateFrom.Enabled = True


    '    Else

    '        txtCreationdays.Enabled = False
    '        txtCreationDateFrom.Enabled = False

    '    End If

    'End Sub
End Class
