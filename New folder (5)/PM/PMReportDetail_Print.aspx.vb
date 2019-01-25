
Partial Class PM_PMReportDetail
    Inherits System.Web.UI.Page
    Protected PageCount As Integer = CInt(ConfigurationManager.AppSettings("PageCount"))
    Protected LastPage As Integer = 1 + PageCount
    Protected FirstPage As Integer = 1
    Protected CommandArgs As String = ""
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objStringBuilder As New StringBuilder()

        If Not Request.QueryString("StartDate") Is Nothing AndAlso Not Request.QueryString("EndDate") Is Nothing Then
            objStringBuilder.Append("Date ( " + Request.QueryString("StartDate") + " - " + Request.QueryString("EndDate").ToString() + " )</br>")
        End If
        If Not Request.QueryString("ClientId") = 0 Then
            objStringBuilder.Append("Client :  " + Request.QueryString("ClientName") + "</br>")
        End If
        If Not Request.QueryString("CategoryId") = 0 Then
            objStringBuilder.Append("Category :  " + Request.QueryString("CategoryName") + "</br>")
        End If
        If Not Request.QueryString("TeamId") = 0 Then
            objStringBuilder.Append("Team :  " + Request.QueryString("TeamName") + "</br>")
        End If
        If Not Request.QueryString("UserId") = 0 Then
            objStringBuilder.Append("User :  " + Request.QueryString("UserName") + "</br>")
        End If
        If Not Request.QueryString("Type") = 0 Then
            objStringBuilder.Append("Type :  " + Request.QueryString("TypeName") + "</br>")
        End If

        ltrlFilters.Text = objStringBuilder.ToString()
    End Sub

   
    Protected Sub rptrPMStats_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptrPMStats.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim time As String = "0:00"
            Dim strArray() As String
            If Not e.Item.DataItem("TimeAsString") Is DBNull.Value Then
                strArray = e.Item.DataItem("TimeAsString").ToString.Split(":")
                If strArray(1).Length = 0 Then
                    time = strArray(0) + ":" + "00"
                ElseIf strArray(1).Length = 1 Then
                    time = strArray(0) + ":" + "0" + strArray(1)
                Else
                    time = e.Item.DataItem("TimeAsString")
                End If
            End If
            CType(e.Item.FindControl("lblTimeSpent"), Label).Text = time
        End If
    End Sub
End Class