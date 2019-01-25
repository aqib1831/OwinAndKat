Imports System.Data.SqlClient

Partial Class admin_comm_EA_Weekly
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim strQry As String
        strQry = Request.QueryString("Forum")

        If strQry = "1" Then
            ltlHeading.Text = "Franchisee Forum"
            trQuote.Visible = True
            trSequence.Visible = False


            'Filtering the weekly letter in which we have a franchise forum
            odsPendingWeekLetters.SelectParameters.Item("HasFranchiseForum").DefaultValue = True
        Else            
            trSequence.Visible = True

            ltrlQuote.Text = "Heading :"
            txtQuote.TextMode = TextBoxMode.SingleLine
            val_Quote.ErrorMessage = "Please enter headline"
            regVal_Quote.ErrorMessage = "Headline cannot be greater than 80 characters."
            regVal_Quote.ValidationExpression = "^[\s\S]{0,80}$"            
        End If

        'RadEditor.ImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
        'RadEditor.UploadImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
        'RadEditor.DeleteImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}

    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim db As New DBAccess()
        Dim ParID As SqlParameter
        Dim intID As Integer = 0
        Dim strQry As String
        Dim reqLetterID As String
        strQry = Request.QueryString("Forum")
        reqLetterID = Request.QueryString("LetterID")  ' This is for redirection purposes. Sajjad Kiyani.


        ParID = CType(db.Parameters, SqlParameterCollection).Add("@ID", Data.SqlDbType.Int)
        ParID.Size = 4
        ParID.Direction = Data.ParameterDirection.Output

        db.AddParameter("@Headline", txtQuote.Text)
        db.AddParameter("@SmallDescription", txtSmallDescription.Text)
        db.AddParameter("@Description", RadEditor.Content)
        If strQry = "1" Then
            db.AddParameter("@Type", 2) ' Forum
            db.AddParameter("@Sequence", 0) ' Forum
        Else
            db.AddParameter("@Type", 1) ' News
            db.AddParameter("@Sequence", txtSequence.Text) ' News
        End If
        db.AddParameter("@SubmittedDate", DateTime.Now)
        db.AddParameter("@Deleted", 0)
        db.AddParameter("@LetterID", CType(ddlWeeklyLetters.SelectedValue, Integer))

        db.AddParameter("@ReturnVal", Data.ParameterDirection.ReturnValue)

        'db.ExecuteNonQuery("WeeklyLetter_News_Add")
        'Inorder to take the weekly letter Id from the drop down list.

        db.ExecuteNonQuery("WeeklyLetter_News_New")

        Dim returnVal As Integer = db.Parameters("@ReturnVal").Value

        If (returnVal = 1) Then  'To check the franchise forum has already been added or not
            vald_WeeklyLetter.IsValid = False
            vald_WeeklyLetter.ErrorMessage = "Already a franchise forum has been added. You can add only one forum for this weekly letter."

        Else
            Dim weekletterObj As Portal.BLL.Communication.WeeklyLetter = New Portal.BLL.Communication.WeeklyLetter()
            Dim templateId As Integer = weekletterObj.WeeklyLetter_GetTemplateId(CInt(ddlWeeklyLetters.SelectedValue))

            intID = ParID.Value.ToString()
            If reqLetterID <> String.Empty Then

                Response.Redirect("EAWeeklyLetters.aspx")

                'Response.Redirect("WeeklyLetter.aspx?LetterID=" & reqLetterID)
                'ClientScript.RegisterStartupScript(Me.GetType, "RedirectPage", "RedirectPage('" & reqLetterID & "');", True)
            Else
                Response.Redirect("EAWeeklyLetters.aspx")
            End If

        End If

    End Sub

    Protected Sub ddlWeeklyLetters_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWeeklyLetters.DataBound
        ddlWeeklyLetters.Items.Insert(0, "Select...")
        If Not String.IsNullOrEmpty(Request.QueryString("LetterId")) Then
            ddlWeeklyLetters.SelectedValue = Request.QueryString("LetterId")
        End If
    End Sub

    Protected Sub lnkAddWeeklyLetter_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAddWeeklyLetter.Click
        Response.Redirect("~/communication/WeeklyLetter_New.aspx?BackAction=add&Forum=" & Request.QueryString("Forum"))

    End Sub
End Class