Imports System
Imports System.Data
Imports LMS.BusinessLogicLayer
Imports System.Data.SqlClient

Public Class ErrorLogger

    Public Shared Function AddError(ByVal ErrorMessage As String, ByVal StackTrace As String, ByVal Source As String, ByVal MethodName As String, ByVal Browser As String, ByVal IP As String, ByVal AdditionalInfo As String, Optional ByVal ParentErrorID As Integer = NullValues.NullInteger) As Integer

        Dim cmd As New SqlCommand
        Dim conDB As New SqlConnection
        Dim ID As Integer = 0
        conDB = New SqlConnection(ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.CommandText = "ErrorLog_Add"
        cmd.Connection = conDB
        cmd.Parameters.Add("@Date", SqlDbType.DateTime, 8, "Date").Value = Date.Now.ToString()
        cmd.Parameters.Add("@ErrorMessage", SqlDbType.VarChar, 4000, "ErrorMessage").Value = ErrorMessage
        cmd.Parameters.AddWithValue("@StackTrace", StackTrace)
        cmd.Parameters.Add("@Source", SqlDbType.VarChar, 500, "Source").Value = Source
        cmd.Parameters.Add("@MethodName", SqlDbType.VarChar, 200, "MethodName").Value = MethodName
        cmd.Parameters.Add("@Browser", SqlDbType.VarChar, 500, "Browser").Value = Browser
        cmd.Parameters.Add("@IP", SqlDbType.VarChar, 50, "IP").Value = IP
        cmd.Parameters.AddWithValue("@AdditionalInfo", AdditionalInfo)


        cmd.Parameters.Add("@ID", SqlDbType.Int).Direction = ParameterDirection.Output
        Try
            conDB.Open()

            cmd.ExecuteNonQuery()
            ID = cmd.Parameters("@ID").Value
        Catch ex As Exception

        Finally
            conDB.Close()
        End Try
        cmd.Dispose()
        conDB = Nothing
        cmd = Nothing
        Return ID
    End Function

    Shared Sub AddErrorByException(ByVal Exc As Exception)

        Dim strAdditionalInfo As String
        Dim strKey As String

        strAdditionalInfo = "URL" & ControlChars.CrLf & "====" & ControlChars.CrLf & HttpContext.Current.Request.Url.ToString() & ControlChars.CrLf & ControlChars.CrLf & "URL Referrer" & ControlChars.CrLf & "===========" & ControlChars.CrLf & HttpContext.Current.Request.UrlReferrer.ToString()
        strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & ControlChars.CrLf & "Session Variables" & ControlChars.CrLf & "=============="
        For Each strKey In HttpContext.Current.Session.Keys
            strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & strKey & " = " & HttpContext.Current.Session.Item(strKey)
        Next
        strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & ControlChars.CrLf & "Cookies" & ControlChars.CrLf & "======"
        For Each strKey In HttpContext.Current.Request.Cookies.Keys
            strAdditionalInfo = strAdditionalInfo & ControlChars.CrLf & strKey & " = " & HttpContext.Current.Request.Cookies(strKey).Value
        Next

        If Exc.InnerException Is Nothing Then
            ErrorLogger.AddError(Exc.ToString(), Exc.StackTrace, Exc.Source, Exc.TargetSite.Name, HttpContext.Current.Request.UserAgent, HttpContext.Current.Request.UserHostAddress, strAdditionalInfo)
        Else
            ErrorLogger.AddError(Exc.InnerException.ToString(), Exc.InnerException.StackTrace, Exc.InnerException.Source, Exc.InnerException.TargetSite.Name, HttpContext.Current.Request.UserAgent, HttpContext.Current.Request.UserHostAddress, strAdditionalInfo)
        End If

    End Sub


End Class

Class NullValues

    Public Const NullDate As Date = #12:00:00 AM#               ' Null Value For Date
    Public Const NullInteger As Integer = Integer.MinValue      ' Null Value For Integer
    Public Const NullDecimal As Decimal = Decimal.MinValue      ' Null Value For Decimal

End Class
