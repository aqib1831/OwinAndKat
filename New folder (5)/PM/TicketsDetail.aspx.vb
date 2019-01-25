Imports Microsoft.VisualBasic
Imports Portal.BLL
Imports Portal.BLL.PM
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient

Partial Class PM_TicketsDetail
    Inherits System.Web.UI.Page

#Region "Private Members"
    Protected ObjTickets As PM_Ticket_Features
    Dim ClientID As Integer
    Dim ddlClients As String
    Dim ddlCategories As String
    Dim ddlStatus As String
    Dim ddlTypes As String
    Dim ddlFilter As String
    Dim txtSearch As String
    Dim hdnSortBy As String = String.Empty
    Dim ddlWaitFor As String
    Dim reClient As String
    Dim reCatagory As String
    Dim WaitingForUserID As Integer
    Dim colTicket_Features As New List(Of PM_Ticket_Features)()
    Dim PublicNotes As New StringBuilder
    Dim PrivateNotes As New StringBuilder
    Dim txtDateFrom As DateTime = DateTime.Now.AddYears(-4)
    Dim txtDateTo As DateTime = DateTime.Now
    Dim GridViewCurrentPageNumber As Integer = 1
    Dim AreaDeveloperId As Integer = 0
#End Region

#Region "Page Events"
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)

        hdnID.Value = Request.QueryString("ID")
        hdnIDPre.Value=Request.QueryString("PreID")

        colTicket_Features = PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(hdnID.Value, Integer))

        If colTicket_Features.Count > 0 Then
            hdnClientID.Value = colTicket_Features.Item(0).ClientID
            hdnClientContactID.Value = colTicket_Features.Item(0).ClientContactID

            lblClientName.Text = colTicket_Features.Item(0).ClientName
            lblContactClientName.Text = colTicket_Features.Item(0).ClientName
            lblContactClientNameOnNotes.Text = colTicket_Features.Item(0).ClientName
            lblCategoryName.Text = colTicket_Features.Item(0).CatagoryName
            lblSubCategory.Text = colTicket_Features.Item(0).SubCatagoryName
            hdnAreaDeveloperID.Value = colTicket_Features.Item(0).AreaDeveloperId
            lblTicketOwner.Text = colTicket_Features.Item(0).TicketOwnerName
            hndProductOwnerID.Value = colTicket_Features.Item(0).TicketOwner
            If colTicket_Features.Item(0).CorporateName <> "" Then
                'lblAreaDeveloper.Visible = True
                'tdAreaDeveloper.Visible = True
                'tdlblAreaDeveloper.Visible = True


                Dim StringArea As String = colTicket_Features.Item(0).CorporateName

                Dim SStringArea As String = StringArea.Substring(0, 15)
                SStringArea += "..."
                'lblAreaDeveloper.Text = SStringArea
                'lblAreaDeveloper.ToolTip = colTicket_Features.Item(0).CorporateName


                Help2tdAreaDeveloper.Visible = True
            Else
                ' lblAreaDeveloper.Visible = False
                tdAreaDeveloper.Visible = False
                Help2tdAreaDeveloper.Visible = True
                'tdlblAreaDeveloper.Visible = False
            End If

            If Not IsNothing(colTicket_Features.Item(0).SowSignedDate) Then
                lblSOWSignedDate.Text = DateTime.Parse(colTicket_Features.Item(0).SowSignedDate).ToShortDateString()
                helptdAreaDeveloper.Visible = False
            Else
                lblSOWSignedDate.Text = ""
                tdSOWSignedDate.Visible = False
                helptdAreaDeveloper.Visible = True

            End If
            'lblSOWSignedDate.Text = DateTime.Parse(Functions.IfNull(colTicket_Features.Item(0).SowSignedDate, ""))

            Me.hdnRefNo.Value = colTicket_Features.Item(0).RefNo

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
            If colTicket_Features.Item(0).DueDate = DateTime.MinValue Then
                hdnDueDate.Value = "-"
            Else
                hdnDueDate.Value = Functions.IfNull(colTicket_Features.Item(0).DueDate, "-")
            End If

            If colTicket_Features.Item(0).ShowDueDateFlag = True Then
                imgDueDate.Visible = True
                imgDueDate.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "flag_orange.gif"
                imgDueDate.Attributes.Add("Title", "Due date is near")
            Else
                imgDueDate.Visible = False
            End If

            If colTicket_Features.Item(0).ReleaseID <> 0 Then
                IsRelease.Value = "True"
            Else
                IsRelease.Value = "False"
            End If


            Dim strDueDate As String
            Dim strStatus As String
            strDueDate = colTicket_Features.Item(0).DueDate
            strStatus = colTicket_Features.Item(0).Status
            hdnStatus.Value = colTicket_Features.Item(0).Status
            hdnClientStatusId.Value = colTicket_Features.Item(0).ClientStatusId

            If CType(strDueDate, Date) < DateTime.Now.Date AndAlso strStatus <> Enumeration.PMStatus.Released AndAlso strStatus <> Enumeration.PMStatus.ConfirmSolved AndAlso strStatus <> Enumeration.PMStatus.OnHold Then
                imgFlag.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "flag_red.gif"
                imgFlag.Attributes.Add("Title", "Delayed Ticket")
            Else

                imgFlag.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "spacer.gif"
            End If

            hdnShowDueDateForFlag.Value = colTicket_Features.Item(0).ShowDueDateFlag
            'If colTicket_Features.Item(0).ClientID = Enumeration.ClientID.EA Then
            '    btnEditTicketDetail.Visible = False
            'End If
            If colTicket_Features.Item(0).Status = 5 Then
                spnEditTicketDetail.Visible = False
            End If

        End If

        If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
            ViewState("ClientID") = Nothing
            hdnID.Value = Request.QueryString("ID").ToString()

            If String.IsNullOrEmpty(Request.QueryString("ddlClients")) = False AndAlso IsNumeric(Request.QueryString("ddlClients")) Then
                ddlClients = Request.QueryString("ddlClients")
            End If
            If String.IsNullOrEmpty(Request.QueryString("ddlCategories")) = False AndAlso IsNumeric(Request.QueryString("ddlCategories")) Then
                ddlCategories = Request.QueryString("ddlCategories")
            End If
            If String.IsNullOrEmpty(Request.QueryString("ddlStatus")) = False AndAlso IsNumeric(Request.QueryString("ddlStatus")) Then
                ddlStatus = Request.QueryString("ddlStatus")
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
            If String.IsNullOrEmpty(Request.QueryString("txtSearch")) = False Then
                txtSearch = Request.QueryString("txtSearch")
            End If
            If String.IsNullOrEmpty(Request.QueryString("ddlWaitFor")) = False AndAlso IsNumeric(Request.QueryString("ddlWaitFor")) Then
                ddlWaitFor = Request.QueryString("ddlWaitFor")
            End If

            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                ClientID = CInt(Request.QueryString("ClientID").ToString())
            End If

            If String.IsNullOrEmpty(Request.QueryString("hdnSortBy")) = False Then
                hdnSortBy = Request.QueryString("hdnSortBy")
            End If

            If String.IsNullOrEmpty(Request.QueryString("txtDateFrom")) = False Then
                txtDateFrom = Request.QueryString("txtDateFrom")
            End If

            If String.IsNullOrEmpty(Request.QueryString("txtDateTo")) = False Then
                txtDateTo = Request.QueryString("txtDateTo")
            End If


            If String.IsNullOrEmpty(Request.QueryString("ReleaseID")) = False AndAlso IsNumeric(Request.QueryString("ReleaseID")) Then
                hdnReleaseID.Value = Request.QueryString("ReleaseID")
            End If


            If String.IsNullOrEmpty(Request.QueryString("CurrentPageNumber")) = False Then
                GridViewCurrentPageNumber = Request.QueryString("CurrentPageNumber")
            End If



            If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
                PrevPage.Value = CInt(Request.QueryString("PrevPage"))
                Select Case PrevPage.Value
                    Case 1 'Home
                        btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx" & IIf(ClientID <> 0, "?ClientID=" & ClientID, "")) & "'; return false;")
                    Case 2 'Feature
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Features.aspx?ID=" & hdnReleaseID.Value) & "&ddlClients=" & ddlClients & "&ddlCategories=" & ddlCategories & "&ddlStatus=" & ddlStatus & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "&hdnSortBy=" & hdnSortBy & "&reClients=" & reClient & "&reCategories=" & reCatagory & "&PrevPage=1';return false; ")
                    Case 6 'Feature
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Features.aspx?ID=" & hdnReleaseID.Value) & "&ddlClients=" & ddlClients & "&ddlCategories=" & ddlCategories & "&ddlStatus=" & ddlStatus & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "&hdnSortBy=" & hdnSortBy & "&reClients=" & reClient & "&reCategories=" & reCatagory & "&PrevPage=2';return false;")
                    Case 3 'Tickets
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/Tickets.aspx?ddlClients=" & ddlClients) & "&ddlCategories=" & ddlCategories & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&ddlStatus=" & ddlStatus & "&txtSearch=" & txtSearch & "&hdnSortBy=" & hdnSortBy & "&ddlWaitFor=" & ddlWaitFor & "&GridViewCurrentPageNumber=" & GridViewCurrentPageNumber & "';return false;")
                    Case 4 'MyTickets
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/MyTickets.aspx?ddlClients=" & ddlClients) & "&ddlCategories=" & ddlCategories & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&ddlStatus=" & ddlStatus & "&txtSearch=" & txtSearch & "&hdnSortBy=" & hdnSortBy & "&GridViewCurrentPageNumber=" & GridViewCurrentPageNumber & "&txtDateFrom=" & txtDateFrom & "&txtDateTo=" & txtDateTo & "';return false;")
                    Case 5 'Tickets History
                        btnBack.Attributes.Add("OnClick", "window.location='" & ResolveClientUrl("~/PM/TicketsHistory.aspx?ddlClients=" & ddlClients) & "&ddlCategories=" & ddlCategories & "&ddlTypes=" & ddlTypes & "&ddlFilter=" & ddlFilter & "&ddlStatus=" & ddlStatus & "&txtSearch=" & txtSearch & "&hdnSortBy=" & hdnSortBy & "';return false;")
                    Case 7 'PM Report
                        btnBack.Attributes.Add("OnClick", "MoveToBack();")
                    Case 0 
                       btnBack.Attributes.Add("OnClick","prePage();")
                    Case Else
                        btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx" & IIf(String.IsNullOrEmpty(Request.QueryString("ClientID")) = False, "?ClientID=" & Request.QueryString("ClientID").ToString(), "")) & "';return false;")
                End Select
            End If
        End If


        Me.lBtnPrint.NavigateUrl = "TicketsReport.aspx?TicketID=" & Request.QueryString("ID")
        ddlHoursNotes.DataSource = Functions.GetInterval(100)
        ddlHoursNotes.DataTextField = "Text"
        ddlHoursNotes.DataValueField = "Value"
        ddlHoursNotes.DataBind()

        ddlMinutesNotes.DataSource = Functions.GetInterval(60)
        ddlMinutesNotes.DataTextField = "Text"
        ddlMinutesNotes.DataValueField = "Value"
        ddlMinutesNotes.DataBind()

        hdnTimeSpent.Value = "00:00:00"

        If Not Page.IsPostBack Then
            chkIsClientFeedback.Checked = False
            colTicket_Features = PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(hdnID.Value, Integer))
            ddlTicketTypes.DataBind()
            ddlTicketOwner.DataBind()

            If colTicket_Features.Count > 0 Then
                txtName.Text = colTicket_Features.Item(0).Name
                hdnOldSubject.Value = colTicket_Features.Item(0).Name
                If (ddlTicketTypes.Items.FindByValue(colTicket_Features.Item(0).TypeID) Is Nothing = False) Then
                    ddlTicketTypes.SelectedValue = colTicket_Features.Item(0).TypeID
                    hdnOldTypeId.Value = colTicket_Features.Item(0).TypeID
                End If

                If (ddlTicketOwner.Items.FindByValue(colTicket_Features.Item(0).TicketOwner) Is Nothing = False AndAlso colTicket_Features.Item(0).TicketOwner <> 0) Then
                    ddlTicketOwner.SelectedValue = colTicket_Features.Item(0).TicketOwner
                End If

                hdnCategoryID.Value = colTicket_Features.Item(0).CatagoryID
                hdnOldCategoryId.Value = colTicket_Features.Item(0).CatagoryID
                hdnSubCategoryID.Value = colTicket_Features.Item(0).SubCatagoryID
                hdnOldsubCategoryId.Value = colTicket_Features.Item(0).SubCatagoryID
                'txtSowSignedDate.Text = DateTime.Parse(Functions.IfNull(colTicket_Features.Item(0).SowSignedDate, System.DateTime.Now)).ToShortDateString()

                If Not IsNothing(colTicket_Features.Item(0).SowSignedDate) Then
                    txtSowSignedDate.Value = DateTime.Parse(colTicket_Features.Item(0).SowSignedDate).ToShortDateString()
                    hdnOldSowSignedDate.Value = DateTime.Parse(colTicket_Features.Item(0).SowSignedDate).ToShortDateString()
                End If


                'ddlTicketStatus.SelectedValue = colTicket_Features.Item(0).Status
                'ddlTicketClients.SelectedValue = colTicket_Features.Item(0).ClientID
                hdnOldClientId.Value = colTicket_Features.Item(0).ClientID
                'ddlTicketClients.DataBind()
                AreaDeveloperId = colTicket_Features.Item(0).AreaDeveloperId
                hdnOldAreaDeveloperId.Value = colTicket_Features.Item(0).AreaDeveloperId
            End If
        End If

        rptUC.DataBind()
        rptCC.DataBind()
        ddlReleases.DataBind()
        ddlExtensionType.DataBind()
        FillAttachmentsValidations()
        FillddlPriority()
        ddlPriority.SelectedValue = colTicket_Features.Item(0).Priority
        hdnOldPriorityId.Value = colTicket_Features.Item(0).Priority
        'ticketGrid.DataSource = New ArrayList()
        'ticketGrid.DataBind()

        If Request.QueryString("PrevPage") = "4" Then
            Dim dtTicketsIDs As DataTable = PM_Ticket_Features.PM_MYTicketGetAll_Paging(ddlClients, ddlCategories, ddlStatus, ddlFilter, hdnSortBy, 10000, 0, txtSearch, txtDateFrom, txtDateTo, Request.QueryString("ID"))
            If dtTicketsIDs.Rows.Count = 1 Or dtTicketsIDs.Rows.Count = 0 Then
                'hide both next and previous buttons
                btnNext.Visible = False
                btnPrev.Visible = False
            ElseIf dtTicketsIDs.Rows.Count = 2 Then
                Dim Ticket_ID As Integer = CInt(Request.QueryString("ID"))
                If Ticket_ID = dtTicketsIDs.Rows(0)("Id") Then
                    'show next button
                    btnNext.Visible = True
                    Dim nextTicketId As Integer = dtTicketsIDs.Rows(1)("Id")
                    btnNext.Attributes.Add("OnClick", "OnPagingClick('" & nextTicketId & "', '" & ddlClients & "', '" & ddlCategories & "', '" & ddlStatus & "', '" & ddlFilter & "', '" & txtSearch & "', '" & txtDateFrom & "', '" & txtDateTo & "', '" & hdnSortBy & "', '" & GridViewCurrentPageNumber & "'); return false;")
                Else
                    'bind previous button
                    btnPrev.Visible = True
                    Dim prevTicketID As Integer = dtTicketsIDs.Rows(0)("Id")
                    btnPrev.Attributes.Add("OnClick", "OnPagingClick('" & prevTicketID & "', '" & ddlClients & "', '" & ddlCategories & "', '" & ddlStatus & "', '" & ddlFilter & "', '" & txtSearch & "', '" & txtDateFrom & "', '" & txtDateTo & "', '" & hdnSortBy & "', '" & GridViewCurrentPageNumber & "'); return false;")
                End If

            ElseIf dtTicketsIDs.Rows.Count = 3 Then
                Dim prevTicketID As Integer = dtTicketsIDs.Rows(0)("Id")
                Dim nextTicketId As Integer = dtTicketsIDs.Rows(2)("Id")
                btnPrev.Attributes.Add("OnClick", "OnPagingClick('" & prevTicketID & "', '" & ddlClients & "', '" & ddlCategories & "', '" & ddlStatus & "', '" & ddlFilter & "', '" & txtSearch & "', '" & txtDateFrom & "', '" & txtDateTo & "', '" & hdnSortBy & "', '" & GridViewCurrentPageNumber & "'); return false;")
                btnNext.Attributes.Add("OnClick", "OnPagingClick('" & nextTicketId & "', '" & ddlClients & "', '" & ddlCategories & "', '" & ddlStatus & "', '" & ddlFilter & "', '" & txtSearch & "', '" & txtDateFrom & "', '" & txtDateTo & "', '" & hdnSortBy & "', '" & GridViewCurrentPageNumber & "'); return false;")
                btnNext.Visible = True
                btnPrev.Visible = True
            End If
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim dt As DataTable = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_TicketLink_GetByTicketID(CType(hdnID.Value, Integer))
        'linkedTickets.DataSource = dt
        'linkedTickets.DataBind()


        If Not Page.IsPostBack Then
            btnSave.Attributes.Add("onclick", ("javascript:" & btnSave.ClientID & ".disabled=true;") + Page.ClientScript.GetPostBackEventReference(btnSave, ""))

            Session("update") = System.DateTime.Now.ToString()

            If String.IsNullOrEmpty(Request.QueryString("NewTicket")) Then Portal.BLL.PM.PM_Ticket_Features.ChangeRead(hdnID.Value, True, Session("AdminID"), Nothing)

            BindControl()
            LoadRelease()


            If Portal.BLL.Users.CheckUserSubModulesAccessByClientID(CInt(Session("AdminID")), Portal.BLL.Enumeration.SubModules.PMFullAccess, CInt(ViewState("ClientID"))) = False Then
                btnAddNotes.Style.Add("display", "none")
                DivDueDateTime.Style.Add("display", "none")
                hdnIsReadOnlyAccess.Value = "1"
                lblActivityDueDate.Visible = True
                lblActivityStatus.Text = GetStatusCaption(hdnStatus.Value)
                If hdnDueDate.Value = "-" Then
                    lblActivityDueDate.Text = hdnDueDate.Value
                Else

                    lblActivityDueDate.Text = String.Format("{0:MMM dd, yyyy}", hdnDueDate.Value)
                End If
                ddlAssignedto.Enabled = False
            Else
                lblActivityStatus.Text = GetStatusCaption(hdnStatus.Value)
            End If
            If ddlActivityStatus.SelectedValue <> Portal.BLL.Enumeration.PMStatus.Released AndAlso Portal.BLL.PM.PM_Ticket_Features.CheckToComplete(hdnID.Value, Session("AdminID")) > 0 Then
                SpanCompleted.Visible = True
            Else
                SpanCompleted.Visible = False
            End If

            If String.IsNullOrEmpty(Request.QueryString("NewReleaseID")) = False AndAlso IsNumeric(Request.QueryString("NewReleaseID")) Then
                ddlReleases.SelectedValue = Request.QueryString("NewReleaseID")
            End If
            hdnPrevReleaseId.Value = ddlReleases.SelectedValue

            rptClientContacts.DataBind()
            ddlAssignedto.SelectedValue = hdnWaitingFor.Value
        Else
            rptClientContacts.DataBind()
            rptUserContacts.DataBind()
            lblActivityStatus.Text = GetStatusCaption(hdnStatus.Value)
            lblAssignedTo.Text = ddlAssignedto.SelectedItem.Text
            If ddlReleases.SelectedItem.Text <> "None" Then
                lblReleaseName.Text = ddlReleases.SelectedItem.Text
            Else
                lblReleaseName.Text = hdnReleaseName.Value
            End If
        End If

        If ddlActivityStatus.SelectedValue = Enumeration.PMStatus.ConfirmSolved Or ddlActivityStatus.SelectedValue = Enumeration.PMStatus.FeedbackRequested Then
            ddlAssignedto.Enabled = False
        Else
            ddlAssignedto.Enabled = True
        End If

        hdnDueDateShowToClient.Value = chkDueDateShowToClient.Checked

    End Sub

    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        ViewState("update") = Session("update")

        colTicket_Features = PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(hdnID.Value, Integer))

        If colTicket_Features.Item(0).TicketOwnerName = String.Empty AndAlso colTicket_Features.Item(0).ReleaseID = 0 AndAlso colTicket_Features.Item(0).SubCatagoryID = 0 Then
            trReleaseandOwner.Visible = False
        End If


        If colTicket_Features.Item(0).TicketOwnerName = String.Empty Then
            td2.Attributes.Add("style", "display:none;")
        End If

        If colTicket_Features.Item(0).TicketOwnerName <> String.Empty AndAlso colTicket_Features.Item(0).ReleaseID > 0 AndAlso colTicket_Features.Item(0).SubCatagoryID > 0 Then
            td2.Attributes.Add("style", "display:none;")
        End If

        If colTicket_Features.Item(0).ReleaseID = 0 Then
            Me.lblTitle.Text = "Ticket Ref # " & colTicket_Features.Item(0).RefNo
            divRelease.Attributes.Add("style", "display:none;")
            DivReleaselbl.Attributes.Add("style", "display:none;")
        Else
            Me.lblTitle.Text = "Feature Ref # " & colTicket_Features.Item(0).RefNo
        End If


        If colTicket_Features.Item(0).TicketOwnerName = String.Empty Then
            tdTicketOwnerlbl.Attributes.Add("style", "display:none;")
            tdTicketOwner.Attributes.Add("style", "display:none;")
            lblTicketOwner.Attributes.Add("style", "display:none;")
        End If

        If colTicket_Features.Item(0).SubCatagoryID = 0 Then
            tdTitleSubCategory.Attributes.Add("style", "display:none;")
            tdSubCategory.Attributes.Add("style", "display:none;")
        End If

        If CType(colTicket_Features.Item(0).DueDate, Date) < DateTime.Now.Date AndAlso colTicket_Features.Item(0).Status <> Enumeration.PMStatus.Released AndAlso colTicket_Features.Item(0).Status <> Enumeration.PMStatus.ConfirmSolved AndAlso colTicket_Features.Item(0).Status <> Enumeration.PMStatus.OnHold Then
            imgFlag.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "flag_red.gif"
            imgFlag.Attributes.Add("Title", "Delayed Ticket")
        Else
            imgFlag.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "spacer.gif"
        End If

        If colTicket_Features.Item(0).Flag Then
            ImageBlueFlag.Visible = True
            ImageBlueFlag.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "flag_blue.gif"
            ImageBlueFlag.Attributes.Add("Title", "Flag Added")
            flag.Checked = True
        End If
        'If hdnPreValueStatus.Value = Enumeration.PMStatus.FeedbackReceived Then
        '    ddlActivityStatus.Items(9).Enabled = True
        'Else
        '    ddlActivityStatus.Items(9).Enabled = False
        'End If

        If CBool(colTicket_Features.Item(0).ShowDueDateFlag) = True Then
            imgDueDate.Visible = True
            imgDueDate.ImageUrl = ConfigurationManager.AppSettings("ImagesURL") & "flag_orange.gif"
            imgDueDate.Attributes.Add("Title", "Due date is near")
        Else
            imgDueDate.Visible = False
        End If

        If hdnPreValueStatus.Value <> Enumeration.PMStatus.Released Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "EnableNewNotes", "IsNewNotesEnabled = true;", True)
        Else
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "DisableNewNotes", "IsNewNotesEnabled = false;", True)
        End If

        If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released Then
            contactsTable.Style.Add("display", "none")
        Else
            contactsTable.Style.Add("display", "inline")
        End If

        If hdnClientID.Value = Portal.BLL.Enumeration.ClientID.Netsolace Then
            ClientContactTR.Visible = False
            trClientContactsOnNotes.Visible = False
        Else
            ClientContactTR.Visible = True
            trClientContactsOnNotes.Visible = True
        End If

        If ddlActivityStatus.SelectedValue = Enumeration.PMStatus.Released Then
            btnAddNotes.Visible = False

            DivDueDateTime.Visible = False
            lblActivityDueDate.Visible = True
            If colTicket_Features.Item(0).DueDate = DateTime.MinValue Then
                lblActivityDueDate.Text = "-"
            Else
                lblActivityDueDate.Text = Functions.IfNull(colTicket_Features.Item(0).DueDate, "-")
            End If
        Else
            If colTicket_Features.Item(0).DueDate = DateTime.MinValue Then

                txtActivityDueDate.Text = "-"
            Else

                txtActivityDueDate.Text = DateTime.Parse(Functions.IfNull(colTicket_Features.Item(0).DueDate, System.DateTime.Now)).ToShortDateString()
            End If
            btnAddNotes.Visible = True
            btnUpdateDueDate.Visible = True
            lblActivityDueDate.Visible = False
            DivDueDateTime.Visible = True
            divStatus.Attributes.Add("style", "display:inline;")
        End If
        hdnDueDate.Value = txtActivityDueDate.Text
        'If (hdnClientID.Value = Portal.BLL.Enumeration.ClientID.Netsolace Or hdnClientID.Value = Portal.BLL.Enumeration.ClientID.EA) Then
        '    dvIsClientFeedback.Visible = True
        'Else
        '    dvIsClientFeedback.Visible = False
        'End If

    End Sub

#End Region

#Region "Render Events"
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

        If Not Page.IsPostBack Then
            pageContent = Functions.RemoveWhitespaceFromHtml(pageContent)
        End If

        writer.Write(pageContent)
    End Sub
#End Region

#Region "Helping Methods"

    Private Sub FillAttachmentsValidations()
        REV_file1.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file1.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file2.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file2.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
        REV_file3.ValidationExpression = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
        REV_file3.ErrorMessage = CStr(ConfigurationManager.AppSettings("AttachmentsErrorMessage"))
    End Sub

    Public Sub BindControl()
        colTicket_Features = PM_Ticket_Features.PM_Ticket_FeaturesGetByID(CType(hdnID.Value, Integer))
        If colTicket_Features.Count > 0 Then
            ddlActivityStatus.SelectedItem.Selected = False
            ddlActivityStatus.SelectedValue = colTicket_Features.Item(0).Status
            If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released Or ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.FeedbackRequested Or ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.ConfirmSolved Then
                UPAssginedto.Visible = False
            Else
                UPAssginedto.Visible = True
            End If
            hdnUserID.Value = colTicket_Features.Item(0).UserID

            ViewState("ClientID") = colTicket_Features.Item(0).ClientID

            ddlAssignedto.DataBind()
            WaitingForUserID = colTicket_Features.Item(0).WaitingForUserID
            ddlAssignedto.SelectedValue = WaitingForUserID
            lblAssignedTo.Text = ddlAssignedto.SelectedItem.Text
            hdnLastAssignTo.Value = WaitingForUserID
            hdnWaitingFor.Value = WaitingForUserID
            hdnAssignTo.Value = WaitingForUserID
            hdnAssignToValue.Value = WaitingForUserID
            ddlReleases.DataBind()
            'lblRelease.Text = ddlReleases.SelectedItem.Text
            ddlReleases.SelectedValue = colTicket_Features.Item(0).ReleaseID
            hdnReleaseID.Value = colTicket_Features.Item(0).ReleaseID
            hdnReleaseName.Value = ddlReleases.SelectedItem.Text

            chkDueDateShowToClient.Checked = colTicket_Features.Item(0).DueDateShowToClient
            hdnPreValueStatus.Value = colTicket_Features.Item(0).Status
            'chkIsClientFeedback.Checked = colTicket_Features.Item(0).IsFeedbackRequired
            'hdnIsFeedBackRequired.Value = colTicket_Features.Item(0).IsFeedbackRequired
            If colTicket_Features.Item(0).Status = Enumeration.PMStatus.ConfirmSolved Then
                ddlAssignedto.Enabled = False
            Else
                ddlAssignedto.Enabled = True
            End If

        End If

    End Sub

    Private Sub SaveTicket(ByVal PMStatu As Portal.BLL.Enumeration.PMStatus)
        'If chkIsClientFeedback.Checked Then


        '    If SOWrev.Checked Then
        '        PublicNotes.Append(SOWrev.Text.Trim & vbCrLf & vbCrLf  & "<br/><br/>")
        '    ElseIf RadioButton1.Checked Then
        '        PublicNotes.Append(RadioButton1.Text.Trim & vbCrLf & vbCrLf & "<br/><br/>")

        '    ElseIf RadioButton3.Checked And chkIsClientFeedback.Checked Then
        '        PublicNotes.Append(RadioButton3.Text.Trim & vbCrLf & vbCrLf & "<br/><br/>")

        '    End If
        'End If
        If rdoPrivate.Checked Then
            PrivateNotes.Append(txtNotes.Value.Trim & vbCrLf & vbCrLf & "<br/>" )
        Else
            PublicNotes.Append(txtNotes.Value.Trim & vbCrLf & vbCrLf & "<br/>")
        End If


        If hdnIsListChanged.Value = 1 Then
            UpdateUsers()
        End If

        If ddlReleases.SelectedValue <> hdnPrevReleaseId.Value Then
            UpdateRelease()
        End If

        If hdnIsAssigntoChanged.Value = 1 Then
            If hdnLastAssignTo.Value <> hdnWaitingFor.Value And (ddlActivityStatus.SelectedValue <> Enumeration.PMStatus.FeedbackRequested Or ddlActivityStatus.SelectedValue <> Enumeration.PMStatus.ConfirmSolved) Then
                UpdateAssignedTo(False)
            Else
                UpdateAssignedTo(True)
            End If
        End If

        If hdnPreValueStatus.Value <> ddlActivityStatus.SelectedValue Then
            UpdateStatus()
        End If

        Dim intNewNotesID As Integer = 0
        Dim ObjNotes As PM_Notes
        Dim IsPublic As Boolean = False
        ObjNotes = New PM_Notes()

        With ObjNotes
            If Not String.IsNullOrEmpty(PublicNotes.ToString) AndAlso Not String.IsNullOrEmpty(PrivateNotes.ToString) Then
                If rdoPrivate.Checked Then
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = PublicNotes.ToString
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = "00:00:00"
                    .Type = Enumeration.TicketsNotesType.PublicNote
                    intNewNotesID = .Notes_Add()

                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = PrivateNotes.ToString
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue
                    .Type = Enumeration.TicketsNotesType.PrivateNote
                    .IsFeedbackRequired = chkIsClientFeedback.Checked

                    IsPublic = True
                    intNewNotesID = .Notes_Add()
                    Try
                        If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))

                    Catch ex As Exception

                    End Try

                Else
                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = PrivateNotes.ToString
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = "00:00:00"
                    .Type = Enumeration.TicketsNotesType.PrivateNote
                    intNewNotesID = .Notes_Add()

                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = PublicNotes.ToString
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue
                    .Type = Enumeration.TicketsNotesType.PublicNote
                    .IsFeedbackRequired = chkIsClientFeedback.Checked
                    IsPublic = True
                    intNewNotesID = .Notes_Add()
                    Try
                        If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))

                    Catch ex As Exception

                    End Try

                End If
            Else
                If Not String.IsNullOrEmpty(PublicNotes.ToString) Then
                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    strStatusEmailDescription = " has been updated"
                    .Notes = PublicNotes.ToString
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue
                    .Type = Enumeration.TicketsNotesType.PublicNote
                    .IsFeedbackRequired = chkIsClientFeedback.Checked
                    IsPublic = True
                    intNewNotesID = .Notes_Add()
                    If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))
                End If

                If Not String.IsNullOrEmpty(PrivateNotes.ToString) Then
                    ObjNotes = New PM_Notes()
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = PrivateNotes.ToString
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .IsByAdmin = 1
                    .TimeSpent = ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue
                    .Type = Enumeration.TicketsNotesType.PrivateNote
                    .IsFeedbackRequired = chkIsClientFeedback.Checked
                    IsPublic = False
                    intNewNotesID = .Notes_Add()
                    Try
                        If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))
                    Catch ex As Exception

                    End Try

                End If
            End If

            If intNewNotesID > 0 Then
                Dim DirectoryName As String = hdnID.Value & "\" & Functions.GetDateTimeUniqueString()

                Dim isReleaseVal As String = IsRelease.Value.Substring(0, 4)                     ' Uncomment if exception still exists. 
                If (isReleaseVal = "True") Then
                    IsRelease.Value = "True"
                Else
                    IsRelease.Value = "False"
                End If

                If IsRelease.Value = True Then
                    DirectoryName = "Ftr" & DirectoryName
                Else
                    DirectoryName = "Tkt" & DirectoryName
                End If
                .NotesID = intNewNotesID
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
                    .SaveAttachmentsTelerik(DirectoryName, fileuTel1, Type)
                End If
                If Not fileuTel2 Is Nothing Then
                    .SaveAttachmentsTelerik(DirectoryName, fileuTel2, Type1)
                End If
                If Not fileuTel3 Is Nothing Then
                    .SaveAttachmentsTelerik(DirectoryName, fileuTel3, Type2)
                End If
                hdnTimeSpent.Value = "00:00:00"

                rptrNotes.DataSourceID = odsNotes.ID
                rptrNotes.DataBind()

                hdnPrevReleaseId.Value = ddlReleases.SelectedValue
            End If
        End With

        hdnIsListChanged.Value = 0
        UpdatePanel3.Update()
        txtClientUserSearch.Text = ""
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideAssigntoValidation", "HideAssigntoValidation();", True)

        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub SendEmailToUsersOnEdit(ByVal IsPublicNote As Boolean, ByVal strDescription As String)

        Dim objDBAccess As DBAccess = New DBAccess()
        Dim dtUsers As DataTable = Nothing
        Dim FranmailUserName As String = String.Empty
        Dim i As Integer = 0
        Dim strStatus As String = ""

        objDBAccess.AddParameter("@TicketFeatureID", hdnID.Value)
        dtUsers = objDBAccess.ExecuteDataTable("PM_Ticket_Features_GetAllUsersForEmail")

        strStatus = GetStatusCaption(hdnStatus.Value)

        Dim strPriority As String = ""
        If Me.ImgPriority.ImageUrl.ToLower().Contains("high") Then
            strPriority = "High"
        ElseIf Me.ImgPriority.ImageUrl.ToLower().Contains("low") Then
            strPriority = "Low"
        ElseIf Me.ImgPriority.ImageUrl.ToLower().Contains("spacer") Then
            strPriority = "Normal"
        End If
        Dim subject As String = "Updated Netsolace Portal Ticket #" & hdnID.Value & ": " & lblActivitySubject.Text

        For i = 0 To dtUsers.Rows.Count - 1
            If IsPublicNote Then 'Send email to all contacts 
                If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Netsolace Then 'Netsolace Contacts
                    If dtUsers.Rows(i)("ID") <> Session("AdminID") Then
                        PM_Ticket_Features.SendMailToNetsolaceContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), "", subject, strDescription, hdnID.Value, Me.lblActivitySubject.Text.Trim(), strStatus, IIf(Me.txtActivityDueDate.Text = Nothing, Me.lblActivityDueDate.Text, Me.txtActivityDueDate.Text), strPriority, Me.lblActivityType.Text, Me.lblClientName.Text, Me.lblCategoryName.Text)
                    End If
                End If
            Else  'Send only to Netsolace contacts
                If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Netsolace Then 'Netsolace Contacts
                    If dtUsers.Rows(i)("ID") <> Session("AdminID") Then
                        PM_Ticket_Features.SendMailToNetsolaceContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), "", subject, strDescription, hdnID.Value, Me.lblActivitySubject.Text.Trim(), strStatus, IIf(Me.txtActivityDueDate.Text = Nothing, Me.lblActivityDueDate.Text, Me.txtActivityDueDate.Text), strPriority, Me.lblActivityType.Text, Me.lblClientName.Text, Me.lblCategoryName.Text)
                    End If
                End If
            End If
        Next
        dtUsers.Dispose()
    End Sub


    Protected Sub SendEmailToUsers(ByVal IsPublicNote As Boolean, ByVal strDescription As String)

        Dim objDBAccess As DBAccess = New DBAccess()
        Dim dtUsers As DataTable = Nothing
        Dim FranmailUserName As String = String.Empty
        Dim i As Integer = 0
        Dim strStatus As String = ""

        objDBAccess.AddParameter("@TicketFeatureID", hdnID.Value)
        dtUsers = objDBAccess.ExecuteDataTable("PM_Ticket_Features_GetAllUsersForEmail")

        strStatus = GetStatusCaption(hdnStatus.Value)

        Dim strPriority As String = ""
        If Me.ImgPriority.ImageUrl.ToLower().Contains("high") Then
            strPriority = "High"
        ElseIf Me.ImgPriority.ImageUrl.ToLower().Contains("low") Then
            strPriority = "Low"
        ElseIf Me.ImgPriority.ImageUrl.ToLower().Contains("spacer") Then
            strPriority = "Normal"
        End If
        Dim subject As String = "Updated Netsolace Portal Ticket #" & hdnID.Value & ": " & lblActivitySubject.Text
        Dim Action As String = ""
        For i = 0 To dtUsers.Rows.Count - 1
            If IsPublicNote Then 'Send email to all contacts 

                If Me.chkIsClientFeedback.Checked Then
                    If Me.SOWrev.Checked Then
                        Action = "SOW ready for review/approval"
                        subject = "Action Required - Netsolace Portal Ticket #" + hdnID.Value
                    ElseIf Me.RadioButton1.Checked Then
                        Action = "Question/ feedback needed"
                        subject = "Action Required - Netsolace Portal Ticket #" + hdnID.Value
                    Else
                        subject = "Status Update - Netsolace Portal Ticket #" + hdnID.Value
                        'ElseIf Me.RadioButton3.Checked Then
                        '    Action = "  "
                    End If
                End If

                If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Client Then 'Client Contacts
                    PM_Ticket_Features.SendMailToClientContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), Session("Email"), Session("AdminName"), "", subject, strDescription, hdnID.Value, Me.lblActivitySubject.Text.Trim(), IIf(strStatus.ToLower = "in qa phase", "In Development Phase", strStatus), IIf(chkDueDateShowToClient.Checked, Me.txtActivityDueDate.Text, IIf(strStatus.ToLower = "completed", "-", "To Be Determined")), strPriority, Me.lblActivityType.Text, Me.lblClientName.Text, Me.lblCategoryName.Text, False, IIf(dtUsers.Rows(i)("AreaDeveloperId") <> 0, "<a href=""" & dtUsers.Rows(i)("Link") & """>" & dtUsers.Rows(i)("Link") & "</a>", ""), IIf(dtUsers.Rows(i)("AreaDeveloperId") <> 0, dtUsers.Rows(i)("Link"), ""), IIf(dtUsers.Rows(i)("AreaDeveloperId") <> 0, True, False), Action)
                Else
                    PM_Ticket_Features.SendMailToNetsolaceContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), "", subject, strDescription, hdnID.Value, Me.lblActivitySubject.Text.Trim(), strStatus, IIf(Me.txtActivityDueDate.Text = Nothing, Me.lblActivityDueDate.Text, Me.txtActivityDueDate.Text), strPriority, Me.lblActivityType.Text, Me.lblClientName.Text, Me.lblCategoryName.Text, Action)
                End If
                'If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Netsolace Then 'Netsolace Contacts
                '    If dtUsers.Rows(i)("ID") <> Session("AdminID") Then

                '    End If
                'End If

                'PM_Ticket_Features.SendMailToNetsolaceContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), "", _
                '                                      subject, _
                '                                      strDescription, _
                '                                      hdnID.Value, _
                '                                      Me.lblActivitySubject.Text.Trim(), _
                '                                      strStatus, _
                '                                      IIf(Me.txtActivityDueDate.Text = Nothing, Me.lblActivityDueDate.Text, Me.txtActivityDueDate.Text), _
                '                                      strPriority, _
                '                                      Me.lblActivityType.Text, _
                '                                      Me.lblClientName.Text, _
                '                                      Me.lblCategoryName.Text, Action)
            Else  'Send only to Netsolace contacts
                If dtUsers.Rows(i)("Type") = Enumeration.ContactsType.Netsolace Then 'Netsolace Contacts
                    If dtUsers.Rows(i)("ID") <> Session("AdminID") Then
                        PM_Ticket_Features.SendMailToNetsolaceContacts(dtUsers.Rows(i)("Name"), dtUsers.Rows(i)("Email"), "", subject, strDescription, hdnID.Value, Me.lblActivitySubject.Text.Trim(), strStatus, IIf(Me.txtActivityDueDate.Text = Nothing, Me.lblActivityDueDate.Text, Me.txtActivityDueDate.Text), strPriority, Me.lblActivityType.Text, Me.lblClientName.Text, Me.lblCategoryName.Text, Action)

                    End If
                End If
            End If
        Next
        dtUsers.Dispose()
    End Sub

    Private Function CheckValidityEmail(ByVal strEmail As String) As Boolean
        If strEmail <> Nothing AndAlso Functions.IsValidEmail(strEmail) AndAlso CStr(HttpContext.Current.Session("Email")) <> Nothing AndAlso Functions.IsValidEmail(CStr(HttpContext.Current.Session("Email"))) Then
            Return True
        End If
        Return False
    End Function

    Dim strClientUsers As New StringBuilder
    Private Sub UpdateUsers()

        Dim strClientContacts As New StringBuilder
        Dim PrevClientChecked As New StringBuilder
        Dim PrevUserChecked As New StringBuilder

        strClientContacts.Append("")
        strClientUsers.Append("")
        PrevClientChecked.Append("")
        PrevUserChecked.Append("")
        Dim strClientContactID As String = ""
        Dim strClientUserID As String = ""
        Dim strClientPrevChecked As String = ""
        Dim strClientPrevChecked2 As String = ""
        Dim strUserPrevChecked As String = ""


        Dim strBeforeClientContactID As New StringBuilder
        Dim strAfterClientContactID As New StringBuilder
        Dim strBeforeUserID As New StringBuilder
        Dim strAfterUserID As New StringBuilder

        Dim HasChangeUser As Boolean = False
        Dim HasChangeClientContact As Boolean = False

        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim k As Integer = 0

        For i = 0 To rptCC.Items.Count - 1
            Dim chkBox As CheckBox = CType(rptCC.Items(i).FindControl("chkCC"), CheckBox)
            If chkBox.Checked = True Then
                j = j + 1
                strClientContactID = chkBox.Attributes("ClientContactID").ToString()

                If strClientContacts.ToString = "" Then
                    strClientContacts.Append(strClientContactID )
                Else
                    strClientContacts.Append(",".ToString + strClientContactID )
                End If


                If strAfterClientContactID.ToString = "" Then
                    strAfterClientContactID.Append(j & ". " & chkBox.ToolTip + vbCrLf)
                Else
                    strAfterClientContactID.Append(j & ". " & chkBox.ToolTip + vbCrLf)
                End If

            End If
            strClientPrevChecked = chkBox.Attributes("PrevClientChecked").ToString()
            If CBool(strClientPrevChecked) = True Then
                k = k + 1
                If strBeforeClientContactID.ToString = "" Then
                    strBeforeClientContactID.Append(k & ". " & chkBox.ToolTip + vbCrLf  )
                Else
                    strBeforeClientContactID.Append(k & ". " & chkBox.ToolTip + vbCrLf )
                End If
            End If

            If chkBox.Checked <> CBool(strClientPrevChecked) Then
                HasChangeClientContact = True
            End If

        Next

        j = 0
        k = 0
        For i = 0 To rptUC.Items.Count - 1
            Dim chkBox As HtmlInputCheckBox = CType(rptUC.Items(i).FindControl("chkCU"), HtmlInputCheckBox)
            If chkBox.Checked = True Then
                strClientUserID = chkBox.Attributes("ClientUserID").ToString()
                j = j + 1
                If strClientUsers.ToString = "" Then
                    strClientUsers.Append(strClientUserID)
                Else
                    strClientUsers.Append(",".ToString + strClientUserID)
                End If

                If strAfterUserID.ToString = "" Then
                    strAfterUserID.Append(j & ". " & chkBox.Attributes("title") + vbCrLf & "<br/>")
                Else
                    strAfterUserID.Append(j & ". " & chkBox.Attributes("title") + vbCrLf & "<br/>")
                End If
            End If
            strUserPrevChecked = chkBox.Attributes("PrevUserChecked").ToString()
            If CBool(strUserPrevChecked) = True Then
                k = k + 1
                If strBeforeUserID.ToString = "" Then
                    strBeforeUserID.Append(k & ". " & chkBox.Attributes("title") + vbCrLf & "<br/>")
                Else
                    strBeforeUserID.Append(k & ". " & chkBox.Attributes("title") + vbCrLf & "<br/>")
                End If
            End If
            If chkBox.Checked <> CBool(strUserPrevChecked) Then
                HasChangeUser = True
            End If
        Next
        If strBeforeClientContactID.ToString = "" Then
            strBeforeClientContactID.Append("No Recipient")
        End If
        If strAfterClientContactID.ToString = "" Then
            strAfterClientContactID.Append("No Recipient")
        End If
        If strBeforeUserID.ToString = "" Then
            strBeforeUserID.Append("No Recipient")
        End If
        If strAfterUserID.ToString = "" Then
            strAfterUserID.Append("No Recipient")
        End If

        Dim strBodyForClientContacts As String = ""
        strBodyForClientContacts = " === Ticket recipient list updated. ===" + vbCrLf + vbCrLf &"<br/>"
        'strBodyForClientContacts += " --------------------------" + vbCrLf 
        'strBodyForClientContacts += " Previous Recipient(s):" + vbCrLf 
        'strBodyForClientContacts += " --------------------------" + vbCrLf  &"<br/>"
        'strBodyForClientContacts += strBeforeClientContactID.ToString + vbCrLf &"<br/>"
        strBodyForClientContacts += " ---------------------" + vbCrLf  &"<br/>"
        strBodyForClientContacts += " New Recipient(s):" + vbCrLf  &"<br/>"
        strBodyForClientContacts += " ---------------------" + vbCrLf &"<br/>"
        strBodyForClientContacts += strAfterClientContactID.ToString &"<br/>"
        Dim strBodyForUsers As String = " === Ticket recipient list updated. ===" + vbCrLf + vbCrLf &"<br/>"
        'strBodyForUsers += " --------------------------" + vbCrLf 
        'strBodyForUsers += " Previous Recipient(s):" + vbCrLf 
        'strBodyForUsers += " --------------------------" + vbCrLf &"<br/>"
        'strBodyForUsers += strBeforeUserID.ToString + vbCrLf &"<br/>" 
        strBodyForUsers += " ---------------------" + vbCrLf &"<br/>"
        strBodyForUsers += " New Recipient(s):" + vbCrLf &"<br/>"
        strBodyForUsers += " ---------------------" + vbCrLf &"<br/>"
        strBodyForUsers += strAfterUserID.ToString


        If HasChangeClientContact Then
            PublicNotes.Append(strBodyForClientContacts & vbCrLf & vbCrLf)
            Dim objPM_TicketUsers As New PM_Ticket_Features_Users
            objPM_TicketUsers.PM_Ticket_Features_UsersAddClientContacs(hdnID.Value, strClientContacts.ToString, 0)
            rptCC.DataBind()
            rptClientContacts.DataBind()
        End If

        If HasChangeUser Then
            Dim objPM_TicketUsers As New PM_Ticket_Features_Users
            PrivateNotes.Append(strBodyForUsers & vbCrLf & vbCrLf)
            objPM_TicketUsers.PM_Ticket_Features_UsersAddUsers(hdnID.Value, strClientUsers.ToString, CInt(Session("AdminID")))
            rptUC.DataBind()
            rptUserContacts.DataBind()
        End If

        Dim Assginedto As Integer = ddlAssignedto.SelectedValue
        ddlAssignedto.DataBind()
        If ddlAssignedto.Items.FindByValue(Assginedto) IsNot Nothing Then
            ddlAssignedto.Items.FindByValue(Assginedto).Selected = True
        End If
    End Sub

    Private Sub UpdateAssignedTo(ByVal IsAssignToChanged As Boolean)
        Dim Result As Boolean

        If hdnAssignToValue.Value = 0 Then
            hdnAssignToValue.Value = Enumeration.Users.Project_Manager
            Dim objPM_TicketUsers As New PM_Ticket_Features_Users
            Dim Users() As String = strClientUsers.ToString.Split(",")
            Dim isExists As Boolean = False
            For Each UId As String In Users
                If UId = hdnAssignToValue.Value Then
                    isExists = True
                    Exit For
                End If
            Next

            If isExists Then
                objPM_TicketUsers.PM_Ticket_Features_UsersAddUsers(hdnID.Value, strClientUsers.ToString, CInt(Session("AdminID")))
            Else
                objPM_TicketUsers.PM_Ticket_Features_UsersAddUsers(hdnID.Value, strClientUsers.ToString & "," & hdnAssignToValue.Value, CInt(Session("AdminID")))
            End If

            rptUserContacts.DataBind()
            rptUC.DataBind()
        End If
        Result = PM_Ticket_Features.UpdateAssingTo(CType(hdnID.Value, Integer), hdnAssignToValue.Value)

        If Result Then
            If Not IsAssignToChanged Then
                PrivateNotes.Append("Ticket has been Assigned to " & hdnAssignToText.Value & vbCrLf & vbCrLf)
            End If
            WaitingForUserID = hdnAssignToValue.Value
            hdnWaitingFor.Value = WaitingForUserID
            lblAssignedTo.Text = hdnAssignToText.Value
            ddlAssignedto.DataBind()
            'ddlAssignedto.SelectedValue = hdnAssignToValue.Value
            If ddlAssignedto.Items.FindByValue(ddlAssignedto.SelectedValue) IsNot Nothing AndAlso ddlAssignedto.SelectedValue <> 0 Then
                ddlAssignedto.SelectedValue = hdnAssignToValue.Value
            End If
            upAssignto.Update()
            hdnIsAssigntoChanged.Value = 0
        End If
    End Sub

    Dim strStatusEmailDescription As String = String.Empty
    Private Sub UpdateStatus()
        If ddlActivityStatus.SelectedValue <> 0 Then
            Dim Result As Boolean
            Dim IsPublic As Boolean = False
            Dim ObjNotes As PM_Notes = New PM_Notes()

            If ddlActivityStatus.SelectedValue = Enumeration.PMStatus.FeedbackRequested Or ddlActivityStatus.SelectedValue = Enumeration.PMStatus.ConfirmSolved Then
                Result = PM_Ticket_Features.UpdateStatus(CType(hdnID.Value, Integer), CType(ddlActivityStatus.SelectedValue, Integer), hdnWaitingFor.Value)
            Else
                Result = PM_Ticket_Features.UpdateStatus(CType(hdnID.Value, Integer), CType(ddlActivityStatus.SelectedValue, Integer), ddlAssignedto.SelectedValue)
            End If

            If Result Then
                If hdnPreValueStatus.Value <> Enumeration.PMStatus.Released AndAlso ddlActivityStatus.SelectedValue = Enumeration.PMStatus.Released Then
                    With ObjNotes
                        .Ticket_Feature_ID = CInt(hdnID.Value)
                        .Notes = "Ticket has been completed on " & DateTime.Now.ToShortDateString()
                        strStatusEmailDescription = " has been completed"
                        .SubmittedBy = CType(Session("AdminID"), Integer)
                        .DateEntered = DateTime.Now
                        .TimeSpent = "00:00:00"
                        .IsByAdmin = 1
                        .Type = Portal.BLL.Enumeration.TicketsNotesType.PublicNote
                        If .Notes_Add() > 0 Then
                            rptrNotes.DataSourceID = odsNotes.ID
                            rptrNotes.DataBind()
                        End If

                        IsPublic = True
                        'rptUserContacts.DataBind()
                        lblActivityStatus.Text = GetStatusCaption(hdnStatus.Value)
                        hdnPreValueStatus.Value = Enumeration.PMStatus.Released
                        hdnStatus.Value = Enumeration.PMStatus.Released
                        If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, strStatusEmailDescription)
                    End With
                ElseIf hdnPreValueStatus.Value = Enumeration.PMStatus.Released AndAlso ddlActivityStatus.SelectedValue <> Enumeration.PMStatus.Released Then
                    With ObjNotes
                        .Ticket_Feature_ID = CInt(hdnID.Value)
                        .Notes = "Ticket has been reopened on " & DateTime.Now.ToShortDateString() & " with Status " & ddlActivityStatus.SelectedItem.Text
                        strStatusEmailDescription = " has been reopened"
                        .SubmittedBy = CType(Session("AdminID"), Integer)
                        .DateEntered = DateTime.Now
                        .TimeSpent = "00:00:00"
                        .IsByAdmin = 1
                        .Type = Portal.BLL.Enumeration.TicketsNotesType.PrivateNote
                        If .Notes_Add() > 0 Then
                            rptrNotes.DataSourceID = odsNotes.ID
                            rptrNotes.DataBind()
                        End If
                        BtnReopen.Visible = False
                        lblActivityStatus.Text = GetStatusCaption(hdnStatus.Value)
                        hdnPreValueStatus.Value = Enumeration.PMStatus.InProgress
                        hdnStatus.Value = Enumeration.PMStatus.InProgress
                        If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, strStatusEmailDescription)
                    End With
                Else
                    strStatusEmailDescription = " has been updated"
                    If rdoPrivate.Checked Then
                        PrivateNotes.Append("</br>Ticket has been updated with Status " & ddlActivityStatus.SelectedItem.Text & vbCrLf & vbCrLf )

                    Else
                        If ddlActivityStatus.SelectedValue = Enumeration.PMStatus.QAPhase Then
                            PublicNotes.Append("</br>Ticket has been updated with Status In QA Phase" & vbCrLf & vbCrLf)
                        Else
                            PublicNotes.Append("</br>Ticket has been updated with Status " & ddlActivityStatus.SelectedItem.Text & vbCrLf & vbCrLf)
                        End If
                    End If
                    hdnPreValueStatus.Value = ddlActivityStatus.SelectedValue
                    hdnStatus.Value = ddlActivityStatus.SelectedValue
                    If hdnStatus.Value = Enumeration.PMStatus.QAPhase Then
                        Dim objPM_TicketUsers As New Portal.BLL.PM.PM_Ticket_Features_Users
                        objPM_TicketUsers.PM_Ticket_Features_UsersAddQAUsers(hdnID.Value, Enumeration.Users.Ijaz_Aslam & "," & Enumeration.Users.Sohail_Qadeer_Abbasi)
                        ddlAssignedto.DataBind()
                        rptUserContacts.DataBind()
                        rptUC.DataBind()
                    End If
                End If

                lblActivityStatus.Text = GetStatusCaption(hdnStatus.Value)

                If ddlActivityStatus.SelectedValue = Enumeration.PMStatus.ConfirmSolved Or ddlActivityStatus.SelectedValue = Enumeration.PMStatus.FeedbackRequested Then
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "HideValidation", "HideValidations();", True)
                End If

                If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released Or ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.FeedbackRequested Or ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.ConfirmSolved Then
                    UPAssginedto.Visible = False
                Else
                    UPAssginedto.Visible = True
                End If
                If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released Then
                    If Portal.BLL.PM.PM_Ticket_Features.CheckToComplete(hdnID.Value, Session("AdminID")) > 0 Then
                        BtnReopen.Visible = True
                    End If
                Else
                    BtnReopen.Visible = False
                End If

                If ddlActivityStatus.SelectedValue <> Portal.BLL.Enumeration.PMStatus.Released AndAlso Portal.BLL.PM.PM_Ticket_Features.CheckToComplete(hdnID.Value, Session("AdminID")) > 0 Then
                    SpanCompleted.Visible = True
                Else
                    SpanCompleted.Visible = False
                End If
                UPSpanCompleted.Update()
                UpdatePanel3.Update()
                upContactsTable.Update()
                If hdnStatus.Value = 5 Then
                    spnEditTicketDetail.Visible = False
                End If
                upBtnEditTicketDetail.Update()
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "DivNotesDisplay_onload", "DivNotesDisplay_onload();", True)
            End If
        End If
    End Sub

    Private Sub LoadRelease()
        If IsRelease.Value = True And hdnReleaseID.Value <> 0 Then
            Dim objReleases As Portal.BLL.PM.PM_Releases = New Portal.BLL.PM.PM_Releases()
            Dim colReleases As New List(Of Portal.BLL.PM.PM_Releases)()
            colReleases = Portal.BLL.PM.PM_Releases.PM_ReleasesGetByID(hdnReleaseID.Value)
            If colReleases.Count > 0 Then
                Me.lblReleaseName.Text = colReleases.Item(0).Name
            End If
            If (colReleases.Item(0).NewReleaseDate.ToShortDateString() <> "1/1/1900") Then
                Me.hdnReleaseDueDate.Value = colReleases.Item(0).NewReleaseDate.ToShortDateString()
            Else
                Me.hdnReleaseDueDate.Value = colReleases.Item(0).ReleaseDate.ToShortDateString()
            End If
        Else
            Me.hdnReleaseDueDate.Value = ""
        End If

    End Sub

    Private Sub UpdateRelease()
        Dim Result As Boolean
        If ddlReleases.SelectedValue <> 0 Then
            Result = PM_Ticket_Features.UpdateReleaseID(CType(hdnID.Value, Integer), CType(ddlReleases.SelectedValue, Integer))
            If Result Then
                If hdnReleaseName.Value = "None" Then
                    PublicNotes.Append("Ticket has moved to " & ddlReleases.SelectedItem.Text & " Release" & vbCrLf & vbCrLf)
                Else
                    PublicNotes.Append("Ticket has moved from " & hdnReleaseName.Value & " Release to " & ddlReleases.SelectedItem.Text & " Release" & vbCrLf & vbCrLf)
                End If
                Me.lblReleaseName.Text = ddlReleases.SelectedItem.Text
                hdnReleaseName.Value = ddlReleases.SelectedItem.Text
                hdnReleaseID.Value = ddlReleases.SelectedValue
                IsRelease.Value = "True"
            End If
            UpdatePanel3.Update()
            LoadRelease()
        Else
            PM_Ticket_Features.UpdateReleaseID(CType(hdnID.Value, Integer), ddlReleases.SelectedValue)
        End If
    End Sub
    Private Function GetStatusCaption(ByVal StatusId As Integer) As String
        Select Case StatusId
            Case Enumeration.PMStatus.InProgress
                Return "In Progress"
            Case Enumeration.PMStatus.ConfirmSolved
                Return "Confirm Solved"
            Case Enumeration.PMStatus.Delayed
                Return "Delayed"
            Case Enumeration.PMStatus.DesignPhase
                Return "In Design Phase"
            Case Enumeration.PMStatus.DevelopmentPhase
                Return "In Development Phase"
            Case Enumeration.PMStatus.FeedbackReceived
                Return "Feedback Received"
            Case Enumeration.PMStatus.FeedbackRequested
                Return "Client's Feedback Requested"
            Case Enumeration.PMStatus.NotStarted
                Return "Not Started"
            Case Enumeration.PMStatus.OnHold
                Return "On Hold"
            Case Enumeration.PMStatus.Pending
                Return "Pending"
            Case Enumeration.PMStatus.QAPhase
                Return "In QA Phase"
            Case Enumeration.PMStatus.Released
                Return "Completed"
            Case Enumeration.PMStatus.RequirementGathering
                Return "In Requirement Gathering"
            Case Enumeration.PMStatus.WaitingFor
                Return "Waiting For"


            Case Enumeration.PMStatus.UATPhase
                Return "UAT Phase"
            Case Enumeration.PMStatus.LocalProductionCheckout
                Return "Local Production Checkout"
            Case Enumeration.PMStatus.Readytogolive
                Return "Ready to go live"
        End Select

        Return Nothing
    End Function
#End Region

#Region "Repeater Events"

    Protected Sub rptrUsersTimeSpent_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrUsersTimeSpent.ItemDataBound


        If (e.Item.ItemType = ListItemType.Item) OrElse (e.Item.ItemType = ListItemType.AlternatingItem) Then
            Dim span As String = CType(e.Item.FindControl("lblUsersTotalTimeSpent"), Label).Text
            Dim objTimeSpent As TimeSpan = New TimeSpan(Integer.Parse(span.Split(":")(0)), Integer.Parse(span.Split(":")(1)), 0)
            hdnTimeSpent.Value = objTimeSpent.ToString()

            Dim strHours As String
            Dim strMin As String

            ''To show Total Time in Format HHH:MM
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
            span = strHours & ":" & strMin
            CType(e.Item.FindControl("lblUsersTotalTimeSpent"), Label).Text = span

        End If

    End Sub
    Protected Sub rptrNotes_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrNotes.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rptrAttachments"), Repeater)
            If Not btnAddNotes.Visible Then
                Dim btnpub As Button = CType(e.Item.FindControl("Pub"), Button)
                btnpub.Visible = False
                Dim btnpri As Button = CType(e.Item.FindControl("Pri"), Button)
                btnpri.Visible = False
            End If
            If rpt.Items.Count <= 0 Then
                rpt.Visible = False
            End If

            Dim span As String = CType(e.Item.FindControl("lblTimeSpent"), Label).Text
            Dim objTimeSpent As TimeSpan = New TimeSpan(Integer.Parse(span.Split(":")(0)), Integer.Parse(span.Split(":")(1)), 0).Add(TimeSpan.Parse(hdnTimeSpent.Value))
            hdnTimeSpent.Value = objTimeSpent.ToString()

            Dim strHours As String
            Dim strMin As String

            ''To show Total Time in Format HHH:MM
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
            lblTotalTimeSpent.Text = strHours & ":" & strMin
            lblTotalTimeSpentOnTicket.Text = " Total Time Spent on Ticket (HH:MM) " + strHours & ":" & strMin


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
            Dim Type As Boolean = DataBinder.Eval(e.Item.DataItem, "Type")
            If (Type = False) Then
                Dim btn As Button = CType(e.Item.FindControl("Pub"), Button)
                btn.Visible = False
            End If
            If (Type = True) Then
                Dim btn As Button = CType(e.Item.FindControl("Pri"), Button)
                btn.Visible = False
            End If

        End If

    End Sub

    Protected Sub rptrTicket_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrTicket.ItemDataBound
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim rptrTicketAttachments As Repeater = CType(e.Item.FindControl("rptrTicketAttachments"), Repeater)
            If rptrTicketAttachments.Items.Count = 0 Then
                rptrTicketAttachments.Visible = False
            End If
        End If
    End Sub

    Protected Sub rptUC_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptUC.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim chkbox As HtmlInputCheckBox = CType(e.Item.FindControl("chkCU"), HtmlInputCheckBox)
            Dim lbl As HtmlControl = CType(e.Item.FindControl("lblUserName"), HtmlControl)

            Dim chkCU As HtmlControl = CType(e.Item.FindControl("chkCU"), HtmlControl)
            chkCU.Attributes.Add("OnClick", "OnUserListChanged('" & e.Item.DataItem("UserID") & "');")

            If WaitingForUserID = 0 Then
                If ddlAssignedto.SelectedValue <> Nothing Then
                    WaitingForUserID = ddlAssignedto.SelectedValue
                End If
            End If

            'Insert the user Access of the contact who is adding the ticket and make him disable.
            If e.Item.DataItem("UserID") = hdnUserID.Value Then
                chkbox.Checked = True
                chkbox.Disabled = True
                lbl.Disabled = True
            End If

            'Disable the User to whom ticket is assign to. 
            'If ddlActivityStatus.SelectedValue = Enumeration.PMStatus.FeedbackRequested Or ddlActivityStatus.SelectedValue = Enumeration.PMStatus.ConfirmSolved Then
            '    If e.Item.DataItem("UserID") = WaitingForUserID Then
            '        chkbox.Disabled = True
            '        lbl.Disabled = True
            '    End If
            'End If

            If ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released Then
                If Portal.BLL.PM.PM_Ticket_Features.CheckToComplete(hdnID.Value, Session("AdminID")) > 0 Then
                    BtnReopen.Visible = True
                End If
            End If
        End If
    End Sub

    Protected Sub rptCC_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptCC.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim chkbox As CheckBox = CType(e.Item.FindControl("chkCC"), CheckBox)
            If e.Item.DataItem("ClientContactID") = hdnClientContactID.Value Then
                chkbox.Enabled = False
            End If
        End If
    End Sub

#End Region

#Region "Button Events"
    Protected Sub btnSaveDueDateReason_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveDueDateReason.Click
        Dim strDescription As String = String.Empty
        Dim ObjNotes As PM_Notes = New PM_Notes()
        Portal.BLL.PM.PM_Ticket_Features.UpdateDueDateShowToClient(hdnID.Value, chkDueDateShowToClient.Checked)

        If chkDueDateShowToClient.Checked Then
            PM_Ticket_Features.UpdateDueDate(CType(hdnID.Value, Integer), CType(txtActivityDueDate.Text, Date))
        End If
        With ObjNotes
            .Ticket_Feature_ID = CInt(hdnID.Value)
            If chkDueDateShowToClient.Checked Then
                .Notes = "Due Date " & txtActivityDueDate.Text & " has been finalized for this ticket." & vbCrLf & vbCrLf & txtReason.Text
            Else
                .Notes = "Due Date has been set as ""To Be Determined"" for client." & vbCrLf & vbCrLf & txtReason.Text
            End If
            strDescription = " has been updated"
            .SubmittedBy = CType(Session("AdminID"), Integer)
            .DateEntered = DateTime.Now
            .TimeSpent = "00:00:00"
            .IsByAdmin = 1
            .Type = Portal.BLL.Enumeration.TicketsNotesType.PublicNote
            If .Notes_Add() > 0 Then
                rptrNotes.DataSourceID = odsNotes.ID
                rptrNotes.DataBind()
            End If
        End With
        txtReason.Text = ""
        If chkIsClientFeedback.Checked Then
            If chkIsClientFeedback.Checked Then SendEmailToUsers(True, strDescription)
        End If
        Response.Redirect(Request.RawUrl)

    End Sub

    Protected Sub btnSaveDueDateExtension_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveDueDateExtension.Click
        Dim Result As Boolean
        Dim IsPublic As Boolean = False
        Dim strDescription As String = String.Empty
        Dim ObjNotes As PM_Notes = New PM_Notes()
        Result = PM_Ticket_Features.UpdateDueDate(CType(hdnID.Value, Integer), CType(txtActivityDueDate.Text, Date))
        If Result Then
            If chkDueDateShowToClient.Checked Then
                With ObjNotes
                    .Ticket_Feature_ID = CInt(hdnID.Value)
                    .Notes = "Due Date Changed From " & hdnDueDate.Value & " To " & txtActivityDueDate.Text & vbCrLf & vbCrLf & "<b>Reason:</b>&nbsp;" & ddlExtensionType.SelectedItem.Text & vbCrLf & vbCrLf & txtExtensionReason.Text
                    strDescription = " has been updated"
                    .SubmittedBy = CType(Session("AdminID"), Integer)
                    .DateEntered = DateTime.Now
                    .TimeSpent = "00:00:00"
                    .IsByAdmin = 1
                    .Type = Portal.BLL.Enumeration.TicketsNotesType.PublicNote
                    IsPublic = True
                    If .Notes_Add() > 0 Then
                        rptrNotes.DataSourceID = odsNotes.ID
                        rptrNotes.DataBind()
                        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateMessageScript", "ShowUpdateMessage();", True)
                    End If
                    If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, strDescription)

                End With
            End If
        Else
            With ObjNotes
                .Ticket_Feature_ID = CInt(hdnID.Value)
                .Notes = "Due Date Changed From " & hdnDueDate.Value & " To " & txtActivityDueDate.Text & vbCrLf & vbCrLf & "<b>Reason:</b>&nbsp;" & ddlExtensionType.SelectedItem.Text & vbCrLf & vbCrLf & txtExtensionReason.Text
                strDescription = " has been updated"
                .SubmittedBy = CType(Session("AdminID"), Integer)
                .DateEntered = DateTime.Now
                .TimeSpent = "00:00:00"
                .IsByAdmin = 1
                .Type = Portal.BLL.Enumeration.TicketsNotesType.PrivateNote
                IsPublic = False
                If .Notes_Add() > 0 Then
                    rptrNotes.DataSourceID = odsNotes.ID
                    rptrNotes.DataBind()
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "UpdateMessageScript", "ShowUpdateMessage();", True)
                End If
                If chkIsClientFeedback.Checked Then SendEmailToUsers(IsPublic, strDescription)

            End With

        End If

        If CType(hdnDueDate.Value, Date) < CType(txtActivityDueDate.Text, Date) Then
            imgFlag.Visible = False
        End If

        txtExtensionReason.Text = ""
        ddlExtensionType.SelectedValue = 0
        Response.Redirect(Request.RawUrl)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        SaveTicket(ddlActivityStatus.SelectedValue)
    End Sub

    Protected Sub BtnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnClose.Click
        If (ddlActivityStatus.SelectedValue <> Portal.BLL.Enumeration.PMStatus.Released) Then
            ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.Released
            UpdateStatus()
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "BlackDivHide", "BlackDivHide();", True)
        End If
    End Sub

    Protected Sub BtnReopen_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnReopen.Click
        If (ddlActivityStatus.SelectedValue <> Portal.BLL.Enumeration.PMStatus.InProgress) Then
            ddlActivityStatus.SelectedValue = Portal.BLL.Enumeration.PMStatus.InProgress
            UpdateStatus()
            BindControl()
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "BlackDivHide", "BlackDivHide();", True)
        End If
    End Sub

    Protected Sub btnContactsListChanged_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnContactsListChanged.Click
        rptCC.DataBind()
        rptUC.DataBind()
        upAssignto.Update()
        ddlAssignedto.SelectedValue = hdnAssignTo.Value
        hdnWaitingFor.Value = hdnAssignTo.Value
        upWaitingfor.Update()
        hdnIsAssigntoChanged.Value = 0
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
    Protected Sub odsClients_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles odsClients.Selecting
        e.InputParameters.Add("subModuleIds", "" & Portal.BLL.Enumeration.SubModules.PMFullAccess)
    End Sub

#End Region

#Region "DropDown Events"

    Protected Sub ddlExtensionType_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlExtensionType.DataBound
        ddlExtensionType.Items.Insert(0, New ListItem("select reason", 0))
    End Sub
    Protected Sub ddlTicketOwner_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTicketOwner.DataBound
        ddlTicketOwner.Items.Insert(0, New ListItem("Select...", 0))
    End Sub

    Protected Sub ddlReleases_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlReleases.DataBound
        ddlReleases.Items.Insert(0, New ListItem("None", 0))
    End Sub

    Protected Sub ddlAssignedto_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlAssignedto.DataBound
        ddlAssignedto.Items.Insert(0, New ListItem("Please Select...", 0))
    End Sub

#End Region

    Protected Sub btnUpdateTicketDetail_Click(sender As Object, e As EventArgs) Handles btnUpdateTicketDetail.Click

        'Dim objFeturesBLL As New Portal.BLL.PM.PM_Ticket_Features


        'With objFeturesBLL
        '    .ID = Me.hdnID.Value
        '    .Name = Me.txtName.Text.Trim()
        '    '.ReleaseID = Me.ddlReleases.SelectedValue
        '    '.DateEntered = System.DateTime.Now.Date
        '    '.Description = Me.txtDescription.Text
        '    .TypeID = Me.ddlTicketTypes.SelectedValue
        '    .UserID = Session("AdminID")
        '    '.Read = False
        '    '.Status = 0
        '    '.Deleted = False
        '    '.History = False
        '    If Me.txtSowSignedDate.Value = "" Then
        '        .SowSignedDate = Nothing
        '    Else
        '        .SowSignedDate = DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString()
        '    End If
        '    '.SowSignedDate = IIf(Me.txtSowSignedDate.Value = "", DateTime.Now, DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString())
        '    .Priority = Me.ddlPriority.SelectedValue
        '    .CatagoryID = Me.ddlTicketCategories.SelectedValue
        '    .SubCatagoryID = Me.ddlSubCategories.SelectedValue
        '    '.WaitingForUserID = 0
        '    .ClientID = Me.ddlTicketClients.SelectedValue
        '    .AreaDeveloperId = IIf(Me.ddlTicketClients.SelectedValue = Enumeration.ClientID.EA, Me.ddlAreaDeveloper.SelectedValue, 0)
        '    .TicketOwner = ddlTicketOwner.SelectedValue

        '    'Dim Affected As Integer = Portal.BLL.PM.PM_Ticket_Features.PMTicketUpdate(.ID, .Name, .TypeID, .UserID, .SowSignedDate, .Priority, .CatagoryID, .SubCatagoryID, .ClientID, .AreaDeveloperId, .TicketOwner)

        '    '    Dim IsTicketDetailChanged As Boolean = False
        '    '    Dim strBodyTicketDetailChange As String = " === Ticket updated. ===" + vbCrLf + vbCrLf
        '    '    If hdnOldSubject.Value <> Me.txtName.Text.Trim() Then
        '    '        strBodyTicketDetailChange += " Subject changed from : " + """" + hdnOldSubject.Value + """" + " to " + """" + Me.txtName.Text.Trim() + """" + vbCrLf
        '    '        IsTicketDetailChanged = True
        '    '    End If
        '    '    If hdnOldTypeId.Value <> Me.ddlTicketTypes.SelectedValue Then
        '    '        strBodyTicketDetailChange += " Type changed from : " + """" + ddlTicketTypes.Items.FindByValue(hdnOldTypeId.Value).Text + """" + " to " + """" + ddlTicketTypes.SelectedItem.Text + """" + vbCrLf
        '    '        IsTicketDetailChanged = True
        '    '    End If
        '    '    '  If ddlTicketClients.SelectedValue <> Enumeration.ClientID.EA Then
        '    '    If Me.txtSowSignedDate.Value = "" Then
        '    '        If hdnOldSowSignedDate.Value <> Me.txtSowSignedDate.Value Then
        '    '            strBodyTicketDetailChange += " SOW Signed Date changed from : " + """" + IIf(hdnOldSowSignedDate.Value = "", " ", hdnOldSowSignedDate.Value) + """" + " to " + """" + " " + """" + vbCrLf
        '    '            IsTicketDetailChanged = True
        '    '        End If
        '    '    Else
        '    '        If hdnOldSowSignedDate.Value <> DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString() Then
        '    '            strBodyTicketDetailChange += " SOW Signed Date changed from : " + """" + IIf(hdnOldSowSignedDate.Value = "", " ", hdnOldSowSignedDate.Value) + """" + " to " + """" + DateTime.Parse(Me.txtSowSignedDate.Value).ToShortDateString() + """" + vbCrLf
        '    '            IsTicketDetailChanged = True
        '    '        End If
        '    '    End If
        '    '    ' End If

        '    '    If hdnOldPriorityId.Value <> Me.ddlPriority.SelectedValue Then
        '    '        strBodyTicketDetailChange += " Priority changed from : " + """" + ddlPriority.Items.FindByValue(hdnOldPriorityId.Value).Text + """" + " to " + """" + ddlPriority.SelectedItem.Text + """" + vbCrLf
        '    '        IsTicketDetailChanged = True
        '    '    End If
        '    '    If hdnOldClientId.Value <> Me.ddlTicketClients.SelectedValue Then
        '    '        strBodyTicketDetailChange += " Client changed from : " + """" + ddlTicketClients.Items.FindByValue(hdnOldClientId.Value).Text + """" + " to " + """" + ddlTicketClients.SelectedItem.Text + """" + vbCrLf
        '    '        IsTicketDetailChanged = True
        '    '    End If
        '    '    If ddlTicketClients.SelectedValue = Enumeration.ClientID.EA AndAlso hdnOldAreaDeveloperId.Value <> Me.ddlAreaDeveloper.SelectedValue Then
        '    '        If hdnOldAreaDeveloperId.Value <> "0" Then
        '    '            If ddlAreaDeveloper.SelectedItem.Value = "0" Then
        '    '                strBodyTicketDetailChange += " Area Developer changed from : " + """" + ddlAreaDeveloper.Items.FindByValue(hdnOldAreaDeveloperId.Value).Text + """" + " to " + """" + " " + """" + vbCrLf
        '    '            Else
        '    '                strBodyTicketDetailChange += " Area Developer changed from : " + """" + ddlAreaDeveloper.Items.FindByValue(hdnOldAreaDeveloperId.Value).Text + """" + " to " + """" + ddlAreaDeveloper.SelectedItem.Text + """" + vbCrLf
        '    '            End If
        '    '        Else
        '    '            strBodyTicketDetailChange += " Area Developer selected : " + """" + ddlAreaDeveloper.SelectedItem.Text + """" + vbCrLf

        '    '        End If
        '    '        IsTicketDetailChanged = True
        '    '    End If
        '    '    If hdnOldCategoryId.Value <> Me.ddlTicketCategories.SelectedValue Then
        '    '        strBodyTicketDetailChange += " Category changed from : " + """" + hdnOldCategoryValue.Value + """" + " to " + """" + ddlTicketCategories.SelectedItem.Text + """" + vbCrLf
        '    '        IsTicketDetailChanged = True
        '    '    End If

        '    '    If hdnOldsubCategoryId.Value <> Me.ddlSubCategories.SelectedValue Then
        '    '        strBodyTicketDetailChange += "Sub Category changed from : " + """" + hdnOldSubCategoryValue.Value + """" + " to " + """" + ddlSubCategories.SelectedItem.Text + """" + vbCrLf
        '    '        IsTicketDetailChanged = True
        '    '    End If

        '    '    If hndProductOwnerID.Value <> Me.ddlTicketOwner.SelectedValue Then
        '    '        If ddlTicketOwner.SelectedItem.Text.ToLower() = "select..." Then
        '    '            strBodyTicketDetailChange += " Product Owner removed. </br>"
        '    '            strBodyTicketDetailChange += " Previous Product Owner : " + """" + lblTicketOwner.Text + """" + vbCrLf
        '    '        Else
        '    '            strBodyTicketDetailChange += " Product Owner changed from : " + """" + lblTicketOwner.Text + """" + " to " + """" + ddlTicketOwner.SelectedItem.Text + """" + vbCrLf
        '    '        End If
        '    '        IsTicketDetailChanged = True
        '    '    End If



        '    '    If IsTicketDetailChanged Then

        '    ' Add Note 
        '    Dim intNewNotesID As Integer = 0
        '    Dim ObjNotes As PM_Notes
        '    Dim IsPublic As Boolean = False
        '    ObjNotes = New PM_Notes()
        '    With ObjNotes
        '        '.Ticket_Feature_ID = CInt(hdnID.Value)
        '        '.Notes = strBodyTicketDetailChange
        '        '.SubmittedBy = CType(Session("AdminID"), Integer)
        '        '.DateEntered = DateTime.Now
        '        '.IsByAdmin = 1
        '        '.TimeSpent = "00:00:00"
        '        '.Type = Enumeration.TicketsNotesType.PrivateNote
        '        'intNewNotesID = .Notes_Add()
        '        ObjNotes = New PM_Notes()
        '        .Ticket_Feature_ID = CInt(hdnID.Value)
        '        .Notes = strBodyTicketDetailChange
        '        .SubmittedBy = CType(Session("AdminID"), Integer)
        '        .DateEntered = DateTime.Now
        '        .IsByAdmin = 1
        '        .TimeSpent = ddlHoursNotes.SelectedValue & ":" & ddlMinutesNotes.SelectedValue
        '        .Type = Enumeration.TicketsNotesType.PrivateNote
        '        IsPublic = True
        '        intNewNotesID = .Notes_Add()
        '        SendEmailToUsersOnEdit(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))

        'End With
        'End If
        'If (Affected = 1) Then
        '    Response.Redirect("TicketsDetail.aspx?ID=" & hdnID.Value & "&ddlClients=" & ddlClients & "&ddlCategories=" & ddlCategories & "&ddlStatus=" & ddlStatus & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "&txtDateFrom=" & txtDateFrom & "&txtDateTo=" & txtDateTo & "&hdnSortBy=" + hdnSortBy & "&PrevPage=4&NewTicket=True")
        'End If

        '    If (Affected = 1) Then
        '        Response.Redirect("TicketsDetail.aspx?ID=" & hdnID.Value & "&ddlClients=" & ddlClients & "&ddlCategories=" & ddlCategories & "&ddlStatus=" & ddlStatus & "&ddlFilter=" & ddlFilter & "&txtSearch=" & txtSearch & "&txtDateFrom=" & txtDateFrom & "&txtDateTo=" & txtDateTo & "&hdnSortBy=" + hdnSortBy & "&PrevPage=4&NewTicket=True")
        '    End If
        '    End If

        'End With
        'dd

    End Sub




    Protected Sub btnEditTicketDetail_PreRender(sender As Object, e As EventArgs) Handles btnEditTicketDetail.PreRender
        btnEditTicketDetail.OnClientClick = "EditTicketDetail(); return false;"

    End Sub


    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If ddlTicketClients.SelectedValue = Enumeration.ClientID.EA Then
            ddlAreaDeveloper.Attributes.Add("style", "display:inline")
            spnAreaDeveloper.Style.Add("display", "inline")
        Else
            ddlAreaDeveloper.Attributes.Add("style", "display:none")
            spnAreaDeveloper.Style.Add("display", "none")
        End If
    End Sub

    Protected Sub ddlTicketCategories_DataBound(sender As Object, e As EventArgs) Handles ddlTicketCategories.DataBound
        If (ddlTicketCategories.Items.FindByValue(Me.hdnCategoryID.Value) Is Nothing = False) Then
            ddlTicketCategories.SelectedValue = Me.hdnCategoryID.Value
            hdnOldCategoryValue.Value = ddlTicketCategories.SelectedItem.Text
        End If
    End Sub

    Protected Sub ddlAreaDeveloper_DataBound(sender As Object, e As EventArgs) Handles ddlAreaDeveloper.DataBound
        If (ddlAreaDeveloper.Items.FindByValue(AreaDeveloperId) Is Nothing = False) Then
            ddlAreaDeveloper.SelectedValue = AreaDeveloperId
        End If
        If ddlAreaDeveloper.Items.FindByValue("0") Is Nothing Then
            ddlAreaDeveloper.Items.Insert(0, New ListItem("Select...", 0))
        End If
    End Sub

    Protected Sub ddlTicketClients_DataBound(sender As Object, e As EventArgs) Handles ddlTicketClients.DataBound
        If Not Page.IsPostBack Then
            If (ddlTicketClients.Items.FindByValue(hdnOldClientId.Value) Is Nothing = False) Then
                ddlTicketClients.SelectedValue = colTicket_Features.Item(0).ClientID
            Else
                Response.Redirect("~/AccessDenied.aspx", True)
            End If

        End If

    End Sub
    Protected Sub ddlSubCategories_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSubCategories.DataBound
        ' If Not Page.IsPostBack Then
        If ddlSubCategories.Items.FindByValue("0") Is Nothing Then
            ddlSubCategories.Items.Insert(0, New ListItem("Select...", 0))
        End If

        If hdnSubCategoryID.Value <> 0 Then
            If (ddlSubCategories.Items.FindByValue(Me.hdnSubCategoryID.Value) Is Nothing = False) Then
                ddlSubCategories.SelectedValue = Me.hdnSubCategoryID.Value
                hdnOldSubCategoryValue.Value = ddlSubCategories.SelectedItem.Text
            End If
        Else
            ddlSubCategories.SelectedIndex = Me.hdnSubCategoryID.Value
        End If
        'End If
    End Sub


    Protected Sub rptrNotes_ItemCommand(source As Object, e As RepeaterCommandEventArgs)
        Dim PM As PM_Notes = New PM_Notes()
        Dim FindID As Integer = CType(e.Item.FindControl("lblID"), Label).Text
        Select Case e.CommandName
            Case "Pub"
                
                PM.Notes_Update(FindID, False)

                rptrNotes.DataBind()
             update1.DataBind()
                'Response.Redirect("TicketsDetail.aspx?ID=" + hdnID.Value)
            Case "Pri"
                PM.Notes_Update(FindID, True)
                rptrNotes.DataBind()
                update1.DataBind()
                'Response.Redirect("TicketsDetail.aspx?ID=" + hdnID.Value)

            Case Else

        End Select
        'Handles rptrNotes.ItemCommand
    End Sub
    Protected Sub rptrAttachments_ItemDataBound(sender As Object, e As RepeaterItemEventArgs)

    End Sub
    Protected Sub btnSearchpop_Click(sender As Object, e As EventArgs)
        'Dim listpo As List(Of Portal.BLL.PM.PM_Ticket_Features)
        Dim dtTicket As DataTable
        Dim ticketNumbers As String = txtSearchBox.Text.Replace(" ", "")
        'listpo = Portal.BLL.PM.PM_Ticket_Features.PM_TicketSearch(Integer.Parse(txtSearchBox.Text))
        dtTicket = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_TicketLink_Search(Integer.Parse(ticketNumbers))
        ticketGrid.DataSource = dtTicket
        ticketGrid.DataBind()
        System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "<script type='Text/Javascript'>ShowDiv();</script>", False)


        'ScriptManager.RegisterStartupScript(Me.Page, Page.GetType(), "text", "ShowDiv()", True)
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "window-script", "ShowDiv()", True)
        'System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "Script", "ShowDiv();", True)
    End Sub
    Protected Sub btnSaveTicket_Click(sender As Object, e As EventArgs)

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

                Dim strBodyTicketDetailChange1 As String = " === This ticket has been linked to ticket #" + hdnID.Value + " (Subject: " + lblActivitySubject.Text + ") by " + lblAssignBy.Text + " on " + DateTime.Now + " ===" + vbCrLf + vbCrLf
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
        Response.Redirect("~/PM/TicketsDetail.aspx?ID=" & hdnID.Value & "&NewTicket=True&PrevPage=4")
    End Sub
    Protected Sub linkedTickets_DataBound(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then

            linkedTickets.Items.Insert(0, New ListItem("Linked Tickets", 0))
            linkedTickets.Items.Add("Add Ticket")

        End If
    End Sub
    Protected Sub Button3_Click(sender As Object, e As EventArgs)
        ticketGrid.DataSource = Nothing
        ticketGrid.DataBind()
        'ticketGrid.Columns.Clear()
        txtSearchBox.Text = ""
        System.Web.UI.ScriptManager.RegisterStartupScript(Me, [GetType](), "check_Javascript", "<script type='Text/Javascript'>HideDiv();</script>", False)
        'Response.Redirect("~/PM/TicketsDetail.aspx?ID=" & hdnID.Value & "&NewTicket=True")
    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs)
        Dim Affeted As Integer = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_UpdateFlag(CType(hdnID.Value, Integer), True, CType(hdnUserID.Value, Integer), flagComments.Text)
        Dim IsTicketDetailChanged As Boolean = True

        Dim strBodyTicketDetailChange As String = " === Flag is Added. ===" + vbCrLf + vbCrLf
        If Not String.IsNullOrEmpty(flagComments.Text) Then
            strBodyTicketDetailChange += flagComments.Text + vbCrLf
        End If
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
                'SendEmailToUsersOnEdit(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))

            End With

            'Response.Redirect("~/PM/MyTickets.aspx")


        End If


        Response.Redirect("~/PM/TicketsDetail.aspx?ID=" & hdnID.Value & "&NewTicket=True&PrevPage=4")
    End Sub
    Protected Sub btnYes_Click(sender As Object, e As EventArgs)
        Dim Affeted As Integer = Portal.BLL.PM.PM_Ticket_Features.PM_TicketFeature_UpdateFlag(CType(hdnID.Value, Integer), False, CType(hdnUserID.Value, Integer), flagComments.Text)
        Dim IsTicketDetailChanged As Boolean = True

        Dim strBodyTicketDetailChange As String = " === Flag has been removed. ===" + vbCrLf + vbCrLf
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
                'SendEmailToUsersOnEdit(IsPublic, IIf(strStatusEmailDescription = "", "has been updated", strStatusEmailDescription))

            End With

            'Response.Redirect("~/PM/MyTickets.aspx")


        End If

        Response.Redirect("~/PM/TicketsDetail.aspx?ID=" & hdnID.Value & "&NewTicket=True&PrevPage=4")
    End Sub
End Class
