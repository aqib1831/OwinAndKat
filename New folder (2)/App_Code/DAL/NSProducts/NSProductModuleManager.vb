Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Namespace Portal.DAL
    Public Class NSProductModuleManager

	Public Function GetAll(ByVal ProductID As Integer, ByVal Inactive As Integer, ByVal Search As String) As DataTable
            Dim dbManager As New DBAccess()
            dbManager.AddParameter("@ProductID", ProductID)
            dbManager.AddParameter("@Inactive", Inactive)
            dbManager.AddParameter("@Search", Search)
            Return dbManager.ExecuteDataTable("NS_ProductModules_GetAll")
        End Function

        Public Shared Sub Update(ByVal ID As Integer, _
                          ByVal Name As String, _
                          ByVal Inactive As Boolean, _
                          ByVal RelatedToProductID As Integer)
            Dim dbManager As New DBAccess()
            dbManager.AddParameter("@ID", ID)
            dbManager.AddParameter("@Name", Name)
            dbManager.AddParameter("@Inactive", Inactive)
            dbManager.AddParameter("@RelatedToProductID", RelatedToProductID)
            dbManager.ExecuteNonQuery("NS_ProductModules_Update")
        End Sub

        Public Shared Sub UpdateStatus(ByVal ID As Integer, ByVal Inactive As Boolean)
            Dim dbManager As New DBAccess()
            dbManager.AddParameter("@ID", ID)
            dbManager.AddParameter("@Inactive", Inactive)
            dbManager.ExecuteNonQuery("NS_ProductModules_UpdateStatus")
        End Sub

        Public Shared Function Add(ByVal Name As String, _
                                   ByVal Inactive As Boolean, _
                                   ByVal RelatedToProductID As Integer, _
                                   ByVal AddedBy As Integer, _
                                   ByVal AddedOn As DateTime) As Integer
            Dim dbManager As New DBAccess()
            dbManager.AddParameter("@ID", Data.SqlDbType.Int, 4, Data.ParameterDirection.Output, 0)
            dbManager.AddParameter("@Name", Name)
            dbManager.AddParameter("@Inactive", Inactive)
            dbManager.AddParameter("@RelatedToProductID", RelatedToProductID)
            dbManager.AddParameter("@AddedBy", AddedBy)
            dbManager.AddParameter("@AddedOn", AddedOn)
            dbManager.ExecuteNonQuery("NS_ProductModules_Add")
            Return dbManager.Parameters("@ID").Value
        End Function

        Public Shared Function ModuleExists(ByVal RelatedToProductID As Integer, ByVal Name As String) As Boolean
            Dim dbManager As New DBAccess()
            dbManager.AddParameter("@RelatedToProductID", RelatedToProductID)
            dbManager.AddParameter("@Name", Name)
            Dim rdrModule As SqlDataReader = dbManager.ExecuteReader("NS_ProductModules_Exists")
            Dim Exists As Boolean = rdrModule.HasRows
            rdrModule.Close()
            dbManager.Dispose()
            Return Exists
        End Function

        Public Shared Function getModule(ByVal ID As Integer) As Portal.BLL.NSProductModule
            Dim dbManager As New DBAccess()
            dbManager.AddParameter("@ID", ID)
            Dim rdrModule As SqlDataReader = dbManager.ExecuteReader("NS_ProductModules_GetByID")
            Dim NSModule As New Portal.BLL.NSProductModule()
            If rdrModule.Read() Then
                NSModule.ID = ID
                NSModule.Name = rdrModule("Name")
                NSModule.RelatedToProductID = rdrModule("RelatedToProductID")
                NSModule.Inactive = rdrModule("Inactive")
                NSModule.AddedBy = rdrModule("AddedBy")
                NSModule.AddedOn = rdrModule("AddedOn")
            End If
            rdrModule.Close()
            dbManager.Dispose()

            Return NSModule
        End Function
    End Class
End Namespace
