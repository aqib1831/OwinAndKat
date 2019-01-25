
Partial Class HR_UsersTimeHistory
    Inherits System.Web.UI.Page

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Me.txtStartDate.Text = System.DateTime.Now.Date.AddDays(-7).ToShortDateString()
            Me.txtEndDate.Text = System.DateTime.Now.Date.ToShortDateString()
            If CheckSubModuleAccess() = False Then
                ddlUsers.Enabled = False
            End If
            LoadEmployee("")
            ddlUsers.FindItemByValue(CInt(Session("AdminID"))).Selected = True
        End If
    End Sub

    Private Function CheckSubModuleAccess() As Boolean
        Dim strcsv As String = Session("UsersSubModulesID")
        If strcsv <> Nothing AndAlso strcsv <> String.Empty Then
            Dim srtArray As String() = strcsv.Split(",")
            If srtArray.Length > 0 Then
                For i As Integer = 0 To srtArray.Length - 1
                    If srtArray(i) = Portal.BLL.Enumeration.SubModules.ManageTimeHistory Then
                        Return True
                    End If
                Next
            End If
        End If
        Return False
    End Function
    Protected Sub srcUserName_PreRender(ByVal senders As Object, ByVal e As System.EventArgs) Handles srcUserName.PreRender
        If srcUserName.Items.Count = 0 Then
            ''srcUserName.Visible = True
            tblNoRecord.Visible = True
        Else
            ''srcUserName.Visible = True
            tblNoRecord.Visible = False
        End If
    End Sub
    Protected Sub ddlUsers_DataBound(ByVal o As Object, ByVal e As System.EventArgs) Handles ddlUsers.DataBound
        ddlUsers.Items.Insert(0, New Telerik.WebControls.RadComboBoxItem("Show All", 0))
    End Sub
    Protected Sub ddlUsers_ItemsRequested(ByVal o As Object, ByVal e As Telerik.WebControls.RadComboBoxItemsRequestedEventArgs) Handles ddlUsers.ItemsRequested
        LoadEmployee(e.Text)
    End Sub
    Private Sub LoadEmployee(ByVal byvalsearch As String)
        Dim db As New DBAccess
        Dim dt As System.Data.DataTable
        db.AddParameter("@Search", byvalsearch)
        dt = db.ExecuteDataTable("HR_Users_GetAll_ForRadCombo")
        ddlUsers.DataSource = dt
        ddlUsers.DataBind()
    End Sub

    Protected Sub srcTimeHistoryDetail_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        'onmouseover = "this.className='HighlightedHomeRow';"
        'onmouseout = "this.className='SimpleHomeRow';"
        'CType(e.Item.FindControl("trTime"), HtmlTableRow).BgColor = "Red"
    End Sub
    Public Shared Sub GetColor(ByVal dtTime As DateTime)

    End Sub

End Class
