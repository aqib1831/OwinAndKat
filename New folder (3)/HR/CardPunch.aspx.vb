Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports Portal.BLL.HR

Partial Class HR_CardPunch
    Inherits System.Web.UI.Page
    'Change the Server Time Zone Before Uploading defined in Web.config
    Private l_LateReason As String = Nothing
    Private CousultHR As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        txtEmployeeID.Text = Request(txtEmployeeID.UniqueID)
        txtEmployeeID.Focus()
        ScriptManager.GetCurrent(Me).SetFocus(txtEmployeeID)
    End Sub

    Protected Sub btnEmployeeLogin_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnEmployeeLogin.Click
        Dim intReturnValue As Integer
        intReturnValue = AuthenticateUser()
        lbErrMessage.Text = intReturnValue
        ''intReturnValue = -1
        If txtEmployeeID.Text.Length = 0 Then
            lbErrMessage.Text = "Please enter Login"
        Else
            If intReturnValue < 0 Then
                If intReturnValue = -1 Then
                    lbErrMessage.Text = "Invalid User!"
                    Me.txtEmployeeID.Text = ""
                    Me.lbErrMessage.ForeColor = Drawing.Color.Red
                ElseIf intReturnValue = -2 Then
                    lbErrMessage.Text = "Invalid User!"
                    Me.lbErrMessage.ForeColor = Drawing.Color.Red
                End If
            Else
                tblLogin.Visible = False
                tblPunch.Visible = True

                hdnuserid.Text = Session("HRAdminID")
                hdnusergroupid.Text = Session("TeamID")
                hdntimezineoffset.Text = Session("HRTimeZoneOffSet")
                HdnPunchInLimit.Text = CDate(FormatDateTime(Functions.GetTimeByZone(Session("HRTimeZoneOffSet"), Now), vbShortDate) & " 23:59")

                Dim colUsers As New List(Of Portal.BLL.Users)()
                colUsers = Portal.BLL.Users.GetUsersByID(Session("HRAdminID"))
                If (colUsers.Count > 0) Then
                    SpanWellCome.InnerText = colUsers.Item(0).Firstname & " " & colUsers.Item(0).Lastname
                End If
                SetPunchStatus()
                BtnActivityClick()

            End If
            'SetPunchStatus()
            'ClientScript.RegisterStartupScript(Me.GetType, "SetFocus", "<script>document.getElementById('" & btnActivity.ClientID & "').focus(); parent.clockpage(2);</script>")

            'hdnKey.Value = Functions.EncryptData(ConfigurationManager.AppSettings("HRKey"))
            'btnExit.PostBackUrl = "Default.aspx?key=" & Functions.EncryptData(ConfigurationManager.AppSettings("HRKey"))

        End If

    End Sub

    Private Function AuthenticateUser() As Integer

        Dim objHRUsers As Portal.BLL.HR.HR_Activities = New Portal.BLL.HR.HR_Activities()
        Dim intReturnValue As Integer

        objHRUsers.RFID = txtEmployeeID.Text
        intReturnValue = objHRUsers.HR_Authenticate_PinCard()
        Session.Add("HRTimeZoneOffSet", objHRUsers.TimeZoneID)
        Session.Add("HRAdminID", objHRUsers.ID)
        Session.Add("TeamID", objHRUsers.TeamID)
        'Session.Add("GroupTimeLimit", objHRUsers.GroupTimeLimit)
        Return intReturnValue
    End Function


    Private Function LoadUserTimeHistory() As Boolean
        Dim colHR_UserTimeHistory As New List(Of Portal.BLL.HR.HR_UserTimeHistory)
        colHR_UserTimeHistory = Portal.BLL.HR.HR_UserTimeHistory.HR_UserTimeHistoryGetByUserID(CType(hdnuserid.Text, Integer))
        If colHR_UserTimeHistory.Count > 0 Then
            hdnPunchInTime.Text = colHR_UserTimeHistory.Item(0).PunchInTime
            hdnPunchOutTime.Text = IIf(colHR_UserTimeHistory.Item(0).PunchOutTime = Nothing, Nothing, colHR_UserTimeHistory.Item(0).PunchOutTime)
            hdnForcedPunchOut.Text = colHR_UserTimeHistory.Item(0).ForcedPunchOut
            If hdnPunchOutTime.Text = Nothing Then
                lastpunchintime.InnerText = "Punch In " & colHR_UserTimeHistory.Item(0).PunchInTime.ToString("MMM dd, yyyy hh:mm tt")
            Else
                lastpunchintime.InnerText = "Punch Out " & colHR_UserTimeHistory.Item(0).PunchOutTime.ToString("MMM dd, yyyy hh:mm tt")
            End If
            Return True
        Else
            hdnForcedPunchOut.Text = False
            Return False
        End If
    End Function

    Private Sub SetPunchStatus()
        Dim objUsers As New Portal.BLL.Users
        Dim objTeamType As New Portal.BLL.Enumeration.TeamType
        Dim curDate As Date
        Dim userPunchinDate As Date
        If LoadUserTimeHistory() = True Then
            If hdnPunchOutTime.Text = Nothing Then
                If hdnForcedPunchOut.Text = True Then
                    ' Sign In and forced sign out		
                    SetEmployeeStatus("SIGN IN", hdnForcedPunchOut.Text)
                    If (AllowPunchIN() = False) Then
                        Exit Sub
                    End If
                Else
                    ' Normal Sign In and has not yet signed out
                    SetEmployeeStatus("SIGN OUT", False)
                End If
            Else
                ' Normal Sign Out and has not yet signed in
                SetEmployeeStatus("SIGN IN", False)
            End If
            If hdnPunchOutTime.Text = Nothing Then
                'Check either user punched out last time or not
                curDate = Functions.GetTimeByZone(hdntimezineoffset.Text, Now)
                userPunchinDate = CType(hdnPunchInTime.Text, DateTime)
                'If punchinday is differ than recent date then disable punch out
                If Not curDate.Day = userPunchinDate.Day Then
                    'Support_Night users has different scenerio to punch out
                    Dim longhour As Long = DateDiff(DateInterval.Hour, userPunchinDate, DateTime.Now)
                    If (objTeamType.Support_Night = hdnusergroupid.Text) And longhour < 24 Then
                        ' Normal Sign In and has not yet signed out
                        SetEmployeeStatus("SIGN OUT", False)
                    ElseIf (objTeamType.Office_Help = hdnusergroupid.Text) Then
                        ' Normal Sign In and has not yet signed out
                        SetEmployeeStatus("SIGN OUT", False)
                    Else
                        btnActivity.Enabled = False
                        btnActivity.ImageUrl = "images/btn_punchout_disabled.gif"
                        lbMessage.Text = "You have forgotton to Punch out last time. Please contact HR for further instructions."
                        lblMainStatus.Text = "You have forgotton to Punch out last time. Please contact HR for further instructions."
                        lblMainStatus.ForeColor = Drawing.Color.Red
                        CousultHR = True
                        ScriptManager.RegisterStartupScript(Me, Me.GetType, "SetFocussasas", "PunchInterval();", True)
                    End If
                End If
            End If
        End If
    End Sub

    Private Sub SetEmployeeStatus(ByVal NextActivity As String, ByVal ForcedPunchOut As String)
        If NextActivity = "SIGN IN" Then
            btnActivity.ImageUrl = "~/HR/Images/btn_punchin.gif"
        Else
            btnActivity.ImageUrl = "~/HR/Images/btn_punchout.gif"
        End If
        If (NextActivity <> "SIGN OUT") Then
            If (AllowPunchIN() = False) Then
                Exit Sub
            End If
        End If
        If ForcedPunchOut = True Then
            btnActivity.Enabled = False
        Else
            btnActivity.Enabled = True
        End If
    End Sub

    Protected Sub btnActivity_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnActivity.Click
        BtnActivityClick()
    End Sub
    Sub BtnActivityClick()
        If CousultHR Then
            Return
        End If
        Dim objUsers As New Portal.BLL.Users
        Dim intAffectedtRows As Integer
        lbMessage.Text = ""
        lblMainStatus.Text = ""
        lblMainStatus.ForeColor = Drawing.Color.Green
        ScriptManager.RegisterStartupScript(Me, Me.GetType, "SetFocussasas", "PunchInterval();", True)
        If (hdnPunchOutTime.Text = Nothing AndAlso hdnPunchInTime.Text = Nothing) Then
            'Check for late reason message
            'If Not IsOnTime() AndAlso CBool(ConfigurationManager.AppSettings("isAskForLateReason")) Then
            '    divDisable.Style.Add("display", "'block'")
            '    dvLateComing.Style.Add("display", "'block'")
            '    Dim scriptString As String = "<script language='JavaScript'> pagetimeout=9; </script>"
            '    Me.RegisterStartupScript("Startup", scriptString)
            '    'ClientScript.RegisterStartupScript(Me.GetType, "SetFocus", "<script>clearInterval(valsetinterval);</script>")
            '    Return
            'Else
            intAffectedtRows = HR_Activities.PunchIN(hdnuserid.Text, Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now), l_LateReason)
            lbMessage.Text = "Punch In SucessFully"
            lblMainStatus.Text = "You Have Sucessfully Punched In."
            lblMainStatus.ForeColor = Drawing.Color.Green
            'End If

        Else
            If hdnPunchOutTime.Text = Nothing And hdnPunchInTime.Text <> Nothing Then
                If CLng(DateDiff("s", hdnPunchInTime.Text, Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now))) < 60 Then
                    lbMessage.Text = "You have recently Punched In. Punch Out is allowed after 1 minute."
                    lblMainStatus.Text = "You have recently Punched In. Punch Out is allowed after 1 minute."
                    lblMainStatus.ForeColor = Drawing.Color.Red
                Else
                    intAffectedtRows = HR_Activities.PunchOUT(hdnuserid.Text, Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now))
                    'Response.Redirect("Default.aspx?key=" & Functions.EncryptData(ConfigurationManager.AppSettings("HRKey")) & "&IsSucessfull=True")
                    lbMessage.Text = "Punch Out SucessFully"
                    lblMainStatus.Text = "You Have Sucessfully Punched Out."
                    lblMainStatus.ForeColor = Drawing.Color.Green
                End If
            Else
                If CLng(DateDiff("s", CType(hdnPunchOutTime.Text, DateTime), Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now))) < 60 Then
                    lbMessage.Text = "You have recently Punched Out. Punch In is allowed after 1 minute."
                    lblMainStatus.Text = "You have recently Punched Out. Punch In is allowed after 1 minute."
                    lblMainStatus.ForeColor = Drawing.Color.Red
                Else
                    'Check for late reason message
                    'If Not IsOnTime() AndAlso CBool(ConfigurationManager.AppSettings("isAskForLateReason")) Then
                    '    divDisable.Style.Add("display", "'block'")
                    '    dvLateComing.Style.Add("display", "'block'")
                    '    Dim scriptString As String = "<script language='JavaScript'> pagetimeout=9; </script>"
                    '    Me.RegisterStartupScript("Startup", scriptString)
                    '    Return
                    'Else
                    intAffectedtRows = HR_Activities.PunchIN(hdnuserid.Text, Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now), l_LateReason)
                    'Response.Redirect("Default.aspx?key=" & Functions.EncryptData(ConfigurationManager.AppSettings("HRKey")) & "&IsSucessfull=False")
                    lbMessage.Text = "Punch IN SucessFully"
                    lblMainStatus.Text = "You Have Sucessfully Punched In."
                    lblMainStatus.ForeColor = Drawing.Color.Green
                    'End If
                End If
            End If
        End If
    End Sub

    Private Function AllowPunchIN() As Boolean
        If Functions.GetTimeByZone(Session("HRTimeZoneOffSet"), Now) > CDate(HdnPunchInLimit.Text) Then
            btnActivity.Enabled = False
            btnActivity.ImageUrl = "~/HR/Images/punch_in_disable.gif"
            btnActivity.Attributes.Add("style", "cursor:normal")
            lbMessage.Text = "You can not Punch In after " & CDate(HdnPunchInLimit.Text).ToShortTimeString
            'ClientScript.RegisterStartupScript(Me.GetType, "SetFocus", "<script>document.getElementById('" & btnExit.ClientID & "').focus();</script>")
            Return False
        End If
        Return True
    End Function
    ''' <summary>
    ''' Purpose:  Check punchin time late or ontime
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    ''' 
    Private Function IsOnTime() As Boolean
        'Dim intResult As Integer = Portal.BLL.HR.HR_Activities.isUserPunchedinToday(hdnuserid.Text, Date.Now.ToString())
        'If (intResult = 1) Then
        '    Return True
        'End If
        ''Dim strGroupName As String = String.Empty
        'Dim dtTimeLimit As DateTime
        'If (Session("GroupTimeLimit") IsNot Nothing) Then
        '    dtTimeLimit = Convert.ToDateTime(Session("GroupTimeLimit"))
        'End If
        'Dim dtCurretnTime As DateTime = Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now)
        'If (dtCurretnTime.TimeOfDay < dtTimeLimit.TimeOfDay) Then
        '    Return True
        'End If
        Return False
    End Function


    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        l_LateReason = txtMessage.Text
        If (hdnPunchOutTime.Text = Nothing AndAlso hdnPunchInTime.Text = Nothing) Then
            HR_Activities.PunchIN(hdnuserid.Text, Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now), l_LateReason)
            divDisable.Style.Add("display", "'none'")
            dvLateComing.Style.Add("display", "'none'")
        Else
            HR_Activities.PunchIN(hdnuserid.Text, Functions.GetTimeByZone(hdntimezineoffset.Text, DateTime.Now), l_LateReason)
            Response.Redirect("Default.aspx?key=" & Functions.EncryptData(ConfigurationManager.AppSettings("HRKey")) & "&IsSucessfull=False")
        End If
        SetPunchStatus()
    End Sub


    'Protected Sub btnExit_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnExit.Click
    'Response.Redirect("Default.aspx?key=" & Functions.EncryptData(ConfigurationManager.AppSettings("HRKey")))
    'End Sub

    Protected Sub btnPunchInterval_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnPunchInterval.Click
        tblLogin.Visible = True
        tblPunch.Visible = False
        lbErrMessage.Text = "Show your employee card."
        Me.lbErrMessage.ForeColor = Drawing.Color.Black
        txtEmployeeID.Text = ""
        ScriptManager.GetCurrent(Me).SetFocus(txtEmployeeID)
    End Sub
End Class
