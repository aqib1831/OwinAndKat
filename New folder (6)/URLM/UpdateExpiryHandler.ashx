<%@ WebHandler Language="VB" Class="UpdateExpiryHandler" %>

Imports System
Imports System.Web
Imports System.Threading

Public Class UpdateExpiryHandler : Implements IHttpHandler
    
    Public Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        
        Dim expdate As String = context.Request.QueryString("expDate")
        Dim urlID As Integer = context.Request.QueryString("URLID")
        Dim URL As String = context.Request.QueryString("URL")
        UpdateExpiry(expdate, urlID, URL)
        context.Response.Write("Success")
    End Sub
    Protected Sub UpdateExpiry(ByVal expdate As String, ByVal urlID As Integer, ByVal url As String)
        Try
            Dim objURLm As New URLM
            Dim rtValue As Integer
            With objURLm
                .ExpirationDate = expdate
                .UrlId = urlID
                .URL = url
                rtValue = .UpdateURLExpirayDate()
            End With
            
        Catch ex As Exception
        End Try
    End Sub
    Public ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class