
Partial Class MyNetsolace_AreaDeveloperHistory
    Inherits System.Web.UI.Page

    Protected Sub ddlFranchises_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFranchises.DataBound
        ddlFranchises.Items.Insert(0, New ListItem("Show All", "0"))
    End Sub
    Protected Sub odsHistory_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceStatusEventArgs) Handles odsHistory.Selected
        If (IsNumeric(e.ReturnValue)) Then
            ltrlActivityCount.Text = e.ReturnValue
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Make the date textboxes readonly
        txtDateFrom.Text = Request(txtDateFrom.UniqueID)
        txtDateTo.Text = Request(txtDateTo.UniqueID)

        hdnAreaDeveloperID.Value = Session("MyNetsolace_AreaDeveloperID")
        If Not IsPostBack Then
            'Assignging a date time within a week
            txtDateTo.Text = DateTime.Now.ToShortDateString()
            txtDateFrom.Text = DateTime.Now.AddDays(-7).ToShortDateString()
            If Not Request.QueryString("ClientID") Is Nothing And IsNumeric(Request.QueryString("ClientID")) Then
                hdnClientId.Value = Request.QueryString("ClientID")
            Else
                hdnClientId.Value = Portal.BLL.Enumeration.ClientID.SaladCreation
            End If

        End If
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeSelected", "parent.SetTrBackGround(2);", True)
    End Sub

    Protected Sub gvwHistory_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvwHistory.RowDataBound
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow'")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow'")
            e.Row.Attributes.Add("onclick", "ShowDetail(" & DataBinder.Eval(e.Row.DataItem, "ActivityID") & "," & DataBinder.Eval(e.Row.DataItem, "FranchiseID") & "," & DataBinder.Eval(e.Row.DataItem, "ClientID") & ");")
        End If
    End Sub
End Class
