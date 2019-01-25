Imports Portal.BLL.PM
Imports Portal.DAL.PM
Imports System.Collections.Generic
Imports System.Data

Partial Class MyNetsolaceClient_PM_Survey
    Inherits System.Web.UI.Page
    Protected ListOfQuestion As List(Of String)
    Protected ListOfAnswers As List(Of String)



    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Portal.BLL.Users.AuthenticateMyNetsolaceSession()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim SQ As DataTable = Portal.BLL.PM.PM_Ticket_Features.DisplayQuestion()







        Q1.InnerText = SQ.Rows(0).Item(1)
        Q2.InnerText = SQ.Rows(1).Item(1)
        Q3.InnerText = SQ.Rows(2).Item(1)
        Q4.InnerText = SQ.Rows(3).Item(1)

        ListOfQuestion = New List(Of String)
        ListOfAnswers = New List(Of String)

        Dim colTicket_Features As New List(Of PM_Ticket_Features)()
        Dim objTicket_FeaturesBll As Portal.BLL.PM.PM_Ticket_Features = New Portal.BLL.PM.PM_Ticket_Features()
        colTicket_Features = PM_Ticket_Features.PM_Ticket_FeaturesGetByID(Request.QueryString("ID"))
        If colTicket_Features.Count > 0 Then
            If colTicket_Features.Item(0).UserID > 0 Then
                lblCustomerName.Text = colTicket_Features.Item(0).UserName
            ElseIf colTicket_Features.Item(0).ClientContactID > 0 Then
                lblCustomerName.Text = colTicket_Features.Item(0).ClientContactName
            End If

            lblSubject.Text = Functions.StringTruncate(colTicket_Features.Item(0).Name, 50)
            lblCompletionDate.Text = Functions.FormatShortDate(colTicket_Features.Item(0).ConfirmedSolvedDate)
        End If

    End Sub


    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objSurveyResult As New PM_Survey_Result
        Dim ObjNotes As PM_Notes = New PM_Notes()
        'Dim S As String = "false"
        'If rdoQ2No.Checked Then
        '    S = "True"
        'End If
        'ListOfAnswers.Add(TextBox1.Text)
        'ListOfAnswers.Add(S)
        'ListOfAnswers.Add(TextBox2.Text)
        'ListOfAnswers.Add(txtQ4.Text)

        'With objSurveyResult
        '    .Ticket_Feature_id = Request.QueryString("id")
        '    .ClientContactid = Session("MyNetsolace_ClientContactID")


        '    '.Answer = TextBox1.Text
        '    'If rdoQ2No.Checked Then
        '    '    .Answer2 = True
        '    'End If
        '    '.Answer3 = TextBox2.Text
        '    '.Answer6 = txtQ4.Text



        '    'rdoQ5No.Checked Then
        '    '    .Answer5 = 2
        '    'ElseIf rdoQ5NA.Checked Then
        '    '    .Answer5 = 3
        '    'End If

        '    '.Answer6 = txtQ6.Text
        '    '.Comments = txtComments.Text
        '    .Signature = txtSignature.Text
        'End With

        'DBPM_Survey_Result.ADD(objSurveyResult)
        Dim dt As DataTable = GetTable()
        Portal.BLL.PM.PM_Ticket_Features.AddAnswer(dt)

        With ObjNotes
            .Ticket_Feature_ID = Request.QueryString("id")
            .Notes = GenerateHTMLForNote()
            .SubmittedBy = Nothing
            .ClientContactID = Session("MyNetsolace_ClientContactID")
            .DateEntered = DateTime.Now
            .TimeSpent = "00:00:00"
            .IsByAdmin = 1
            .Notes_Add()
        End With

        Response.Redirect("TicketsDetail.aspx?" & Request.QueryString.ToString())

    End Sub

    Private Function GenerateHTMLForNote() As String
        Dim strHTMLForNotes As New StringBuilder
        strHTMLForNotes.Append("<table cellpadding=""0"" cellspacing=""0"" border=""0"" style=""width: 100%;height:auto;"" class=""tblSurveyQuestionsDisplay"">" & _
                        "<tr>" & _
                            "<td valign=""top"" class=""Gray"">1. Please rate the final product that was delivered on a rating scale of 1-10, where 1 is ‘below expectations’ and 10 is ‘exceeds expectations'.</td>" & _
                            "<td valign=""top"" class=""Gray"">" & TextBox1.Text & "</td>" & _
                        "</tr>" & _
                        "<tr>" & _
                            "<td valign=""top"">2. Was the final product delivered per the project plan timeline?</td>" & _
                            "<td valign=""top"">" & rdoQ2Yes.SelectedValue & "</td>" & _
                        "</tr>" & _
                        "<tr>" & _
                            "<td valign=""top"" class=""Gray"">3.Please rate your satisfaction with how the project was managed on a rating scale of 1-10, where 1 is ‘below expectations’ and 10 is ‘exceeds expectations'.</td>" & _
                           "<td valign=""top"" class=""Gray"">" & TextBox2.Text & "</td>" & _
                        "</tr>" & _
                        "<tr>" & _
                            "<td valign=""top"">4. What could we have done better? Please add comments and feedback below</td>" & _
                        "</tr>" & _
                        "<tr>" & _
                             "<td colspan=""2"" style=""min-height:80px;word-break:break-all;"" valign=""top"" class=""Gray"">" & IIf(txtQ4.Text <> String.Empty, txtQ4.Text, "<font color=""#cfcfcd"">No Comments</font>") & "</td>" & _
                        "</tr>" & _
                  "</table>")
        Return strHTMLForNotes.ToString()
    End Function

    Function GetTable() As DataTable
        ' Create new DataTable instance.
        Dim table As New DataTable

        ' Create four typed columns in the DataTable.
        table.Columns.Add("QID", GetType(Integer))
        table.Columns.Add("Answers", GetType(String))
        table.Columns.Add("Signature", GetType(String))
        table.Columns.Add("ClientContactid", GetType(Integer))
        table.Columns.Add("Ticket_Feature_Id", GetType(Integer))
        table.Columns.Add("EnteredDate", GetType(DateTime))
        ' Add five rows with those columns filled in the DataTable.
        'For Each item As String In ListOfQuestion
        '    table.Rows.Add(item)
        'Next
        Dim SQ As DataTable = Portal.BLL.PM.PM_Ticket_Features.DisplayQuestion()



        For Each row As DataRow In SQ.Rows
            ListOfQuestion.Add(row.Item(0))
        Next
        Dim Radio As String = "Yes"

        table.Rows.Add(ListOfQuestion.Item(0), TextBox1.Text, txtSignature.Text, Session("MyNetsolace_ClientContactID"), Request.QueryString("id"), DateTime.Now)
        table.Rows.Add(ListOfQuestion.Item(1), Radio, txtSignature.Text, Session("MyNetsolace_ClientContactID"), Request.QueryString("id"), DateTime.Now)
        table.Rows.Add(ListOfQuestion.Item(2), TextBox2.Text, txtSignature.Text, Session("MyNetsolace_ClientContactID"), Request.QueryString("id"), DateTime.Now)
        table.Rows.Add(ListOfQuestion.Item(3), txtQ4.Text, txtSignature.Text, Session("MyNetsolace_ClientContactID"), Request.QueryString("id"), DateTime.Now)


        Return table
    End Function
End Class