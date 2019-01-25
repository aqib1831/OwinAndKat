
Partial Class TestStore
    Inherits System.Web.UI.Page
    Enum IsTestStore
        Enabled = 0
        Disabled = 1
    End Enum
    Protected Sub btnEnable_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEnable.Click
        Dim connectionString As String = Portal.BLL.Client.Clients.GetFransupportConnectionStringByClientID(ddlClients.SelectedValue)
        Dim objFranchises As New Portal.BLL.Franchises
        If String.IsNullOrEmpty(ddlStores.SelectedValue) = False Then
            'Enabling in Portal
            objFranchises.UpdateTestStoreStatus(IsTestStore.Enabled, CInt(ddlStores.SelectedValue), CInt(ddlClients.SelectedValue))
            'Enabling in Fransupport
            UpdateTestStoreStatus(connectionString, IsTestStore.Enabled, CInt(ddlStores.SelectedValue))
            lblMessage.Text = ddlStores.SelectedItem.Text & " has been Enabled"
			'Log Admin Action For TestStore
            objFranchises.LogAdminActionForTestStore(CInt(ddlClients.SelectedValue), CInt(ddlStores.SelectedValue), lblMessage.Text, CInt(Session("AdminID").ToString()), Date.Now())
        Else
            lblMessage.Text = "Please Select a store"
        End If
    End Sub

    Protected Sub btnDisable_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDisable.Click
        Dim connectionString As String = Portal.BLL.Client.Clients.GetFransupportConnectionStringByClientID(ddlClients.SelectedValue)
        Dim objFranchises As New Portal.BLL.Franchises
        If String.IsNullOrEmpty(ddlStores.SelectedValue) = False Then
            'Disabling in Portal
            objFranchises.UpdateTestStoreStatus(IsTestStore.Disabled, CInt(ddlStores.SelectedValue), CInt(ddlClients.SelectedValue))
            'Disabling in Fransupport
            UpdateTestStoreStatus(connectionString, IsTestStore.Disabled, CInt(ddlStores.SelectedValue))
            lblMessage.Text = ddlStores.SelectedItem.Text & " has been Disabled"
			'Log Admin Action For TestStore
            objFranchises.LogAdminActionForTestStore(CInt(ddlClients.SelectedValue), CInt(ddlStores.SelectedValue), lblMessage.Text, CInt(Session("AdminID").ToString()), Date.Now())			
        Else
            lblMessage.Text = "Please Select a store"
        End If
    End Sub
    Public Function UpdateTestStoreStatus(ByVal connectionString As String, ByVal status As Boolean, ByVal StoreNumber As Integer) As Integer
        Dim objDbAccess As New DBAccess(connectionString)
        Try
            objDbAccess.AddParameter("@Status", status)
            objDbAccess.AddParameter("@StoreNumber", StoreNumber)
            objDbAccess.ExecuteNonQuery("Franchises_TestStoreStatus_Update")
        Catch ex As Exception
            lblMessage.Text = "Stored Procedure does not exist."
        End Try
    End Function
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

	'Dim CurBrowser As HttpBrowserCapabilities = HttpContext.Current.Request.Browser
        'Response.Write("Browser: " & CurBrowser.Browser )
	'Response.Write("<br>Version: " & CurBrowser.MajorVersion )
	'Response.Write("<br>UserAgent: " & HttpContext.Current.Request.UserAgent.ToLower() )
        
	Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        If (Context.Session.Count < 1) Then
            ClientScript.RegisterClientScriptBlock(Me.GetType(), "SessionExpiration", "<script language='javascript' type='text/javascript'>window.location='AccessDenied.htm';</script>", False)
        End If
    End Sub

End Class
