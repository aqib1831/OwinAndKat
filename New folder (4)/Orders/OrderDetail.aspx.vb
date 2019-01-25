Imports System.Data.SqlClient
Imports System.Data

Partial Class OrderDetail
    Inherits System.Web.UI.Page
    Dim GrandTotal As Integer = 0.0
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
        'If (IsPostBack = False) Then
        '    Dim strDomainName = String.Empty
        '    strDomainName = ConfigurationManager.AppSettings("NetsolaceURL")
        '    If Request.ServerVariables.Item("HTTP_HOST").ToLower() <> ("www." & strDomainName) Then
        '        Response.Redirect(IIf(Request.IsSecureConnection, "https://www.", "http://www.") & strDomainName & Request.RawUrl)
        '    End If
        'End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("OrderID")) = False AndAlso IsNumeric(Request.QueryString("OrderID")) Then
            ' To get the status of the order every time.
            Dim orderObj As Portal.BLL.Orders.SCM_Orders = New Portal.BLL.Orders.SCM_Orders()
            Dim statusID As Integer = 0
            orderObj.GetOrderStatus(CInt(Request.QueryString("OrderID")))
            lblOrderStatus.Text = orderObj.OrderStatus
            statusID = orderObj.StatusID
            hdnOrderID.Value = Request.QueryString("OrderID")
            lblOrderNo.Text = Request.QueryString("OrderID")

            If Not IsPostBack Then      'If first time show new then update status
                Dim retrunVal As Integer = 0
                Dim notes As String = String.Empty
                'If the order status is new update it to pending.
                If (statusID = Portal.BLL.Enumeration.OrderStatus.NewOrder) Then
                    retrunVal = orderObj.UpdateOrderStatus(CInt(Portal.BLL.Enumeration.OrderStatus.Pending), CInt(Request.QueryString("OrderID")), CInt(Session("AdminID")), "")
                End If            
            End If
            'If the order status is shipped
            If (statusID = Portal.BLL.Enumeration.OrderStatus.Shipped) Then
                tdShippingInfo.Visible = True
            End If

            'If the order status is shipped or canceled
            If (statusID = Portal.BLL.Enumeration.OrderStatus.Shipped OrElse statusID = Portal.BLL.Enumeration.OrderStatus.Canceled) Then
                tdSetStatus.Visible = False
            End If

        End If
    End Sub

   
End Class
