Imports System.IO
Imports System.Net
Imports System.Data.SqlClient

Partial Class admin_comm_WeeklyLetter_Head
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Dim reqContactID As String = String.Empty
            Dim reqPublished As String
            Dim reqLetterID As String
            Dim iFrameURL As String
            Dim reqFranHistory As String
            Dim reqFranchiseeList As String
            Dim reqAdminID As String = String.Empty
            'Dim reqAdminMgmt As String
            'Dim reqAdminHome As String = String.Empty
            'Dim reqFranHome As String = String.Empty
            'Dim reqStoreEmployee As String = String.Empty
            Dim intLetterNewsCount As Integer = 0

            reqPublished = Request.QueryString("IsPublished")
            reqLetterID = Request.QueryString("LetterID")
            reqFranHistory = Request.QueryString("FranHistory")
            reqFranchiseeList = Request.QueryString("FranchiseeList")
            'reqStoreEmployee = Request.QueryString("StoreEmployee")

            If reqLetterID <> String.Empty And reqLetterID <> "0" Then
                hdnLetterID.Value = reqLetterID
                intLetterNewsCount = Portal.BLL.Communication.WeeklyLetter.WeeklyLetter_GetNewsCount(reqLetterID)
            End If

            If Not Session("AdminID") Is Nothing Then
                reqAdminID = Session("AdminID")
            End If

            'If Not Session("Fran_FranchiseID") Is Nothing Then
            '    reqContactID = Franchisee.GetLoggedInContactID()
            'End If

            'reqAdminHome = Request.QueryString("AdminHome")
            'reqFranHome = Request.QueryString("FranHome")
            'reqAdminMgmt = Request.QueryString("AdminMgmt")

            btnPublish.Visible = False
            btnBack.Visible = True
            btnBackFranchisee.Visible = False
            btnFranchiseContinue.Visible = False
            btnAdminContinue.Visible = False

            iFrameURL = "WeeklyLetter.aspx?LetterID=" & reqLetterID & "&IsPublished=" & reqPublished

            'If reqContactID <> String.Empty And reqFranHome <> String.Empty Then
            '          Dim dbLetterFranchise As New DBAccess
            '          Dim rdrLetterFranchise As SqlDataReader
            '          reqLetterID = String.Empty
            '          dbLetterFranchise.AddParameter("@ContactID", reqContactID)
            '          If reqStoreEmployee = "1" Then
            '              rdrLetterFranchise = dbLetterFranchise.ExecuteSingleRecordReader("WeeklyLetter_GetPendingByFranContactID_ForStore")
            '          Else
            '              rdrLetterFranchise = dbLetterFranchise.ExecuteSingleRecordReader("WeeklyLetter_GetPendingByFranContactID")
            '          End If

            '          If rdrLetterFranchise.Read Then
            '              reqLetterID = rdrLetterFranchise("ID")
            '              hdnLetterID.Value = reqLetterID
            '          End If
            '          rdrLetterFranchise.Close()

            '          If reqLetterID = String.Empty Then
            '               FranchisesSettings.CheckFreshFlyrerToShow(Session("Fran_FranchiseID"))
            '              If reqStoreEmployee = "1" Then
            '                  Response.Redirect("/franchisee/manager_main.asp")
            '              Else
            '                  Response.Redirect("/franchisee/notices_view.asp")
            '              End If
            'End If
            '    btnFranchiseContinue.Visible = True
            '    iFrameURL = "WeeklyLetter_Published.aspx?LetterID=" & reqLetterID & "&StoreEmployee=" & reqStoreEmployee
            'End If

            If CBool(reqPublished) = "True" Then
                iFrameURL = "WeeklyLetter_Published.aspx?LetterID=" & reqLetterID
                btnPublish.Visible = False

            ElseIf CBool(reqPublished) = "False" And intLetterNewsCount > 0 Then
                btnPublish.Visible = True
                iFrameURL = "WeeklyLetter.aspx?LetterID=" & reqLetterID & "&IsPublished=" & reqPublished
            End If

            'If reqFranchiseeList <> String.Empty Then
            '    iFrameURL = "WeeklyLetter_Published.aspx?LetterID=" & reqLetterID & "&StoreEmployee=" & reqStoreEmployee
            '    btnBackFranchisee.Visible = True
            'End If

            'If reqAdminMgmt <> String.Empty Then
            '    btnBack.Visible = True
            'End If

            'If reqAdminID <> String.Empty Then

            'Dim dbLetter As New DBAccess
            'Dim rdrLetter As SqlDataReader
            'reqLetterID = String.Empty
            'Dim LastPasswordChanged As DateTime = DateTime.Now

            'dbLetter.AddParameter("@UserID", reqAdminID)
            'rdrLetter = dbLetter.ExecuteReader("WeeklyLetter_GetPendingByUserID")
            'If rdrLetter.Read Then
            '    reqLetterID = rdrLetter("ID")
            '    hdnLetterID.Value = reqLetterID
            'End If
            'rdrLetter.Close()


            'btnPublish.Visible = True


            'End If

            frameWeeklyLetter.Attributes.Add("src", iFrameURL)
            btnPublish.Attributes.Add("onclick", "if(confirm('Are you sure to publish this weekly?') == true){document.getElementById('WaitingDiv').style.display='inline'; SetPosition(); return true;} else {return false;}")
        End If
    End Sub

    Protected Sub btnPublish_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPublish.Click
        Dim reqLetterID As String
        Dim strResponse As String
        Dim strResponseForStoreEmployee As String
        Dim intNewsCountForStore As Integer = 0

        reqLetterID = Request.QueryString("LetterID")

        'intNewsCountForStore = Portal.BLL.Communication.WeeklyLetter.WeeklyLetter_GetNewsCountForStore(reqLetterID)
        ' Make Weekly letter publish
        Portal.BLL.Communication.WeeklyLetter.MakePublish(reqLetterID)

        ' Get the HTML of Weeklyletter
        strResponse = GetHTMLOfLetter(reqLetterID)
        'If intNewsCountForStore > 0 Then
        '    strResponseForStoreEmployee = GetHTMLOfLetterForStoreEmployee(reqLetterID)
        'Else
        strResponseForStoreEmployee = String.Empty
        'End If

        ' Update Description of Weeklyletter by the HTML of Weekly letter
        Portal.BLL.Communication.WeeklyLetter.UpdateDescription(reqLetterID, strResponse, strResponseForStoreEmployee)

        'Send Email to all Franchises
        SendEmailToAllAdmins(strResponse, reqLetterID, strResponseForStoreEmployee, intNewsCountForStore)

        Response.Redirect("commmain.aspx")
    End Sub

    Sub SendEmailToAllAdmins(ByVal MailBody As String, ByVal LetterID As String, ByVal ResponseForStoreEmployee As String, ByVal NewsCountForStore As Integer)
        'Dim rdrFranchises As SqlDataReader
        'Dim rdrAdminEmails As SqlDataReader
        Dim dbFranchises As New DBAccess(Data.CommandType.Text)
        Dim strSubject As String = String.Empty
        Dim strMessageBody As String = String.Empty
        ' Dim intEmailID As Integer
        ' Dim intNewsId As Integer
        ' Dim intActivityID As Integer
        ' Dim intFranchiseEmailID As Integer
        Dim strActivityDescription As String
        Dim strEmailText As String = String.Empty
        Dim blnForManager As Boolean = False

        'Dim objAdmin As New Admin
        'objAdmin.AdminID = Session("AdminID")
        'objAdmin.LoadAdminInformation()

        If NewsCountForStore > 0 Then
            blnForManager = True
        End If

        strSubject = GetSubject(LetterID)
        strMessageBody = MailBody
        'strActivityDescription = strSubject & " has been emailed. Click <a href='#'  onclick=window.open('" & ConfigurationManager.AppSettings("NewFransupportURL") & "admin/Comm/WeeklyLetter_Head.aspx?FranHistory=1&LetterID=" & LetterID & "&StoreEmployee='+document.getElementById('FranchiseContactType').value);>here</a> to view this letter."
        strActivityDescription = strSubject & " has been posted. Please view this newsletter for important and time sensitive information under communication."

        'intEmailID = Portal.BLL.Email.LogEmail(objAdmin.AdminID, 0, objAdmin.CorporateEmail, objAdmin.FirstName & " " & objAdmin.LastName, objAdmin.DepartmentID, "All Franchises", String.Empty, String.Empty, String.Empty, String.Empty, String.Empty, String.Empty, strSubject, strMessageBody, False, False, False, DateTime.Now, "Owner", False, False, String.Empty, 0, String.Empty, String.Empty, 8, String.Empty)
        Portal.BLL.News.News.NewsAdd(DateTime.Now, strSubject, strMessageBody, False, True, Request.QueryString("LetterID"), Session("AdminID"))

        Dim colUsers As New System.Collections.Generic.List(Of Portal.BLL.Users)()
        colUsers = Portal.BLL.Users.GetAll(0, 0, 0, 0, "Null", 0, "", 1000, 0, "")


        ' Now send Email to Admins also
        For index As Integer = 0 To colUsers.Count - 1

            ' While rdrAdminEmails.Read
            strEmailText = GetFranchiseEmail()

            strEmailText = strEmailText.Replace("***OWNERNAME***", colUsers.Item(index).Name)
            strEmailText = strEmailText.Replace("***EAIWEEKLYNAME***", strSubject)

            If Not String.IsNullOrEmpty(colUsers.Item(index).Email) Then
                ' Code to send Email
                Dim objEmail As Portal.BLL.Email
                objEmail = New Portal.BLL.Email
                With objEmail
                    .DisplayName = Session("AdminName")
                    .MailTo = colUsers.Item(index).Email
                    .MailFrom = Session("AdminName") & "<" & Session("Email") & ">"
                    .Subject = strSubject
                    .Detail = strEmailText 'strMessageBody
                    .Attachments = ""
                    '.Send_mail()
                End With
                objEmail = Nothing
            End If
        Next
        

    End Sub

    Function GetSubject(ByVal LetterID As String) As String

        Dim strFromDate As DateTime
        Dim strToDate As DateTime
        Dim dbLetter As New DBAccess
        Dim rdrLetter As SqlDataReader
        Dim strSubject As String = String.Empty

        dbLetter.AddParameter("@ID", LetterID)
        rdrLetter = dbLetter.ExecuteReader("WeeklyLetter_GetByID")

        If rdrLetter.Read Then

            strFromDate = rdrLetter("FromDate")
            strToDate = rdrLetter("ToDate")

            If String.IsNullOrEmpty(strFromDate) = False Then
                strSubject = rdrLetter("Title") & " (" & strFromDate.ToString("M") & " - " & strToDate.ToString("M") & ", " & Year(strToDate) & ")"
            Else
                strSubject = rdrLetter("Title")
            End If

        End If

            rdrLetter.Close()

            Return strSubject

    End Function

    Function GetHTMLOfLetter(ByVal LetterID As String) As String

        Dim wcMicrosoft As WebClient
        Dim objUTF8Encoding As UTF8Encoding
        Dim strResponse As String
        Dim strURL As String
        Dim weeklyletterObj As Portal.BLL.Communication.WeeklyLetter = New Portal.BLL.Communication.WeeklyLetter()
        Dim tblTemplate As Data.DataTable = weeklyletterObj.WeeklyLetterTemplate_GetByLetterID(LetterID)

        strURL = Functions.GetUrlDomain & "/Portal/Communication/WeeklyLetterTemplates/" & tblTemplate.Rows(0).Item("FilePath").ToString & "?viewst=false&LetterID=" & LetterID
        'Commented 
        ' strURL = ConfigurationManager.AppSettings("NewFransupportURL") & "Communication/WeeklyLetter.aspx?viewst=false&LetterID=" & LetterID

        wcMicrosoft = New WebClient
        objUTF8Encoding = New UTF8Encoding

        strResponse = objUTF8Encoding.GetString(wcMicrosoft.DownloadData(strURL))
        Return strResponse
    End Function

    

    Protected Sub btnBack_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnBack.Click
        Response.Redirect("commmain.aspx")
    End Sub

    

    Protected Sub btnAdminContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdminContinue.Click

        Dim reqLetterID As String
        Dim reqAdminID As String

        reqLetterID = hdnLetterID.Value
        reqAdminID = Session("AdminID")

        ' Add Admin in weekly letter
        Portal.BLL.Communication.WeeklyLetter.AdminsAdd(reqLetterID, reqAdminID)

        Response.Redirect("WeeklyLetter_Head.aspx?AdminHome=1")

    End Sub

    Function GetFranchiseEmail() As String

        Dim objStreamReader As StreamReader
        Dim strReturn As String = String.Empty

        If File.Exists(MapPath("WeeklyLetterTemplates/weekly_mail_template.htm")) Then
            objStreamReader = File.OpenText(MapPath("WeeklyLetterTemplates/weekly_mail_template.htm"))
            strReturn = objStreamReader.ReadToEnd
            objStreamReader.Close()
        End If
        Return strReturn

    End Function
End Class
