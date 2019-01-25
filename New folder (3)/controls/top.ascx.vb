Imports System.Data
Imports System.Data.SqlClient
Imports Portal.BLL

Partial Class LMS_top
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

     
        Dim curUser As Users = CType(Session.Item("AdminCurrentobjUser"), Users)
        lblAdminName.Text = curUser.Name
        If (curUser.ID = 3165 OR curUser.ID = 3164 OR Portal.BLL.Enumeration.Users.Khurram_Ali = curUser.ID Or Portal.BLL.Enumeration.Users.Rana_Khurram = curUser.ID ) Then
            testStoreDiv.Style.Add("display", "inline")
        Else
            testStoreDiv.Style.Add("display", "none")
        End If

        IconHome.Attributes("onclick") = "javascript:window.location='" & ResolveClientUrl("~/Home.aspx") & "';"
        If _SelectedIcon = Enumeration.Modules.Home Then
            IconHome.Attributes("class") = "TopBarHover"
        Else
            IconHome.Attributes("class") = "TopBarSimple"
            IconHome.Attributes("onmouseover") = "this.className='TopBarHover';"
            IconHome.Attributes("onmouseout") = "this.className='TopBarSimple';"
        End If

    End Sub
   
    Protected Sub lbtnSignout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbtnSignout.Click
        Users.RemoveUserFromApplication(CType(Session("AdminID"), Integer))
        Response.Redirect("~/Login.aspx")
    End Sub

    Protected Sub rptTopMenu_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptTopMenu.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem OrElse e.Item.ItemType = ListItemType.Item Then
            Dim lbl As Label
            Dim tbl As HtmlTable
            lbl = CType(e.Item.FindControl("lblID"), Label)
            tbl = CType(e.Item.FindControl("menutblID"), HtmlTable)
            tbl.Attributes.Add("onclick", "window.location='" & ResolveClientUrl(e.Item.DataItem("URL").ToString) & "';")
            Start = e.Item.DataItem("URL").ToString().LastIndexOf("/") + 1
            Length = IIf(e.Item.DataItem("URL").ToString().IndexOf("?") = -1, (e.Item.DataItem("URL").ToString().Length - (e.Item.DataItem("URL").ToString().LastIndexOf("/") + 1)), e.Item.DataItem("URL").ToString().IndexOf("?") - (e.Item.DataItem("URL").ToString().LastIndexOf("/") + 1))
            Url = e.Item.DataItem("URL").ToString().Substring(Start, Length).ToUpper()
            Start = Request.RawUrl.ToString().LastIndexOf("/") + 1
            Length = IIf(Request.RawUrl.ToString().IndexOf("?") = -1, (Request.RawUrl.ToString().Length - (Request.RawUrl.ToString().LastIndexOf("/") + 1)), Request.RawUrl.ToString().IndexOf("?") - (Request.RawUrl.ToString().LastIndexOf("/") + 1))
            RawUrl = Request.RawUrl.ToString().Substring(Start, Length).ToUpper()
            If RawUrl.Equals(Url) Or Request.RawUrl.Contains("Home.aspx") Then
                Authenticated = True
            End If
            If _SelectedIcon = CInt(lbl.Text) Then
                tbl.Attributes.Add("class", "TopBarHover")
                tbl.Attributes("onmouseover") = "this.className='TopBarHover';"
                tbl.Attributes("onmouseout") = "this.className='TopBarHover';"
            End If
        ElseIf e.Item.ItemType = ListItemType.Footer Then
            'If Not Authenticated Then
            '    Response.Redirect("~/Home.aspx")
            'End If
        End If
    End Sub
   
End Class
