												 Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports Portal.BLL
Imports System.Security.Cryptography
Imports System.IO
Imports System.IO.Compression
Imports System.Web.Configuration

Public Class Functions

#Region " Private Members "
    Private _commingSoon As Integer
    Private _operating As Integer
    Private _ClientName As String
    Private _openActivities As Integer
    Private _openTicket As Integer
    Private _totalStores As Integer

    ' Define supported password characters divided into groups.
    ' You can add (or remove) characters to (from) these groups.
    Private Shared PASSWORD_CHARS_LCASE As String = "abcdefgijkmnopqrstwxyz"
    Private Shared PASSWORD_CHARS_UCASE As String = "ABCDEFGHJKLMNPQRSTWXYZ"
    Private Shared PASSWORD_CHARS_NUMERIC As String = "23456789"
    Private Shared PASSWORD_CHARS_SPECIAL As String = "$"

#End Region

#Region "Enumeration"
    Public Enum CallerTypes
        DailyAttendenceView = 1
    End Enum
    Public Enum ReportDatePeriods
        Today = 1
        Yesterday = 2
        ThisWeek = 3
        LastWeek = 4
        ThisMonth = 5
        LastMonth = 6
        Custom = 7
        Last7Days = 8
    End Enum
    Public Enum HRAttendenceStatus
        All = 1
        OnWork = 2
        OnLeave = 3
        LateArrivals = 4
        ExtraTime = 5
        SaturdayOff = 6
        SaturdayOn = 7
    End Enum
#End Region

#Region " Public Properties "
    Public Property OpenActivities() As Integer
        Get
            Return _openActivities
        End Get
        Set(ByVal value As Integer)
            _openActivities = value
        End Set
    End Property
    Public Property OpenTicket() As Integer
        Get
            Return _openTicket
        End Get
        Set(ByVal value As Integer)
            _openTicket = value
        End Set
    End Property
    Public Property ClientName() As String
        Get
            Return _ClientName
        End Get
        Set(ByVal value As String)
            _ClientName = value
        End Set
    End Property

    Public Property TotalStores() As Integer
        Get
            Return _totalStores
        End Get
        Set(ByVal value As Integer)
            _totalStores = value
        End Set
    End Property


    Public Property Operating() As Integer
        Get
            Return _operating
        End Get
        Set(ByVal value As Integer)
            _operating = value
        End Set
    End Property

    Public Property ComingSoon() As Integer
        Get
            Return _commingSoon
        End Get
        Set(ByVal value As Integer)
            _commingSoon = value
        End Set
    End Property
#End Region

#Region " Constructor "

    Public Sub New(ByVal ComingSoon As Integer, ByVal Operating As Integer)
        Me.Operating = Operating
        Me.ComingSoon = ComingSoon
	#End Sub

    Public Sub New(ByVal OpenActivities As Integer, ByVal Tickets As Integer, ByVal TotalStores As Integer, ByVal ClientName As String)
        Me.OpenActivities = OpenActivities
        Me.OpenTicket = Tickets
        Me.TotalStores = TotalStores
        Me.ClientName = ClientName
	#End Sub

    Public Sub New()

	#End Sub

#End Region

    Public Shared Function IsSuperAdmin(ByVal UserID As Integer) As Boolean
        Return False
        'If Portal.BLL.Enumeration.Users.Khurram_Ali = UserID Or UserID = 3004 Or UserID = 3852 Or UserID = 1 Then 'Check for super users
        '    Return True
        'Else
        '    Return False
        'End If
    End Function
#Region " Public Method "

    Public Shared Function GetRowCount(ByVal ds As DataSet) As Integer
        Try
            Dim rowCount As Integer = 0
            For Each table As DataTable In ds.Tables
                rowCount += table.Rows.Count
            Next
            Return rowCount
        Catch ex As Exception            
            Return 0
        End Try
    End Function

    Public Shared Function IsSingleLoginEnabled() As Boolean
        If ConfigurationManager.AppSettings("SingleLogIn") = "Enabled" Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Shared Function KeyCode_VerifyPass_Admin(ByVal sNumber As String, ByVal sPIN As String) As Boolean

        Dim d1 As Integer, d2 As Integer, d3 As Integer, d4 As Integer, result As String

        If Len(sNumber) < 4 Then
            Return False
        End If

        If IsNumeric(sNumber) = False Then
            Return False
        End If

        d1 = Mid(sNumber, 1, 1)
        d2 = Mid(sNumber, 2, 1)
        d3 = Mid(sNumber, 3, 1)
        d4 = Mid(sNumber, 4, 1)

        result = d4 & d3 & d2 & d1

        If result = sPIN Then
            Return True
        Else
            Return False
        End If

    End Function

    Public Shared Function Skip_Synch_Key(ByVal sNumber As String) As String

        Dim d1 As Integer
        Dim d2 As Integer
        Dim d3 As Integer
        Dim d4 As Integer
        Dim ans1 As String
        Dim ans2 As String
        Dim result As String

        d1 = Mid(sNumber, 1, 1)
        d2 = Mid(sNumber, 2, 1)
        d3 = Mid(sNumber, 3, 1)
        d4 = Mid(sNumber, 4, 1)

        ans1 = (d1 * d3)
        ans2 = (d2 + d4)
        If ans1 < 10 Then
            If ans1 = 0 Then
                ans1 = "07"
            Else
                ans1 = "0" & ans1
            End If
        End If

        If ans2 < 10 Then
            ans2 = "0" & ans2
        End If
        result = ans1 & ans2

        Return result

    End Function
    Public Shared Function Skip_Synch_KeyForNonUs(ByVal sNumber As String, ByVal StoreNumber As String) As String

        Dim d1 As Integer
        Dim d2 As Integer
        Dim d3 As Integer
        Dim d4 As Integer

        Dim ans1 As String
        Dim ans2 As String
        Dim result As String

        d1 = Mid(sNumber, 1, 1)
        d2 = Mid(sNumber, 2, 1)
        d3 = Mid(sNumber, 3, 1)
        d4 = Mid(sNumber, 4, 1)

        ans1 = (d1 * d3)
        ans2 = (d2 + d4)
        If ans1 < 10 Then
            If ans1 = 0 Then
                ans1 = "07"
            Else
                ans1 = "0" & ans1
            End If
        End If

        If ans2 < 10 Then
            ans2 = "0" & ans2
        End If
        result = ans1 & ans2

        Dim sum As Integer = 0
        Dim i As Integer
        For i = 0 To StoreNumber.Length - 1
            sum = sum + Convert.ToInt32(StoreNumber(i).ToString())
        Next
        sum = sum + d1 + d2 + d3 + d4
        result = sum.ToString() & result
        Return result
    End Function

    Public Shared Function Skip_Synch_KeyForNewSMSX(ByVal sNumber As String, ByVal StoreNumber As String) As String

        Dim d1 As Integer
        Dim d2 As Integer
        Dim d3 As Integer
        Dim d4 As Integer

        Dim ans1 As String
        Dim ans2 As String
        Dim result As String

        d1 = Mid(sNumber, 1, 1)
        d2 = Mid(sNumber, 2, 1)
        d3 = Mid(sNumber, 3, 1)
        d4 = Mid(sNumber, 4, 1)

        ans1 = (d1 * d3)
        ans2 = (d2 + d4)

        If ans1 < 10 Then
            If ans1 = 0 Then
                ans1 = "07"
            Else
                ans1 = "0" & ans1
            End If
        End If

        If ans2 < 10 Then
            ans2 = "0" & ans2
        End If
        result = ans1 & ans2
        result = CInt(result) + CInt(StoreNumber)
        Return result
    End Function

    Public Shared Function GetActivityStatus(ByVal intStatus As Integer) As String
        Dim retVal As String = String.Empty
        Select Case intStatus
            Case 1
                retVal = "Not Started"
            Case 2
                retVal = "In Progress"
            Case 3
                retVal = "Completed"
            Case 4
                retVal = "Waiting For"
            Case Else
                retVal = "Unknown"
        End Select
        Return retVal
    End Function

    Public Shared Function GetStoreName(ByVal intStatus As Integer) As String
        Dim retVal As String = String.Empty
        Select Case intStatus
            Case 4
                retVal = "X"
            Case 5
                retVal = "S"
            Case 6
                retVal = "T"
            Case Else
                retVal = ""
        End Select
        Return retVal
    End Function

    Public Shared Function GetLeadRating(ByVal intTypeCode As Integer) As String

        Select Case intTypeCode
            Case 1
                Return "Cold"
            Case 2
                Return "Warm"
            Case 3
                Return "Hot"
            Case Else
                Return "Unknown"
        End Select

    End Function

    Public Shared Function GetTaskPriority(ByVal intPriorityCode As Integer) As String
        Select Case intPriorityCode
            Case 1
                Return "Low"
            Case 2
                Return "Medium"
            Case 3
                Return "High"
            Case Else
                Return " "
        End Select
    End Function

    Public Shared Function GetLeadRatingColor(ByVal intTypeCode As Integer) As String

        Select Case intTypeCode
            Case 1
                Return "#D0F1CD"
            Case 2
                Return "#FFC6C6"
            Case 3
                Return "#FFCF88"
            Case Else
                Return "#AAD4FF"
        End Select

    End Function

    Public Shared Function GetLeadType(ByVal leadTypeCode As Integer) As String

        Select Case leadTypeCode
            Case 1
                Return "Lead"
            Case 2
                Return "Prospect"
            Case 3
                Return "Applicant"
            Case 4
                Return "Candidate"
            Case 5
                Return "Franchisee"
            Case Else
                Return "Lead"
        End Select

    End Function

    Public Shared Function GetWeekDay(ByVal leadTypeCode As Integer) As String

        Select Case leadTypeCode
            Case 1
                Return "Mon"
            Case 2
                Return "Tue"
            Case 3
                Return "Wed"
            Case 4
                Return "Thur"
            Case 5
                Return "Fri"
            Case 5
                Return "Sat"
            Case 5
                Return "Sun"
            Case Else
                Return ""
        End Select

    End Function

    Public Shared Function StringTruncate(ByVal strArg As String, ByVal len As String) As String
        If Trim(strArg).Length > len Then
            Return Left(strArg, len) & "..."
        Else
            Return strArg
        End If
    End Function

    Public Shared Function GetActivityImage(ByVal intType As Integer) As String
        Select Case intType
            Case Enumeration.ActivityType.HelpDesk
                Return "ico_helpdesktickets.gif"
            Case Enumeration.ActivityType.Message
                Return "ico_newmessage.gif"
            Case Enumeration.ActivityType.PhoneCall
                Return "Call.gif"
            Case Enumeration.ActivityType.Email
                Return "Email.gif"
            Case Enumeration.ActivityType.Fax
                Return "fax.gif"
            Case Enumeration.ActivityType.Meeting
                Return "Meeting.gif"
            Case Enumeration.ActivityType.Letter
                Return "Letter.gif"
            Case Enumeration.ActivityType.Other
                Return "Other.gif"
            Case Enumeration.ActivityType.NewStoreStage
                Return "store.gif"
            Case Enumeration.ActivityType.MKTCalendar
                Return "store.gif"
            Case Enumeration.ActivityType.EdibleIdea
                Return "ico_edibleidea.gif"
            Case Enumeration.ActivityType.DiscussionBoard
                Return "ico_discussion.gif"
            Case Enumeration.ActivityType.ProfileUpdate
                Return "ico_profileupdate.gif"
            Case Enumeration.ActivityType.NSMCoordinatorChange
                Return "store.gif"
            Case Enumeration.ActivityType.RequestAdditionalArea
                Return "ico_additionaldeliveryarea.gif"
            Case Enumeration.ActivityType.Installation
                Return "ico_Installation.png"
            Case Enumeration.ActivityType.Webinar
                Return "ico_other.gif"
            Case Enumeration.ActivityType.IncomingCall
                Return "Call.gif"
            Case Enumeration.ActivityType.OutgoingCall
                Return "Call.gif"
            Case Enumeration.ActivityType.EscalationfromEA
                Return "ico_other.gif"
            Case Enumeration.ActivityType.Internal
                Return "ico_Installation.png"
            Case Else
                Return "ico_other.gif"
        End Select

    End Function

    Public Shared Function NullDate(ByVal dt As DateTime) As Boolean
        If dt = DateTime.MinValue Or dt = DateTime.MaxValue Then
            Return True
        Else
            Return False
        End If
    End Function

    Public Shared Function GetActivityPrefix(ByVal intType As String) As String
        Select Case intType
            Case Enumeration.ActivityType.HelpDesk
                Return "H"
            Case Enumeration.ActivityType.Message
                Return "M"
            Case Enumeration.ActivityType.PhoneCall
                Return "C"
            Case Enumeration.ActivityType.Email
                Return "E"
            Case Enumeration.ActivityType.Fax
                Return "F"
            Case Enumeration.ActivityType.Meeting
                Return "T"
            Case Enumeration.ActivityType.Letter
                Return "L"
            Case Enumeration.ActivityType.Other
                Return "O"
            Case Enumeration.ActivityType.NewStoreStage
                Return "N"
            Case Enumeration.ActivityType.MKTCalendar
                Return "MC"
            Case Enumeration.ActivityType.EdibleIdea
                Return "EI"
            Case Enumeration.ActivityType.DiscussionBoard
                Return "D"
            Case Enumeration.ActivityType.ProfileUpdate
                Return "S"
            Case Enumeration.ActivityType.ProfileStoreUpdate
                Return "PU"
            Case Enumeration.ActivityType.NSMCoordinatorChange
                Return "NC"
            Case Enumeration.ActivityType.Finance
                Return "FN"
            Case Enumeration.ActivityType.RequestAdditionalArea
                Return "RA"
            Case Enumeration.ActivityType.QAR
                Return "Q"
            Case Enumeration.ActivityType.Installation 'Installation = 19
                Return "INS"
            Case Enumeration.ActivityType.SMS_X ' 20
                Return "SMS"
            Case Enumeration.ActivityType.Webinar ' 21
                Return "WEB"
            Case Enumeration.ActivityType.IncomingCall '22
                Return "IC"
            Case Enumeration.ActivityType.OutgoingCall '23
                Return "OC"
            Case Enumeration.ActivityType.EscalationfromEA '24
                Return "ESE"
            Case Enumeration.ActivityType.Internal '25
                Return "INT"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function getActivityCaption(ByVal intType As String) As String
        Select Case intType
            Case Enumeration.ActivityType.HelpDesk
                Return "Help Desk"
            Case Enumeration.ActivityType.Message
                Return "Message"
            Case Enumeration.ActivityType.PhoneCall
                Return "Call"
            Case Enumeration.ActivityType.Email
                Return "Email"
            Case Enumeration.ActivityType.Fax
                Return "Fax"
            Case Enumeration.ActivityType.Meeting
                Return "Meeting"
            Case Enumeration.ActivityType.Letter
                Return "Letter"
            Case Enumeration.ActivityType.Other
                Return "Other"
            Case Enumeration.ActivityType.NewStoreStage
                Return "New Store Stage"
            Case Enumeration.ActivityType.MKTCalendar
                Return "Marketing Calendar"
            Case Enumeration.ActivityType.ProfileUpdate
                Return "Profile Update"
            Case Enumeration.ActivityType.ProfileStoreUpdate
                Return "Store"
            Case Enumeration.ActivityType.NSMCoordinatorChange
                Return "Coordinator Change"
            Case Enumeration.ActivityType.DiscussionBoard
                Return "Discussion Board"
            Case Enumeration.ActivityType.Finance
                Return "Finance"
            Case Enumeration.ActivityType.EdibleIdea
                Return "Edible Idea"
            Case Enumeration.ActivityType.RequestAdditionalArea
                Return "Additional Area"
            Case Enumeration.ActivityType.QAR
                Return "QAR"
            Case Enumeration.ActivityType.SMS_X
                Return "SMSx"
            Case Enumeration.ActivityType.Installation
                Return "Installation"
            Case Enumeration.ActivityType.Webinar
                Return "Webinar"
            Case Enumeration.ActivityType.IncomingCall
                Return "Incoming Call"
            Case Enumeration.ActivityType.OutgoingCall
                Return "Outgoing Call"
            Case Enumeration.ActivityType.Internal
                Return "Internal"
            Case Enumeration.ActivityType.EscalationfromEA
                Return "Escalation from EA"
            Case Else
                Return "Unknown"
        End Select
    End Function

    Public Shared Function getSubStatusCaption(ByVal intType As Integer) As String
        Select Case intType
            Case 1
                Return "PL"
            Case 2
                Return "LS"
            Case 3
                Return "UC"
            Case 4
                Return "PO"
            Case 5
                Return "GO"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function GetStoreStatus(ByVal intType As Integer) As String
        Select Case intType
            Case 1
                Return "Coming Soon"
            Case 2
                Return "Operating"
            Case 3
                Return "Corporate"
            Case 4
                Return "Terminated"
            Case 5
                Return "Suspended"
            Case 6
                Return "Transferred"
            Case 7
                Return "Master"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function GetStoreStatus1(ByVal intType As Integer, ByVal IsSuspended As Boolean, ByVal IsAbandon As Boolean) As String
        Select Case intType
            Case 1
                Return "Coming Soon"
            Case 2
				IF IsSuspended = True Then
					 Return "Suspended"
				ElseIF IsAbandon = true Then
					 Return "Abandon"
				Else
					 Return "Operating"
				End If
            Case 3
                Return "Corporate"
            Case 4
                Return "Terminated"
            Case 5
                Return "Suspended"
            Case 6
                Return "Transferred"
            Case 7
                Return "Master"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function GetStoreSubStatus(ByVal intType As Integer) As String
        Select Case intType
            Case 1
                Return "Pending Lease"
            Case 2
                Return "Lease Signed"
            Case 3
                Return "Under Construction"
            Case 4
                Return "Pre Opening"
            Case 5
                Return "Grand Opening"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function GetSubTypeCaption(ByVal intType As String) As String

        Select Case intType
            Case 1
                Return "General"
            Case 2
                Return "Notice"
            Case 3
                Return "Complaint"
            Case 4
                Return "Compliment"
            Case 5
                Return "Violation"
            Case 6
                Return "Weekly call"
            Case 7
                Return "Left message"
            Case 8
                Return "Sales Report"
	    	Case 17
                Return "Management"
            Case 16
                Return "Accounts"
            Case 15
                Return "Hardware"
            Case 14
                Return "Support"
	        Case 19
                Return "Installation"	
            Case Else
                Return "Unknown"
        End Select
    End Function

    Public Shared Function GetTaskTypeName(ByVal intType As Integer, ByVal intActivity As Integer) As String

        Dim strReturn As String = String.Empty

        Select Case intType

            Case 0
                Select Case intActivity

                    Case 7
                        strReturn = "UFOC"

                    Case 9
                        strReturn = "Franchise Agreement"

                    Case 10
                        strReturn = "Franchise Agreements Receipt"

                    Case 8
                        strReturn = "UFOC Receipt"
                    Case 11
                        strReturn = "Next-Step"
                    Case 14
                        strReturn = "Initial Info"

                    Case 12
                        strReturn = "CQ"

                    Case 13
                        strReturn = "Comments"

                    Case 14
                        strReturn = "Lead Notes"

                    Case 15
                        strReturn = "Lead Type"


                    Case 16
                        strReturn = "Lead Status"

                    Case 17
                        strReturn = "Appiontment Email"

                    Case Else
                        strReturn = "Other"

                End Select

            Case 1
                strReturn = "Call"
            Case 2
                strReturn = "Meeting"
            Case 3
                strReturn = "Email"
            Case 4
                strReturn = "Fax"
            Case 5
                strReturn = "Letter"
            Case 6
                strReturn = "Demo"
            Case 7
                strReturn = "Financial Status"
            Case 8
                strReturn = "Conf. Questionnaire"
            Case 9
                strReturn = "Discovery Day Meeting"
            Case 10
                strReturn = "Presigning Check List"
            Case 11
                strReturn = "Lead Status"
            Case 12
                strReturn = "Lead Owner"
            Case 13
                strReturn = "Lead Type"
            Case 14
                strReturn = "Lead Notes"
            Case Else
                strReturn = "Other"

        End Select

        Return strReturn

    End Function

    Public Shared Function KeyCode_GenPass(ByVal nNoChars As Integer, ByVal sValidChars As String)

        Const szDefault = "abcdefghijklmnopqrstuvwxyz0123456789"
        Dim nCount As Integer
        Dim sRet As String = String.Empty
        Dim nNumber As Integer
        Dim nLength As Integer

        Randomize() 'init random 

        If sValidChars = String.Empty Then
            sValidChars = szDefault
        End If

        nLength = sValidChars.Length

        For nCount = 1 To nNoChars
            nNumber = CType((nLength * Rnd()) + 1, Integer)
            sRet = sRet & Mid(sValidChars, nNumber, 1)
        Next
        KeyCode_GenPass = sRet

    End Function

    Public Shared Function GetStateIDByCode(ByVal strCode As String) As Integer
        Dim db As New DBAccess
        db.AddParameter("@StateCode", strCode)
        Return CType(db.ExecuteScalar("States_GetByCode"), Integer)
    End Function

    Public Shared Function GetCountryIDByCode(ByVal strCode As String) As Integer
        Dim db As New DBAccess
        db.AddParameter("@Code", strCode)
        Return CType(db.ExecuteScalar("Country_GetByCode"), Integer)
    End Function

    Public Shared Function IfNull(ByVal objField As Object, ByVal objValue As Object) As Object
        If objField Is DBNull.Value Then
            Return objValue
        Else
            Return objField
        End If
    End Function

    Public Shared Function ReplaceNullOrEmpty(ByRef Value As Object)
        If Value.ToString.Trim = String.Empty Then
            Return String.Empty
        ElseIf Value Is DBNull.Value Then
            Return String.Empty
        Else
            Return Value
        End If
    End Function

    Public Shared Function ReplaceNullOrEmpty(ByRef Value As Object, ByVal ReplaceValue As Object)
        If ReplaceNullOrEmpty(Value) = String.Empty Then
            Return ReplaceValue
        Else
            Return Value
        End If
    End Function

    Public Shared Function ReplaceNullOrEmpty(ByRef Value As Object, ByVal ReplaceValue As Object, ByVal PadText As String)
        If ReplaceNullOrEmpty(Value) = String.Empty Then
            Return ReplaceValue
        Else
            Return PadText & Value
        End If
    End Function

    Public Shared Function ReplaceNullOrEmpty(ByRef Value As Object, ByVal ReplaceValue As Object, ByVal FormatOfDate As DateFormat)
        If ReplaceNullOrEmpty(Value).ToString = String.Empty Then
            Return ReplaceValue
        Else
            If IsDate(Value) Then
                Return FormatDateTime(Value, FormatOfDate)
            Else
                Return ReplaceValue
            End If
        End If
    End Function

    Public Shared Function ReplaceNullOrEmpty(ByRef Value As Object, ByVal FormatOfDate As String)
        If ReplaceNullOrEmpty(Value).ToString = String.Empty Then
            Return String.Empty
        Else
            If IsDate(Value) Then
                Return Format(Value, FormatOfDate)
            Else
                Return String.Empty
            End If
        End If
    End Function

    Public Shared Function GetDateTimeUniqueString() As String
        Dim retVal As String = String.Empty
        With DateTime.Now
            retVal = .Month.ToString & _
                        .Day.ToString & _
                        .Year.ToString & _
                        .Hour.ToString & _
                        .Minute.ToString & _
                        .Second.ToString & _
                        .Millisecond.ToString
        End With
        Return retVal
    End Function

    Public Shared Function ProperCase(ByVal strValue As String) As String
        ProperCase = StrConv(strValue, VbStrConv.ProperCase)
        Return ProperCase
    End Function

    Public Shared Function CreatePager(ByVal PageCount As Integer, ByVal Pageindex As Integer, ByVal FirstPage As Integer, ByVal LastPage As Integer) As HtmlTable
        Dim PagerTable As HtmlTable = New HtmlTable()
        PagerTable.Attributes.Add("Style", "cellspacing:2px; border:0 ; cellpadding:0px;")
        Dim Row As HtmlTableRow = New HtmlTableRow()
        ' add  previous page button
        Dim i As Int32 = 0
        Dim lbPrev As LinkButton = New LinkButton()
        lbPrev.Text = "Prev"
        lbPrev.CommandArgument = "Prev"
        lbPrev.CommandName = "Page"
        Row.Controls.Add(New HtmlTableCell())
        Dim CellPrev As HtmlTableCell = New HtmlTableCell()
        CellPrev.Attributes.Add("class", "PagerNextNormal")
        CellPrev.Attributes.Add("width", "20px")
        CellPrev.Attributes.Add("onmouseover", "javascript:this.className='PagerNextMouseOnOver';")
        CellPrev.Attributes.Add("onmouseout", "javascript:this.className='PagerNextNormal';")
        CellPrev.Controls.Add(lbPrev)
        If Pageindex <> 1 Then
            Row.Controls.Add(CellPrev)
        End If
        '-----------------  Addd   ....   or number 

        Dim lbist As LinkButton = New LinkButton()
        If FirstPage <= 1 Then
            FirstPage = 1
            lbist.Text = FirstPage.ToString() & " "
            lbist.CommandName = "Page"
        Else
            lbist.Text = "..."
            lbist.CommandName = "PrevPages"
        End If
        lbist.CommandArgument = FirstPage.ToString()
        Dim CellIst As HtmlTableCell = New HtmlTableCell()
        If Pageindex = FirstPage Then
            CellIst.Attributes.Add("class", "PagerMouseOnOver")
        Else
            CellIst.Attributes.Add("class", "PagerNormal")
            CellIst.Attributes.Add("onmouseover", "javascript:this.className='PagerMouseOnOver';")
            CellIst.Attributes.Add("onmouseout", "javascript:this.className='PagerNormal';")
        End If
        CellIst.Attributes.Add("width", "20px")
        CellIst.Controls.Add(lbist)
        Row.Controls.Add(CellIst)
        FirstPage = FirstPage + 1

        '-----------------  Addd   ....   or number 

        Dim lblast As LinkButton = New LinkButton()
        If LastPage >= PageCount Then
            LastPage = PageCount
            lblast.Text = LastPage.ToString()
            lblast.CommandName = "Page"
        Else
            lblast.Text = "..."
            lblast.CommandName = "NextPages"
        End If
        lblast.CommandArgument = LastPage.ToString()
        '-----------------  Addd   Remaining Numbers 

        For i = FirstPage To LastPage - 1
            Dim PNumber As Int32 = i
            Dim lb As LinkButton = New LinkButton()
            lb.CommandArgument = PNumber.ToString()
            lb.Text = PNumber.ToString() & " "
            lb.CommandName = "Page"
            Dim CellNumber As HtmlTableCell = New HtmlTableCell()
            CellNumber.Controls.Add(lb)
            If Pageindex = PNumber Then
                CellNumber.Attributes.Add("class", "PagerMouseOnOver")
            Else
                CellNumber.Attributes.Add("class", "PagerNormal")
                CellNumber.Attributes.Add("onmouseover", "javascript:this.className='PagerMouseOnOver';")
                CellNumber.Attributes.Add("onmouseout", "javascript:this.className='PagerNormal';")
            End If
            CellNumber.Attributes.Add("width", "20px")
            Row.Controls.Add(CellNumber)
        Next
        Dim CellLast As HtmlTableCell = New HtmlTableCell()
        CellLast.Controls.Add(lblast)
        If Pageindex = LastPage Then
            CellLast.Attributes.Add("class", "PagerMouseOnOver")
        Else
            CellLast.Attributes.Add("class", "PagerNormal")
            CellLast.Attributes.Add("onmouseover", "javascript:this.className='PagerMouseOnOver';")
            CellLast.Attributes.Add("onmouseout", "javascript:this.className='PagerNormal';")
        End If
        CellLast.Attributes.Add("width", "20px")
        Row.Controls.Add(CellLast)

        ' add  Next page button

        Dim lbnext As LinkButton = New LinkButton()
        lbnext.Text = "Next"
        lbnext.CommandArgument = "Next"
        lbnext.CommandName = "Page"
        Dim CellNext As HtmlTableCell = New HtmlTableCell()
        CellNext.Controls.Add(lbnext)
        CellNext.Attributes.Add("class", "PagerNextNormal")
        CellNext.Attributes.Add("onmouseover", "javascript:this.className='PagerNextMouseOnOver';")
        CellNext.Attributes.Add("onmouseout", "javascript:this.className='PagerNextNormal';")
        CellNext.Attributes.Add("width", "20px")
        If Pageindex <> PageCount Then
            Row.Controls.Add(CellNext)
        End If
        'Row.Controls.Add(New HtmlTableCell())

        PagerTable.Controls.Add(Row)
        Return PagerTable
    End Function

    Public Shared Function DecryptData(ByVal strData As String) As String
        Dim strTemp As String = String.Empty
        Dim i As Integer

        On Error Resume Next
        For i = 0 To strData.Length
            strTemp = strTemp & Chr((Split(strData, "KlSmJsYws")(i) / 55.55))
        Next

        Return strTemp
    End Function

    Public Shared Function EncryptData(ByVal strData As String) As String
        Dim strTemp As String = String.Empty
        Dim i As Integer

        On Error Resume Next
        For i = 0 To strData.Length
            strTemp = strTemp & (Asc(Mid(strData, i, 1)) * 55.55) & "KlSmJsYws"
        Next

        Return strTemp
    End Function

    Public Shared Sub CheckForIE()

        Dim CurBrowser As HttpBrowserCapabilities = HttpContext.Current.Request.Browser
        If CurBrowser.Browser <> "IE" Then
            HttpContext.Current.Response.Redirect("~/NonSupportedBrowser.aspx")
        ElseIf CurBrowser.MajorVersion < 6 Then
            HttpContext.Current.Response.Redirect("~/NonSupportedBrowser.aspx")
        End If
    End Sub
    Public Shared Sub CheckForIEAndMac()
        Dim CurBrowser As HttpBrowserCapabilities = HttpContext.Current.Request.Browser
        ' IE 11 Sometimes Send Browser as "Mozilla" and sometimes as "InternetExplorer"
        Dim IsIE As Boolean = (CurBrowser.Browser = "IE" AndAlso CurBrowser.MajorVersion > 6) _
                                Or (CurBrowser.Browser = "Mozilla" AndAlso CurBrowser.MajorVersion = 11) _
                                Or (CurBrowser.Browser = "InternetExplorer" AndAlso CurBrowser.MajorVersion = 11)
        Dim IsSafari As Boolean = (CurBrowser.Browser = "AppleMAC-Safari")

        ' If Browser is neither IE nor "AppleMAC-Safari"
        'If Not IsIE AndAlso CurBrowser.Browser <> "AppleMAC-Safari" Then
        '    HttpContext.Current.Response.Redirect("~/NonSupportedBrowser.aspx")
        'End If
        HttpContext.Current.Session("UserBrowser") = CurBrowser.Browser
    End Sub

    Public Shared Function GetStoreStats(ByVal ClientID As Integer) As List(Of Functions)
        Return Portal.DAL.DBFunction.GetStoreStats(ClientID)
    End Function

    Public Shared Function GetClientStats() As List(Of Functions)
        Return Portal.DAL.DBFunction.GetClientStats()
    End Function

    Public Shared Function GetActivityPriorityByID(ByVal PriorityID As Integer) As String
        Select Case PriorityID
            Case Portal.BLL.Enumeration.ActivityPriority.Low
                Return "Low"
            Case Portal.BLL.Enumeration.ActivityPriority.Minimal
                Return "Minimal"
            Case Portal.BLL.Enumeration.ActivityPriority.Moderate
                Return "Moderate"
            Case Portal.BLL.Enumeration.ActivityPriority.Severe
                Return "Severe"
            Case Portal.BLL.Enumeration.ActivityPriority.Critical
                Return "Critical"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function GetActivityPriorityByID_New(ByVal PriorityID As Integer) As String
        Select Case PriorityID
            Case Portal.BLL.Enumeration.ActivityPriority.Low
                Return "Low"
            Case Portal.BLL.Enumeration.ActivityPriority.Minimal
                Return "Minimal"
            Case Portal.BLL.Enumeration.ActivityPriority.Moderate
                Return "Moderate"
            Case Portal.BLL.Enumeration.ActivityPriority.Severe
                Return "High"
            Case Portal.BLL.Enumeration.ActivityPriority.Critical
                Return "Critical"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function GetActivityPriorityColorByID(ByVal PriorityID As Integer) As String
        Select Case PriorityID
            Case Portal.BLL.Enumeration.ActivityPriority.Low
                Return "#FFFFFF"
            Case Portal.BLL.Enumeration.ActivityPriority.Minimal
                Return "#E8FAE6"
            Case Portal.BLL.Enumeration.ActivityPriority.Moderate
                Return "#FFFFCC"
            Case Portal.BLL.Enumeration.ActivityPriority.Severe
                Return "#FFEBCC"
            Case Portal.BLL.Enumeration.ActivityPriority.Critical
                Return "#FFD5D5"
            Case Else
                Return "#FFFFFF"
        End Select
    End Function


    Public Shared Function GetUserIDByClient(ByVal ClientID As Integer) As Integer
        Return CType(HttpContext.Current.Session("AdminCurrentobjUser"), Portal.BLL.Users).ID
    End Function

    '-- This function is not useful. Can be deleted once verified.  Khurram ALi 2008-04-05.
    Public Shared Function GetClientActivityobjectByID(ByVal ClientID As Integer) As Object
        Return New Portal.BLL.Activities()
    End Function

    Public Shared Function GetAttachmentUploadFolder(ByVal ClientID As Integer) As String
        Return ConfigurationManager.AppSettings("PortalComAttachmentPath").ToString()
    End Function


    Public Shared Function CheckModuleAccess(ByVal ModuleID As Integer) As Boolean
        Dim str As String = HttpContext.Current.Session("UsersModulesID")

        Dim ModuleArray As String()
        Dim i As Integer = 0
        ModuleArray = Split(str, ",")
        For i = 0 To ModuleArray.Length - 1
            If CInt(ModuleArray(i).Trim) = ModuleID Then
                Return True
            End If
        Next
        Return False
    End Function

    Public Shared Function GetPaymentGateWay(ByVal ID As Integer) As String
        Select Case ID
            Case 1
                Return "MPS"
            Case 2
                Return "FirstData"
            Case 3
                Return "Nova"
            Case 4
                Return "Apriva"
            Case Else
                Return ""
        End Select
    End Function

    Public Shared Function MakeFolderNameValid(ByVal Foldername As String) As String
        Dim index As Integer
        Dim validFolderName As String = String.Empty
        For index = 0 To Foldername.Length - 1

            If ((Char.ToUpper(Foldername(index)) >= "A" AndAlso Char.ToUpper(Foldername(index)) <= "Z") Or (Foldername(index) >= "0" AndAlso Foldername(index) <= "9")) Then
                validFolderName = validFolderName & Foldername(index)
            Else
                validFolderName = validFolderName & "_"
            End If
        Next
        Return validFolderName
    End Function

    Public Shared Function MakeFileNameValid(ByVal Foldername As String) As String
        Dim index As Integer
        Dim validFolderName As String = String.Empty
        For index = 0 To Foldername.Length - 1

            If ((Char.ToUpper(Foldername(index)) >= "A" AndAlso Char.ToUpper(Foldername(index)) <= "Z") Or (Foldername(index) >= "0" AndAlso Foldername(index) <= "9")) Or (Foldername(index) = ".") Then
                validFolderName = validFolderName & Foldername(index)
            Else
                validFolderName = validFolderName & "_"
            End If
        Next
        Return validFolderName
    End Function

    Public Shared Function GeneratePassword(ByVal minLength As Integer, _
    ByVal maxLength As Integer) _
        As String


        If (minLength <= 0 Or maxLength <= 0 Or minLength > maxLength) Then
            GeneratePassword = Nothing
        End If


        Dim charGroups As Char()() = New Char()() _
        { _
            PASSWORD_CHARS_LCASE.ToCharArray(), _
            PASSWORD_CHARS_UCASE.ToCharArray(), _
            PASSWORD_CHARS_NUMERIC.ToCharArray(), _
            PASSWORD_CHARS_SPECIAL.ToCharArray() _
        }


        Dim charsLeftInGroup As Integer() = New Integer(charGroups.Length - 1) {}

        ' Initially, all characters in each group are not used.
        Dim I As Integer
        For I = 0 To charsLeftInGroup.Length - 1
            charsLeftInGroup(I) = charGroups(I).Length
        Next

        ' Use this array to track (iterate through) unused character groups.
        Dim leftGroupsOrder As Integer() = New Integer(charGroups.Length - 1) {}

        ' Initially, all character groups are not used.
        For I = 0 To leftGroupsOrder.Length - 1
            leftGroupsOrder(I) = I
        Next


        Dim randomBytes As Byte() = New Byte(3) {}

        ' Generate 4 random bytes.
        Dim rng As System.Security.Cryptography.RNGCryptoServiceProvider = New System.Security.Cryptography.RNGCryptoServiceProvider()

        rng.GetBytes(randomBytes)

        ' Convert 4 bytes into a 32-bit integer value.
        Dim seed As Integer = ((randomBytes(0) And &H7F) << 24 Or _
                                randomBytes(1) << 16 Or _
                                randomBytes(2) << 8 Or _
                                randomBytes(3))

        ' Now, this is real randomization.
        Dim random As Random = New Random(seed)

        ' This array will hold password characters.
        Dim password As Char() = Nothing

        ' Allocate appropriate memory for the password.
        If (minLength < maxLength) Then
            password = New Char(random.Next(minLength - 1, maxLength)) {}
        Else
            password = New Char(minLength - 1) {}
        End If

        ' Index of the next character to be added to password.
        Dim nextCharIdx As Integer

        ' Index of the next character group to be processed.
        Dim nextGroupIdx As Integer

        ' Index which will be used to track not processed character groups.
        Dim nextLeftGroupsOrderIdx As Integer

        ' Index of the last non-processed character in a group.
        Dim lastCharIdx As Integer

        ' Index of the last non-processed group.
        Dim lastLeftGroupsOrderIdx As Integer = leftGroupsOrder.Length - 1

        ' Generate password characters one at a time.
        For I = 0 To password.Length - 1


            If (lastLeftGroupsOrderIdx = 0) Then
                nextLeftGroupsOrderIdx = 0
            Else
                nextLeftGroupsOrderIdx = random.Next(0, lastLeftGroupsOrderIdx)
            End If

            nextGroupIdx = leftGroupsOrder(nextLeftGroupsOrderIdx)


            lastCharIdx = charsLeftInGroup(nextGroupIdx) - 1

            If (lastCharIdx = 0) Then
                nextCharIdx = 0
            Else
                nextCharIdx = random.Next(0, lastCharIdx + 1)
            End If


            password(I) = charGroups(nextGroupIdx)(nextCharIdx)


            If (lastCharIdx = 0) Then
                charsLeftInGroup(nextGroupIdx) = _
                                charGroups(nextGroupIdx).Length

            Else

                If (lastCharIdx <> nextCharIdx) Then
                    Dim temp As Char = charGroups(nextGroupIdx)(lastCharIdx)
                    charGroups(nextGroupIdx)(lastCharIdx) = _
                                charGroups(nextGroupIdx)(nextCharIdx)
                    charGroups(nextGroupIdx)(nextCharIdx) = temp
                End If

                charsLeftInGroup(nextGroupIdx) = _
                           charsLeftInGroup(nextGroupIdx) - 1
            End If


            If (lastLeftGroupsOrderIdx = 0) Then
                lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1

            Else

                If (lastLeftGroupsOrderIdx <> nextLeftGroupsOrderIdx) Then
                    Dim temp As Integer = _
                                leftGroupsOrder(lastLeftGroupsOrderIdx)
                    leftGroupsOrder(lastLeftGroupsOrderIdx) = _
                                leftGroupsOrder(nextLeftGroupsOrderIdx)
                    leftGroupsOrder(nextLeftGroupsOrderIdx) = temp
                End If


                lastLeftGroupsOrderIdx = lastLeftGroupsOrderIdx - 1
            End If
        Next


        GeneratePassword = New String(password)
    End Function

    Public Shared Function IsValidEmail(ByVal EmailAddress As String) As Boolean
        Dim pattern As String = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
        Dim emailAddressMatch As Match = Regex.Match(EmailAddress, pattern)
        If emailAddressMatch.Success Then
            IsValidEmail = True
        Else
            IsValidEmail = False
        End If
    End Function

    Public Function VerifySMSXInstalled(ByVal FranchiseID As Integer) As Boolean
        Dim retVal As Integer = 0

        Dim db As New DBAccess
        db.AddParameter("@FranchiseID", FranchiseID)
        db.AddParameter("@Return", SqlDbType.Int, 4, ParameterDirection.ReturnValue, 0)
        db.ExecuteNonQuery("SMSX_VerifySMSXInstalled")
        retVal = CInt(CType(db.Parameters("@Return"), System.Data.SqlClient.SqlParameter).Value)
        If retVal = 0 Then
            Return True
        Else
            Return False
        End If

    End Function

#Region "isDateNull" 'User IN HR Module only'
    Public Shared Function isDateNull(ByVal obj As Object) As String
        If IsDBNull(obj) = True Then
            Return String.Empty
        Else
            Return FormatDateTime(CType(obj, DateTime), DateFormat.LongTime).ToString
        End If
    End Function
#End Region

#Region "GetTimeByZone" 'User IN HR Module only'
    Public Shared Function GetTimeByZone(ByVal argUserTimeZone As Integer, ByVal argDate As Date) As Date
        Dim rtDate As Date
        rtDate = DateAdd("h", argUserTimeZone - CONSTANTS.SERVER_TIME_ZONE, argDate)
        Return rtDate
    End Function
#End Region

    Private Const EncKey = 17
    Private Const SaltChar = 143

    Shared Function Encryption(ByVal DataString As String) As String
GenerateAgain:
        Dim intCount As Integer
        Dim strEncString As String = ""
        Dim EKey As Integer
        EKey = GetRandomNumber(150, 1) + EncKey
        If Trim(DataString) <> "" Then
            For intCount = 1 To Len(DataString)
                If (Asc(Mid(DataString, intCount, 1)) + EKey > 255) Then
                    GoTo GenerateAgain
                End If
                strEncString = strEncString & Chr(Asc(Mid(DataString, intCount, 1)) + EKey)
            Next
            strEncString = Chr(EKey) & strEncString & Chr(SaltChar)
        End If
        Encryption = strEncString
    End Function

    Shared Function Decryption(ByVal EncryptedString As String) As String
        Dim intCount As Integer
        Dim strDecString As String = ""
        Dim EKey As Integer
        If Trim(EncryptedString) <> "" Then
            EKey = Asc(Strings.Left(EncryptedString, 1))

            If Strings.Right(EncryptedString, 1) <> Chr(SaltChar) Then Return Nothing
            For intCount = 2 To Len(EncryptedString) - 1
                strDecString = strDecString & Chr(Asc(Mid(EncryptedString, intCount, 1)) - EKey)
            Next
        End If
        Decryption = strDecString
    End Function

    Shared Function GetRandomNumber(ByVal MaxValue As Integer, ByVal MinValue As Integer)
        On Error GoTo ErrHandler

        Dim RndNum As Object
        Dim Ans(256) As String
        Dim Answer As String
        Dim Search As Integer
        Dim HowMany As Integer
        Dim i As Integer
        Randomize()
        Answer = ""
        For HowMany = 1 To 10
5:          RndNum = Int(Rnd() * MaxValue) + MinValue
            For Search = 1 To HowMany
                If RndNum = Ans(Search) Then GoTo 5
            Next Search
            Ans(HowMany) = RndNum
        Next HowMany
        For i = 1 To 10
            Answer = Answer & Ans(i)
            If i <> 256 Then Answer = Answer & ", "
        Next i
        GetRandomNumber = Ans(1)
        Exit Function

ErrHandler:
    End Function

    Public Shared Function GetCCType(ByVal type As Integer)
        If (type = Portal.BLL.Enumeration.CreditCardType.Amex) Then
            Return "Amex"
        ElseIf (type = Portal.BLL.Enumeration.CreditCardType.Discover) Then
            Return "Discover"
        ElseIf (type = Portal.BLL.Enumeration.CreditCardType.Master_Card) Then
            Return "Master Card"
        ElseIf (type = Portal.BLL.Enumeration.CreditCardType.VISA) Then
            Return "Visa"
        End If
        Return String.Empty
    End Function
    Public Shared Function ToLongDate(ByVal objField As Object, ByVal objValue As Object) As String
        If objField Is DBNull.Value Then
            Return objValue
        Else
            Return MonthName(Month(objField)).ToString & " " & Day(objField).ToString & ", " & Year(objField).ToString
        End If
    End Function
    Public Shared Function DateandYearPart(ByVal objField As Object, ByVal objValue As Object) As String
        If objField Is DBNull.Value Then
            Return objValue
        Else
            Return Month(objField).ToString & " / " & Year(objField).ToString
        End If
    End Function
    Public Shared Function DateDiffInWords(ByVal objField As Object) As String
        Dim Str As String = ""
        If Not objField Is DBNull.Value Then
            If IsDate(objField) Then
                Dim dt As DateTime = objField
                Dim tsTimeSpan As TimeSpan = DateTime.Now.Subtract(dt)
                Dim Sec As Double = tsTimeSpan.TotalSeconds

                If Sec >= 0 AndAlso Sec < 30 Then ' less than 30 Sec
                    Str = "Few seconds ago."
                ElseIf Sec >= 30 AndAlso Sec < 60 Then ' less than 60 Sec
                    Str = "Less than a min."
                ElseIf Sec >= 60 AndAlso Sec < 119 Then ' equal to 1 min
                    Str = tsTimeSpan.Minutes & "min  ago."
                ElseIf Sec >= 120 AndAlso Sec < 3600 Then ' less than 1 hour
                    Str = tsTimeSpan.Minutes & " mins  ago."
                ElseIf Sec >= 3600 AndAlso Sec < 7200 Then ' equal to 1 hour
                    Str = tsTimeSpan.Hours & " hr " & tsTimeSpan.Minutes & " mins ago."
                ElseIf Sec >= 7200 AndAlso Sec < 86400 Then ' less than 1 day
                    Str = tsTimeSpan.Hours & " hrs " & tsTimeSpan.Minutes & " mins ago."
                ElseIf Sec >= 86400 AndAlso Sec < 172800 Then ' less than 2 days
                    Str = tsTimeSpan.Days & " day ago."
                ElseIf Sec >= 172800 AndAlso Sec < 259200 Then ' less than 3 days
                    Str = tsTimeSpan.Days & " days ago."
                Else
                    Str = String.Format("{0:MMM dd, yyyy}", dt)
                End If
            End If
        End If
        Return Str
    End Function
    Public Shared Function DateDiffInWordsLong(ByVal objField As Object) As String
        Dim Str As String = ""
        If Not objField Is DBNull.Value Then
            If IsDate(objField) Then
                Dim dt As DateTime = objField
                Dim tsTimeSpan As TimeSpan = DateTime.Now.Subtract(dt)
                Dim Sec As Double = tsTimeSpan.TotalSeconds

                If Sec >= 0 AndAlso Sec < 30 Then ' less than 30 Sec
                    Str = "Few seconds ago."
                ElseIf Sec >= 30 AndAlso Sec < 60 Then ' less than 60 Sec
                    Str = "Less than a min."
                ElseIf Sec >= 60 AndAlso Sec < 119 Then ' equal to 1 min
                    Str = tsTimeSpan.Minutes & "min  ago."
                ElseIf Sec >= 120 AndAlso Sec < 3600 Then ' less than 1 hour
                    Str = tsTimeSpan.Minutes & " mins  ago."
                ElseIf Sec >= 3600 AndAlso Sec < 7200 Then ' equal to 1 hour
                    Str = tsTimeSpan.Hours & " hr " & tsTimeSpan.Minutes & " mins ago."
                ElseIf Sec >= 7200 AndAlso Sec < 86400 Then ' less than 1 day
                    Str = tsTimeSpan.Hours & " hrs " & tsTimeSpan.Minutes & " mins ago."
                ElseIf Sec >= 86400 AndAlso Sec < 172800 Then ' less than 2 days
                    Str = tsTimeSpan.Days & " day ago."
                ElseIf Sec >= 172800 AndAlso Sec < 259200 Then ' less than 3 days
                    Str = tsTimeSpan.Days & " days ago."
                Else
                    Str = String.Format("{0:MMMM dd, yyyy}", dt)
                End If
            End If
        End If
        Return Str
    End Function
    Public Shared Function ReplaceSpecailChar(ByVal Str As String) As String
        Dim StrToolTip As String = Str
        StrToolTip = Replace(StrToolTip, "'", "\'")
        StrToolTip = Replace(StrToolTip, ")", "\)")
        StrToolTip = Replace(StrToolTip, "(", "\(")
        StrToolTip = Replace(StrToolTip, "/", "\/")
        StrToolTip = Replace(StrToolTip, ",", "\,")
        StrToolTip = Replace(StrToolTip, vbCrLf, "\n")
        Return StrToolTip
    End Function

    Public Shared Function CheckSubModuleAccess(ByVal SubModulesType As Portal.BLL.Enumeration.SubModules) As Boolean
        Dim strcsv As String = HttpContext.Current.Session("UsersSubModulesID")
        If strcsv <> Nothing AndAlso strcsv <> String.Empty Then
            Dim srtArray As String() = strcsv.Split(",")
            If srtArray.Length > 0 Then
                For i As Integer = 0 To srtArray.Length - 1
                    If srtArray(i) = SubModulesType Then
                        Return True
                    End If
                Next
            End If
        End If
        Return False
    End Function

Public Shared Function GetInterval(ByVal Max As Integer) As Data.DataTable
        Dim dtTime As New DataTable("Hours")
        Dim i As Integer = 0
        Dim Count As Integer = 0

        dtTime.Columns.Add("Text")
        dtTime.Columns.Add("Value")

        For i = 1 To Max
            If Count < 10 Then
                dtTime.Rows.Add(New Object() {"0" & Count, Count})
            Else
                dtTime.Rows.Add(New Object() {Count, Count})
            End If
            Count += 1
        Next

        Return dtTime

    End Function	

	Public Shared Function FormatShortDate(ByVal value As Object) As String
        If IsDate(value) Then
            Return CDate(value).ToString("MMM dd, yyyy")
        Else
            Return String.Empty
        End If
    End Function
	
    ' The AdjustDSTimeZone method adjusts the DateTime values to reflect the original time of the client application.
    ' Here the ExtendedProperties property of the DataSet class is used to store the Coordinated Universal Time (UTC) offset with the DataSet object.
    ' With the ExtendedProperties property, you can store custom information with the DataSet object.
    ' If you want the DataSet object to be remoted, you must store the UTC offset as a string in the ExtendedProperties collection.
    Public Shared Sub AdjustDSTimeZone(ByVal dsExtProps As PropertyCollection, ByRef table As DataTable, ByVal column As String)
        ' Obtains the time difference on the server computer that
        'send this dataset to the local computer.
        If (dsExtProps("UTCDifference") IsNot Nothing) Then
            Dim sourceTicksString As String = dsExtProps("UTCDifference").ToString()
            Dim sourceTicks As Long = Long.Parse(sourceTicksString)
            ' Obtain the UTC offset for the server computer.
            Dim baseUTC As DateTime = DateTime.Now
            Dim UtcTickslocal As Long = TimeZone.CurrentTimeZone.GetUtcOffset(baseUTC).Ticks
            ' Obtain the time difference between the server computer and the local computer.
            Dim ticksDifference As Long = sourceTicks - UtcTickslocal
            Dim timespan As New TimeSpan(ticksDifference)

            For Each row As DataRow In table.Rows
                Select Case row.RowState
                    Case DataRowState.Unchanged
                        If row(column) Is DBNull.Value Then
                            row(column) = DBNull.Value
                        Else
                            row(column) = DirectCast(row(column), DateTime).Add(timespan)
                        End If
                        row.AcceptChanges()
                        ' This is to make sure that the
                        ' row appears to be unchanged again.
                        Exit Select
                    Case DataRowState.Added
                        If row(column) Is DBNull.Value Then
                            row(column) = DBNull.Value
                        Else
                            row(column) = DirectCast(row(column), DateTime).Add(timespan)
                        End If
                        ' The row is still in a DataRowState.Added state.
                        Exit Select
                    Case DataRowState.Modified
                        If row(column) Is DBNull.Value Then
                            row(column) = DBNull.Value
                        Else
                            row(column) = DirectCast(row(column), DateTime).Add(timespan)
                        End If
                        ' The row is a still DataRowState.Modified.
                        Exit Select
                    Case DataRowState.Deleted
                        ' This is to make sure that you obtain the right results if
                        'the .RejectChanges()method is called.
                        row.RejectChanges()
                        ' This is to "undo" the delete.
                        If row(column) Is DBNull.Value Then
                            row(column) = DBNull.Value
                        Else
                            row(column) = DirectCast(row(column), DateTime).Add(timespan)
                        End If
                        ' To adjust the datatime values.
                        ' The row is now in DataRowState.Modified state.
                        row.AcceptChanges()
                        ' This is to mark the changes as permanent.
                        row.Delete()
                        ' Delete the row. Now, it has the same state as it started.
                        Exit Select
                    Case Else
                        Throw New ApplicationException("Unexpected DataRowState encountered.")
                End Select
            Next
        End If
    End Sub
    Public Shared Sub AddUTCOffset(ByRef dataSet As DataSet)

        dataSet.ExtendedProperties("UTCDifference") = TimeZone.CurrentTimeZone.GetUtcOffset(DateTime.Now).Ticks.ToString

    End Sub

    Public Shared Function ConvertToDbNull(ByVal value As Decimal) As Object
        If value = NullValues.NullDecimal Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function

    Public Shared Function ConvertToDbNull(ByVal value As Integer) As Object
        If value = NullValues.NullInteger Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function

    Public Shared Function ConvertToDbNull(ByVal value As String) As Object
        If String.IsNullOrEmpty(value) Then
            Return DBNull.Value
        Else
            Return value
        End If
    End Function

    Public Shared Function FormatDateByPattern(ByVal value As DateTime, ByVal objDateTimePatteren As Functions.DatePattern) As String
        If objDateTimePatteren = Functions.DatePattern.Format1 Then
            Return value.ToString("MM/dd/yyyy")
        End If
        If objDateTimePatteren = Functions.DatePattern.Format7 Then
            Return value.ToString("ddd, MMMM dd, yyyy")
        End If
        If objDateTimePatteren = Functions.DatePattern.Format8 Then
            Return value.ToString("MMM d, yyyy")
        End If
        If objDateTimePatteren = Functions.DatePattern.Format9 Then
            Return value.ToString("ddd, MMM , yyyy")
        End If
        If objDateTimePatteren = Functions.DatePattern.Format10 Then
            Return value.ToString("MM/dd/yy")
        End If
        If objDateTimePatteren = Functions.DatePattern.Format5 Then 'To add the fix for NSM history page
            Return value.ToString("ddd, MMM dd, yyyy")
        End If
        If objDateTimePatteren = Functions.DatePattern.Format11 Then 'To add the fix for NSM history page
            Return value.ToString("MM/dd")
        End If
        Return String.Empty
    End Function

    Public Enum DatePattern
        ''' <summary>
        ''' mm/dd/yyyy
        ''' </summary>
        Format1 = 1
        ''' <summary>
        ''' mm-dd-yyyy
        ''' </summary>
        Format2 = 2
        ''' <summary>
        ''' dd/mm/yyyy
        ''' </summary>
        Format3 = 3
        ''' <summary>
        ''' dd-mm-yyyy
        ''' </summary>
        Format4 = 4
        ''' <summary>
        ''' 02 Feburary, 2010
        ''' </summary>
        Format5 = 5
        ''' <summary>
        ''' 02 Feb, 2010
        ''' </summary>
        Format6 = 6
        ''' <summary>
        ''' Saturday, 02 March, 2010
        ''' </summary>
        Format7 = 7
        ''' <summary>
        ''' Dec 10, 2010
        ''' </summary>
        Format8 = 8
        ''' <summary>
        ''' Sat, March 02, 2010
        ''' </summary>
        Format9 = 9
        ''' <summary>
        ''' mm/dd/yyy
        ''' </summary>
        Format10 = 10

        '''<summary>
        ''' MM/dd For Birth Date
        '''</summary>
        Format11 = 11
    End Enum


#Region "Netsolace Product"
    Public Shared Function GetProductType(ByVal ID As Integer) As String
        Dim ProductType As String = ""
        Select Case ID
            Case Portal.BLL.Enumeration.ProductType.Software
                ProductType = "Software"
            Case Portal.BLL.Enumeration.ProductType.Hardware
                ProductType = "Hardware"
            Case Portal.BLL.Enumeration.ProductType.Services
                ProductType = "Services"
            Case Portal.BLL.Enumeration.ProductType.Support
                ProductType = "Support"
            Case Else
                ProductType = "N/A"
        End Select
        Return ProductType
    End Function
    Public Shared Function DisplayPaymentMode(ByVal PaymentMode As Integer) As String
        Dim returnvalue As String = ""
        Select Case PaymentMode
            Case 1
                returnvalue = "Credit Card"
            Case 2
                returnvalue = "Debit On Bank"
            Case 3
                returnvalue = "Bill"
            Case Else
                returnvalue = "N \ A"
        End Select
        Return returnvalue
    End Function
    Public Shared Function DisplayBillSendOption(ByVal Sendoption As Integer) As String
        Dim returnvalue As String = ""
        Select Case Sendoption
            Case 1
                returnvalue = "By Post"
            Case 2
                returnvalue = "Email"
            Case Else
                returnvalue = "N \ A"
        End Select
        Return returnvalue
    End Function
    Public Shared Function BillToOption(ByVal Billoption As Integer) As String
        Dim returnvalue As String = ""
        Select Case Billoption
            Case 0
                returnvalue = ""
            Case 1
                returnvalue = "Corporate"
            Case 2
                returnvalue = "Franchise"
            Case Else
                returnvalue = "Both"
        End Select
        Return returnvalue
    End Function
#End Region
#End Region

#Region " Qs Decryption Method"
    '******************** FUNCTION FOR Encryption*********************************** 
    Public Shared Function EncryptString128Bit(ByVal vstrTextToBeEncrypted As String, ByVal vstrEncryptionKey As String) As String

        Try
            If (String.IsNullOrEmpty(vstrTextToBeEncrypted)) Then
                Return vstrTextToBeEncrypted
            End If

            Dim bytValue() As Byte

            Dim bytKey() As Byte

            Dim bytEncoded() As Byte = Nothing

            Dim bytIV() As Byte = {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62}

            Dim intLength As Integer

            Dim intRemaining As Integer

            Dim objMemoryStream As New MemoryStream()

            Dim objCryptoStream As CryptoStream

            Dim objRijndaelManaged As RijndaelManaged

            ' **********************************************************************

            ' ****** Strip any null character from string to be encrypted ******

            ' **********************************************************************

            vstrTextToBeEncrypted = StripNullCharacters(vstrTextToBeEncrypted)

            ' **********************************************************************

            ' ****** Value must be within ASCII range (i.e., no DBCS chars) ******

            ' **********************************************************************

            bytValue = Encoding.ASCII.GetBytes(vstrTextToBeEncrypted.ToCharArray)

            intLength = Len(vstrEncryptionKey)

            ' ********************************************************************

            ' ****** Encryption Key must be 256 bits long (32 bytes) ******

            ' ****** If it is longer than 32 bytes it will be truncated. ******

            ' ****** If it is shorter than 32 bytes it will be padded ******

            ' ****** with upper-case Xs. ****** 

            ' ********************************************************************

            If intLength >= 32 Then

                vstrEncryptionKey = Strings.Left(vstrEncryptionKey, 32)

            Else

                intLength = Len(vstrEncryptionKey)

                intRemaining = 32 - intLength

                vstrEncryptionKey = vstrEncryptionKey & Strings.StrDup(intRemaining, "X")

            End If

            bytKey = Encoding.ASCII.GetBytes(vstrEncryptionKey.ToCharArray)

            objRijndaelManaged = New RijndaelManaged()

            ' ***********************************************************************

            ' ****** Create the encryptor and write value to it after it is ******

            ' ****** converted into a byte array ******

            ' ***********************************************************************

            Try

                objCryptoStream = New CryptoStream(objMemoryStream, objRijndaelManaged.CreateEncryptor(bytKey, bytIV), CryptoStreamMode.Write)

                objCryptoStream.Write(bytValue, 0, bytValue.Length)

                objCryptoStream.FlushFinalBlock()

                bytEncoded = objMemoryStream.ToArray

                objMemoryStream.Close()

                objCryptoStream.Close()

            Catch

            End Try

            ' ***********************************************************************

            ' ****** Return encryptes value (converted from byte Array to ******

            ' ****** a base64 string). Base64 is MIME encoding) ******

            ' ***********************************************************************

            Return Convert.ToBase64String(bytEncoded)

        Catch ex As Exception

            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "Crypto.EncryptString128Bit", String.Empty, String.Empty, String.Empty)
            Return vstrTextToBeEncrypted

        End Try

    End Function

    '******************** FUNCTION FOR DECRYPTING*********************************** 
    Public Shared Function DecryptString128Bit(ByVal vstrStringToBeDecrypted As String, _
                                            ByVal vstrDecryptionKey As String) As String
        Try
            Dim bytDataToBeDecrypted() As Byte
            Dim bytTemp() As Byte
            Dim bytIV() As Byte = {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62}
            Dim objRijndaelManaged As New RijndaelManaged()
            Dim objMemoryStream As MemoryStream
            Dim objCryptoStream As CryptoStream
            Dim bytDecryptionKey() As Byte

            Dim intLength As Integer
            Dim intRemaining As Integer
            'Dim intCtr As Integer
            Dim strReturnString As String = String.Empty
            'Dim achrCharacterArray() As Char
            'Dim intIndex As Integer

            '   *****************************************************************
            '   ******   Convert base64 encrypted value to byte array      ******
            '   *****************************************************************

            bytDataToBeDecrypted = Convert.FromBase64String(vstrStringToBeDecrypted)

            '   ********************************************************************
            '   ******   Encryption Key must be 256 bits long (32 bytes)      ******
            '   ******   If it is longer than 32 bytes it will be truncated.  ******
            '   ******   If it is shorter than 32 bytes it will be padded     ******
            '   ******   with upper-case Xs.                                  ****** 
            '   ********************************************************************

            intLength = Len(vstrDecryptionKey)

            If intLength >= 32 Then
                vstrDecryptionKey = Strings.Left(vstrDecryptionKey, 32)
            Else
                intLength = Len(vstrDecryptionKey)
                intRemaining = 32 - intLength
                vstrDecryptionKey = vstrDecryptionKey & Strings.StrDup(intRemaining, "X")
            End If

            bytDecryptionKey = Encoding.ASCII.GetBytes(vstrDecryptionKey.ToCharArray)

            ReDim bytTemp(bytDataToBeDecrypted.Length)

            objMemoryStream = New MemoryStream(bytDataToBeDecrypted)

            '   ***********************************************************************
            '   ******  Create the decryptor and write value to it after it is   ******
            '   ******  converted into a byte array                              ******
            '   ***********************************************************************

            Try

                objCryptoStream = New CryptoStream(objMemoryStream, _
                   objRijndaelManaged.CreateDecryptor(bytDecryptionKey, bytIV), _
                   CryptoStreamMode.Read)

                objCryptoStream.Read(bytTemp, 0, bytTemp.Length)

                objCryptoStream.FlushFinalBlock()
                objMemoryStream.Close()
                objCryptoStream.Close()

            Catch

            End Try

            '   *****************************************
            '   ******   Return decypted value     ******
            '   *****************************************

            Return StripNullCharacters(Encoding.ASCII.GetString(bytTemp))
        Catch ex As Exception

            Return vstrStringToBeDecrypted
        End Try
    End Function

    Public Shared Function StripNullCharacters(ByVal vstrStringWithNulls As String) As String

        Dim intPosition As Integer
        Dim strStringWithOutNulls As String

        intPosition = 1
        strStringWithOutNulls = vstrStringWithNulls

        Do While intPosition > 0
            intPosition = InStr(intPosition, vstrStringWithNulls, vbNullChar)

            If intPosition > 0 Then
                strStringWithOutNulls = Left$(strStringWithOutNulls, intPosition - 1) & _
                                  Right$(strStringWithOutNulls, Len(strStringWithOutNulls) - intPosition)
            End If

            If intPosition > strStringWithOutNulls.Length Then
                Exit Do
            End If
        Loop

        Return strStringWithOutNulls

    End Function
    Public Shared Function GetUrlDomain() As String
        Dim Port As String = HttpContext.Current.Request.ServerVariables("SERVER_PORT")

        If Port Is Nothing OrElse Port = "80" Then
            Port = ""
        Else
            Port = ":" + Port
        End If
        Dim Protocol As String = HttpContext.Current.Request.ServerVariables("SERVER_PORT_SECURE")
        If Protocol Is Nothing OrElse Protocol = "0" Then
            Protocol = "http://"
        Else
            Protocol = "https://"
        End If
        Return Protocol + HttpContext.Current.Request.ServerVariables("SERVER_NAME")
    End Function




    Public Shared Function CompressDataSet(ByVal ds As DataSet) As Byte()
        Dim data As Byte()
        Dim memStream As New MemoryStream()
        Dim zipStream As GZipStream = New GZipStream(memStream, CompressionMode.Compress)
        ds.WriteXml(zipStream, XmlWriteMode.WriteSchema)
        zipStream.Close()
        data = memStream.ToArray()
        memStream.Close()
        Return data
    End Function

    Public Shared Function DecompressDataSet(ByVal data As Byte()) As DataSet
        Dim memStream As New MemoryStream(data)
        Dim unzipStream As New GZipStream(memStream, CompressionMode.Decompress)
        Dim objDataSet As New DataSet()
        objDataSet.ReadXml(unzipStream, XmlReadMode.ReadSchema)
        unzipStream.Close()
        memStream.Close()
        Return objDataSet
    End Function
Private Shared ReadOnly RegexBetweenTags As New Regex(">\s+", RegexOptions.Compiled)
    Private Shared ReadOnly RegexLineBreaks As New Regex("\n\s+", RegexOptions.Compiled)
    Public Shared Function RemoveWhitespaceFromHtml(ByVal html As String) As String
        html = RegexBetweenTags.Replace(html, ">")
        html = RegexLineBreaks.Replace(html, String.Empty)

        Return html

        'Dim SB As New StringBuilder()
        'Dim SW As New IO.StringWriter(SB)
        'Dim htmlTW As New HtmlTextWriter(SW)
        'Page.RenderControl(htmlTW)
        'Dim MyHTML As String = SB.ToString()
        'MyHTML = WebOptimizer.RemoveWhitespaceFromHtml(MyHTML)

    End Function


    ' Strips the whitespace from any .css file.
    Public Shared Function RemoveWhitespaceFromCss(ByVal body As String) As String
        body = body.Replace("  ", " ")
        body = body.Replace(Environment.NewLine, [String].Empty)
        body = body.Replace(vbTab, String.Empty)
        body = body.Replace(" {", "{")
        body = body.Replace(" :", ":")
        body = body.Replace(": ", ":")
        body = body.Replace(", ", ",")
        body = body.Replace("; ", ";")
        body = body.Replace(";}", "}")

        ' sometimes found when retrieving CSS remotely
        body = body.Replace("?", String.Empty)

        'body = Regex.Replace(body, @"/\*[^\*]*\*+([^/\*]*\*+)*/", "$1");
        body = Regex.Replace(body, "(?<=[>])\s{2,}(?=[<])|(?<=[>])\s{2,}(?=&nbsp;)|(?<=&ndsp;)\s{2,}(?=[<])", [String].Empty)

        'Remove comments from CSS
        body = Regex.Replace(body, "/\*[\d\D]*?\*/", String.Empty)

        Return body
    End Function

    ' Strips the whitespace from any .js file.
    Public Shared Function RemoveWhitespaceFromJavaScript(ByVal body As String) As String
        Dim lines As String() = body.Split(New String() {Environment.NewLine}, StringSplitOptions.RemoveEmptyEntries)
        Dim emptyLines As New StringBuilder()
        For Each line As String In lines
            Dim s As String = line.Trim()
            If s.Length > 0 AndAlso Not s.StartsWith("//") Then
                emptyLines.AppendLine(s.Trim())
            End If
        Next

        body = emptyLines.ToString()

        ' remove C styles comments
        body = Regex.Replace(body, "/\*.*?\*/", [String].Empty, RegexOptions.Compiled Or RegexOptions.Singleline)
        ' trim left
        body = Regex.Replace(body, "^\s*", [String].Empty, RegexOptions.Compiled Or RegexOptions.Multiline)
        ' trim right
        body = Regex.Replace(body, "\s*[\r\n]", vbCr & vbLf, RegexOptions.Compiled Or RegexOptions.ECMAScript)
        ' remove whitespace beside of left curly braced
        body = Regex.Replace(body, "\s*{\s*", "{", RegexOptions.Compiled Or RegexOptions.ECMAScript)
        ' remove whitespace beside of coma
        body = Regex.Replace(body, "\s*,\s*", ",", RegexOptions.Compiled Or RegexOptions.ECMAScript)
        ' remove whitespace beside of semicolon
        body = Regex.Replace(body, "\s*;\s*", ";", RegexOptions.Compiled Or RegexOptions.ECMAScript)
        ' remove newline after keywords
        body = Regex.Replace(body, "\r\n(?<=\b(abstract|boolean|break|byte|case|catch|char|class|const|continue|default|delete|do|double|else|extends|false|final|finally|float|for|function|goto|if|implements|import|in|instanceof|int|interface|long|native|new|null|package|private|protected|public|return|short|static|super|switch|synchronized|this|throw|throws|transient|true|try|typeof|var|void|while|with)\r\n)", " ", RegexOptions.Compiled Or RegexOptions.ECMAScript)

        Return body
    End Function
	Public Shared Function GetSuperScript(ByVal Number As Integer) As String
        Dim StrScript As String = ""
        If Number = 1 Or Number = 21 Or Number = 31 Then
            StrScript = "st"
        ElseIf Number = 2 Or Number = 22 Then
            StrScript = "nd"
        ElseIf Number = 3 Or Number = 23 Then
            StrScript = "rd"
        ElseIf (Number >= 4 And Number <= 20) Or (Number >= 24 And Number <= 30) Then
            StrScript = "th"
        End If
        Return StrScript
    End Function

#End Region

    Public Shared ReadOnly Property TempExcelPath() As String
        Get
            Return WebConfigurationManager.AppSettings("AttachmentPath_Resources").ToString() & "TempExcelFiles\"
        End Get
    End Property
End Class