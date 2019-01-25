Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Partial Class HR_Career_New
    Inherits System.Web.UI.Page
    Protected isEditMode As Boolean = False
    Protected HasResponsibilities As Boolean = False
    Protected HasQualifications As Boolean = False
    Protected HasBenefits As Boolean = False
    Protected HasSubResp As Boolean = False
    Protected HasSubQua As Boolean = False
    Protected HasSubBen As Boolean = False

    Private dt As DataTable

    Protected Sub HR_Career_New_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            InitPage()
        End If
    End Sub
    Private Sub InitPage()
        If String.IsNullOrEmpty(Request.QueryString("JobID")) = False Then
            hdnJobID.Value = Request.QueryString("JobID")
            isEditMode = True
            GetJobByID()
        Else
            chkActive.Checked = True
        End If
    End Sub
    Private Sub GetJobByID()
        dt = Portal.BLL.HR.Jobs.GetJobByID(Request.QueryString("JobID"))
        If dt IsNot Nothing AndAlso dt.Rows.Count > 0 Then
            jobTitle.Text = dt.Rows(0)("JobTitle")
            chkActive.Checked = Not dt.Rows(0)("InActive")
            If dt.Rows(0)("LocationID") = 1 Then
                rbPk.Checked = True
            ElseIf dt.Rows(0)("LocationID") = 2 Then
                rbUs.Checked = True
            ElseIf dt.Rows(0)("LocationID") = 3 Then
                rbDubail.Checked = True
            ElseIf dt.Rows(0)("LocationID") = 4 Then
                rbAtlanta.Checked = True
            End If
            txtDescription.Text = Server.UrlDecode(dt.Rows(0)("Description")).Replace("<br/>", vbCrLf)
            If dt.Select("JobAttributeID = 1 AND ParentID = 0").Length > 0 Then
                HasResponsibilities = True
                rptResponsibilities.DataSource = New DataView(dt, "JobAttributeID = 1 AND ParentID = 0", "Sequence", DataViewRowState.CurrentRows)
                rptResponsibilities.DataBind()
            End If
            If dt.Select("JobAttributeID = 2 AND ParentID = 0").Length > 0 Then
                HasQualifications = True
                rptQualification.DataSource = New DataView(dt, "JobAttributeID = 2 AND ParentID = 0", "Sequence", DataViewRowState.CurrentRows)
                rptQualification.DataBind()
            End If
            If dt.Select("JobAttributeID = 3 AND ParentID = 0").Length > 0 Then
                HasBenefits = True
                rptBenefits.DataSource = New DataView(dt, "JobAttributeID = 3 AND ParentID = 0", "Sequence", DataViewRowState.CurrentRows)
                rptBenefits.DataBind()
            End If
            Me.lblPageTitle.Text = "Edit Career Opportunity"
        End If
    End Sub
    Protected Sub rptResponsibilities_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptResponsibilities.ItemDataBound
        Dim DetailID As Integer = DataBinder.Eval(e.Item.DataItem, "DetailID")
        Dim rptSubResponsibilities As Repeater = e.Item.FindControl("rptSubResponsibilities")
        If rptSubResponsibilities IsNot Nothing Then
            If dt.Select("JobAttributeID = 1 AND ParentID = " & DetailID).Length > 0 Then
                HasSubResp = True
            End If
            rptSubResponsibilities.DataSource = New DataView(dt, "JobAttributeID = 1 AND ParentID = " & DetailID.ToString(), "Sequence", DataViewRowState.CurrentRows)
            rptSubResponsibilities.DataBind()
        End If
    End Sub

    Protected Sub rptQualification_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptQualification.ItemDataBound
        Dim DetailID As Integer = DataBinder.Eval(e.Item.DataItem, "DetailID")
        Dim rptSubQualification As Repeater = e.Item.FindControl("rptSubQualification")
        If rptSubQualification IsNot Nothing Then
            If dt.Select("JobAttributeID = 2 AND ParentID = " & DetailID).Length > 0 Then
                HasSubQua = True
            End If
            rptSubQualification.DataSource = New DataView(dt, "JobAttributeID = 2 AND ParentID = " & DetailID.ToString(), "Sequence", DataViewRowState.CurrentRows)
            rptSubQualification.DataBind()
        End If
    End Sub

    Protected Sub rptBenefits_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptBenefits.ItemDataBound
        Dim DetailID As Integer = DataBinder.Eval(e.Item.DataItem, "DetailID")
        Dim rptSubBenefits As Repeater = e.Item.FindControl("rptSubBenefits")
        If rptSubBenefits IsNot Nothing Then
            If dt.Select("JobAttributeID = 3 AND ParentID = " & DetailID).Length > 0 Then
                HasSubBen = True
            End If
            rptSubBenefits.DataSource = New DataView(dt, "JobAttributeID = 3 AND ParentID = " & DetailID.ToString(), "Sequence", DataViewRowState.CurrentRows)
            rptSubBenefits.DataBind()
        End If
    End Sub
End Class