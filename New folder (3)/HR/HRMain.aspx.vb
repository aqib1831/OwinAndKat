
Partial Class HR_HRMain
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.HumanResourceManagment
        ClientScript.RegisterStartupScript(Me.GetType(), "highLight", "<script language=javascript> ChangeTrBackGround(1);</script>")
        If CheckSubModuleAccess() = False Then
            ClientScript.RegisterStartupScript(Me.GetType, "HideRow", "HideRow();", True)
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

End Class
