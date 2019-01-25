
Partial Class admin_comm_WeeklyLetter_New
    Inherits System.Web.UI.Page

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'Inserted item id will be stored in it
        Dim addId As Integer = 0
        'The selected weekly letter template Id will be stored in it
        Dim templateId As Integer = 0

        'Getting the selected template Id

        For i As Integer = 0 To dlstTemplates.Items.Count - 1

            Dim rbtTemplate As RadioButton = CType(dlstTemplates.Items(i).FindControl("rbtTemplate"), RadioButton)
            If (rbtTemplate.Checked) Then
                templateId = CType(dlstTemplates.DataKeys.Item(i), Integer)
            End If

        Next

        'adding the weekly letter to the database.
        addId = Portal.BLL.Communication.WeeklyLetter.WeeklyLetter_Add(txtTitle.Text.Trim(), CType(txtToDate.Text, Date), CType(txtFromDate.Text, Date), templateId)

        If (addId = 1) Then         'If the a weekletter with this name already exits
            lblOutput.Text = "WeekLetter with this 'Title' Already exists"
        Else
            'Redirecting to the EA weekly letters page.
            If (Request.QueryString("BackAction") = Nothing OrElse Request.QueryString("BackAction").Equals("")) Then
                Response.Redirect("~/communication/EAWeeklyLetters.aspx?" & Request.QueryString().ToString())
            Else
                Dim queryValue As String = Request.Params("BackAction").ToString()
                If (queryValue.Equals("add")) Then
                    Response.Redirect("~/communication/WeeklyLetter_Add.aspx?LetterId=" & addId & "&Forum=" & Request.QueryString("Forum"))
                ElseIf (queryValue.Equals("edit")) Then
                    Response.Redirect("~/communication/WeeklyLetter_Add.aspx?LetterId=" & addId & "&Forum=" & Request.QueryString("Forum"))
                End If
            End If
        End If
    End Sub

    Protected Sub dlstTemplates_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlstTemplates.ItemDataBound

        If (e.Item.ItemIndex > -1) Then
            Dim script As String = "SetUniqueRadioButton('rbtTemplate.*temp','" & e.Item.FindControl("rbtTemplate").ClientID() & "')"
            Dim rbtTemplate As RadioButton = CType(e.Item.FindControl("rbtTemplate"), RadioButton)
            rbtTemplate.Attributes.Add("onclick", script)
        End If

        If Not IsPostBack Then
            If (e.Item.ItemIndex = 0) Then
                Dim rbtTemplate As RadioButton = CType(e.Item.FindControl("rbtTemplate"), RadioButton)
                rbtTemplate.Checked = True
            End If
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            dlstTemplates.DataSource = Portal.BLL.Communication.WeeklyLetter.WeeklyLetter_GetAll_Templates()
            dlstTemplates.DataBind()
        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        If (Request.Params("BackAction") = Nothing) Then
            Response.Redirect("EAWeeklyLetters.aspx?" & Request.QueryString().ToString())
        Else
            If (Request.Params("BackAction").Equals("add")) Then
                Response.Redirect("~/communication/WeeklyLetter_Add.aspx?Forum=" & Request.QueryString("Forum"))
            End If
            If (Request.Params("BackAction").Equals("edit")) Then
                Response.Redirect("~/communication/WeeklyLetter_Update.aspx?Forum=" & Request.QueryString("Forum"))
            End If
        End If

    End Sub
End Class
