
Partial Class HR_HRMainNew
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Me.Master.SelectedIcon = Portal.BLL.Enumeration.Modules.HumanResourceManagment
    End Sub
End Class
