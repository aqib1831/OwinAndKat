Imports System.Data.SqlClient
Imports System.Data
Imports System.Collections.Generic

Partial Class OrderDetailPrint
    Inherits System.Web.UI.Page
    Dim GrandTotal As Decimal = 0.0
    Dim TotalWithoutTax As Decimal = 0.0
    Dim Tax As Decimal = 0.0
    Dim PaymentOption As Integer = 0
    Dim Service As String = String.Empty
    Dim Notes As String = String.Empty
    Dim CCNumber As String = String.Empty
    Dim AccountNumber As String = String.Empty
    Dim StatusID As Integer = 0

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
        Dim orderObj As Portal.BLL.Orders.SCM_Orders = New Portal.BLL.Orders.SCM_Orders()
        Dim transactionObj As Portal.BLL.Accounts.Transaction = New Portal.BLL.Accounts.Transaction()
        Dim returnVal As Integer = 0
        Dim newCCNumber As String = String.Empty


        If String.IsNullOrEmpty(Request.QueryString("OrderID")) = False AndAlso IsNumeric(Request.QueryString("OrderID")) Then
            hdnOrderID.Value = Request.QueryString("OrderID")
            GetDetail()
            'On the basis of payment option show the info
            If (PaymentOption = 1) Then     '1 for credit card.
                btnAuthenticate.Text = "Show CC #"
            Else
                If (PaymentOption = 2) Then '2 for Account No.
                    btnAuthenticate.Text = "Show Account #"
                End If
            End If

            'Check if status is Processed then don't show security code.
            If (StatusID = Portal.BLL.Enumeration.OrderStatus.Shipped OrElse StatusID = Portal.BLL.Enumeration.OrderStatus.Canceled OrElse StatusID = Portal.BLL.Enumeration.OrderStatus.Processed) Then
                txtSecurityCode.Visible = False
                btnAuthenticate.Visible = False
            End If

            If (StatusID = Portal.BLL.Enumeration.OrderStatus.Processed) Then                
                If (PaymentOption = 1) Then     '1 for credit card.
                    newCCNumber = Functions.Encryption("xxxxxxxxxxxx" & Right(CCNumber, 4))
                    orderObj.UpdateCCNumber(CInt(hdnOrderID.Value), newCCNumber)
                    returnVal = transactionObj.AddTransaction(CInt(hdnOrderID.Value), GrandTotal, PaymentOption, newCCNumber, Service, Notes)
                Else
                    If (PaymentOption = 2) Then '2 for Account No.                                                
                        returnVal = transactionObj.AddTransaction(CInt(hdnOrderID.Value), GrandTotal, PaymentOption, AccountNumber, Service, Notes)
                    End If
                End If
            End If
        End If
        lblNotValidSecurityCode.Text = ""

    End Sub

    Protected Sub RptmainProducts_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RptmainProducts.ItemCreated
        If (e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem) Then
            'hdnSerial.Value = CInt(hdnSerial.Value) + 1
        End If
    End Sub
    Protected Sub RptmainProducts_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles RptmainProducts.ItemDataBound
        If e.Item.ItemType = ListItemType.AlternatingItem Or e.Item.ItemType = ListItemType.Item Then
            Dim rpt As Repeater = CType(e.Item.FindControl("rpSubModules"), Repeater)
            Dim ModuleID As Integer = CType(CType(e.Item.FindControl("lblID"), Label).Text, Integer)
            SdsSubModules.FilterExpression = "[ModuleID] = " & ModuleID
            rpt.DataSource = SdsSubModules
            rpt.DataBind()
            If rpt.Items.Count <= 0 Then
                rpt.Visible = False
            End If
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRenderComplete
        Dim lblGrandTotal As New Label
        Dim lblProductTotal As New Label
        Dim lblTax As New Label

        lblGrandTotal = CType(RptmainProducts.Controls(RptmainProducts.Controls.Count - 1).FindControl("lblGrandTotal"), Label)
        lblGrandTotal.Text = FormatNumber(GrandTotal, 2, -1, 0, -1)
        lblProductTotal = CType(RptmainProducts.Controls(RptmainProducts.Controls.Count - 1).FindControl("lblProductTotal"), Label)
        lblProductTotal.Text = FormatNumber(TotalWithoutTax, 2, -1, 0, -1)
        lblTax = CType(RptmainProducts.Controls(RptmainProducts.Controls.Count - 1).FindControl("lblTax"), Label)
        lblTax.Text = FormatNumber(Tax, 2, -1, 0, -1)
    End Sub
    Private Sub GetDetail()
        Dim Rd As SqlDataReader
        Rd = Portal.BLL.Orders.SCM_OrderItems.GetOrderDetailbyID(hdnOrderID.Value)
        If (Rd.Read) Then
            GrandTotal = Convert.ToDecimal(Functions.IfNull(Rd("GrandTotal"), 0))
            StatusID = CInt(Rd("StatusID"))
            TotalWithoutTax = Functions.IfNull(Rd("TotalWithoutTax"), 0)
            Tax = Functions.IfNull(Rd("TaxAmount"), 0)
            PaymentOption = CInt(Rd("PaymentType"))
            AccountNumber = Functions.IfNull(Rd("BankAccount"), "")
            Service = "SCM Order Service"
            Notes = "The order is Being processed."
            CCNumber = Functions.Decryption(Functions.IfNull(Rd("CCNumber"), ""))
        End If
        Rd.Close()
    End Sub

    Protected Sub btnAuthenticate_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim objUsersBll As Portal.BLL.Users = New Portal.BLL.Users()
        Dim colUsers As New List(Of Portal.BLL.Users)()
        Dim UserID As Integer = 0
        Dim OrderID As Integer = 0        
        Dim CCNo As String = String.Empty
        Dim BankAccount As String = String.Empty
        Dim expDate As String = String.Empty

        UserID = HttpContext.Current.Session("AdminID")
        OrderID = hdnOrderID.Value
        colUsers = Portal.BLL.Users.GetUsersByID(UserID)

        Dim strCreditCardSecurityCode As String = colUsers.Item(0).SecurityCode

        If Not String.IsNullOrEmpty(strCreditCardSecurityCode) Then
            If txtSecurityCode.Value = strCreditCardSecurityCode Then
                Dim dr As SqlDataReader
                dr = Portal.BLL.Orders.SCM_OrderItems.GetOrderDetailbyID(OrderID)
                Dim ltrlExpDate As Literal
                ltrlExpDate = FormView4.FindControl("ltrlExpDate")                
                While dr.Read
                    CCNo = Functions.Decryption(Functions.IfNull(dr("CCNumber"), ""))
                    BankAccount = Functions.Decryption(Functions.IfNull(dr("BankAccount"), ""))
                    If (PaymentOption = 1) Then
                        expDate = Functions.DateandYearPart(Functions.IfNull(dr("CCExpirationDate"), ""), "")
                    End If
                End While

                If (PaymentOption = 1) Then         'If payment option is credit card no 
                    Dim litCC As Literal
                    litCC = FormView4.FindControl("litCCNo")                   
                    litCC.Text = CCNo
                    ltrlExpDate.Text = expDate
                    ' Now also log it in history
                    Portal.DAL.Orders.DBSCM_Orders.SCM_OrdersHistory_Add(UserID, OrderID)
                Else
                    If (PaymentOption = 2) Then     'If payment option is account no
                        Dim ltrlAccNo As Literal
                        ltrlAccNo = FormView4.FindControl("ltrlAccNo")
                        ltrlAccNo.Text = BankAccount
                        ' Now also log it in history
                        Portal.DAL.Orders.DBSCM_Orders.SCM_OrdersHistory_Add(UserID, OrderID)
                    End If
                End If
                dr.Close()
            Else
                lblNotValidSecurityCode.Text = "Security code is not valid"
            End If
        End If

    End Sub

End Class
