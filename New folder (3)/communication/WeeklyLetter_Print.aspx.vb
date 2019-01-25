
Partial Class admin_comm_WeeklyLetter_Print
    Inherits System.Web.UI.Page

    Protected Sub rptNewsHeadlines_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptNewsHeadlines.PreRender

        If rptNewsHeadlines.Items.Count = 0 Then
            ltlHeadlinesNoRecord.Visible = True
            rptNewsHeadlines.Visible = False
        Else
            ltlHeadlinesNoRecord.Visible = False
            rptNewsHeadlines.Visible = True
        End If

    End Sub


    Protected Sub FormView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.PreRender

        If FormView1.DataItemCount < 1 Then
            trForumHeadline1.Visible = False
            trForumHeadline2.Visible = False
            tblFranchiseForum.Visible = False
        Else
            trForumHeadline1.Visible = True
            trForumHeadline2.Visible = True
            tblFranchiseForum.Visible = True
        End If

    End Sub

    Protected Sub srcNews_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles srcNews.Selecting
        If Request.QueryString("StoreEmployee") = "1" Then
            srcNews.FilterExpression = "ForStoreEmployee=1"
        End If
    End Sub

End Class
