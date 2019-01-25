Imports System.Data
Partial Class NSBS_ViewStatus
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            If Session("FranchiseID") <> Nothing And Session("FranchiseID") <> 0 AndAlso Session("MyNetsolace_ClientID") <> Nothing Then
                ltrFranchiseID.Text = Portal.BLL.Franchises.GetStoreNickByFransupportFranchiseID(CInt(Session("FranchiseID")), Session("MyNetsolace_ClientID"))
            End If
            txtFromDate.Attributes.Add("readonly", "readonly")
            txtToDate.Attributes.Add("readonly", "readonly")
            txtFromDate.Text = Date.Now.AddDays(-7).ToShortDateString()
            txtToDate.Text = Date.Now.ToShortDateString()
            gvwKeys.PageSize = 100
        End If
        BindGrid()
    End Sub

    Protected Sub gvwKeys_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwKeys.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then

            Dim img As Image = CType(e.Row.FindControl("imgStatus"), Image)
            If (Functions.IfNull(e.Row.DataItem("Successful"), False)) Then
                img.ImageUrl = "../../images/icn_green_tick.gif"
            Else
                img.ImageUrl = "../../images/ico_cross.gif"
            End If

        End If
    End Sub


    Protected Sub gvwKeys_Sorting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewSortEventArgs) Handles gvwKeys.Sorting
        Dim Script As String = "setValues('" & e.SortExpression & IIf(e.SortDirection = 1, " DESC", "") & "');"
        ScriptManager.RegisterStartupScript(Me.Page, Me.GetType(), "AssignValues", Script, True)
    End Sub

    Private Sub BindGrid()

        Dim service As New BackupService.FransupportService()
        Dim securityCode As String = Functions.EncryptString128Bit("$M$_Fr@n$upport", ConfigurationManager.AppSettings("SMSXEncryptionKey"))
        Dim data As Byte() = Nothing
        Try
            Dim tmp As String() = ltrFranchiseID.Text.Split("-")
            data = service.GetBackupInformation(HttpUtility.UrlEncode(securityCode), IIf(Session("FranchiseID") = Nothing, 0, tmp(tmp.Length - 1).Trim), ddlShow.SelectedValue, 1, 100, txtFromDate.Text, txtToDate.Text, Session("MyNetsolace_ClientID"))
        Catch ex As Exception
        End Try

        If data IsNot Nothing Then
            Dim ds As DataSet = Nothing
            ds = Functions.DecompressDataSet(data)

            gvwKeys.DataSource = ds.Tables(0)
            gvwKeys.DataBind()
        Else
            gvwKeys.DataSource = Nothing
            gvwKeys.DataBind()
        End If


    End Sub
End Class
