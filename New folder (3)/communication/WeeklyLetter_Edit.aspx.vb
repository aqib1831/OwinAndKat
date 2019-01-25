Imports System.Data.SqlClient
Partial Class admin_comm_WeeklyLetter_Edit
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'Assging the datasource to the templates datalist
            dlstTemplates.DataSource = Portal.BLL.Communication.WeeklyLetter.WeeklyLetter_GetAll_Templates()
            dlstTemplates.DataBind()

            If Request.Params("LetterId") <> Nothing Then
                'Getting the Weekly letter Id from query string
                Dim LId As Integer = CType(Request.QueryString("LetterId"), Integer)
                'Creating the object of Weekly letter class
                Dim weekObj As Portal.BLL.Communication.WeeklyLetter = New Portal.BLL.Communication.WeeklyLetter()
                'Getting the data from db against the Id
                Dim reader As SqlDataReader = weekObj.GetWeeklyLetter_ByID(LId)

                If (reader.HasRows) Then

                    While (reader.Read())
                        txtTitle.Text = reader("Title").ToString()
                        txtToDate.Text = CType(reader("ToDate"), Date).ToShortDateString()
                        txtFromDate.Text = CType(reader("FromDate"), Date).ToShortDateString()
                        Dim templateId As String = CType(reader("TemplateId"), String)

                        For i As Integer = 0 To dlstTemplates.Items.Count - 1
                            If (templateId = dlstTemplates.DataKeys.Item(i).ToString()) Then
                                Dim rbtTemplate As RadioButton = CType(dlstTemplates.Items(i).FindControl("rbtTemplate"), RadioButton)
                                rbtTemplate.Checked = True
                            End If
                        Next
                        'End of for loop

                    End While
                    'End of While loop

                End If
                reader.Close()
            End If

        End If
        End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        Dim templateId As Integer = 0
        'Getting the selected template Id

        For i As Integer = 0 To dlstTemplates.Items.Count - 1

            Dim rbtTemplate As RadioButton = CType(dlstTemplates.Items(i).FindControl("rbtTemplate"), RadioButton)
            If (rbtTemplate.Checked) Then
                templateId = CType(dlstTemplates.DataKeys.Item(i), Integer)
            End If

        Next

        Dim actionId As Integer = 0

        actionId = Portal.BLL.Communication.WeeklyLetter.WeeklyLetter_Update(txtTitle.Text.Trim(), txtToDate.Text, txtFromDate.Text, templateId, CType(Request.Params("LetterId"), Integer))

        If (actionId = 1) Then
            lblOutput.Text = "WeeklyLetter with this name already exists."
        Else
            'Redirecting to the EA weekly letters page.
            Response.Redirect("~/communication/EAWeeklyLetters.aspx?" & Request.QueryString().ToString())
        End If

    End Sub

    Protected Sub dlstTemplates_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles dlstTemplates.ItemDataBound
        If (e.Item.ItemIndex > -1) Then
            Dim script As String = "SetUniqueRadioButton('rbtTemplate.*temp','" & e.Item.FindControl("rbtTemplate").ClientID() & "')"
            Dim rbtTemplate As RadioButton = CType(e.Item.FindControl("rbtTemplate"), RadioButton)
            rbtTemplate.Attributes.Add("onclick", script)
        End If
    End Sub
End Class
