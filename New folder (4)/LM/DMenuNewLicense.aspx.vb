Partial Class LM_NewLicense
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    'Protected Sub ddlClient_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlClient.DataBound
    '    ddlClient.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Select...", "0"))
    'End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            ddlProducts.Items.Insert(0, New ListItem("DMenu", Portal.BLL.Enumeration.NSProductIDs.DMenu ))
            ddlStores.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Search...", "0"))
        End If
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objLM As New Portal.BLL.LM.DMenuLicenseManagement
        Dim returnVal As Integer = 0
        Dim str As String() = ddlStores.Value.Split(",")

        objLM.InVoiceNo = txtInvoiceNo.Text.Trim()
        objLM.ClientID = CInt(str(1))
        objLM.ProductID = CInt(ddlProducts.SelectedValue)
        objLM.StoreNo = CInt(str(0))
        objLM.NumberOfDisplays = ddlNumberOfDisplays.SelectedValue
        objLM.Notes = txtNotes.Text.Trim()
        objLM.IssuedByID = CInt(Session("AdminID"))
        objLM.CurrentVersion = ConfigurationManager.AppSettings("DMenuversion")
        'If static ip is selected then we are going to save static ip
        'Other wise dynamic ip will be used.
        If (chkStaticIP.Checked) Then
            objLM.SystemIP = txtStaticIP.Text.Trim()
            objLM.IsDynamicIP = False
        Else
            objLM.SystemIP = String.Empty
            objLM.IsDynamicIP = True
        End If
        returnVal = objLM.AddDMenuLicense()
        If (returnVal > 0) Then
            ClientScript.RegisterStartupScript(Me.GetType(), "CloseNewLicenseDiv", "parent.CloseNewLicenseDiv();", True)
            ClientScript.RegisterStartupScript(Me.GetType(), "RebindGrid", "parent.RebindRecords();", True)
        End If
    End Sub
    Protected Sub ddlStores_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlStores.ItemsRequested
        If Functions.IsSuperAdmin(CInt(Session("AdminId"))) Then
            LoadStores_SuperUser(e.Text)
        Else
            LoadStores(e.Text)
        End If
    End Sub
    Private Sub LoadStores(ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@ClientID", 0)
        db.AddParameter("@FranchiseID", 0)
        db.AddParameter("@Search", byvalsearch)
        db.AddParameter("@UserID", Session("AdminId"))
        'dt = db.ExecuteDataTable("Franchises_GetByClientID_ForRadCombo") OLD
        dt = db.ExecuteDataTable("Franchises_GetByClientAndUserAccess_ForRadCombo") 'NEW
        ddlStores.DataSource = dt
        ddlStores.DataBind()
    End Sub
    Private Sub RadComboBox1_ItemDataBound(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemDataBoundEventArgs) Handles ddlStores.ItemDataBound
        e.Item.Text = CType(e.Item.DataItem, System.Data.DataRowView)("StoreNick").ToString() + ", " + CType(e.Item.DataItem, System.Data.DataRowView)("ClientCode").ToString()
    End Sub
 Private Sub LoadStores_SuperUser(ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@ClientID", 0)
        db.AddParameter("@FranchiseID", 0)
        db.AddParameter("@Search", byvalsearch)
        dt = db.ExecuteDataTable("Franchises_GetByClientID_ForRadCombo") 'OLD

        ddlStores.DataSource = dt
        ddlStores.DataBind()
    End Sub
End Class