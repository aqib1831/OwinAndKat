Imports System.Collections.Generic
Imports Portal.BLL
Imports System.Data.SqlClient

Partial Class MyNetsolace_ActivityDetail
    Inherits System.Web.UI.Page
    
    Dim WaitingForID As String = "0"
    'Dim colFrutationFranchise As New List(Of FR_Franchise)()
    Dim doBindControl As Boolean = False
    Dim objActivity As New List(Of Portal.BLL.Activities)()
    Dim objConnectionStringSettings As ConnectionStringSettings

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Page.Title = "Netsolace Portal - My Netsolace"

        If Not Page.IsPostBack Then
            If String.IsNullOrEmpty(Request.QueryString("ID")) = False AndAlso IsNumeric(Request.QueryString("ID")) Then
                hdnID.Value = Request.QueryString("ID").ToString()
            End If
            If String.IsNullOrEmpty(Request.QueryString("ClientID")) = False AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                hdnClientID.Value = Request.QueryString("ClientID").ToString()
            End If
            'ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ShowDiv", "showHideVital();", True)
            If String.IsNullOrEmpty(Request.QueryString("FranchiseID")) = False AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
                hdnFranchiseID.Value = HttpContext.Current.Request.QueryString("FranchiseID").ToString()
                If Not Session("MyNetsolace_ClientContactID") Is Nothing Then
                    lnkBtnNewActivity.PostBackUrl = "AddActivity.aspx?ClientID= " & hdnClientID.Value & "&FranchiseID=" & hdnFranchiseID.Value & "&PrevPage=" & Request.QueryString("PrevPage").ToString()
                End If
                lblFranchiseName.Text = "(" & Portal.BLL.Franchises.GetStoreNickByFranchiseID(CInt(hdnFranchiseID.Value)) & ")"
            End If
            OnBackClick()
            doBindControl = True
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
        hdnRegularExprssion.Value = CStr(ConfigurationManager.AppSettings("AttachmentsExpression"))
    End Sub
  
    Protected Sub rptrNotes_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrNotes.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rptrAttachments"), Repeater)
            Dim NotesID As Integer = CType(CType(e.Item.FindControl("lblID"), Label).Text, Integer)
            sdsAttachments.FilterExpression = "[NoteID] = " & NotesID.ToString
            rpt.DataSource = sdsAttachments
            rpt.DataBind()
            If rpt.Items.Count <= 0 Then
                rpt.Visible = False
            End If
        End If
    End Sub
    Protected Sub AddNotes()
        Dim Client As Integer = CInt(hdnClientID.Value)
        Dim ObjectActivity As New Portal.BLL.Activities()
        Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
        Dim intNewNotesID As Integer = 0
        With objActivityNotes
            .ActivityID = CInt(hdnID.Value)
            .NotesType = Portal.BLL.Enumeration.ActivityNotesType.PublicNote
            .Notes = txtNotes.Text.Trim
            .AdminID = 0

            If Not Session("MyNetsolace_ClientContactID") Is Nothing Then
                .PlacedBy = Enumeration.PlacedBy.Corporate
                .ClientContactID = CInt(Session("MyNetsolace_ClientContactID"))
                .FranchiseContactID = 0
            End If

            .NotesDate = DateTime.Now
            intNewNotesID = .AddNotes()
        End With

        If intNewNotesID > 0 Then
            Dim DirectoryName As String = Functions.GetDateTimeUniqueString()
            Dim objActivityAttachements As Portal.BLL.ActivityAttachements = New Portal.BLL.ActivityAttachements()
            With objActivityAttachements
                .NotesID = intNewNotesID
                .ActivityID = 0
                If file1.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file1)
                End If
                If file2.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file2)
                End If
                If file3.FileName <> Nothing Then
                    .SaveAttachments(DirectoryName, file3)
                End If
            End With

            txtNotes.Text = ""
            rptrNotes.DataSourceID = sdsNotes.ID
            rptrNotes.DataBind()
            doBindControl = True
        End If
    End Sub
    Public Sub BindControl()

        objActivity = Portal.BLL.Activities.GetActivityByID(CInt(hdnClientID.Value), CInt(hdnID.Value))
        Dim Item As ListItem = Nothing
        If objActivity.Count > 0 Then
            ' Bind Notes Data 
            lbladminName.Text = objActivity.Item(0).AdminName
            lblDate.Text = CDate(Functions.IfNull(objActivity.Item(0).ActivityDate, Date.Now)).ToString("MMMM dd, yyyy hh:mm:ss tt") & "<i> ( EST )</i>"
            lblDescription.Text = objActivity.Item(0).Description.ToString().Replace(vbCrLf, "</br>")
            lblActivitySubject.Text = Functions.StringTruncate(objActivity.Item(0).Subject, 37)                     
            lblTicketNumber.Text = Functions.GetActivityPrefix(objActivity.Item(0).Type) & objActivity.Item(0).ID
            hdnType.Value = objActivity.Item(0).Type          
            lblAssignBy.Text = objActivity.Item(0).AdminName

            If objActivity.Item(0).RelatedTo = 0 Then
                lblRelatedTo.Text = "General Ticket"
                ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "HideTrModule", "SetModuleDisplay('none');", True)
            ElseIf objActivity.Item(0).ModuleId = 0 Then
                lblRelatedTo.Text = objActivity.Item(0).RelatedTitle
                ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "HideTrModule", "SetModuleDisplay('none');", True)
            Else
                lblRelatedTo.Text = objActivity.Item(0).RelatedTitle
                lblModule.Text = objActivity.Item(0).ModuleName
            End If

            lblActivityDueDate.Text = DateTime.Parse(Functions.IfNull(objActivity.Item(0).ActivityDate, System.DateTime.Now)).ToString("MMMM dd, yyyy")
            hdnDueDate.Value = Functions.IfNull(objActivity.Item(0).ActivityDate, System.DateTime.Now)
            
            hdnIsClose.Value = objActivity.Item(0).Status
            If objActivity.Item(0).Status = True Then
                btnAddNotes.Visible = False
                btnReopenTicket.Visible = True
            Else
                btnAddNotes.Visible = True
                btnReopenTicket.Visible = False
            End If
            
        End If
    End Sub    

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        If Not IsPostBack Then
            BindControl()
        Else
            If doBindControl Then
                BindControl()
            End If
        End If
    End Sub

    Protected Sub rptrStartActivityAttachments_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrStartActivityAttachments.ItemDataBound
        If e.Item.ItemType = ListItemType.Footer Then
            If rptrStartActivityAttachments.Items.Count <= 0 Then
                rptrStartActivityAttachments.Visible = False
            End If
        End If
    End Sub

    Protected Sub btnSaveNotes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveNotes.Click
        Me.AddNotes()
    End Sub

    Private Sub OnBackClick()
        If String.IsNullOrEmpty(Request.QueryString("PrevPage")) = False AndAlso IsNumeric(Request.QueryString("PrevPage")) Then
            Select Case CInt(Request.QueryString("PrevPage"))
                Case 1 'Home
                    btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx?ClientID=" & hdnClientID.Value) & "'; return false; ")
                Case 2 'Franchisor Store inbox
                    btnBack.Attributes.Add("OnClick", "window.location='Franchisor_StoreInbox.aspx?ClientID=" & hdnClientID.Value & "&FranchiseID=" & hdnFranchiseID.Value & "'; return false;")
                Case 3 'Franchisor Inbox
                    btnBack.Attributes.Add("OnClick", "window.location='FranchisorInbox.aspx?ClientID=" & hdnClientID.Value & "'; return false;")
                Case 5 'Franchisor History
                    btnBack.Attributes.Add("OnClick", "window.location='FranchisorHistory.aspx?ClientID=" & hdnClientID.Value & "'; return false;")
                Case Else
                    btnBack.Attributes.Add("OnClick", "parent.window.location='" & ResolveClientUrl("~/Home.aspx?ClientID=" & hdnClientID.Value) & "'; return false;")
            End Select
        End If
    End Sub

    Protected Sub btnReopenTicket_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReopenTicket.Click
        Dim ObjectActivity As New Portal.BLL.Activities()
        Dim intNewNotesID As Integer
        ObjectActivity.ID = CType(hdnID.Value, Integer)
        Dim objActivityNotes As Portal.BLL.ActivityNotes = New Portal.BLL.ActivityNotes()
        With objActivityNotes
            .ActivityID = CInt(hdnID.Value)
            .NotesType = Enumeration.ActivityNotesType.PublicNote
            .Notes = "Ticket has been reopened."
            .PlacedBy = Enumeration.PlacedBy.Corporate
            .ClientContactID = CInt(Session("MyNetsolace_ClientContactID"))
            .FranchiseContactID = 0
            .NotesDate = DateTime.Now
            intNewNotesID = .AddNotes()
        End With

        With ObjectActivity
            'Open the Ticket 
            .ID = CInt(hdnID.Value)
            .WaitingForID = "0"
            .IsClose = False
            intNewNotesID = Portal.BLL.Activities.UpdateActivityStatus(CInt(hdnClientID.Value), ObjectActivity)
            doBindControl = True
        End With

    End Sub
End Class
