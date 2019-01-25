Imports System.Data.SqlClient

Partial Class admin_comm_WeeklyLetter_Update
    Inherits System.Web.UI.Page

    Dim templateId As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim strQry As String
            Dim strID As String
            strQry = Request.QueryString("Forum")
            strID = Request.QueryString("ID")

            If strQry = "1" Then

                'Filtering the weekly letter in which we have a franchise forum                 
                odsPendingWeekLetters.SelectParameters.Item("HasForum").DefaultValue = True
                ltlHeading.Text = "Franchisee Forum :"
                tdSequence.Visible = False
            Else
                tdSequence.Visible = True
                ltrlQuote.Text = "Heading :"
                txtQuote.TextMode = TextBoxMode.SingleLine
                val_Quote.ErrorMessage = "Please enter headline"
                regVal_Quote.ErrorMessage = "Headline cannot be greater than 80 characters."
                regVal_Quote.ValidationExpression = "^[\s\S]{0,80}$"
            End If

            hdnID.Value = strID

            Dim db As New DBAccess
            Dim rdr As SqlDataReader

            db.AddParameter("@ID", strID)

            rdr = db.ExecuteReader("WeeklyLetter_News_GetByID")

            If rdr.Read Then
                txtQuote.Text = rdr("HeadLine")
                txtSequence.Text = rdr("Sequence")
                txtSmallDescription.Text = rdr("SmallDescription")
                RadEditor.Html = rdr("Description")

  
            End If

            RadEditor.ImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
            RadEditor.UploadImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}
            RadEditor.DeleteImagesPaths = New String() {ConfigurationManager.AppSettings("radEditorImagesPath").ToString()}

            rdr.Close()
            'btnCancel.Attributes.Add("Onclick", "window.location='EAWeeklyLetters.aspx';")
        End If

    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim db As New DBAccess
        Dim reqLetterID As String
        reqLetterID = Request.QueryString("LetterID")

        db.AddParameter("@ID", hdnID.Value)
        db.AddParameter("@Headline", txtQuote.Text)
        db.AddParameter("@SmallDescription", txtSmallDescription.Text)
        db.AddParameter("@Sequence", txtSequence.Text)
        db.AddParameter("@Description", RadEditor.Html)
        db.AddParameter("@LetterID", CType(ddlWeeklyLetters.SelectedValue, Integer))


        db.ExecuteNonQuery("WeeklyLetter_News_Update")

        Dim weekletterObj As Portal.BLL.Communication.WeeklyLetter = New Portal.BLL.Communication.WeeklyLetter()
        templateId = weekletterObj.WeeklyLetter_GetTemplateId(CInt(Request.QueryString("LetterID")))

        If reqLetterID <> String.Empty Then
            'Response.Redirect("WeeklyLetter_Head.aspx?AdminMgmt=1&IsPublished=False&LetterID=" & reqLetterID & "&TemplateId=" & templateId)
            ClientScript.RegisterClientScriptBlock(Me.GetType, "", " parent.window.location='WeeklyLetter_Head.aspx?AdminMgmt=1&IsPublished=False&LetterID=" & reqLetterID & "&TemplateId=" & templateId & "';", True)
        Else
            Response.Redirect("EAWeeklyLetters.aspx")
        End If

    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        'Dim reqLetterID As String
        'reqLetterID = Request.QueryString("LetterID")
        ''Creating weekly letter object to get the template id for the specific letter
        'Dim weekletterObj As Portal.BLL.Communication.WeeklyLetter = New Portal.BLL.Communication.WeeklyLetter()

        'If reqLetterID <> String.Empty Then
        '    templateId = weekletterObj.WeeklyLetter_GetTemplateId(reqLetterID)
        '    Response.Redirect("WeeklyLetter_Head.aspx?AdminMgmt=1&IsPublished=False&LetterID=" & reqLetterID & "&TemplateId=" & templateId)
        'Else
        '    Response.Redirect("EAWeeklyLetters.aspx")
        'End If
        Response.Redirect("EAWeeklyLetters.aspx")

    End Sub

    Protected Sub ddlWeeklyLetters_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlWeeklyLetters.DataBound
        ddlWeeklyLetters.Items.Insert(0, "Select...")
        If (Request.QueryString("LetterID") <> Nothing) Then
            ddlWeeklyLetters.SelectedValue = Request.QueryString("LetterID")
        End If
    End Sub
End Class
