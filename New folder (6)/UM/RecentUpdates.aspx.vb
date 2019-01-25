
Partial Class UM_RecentUpdate
    Inherits System.Web.UI.Page
    Dim rowcount As Integer = 0

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub gvTopics_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If Not (e.Row Is Nothing) AndAlso e.Row.RowType = DataControlRowType.Header Then
            If gvTopics.SortExpression.ToString() = "" Then
                Dim button As LinkButton = DirectCast(e.Row.Cells(1).Controls(0), LinkButton) 'By default grid is sorted on Admin name
                If Not (button Is Nothing) Then
                    ' button.Text += " &nbsp;<img src='../images/asc.gif' title='Sort descending' style='vertical-align:middle;'  />"
                End If
            Else
                For Each cell As TableCell In e.Row.Cells
                    If cell.HasControls Then
                        Dim button As LinkButton = DirectCast(cell.Controls(0), LinkButton)
                        If Not (button Is Nothing) Then
                            If gvTopics.SortExpression = button.CommandArgument Then
                                If gvTopics.SortDirection = SortDirection.Ascending Then
                                    '      button.Text += " &nbsp;<img src='../images/asc.gif' title='Sort descending' style='vertical-align:middle;'  />"
                                Else
                                    '    button.Text += " &nbsp;<img src='../images/desc.gif' title='Sort ascending' style='vertical-align:middle;'  />"
                                End If
                            End If
                        End If
                    End If
                Next
            End If
        End If
    End Sub

    Protected Sub gvTopics_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvTopics.DataBound
        lblCategoryCount.Text = rowcount.ToString()
        If ((rowcount Mod 2) <> 0) Then
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "ChangeClass", "ChangeRowsClass();", True)
        End If
    End Sub

    Protected Sub gvTopics_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvTopics.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            rowcount += 1
        End If
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Attributes.Add("onclick", "this.className='selectedRow';javascript:window.location='NewTopic.aspx?TopicID=" & e.Row.DataItem("ID") & "&NavigateTo=RecentUpdates" & "&UMType=" & e.Row.DataItem("UMType") & "'")


        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        rowcount = 0
        If IsPostBack = False Then
            ClientScript.RegisterStartupScript(Me.GetType(), "SelectTab", "javascript:parent.SetSelected(5);", True)
        End If

    End Sub
End Class