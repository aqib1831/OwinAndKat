Imports System.Web.Configuration
Imports Portal.BLL
Imports System.Data.SqlClient
Imports System.Web

Partial Public Class Portal_main
    Inherits System.Web.UI.MasterPage

    Private _RenderCalenderScripts As Boolean = False
    Private _RenderCalenderFunctions As Boolean = False
    Private _RenderWindowFunctions As Boolean = False
    Private _SelectedIcon As Portal.BLL.Enumeration.Modules = -1 'User.Modules.Home

    Public Property SelectedIcon() As Portal.BLL.Enumeration.Modules
        Get
            Return _SelectedIcon
        End Get
        Set(ByVal value As Portal.BLL.Enumeration.Modules)
            _SelectedIcon = value
        End Set
    End Property

    Public Property RenderCalendarScripts() As Boolean
        Get
            Return _RenderCalenderScripts
        End Get
        Set(ByVal value As Boolean)
            _RenderCalenderScripts = value
        End Set
    End Property

    Public Property RenderCalenderFunctions() As Boolean
        Get
            Return _RenderCalenderFunctions
        End Get
        Set(ByVal value As Boolean)
            _RenderCalenderFunctions = value
        End Set
    End Property

    Public Property RenderWindowFunctions() As Boolean
        Get
            Return _RenderWindowFunctions
        End Get
        Set(ByVal value As Boolean)
            _RenderWindowFunctions = value
        End Set
    End Property

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init

        ' Browser Support Check
        Functions.CheckForIEAndMac()

        ' Check For Session
        Users.AuthenticateSession(Users.EndSessionRedirectPages.Login)

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim ScriptTag As New Literal()
        ScriptTag.Text = "<script type="" text/javascript"" language=""javascript"" src=""" & ResolveClientUrl("~/scripts/functions.js") & """ ></script>"
        Page.Header.Controls.Add(ScriptTag)

        If _RenderCalenderScripts Then
            Dim CalenderScriptTag As New Literal()
            CalenderScriptTag.Text = "<script type=""text/javascript"" language=""javascript"" src=""" & ResolveClientUrl("~/scripts/calendar.js") & """ ></script><script type=""text/javascript"" language=""javascript"" src=""" & ResolveClientUrl("~/scripts/calendar-en.js") & """ ></script>"
            Page.Header.Controls.Add(CalenderScriptTag)
        End If
        If _RenderCalenderFunctions Then
            Dim CalenderScriptTag As New Literal()
            CalenderScriptTag.Text = "<script type=""text/javascript"" language=""javascript"" src=""" & ResolveClientUrl("~/scripts/calendar-fs.js") & """ ></script>"
            Page.Header.Controls.Add(CalenderScriptTag)
        End If
        If _RenderWindowFunctions Then
            Dim WindowScriptTag As New Literal()
            WindowScriptTag.Text = "<script type=""text/javascript"" language=""javascript"" src=""" & ResolveClientUrl("~/scripts/ferantlib.js") & """ ></script>"
            Page.Header.Controls.Add(WindowScriptTag)
        End If

        ucTop1.SelectedIcon = _SelectedIcon
    End Sub

End Class