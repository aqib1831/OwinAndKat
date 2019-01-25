Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class UMv3_Default
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack = False Then
            Dim TopicDetail As String = String.Empty
            Dim dsModule As DataSet = Nothing
            Dim Type As String = Functions.DecryptData(Request.QueryString("Type"))
            hdnType.Value = Type
            dsModule = Portal.BLL.UM.Modules.GetAllModules(Convert.ToInt32(Type))
            rptClientManual.DataSource = dsModule
            rptClientManual.DataBind()
        End If
    End Sub
End Class