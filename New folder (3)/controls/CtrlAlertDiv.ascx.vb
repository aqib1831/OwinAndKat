Imports Portal.BLL.Enumeration
Partial Class UserControls_CtrlAlertDiv
    Inherits System.Web.UI.UserControl
    

    Public Event MyClick()

#Region "Local Variables"

    Private l_HeaderText As String
    Private l_DetailInfo As String
    Private l_top As Integer = 500
    Private l_ErrorType As AlertType
    Private l_showCloseButton As Boolean

#End Region

#Region "Public Properties"

    Public Property HeaderText() As String
        Get
            Return lblHeadertext.Text
        End Get
        Set(ByVal value As String)
            lblHeadertext.Text = value
        End Set
    End Property

    Public Property DetialInfo() As String
        Get
            Return lblError.Text
        End Get
        Set(ByVal value As String)
            lblError.Text = value
        End Set
    End Property

    Public Property Visibility() As Boolean
        Get
        End Get

        Set(ByVal value As Boolean)
            divError.Style.Add("visibility", IIf(value, "visible", "hidden"))
        End Set

    End Property

    Public Property ErrorType() As Portal.BLL.Enumeration.AlertType
        Get
            Return l_ErrorType
        End Get

        Set(ByVal value As Portal.BLL.Enumeration.AlertType)
            If value = Portal.BLL.Enumeration.AlertType.ShowError Then
                ImgErrorType.ImageUrl = "../Images/icn_error.gif"
            ElseIf value = Portal.BLL.Enumeration.AlertType.ShowInfo Then
                ImgErrorType.ImageUrl = "../Images/ico_info.gif"
            ElseIf value = Portal.BLL.Enumeration.AlertType.ShowCritical Then
                ImgErrorType.ImageUrl = "../Images/icn_info.gif"
            ElseIf value = Portal.BLL.Enumeration.AlertType.ShowLoading Then
                ImgErrorType.ImageUrl = "../Images/icn_loading.gif"
            ElseIf value = Portal.BLL.Enumeration.AlertType.ShowRight Then
                ImgErrorType.ImageUrl = "../Images/ico_tick.gif"
            ElseIf value = Portal.BLL.Enumeration.AlertType.ShowWrong Then
                ImgErrorType.ImageUrl = "../Images/ico_cross.gif"
            Else
                ImgErrorType.Visible = False
            End If

        End Set

    End Property

    Public Property ShowCloseButton() As Boolean

        Get
            Return l_showCloseButton
        End Get
        Set(ByVal Value As Boolean)
            If Value = False Then
                imgClose.Src = "../Images/div_hdr_rt1.gif"
                btnClose.Visible = False
            End If
        End Set
    End Property

#End Region

#Region "Page_Load"


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim objClientScriptManager As ClientScriptManager
        objClientScriptManager = Page.ClientScript

        Dim functionStr As String = "function closeDiv(controlId)    {   hideAniDiv(getElement(controlId));      } "

        If objClientScriptManager.IsClientScriptBlockRegistered("closingdiv") = False Then
            objClientScriptManager.RegisterClientScriptBlock(Me.GetType(), "closingdiv", functionStr, True)
        End If
    End Sub

#End Region

#Region "Custom Events"

#Region "btnMy_Click"

    Protected Sub btnMy_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMy.Click
        RaiseEvent MyClick()
    End Sub

#End Region

#End Region

End Class
