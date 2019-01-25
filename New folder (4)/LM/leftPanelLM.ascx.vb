Imports System.Data

Partial Class LM_leftPanelLM
    Inherits System.Web.UI.UserControl

    Protected Sub imgBtnSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles imgBtnSearch.Click
        If (String.IsNullOrEmpty(txtSearch.Text.Trim.ToString()) = False) Then
            'If lblTabSelected.Value = "1" Then
            '    Dim dtLicenses As New DataTable
            '    dtLicenses = Portal.BLL.LicenseManagement.GetAllNextStepLicenses(txtSearch.Text.Trim(), 1, -1, 0, "Title", 0, 100)
            '    rptSearchLicenses.DataSource = dtLicenses
            '    rptSearchLicenses.DataBind()
            'ElseIf lblTabSelected.Value = "2" Then
            '    Dim colNS_Products_Franchises As New System.Collections.Generic.List(Of Portal.BLL.NS.NS_Products_Franchises)()
            '    colNS_Products_Franchises = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetAllForSMS(txtSearch.Text.Trim(), 0, 0, 0, Portal.BLL.Enumeration.NSProductIDs.SMS, "", 0, 100)
            '    rptSearchLicenses.DataSource = colNS_Products_Franchises
            '    rptSearchLicenses.DataBind()
            'ElseIf lblTabSelected.Value = "3" Then
            '    Dim colQS_Users As New System.Collections.Generic.List(Of Portal.BLL.QS.QS_Users)()
            '    colQS_Users = Portal.BLL.QS.QS_Users.QS_UsersGetAll(txtSearch.Text.Trim(), 0, 1, 0, "", 0, 100)
            '    rptSearchLicenses.DataSource = colQS_Users
            '    rptSearchLicenses.DataBind()
            'ElseIf lblTabSelected.Value = "4" Then
            '    Dim dtDMenuLicenses As New DataTable
            '    dtDMenuLicenses = Portal.BLL.LM.DMenuLicenseManagement.GetAllDMenuLicenses(txtSearch.Text.Trim(), 0, 0, 0, "", 0, 100)
            '    rptSearchLicenses.DataSource = dtDMenuLicenses
            '    rptSearchLicenses.DataBind()
            'End If
        End If
    End Sub

    Protected Sub rptSearchLicenses_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptSearchLicenses.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            'Dim lblName As Label = CType(rptSearchLicenses.Controls(1).FindControl("lblName"), Label)
            'lblName.Text = ""
            'lblName.ToolTip = ""

            'If lblTabSelected.Value = "1" Then
            '    lblName.Text = Functions.StringTruncate(CStr(e.Item.DataItem("RegKey")), 20)
            '    lblName.ToolTip = CStr(e.Item.DataItem("RegKey"))
            'ElseIf lblTabSelected.Value = "2" Then
            '    lblName.Text = Functions.StringTruncate(CType(e.Item.DataItem(), Portal.BLL.NS.NS_Products_Franchises).StoreNick & " " & CType(e.Item.DataItem(), Portal.BLL.NS.NS_Products_Franchises).StoreNumber, 20)
            '    lblName.ToolTip = CType(e.Item.DataItem(), Portal.BLL.NS.NS_Products_Franchises).StoreNick & " " & CType(e.Item.DataItem(), Portal.BLL.NS.NS_Products_Franchises).StoreNumber
            'ElseIf lblTabSelected.Value = "3" Then
            '    lblName.Text = Functions.StringTruncate(CType(e.Item.DataItem(), Portal.BLL.QS.QS_Users).KEY, 20)
            '    lblName.ToolTip = CType(e.Item.DataItem(), Portal.BLL.QS.QS_Users).KEY
            'ElseIf lblTabSelected.Value = "4" Then
            '    lblName.Text = Functions.StringTruncate(CStr(e.Item.DataItem("RegKey")), 20)
            '    lblName.ToolTip = CStr(e.Item.DataItem("RegKey"))
            'End If

        ElseIf e.Item.ItemType = ListItemType.Footer Then
            If (rptSearchLicenses.Items.Count = 0) Then
                ltrlNoRecord.Visible = True
                rptSearchLicenses.Visible = False
            Else
                ltrlNoRecord.Visible = False
                rptSearchLicenses.Visible = True
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Functions.IsSuperAdmin(CInt(Session("AdminID"))) Then
        ltrlnXtepCount.Text = "- " & Portal.BLL.LicenseManagement.GetAllNextStepLicensesCount("", 0, 0, 0)
        ltrlSMSCount.Text = "- " & Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetAllCountForSMS("", 0, 0, 0, Portal.BLL.Enumeration.NSProductIDs.SMS)
        ltrlQsCount.Text = "- " & Portal.BLL.QsLicenseManagment.GetAllQsLicensesCount("", 0, -1, 0)
        ltrlDMenuCount.Text = "- " & Portal.BLL.LM.DMenuLicenseManagement.GetAllDMenuLicensesCount("", 0, 0, 0)
        ltrlSMSXCount.Text = "- " & Portal.BLL.SMSXLicenseManagement.GetAllSMSXLicensesCount("", 0, -1, 0)
        lblDFLicensesCount.Text = "- " & Portal.BLL.DFLicenseManagement.GetAllDFLicensesCount("", 0, -1, 0)
        'lblSMSKCount.Text = "- " & Portal.BLL.SMSKLicenseManagement.GetAllSMSKLicensesCount("", 0, -1, 0)
        lblDigitalCatalogCount.Text = "- " & Portal.BLL.LicenseManagementDC.GetAllNextStepLicensesCount("", 0, -1, 0)
            lblUpdateCount.Text = "- " & Portal.BLL.UpdateManagement.GetAllSMSUpdateCount(1).ToString()
        Else
            Dim UserID As Integer = CInt(Session("AdminID"))
            ltrlnXtepCount.Text = "- " & Portal.BLL.LicenseManagement.GetAllNextStepLicensesByLMUserAccessCount("", 0, 0, 0, UserID)

            ltrlSMSCount.Text = "- " & Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesGetAllCountForSMS_LM("", 0, 0, 0, Portal.BLL.Enumeration.NSProductIDs.SMS, UserID)
            ltrlQsCount.Text = "- " & Portal.BLL.QsLicenseManagment.GetAllQsLicensesCount_LM("", 0, -1, 0, UserID)
            ltrlDMenuCount.Text = "- " & Portal.BLL.LM.DMenuLicenseManagement.GetAllDMenuLicensesByLMRightsCount("", 0, 0, 0, UserID)
            ltrlSMSXCount.Text = "- " & Portal.BLL.SMSXLicenseManagement.GetAllSMSXLicensesCount_LM("", 0, -1, 0, UserID)
            lblDFLicensesCount.Text = "- " & Portal.BLL.DFLicenseManagement.GetAllDFLicensesCount_LM("", 0, -1, 0, UserID)
            'lblSMSKCount.Text = "- " & Portal.BLL.SMSKLicenseManagement.GetAllSMSKLicensesCount_LM("", 0, -1, 0, UserID)
            lblDigitalCatalogCount.Text = "- " & Portal.BLL.LicenseManagementDC.GetAllNextStepLicensesCount_LM("", 0, -1, 0, UserID)
            lblUpdateCount.Text = "- " & Portal.BLL.UpdateManagement.GetAllSMSUpdateCount(1).ToString()

        End If
    End Sub

    Protected Sub sdsLicences_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles sdsLicences.Selecting

    End Sub

    Public Function GetLicenceType(ByVal Type As String)
        Dim TypeStatus As String = String.Empty
        Select Case Type
            Case "nxstep"
                TypeStatus = "License for nXstep"
            Case "dmenu"
                TypeStatus = "License for DMenu"
            Case "smsx"
                TypeStatus = "License for SMSX"
            Case "Qs"
                TypeStatus = "License for Qs"
            Case "DF"
                TypeStatus = "License for DF"

            Case Else
                TypeStatus = ""

        End Select

        Return TypeStatus
    End Function

End Class