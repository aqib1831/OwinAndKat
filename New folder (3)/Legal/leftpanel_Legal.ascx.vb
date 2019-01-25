Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class Research_leftpanel_Research
    Inherits System.Web.UI.UserControl
    Protected intOpenActivitiesCount As Integer = 0




#Region " Private Members "

    Private _Selected As Integer = 0

#End Region

#Region " Public Properties "

    Public Property Seleted() As Integer
        Get
            Return _Selected
        End Get
        Set(ByVal value As Integer)
            _Selected = value
        End Set
    End Property
#End Region

    Protected Function GetDaysColor(ByVal WaitingFor As Integer) As String
        If WaitingFor < 15 Then
            Return "color:Green;"
        ElseIf WaitingFor >= 15 And WaitingFor < 25 Then
            Return "color:Orange;"
        ElseIf WaitingFor >= 25 Then
            Return "color:Red;"
        End If
        Return "color:Green;"

    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
        If Not HttpContext.Current.Session("Admin_AdminID") Is Nothing Then
            If String.IsNullOrEmpty(Request.QueryString("MySocket")) = True Then
                Dim dr As SqlDataReader = Home.Home_GetActiveReminders(Session("Admin_AdminID"))
                If dr.Read() Then
                    lblActivityName.Text = dr.Item("Subject").ToString()
                    Session.Add("ReminderID", CInt(dr.Item("ID")))
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Reminder", "SetWin();", True)
                    If Not dr.Item("CaseID") Is DBNull.Value Then
                        Dim link As LinkButton = CType(UpdatePanel1.FindControl("lnkReminderActivity"), LinkButton)
                        If Not link Is Nothing Then
                            link.OnClientClick = "parent.frameMain.location='CaseMain.aspx?ID=" & dr.Item("CaseID") & "';HideWin();"
                            reminderImg.ImageUrl = "images/Case.gif"
                        End If
                    Else
                        Dim link As LinkButton = CType(UpdatePanel1.FindControl("lnkReminderActivity"), LinkButton)
                        If Not link Is Nothing Then
                            link.OnClientClick = "parent.frameMain.location='IPMain.aspx?ID=" & dr.Item("IPID") & "';HideWin();"
                            reminderImg.ImageUrl = "images/IP.gif"
                        End If
                    End If
                End If
                dr.Close()

            End If
        End If
    End Sub
    Protected Sub GetReminder(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("Default.aspx")
    End Sub
    Protected Sub GetReminder()
        If Not HttpContext.Current.Session("Admin_AdminID") Is Nothing Then
            If String.IsNullOrEmpty(Request.QueryString("MySocket")) = True Then
                Dim dr As SqlDataReader = Home.Home_GetActiveReminders(Session("Admin_AdminID"))
                If dr.Read() Then
                    lblActivityName.Text = dr.Item("Subject").ToString()
                    Session.Add("ReminderID", CInt(dr.Item("ID")))
                    ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Reminder", "SetWin();", True)
                    If Not dr.Item("CaseID") Is DBNull.Value Then
                        Dim link As LinkButton = CType(UpdatePanel1.FindControl("lnkReminderActivity"), LinkButton)
                        If Not link Is Nothing Then
                            link.OnClientClick = "parent.frameMain.location='CaseMain.aspx?ID=" & dr.Item("CaseID") & "';HideWin();"
                            reminderImg.ImageUrl = "images/Case.gif"
                        End If
                    Else
                        Dim link As LinkButton = CType(UpdatePanel1.FindControl("lnkReminderActivity"), LinkButton)
                        If Not link Is Nothing Then
                            link.OnClientClick = "parent.frameMain.location='IPMain.aspx?ID=" & dr.Item("IPID") & "';HideWin();"
                            reminderImg.ImageUrl = "images/IP.gif"
                        End If
                    End If
                End If
                dr.Close()

            End If
        End If
    End Sub
    Protected Sub btnSnooze_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSnooze.Click
        Dim dt As DateTime = DateTime.Now
        Select Case ddlSnoozeTime.SelectedValue
            Case 1
                dt = dt.AddMinutes(5)
            Case 2
                dt = dt.AddMinutes(10)
            Case 3
                dt = dt.AddMinutes(15)
            Case 4
                dt = dt.AddMinutes(30)
            Case 5
                dt = dt.AddMinutes(45)
            Case 6
                dt = dt.AddHours(1)
            Case 7
                dt = dt.AddHours(2)
            Case 8
                dt = dt.AddHours(5)
            Case 9
                dt = dt.AddHours(10)
            Case 10
                dt = dt.AddDays(1)
            Case 11
                dt = dt.AddDays(2)
            Case 12
                dt = dt.AddDays(3)
            Case 13
                dt = dt.AddDays(7)
        End Select
        'Dim dr As SqlDataReader = Home.Home_GetActiveReminders()
        'If dr.HasRows Then
        ' dr.Read()
        Home.Home_SnoozeReminder(dt, CInt(Session("ReminderID"))) 'CInt(dr.Item("ID")))
        ' End If
    End Sub

    Protected Sub btnDisMiss_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDisMiss.Click
        'Dim dr As SqlDataReader = Home.Home_GetActiveReminders()
        'If dr.HasRows Then
        '    dr.Read()
        Home.Home_DisMissReminder(CInt(Session("ReminderID")))
        'End If
    End Sub
End Class
