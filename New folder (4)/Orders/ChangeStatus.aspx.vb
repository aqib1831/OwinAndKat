
Partial Class Orders_ChangeStatus
    Inherits System.Web.UI.Page

    Protected Sub btnUpdateStatus_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateStatus.Click
        If (Request.QueryString("OrderID") <> Nothing AndAlso IsNumeric(Request.QueryString("OrderID"))) Then

            Dim orderObj As Portal.BLL.Orders.SCM_Orders = New Portal.BLL.Orders.SCM_Orders()
            Dim returnVal As Integer = 0
            If (CInt(ddlOrderStatus.SelectedValue) <> Portal.BLL.Enumeration.OrderStatus.Shipped) Then
                returnVal = orderObj.UpdateOrderStatus(CInt(ddlOrderStatus.SelectedValue), CInt(Request.QueryString("OrderID")), CInt(Session("AdminID")), txtNotes.Text)
                'Close the div and save
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "parent.CloseDiv();", True)
                ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ReloadPage", "parent.ReloadPage();", True)
            End If

            'After Adding the notes refresh the grid to show new notes.
            gvwOrderHistory.DataBind()
            upOrderHistory.Update()
            If (CInt(ddlOrderStatus.SelectedValue) = Portal.BLL.Enumeration.OrderStatus.Shipped) Then
                'Get the latest status from the database.
                orderObj.GetOrderStatus(CInt(Request.QueryString("OrderID")))
                'If the order status is processed then allow shipment and make entry into db.
                If (orderObj.StatusID = Portal.BLL.Enumeration.OrderStatus.Processed) Then
                    returnVal = orderObj.UpdateOrderStatus(CInt(ddlOrderStatus.SelectedValue), CInt(Request.QueryString("OrderID")), CInt(Session("AdminID")), txtNotes.Text)
                    returnVal = orderObj.Order_ShipingInfo_ADD(CInt(Request.QueryString("OrderID")), CInt(ddlShipVia.SelectedValue), Date.Today, Convert.ToDecimal(txtShipCharges.Text), txtTrackingNo.Text, txtShipNotes.Text, txtETADate.Text)
                    'Close the div and save
                    ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "parent.CloseDiv();", True)
                    ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ReloadPage", "parent.ReloadPage();", True)
                Else
                    cvOrderStatus.IsValid = False
                End If
            Else

            End If


            

            'To show the popup for message confirmation.
            'If (CInt(ddlOrderStatus.SelectedValue) = Portal.BLL.Enumeration.OrderStatus.Shipped) Then
            '    ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ShowMailingDiv", "ShowMailDiv();", True)
            'Else
            '    ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "parent.CloseDiv();", True)
            '    ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ReloadPage", "parent.ReloadPage();", True)
            'End If

        End If

    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateSession(Portal.BLL.Users.EndSessionRedirectPages.Login)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Mail body
        ltrlMailFrom.Text = ConfigurationManager.AppSettings("OrderMailFrom").ToString()
        ltrlMailBody.Text = "Thank you for your order. You will receive an email with the tracking numbers once the order has been shipped."
        ltrlNetsolaceAddress.Text = ConfigurationManager.AppSettings("NetsolaceAddress").ToString.Replace("**", "<br>")
        ltrlSenderName.Text = Session("AdminName").ToString
        ltrlJobTitle.Text = CType(Session("AdminCurrentobjUser"), Portal.BLL.Users).JobTitle
        ltrlSubject.Text = "Order Confirmation"

        'To make the date textboxes readonly
        txtShipDate.Text = Request(txtShipCharges.UniqueID)
        txtETADate.Text = Request(txtETADate.UniqueID)
        'To filter status don't show New and Pending
        If Not IsPostBack Then
            sds_OrdersStatus.FilterExpression = "ID > 2"
        End If

    End Sub

    Protected Sub ddlShipVia_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlShipVia.DataBound
        ddlShipVia.Items.Insert(0, New ListItem("Select...", "0"))
    End Sub

    Protected Sub btnSendMail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendMail.Click
        Dim orderObj As Portal.BLL.Orders.SCM_Orders = New Portal.BLL.Orders.SCM_Orders()
        'Send Mail to the user        
        Dim mail As Portal.BLL.Email
        mail = New Portal.BLL.Email()
        Dim strBody As String = ltrlMailBody.Text
        With mail            
            .MailTo = orderObj.GetEmailAddress(CInt(Request.QueryString("OrderID")))
            .MailFrom = ConfigurationManager.AppSettings("OrderMailFrom").ToString
            .Subject = ltrlSubject.Text
            .Detail = strBody & "<br>" & ltrlSenderName.Text & "<br>" & ltrlJobTitle.Text & "<br>" & ltrlNetsolaceAddress.Text
            .CompletedDate = System.DateTime.Now
            .Send_mail()
        End With

        'To close the div and refresh the previous page.
        If (CInt(ddlOrderStatus.SelectedValue) > 0) Then
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "CloseDiv", "parent.CloseDiv();", True)
            ScriptManager.RegisterClientScriptBlock(Me, Me.GetType(), "ReloadPage", "parent.ReloadPage();", True)
        End If
    End Sub
End Class
