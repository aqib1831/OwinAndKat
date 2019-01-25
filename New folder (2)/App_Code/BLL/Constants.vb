Imports Microsoft.VisualBasic

Public Class CONSTANTS

#Region "Public Shared Variables"

    Public Shared ADJUSTMENT_TIME As Integer = ConfigurationManager.AppSettings("timemargin")
    Public Shared SERVER_TIME_ZONE As Integer = ConfigurationManager.AppSettings("ServerTimeZone")
    Public Shared ISASKFORLATEREASON As Boolean = ConfigurationManager.AppSettings("isAskForLateReason")
    Public Shared HR_ID As Integer = 199


    'Web service to locate website information
    Public Const GETWHOIS = "http://webservicex.net/whois.asmx/GetWhoIS?Hostname="
    Public Const GODADDY = "http://who.godaddy.com/WhoIs.aspx?domain="
    Public Const NETWORKSOLUTION = "http://www.networksolutions.com/whois/results.jsp?domain="

    Public Const NullDate = "#12:00:00 AM#"

#End Region


End Class
