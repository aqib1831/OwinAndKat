Imports System.Collections.Generic
Partial Class LM_nXstepLicensesReport
    Inherits System.Web.UI.Page
    Dim rowCount As Integer = 0



    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        If Not String.IsNullOrEmpty(Request.QueryString("IsXLS")) AndAlso CBool(Request.QueryString("IsXLS")) Then
            Response.Buffer = True
            Response.AddHeader("content-disposition", "attachment; filename=FranchiseeSupportReport.xls")
            Response.ContentType = "application/vnd.ms-excel"
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        showClientOrState()
        If Not Functions.IsSuperAdmin(CInt(Session("AdminID"))) Then
            odsSBSLicenses.SelectMethod = "GetAllNextStepLicensesForReporting_LM"
            If odsSBSLicenses.SelectParameters("UserID") Is Nothing Then
                odsSBSLicenses.SelectParameters.Add("UserID", CInt(Session("AdminID")))
            End If
        End If
    End Sub

    Public Function GetClientByID(ByVal ClientID As Integer) As String
        Dim strClientName As String = ""
        Dim objCol As List(Of Portal.BLL.Client.Clients) = Portal.BLL.Client.Clients.ClientsGetByID(ClientID)
        If objCol.Count > 0 Then
            strClientName = objCol.Item(0).Name.ToString
        End If
        Return strClientName
    End Function
    Public Sub showClientOrState()
        If (CInt(Request.QueryString("ClientID")) > 0) And (CInt(Request.QueryString("StateID")) = 0) Then
            lblShowClientOrState.Text = "Client:&nbsp;" & GetClientByID(Request.QueryString("ClientID"))
        ElseIf (CInt(Request.QueryString("StateID")) > 0) And (CInt(Request.QueryString("ClientID")) = 0) Then
            lblShowClientOrState.Text = "State:&nbsp;" & Request.QueryString("State")
        ElseIf (CInt(Request.QueryString("StateID")) > 0) And (CInt(Request.QueryString("ClientID")) > 0) Then
            lblShowClientOrState.Text = "Client:&nbsp;" & GetClientByID(Request.QueryString("ClientID"))
        ElseIf (CInt(Request.QueryString("StateID")) = 0) And (CInt(Request.QueryString("ClientID")) = 0) Then
            divClientOrState.Visible = False
        End If
    End Sub
    Protected Sub rptReport_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptReport.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            rowCount += 1
            If CInt(Request.QueryString("ClientID")) > 0 Then
                Dim tdClientCode As HtmlTableCell = CType(e.Item.FindControl("tdClientCode"), HtmlTableCell)
                tdClientCode.Visible = False
            End If
        End If
        If e.Item.ItemType = ListItemType.Header Then
            If CInt(Request.QueryString("ClientID")) > 0 Then
                Dim tdClient As HtmlTableCell = CType(e.Item.FindControl("tdClient"), HtmlTableCell)
                tdClient.Visible = False
            End If
        End If
        If e.Item.ItemType = ListItemType.Footer Then
            Dim tblNoRecord As HtmlTable = CType(e.Item.FindControl("tblNoRecord"), HtmlTable)
            Dim tblFooter As HtmlTable = CType(e.Item.FindControl("tblFooter"), HtmlTable)
            Dim lblTotalLicenses As Label = CType(e.Item.FindControl("lblTotalLicenses"), Label)
            If rowCount > 0 Then
                tblNoRecord.Visible = False
                tblFooter.Visible = True
                lblTotalLicenses.Text = rowCount
            Else
                tblNoRecord.Visible = True
                tblFooter.Visible = False
            End If
        End If
    End Sub
End Class