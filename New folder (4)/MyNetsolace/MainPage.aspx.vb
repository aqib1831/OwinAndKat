
Partial Class MyNetsolace_MainPage
    Inherits System.Web.UI.Page
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Me.lftforhelpDesk.Visible = True
        'Me.lftforLicence.Visible = False

        Me.Page.Title = "Netsolace Portal - My Netsolace"
        If Request.QueryString("Module") = "1" Or Request.QueryString("Module") = "" Then
            Me.Master.SelectedIcon = 1 'help desk
            Me.lftforhelpDesk.Visible = True
            Me.lftforLicence.Visible = False
            Me.lftforBilling.Visible = False
			If (Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.NewPoint OR Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.TintWorld OR Context.Session("MyNetsolace_ClientID") = Portal.BLL.Enumeration.ClientID.SaladCreation OR Context.Session("MyNetsolace_ClientID") = 11) And Request.QueryString("Module") = "" Then
                Me.lftforhelpDesk.Visible = False
                Me.lftforLicence.Visible = False
                Me.lftforBilling.Visible = False
                Me.Master.SelectedIcon = 4 'Portal PM
                Response.Redirect("~/Mynetsolace/PM/PMMain.aspx")
                'iframeMain.Attributes.Add("src", "PM/PMMain.aspx")
                Return
            End If
            If Not Request.QueryString("ClientID") Is Nothing AndAlso IsNumeric(Request.QueryString("ClientID")) Then
                'Incase the request is from admin side
                hdnClientId.Value = Request.QueryString("ClientID")
                hdnAreaDeveloperID.Value = Request.QueryString("AreaDeveloperID")
                'Checking if the request is from franchise
                If Not Request.QueryString("FranchiseID") Is Nothing AndAlso IsNumeric(Request.QueryString("FranchiseID")) Then
                    'Portal Franchise Id on the basis of client
                    Dim portalFranchiseId As Integer = 0
                    portalFranchiseId = Portal.BLL.Franchises.GetPortalFranchiseID(CInt(Request.QueryString("FranchiseID")), CInt(hdnClientId.Value))
                    'Showing the page for franchisee
                    If (portalFranchiseId > 0) Then
                        iframeMain.Attributes.Add("src", "FranchiseeInbox.aspx?ClientID=" & hdnClientId.Value & "&FranchiseID=" & portalFranchiseId)
                    Else
                        Response.Redirect("AccessDenied.htm")
                    End If
                    'Portal franchise id to be used in javascript
                    hdnFranchiseId.Value = portalFranchiseId.ToString()
                Else
                    If Not Request.QueryString("ContactID") Is Nothing And IsNumeric(Request.QueryString("ContactID")) Then
                        If Not Request.QueryString("AreaDeveloperID") Is Nothing And IsNumeric(Request.QueryString("AreaDeveloperID")) Then
                            iframeMain.Attributes.Add("src", "AreaDeveloperInbox.aspx?ClientID=" & hdnClientId.Value & "&AreaDeveloperID=" & Request.QueryString("AreaDeveloperID"))
                        End If
                    Else
                        'Showing the page for franchisor                 
                        iframeMain.Attributes.Add("src", "FranchisorInbox.aspx?ClientID=" & hdnClientId.Value)
                    End If
                End If
            End If
            If Not Session("MyNetsolace_ClientID") Is Nothing AndAlso IsNumeric(Session("MyNetsolace_ClientID")) Then
                'Incase the request is from admin side
                hdnClientId.Value = Session("MyNetsolace_ClientID")
                hdnAreaDeveloperID.Value = Session("MyNetsolace_AreaDeveloperID")
                'Checking if the request is from franchise
                If Not Session("FranchiseID") Is Nothing AndAlso IsNumeric(Session("FranchiseID")) Then
                    'Portal Franchise Id on the basis of client
                    Dim portalFranchiseId As Integer = 0
                    portalFranchiseId = Portal.BLL.Franchises.GetPortalFranchiseID(CInt(Session("FranchiseID")), CInt(hdnClientId.Value))
                    'Showing the page for franchisee
                    If (portalFranchiseId > 0) Then
                        iframeMain.Attributes.Add("src", "FranchiseeInbox.aspx?ClientID=" & hdnClientId.Value & "&FranchiseID=" & portalFranchiseId)
                    Else
                        Response.Redirect("AccessDenied.htm")
                    End If
                    'Portal franchise id to be used in javascript
                    hdnFranchiseId.Value = portalFranchiseId.ToString()
                Else
                    If Not Session("ContactID") Is Nothing And IsNumeric(Session("ContactID")) Then
                        If Not Session("MyNetsolace_AreaDeveloperID") Is Nothing And IsNumeric(Session("MyNetsolace_AreaDeveloperID")) Then
                            iframeMain.Attributes.Add("src", "AreaDeveloperInbox.aspx?ClientID=" & hdnClientId.Value & "&AreaDeveloperID=" & Session("MyNetsolace_AreaDeveloperID"))
                        End If
                    Else
                        'Showing the page for franchisor                 
                        iframeMain.Attributes.Add("src", "FranchisorInbox.aspx?ClientID=" & hdnClientId.Value)
                    End If
                End If
            End If
        ElseIf Request.QueryString("Module") = "2" Then
            Me.Master.SelectedIcon = 2 'licence manageent
            Me.lftforhelpDesk.Visible = False
            Me.lftforLicence.Visible = True
            Me.lftforBilling.Visible = False
            iframeMain.Attributes.Add("src", "../LM/LicenseManagement.aspx?PrevPage=MyNetsolace&ddlClient=" & Session("MyNetsolace_ClientID"))
            'ElseIf Request.QueryString("Module") = "3" Then
            '    Me.Master.SelectedIcon = 3 'Billing Report
            '    Me.lftforhelpDesk.Visible = False
            '    Me.lftforLicence.Visible = False
            '    Me.lftforBilling.Visible = True
            '    Dim portalFranchiseId As Integer = 0
            '    If Not Session("MyNetsolace_ClientID") Is Nothing AndAlso IsNumeric(Session("MyNetsolace_ClientID")) _
            '    And Not Session("FranchiseID") Is Nothing AndAlso IsNumeric(Session("FranchiseID")) Then
            '        hdnClientId.Value = Session("MyNetsolace_ClientID")
            '        portalFranchiseId = Portal.BLL.Franchises.GetPortalFranchiseID(CInt(Session("FranchiseID")), CInt(hdnClientId.Value))
            '        iframeMain.Attributes.Add("src", "../MyNetsolace/FranchiseSubscription.aspx?FranchiseID=" & portalFranchiseId & "&ClientID=" & hdnClientId.Value)
            '    Else
            '        Response.Redirect("AccessDenied.htm")
            '    End If
        ElseIf Request.QueryString("Module") = "4" Then
            Me.lftforhelpDesk.Visible = False
            Me.lftforLicence.Visible = False
            Me.lftforBilling.Visible = False
            Me.Master.SelectedIcon = 4 'Portal PM
            iframeMain.Attributes.Add("src", "/PMMain.aspx")
        End If
    End Sub

End Class
