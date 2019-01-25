Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.IO


Namespace Portal.BLL


    Public Class Email

#Region " Private Members "

        Private _LeadId As Integer
        Private _Status As Integer
        Private _TaskType As Integer
        Private _subject As String
        Private _from As String
        Private _to As String
        Private _CompletedOn As DateTime
        Private _cc As String
        Private _bcc As String
        Private _detail As String
        Private _attachments As String
        Private _fileone As String = ""
        Private _filetwo As String = ""
        Private _filethree As String = ""
        Private _DisplayName As String = ""

#End Region

#Region " Public Properties "
        Public Property DisplayName() As String
            Get
                Return _DisplayName
            End Get
            Set(ByVal value As String)
                _DisplayName = value
            End Set
        End Property
        Public Property Filethree() As String
            Get
                Return _filethree
            End Get
            Set(ByVal value As String)
                _filethree = value
            End Set
        End Property
        Public Property Filetwo() As String
            Get
                Return _filetwo
            End Get
            Set(ByVal value As String)
                _filetwo = value
            End Set
        End Property

        Public Property FileOne() As String
            Get
                Return _fileone
            End Get
            Set(ByVal value As String)
                _fileone = value
            End Set
        End Property
        Public Property CompletedDate() As DateTime
            Get
                Return _CompletedOn
            End Get
            Set(ByVal value As DateTime)
                _CompletedOn = value
            End Set
        End Property

        Public Property Attachments() As String
            Get
                Return _attachments
            End Get
            Set(ByVal value As String)
                _attachments = value
            End Set
        End Property


        Public Property Detail() As String
            Get
                Return _detail
            End Get
            Set(ByVal value As String)
                _detail = value
            End Set
        End Property
        Public Property MailBCC() As String
            Get
                Return _bcc
            End Get
            Set(ByVal value As String)
                _bcc = value
            End Set
        End Property

        Public Property MailCC() As String
            Get
                Return _cc
            End Get
            Set(ByVal value As String)
                _cc = value
            End Set
        End Property

        Public Property MailTo() As String
            Get
                Return _to
            End Get
            Set(ByVal value As String)
                _to = value
            End Set
        End Property

        Public Property MailFrom() As String
            Get
                Return _from
            End Get
            Set(ByVal value As String)
                _from = value
            End Set
        End Property
        Public Property TaskType() As Integer
            Get
                Return _TaskType
            End Get
            Set(ByVal value As Integer)
                _TaskType = value
            End Set
        End Property
        Public Property Subject() As String
            Get
                Return _subject
            End Get
            Set(ByVal value As String)
                _subject = value
            End Set
        End Property

        Public Property LeadID() As Integer
            Get
                Return _LeadId
            End Get
            Set(ByVal value As Integer)
                _LeadId = value
            End Set
        End Property

        Public Property StatusID() As Integer
            Get
                Return _Status
            End Get
            Set(ByVal value As Integer)
                _Status = value
            End Set
        End Property


#End Region

        'Public Function Mail_Log() As Integer
        '    Dim intReturn As Integer = 0
        '    Dim sqlCmd As SqlCommand = New SqlCommand()
        '    Dim conn As New SqlConnection(ConfigurationManager.ConnectionStrings("lmsConnectionString").ConnectionString)
        '    If Me._LeadId = 0 Then
        '        DataAccess.AddParamToSQLCmd(sqlCmd, "@LeadID", SqlDbType.Int, 4, ParameterDirection.Input, DBNull.Value)
        '    Else
        '        DataAccess.AddParamToSQLCmd(sqlCmd, "@LeadID", SqlDbType.Int, 4, ParameterDirection.Input, Me._LeadId)
        '    End If

        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@TaskType", SqlDbType.Int, 4, ParameterDirection.Input, Me._TaskType)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@Completedon", SqlDbType.DateTime, 8, ParameterDirection.Input, Me._CompletedOn)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@Subject", SqlDbType.NVarChar, 200, ParameterDirection.Input, Me._subject)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@From", SqlDbType.NVarChar, 100, ParameterDirection.Input, Me._from)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@To", SqlDbType.NVarChar, 100, ParameterDirection.Input, Me._to)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@CC", SqlDbType.NVarChar, 100, ParameterDirection.Input, Me._cc)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@BCC", SqlDbType.NVarChar, 100, ParameterDirection.Input, Me._bcc)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@Detail", SqlDbType.NText, 160000, ParameterDirection.Input, Me._detail)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@Attachments", SqlDbType.NVarChar, 500, ParameterDirection.Input, Me._attachments)
        '    DataAccess.AddParamToSQLCmd(sqlCmd, "@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, intReturn)
        '    sqlCmd.Connection = conn
        '    sqlCmd.CommandType = CommandType.StoredProcedure
        '    sqlCmd.CommandText = "lms_Email_log"
        '    Try
        '        conn.Open()
        '        sqlCmd.ExecuteNonQuery()
        '        intReturn = CType(sqlCmd.Parameters("@ReturnValue").Value, Integer)
        '    Catch ex As Exception
        '        intReturn = 0
        '    Finally
        '        conn.Close()
        '    End Try
        '    conn.Dispose()
        '    Return intReturn

        'End Function

        Public Function Send_mail() As Integer
            Dim Emailaddress As String = ""
            Dim MailMsg As New MailMessage()
            MailMsg.From = New MailAddress(_from.Trim(), _DisplayName)
            If _to <> "" Then
                While _to.IndexOf(",") <> -1
                    Emailaddress = _to.Substring(0, _to.IndexOf(","))
                    Try
                        MailMsg.To.Add(Emailaddress)
                    Catch ex As Exception

                    End Try
                    _to = _to.Substring(_to.IndexOf(",") + 1, _to.Length - (_to.IndexOf(",") + 1))
                End While
                If _to.IndexOf(",") = -1 And _to <> "" Then
                    Try
                        MailMsg.To.Add(_to)
                    Catch ex As Exception

                    End Try

                End If
            End If
            If _cc <> "" Then
                While _cc.IndexOf(",") <> -1
                    Emailaddress = _cc.Substring(0, _cc.IndexOf(","))
                    Try
                        MailMsg.CC.Add(Emailaddress)
                    Catch ex As Exception

                    End Try

                    _cc = _cc.Substring(_cc.IndexOf(",") + 1, _cc.Length - (_cc.IndexOf(",") + 1))
                End While
                If _cc.IndexOf(",") = -1 And _cc <> "" Then
                    Try
                        MailMsg.CC.Add(_cc)
                    Catch ex As Exception

                    End Try
                End If
            End If
            If _bcc <> "" Then
                While _bcc.IndexOf(",") <> -1
                    Emailaddress = _bcc.Substring(0, _bcc.IndexOf(","))
                    Try
                        MailMsg.Bcc.Add(Emailaddress)
                    Catch ex As Exception

                    End Try
                    _bcc = _bcc.Substring(_bcc.IndexOf(",") + 1, _bcc.Length - (_bcc.IndexOf(",") + 1))
                End While
                If _bcc.IndexOf(",") = -1 And _bcc <> "" Then
                    Try
                        MailMsg.Bcc.Add(_bcc)
                    Catch ex As Exception

                    End Try

                End If
            End If
            MailMsg.BodyEncoding = Encoding.Default
            MailMsg.Subject = _subject
            MailMsg.Body = _detail
            If _fileone.Trim() <> String.Empty Then
                MailMsg.Attachments.Add(New Attachment(_fileone))
            End If
            If _filetwo.Trim() <> String.Empty Then
                MailMsg.Attachments.Add(New Attachment(_filetwo))
            End If
            If _filethree.Trim() <> String.Empty Then
                MailMsg.Attachments.Add(New Attachment(_filethree))
            End If
            MailMsg.Priority = MailPriority.Normal
            MailMsg.IsBodyHtml = True
            Dim Client As New SmtpClient("localhost")
            'Client.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis

            Try
                Client.Send(MailMsg)
            Catch ex As Exception
                Throw ex
            End Try
            Client = Nothing
            MailMsg.Dispose()

            Return 1
        End Function


        Public Function GetNewMessageContent() As String
            Dim retVal As String = String.Empty
            Using sr As StreamReader = New StreamReader(HttpContext.Current.Server.MapPath("~/templates/New_Message_Notification.htm"))
                retVal = sr.ReadToEnd
                sr.Close()
            End Using
            Return retVal
        End Function
    End Class
End Namespace