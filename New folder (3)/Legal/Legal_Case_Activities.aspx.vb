Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_Legal_Legal_IP_Activities
    Inherits System.Web.UI.Page

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "parent.RightFrame.location='NewCaseNote.aspx?ID=" & e.Row.DataItem("ID") & "&CaseID=" & Request.QueryString("ID") & "';")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If

    End Sub

    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
        ' ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "SelectIpTab", "parent.parent.onPageLoadTRClick('trID_2');", True)
        Dim cm As CaseMgmt = New CaseMgmt()
        Dim dr As SqlDataReader = cm.GetSingleCase(CInt(Request.QueryString("ID")))
        dr.Read()
        lblTitle.Text = Server.HtmlEncode(Functions.StringTruncate(dr.Item("Title").ToString(), 45))
        dr.Close()
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "parent.RightFrame.location='NewCaseNote.aspx?ID=" & e.Row.DataItem("ID") & "&CaseID=" & Request.QueryString("ID") & "';")
            e.Row.Attributes.Add("onmouseover", "this.className='HighlightedHomeRow';")
            e.Row.Attributes.Add("onmouseout", "this.className='SimpleHomeRow';")
        End If
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
