
Partial Class admin_Legal_Legal_IP_Activities
    Inherits System.Web.UI.Page

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "parent.RightFrame.location='NewActivityNote.aspx?ID=" & e.Row.DataItem("ID") & "&IPID=" & Request.QueryString("ID") & "';")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If


    End Sub

    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'lnkEdit.Attributes.Add("onClick", "parent.parent.MainFrame.location='Legal_IP_Edit.aspx?" & Request.QueryString().ToString() & "&ActivityPage=True'")
        lblActivities.Text = Server.HtmlEncode(Functions.StringTruncate(IntellectualProperty.Legal_GetSingleIPName(CInt(Request.QueryString("ID"))), 40))
        'ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "SelectIpTab", "parent.onPageLoadTRClick('trID_3');", True)
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "parent.RightFrame.location='NewActivityNote.aspx?ID=" & e.Row.DataItem("ID") & "&IPID=" & Request.QueryString("ID") & "';")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
    End Sub

    Protected Sub lnkEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkEdit.Click
        'Response.Redirect("Legal_IP_Edit.aspx?" & Request.QueryString().ToString() & "&ActivityPage=True")
    End Sub

    Protected Sub GridView2_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.DataBound
        lblHistoryCount.Text = GridView2.Rows.Count
    End Sub

    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
        lblincount.Text = GridView1.Rows.Count
    End Sub

    Protected Function SetBackButtonUrl() As String
        If (String.IsNullOrEmpty(Request.QueryString("Source"))) Then
            Return "Legal_Ip"
        Else
            Return Request.QueryString("Source").ToString()
        End If
    End Function
End Class
