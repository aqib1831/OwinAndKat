Imports System.Data
Imports System.Data.SqlClient
Imports Portal.BLL
Partial Class TopControl
    Inherits System.Web.UI.UserControl
    Protected Authenticated As Boolean = False
    Private _SelectedIcon As Enumeration.Modules = Enumeration.Modules.Home
    Dim RawUrl As String = ""
    Dim Url As String = ""
    Dim Start As Integer = 0
    Dim Length As Integer = 0
    
    Public Property SelectedIcon() As Enumeration.Modules
        Get
            Return _SelectedIcon
        End Get
        Set(ByVal value As Enumeration.Modules)
            _SelectedIcon = value
        End Set
    End Property

    Protected Sub rptModules_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptModules.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim lbl As Label
            Dim tbl As HtmlTable
            lbl = CType(e.Item.FindControl("lblID"), Label)
            tbl = CType(e.Item.FindControl("menutblID"), HtmlTable)
            If CInt(lbl.Text) = Portal.BLL.Enumeration.Modules.LMS Then
                tbl.Attributes.Add("onclick", "window.open('" & ResolveClientUrl(e.Item.DataItem("URL").ToString) & "','LMS','','');")
            ElseIf CInt(lbl.Text) = Portal.BLL.Enumeration.Modules.FranMail Then
                Dim dr As SqlDataReader
                Dim strUserName As String = String.Empty
                Dim strPassword As String = String.Empty
                Dim ID As Integer = Session("AdminID")
                dr = Users.GetLoginInfo_ByUserID(Session("AdminID"))
                If dr.Read Then
                    strUserName = dr("FranMail_UserName")
                    strPassword = dr("FranMail_Password")
                End If
                dr.Close()
                If strUserName.Contains("@netsolace.com.pk") Then
                    'tbl.Attributes.Add("onclick", "window.open('LogInToFranMail.aspx','Mail','','');")
		    tbl.Attributes.Add("onclick", "window.open('" & ResolveClientUrl("~/LogInToFranMail.aspx") & "','Mail','','');")
                ElseIf strUserName.Contains("@netsolace.com") Then
                    Session("Admin_LogInName") = strUserName.Replace("@netsolace.com", "")
                    'tbl.Attributes.Add("onclick", "window.open(' MailSignIn.aspx','Mail','','');")
		    tbl.Attributes.Add("onclick", "window.open('" & ResolveClientUrl("~/MailSignIn.aspx") & "','Mail','','');")
                End If

            Else
                tbl.Attributes.Add("onclick", "window.location='" & ResolveClientUrl(e.Item.DataItem("URL").ToString) & "';")
            End If

            Start = e.Item.DataItem("URL").ToString().LastIndexOf("/") + 1
            Length = IIf(e.Item.DataItem("URL").ToString().IndexOf("?") = -1, (e.Item.DataItem("URL").ToString().Length - (e.Item.DataItem("URL").ToString().LastIndexOf("/") + 1)), e.Item.DataItem("URL").ToString().IndexOf("?") - (e.Item.DataItem("URL").ToString().LastIndexOf("/") + 1))
            Url = e.Item.DataItem("URL").ToString().Substring(Start, Length).ToUpper()
            Start = Request.RawUrl.ToString().LastIndexOf("/") + 1
            Length = IIf(Request.RawUrl.ToString().IndexOf("?") = -1, (Request.RawUrl.ToString().Length - (Request.RawUrl.ToString().LastIndexOf("/") + 1)), Request.RawUrl.ToString().IndexOf("?") - (Request.RawUrl.ToString().LastIndexOf("/") + 1))
            RawUrl = Request.RawUrl.ToString().Substring(Start, Length).ToUpper()
            If RawUrl.Equals(Url) Or Request.RawUrl.Contains("Home.aspx") Then
                Authenticated = True
            End If
            If Session("UserBrowser") = "AppleMAC-Safari" Then
                If CInt(lbl.Text) = Portal.BLL.Enumeration.Modules.URLM Then
                    _SelectedIcon = Portal.BLL.Enumeration.Modules.URLM
                End If
            End If
            If _SelectedIcon = CInt(lbl.Text) Then
                tbl.Attributes.Add("class", "TopLinkHover")
                tbl.Attributes("onmouseover") = "this.className='TopLinkHover';"
                tbl.Attributes("onmouseout") = "this.className='TopLinkHover';"
                Dim td As HtmlTableCell = CType(e.Item.FindControl("td"), HtmlTableCell)
                Dim tdC As HtmlTableCell = CType(e.Item.FindControl("tdC"), HtmlTableCell)
                tdC.Style.Add("display", "inline")
                td.Attributes.Add("onmouseover", "ShowCaption(this);")
                td.Attributes.Add("onmouseout", "ShowCaption(this);")
            Else
                tbl.Attributes.Add("class", "")
                tbl.Attributes("onmouseover") = "this.className='TopLinkHover';"
                tbl.Attributes("onmouseout") = "this.className='';"
                Dim td As HtmlTableCell = CType(e.Item.FindControl("td"), HtmlTableCell)
                td.Attributes.Add("onmouseover", "ShowCaption(this);")
                td.Attributes.Add("onmouseout", "HideCaption(this);")
            End If
            If Session("UserBrowser") = "AppleMAC-Safari" Then
                tdP.Visible = False ' For Home Module
                If CInt(lbl.Text) = Portal.BLL.Enumeration.Modules.URLM Then
                    e.Item.Visible = True
                    'tbl.Attributes.Add("style", "background-color:#FFB600;font-size:9px;cursor:pointer; height:30px;")
                ElseIf CInt(lbl.Text) = Portal.BLL.Enumeration.Modules.ProjectManagement Then
                    e.Item.Visible = True
                    'tbl.Attributes.Add("style", "background-color:#FFB600;font-size:9px;cursor:pointer; height:30px;")
                Else
                    e.Item.Visible = False
                    Exit Sub
                End If
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
	'Dim curUser As Users = CType(Session.Item("AdminCurrentobjUser"), Users)
        lblAdminName.Text = Session("AdminName")
        If (Portal.BLL.Enumeration.Users.Khurram_Ali = Session("AdminID") Or Portal.BLL.Enumeration.Users.Rana_Khurram = Session("AdminID") Or Portal.BLL.Enumeration.Users.Ijaz_Aslam = Session("AdminID") Or Session("AdminID") = 3165 Or Session("AdminID") = 3164 ) Then
            testStoreDiv.Style.Add("display", "inline")
        Else
            testStoreDiv.Style.Add("display", "none")
        End If

        IconHome.Attributes("onclick") = "javascript:window.location='" & ResolveClientUrl("~/Home.aspx") & "';"
        If _SelectedIcon = Enumeration.Modules.Home Then
            IconHome.Attributes("class") = "TopLinkHover"
            tdCHome.Style.Add("display", "inline")
        Else
            IconHome.Attributes("class") = ""
            IconHome.Attributes.Add("onmouseover", "ShowHomeC();")
            IconHome.Attributes.Add("onmouseout", "HideHomeC();")
        End If
        If Session("UserBrowser") = "AppleMAC-Safari" Then
            spnChangePassword.Visible = False
        End If

    End Sub

    Protected Sub lbtnSignout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSignout.Click
        Users.RemoveUserFromApplication(CType(Session("AdminID"), Integer))
        Response.Redirect("~/Login.aspx")
    End Sub
    Protected Sub rptModules_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rptModules.PreRender
        Dim hasURLMAccess As Boolean = False
        If Session("UserBrowser") = "AppleMAC-Safari" Then
            If (rptModules.Items.Count > 0) Then
                For count As Integer = 0 To rptModules.Items.Count - 1
                    If rptModules.Items.Item(count).ItemType = ListItemType.Item Or rptModules.Items.Item(count).ItemType = ListItemType.AlternatingItem Then
                        If CType(rptModules.Items.Item(count).FindControl("lblID"), Label).Text = Portal.BLL.Enumeration.Modules.URLM OR CType(rptModules.Items.Item(count).FindControl("lblID"), Label).Text = Portal.BLL.Enumeration.Modules.ProjectManagement Then
                            hasURLMAccess = True
                        End If
                    End If
                Next
            End If
            If hasURLMAccess = False Then
                Session.Clear()
                Response.Redirect("~/NonSupportedBrowser.aspx")
            End If
        End If
    End Sub
End Class