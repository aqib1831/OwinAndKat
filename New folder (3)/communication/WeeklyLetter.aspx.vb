Imports System.Net

Partial Class admin_comm_WeeklyLetter
    Inherits System.Web.UI.Page

    Dim strTemplatePath As String = String.Empty

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim reqLetterID As String = String.Empty
        Dim reqWeeklyLetterNewsID As String = String.Empty
        Dim reqDeleted As String = String.Empty
        Dim reqMoveUp As String = String.Empty
        Dim reqMoveDown As String = String.Empty
        Dim reqViewSt As String = String.Empty
        Dim reqStoreEmployee As String = String.Empty

        reqDeleted = Request.QueryString("Delete")
        reqMoveUp = Request.QueryString("MoveUp")
        reqMoveDown = Request.QueryString("MoveDown")
        reqLetterID = Request.QueryString("LetterID")
        reqWeeklyLetterNewsID = Request.QueryString("ID")
        reqViewSt = Request.QueryString("viewst")
        reqStoreEmployee = Request.QueryString("StoreEmployee")

        Dim weeklyletterObj As Portal.BLL.Communication.WeeklyLetter = New Portal.BLL.Communication.WeeklyLetter()
        Dim tblTemplate As Data.DataTable = weeklyletterObj.WeeklyLetterTemplate_GetByLetterID(reqLetterID)

        strTemplatePath = Functions.GetUrlDomain & "/Portal/Communication/WeeklyLetterTemplates/" & tblTemplate.Rows(0).Item("FilePath").ToString

        strTemplatePath = strTemplatePath & "?LetterID=" & reqLetterID & "&ID=" & reqWeeklyLetterNewsID & "&Delete=" & reqDeleted & "&MoveUp=" & reqMoveUp & "&MoveDown=" & reqMoveDown & "&viewst=" & reqViewSt & "&StoreEmployee=" & reqStoreEmployee
        Dim wcMicrosoft As WebClient
        Dim objUTF8Encoding As UTF8Encoding
        Dim strResponse As String

        wcMicrosoft = New WebClient
        objUTF8Encoding = New UTF8Encoding
        strResponse = objUTF8Encoding.GetString(wcMicrosoft.DownloadData(strTemplatePath))

        Response.Write(strResponse)

    End Sub

End Class

