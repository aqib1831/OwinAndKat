Imports Microsoft.VisualBasic
Imports System.Web.HttpUtility

Namespace Portal.DAL
    Public Class WebServiceLog

       

        Public Shared Sub Add(ByVal product As Portal.BLL.Enumeration.ProductNames, ByVal methodName As String)
            Dim objDbManager As New DbManager
            objDbManager.AddParameter("@ProductName", product.ToString())
            objDbManager.AddParameter("@MethodName", methodName)
            objDbManager.AddParameter("@IpAddress", HttpContext.Current.Request.UserHostAddress)
            objDbManager.ExecuteNonQuery("Webservice_Log_Add")
        End Sub

    End Class
End Namespace

