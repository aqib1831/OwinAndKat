
Partial Class admin_comm_compose_new
    Inherits System.Web.UI.Page

    Protected blnShowEmailToAllFranchiseeLink As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            ClientScript.RegisterStartupScript(Me.GetType(), "tbleShow", "showOptionsTbl();", True)
            hdnPinCode.Value = Session("Admin_AuthenticationPIN")
            'blnShowEmailToAllFranchiseeLink = Admin.ShowEmailToAllFranchiseeLink(Session("Admin_AdminID"))

            If blnShowEmailToAllFranchiseeLink Then
                trEmergencyOne.Visible = True
                trEmergencyTwo.Visible = True
            End If
        End If

    End Sub
    
End Class
