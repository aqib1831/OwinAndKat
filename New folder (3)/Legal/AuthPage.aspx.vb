Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Partial Class admin_research_Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If String.IsNullOrEmpty(Request.QueryString("MySocket")) = False Then
            If String.IsNullOrEmpty(Request.QueryString("CaseID")) = False Then
                DetailURL_FromMySocket.Value = "ID=" & Request.QueryString("ID") & "&CaseID=" & Request.QueryString("CaseID") & "&MySocket=1"
            Else
                DetailURL_FromMySocket.Value = "ID=" & Request.QueryString("ID") & "&IPID=" & Request.QueryString("IPID") & "&MySocket=1"
            End If
        End If
    End Sub

    Protected Sub btnGo_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnGo.Click
        Dim ReturnValue As Integer = 0
        Dim objAdmin As New Admin
        objAdmin.AdminID = Session("Admin_AdminID")
        objAdmin.LoadAdminInformation()

        If objAdmin.AuthenticationPin = txtPin.Text Then
            ReturnValue = Me.AddLogin(objAdmin.AdminID, HttpContext.Current.Request.UserHostAddress, True)
            If ReturnValue < 3 Then
                If DetailURL_FromMySocket.Value <> "" Then
                    Response.Redirect("Default.aspx?" & DetailURL_FromMySocket.Value)
                Else
                    If objAdmin.AdminType = False Then
                        Response.Redirect("Default.aspx")
                    Else
                        Response.Redirect("Default.aspx")
                    End If
                End If
            Else
                Response.Redirect("AccessDenied.htm")
            End If
        Else
            Me.AddLogin(objAdmin.AdminID, HttpContext.Current.Request.UserHostAddress, False)
            trerror.Visible = True
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If String.IsNullOrEmpty(Session("Admin_AdminID")) = True Then
            Response.Redirect("SessionExpire.htm")
        End If
    End Sub

    Public Function AddLogin(ByVal ID As Integer, ByVal IPAddress As String, ByVal isSucessful As Boolean) As Integer

        Dim cmd As New SqlCommand
        Dim conDB As New SqlConnection
        Dim ReturnValue As Integer = 0
        conDB = New SqlConnection(ConfigurationManager.ConnectionStrings("FSConnectionString").ConnectionString)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.CommandText = "Research_AddLogin"
        cmd.Connection = conDB
        cmd.Parameters.Add("@ID", SqlDbType.Int, 4, "ID").Value = ID
        If String.IsNullOrEmpty(IPAddress) = False Then
            cmd.Parameters.Add("@IPAddress", SqlDbType.NVarChar, 200, "IPAddress").Value = IPAddress
        End If
        cmd.Parameters.Add("@IsSucessFull", SqlDbType.Bit, 1, "IsSucessFull").Value = isSucessful
        cmd.Parameters.Add("@ReturnValue", SqlDbType.Int).Direction = ParameterDirection.Output
        cmd.Parameters.Add("@ModuleID", SqlDbType.Int).Value = AdminModules.Legal
        Try
            conDB.Open()
            cmd.ExecuteNonQuery()
            ReturnValue = cmd.Parameters("@ReturnValue").Value
        Catch ex As Exception
        Finally
            conDB.Close()
        End Try
        cmd.Dispose()
        conDB = Nothing
        cmd = Nothing
        Return ReturnValue
    End Function
End Class
