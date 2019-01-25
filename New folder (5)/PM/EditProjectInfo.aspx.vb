
Imports System.Collections.Generic
Imports System.Data
Imports System.Web.Script.Serialization
Imports Portal.BLL
Imports Portal.BLL.PM

Partial Class PM_EditProjectInfo
    Inherits System.Web.UI.Page
    Dim colTicket_Features As New List(Of PM_Ticket_Features)()
    Dim addedNewEstimate As String = ""
    Public SuggestionList As String = ""
    Public SuggestionEstimateList As String = ""
    Dim GroupIds As DataTable
    Public dt As DataTable
    Public ListOfResourcesKeyValues As List(Of KeyValuePair(Of String, String))
    Public ListOfAddedResources As String
    Public ListOfTicketResources As Dictionary(Of String, String)
    Public ListOfTicketEstimate As Dictionary(Of String, String)
    public productOwner as String
    public designLead as String
    public QALead as String
    public DevelopmentLead as String
    public newRole as string
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        hdnID.Value = Request.QueryString("ID")
        hdnName.Value= Request.QueryString("AdminName")
        GroupIds = PM_Ticket_Features.PM_GetGroupID_ByUserID(CType(Session("AdminID"), Integer))

        'hdnCategoryID.Value = colTicket_Features.Item(0).CatagoryID
        FillddlPriority()
        'ddlPriority.SelectedValue = colTicket_Features.Item(0).Priority
        If Not Page.IsPostBack Then

            colTicket_Features = PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(hdnID.Value, Integer))
            ddlTicketTypes.Items.Insert(0, New ListItem("Select...", 0))
            ddlTicketTypes.DataBind()

            If colTicket_Features.Count > 0 Then
                txtName.Text = colTicket_Features.Item(0).Name
                txtNotes.InnerText = colTicket_Features.Item(0).Notes


                hdnOldSubject.Value = colTicket_Features.Item(0).Name
                editNotes.Value = colTicket_Features.Item(0).Notes
                If (ddlTicketTypes.Items.FindByValue(colTicket_Features.Item(0).TypeID) Is Nothing = False) Then
                    ddlTicketTypes.SelectedValue = colTicket_Features.Item(0).TypeID
                    hdnOldTypeId.Value = colTicket_Features.Item(0).TypeID
                End If



                hdnCategoryID.Value = colTicket_Features.Item(0).CatagoryID
                hdnOldCategoryId.Value = colTicket_Features.Item(0).CatagoryID
                'hdnSubCategoryID.Value = colTicket_Features.Item(0).SubCatagoryID
                hdnOldsubCategoryId.Value = colTicket_Features.Item(0).SubCatagoryID
                'txtSowSignedDate.Text = DateTime.Parse(Functions.IfNull(colTicket_Features.Item(0).SowSignedDate, System.DateTime.Now)).ToShortDateString()

                If Not IsNothing(colTicket_Features.Item(0).SowSignedDate) Then
                    txtSowSignedDate.Value = DateTime.Parse(colTicket_Features.Item(0).SowSignedDate).ToShortDateString()
                    hdnOldSowSignedDate.Value = DateTime.Parse(colTicket_Features.Item(0).SowSignedDate).ToShortDateString()
                End If
                If Not IsNothing(colTicket_Features.Item(0).CRBApprovalDate) Then
                    txtCRBApprovalDate.Value = DateTime.Parse(colTicket_Features.Item(0).CRBApprovalDate).ToShortDateString()
                    hdnOldCRBApprovalDate.Value = DateTime.Parse(colTicket_Features.Item(0).CRBApprovalDate).ToShortDateString()
                End If
                ddlPriority.SelectedValue = colTicket_Features.Item(0).Priority
                hdnOldPriorityId.Value = colTicket_Features.Item(0).Priority
                'ddlTicketStatus.SelectedValue = colTicket_Features.Item(0).Status
                'ddlTicketClients.SelectedValue = colTicket_Features.Item(0).ClientID
                hdnOldClientId.Value = colTicket_Features.Item(0).ClientID
                'ddlTicketClients.DataBind()

                hdnOldAreaDeveloperId.Value = colTicket_Features.Item(0).AreaDeveloperId
            End If
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'ScriptManager.RegisterStartupScript(
        '    UpdatePanel4,
        '    Me.GetType(),
        '    "MyAction",
        '    "doMyAction();",
        '    true)
        'Dim dtSuggestionList As DataTable = PM_Ticket_Features.PM_Roles_GetAll(Integer.Parse(hdnID.Value))
        If ViewState("SuggestionList") <> Nothing Then
            SuggestionList = CType(ViewState("SuggestionList"), String)
        End If

        If ViewState("SuggestionEstimateList") <> Nothing Then
            SuggestionEstimateList = CType(ViewState("SuggestionEstimateList"), String)
        End If

        'Dim dtSuggestionEstimateList As DataTable = PM_Ticket_Features.PM_EstimatesType_GetAll(Integer.Parse(hdnID.Value))
        'SuggestionEstimateList = DataTableToJSONWithJavaScriptSerializer(dtSuggestionEstimateList)
        'EstimatesGrid.DataSource = Portal.BLL.PM.PM_Ticket_Features.PM_MYTicket_Estimates_GetByTicketID(hdnID.Value)
        If Not IsPostBack Then
            If (ListOfResourcesKeyValues Is Nothing) Then
                ListOfResourcesKeyValues = New List(Of KeyValuePair(Of String, String))
                ViewState("ListOfResourcesKeyValues") = ListOfResourcesKeyValues
            End If

            Dim listpo As List(Of Portal.BLL.PM.PM_Ticket_Features)
            listpo = Portal.BLL.PM.PM_Ticket_Features.PM_Project_Information_GetByTicketID(Integer.Parse(hdnID.Value))
            'Dim dt As DataTable
            If listpo.Count > 0 Then
                dt = listpo(0).DtProjectResources
                ViewState("dt") = dt

                For Each row As DataRow  In dt.Rows
                    if row.Item("RoleID")=1
                        hdnListOfPM.Value=row.Item("ResourceNames")
                        hdnListOfOldPMIds.Value=row.Item("UserID")
                        hdnListOfPMIds.Value=row.Item("UserID")
                    ElseIf row.Item("RoleID")=2
                        hdnProductOwner.Value =row.Item("ResourceNames")
                        hdnOldProductOwnerID.Value=row.Item("UserID")
                        hdnProductOwnerID.Value=row.Item("UserID")
                    ElseIf row.Item("RoleID")=3
                        hdnDesignLead.Value =row.Item("ResourceNames")
                        hdnOldDesignLeadID.Value=row.Item("UserID")
                        hdnDesignLeadID.Value=row.Item("UserID")
                    ElseIf row.Item("RoleID")=4
                        hdnDevlopmentLead.Value =row.Item("ResourceNames")
                        hdnOldDevlopmentLeadID.Value=row.Item("UserID")
                        hdnDevlopmentLeadID.Value=row.Item("UserID")
                    ElseIf row.Item("RoleID")=5
                        hdnQALead.Value =row.Item("ResourceNames")
                        hdnOldQALeadID.Value=row.Item("UserID")
                        hdnQALeadID.Value=row.Item("UserID")
                    End If
                    
                Next

                ListOfTicketResources = New Dictionary(Of String, String)
                For Each row As DataRow In dt.Rows
                    ListOfTicketResources.Add(row.Item("Title"), IIf(IsDBNull(row.Item("ResourceNames")), Nothing, row.Item("ResourceNames")))
                Next
                Dim EstimateTable As DataTable = Portal.BLL.PM.PM_Ticket_Features.PM_MYTicket_Estimates_GetByTicketID(hdnID.Value)
                ListOfTicketEstimate = New Dictionary(Of String, String)
                For Each row As DataRow In EstimateTable.Rows
                    ListOfTicketEstimate.Add(row.Item("Title"), IIf(IsDBNull(row.Item("Estimates")), Nothing, row.Item("Estimates")))
                Next
                ViewState("preResources") = ListOfTicketResources
                ViewState("preEstimates") = ListOfTicketEstimate
            End If
            If Not String.IsNullOrEmpty(listpo(0).TotalEstimates) Then
                Dim Nbr As Double = listpo(0).TotalEstimates

                Label2.Text = Nbr.ToString("#,###") + " Hrs"
            End If

            ResourcesGrid.DataSource = dt
            ResourcesGrid.DataBind()
            'If ViewState("value") <> Nothing Then
            '    CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox).Text = ViewState("value").ToString()
            'End If
            'If ViewState("value1") <> Nothing Then
            '    CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox).Text = ViewState("value1").ToString()
            'End If

        End If

    End Sub

   


    Protected Sub ResourcesGrid_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        Dim usrCurrent As String
        Dim RoleID As Integer
        Dim usrId As String
        Dim lblName As Label
        Dim Dropdown As DropDownList
        Dim PMVal = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String)
        Dim PMfind As String = "GroupID = '" + PMVal + "'"
        Dim QAVal = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "QALead"), String)
        Dim QAfind As String = "GroupID = '" + QAVal + "'"
        Dim DevVal = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "DevLead"), String)
        Dim Devfind As String = "GroupID = '" + DevVal + "'"
        Dim DesignVal = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "DesignLead"), String)
        Dim Designfind As String = "GroupID = '" + DesignVal + "'"
        Dim POVal = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProductOwnerLead"), String)
        Dim POfind As String = "GroupID = '" + POVal + "'"
        Dim AdminVal = CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "Admin"), String)
        Dim Adminfind As String = "GroupID = '" + AdminVal + "'"
        Dim PMfoundRows As DataRow() = GroupIds.Select(PMfind)
        Dim QAfoundRows As DataRow() = GroupIds.Select(QAfind)
        Dim DevfoundRows As DataRow() = GroupIds.Select(Devfind)
        Dim DesignfoundRows As DataRow() = GroupIds.Select(Designfind)
        Dim POfoundRows As DataRow() = GroupIds.Select(POfind)
        Dim AdminfoundRows As DataRow() = GroupIds.Select(Adminfind)
        Dim List As List(Of KeyValuePair(Of String, String))
        Dim LablesValues As String
        Dim Lableskeys As String
        If ViewState("ListOfResourcesKeyValues") IsNot Nothing Then
            List = CType(ViewState("ListOfResourcesKeyValues"), List(Of KeyValuePair(Of String, String)))
        End If
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim s As String = DataBinder.Eval(e.Row.DataItem, "RoleID").ToString().Trim()
            If s IsNot Nothing AndAlso s.Length > 0 Then
                If s.Equals(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceIds), "ProjectManager"), String)) Then
                    'usrCurrent = DataBinder.Eval(e.Row.DataItem, "ResourceNames").ToString()
                    Dim Minus As ImageButton = CType(e.Row.FindControl("cross"), ImageButton)
                    Minus.Attributes.CssStyle.Add("display", "none")
                    usrCurrent = hdnListOfPM.Value
                    RoleID = DataBinder.Eval(e.Row.DataItem, "RoleID")
                    'usrId = DataBinder.Eval(e.Row.DataItem, "UserID").ToString()
                    usrId = hdnListOfPMIds.Value
                    Dim Cross As Boolean = False
                    Dropdown = CType(e.Row.FindControl("ddlTicketOwner"), DropDownList)
                    Dropdown.Attributes.Add("data", RoleID)
                    Dropdown.DataSource = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProjectManagerLead"), String))
                    Dropdown.DataBind()
                    Dropdown.Items.Insert(0, New ListItem("Add Owner", 0))
                    Dropdown.Enabled = False
                    If PMfoundRows.Length > 0 Or AdminfoundRows.Length > 0 Then
                        Dropdown.Enabled = True
                        Cross = True
                        If List IsNot Nothing Then
                            For Each pair As KeyValuePair(Of String, String) In List
                                If pair.Key = s Then
                                    Dim values = pair.Value.Split("|")
                                    If LablesValues Is Nothing Then
                                        LablesValues = values(0)
                                        Lableskeys = values(1)
                                    Else
                                        LablesValues = LablesValues & "," & values(0)
                                        Lableskeys = Lableskeys & "," & values(1)
                                    End If
                                End If
                            Next
                        End If

                    End If
                    Dim sa As String
                    If LablesValues IsNot Nothing AndAlso Lableskeys IsNot Nothing Then
                        If String.IsNullOrEmpty(usrCurrent) Then
                            usrCurrent = LablesValues
                            usrId = Lableskeys
                        Else
                            usrCurrent = usrCurrent & "," & LablesValues
                            usrId = usrId & "," & Lableskeys
                        End If
                    End If
                    sa = getArray(usrCurrent, usrId, RoleID, Cross)

                    lblName = CType(e.Row.FindControl("PO"), Label)
                    lblName.Text = sa

                    usrCurrent = Nothing
                    usrId = Nothing

                ElseIf s.Equals(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceIds), "ProductOwner"), String)) Then
                    usrCurrent = DataBinder.Eval(e.Row.DataItem, "ResourceNames").ToString()
                    RoleID = DataBinder.Eval(e.Row.DataItem, "RoleID")
                    usrId = DataBinder.Eval(e.Row.DataItem, "UserID").ToString()
                    Dim Cross As Boolean = False
                    Dim Minus As ImageButton = CType(e.Row.FindControl("cross"), ImageButton)
                    Minus.Attributes.CssStyle.Add("display", "none")
                    Dropdown = CType(e.Row.FindControl("ddlTicketOwner"), DropDownList)
                    Dropdown.Attributes.Add("data", RoleID)
                    Dropdown.DataSource = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "ProductOwnerLead"), String))
                    Dropdown.DataBind()
                    Dropdown.Items.Insert(0, New ListItem("Add Owner", 0))
                    Dropdown.Enabled = False
                    lblName = CType(e.Row.FindControl("PO"), Label)
                    If PMfoundRows.Length > 0 Or POfoundRows.Length > 0 Or AdminfoundRows.Length > 0 Then
                        Dropdown.Enabled = True
                        Cross = True
                        'If List IsNot Nothing Then
                        '    For Each pair As KeyValuePair(Of String, String) In List
                        '        If pair.Key = s Then
                        '            Dim values = pair.Value.Split("|")
                        '            If LablesValues Is Nothing Then
                        '                LablesValues = values(0)
                        '                Lableskeys = values(1)
                        '            Else
                        '                LablesValues = LablesValues & "," & values(0)
                        '                Lableskeys = Lableskeys & "," & values(1)
                        '            End If
                        '        End If
                        '    Next
                        'End If

                    End If
                    'Dim sa As String
                    'If LablesValues IsNot Nothing AndAlso Lableskeys IsNot Nothing Then
                    '    If String.IsNullOrEmpty(usrCurrent) Then
                    '        usrCurrent = LablesValues
                    '        usrId = Lableskeys
                    '    Else
                    '        usrCurrent = usrCurrent & "," & LablesValues
                    '        usrId = usrId & "," & Lableskeys
                    '    End If
                    'End If
                    'sa = getArray(usrCurrent, usrId, RoleID, Cross)
                    lblName = CType(e.Row.FindControl("PO"), Label)
                    If String.IsNullOrEmpty(hdnProductOwner.Value) Then
                        lblName.Text = "<br/>"
                    Else

                        lblName.Text = hdnProductOwner.Value + "<img  id =" + hdnProductOwnerID.Value + " data =" + s + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;' class='imgcross' onclick='RemoveRes(this)' /><br/>"

                    End If
                    usrCurrent = Nothing
                    usrId = Nothing
                ElseIf s.Equals(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceIds), "DesignLead"), String)) Then
                    usrCurrent = DataBinder.Eval(e.Row.DataItem, "ResourceNames").ToString()
                    RoleID = DataBinder.Eval(e.Row.DataItem, "RoleID")
                    usrId = DataBinder.Eval(e.Row.DataItem, "UserID").ToString()
                    Dim Cross As Boolean = False
                    Dim Minus As ImageButton = CType(e.Row.FindControl("cross"), ImageButton)
                    Minus.Attributes.CssStyle.Add("display", "none")
                    Dropdown = CType(e.Row.FindControl("ddlTicketOwner"), DropDownList)
                    Dropdown.Attributes.Add("data", RoleID)
                    Dropdown.DataSource = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "DesignLead"), String))
                    Dropdown.DataBind()
                    Dropdown.Items.Insert(0, New ListItem("Add Owner", 0))
                    Dropdown.Enabled = False
                    If PMfoundRows.Length > 0 Or DesignfoundRows.Length > 0 Or AdminfoundRows.Length > 0 Then
                        Dropdown.Enabled = True
                        Cross = True
                        'If List IsNot Nothing Then

                        '    For Each pair As KeyValuePair(Of String, String) In List
                        '        If pair.Key = s Then
                        '            Dim values = pair.Value.Split("|")
                        '            If LablesValues Is Nothing Then
                        '                LablesValues = values(0)
                        '                Lableskeys = values(1)
                        '            Else
                        '                LablesValues = LablesValues & "," & values(0)
                        '                Lableskeys = Lableskeys & "," & values(1)
                        '            End If
                        '        End If
                        '    Next
                        'End If
                    End If
                    'Dim sa As String
                    'If LablesValues IsNot Nothing AndAlso Lableskeys IsNot Nothing Then
                    '    If String.IsNullOrEmpty(usrCurrent) Then
                    '        usrCurrent = LablesValues
                    '        usrId = Lableskeys
                    '    Else
                    '        usrCurrent = usrCurrent & "," & LablesValues
                    '        usrId = usrId & "," & Lableskeys
                    '    End If
                    'End If
                    'sa = getArray(usrCurrent, usrId, RoleID, Cross)
                    lblName = CType(e.Row.FindControl("PO"), Label)
                    If String.IsNullOrEmpty(hdnDesignLead.Value) Then
                        lblName.Text = "<br/>"
                    Else
                        lblName.Text = hdnDesignLead.Value + "<img id =" + hdnDesignLeadID.Value + " data =" + s + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;' class='imgcross' onclick='RemoveRes(this)' /><br/>"
                    End If



                    usrCurrent = Nothing
                    usrId = Nothing
                ElseIf s.Equals(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceIds), "DevelopmentLead"), String)) Then
                    usrCurrent = DataBinder.Eval(e.Row.DataItem, "ResourceNames").ToString()
                    RoleID = DataBinder.Eval(e.Row.DataItem, "RoleID")
                    usrId = DataBinder.Eval(e.Row.DataItem, "UserID").ToString()
                    Dim Minus As ImageButton = CType(e.Row.FindControl("cross"), ImageButton)
                    Minus.Attributes.CssStyle.Add("display", "none")
                    Dim Cross As Boolean = False
                    Dropdown = CType(e.Row.FindControl("ddlTicketOwner"), DropDownList)
                    Dropdown.Attributes.Add("data", RoleID)
                    Dropdown.DataSource = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "DevLead"), String))
                    Dropdown.DataBind()
                    Dropdown.Items.Insert(0, New ListItem("Add Owner", 0))
                    Dropdown.Enabled = False
                    If PMfoundRows.Length > 0 Or DevfoundRows.Length > 0 Or AdminfoundRows.Length > 0 Then
                        Dropdown.Enabled = True
                        Cross = True
                        'If List IsNot Nothing Then
                        '    For Each pair As KeyValuePair(Of String, String) In List
                        '        If pair.Key = s Then
                        '            Dim values = pair.Value.Split("|")
                        '            If LablesValues Is Nothing Then
                        '                LablesValues = values(0)
                        '                Lableskeys = values(1)
                        '            Else
                        '                LablesValues = LablesValues & "," & values(0)
                        '                Lableskeys = Lableskeys & "," & values(1)
                        '            End If
                        '        End If
                        '    Next
                        'End If
                    End If
                    'Dim sa As String
                    'Dim saa As String
                    'If LablesValues IsNot Nothing AndAlso Lableskeys IsNot Nothing Then
                    '    If String.IsNullOrEmpty(usrCurrent) Then
                    '        usrCurrent = LablesValues
                    '        usrId = Lableskeys
                    '    Else
                    '        usrCurrent = usrCurrent & "," & LablesValues
                    '        usrId = usrId & "," & Lableskeys
                    '    End If
                    'End If
                    'sa = getArray(usrCurrent, usrId, RoleID, Cross)
                    lblName = CType(e.Row.FindControl("PO"), Label)
                    If String.IsNullOrEmpty(hdnDevlopmentLead.Value) Then
                        lblName.Text = "<br/>"
                    Else
                        lblName.Text = hdnDevlopmentLead.Value + "<img id =" + hdnDevlopmentLeadID.Value + " data =" + s + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;' class='imgcross' onclick='RemoveRes(this)' /><br/>"
                    End If



                    usrCurrent = Nothing
                    usrId = Nothing
                ElseIf s.Equals(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceIds), "QALead"), String)) Then
                    usrCurrent = DataBinder.Eval(e.Row.DataItem, "ResourceNames").ToString()
                    RoleID = DataBinder.Eval(e.Row.DataItem, "RoleID")
                    usrId = DataBinder.Eval(e.Row.DataItem, "UserID").ToString()
                    Dim Cross As Boolean = False
                    Dim Minus As ImageButton = CType(e.Row.FindControl("cross"), ImageButton)
                    Minus.Attributes.CssStyle.Add("display", "none")
                    Dropdown = CType(e.Row.FindControl("ddlTicketOwner"), DropDownList)
                    Dropdown.Attributes.Add("data", RoleID)
                    Dropdown.DataSource = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetByGroupId(CType([Enum].Parse(GetType(Portal.BLL.Enumeration.ResourceType), "QALead"), String))
                    Dropdown.DataBind()
                    Dropdown.Items.Insert(0, New ListItem("Add Owner", 0))
                    Dropdown.Enabled = False
                    If PMfoundRows.Length > 0 Or QAfoundRows.Length > 0 Or AdminfoundRows.Length > 0 Then
                        Dropdown.Enabled = True
                        Cross = True
                        'If List IsNot Nothing Then


                        '    For Each pair As KeyValuePair(Of String, String) In List
                        '        If pair.Key = s Then
                        '            Dim values = pair.Value.Split("|")
                        '            If LablesValues Is Nothing Then
                        '                LablesValues = values(0)
                        '                Lableskeys = values(1)
                        '            Else
                        '                LablesValues = LablesValues & "," & values(0)
                        '                Lableskeys = Lableskeys & "," & values(1)
                        '            End If
                        '        End If
                        '    Next
                        'End If
                    End If
                    'Dim sa As String
                    'If LablesValues IsNot Nothing AndAlso Lableskeys IsNot Nothing Then
                    '    If String.IsNullOrEmpty(usrCurrent) Then
                    '        usrCurrent = LablesValues
                    '        usrId = Lableskeys
                    '    Else
                    '        usrCurrent = usrCurrent & "," & LablesValues
                    '        usrId = usrId & "," & Lableskeys
                    '    End If

                    'End If

                    'sa = getArray(usrCurrent, usrId, RoleID, Cross)
                    lblName = CType(e.Row.FindControl("PO"), Label)
                    If Not String.IsNullOrEmpty(hdnQALead.Value) Then
                        lblName.Text = hdnQALead.Value + "<img id =" + hdnQALeadID.Value + " data =" + s + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;' class='imgcross' onclick='RemoveRes(this)' /><br/>"
                    Else

                        lblName.Text = "<br/>"
                    End If

                    usrCurrent = Nothing
                    usrId = Nothing
                Else
                    usrCurrent = DataBinder.Eval(e.Row.DataItem, "ResourceNames").ToString()
                    RoleID = DataBinder.Eval(e.Row.DataItem, "RoleID")
                    usrId = DataBinder.Eval(e.Row.DataItem, "UserID").ToString()
                    Dim Cross As Boolean = False
                    Dropdown = CType(e.Row.FindControl("ddlTicketOwner"), DropDownList)
                    Dropdown.Attributes.Add("data", RoleID)
                    Dropdown.DataSource = Portal.BLL.PM.PM_Ticket_Features.PM_Users_GetAll()
                    Dropdown.DataBind()
                    Dropdown.Items.Insert(0, New ListItem("Add Owner", 0))
                    Dropdown.Enabled = False
                    If PMfoundRows.Length > 0 Or AdminfoundRows.Length > 0 Then
                        Dropdown.Enabled = True
                        Cross = True
                        If List IsNot Nothing Then
                            For Each pair As KeyValuePair(Of String, String) In List
                                If pair.Key = s Then
                                    If LablesValues Is Nothing Then
                                        LablesValues = pair.Value
                                        Lableskeys = pair.Key
                                    Else
                                        LablesValues = LablesValues & "," & pair.Value
                                        Lableskeys = Lableskeys & "," & pair.Key
                                    End If
                                End If
                            Next
                        End If

                    End If
                    Dim sa As String
                    If LablesValues IsNot Nothing AndAlso Lableskeys IsNot Nothing Then
                        If String.IsNullOrEmpty(usrCurrent) Then
                            usrCurrent = LablesValues
                            usrId = Lableskeys
                        Else
                            usrCurrent = usrCurrent & "," & LablesValues
                            usrId = usrId & "," & Lableskeys
                        End If
                    End If
                    sa = getArray(usrCurrent, usrId, RoleID, Cross)
                    lblName = CType(e.Row.FindControl("PO"), Label)
                    lblName.Text = sa
                    'If String.IsNullOrEmpty(usrCurrent)
                    '    lblName.Text=hdnResource.Value +"<img id =" + usrId.ToString() + " data =" + RoleID + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;' class='imgcross' onclick='RemoveOwner(this)' />"
                    '    Else 
                    '        lblName.Text =usrCurrent +"<img id =" + hdnOldQALeadID.Value +" data =" + s +  " src='../images/icn_cross.png' style='padding-left:8px;width:13px;' class='imgcross' onclick='RemoveOwner(this)' /><br/>"
                    'End If


                    usrCurrent = Nothing
                    usrId = Nothing
                End If
            End If
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.CssClass = "footer"
            e.Row.Cells(0).ColumnSpan = 2
        End If

    End Sub

    Protected Function getArray(NamesArray As String, UsrId As String, owner As Integer) As String
        Dim names As String = ""
        Dim array As String()
        Dim uId As String()
        array = NamesArray.Split(",".ToCharArray())
        uId = UsrId.Split(",".ToCharArray())
        'For Each Name As String In array
        For value As Integer = 0 To array.Length - 1
            names += "<span id= span" + uId(value) + " >" + array(value) + "<img id =" + uId(value) + " data =" + owner.ToString() + " src='../images/icn_cross.png' class='imgcross' onclick='RemoveOwner(this)' /></span> <br>"
        Next
        'names += "<span >" + Name + "<img src='../images/icn_cross.png' class='imgcross' /></span> <br>"
        'Next
        Return names
    End Function
    Protected Function getArray(NamesArray As String, UsrId As String, owner As Integer, cross As Boolean) As String
        Dim names As String = ""
        Dim array As String()
        Dim uId As String()
        Dim index As Integer
        'index = listOfDeletedItem.Value
        array = NamesArray.Split(",".ToCharArray())
        uId = UsrId.Split(",".ToCharArray())
        'If Not String.IsNullOrEmpty(listOfDeletedItem.Value) Then
        '    Dim val() As String = listOfDeletedItem.Value.Split(",")
        '    If val.Length > 0 Then
        '        For i As Integer = 0 To val.Length - 1
        '            For j As Integer = 0 To uId.Length - 1
        '                If uId(j).Equals(val(i)) Then
        '                    array = RemoveAt(array, j)
        '                End If
        '            Next
        '        Next
        '    End If
        'End If
        'If Not String.IsNullOrEmpty(val) Then

        '    For i As Integer = 0 To uId.Length - 1
        '        If uId(i).Equals(val) Then
        '            index = i
        '            Exit For
        '        End If
        '    Next

        'End If
        'array = RemoveAt(array, Index)
        'For Each Name As String In array
        If array IsNot Nothing

        If cross = True And NamesArray <> Nothing Then
            For value As Integer = 0 To array.Length-1
                    names += "<span style='font-size:13px;' id= span" + uId(value) + " >" + array(value) + "<img id =" + uId(value) + " data =" + owner.ToString() + " src='../images/icn_cross.png' style='padding-left:8px;width:13px;' class='imgcross' onclick='RemoveOwner(this)' /></span> <br/>"
                    'names+=array(value)
                Next
        Else
            For value As Integer = 0 To array.Length - 1
                names += "<span style='font-size:13px;' id= span" + uId(value) + " >" + array(value) + "</span> <br>"
            Next
        End If
        End If
        'names += "<span >" + Name + "<img src='../images/icn_cross.png' class='imgcross' /></span> <br>"
        'Next
        Return names
    End Function
    Function RemoveAt(Of T)(ByVal arr As T(), ByVal index As Integer) As T()
        If arr IsNot Nothing

     
        Dim uBound = arr.GetUpperBound(0)
        Dim lBound = arr.GetLowerBound(0)
        Dim arrLen = uBound - lBound

        If index < lBound OrElse index > uBound Then
            'Throw New ArgumentOutOfRangeException(String.Format("Index must be from {0} to {1}.", lBound, uBound))

        Else
            'create an array 1 element less than the input array
            Dim outArr(arrLen - 1) As T
            'copy the first part of the input array
            Array.Copy(arr, 0, outArr, 0, index)
            'then copy the second part of the input array
            Array.Copy(arr, index + 1, outArr, index, uBound - index)

            Return outArr
        End If
        End If
    End Function
    Protected Function getStringForLables(text As String, id As String) As String
        Dim names As String = ""
        names += "<span style='font-size:8pt;' id= span" + id + " >" + text + "<img id =" + id + " data =" + id + " src='../images/icn_cross.png' class='imgcross' onclick='RemoveOwner(this)' /></span> <br>"
        Return names
    End Function
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
    Protected Function Get_Estimates() As String
        Dim estimate As String = Nothing
        'Dim txtEstimateName As String = CType(EstimatesGrid.FooterRow.FindControl("hdnEstimates"), HiddenField).Value
        ' Dim txtEstimateValue As String = CType(EstimatesGrid.FooterRow.FindControl("Estimate"), TextBox).Text
        ' Dim S As String = CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox).Text
        For Each row As GridViewRow In EstimatesGrid.Rows
            Dim Estimates As String = CType(row.FindControl("txtName"), TextBox).Text
            Dim EstimatesTypeID As String = CType(row.FindControl("txtlbl"), Label).Text
            Dim LableEstimate As String = CType(row.FindControl("lblEstimateName"), Label).Text
            ' If EstimatesTypeID.Equals(txtEstimateName) Then
            'Estimates = txtEstimateValue
            'txtEstimateValue = Nothing
            ' End If
            '
            If Estimates <> Nothing AndAlso EstimatesTypeID <> Nothing Then
                If estimate <> Nothing Then
                    estimate = estimate + "|" + EstimatesTypeID + "," + Estimates
                Else
                    estimate = EstimatesTypeID + "," + Estimates

                End If
            End If
        Next
        ' If txtEstimateValue <> Nothing Then
        'addedNewEstimate = S + "|" + txtEstimateValue
        ' End If
        Return estimate

    End Function
    Public Function GetNewAddedEstimate() As String
        Dim S As String = CType(EstimatesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox).Text
        Dim S1 As String = CType(EstimatesGrid.FooterRow.FindControl("Estimate"), TextBox).Text
        Return S + S1
    End Function
    Protected Sub btnUpdateTicketDetail_Click(sender As Object, e As EventArgs) Handles btnUpdateTicketDetail.Click
        Dim newResourceName As String
        Dim ListOfPMS as String
        ListOfPMS =GetUniquePMIds()
        Dim S As TextBox = CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox)
        If Not String.IsNullOrEmpty(S.Text.ToString()) Then
            newResourceName = S.Text.ToString()
        End If
        If String.IsNullOrEmpty(newResourceName) Then
            AddedResource.Value = Nothing
        Else
            AddedResource.Value = newResourceName & "|" & AddedResource.Value
        End If
        Dim ResourcesAdded As String

        If (ViewState("Resources") IsNot Nothing) Then
            ResourcesAdded = CType(ViewState("Resources"), String)
        End If
        Dim DelItem as String=hdnListOfProjectManager.value
        If not String.IsNullOrEmpty(DelItem) And Not ResourcesAdded Is Nothing
            ResourcesAdded=GetUniqueProjectManager(ResourcesAdded,DelItem)
        End If
        Dim estimates As String = Get_Estimates()
        If Not String.IsNullOrEmpty(hdnProductOwner.Value) And Not hdnOldProductOwnerID.Value.Equals(hdnProductOwnerID.value)
            Dim owner="2"+ "," + hdnProductOwnerID.Value
            If String.IsNullOrEmpty(ResourcesAdded)
                ResourcesAdded=owner
            Else 
                ResourcesAdded = ResourcesAdded + "|" + owner
            End If
        End If
         If Not String.IsNullOrEmpty(hdnDesignLead.Value) And Not hdnOldDesignLeadID.Value.Equals(hdnDesignLeadID.Value)
            Dim owner="3"+ "," + hdnDesignLeadID.Value
            If String.IsNullOrEmpty(ResourcesAdded)
               ResourcesAdded=owner
            Else 
               ResourcesAdded = ResourcesAdded + "|" + owner
            End If
        End If
        If Not String.IsNullOrEmpty(hdnDevlopmentLead.Value) And Not hdnOldDevlopmentLeadID.Value.Equals(hdnDevlopmentLeadID.value)
            Dim owner="4"+ "," + hdnDevlopmentLeadID.Value
             If String.IsNullOrEmpty(ResourcesAdded)
               ResourcesAdded=owner
            Else 
               ResourcesAdded = ResourcesAdded + "|" + owner
            End If
        End If
        If Not String.IsNullOrEmpty(hdnQALead.Value) And Not hdnOldQALeadID.Value.Equals(hdnQALeadID.value)
            Dim owner="5" + "," + hdnQALeadID.Value
            If String.IsNullOrEmpty(ResourcesAdded)
               ResourcesAdded=owner
            Else 
               ResourcesAdded = ResourcesAdded + "|" + owner
            End If
        End If
        If Not String.IsNullOrEmpty(ListOfPMS)
            If String.IsNullOrEmpty(ResourcesAdded)
                ResourcesAdded=ListOfPMS
            Else 
                ResourcesAdded = ResourcesAdded + "|" + ListOfPMS
            End If
        End If
        Dim objFeturesBLL As New Portal.BLL.PM.PM_Ticket_Features
        'Dim ListOfResources As String
        'Dim DeleteItem = listOfDeletedItem.Value.Split(",")
        'Dim AddItem = listOfAddedItem.Value.Split("|")
        'For Each item As String In DeleteItem
        '    If String.IsNullOrEmpty(AddItem) Then
        '        For Each Resource As String In AddItem
        '            Dim Res = Resource.Split(",")
        '            If item.Equals(Res(1)) Then

        '            Else
        '                If String.IsNullOrEmpty(ListOfResources) Then
        '                    ListOfResources = Resource
        '                Else
        '                    ListOfResources = ListOfResources & "," & Resource
        '                End If
        '            End If
        '        Next
        '    End If
        'Next

        Dim cid As String = Session("AdminID")
        With objFeturesBLL
            .ID = Me.hdnID.Value
            .Name = Me.txtName.Text.Trim()
            '.ReleaseID = Me.ddlReleases.SelectedValue
            '.DateEntered = System.DateTime.Now.Date
            '.Description = Me.txtDescription.Text
            .TypeID = Me.ddlTicketTypes.SelectedValue
            .UserID = Session("AdminID")
            '.Read = False
            '.Status = 0
            '.Deleted = False
            '.History = False
            If Me.txtSowSignedDate.Value = "" Then
                .SowSignedDate = Nothing
            Else
                .SowSignedDate = DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString()
            End If
            '.SowSignedDate = IIf(Me.txtSowSignedDate.Value = "", DateTime.Now, DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString())
            .Priority = Me.ddlPriority.SelectedValue
            .CatagoryID = Me.ddlTicketCategories.SelectedValue
            .SubCatagoryID = Me.ddlSubCategories.SelectedValue
            '.WaitingForUserID = 0
            .ClientID = Me.ddlTicketClients.SelectedValue
            .AreaDeveloperId = 0
            .TicketOwner = 0
            .Resources = ResourcesAdded
            .ResourcesDeleted = Me.listOfDeletedItem.Value
            .Estimates = estimates
            .Notes = txtNotes.Value
            If Me.txtCRBApprovalDate.Value = "" Then
                .CRBApprovalDate = Nothing
            Else
                .CRBApprovalDate = DateTime.Parse(Me.txtCRBApprovalDate.Value).ToShortDateString()
            End If
            Dim Affected As Integer = Portal.BLL.PM.PM_Ticket_Features.PMTicketUpdate(.ID, .Name, .TypeID, .UserID, .SowSignedDate, .Priority, .CatagoryID, .SubCatagoryID, .ClientID, .AreaDeveloperId, .Resources, .ResourcesDeleted, .Estimates, .CRBApprovalDate, .Notes, AddedResource.Value, addedNewEstimate, .TicketOwner)
            Dim preProjectManager As String = Nothing
            Dim newProjectManager As String = Nothing
            Dim preProductOwner As String = Nothing
            Dim newProductOwner As String = Nothing
            Dim preDevelopment As String = Nothing
            Dim newDevelopment As String = Nothing
            Dim preQALead As String = Nothing
            Dim newQALead As String = Nothing
            Dim preDesignLead As String = Nothing
            Dim newDesignLead As String = Nothing

            Dim preAnalysisSOW As String = Nothing
            Dim newAnalysisSOW As String = Nothing
            Dim preDesign As String = Nothing
            Dim newDesign As String = Nothing
            Dim preDev As String = Nothing
            Dim newDev As String = Nothing
            Dim preQA As String = Nothing
            Dim newQA As String = Nothing
            Dim preDeployment As String = Nothing
            Dim newDeployment As String = Nothing
            Dim preProjectOversight As String = Nothing
            Dim newProjectOversight As String = Nothing
            preProjectManager = ManageResources("Project Manager                                                                                     ")
            preProductOwner = ManageResources("Product Owner                                                                                       ")
            preDesignLead = ManageResources("Design Lead                                                                                         ")
            preDevelopment = ManageResources("Development Lead                                                                                    ")
            preQALead = ManageResources("QA Lead                                                                                             ")
            newProjectManager = ManageNewResources("Project Manager                                                                                     ")
            newProductOwner = ManageNewResources("Product Owner                                                                                       ")
            newDesignLead = ManageNewResources("Design Lead                                                                                         ")
            newDevelopment = ManageNewResources("Development Lead                                                                                    ")
            newQALead = ManageNewResources("QA Lead                                                                                             ")

            preAnalysisSOW = ManageEstimate("Analysis/SOW                                                                                        ")
            newAnalysisSOW = ManageNewEstimate("Analysis/SOW                                                                                        ")
            preDesign = ManageEstimate("Design                                                                                              ")
            newDesign = ManageNewEstimate("Design                                                                                              ")
            preDev = ManageEstimate("Development                                                                                         ")
            newDev = ManageNewEstimate("Development                                                                                         ")
            preQA = ManageEstimate("QA                                                                                                  ")
            newQA = ManageNewEstimate("QA                                                                                                  ")
            preDeployment = ManageEstimate("Deployment                                                                                          ")
            newDeployment = ManageNewEstimate("Deployment                                                                                          ")
            preProjectOversight = ManageEstimate("Project Oversight                                                                                   ")
            newProjectOversight = ManageNewEstimate("Project Oversight                                                                                   ")

            Dim IsTicketDetailChanged As Boolean = False
            Dim strBodyTicketDetailChange As String = " === Ticket updated. ===<br />" + vbCrLf + vbCrLf
            If Not String.IsNullOrEmpty(preAnalysisSOW) Then

            End If

            If Not newAnalysisSOW.Equals(preAnalysisSOW) Then
                strBodyTicketDetailChange += "Analysis/SOW Estimates changed from : " + """" + preAnalysisSOW + """" + " to " + """" + newAnalysisSOW + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newDesign.Equals(preDesign) Then
                strBodyTicketDetailChange += "Design Estimates changed from : " + """" + preDesign + """" + " to " + """" + newDesign + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newDev.Equals(preDev) Then
                strBodyTicketDetailChange += "Development Estimates changed from : " + """" + preDev + """" + " to " + """" + newDev + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newQA.Equals(preQA) Then
                strBodyTicketDetailChange += "QA Estimates changed from : " + """" + preQA + """" + " to " + """" + newQA + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newDeployment.Equals(preDeployment) Then
                strBodyTicketDetailChange += "Deployment Estimates changed from : " + """" + preDeployment + """" + " to " + """" + newDeployment + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newProjectOversight.Equals(preProjectOversight) Then
                strBodyTicketDetailChange += "Project Oversight Estimates changed from : " + """" + preProjectOversight + """" + " to " + """" + newProjectOversight + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If

            If Not newProjectManager.Equals(preProjectManager) Then
                strBodyTicketDetailChange += "Project Manager changed from : " + """" + preProjectManager + """" + " to " + """" + newProjectManager + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newProductOwner.Equals(preProductOwner) Then
                strBodyTicketDetailChange += "Product Owner changed from : " + """" + preProductOwner + """" + " to " + """" + newProductOwner + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newDesignLead.Equals(preDesignLead) Then
                strBodyTicketDetailChange += "Design Lead changed from : " + """" + preDesignLead + """" + " to " + """" + newDesignLead + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If Not newDevelopment.Equals(preDevelopment) Then
                strBodyTicketDetailChange += "Development Lead changed from : " + """" + preDevelopment + """" + " to " + """" + newDevelopment + """" + "<br/>" + vbCrLf
            End If
            If Not newQALead.Equals(preQALead) Then
                strBodyTicketDetailChange += "QA Lead changed from : " + """" + preQALead + """" + " to " + """" + newQALead + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If

            If hdnOldSubject.Value <> Me.txtName.Text.Trim() Then
                strBodyTicketDetailChange += " Subject changed from : " + """" + hdnOldSubject.Value + """" + " to " + """" + Me.txtName.Text.Trim() + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If hdnOldTypeId.Value <> Me.ddlTicketTypes.SelectedValue Then
                strBodyTicketDetailChange += " Type changed from : " + """" + ddlTicketTypes.Items.FindByValue(hdnOldTypeId.Value).Text + """" + " to " + """" + ddlTicketTypes.SelectedItem.Text + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            '  If ddlTicketClients.SelectedValue <> Enumeration.ClientID.EA Then
            If Me.txtSowSignedDate.Value = "" Then
                If hdnOldSowSignedDate.Value <> Me.txtSowSignedDate.Value Then
                    strBodyTicketDetailChange += " SOW Approval Date changed from : " + """" + IIf(hdnOldSowSignedDate.Value = "", " ", hdnOldSowSignedDate.Value) + """" + " to " + """" + " " + """" + "<br/>" + vbCrLf
                    IsTicketDetailChanged = True
                End If
            Else
                If hdnOldSowSignedDate.Value <> DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString() Then
                    strBodyTicketDetailChange += " SOW Approval Date changed from : " + """" + IIf(hdnOldSowSignedDate.Value = "", " ", hdnOldSowSignedDate.Value) + """" + " to " + """" + DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString() + """" + "<br/>" + vbCrLf
                    IsTicketDetailChanged = True
                End If
            End If
            If Me.txtCRBApprovalDate.Value = "" Then
                If hdnOldCRBApprovalDate.Value <> Me.txtCRBApprovalDate.Value Then
                    strBodyTicketDetailChange += "CRB Approval Date changed from : " + """" + IIf(hdnOldCRBApprovalDate.Value = "", " ", hdnOldCRBApprovalDate.Value) + """" + " to " + """" + " " + """" + "<br/>" + vbCrLf
                    IsTicketDetailChanged = True
                End If
            Else
                If hdnOldCRBApprovalDate.Value <> DateTime.Parse(Me.txtCRBApprovalDate.Value).ToShortDateString() Then
                    strBodyTicketDetailChange += "CRB Approval Date changed from : " + """" + IIf(hdnOldCRBApprovalDate.Value = "", " ", hdnOldCRBApprovalDate.Value) + """" + " to " + """" + DateTime.Parse(Me.txtCRBApprovalDate.Value).ToShortDateString() + """" + "<br/>" + vbCrLf
                    IsTicketDetailChanged = True
                End If
            End If
            ' End If

            If hdnOldPriorityId.Value <> Me.ddlPriority.SelectedValue Then
                strBodyTicketDetailChange += " Priority changed from : " + """" + ddlPriority.Items.FindByValue(hdnOldPriorityId.Value).Text + """" + " to " + """" + ddlPriority.SelectedItem.Text + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If
            If hdnOldClientId.Value <> Me.ddlTicketClients.SelectedValue Then
                strBodyTicketDetailChange += " Client changed from : " + """" + ddlTicketClients.Items.FindByValue(hdnOldClientId.Value).Text + """" + " to " + """" + ddlTicketClients.SelectedItem.Text + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If

            If hdnOldCategoryId.Value <> Me.ddlTicketCategories.SelectedValue Then
                strBodyTicketDetailChange += " Category changed from : " + """" + hdnOldCategoryValue.Value + """" + " to " + """" + ddlTicketCategories.SelectedItem.Text + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If

            If hdnOldsubCategoryId.Value <> Me.ddlSubCategories.SelectedValue Then
                strBodyTicketDetailChange += "Sub Category changed from : " + """" + hdnOldSubCategoryValue.Value + """" + " to " + """" + ddlSubCategories.SelectedItem.Text + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If

            If editNotes.Value <> Me.txtNotes.Value Then
                
                strBodyTicketDetailChange += " Notes changed from : " + """" + editNotes.Value.Trim() + """" + " to " + """" + txtNotes.Value.Trim() + """" + "<br/>" + vbCrLf
                IsTicketDetailChanged = True
            End If


            If IsTicketDetailChanged Then

                ' Add Note 
                Dim intNewNotesID As Integer = 0
                Dim ObjNotes As PM_Notes
                Dim IsPublic As Boolean = False
                ObjNotes = New PM_Notes()
                With ObjNotes
                    '.Ticket_Feature_ID = CInt(hdnID.Value)
                    '.Notes = strBodyTicketDetailChange
                    '.SubmittedBy = CType(Session("AdminID"), Integer)
                    '.DateEntered = DateTime.Now
                    '.IsByAdmin = 1
                    '.TimeSpent = "00:00:00"
                    '.Type = Enumeration.TicketsNotesType.PrivateNote
                    'intNewNotesID = .Notes_Add()
                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = strBodyTicketDetailChange
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = "0:0"
                    .Type = Enumeration.TicketsNotesType.PrivateNote
                    IsPublic = True
                    intNewNotesID = .Notes_Add()
                    'SendEmailToUsersOnEdit(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))

                End With

                'Response.Redirect("~/PM/MyTickets.aspx")


            End If

        End With
        Response.Redirect("~/PM/TicketsDetail.aspx?ID=" & hdnID.Value & "&NewTicket=True")
    End Sub
    Protected Sub ddlTicketCategories_DataBound(sender As Object, e As EventArgs) Handles ddlTicketCategories.DataBound
        If (ddlTicketCategories.Items.FindByValue(Me.hdnCategoryID.Value) Is Nothing = False) Then
            ddlTicketCategories.SelectedValue = Me.hdnCategoryID.Value
            ddlTicketCategories.Items.Insert(0, New ListItem("Select...", 0))
            hdnOldCategoryValue.Value = ddlTicketCategories.SelectedItem.Text
        End If
    End Sub

    Protected Sub ddlTicketClients_DataBound(sender As Object, e As EventArgs) Handles ddlTicketClients.DataBound
        If Not Page.IsPostBack Then
            If (ddlTicketClients.Items.FindByValue(hdnOldClientId.Value) Is Nothing = False) Then
                ddlTicketClients.SelectedValue = colTicket_Features.Item(0).ClientID
                ddlTicketClients.Items.Insert(0, New ListItem("Select...", 0))
            Else
                Response.Redirect("~/AccessDenied.aspx", True)
            End If

        End If

    End Sub
    Protected Sub ddlTicketTypes_DataBound(sender As Object, e As EventArgs) Handles ddlTicketTypes.DataBound
        If Not Page.IsPostBack Then

            ddlTicketTypes.Items.Insert(0, New ListItem("Select...", 0))


        End If

    End Sub
    Protected Sub ddlSubCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSubCategories.DataBound
        ' If Not Page.IsPostBack Then
        If ddlSubCategories.Items.FindByValue("0") Is Nothing Then
            ddlSubCategories.Items.Insert(0, New ListItem("Select...", 0))
        End If

        'If hdnSubCategoryID.Value <> 0 Then
        '    If (ddlSubCategories.Items.FindByValue(Me.hdnSubCategoryID.Value) Is Nothing = False) Then
        '        ddlSubCategories.SelectedValue = Me.hdnSubCategoryID.Value
        '        hdnOldSubCategoryValue.Value = ddlSubCategories.SelectedItem.Text
        '    End If
        'Else
        '    ddlSubCategories.SelectedIndex = Me.hdnSubCategoryID.Value
        'End If
        'End If
    End Sub

    'Protected Sub addfield1_Click(sender As Object, e As EventArgs) Handles addfield1.Click

    '    'Dim s As String = CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox).Text
    '    'ViewState("value1") = s


    '    'For Each row As DataRow In dt.Rows
    '    '    Dim title As String = row.Item("Title").ToString().Trim()
    '    '    If String.IsNullOrEmpty(SuggestionEstimateList) Then
    '    '        SuggestionEstimateList += """" + title + """"
    '    '    Else
    '    '        SuggestionEstimateList += ", """ + title + """"
    '    '    End If
    '    'Next
    '    Dim listOfKeyValue = New Dictionary(Of String, String)
    '    For Each row As GridViewRow In EstimatesGrid.Rows
    '        Dim Key = CType(row.FindControl("lblEstimateName"), Label).Text
    '        Dim val = CType(row.FindControl("txtName"), TextBox).Text
    '        listOfKeyValue.Add(Key, val)
    '    Next
    '    ViewState("listOfKeyValue") = listOfKeyValue
    '    Dim dtSuggestionEstimateList As DataTable = PM_Ticket_Features.PM_EstimatesType_GetAll(Integer.Parse(hdnID.Value))


    '    SuggestionEstimateList = DataTableToJSONWithJavaScriptSerializer(dtSuggestionEstimateList)
    '    ViewState("SuggestionEstimateList") = SuggestionEstimateList
    '    EstimatesGrid.ShowFooter = True

    '    If ViewState("dt") IsNot Nothing Then
    '        dt = CType(ViewState("dt"), DataTable)
    '        ResourcesGrid.DataSource = dt
    '    End If

    '    EstimatesGrid.DataBind()
    '    Dim S As TextBox = CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox)
    '    S.Focus()
    'End Sub
    'Protected Sub addResources_Click(sender As Object, e As EventArgs) Handles addResources.Click
    '    'ViewState("value") = CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox).Text
    '    'For Each row As DataRow In dt.Rows
    '    '    Dim title As String = row.Item("Title").ToString().Trim()
    '    '    If String.IsNullOrEmpty(SuggestionList) Then
    '    '        SuggestionList += """" + title + """"
    '    '    Else
    '    '        SuggestionList += ", """ + title + """"
    '    '    End If
    '    'Next
    '    Dim dtSuggestionList As DataTable = PM_Ticket_Features.PM_Roles_GetAll(Integer.Parse(hdnID.Value))
    '    SuggestionList = DataTableToJSONWithJavaScriptSerializer(dtSuggestionList)
    '    ViewState("SuggestionList") = SuggestionList
    '    ResourcesGrid.ShowFooter = True
    '    If ViewState("dt") IsNot Nothing Then
    '        dt = CType(ViewState("dt"), DataTable)
    '        ResourcesGrid.DataSource = dt
    '    End If
    '    ResourcesGrid.DataBind()
    '    Dim S As TextBox = CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox)
    '    S.Focus()

    'End Sub
    Public Function DataTableToJSONWithJavaScriptSerializer(table As DataTable) As String

        Dim JSONString = New StringBuilder()
        If table.Rows.Count > 0 Then
            'JSONString.Append("[")
            For i As Integer = 0 To table.Rows.Count - 1
                JSONString.Append("{")
                For j As Integer = 0 To table.Columns.Count - 1
                    If j < table.Columns.Count - 1 Then
                        If table.Columns(j).ColumnName.ToString() = "ID" Then
                            JSONString.Append("value:" + "" + table.Rows(i)(j).ToString().Trim() + ",")
                        Else
                            JSONString.Append("label:" + """" + table.Rows(i)(j).ToString().Trim() + """,")
                        End If

                    ElseIf j = table.Columns.Count - 1 Then
                        JSONString.Append("label:" + """" + table.Rows(i)(j).ToString().Trim() + """")
                    End If
                Next
                If i = table.Rows.Count - 1 Then
                    JSONString.Append("}")
                Else
                    JSONString.Append("},")
                End If
            Next

        End If
        Return JSONString.ToString()
    End Function
    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        Response.Redirect("~/PM/TicketsDetail.aspx?ID=" & hdnID.Value & "&NewTicket=True")
    End Sub
    Protected Sub OnRowCommand(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandName = "ButtonField" Then
            ResourcesGrid.ShowFooter = False
            If ViewState("dt") IsNot Nothing Then
                dt = CType(ViewState("dt"), DataTable)
                ResourcesGrid.DataSource = dt
            End If
            ResourcesGrid.DataBind()

        End If
    End Sub
    Protected Sub OnRowCommandEstimate(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        If e.CommandName = "EstimateCancelbtn" Then
            EstimatesGrid.ShowFooter = False
            If ViewState("dt") IsNot Nothing Then
                dt = CType(ViewState("dt"), DataTable)
                ResourcesGrid.DataSource = dt
            End If
            EstimatesGrid.DataBind()

        End If
    End Sub
    Protected Sub EstimatesGrid_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim estimateId As Integer = CType(DataBinder.Eval(e.Row.DataItem, "ID").ToString().Trim(),Integer)
            if estimateId<7
                Dim Minus As ImageButton = CType(e.Row.FindControl("EstimateCross"), ImageButton)
                Minus.Attributes.CssStyle.Add("display", "none")
            End If


        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.CssClass = "footer"
            e.Row.Cells(0).ColumnSpan = 2
        End If
        If ViewState("listOfKeyValue") IsNot Nothing Then
            Dim list As Dictionary(Of String, String) = CType(ViewState("listOfKeyValue"), Dictionary(Of String, String))
            If e.Row.RowType = DataControlRowType.DataRow Then
                Dim S As String = CType(e.Row.FindControl("lblEstimateName"), Label).Text
                If list.ContainsKey(S) Then
                    ' Write value of the key.
                    Dim num As String = list.Item(S)
                    CType(e.Row.FindControl("txtName"), TextBox).Text = num
                 End If

            
            End If
        End If
    End Sub

    Protected Sub ddlTicketOwner_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim RoleIdval As String = hdnRoleId.Value
        Dim list As DropDownList = DirectCast(sender, DropDownList)
        Dim value As String = DirectCast(list.SelectedItem.Text, String)
        Dim RoleId As String = DirectCast(list.Attributes("data"), String)
        Dim UserId As String = DirectCast(list.SelectedItem.Value, String)
        If RoleIdval.Equals("2") Then
            hdnProductOwner.Value = value
            hdnProductOwnerID.Value = UserId
        ElseIf RoleIdval.Equals("3") Then
            hdnDesignLead.Value = value
            hdnDesignLeadID.Value = UserId
        ElseIf RoleIdval.Equals("4") Then
            hdnDevlopmentLead.Value = value
            hdnDevlopmentLeadID.Value = UserId
        ElseIf RoleIdval.Equals("5") Then
            hdnQALead.Value = value
            hdnQALeadID.Value = UserId
        ElseIf RoleIdval.Equals("1") Then
            Dim add As String = listOfAddedItem.Value

            'If (ViewState("Resources") IsNot Nothing) Then
            '    Dim aaa As String = CType(ViewState("Resources"), String)
            '    listOfAddedItem.Value = aaa & "|" & add
            'Else
            '    listOfAddedItem.Value = add
            'End If
            'Dim newResources As String = AddedResource.Value
            'If (ViewState("NewResource") IsNot Nothing) Then
            '    Dim rrr As String = CType(ViewState("NewResource"), String)
            '    AddedResource.Value = rrr & "|" & newResources
            'Else
            '    AddedResource.Value = newResources
            'End If

            'If (ViewState("hdnRoleId") IsNot Nothing) Then
            '    Dim rrrID As String = CType(ViewState("hdnRoleId"), String)
            '    hdnRoleId.Value = rrrID & "|" & RoleIdval
            'Else
            '    hdnRoleId.Value = RoleIdval
            'End If
            'If String.IsNullOrEmpty(ListOfAddedResources) Then hdnRoleId
            '    ListOfAddedResources = add
            'Else
            '    ListOfAddedResources = ListOfAddedResources & "|" & add
            'End If
            'ViewState("Resources") = listOfAddedItem.Value
            'ViewState("NewResource") = AddedResource.Value
            'Dim list As DropDownList = DirectCast(sender, DropDownList)
            'Dim value As String = DirectCast(list.SelectedItem.Text, String)
            'Dim RoleId As String = DirectCast(list.Attributes("data"), String)
            'Dim UserId As String = DirectCast(list.SelectedItem.Value, String)
            'Dim x = New System.Collections.Generic.KeyValuePair(Of String, String)(RoleId, value & "|" & UserId)
            'If (ListOfResourcesKeyValues Is Nothing) Then
            '    ListOfResourcesKeyValues = CType(ViewState("ListOfResourcesKeyValues"), System.Collections.Generic.List(Of System.Collections.Generic.KeyValuePair(Of String, String)))
            'End If
            'ListOfResourcesKeyValues.Add(x)
            'ViewState("ListOfResourcesKeyValues") = ListOfResourcesKeyValues
            Dim PM As String = hdnListOfPM.Value
            'Dim PmIds as String =hdnListOfPMIds.Value
            If String.IsNullOrEmpty(PM) Then
                hdnListOfPM.Value = value
                hdnListOfPMIds.Value = UserId
            Else
                hdnListOfPM.Value = hdnListOfPM.Value + "," + value
                hdnListOfPMIds.Value = hdnListOfPMIds.Value + "," + UserId
            End If
        Else
           Dim dtt as DataTable= Portal.BLL.PM.PM_Ticket_Features.UpdateTicketResource(CType(hdnID.Value,Integer),CType(RoleIdval,Integer),CType(UserId,Integer))
            hdnResource.Value=value
            hdnResourceID.Value=UserId
          
                ViewState("dt") = dtt
        
         End If
       ' If RoleIdval.Equals("1")

        'Dim add As String = listOfAddedItem.Value
        'If (ViewState("Resources") IsNot Nothing) Then
        '    Dim aaa As String = CType(ViewState("Resources"), String)
        '    listOfAddedItem.Value = aaa & "|" & add
        'Else
        '    listOfAddedItem.Value = add
        'End If
        'Dim newResources As String = AddedResource.Value
        'If (ViewState("NewResource") IsNot Nothing) Then
        '    Dim rrr As String = CType(ViewState("NewResource"), String)
        '    AddedResource.Value = rrr & "|" & newResources
        'Else
        '    AddedResource.Value = newResources
        'End If
       
        'If (ViewState("hdnRoleId") IsNot Nothing) Then
        '    Dim rrrID As String = CType(ViewState("hdnRoleId"), String)
        '    hdnRoleId.Value = rrrID & "|" & RoleIdval
        'Else
        '    hdnRoleId.Value = RoleIdval
        'End If
        ''If String.IsNullOrEmpty(ListOfAddedResources) Then hdnRoleId
        ''    ListOfAddedResources = add
        ''Else
        ''    ListOfAddedResources = ListOfAddedResources & "|" & add
        ''End If
        'ViewState("Resources") = listOfAddedItem.Value
        'ViewState("NewResource") = AddedResource.Value
        ''Dim list As DropDownList = DirectCast(sender, DropDownList)
        ''Dim value As String = DirectCast(list.SelectedItem.Text, String)
        ''Dim RoleId As String = DirectCast(list.Attributes("data"), String)
        ''Dim UserId As String = DirectCast(list.SelectedItem.Value, String)
        'Dim x = New System.Collections.Generic.KeyValuePair(Of String, String)(RoleId, value & "|" & UserId)
        'If (ListOfResourcesKeyValues Is Nothing) Then
        '    ListOfResourcesKeyValues = CType(ViewState("ListOfResourcesKeyValues"), System.Collections.Generic.List(Of System.Collections.Generic.KeyValuePair(Of String, String)))
        'End If
        'ListOfResourcesKeyValues.Add(x)
        'ViewState("ListOfResourcesKeyValues") = ListOfResourcesKeyValues

        'End If
        If ViewState("dt") IsNot Nothing Then
            dt = CType(ViewState("dt"), DataTable)
            ResourcesGrid.DataSource = dt
        End If
        ResourcesGrid.DataBind()
    End Sub
    'Protected Sub addResources_Click(sender As Object, e As ImageClickEventArgs)
      
    'End Sub
    'Protected Sub addEstimate_Click(sender As Object, e As ImageClickEventArgs)

    '    'Dim s As String = CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox).Text
    '    'ViewState("value1") = s


    '    'For Each row As DataRow In dt.Rows
    '    '    Dim title As String = row.Item("Title").ToString().Trim()
    '    '    If String.IsNullOrEmpty(SuggestionEstimateList) Then
    '    '        SuggestionEstimateList += """" + title + """"
    '    '    Else
    '    '        SuggestionEstimateList += ", """ + title + """"
    '    '    End If
    '    'Next
      
    'End Sub

    Protected Function ManageResources(ByVal val As String) As String
        Dim perviousResources As Dictionary(Of String, String) = CType(ViewState("preResources"), Dictionary(Of String, String))
        'Dim newResource As String
        Dim preResource As String
        If perviousResources.ContainsKey(val) Then
            '    newResource = NewTicketResources.Item(val)
            preResource = perviousResources.Item(val)
        End If
        'Dim ArrayOfResources As String() = newResource.Split(",")
        'Dim ArrayOfPreResources As String() = preResource.Split(",")
        'Dim x As Boolean = False
        'For i As Integer = 0 To ArrayOfResources.Length - 1
        '    For j As Integer = 0 To ArrayOfPreResources.Length - 1
        '        If ArrayOfResources(i).Equals(ArrayOfPreResources(j)) Then
        '            Exit For
        '        Else
        '            If String.IsNullOrEmpty(NewAddedResource) Then
        '                NewAddedResource = ArrayOfResources(i)
        '            Else
        '                NewAddedResource = NewAddedResource & "," & ArrayOfResources(i)
        '            End If

        '        End If
        '    Next
        'Next
        If String.IsNullOrEmpty(preResource) Then
            preResource = ""
        End If
        Return preResource
    End Function

    Protected Function ManageNewResources(ByVal val As String) As String
        Dim listpo As List(Of Portal.BLL.PM.PM_Ticket_Features)
        Dim NewResourcesdt As DataTable
        Dim NewTicketResources As Dictionary(Of String, String)
        listpo = Portal.BLL.PM.PM_Ticket_Features.PM_Project_Information_GetByTicketID(Integer.Parse(hdnID.Value))
        If listpo.Count > 0 Then
            NewResourcesdt = listpo(0).DtProjectResources
            NewTicketResources = New Dictionary(Of String, String)
            For Each row As DataRow In NewResourcesdt.Rows
                NewTicketResources.Add(row.Item("Title"), IIf(IsDBNull(row.Item("ResourceNames")), Nothing, row.Item("ResourceNames")))
            Next
        End If
        Dim newResource As String
        If NewTicketResources.ContainsKey(val) Then
            '    newResource = NewTicketResources.Item(val)
            newResource = NewTicketResources.Item(val)
        End If
        If String.IsNullOrEmpty(newResource) Then
            newResource = ""
        End If
        Return newResource
    End Function
    Protected Function ManageEstimate(ByVal val As String) As String
        Dim perviousEstimate As Dictionary(Of String, String) = CType(ViewState("preEstimates"), Dictionary(Of String, String))
        Dim preEstimate As String
        If perviousEstimate.ContainsKey(val) Then
            preEstimate = perviousEstimate.Item(val)
        End If
        If String.IsNullOrEmpty(preEstimate) Then
            preEstimate = ""
        End If
        Return preEstimate

    End Function
    Protected Function ManageNewEstimate(ByVal val As String) As String
        Dim NewTicketEstimate As Dictionary(Of String, String)
        Dim EstimateTable As DataTable = Portal.BLL.PM.PM_Ticket_Features.PM_MYTicket_Estimates_GetByTicketID(hdnID.Value)
        NewTicketEstimate = New Dictionary(Of String, String)
        For Each row As DataRow In EstimateTable.Rows
            NewTicketEstimate.Add(row.Item("Title"), IIf(IsDBNull(row.Item("Estimates")), Nothing, row.Item("Estimates")))
        Next
        Dim newEstimate As String
        If NewTicketEstimate.ContainsKey(val) Then
            '    newResource = NewTicketResources.Item(val)
            newEstimate = NewTicketEstimate.Item(val)
        End If
        If String.IsNullOrEmpty(newEstimate) Then
            newEstimate = ""
        End If
        Return newEstimate
    End Function


    Function GetUniqueProjectManager(Resources As String,DelResources As String) As String
        Dim R as String()=Resources.split("|")
        Dim D as String()=DelResources.Split(",")
        Dim ReturnVal As String
        Dim i as Integer 
        For  i= 0 To R.Length-1
          Dim keyValue as String() =R(i).Split(",")
          Dim j as integer
          Dim p As Boolean=False
          for j=0 to D.Length-1
                If D(j).Equals(keyValue(1))
                  p=true 
                End If
          Next 
            if p =False
            If Not String.IsNullOrEmpty(ReturnVal)
                ReturnVal=R(i)
            Else 
                ReturnVal=ReturnVal +"|"+R(i)
            End If
            End If
        Next 
        Return ReturnVal
    End Function
    Function GetUniquePMIds() As String
        Dim ProjectManagers =hdnListOfPMIds.Value
        Dim preProjectManagers =hdnListOfOldPMIds.Value
        Dim ReturnVal As String
        if Not  String.IsNullOrEmpty(ProjectManagers) And Not  String.IsNullOrEmpty(preProjectManagers)

        Dim R as String()=ProjectManagers.split(",")
        Dim D as String()=preProjectManagers.Split(",")
        
        Dim i as Integer 
        For  i= 0 To R.Length-1
'Dim keyValue as String() =R(i).Split(",")
            'Dim j as integer
            Dim p As Boolean=False
            for Each nam As String in D
                If nam.Equals(R(i))
                            p=true 
                End If
            Next 

            'for j=0 to D.Length-1
            '    If D(j).Equals(keyValue(1))
            '        p=true 
            '    End If
            'Next 
            if p =False
                If  String.IsNullOrEmpty(ReturnVal)
                    ReturnVal= "1,"+R(i)
                Else 
                    ReturnVal=ReturnVal +"|"+ "1,"+R(i)
                End If
            End If
        Next 
     Else 
        if not String.IsNullOrEmpty(hdnListOfPMIds.Value)

       
        Dim PMList as String() =hdnListOfPMIds.Value.Split(",")
            for Each S As String in PMList
                If String.IsNullOrEmpty(ReturnVal)
                    ReturnVal= "1,"+S
                Else 
                    ReturnVal=ReturnVal +"|"+ "1,"+S
                End If
            Next
        ' ReturnVal=hdnListOfPMIds.Value
        End If
        End If
        Return ReturnVal
    End Function

    Protected Sub btnYes_OnClick(sender As Object, e As EventArgs)
        'Dim ticketID as Integer =hdnID.Value
        'Dim linkedTicketId as Integer=removeLinkedID.Value
        Portal.BLL.PM.PM_Ticket_Features.RemoveLinkedTicket(CType(hdnID.Value,Integer),CType(removeLinkedID.Value,Integer))
         Dim IsTicketDetailChanged As Boolean = True

            Dim strBodyTicketDetailChange As String = " === Ticket "+removeLinkedID.Value+" has been de-linked from this ticket  ===" + vbCrLf + vbCrLf
            If IsTicketDetailChanged Then

                ' Add Note 
                Dim intNewNotesID As Integer = 0
                Dim ObjNotes As PM_Notes
                Dim IsPublic As Boolean = False
                ObjNotes = New PM_Notes()
                With ObjNotes
                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = strBodyTicketDetailChange
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = "0:0"
                    .Type = Enumeration.TicketsNotesType.PrivateNote
                    IsPublic = True
                    intNewNotesID = .Notes_Add()
                End With



                End If

                Dim strBodyTicketDetailChange1 As String = " === Ticket "+hdnID.Value+" has been de-linked from this ticket by " +  hdnName.Value + " on " + DateTime.Now + " ===" + vbCrLf + vbCrLf
                If IsTicketDetailChanged Then

                    ' Add Note 
                    Dim intNewNotesID As Integer = 0
                    Dim ObjNotes As PM_Notes
                    Dim IsPublic As Boolean = False
                    ObjNotes = New PM_Notes()
                    With ObjNotes
                        ObjNotes = New PM_Notes()
                        .Ticket_Feature_ID = removeLinkedID.Value
                        .Notes = strBodyTicketDetailChange1
                        .SubmittedBy = CType(Session("AdminID"), Integer)
                        .DateEntered = DateTime.Now
                        .IsByAdmin = 1
                        .TimeSpent = "0:0"
                        .Type = Enumeration.TicketsNotesType.PrivateNote
                        IsPublic = True
                        intNewNotesID = .Notes_Add()
                    End With



                End If
        dlData.DataBind()
    End Sub

    Protected Sub btnSearchpop_OnClick(sender As Object, e As EventArgs)
        'Dim listpo As List(Of Portal.BLL.PM.PM_Ticket_Features)
        Dim dtTicket As DataTable
        Dim ticketNumbers As String = txtSearchBox.Text.Replace(" ", "")
        'listpo = Portal.BLL.PM.PM_Ticket_Features.PM_TicketSearch(Integer.Parse(txtSearchBox.Text))
        dtTicket = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_TicketLink_Search(Integer.Parse(ticketNumbers))
        ticketGrid.DataSource = dtTicket
        ticketGrid.DataBind()
        System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "<script type='Text/Javascript'>ShowDiv();</script>", False)
    End Sub

    Protected Sub btnSaveTicket_OnClick(sender As Object, e As EventArgs)
        Dim chkBox As CheckBox
        Dim val As String
        Dim Subject as String
        For Each gvRow As GridViewRow In ticketGrid.Rows
            chkBox = DirectCast(gvRow.FindControl("checkTicket"), CheckBox)
            val = CType(gvRow.FindControl("ticketNumber"), Label).Text
            Subject = CType(gvRow.FindControl("ticketName"), Label).text
        Next


        If val > 0 Then
            If Not val.Equals(hdnID.Value) Then
                Dim result = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_TicketLink_Add(CType(hdnID.Value, Integer), CType(val, Integer), Subject)
            Dim IsTicketDetailChanged As Boolean = True

                Dim strBodyTicketDetailChange As String = " === This ticket has been linked to ticket #" + val + " (Subject: " + Subject + "). ===" + vbCrLf + vbCrLf
            If IsTicketDetailChanged Then

                ' Add Note 
                Dim intNewNotesID As Integer = 0
                Dim ObjNotes As PM_Notes
                Dim IsPublic As Boolean = False
                ObjNotes = New PM_Notes()
                With ObjNotes
                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = strBodyTicketDetailChange
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = "0:0"
                    .Type = Enumeration.TicketsNotesType.PrivateNote
                    IsPublic = True
                    intNewNotesID = .Notes_Add()
                End With



                End If

                Dim strBodyTicketDetailChange1 As String = " === This ticket has been linked to ticket #" + hdnID.Value + " (Subject: " + txtName.Text + ") by " +  hdnName.Value + " on " + DateTime.Now + " ===" + vbCrLf + vbCrLf
                If IsTicketDetailChanged Then

                    ' Add Note 
                    Dim intNewNotesID As Integer = 0
                    Dim ObjNotes As PM_Notes
                    Dim IsPublic As Boolean = False
                    ObjNotes = New PM_Notes()
                    With ObjNotes
                        ObjNotes = New PM_Notes()
                        .Ticket_Feature_ID = val
                        .Notes = strBodyTicketDetailChange1
                        .SubmittedBy = CType(Session("AdminID"), Integer)
                        .DateEntered = DateTime.Now
                        .IsByAdmin = 1
                        .TimeSpent = "0:0"
                        .Type = Enumeration.TicketsNotesType.PrivateNote
                        IsPublic = True
                        intNewNotesID = .Notes_Add()
                    End With



                End If

        End If

        End If

        System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "<script type='Text/Javascript'>HideDiv();</script>", False)
        ticketGrid.DataSource = Nothing
        dlData.DataBind()
       ' Response.Redirect("~/PM/TicketsDetail.aspx?ID=" & hdnID.Value & "&NewTicket=True&PrevPage=4")
    End Sub

    Protected Sub Button1_OnClick(sender As Object, e As EventArgs)
        Portal.BLL.PM.PM_Ticket_Features.DeleteResources(CType(hdnID.Value,Integer),CType(deleteResource.Value,Integer))
        Dim listpo As List(Of Portal.BLL.PM.PM_Ticket_Features)
        listpo = Portal.BLL.PM.PM_Ticket_Features.PM_Project_Information_GetByTicketID(Integer.Parse(hdnID.Value))
        'Dim dt As DataTable
        If listpo.Count > 0 Then
            Dim dt = listpo(0).DtProjectResources
            ResourcesGrid.DataSource=dt
            ResourcesGrid.DataBind()
            ViewState("dt") = dt
        End If
        'Dim IsTicketDetailChanged As Boolean = True

        'Dim strBodyTicketDetailChange As String = " === Ticket "+removeLinkedID.Value+" has been de-linked from this ticket  ===" + vbCrLf + vbCrLf
        'If IsTicketDetailChanged Then

        '    ' Add Note 
        '    Dim intNewNotesID As Integer = 0
        '    Dim ObjNotes As PM_Notes
        '    Dim IsPublic As Boolean = False
        '    ObjNotes = New PM_Notes()
        '    With ObjNotes
        '        ObjNotes = New PM_Notes()
        '        .Ticket_Feature_ID = CInt(hdnID.Value)
        '        .Notes = strBodyTicketDetailChange
        '        .SubmittedBy = CType(Session("AdminID"), Integer)
        '        .DateEntered = DateTime.Now
        '        .IsByAdmin = 1
        '        .TimeSpent = "0:0"
        '        .Type = Enumeration.TicketsNotesType.PrivateNote
        '        IsPublic = True
        '        intNewNotesID = .Notes_Add()
        '    End With



        'End If
    End Sub

    Protected Sub linkButton_OnClick(sender As Object, e As EventArgs)
        Dim S As TextBox = CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox)
        If Not String.IsNullOrEmpty(S.Text.ToString()) Then
           Dim D as DataTable= Portal.BLL.PM.PM_Ticket_Features.AddNewResource(CType(hdnID.Value,Integer),S.Text.ToString())
            ViewState("dt") = D
            ResourcesGrid.ShowFooter = false
            ResourcesGrid.DataSource=D
            ResourcesGrid.DataBind()
        End If
       
    End Sub

    Protected Sub addResources_OnClick(sender As Object, e As EventArgs)
        ViewState("value") = CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox).Text
        'For Each row As DataRow In dt.Rows
        '    Dim title As String = row.Item("Title").ToString().Trim()
        '    If String.IsNullOrEmpty(SuggestionList) Then
        '        SuggestionList += """" + title + """"
        '    Else
        '        SuggestionList += ", """ + title + """"
        '    End If
        'Next
        Dim dtSuggestionList As DataTable = PM_Ticket_Features.PM_Roles_GetAll(Integer.Parse(hdnID.Value))
        SuggestionList = DataTableToJSONWithJavaScriptSerializer(dtSuggestionList)
        ViewState("SuggestionList") = SuggestionList
        ResourcesGrid.ShowFooter = True
        'Dim txt As TextBox = CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox)
        'TextBox.Attributes.Add("placeholder", "hint")
        If ViewState("dt") IsNot Nothing Then
            dt = CType(ViewState("dt"), DataTable)
            ResourcesGrid.DataSource = dt
        End If
        ResourcesGrid.DataBind()
        Dim S As TextBox = CType(ResourcesGrid.FooterRow.FindControl("txtResourceSearchBox"), TextBox)
        S.Focus()

    End Sub

    Protected Sub addEstimate_OnClick(sender As Object, e As EventArgs)
        Dim listOfKeyValue = New Dictionary(Of String, String)
        For Each row As GridViewRow In EstimatesGrid.Rows
            Dim Key = CType(row.FindControl("lblEstimateName"), Label).Text
            Dim val = CType(row.FindControl("txtName"), TextBox).Text
            listOfKeyValue.Add(Key, val)
        Next
        ViewState("listOfKeyValue") = listOfKeyValue
        Dim dtSuggestionEstimateList As DataTable = PM_Ticket_Features.PM_EstimatesType_GetAll(Integer.Parse(hdnID.Value))


        SuggestionEstimateList = DataTableToJSONWithJavaScriptSerializer(dtSuggestionEstimateList)
        ViewState("SuggestionEstimateList") = SuggestionEstimateList
        EstimatesGrid.ShowFooter = True

        If ViewState("dt") IsNot Nothing Then
            dt = CType(ViewState("dt"), DataTable)
            ResourcesGrid.DataSource = dt
        End If

        EstimatesGrid.DataBind()
        Dim S As TextBox = CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox)
        S.Focus()
    End Sub

    Protected Sub LinkEstimateSave_OnClick(sender As Object, e As EventArgs)
        Dim S As TextBox = CType(EstimatesGrid.FooterRow.FindControl("txtEstimateSearchBox"), TextBox)
        If Not String.IsNullOrEmpty(S.Text.ToString()) Then
            Dim D as DataTable= Portal.BLL.PM.PM_Ticket_Features.AddNewEstimate(CType(hdnID.Value,Integer),S.Text.ToString())
            'ViewState("dt") = D
            EstimatesGrid.ShowFooter = false
            'EstimatesGrid.DataSource=D
            EstimatesGrid.DataBind()
        End If
    End Sub

    Protected Sub Button5_OnClick(sender As Object, e As EventArgs)
        Portal.BLL.PM.PM_Ticket_Features.DeleteEstimate(CType(hdnID.Value,Integer),CType(deleteEstimate.Value,Integer))
        EstimatesGrid.DataBind()
    End Sub

End Class
