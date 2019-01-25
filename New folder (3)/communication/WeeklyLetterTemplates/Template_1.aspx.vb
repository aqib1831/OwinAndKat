
Partial Class admin_comm_WeeklyLetterTemplates_Template_2
    Inherits System.Web.UI.Page

    Dim FirstRow As Boolean = True
    Dim WeeklyNewsIDForLastItem As String
    Dim LetterIDForLastItem As String
    Dim isPublished As Boolean = False

    Protected Sub rptNewsDetail_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptNewsDetail.ItemDataBound
        Dim l As New Literal
        Dim isRepeterHasRow As Boolean

        isRepeterHasRow = False
        If e.Item.ItemType = ListItemType.Item OrElse e.Item.ItemType = ListItemType.AlternatingItem Then
            isRepeterHasRow = True
            isPublished = CType(e.Item.DataItem("IsPublished"), Boolean)
            If isPublished = False Then

                l = e.Item.FindControl("ltlEditNewsLink")
                'l.Text = "&nbsp;<a href='#' onclick="" parent.location='WeeklyLetter_update.aspx?id=" & e.Item.DataItem("ID") & "&LetterID=" & e.Item.DataItem("LetterID") & "';"">Edit</a>" & _
                '         "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to delete this headline?"");' href=WeeklyLetter.aspx?Delete=1&id=" & e.Item.DataItem("ID") & "&LetterID=" & e.Item.DataItem("LetterID") & ">Delete</a>"
                l.Text = "&nbsp;<a href='#' onclick="" parent.parent.window.location='CommMain.aspx?GoToEdit=True&ID=" & e.Item.DataItem("ID") & "&LetterID=" & e.Item.DataItem("LetterID") & "';"">Edit</a>" & _
                        "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to delete this headline?"");' href=WeeklyLetter.aspx?Delete=1&id=" & e.Item.DataItem("ID") & "&LetterID=" & e.Item.DataItem("LetterID") & ">Delete</a>"

                If FirstRow = True Then
                    l.Text = l.Text & "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to move down this headline?"");' href=WeeklyLetter.aspx?MoveDown=1&id=" & e.Item.DataItem("ID") & "&LetterID=" & e.Item.DataItem("LetterID") & ">Move Down</a>"
                    FirstRow = False
                Else
                    l.Text = l.Text & "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to move up this headline?"");' href=WeeklyLetter.aspx?MoveUp=1&id=" & e.Item.DataItem("ID") & "&LetterID=" & e.Item.DataItem("LetterID") & ">Move Up</a>"
                    l.Text = l.Text & "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to move down this headline?"");' href=WeeklyLetter.aspx?MoveDown=1&id=" & e.Item.DataItem("ID") & "&LetterID=" & e.Item.DataItem("LetterID") & ">Move Down</a>"
                End If

                WeeklyNewsIDForLastItem = e.Item.DataItem("ID")
                LetterIDForLastItem = e.Item.DataItem("LetterID")

            End If
        End If

        If e.Item.ItemType = ListItemType.Footer Then
            If isPublished = False Then

                Dim intItemCount As Integer
                Dim ltlLast As Literal

                intItemCount = rptNewsDetail.Items.Count
                If intItemCount = 1 Then
                    ltlLast = CType(rptNewsDetail.Items(intItemCount - 1).FindControl("ltlEditNewsLink"), Literal)
                    'ltlLast.Text = "&nbsp;<a href='#' onclick="" parent.location='WeeklyLetter_update.aspx?id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & "';"">Edit</a>" & _
                    '               "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to delete this headline?"");' href=WeeklyLetter.aspx?Delete=1&id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & ">Delete</a>"
                    ltlLast.Text = "&nbsp;<a href='#' onclick=""parent.parent.window.location='CommMain.aspx?GoToEdit=True&ID=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & "';"">Edit</a>" & _
                                   "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to delete this headline?"");' href=WeeklyLetter.aspx?Delete=1&id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & ">Delete</a>"

                    ' parent.location='WeeklyLetter_update.aspx?id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & "';
                End If

                If intItemCount > 1 Then
                    ltlLast = CType(rptNewsDetail.Items(intItemCount - 1).FindControl("ltlEditNewsLink"), Literal)
                    'ltlLast.Text = "&nbsp;<a href='#' onclick="" parent.location='WeeklyLetter_update.aspx?id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & "';"">Edit</a>" & _
                    '                   "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to delete this headline?"");' href=WeeklyLetter.aspx?Delete=1&id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & ">Delete</a>" & _
                    '                   "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to move up this headline?"");' href=WeeklyLetter.aspx?MoveUp=1&id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & ">Move Up</a>"

                    ltlLast.Text = "&nbsp;<a href='#' onclick=""parent.parent.window.location='CommMain.aspx?GoToEdit=True&ID=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & "';"">Edit</a>" & _
                                      "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to delete this headline?"");' href=WeeklyLetter.aspx?Delete=1&id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & ">Delete</a>" & _
                                      "&nbsp;|&nbsp;<a onclick='return confirm(""Are you sure, to move up this headline?"");' href=WeeklyLetter.aspx?MoveUp=1&id=" & WeeklyNewsIDForLastItem & "&LetterID=" & LetterIDForLastItem & ">Move Up</a>"
                End If
            End If
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim hdnStatus As HiddenField
        Dim hdnForumID As HiddenField
        Dim hdnLetterID As HiddenField
        Dim reqWeeklyLetterNewsID As String = String.Empty
        Dim reqDeleted As String = String.Empty
        Dim reqMoveUp As String = String.Empty
        Dim reqMoveDown As String = String.Empty
        Dim reqLetterID As String = String.Empty
        Dim reqViewSt As String = String.Empty

        reqViewSt = Request.QueryString("viewst")

        reqDeleted = Request.QueryString("Delete")
        reqMoveUp = Request.QueryString("MoveUp")
        reqMoveDown = Request.QueryString("MoveDown")
        reqLetterID = Request.QueryString("LetterID")
        reqWeeklyLetterNewsID = Request.QueryString("ID")
        hdnStatus = frmViewWeeklyLetter.FindControl("hdnStatus")
        hdnLetterID = frmViewWeeklyLetter.FindControl("hdnLetterID")

        If reqViewSt = "false" Then
            Page.EnableViewState = False
        End If

        If reqDeleted <> String.Empty And reqWeeklyLetterNewsID <> String.Empty Then
            DeleteWeeklyNews(reqWeeklyLetterNewsID)
        End If

        If reqMoveUp <> String.Empty And reqWeeklyLetterNewsID <> String.Empty Then
            MoveUpWeeklyNews(reqWeeklyLetterNewsID, reqLetterID)
        End If

        If reqMoveDown <> String.Empty And reqWeeklyLetterNewsID <> String.Empty Then
            MoveDownWeeklyNews(reqWeeklyLetterNewsID, reqLetterID)
        End If

        If CType(hdnStatus.Value, Boolean) = False Then

        Else
            'btnPublish.Visible = False
            'btnContinue.Visible = False
        End If

        ltlTitle.Text = CType(frmViewWeeklyLetter.FindControl("hdnLetterTitle"), HiddenField).Value

    End Sub

    Protected Sub rptNewsHeadlines_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptNewsHeadlines.PreRender

        If rptNewsHeadlines.Items.Count = 0 Then
            ltlHeadlinesNoRecord.Visible = True
            rptNewsHeadlines.Visible = False
        Else
            ltlHeadlinesNoRecord.Visible = False
            rptNewsHeadlines.Visible = True
        End If

    End Sub

    Sub DeleteWeeklyNews(ByVal id As Integer)
        Dim db As New DBAccess

        db.AddParameter("@ID", id)
        db.ExecuteNonQuery("WeeklyLetter_News_Delete")

    End Sub

    Sub MoveUpWeeklyNews(ByVal id As Integer, ByVal LetterID As String)
        Dim db As New DBAccess

        db.AddParameter("@ID", id)
        db.AddParameter("@LetterID", LetterID)
        db.ExecuteNonQuery("WeeklyLetter_News_MoveUp")

    End Sub

    Sub MoveDownWeeklyNews(ByVal id As Integer, ByVal LetterID As String)
        Dim db As New DBAccess

        db.AddParameter("@ID", id)
        db.AddParameter("@LetterID", LetterID)
        db.ExecuteNonQuery("WeeklyLetter_News_MoveDown")

    End Sub

    Protected Sub srcNews_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ObjectDataSourceSelectingEventArgs) Handles srcNews.Selecting
        If Request.QueryString("StoreEmployee") = "1" Then
            srcNews.FilterExpression = "ForStoreEmployee=1"
        End If
    End Sub

End Class
