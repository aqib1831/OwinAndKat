Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL
    Public Class DBNSProducts
        Dim cnn As New SqlConnection()
        Dim da_Products As New SqlDataAdapter()
        Dim cmd As New SqlCommand
#Region "Public Methods"
        Public Shared Function ProductsGetAll(ByVal Search As String, ByVal Type As Integer, ByVal sortExpression As String) As List(Of Portal.BLL.NSProducts)
            Dim colNS_Products As New List(Of Portal.BLL.NSProducts)()
            Dim dr_Products As SqlDataReader = Nothing
            Dim db As New DBAccess
            If Search Is Nothing Or Search Is "" Then
                db.AddParameter("@Search", DBNull.Value)
            Else
                db.AddParameter("@Search", Search)
            End If
            If Type = 0 Then
                db.AddParameter("@Type", 0)
            Else
                db.AddParameter("@Type", Type)
            End If
            If sortExpression Is Nothing Or sortExpression = "" Then
                db.AddParameter("@sortExpression", DBNull.Value)
            Else
                db.AddParameter("@sortExpression", sortExpression)
            End If
            dr_Products = db.ExecuteReader("NS_ProductsGetAll")
            While dr_Products.Read()
                colNS_Products.Add(New Portal.BLL.NSProducts( _
                CType(Functions.IfNull(dr_Products("ID"), 0), Integer), _
                CType(Functions.IfNull(dr_Products("Title"), ""), String), _
                CType(Functions.IfNull(dr_Products("Abbreviation"), ""), String), _
                CType(Functions.IfNull(dr_Products("Type"), 0), Integer), _
                CType(Functions.IfNull(dr_Products("Price"), 0.0), Decimal), _
                CBool(dr_Products("CheckForSupport"))))
                'CType(dr("MonthlySupportPrice"), Decimal) _
                '  )))
            End While
            dr_Products.Close()
            Return colNS_Products
        End Function
        Public Shared Function ProductsGetAllCount(ByVal Search As String, ByVal Type As Integer, ByVal sortExpression As String) As Integer
            Dim db As New DBAccess
            If Search Is Nothing Or Search Is "" Then
                db.AddParameter("@Search", DBNull.Value)
            Else
                db.AddParameter("@Search", Search)
            End If
            If Type = 0 Then
                db.AddParameter("@Type", 0)
            Else
                db.AddParameter("@Type", Type)
            End If
            If sortExpression Is Nothing Or sortExpression = "" Then
                db.AddParameter("@sortExpression", DBNull.Value)
            Else
                db.AddParameter("@sortExpression", sortExpression)
            End If
            Return CType(db.ExecuteScalar("NS_ProductsGetAllCount"), Integer)
        End Function
        Public Shared Function NS_ProductsGetByID(ByVal ID As Integer) As List(Of Portal.BLL.NSProducts)
            Dim colNS_Products As New List(Of Portal.BLL.NSProducts)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("NS_ProductsGetByID")
            While dr.Read()
                colNS_Products.Add(New Portal.BLL.NSProducts( _
                CType(dr("ID"), Integer), _
                CType(dr("Title"), String), _
                CType(dr("Abbreviation"), String), _
                CType(dr("Type"), Integer), _
                CType(dr("Price"), Decimal), _
                CBool(dr("CheckForSupport")) _
                ))
            End While
            dr.Close()
            Return colNS_Products
        End Function
        Public Shared Function Add(ByVal ObjNSProduct As Portal.BLL.NSProducts) As Integer
            Dim ID As Integer = 0
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Title", ObjNSProduct.Title)
            db.AddParameter("@Abbreviation", ObjNSProduct.Abbreviation)
            db.AddParameter("@Type", ObjNSProduct.Type)
            db.AddParameter("@Price", ObjNSProduct.Price)
            db.AddParameter("@PriceOption", ObjNSProduct.PriceOption)
            If ObjNSProduct.ParentID = 0 Then
                db.AddParameter("@ParentID", DBNull.Value)
            Else
                db.AddParameter("@ParentID", ObjNSProduct.ParentID)
            End If
            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, -1)
            Try
                db.ExecuteNonQuery("NS_Add_Product")
                ID = CInt(db.Parameters("@ID").Value)
            Catch ex As Exception
                ID = 0
            Finally
                db.Dispose()
            End Try
            Return ID
        End Function

        Public Shared Function GetModulesByProductsID(ByVal Search As String, ByVal Type As Integer, ByVal sortExpression As String, ByVal ParentID As Integer) As List(Of Portal.BLL.NSProducts)
            Dim colNS_ProductModules As New List(Of Portal.BLL.NSProducts)()
            Dim dr_Modules As SqlDataReader
            Dim db As New DBAccess
            If Search Is Nothing Or Search Is "" Then
                db.AddParameter("@Search", DBNull.Value)
            Else
                db.AddParameter("@Search", Search)
            End If
            If Type = 0 Then
                db.AddParameter("@Type", 0)
            Else
                db.AddParameter("@Type", Type)
            End If
            If sortExpression Is Nothing Or sortExpression = "" Then
                db.AddParameter("@sortExpression", DBNull.Value)
            Else
                db.AddParameter("@sortExpression", sortExpression)
            End If
            If ParentID = 0 Then
                db.AddParameter("@ID", DBNull.Value)
            Else
                db.AddParameter("@ID", ParentID)
            End If
            dr_Modules = db.ExecuteReader("NS_GetModulesByProductID")
            While dr_Modules.Read()
                colNS_ProductModules.Add(New Portal.BLL.NSProducts( _
                CType(Functions.IfNull(dr_Modules("ID"), 0), Integer), _
                CType(Functions.IfNull(dr_Modules("Title"), ""), String), _
                CType(Functions.IfNull(dr_Modules("Abbreviation"), ""), String), _
                CType(Functions.IfNull(dr_Modules("Type"), 0), Integer), _
                CType(Functions.IfNull(dr_Modules("Price"), 0.0), Decimal), _
                 CType(Functions.IfNull(dr_Modules("ParentID"), 0), Integer) _
                  ))
            End While
            dr_Modules.Close()
            Return colNS_ProductModules
        End Function

        Public Shared Function AddModule(ByVal ObjNSProduct As Portal.BLL.NSProducts) As Integer
            Dim ID As Integer = 0
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@Title", ObjNSProduct.Title)
            db.AddParameter("@Abbreviation", ObjNSProduct.Abbreviation)
            db.AddParameter("@Type", ObjNSProduct.Type)
            db.AddParameter("@Price", ObjNSProduct.Price)
            db.AddParameter("@PriceOption", ObjNSProduct.PriceOption)
            db.AddParameter("@ProductID", ObjNSProduct.ParentID)
            db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, -1)
            Try
                db.ExecuteNonQuery("NS_Add_ProductModule")
                ID = CInt(db.Parameters("@ID").Value)
            Catch ex As Exception
                ID = 0
            Finally
                db.Dispose()
            End Try
            Return ID
        End Function
        Public Shared Function GetProductsAndModules(ByVal ClientID As Integer) As DataSet
            Dim ds_ProductsAndModules As DataSet
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            ds_ProductsAndModules = db.ExecuteDataSet("NS_GetProductModules")
            ds_ProductsAndModules.Tables(0).TableName = "ProductTypes"
            ds_ProductsAndModules.Tables(1).TableName = "Products"
            ds_ProductsAndModules.Tables(2).TableName = "Modules"
            ds_ProductsAndModules.Relations.Add("ProductTypes", ds_ProductsAndModules.Tables("ProductTypes").Columns("ID"), ds_ProductsAndModules.Tables("Products").Columns("Type"), False)
            ds_ProductsAndModules.Relations.Add("ProductModules", ds_ProductsAndModules.Tables("Products").Columns("ID"), ds_ProductsAndModules.Tables("Modules").Columns("ParentID"), False)
            Return ds_ProductsAndModules
        End Function
        Public Shared Function AddClientProuducts(ByVal ProductIDs As String, ByVal BillTo As String, ByVal ClientID As Integer) As Integer
            Dim db As New DBAccess
            Dim returnValue As Integer = 0
            db.AddParameter("@ProductIDs", ProductIDs)
            db.AddParameter("@BillTo", BillTo)
            db.AddParameter("@ClientID", ClientID)
            returnValue = db.ExecuteNonQuery("NS_Add_ClientProducts")
            Return returnValue
        End Function

        Public Function GetDataSet(ByVal ClientID As Integer) As DataSet
            Dim ds_Products As New DataSet
            Dim sqlCb As SqlCommandBuilder
            cmd.CommandType = CommandType.StoredProcedure
            cmd.CommandText = "NS_GetProductsByClientID"
            cmd.Parameters.Add("@ClientID", SqlDbType.Int).Value = ClientID
            cmd.Connection = cnn
            da_Products.SelectCommand = cmd
            Open()
            da_Products.Fill(ds_Products)
            sqlCb = New SqlCommandBuilder(da_Products)
            ds_Products.Tables(0).TableName = "Products"
            For Each row As DataRow In ds_Products.Tables("Products").Rows
                row.Delete()
            Next
            Close()
            Return ds_Products
        End Function
        Public Sub UpdateDataSet(ByRef ds_Products As DataSet)
            Open()
            da_Products = New SqlDataAdapter()
            Dim sqlCb As New SqlCommandBuilder(da_Products)
            da_Products.Update(ds_Products, "Products")
            Close()
        End Sub
        Public Sub Open()
            Dim strConnectionString As String = ""
            Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
            strConnectionString = objConnectionStringSettings.ConnectionString
            cnn.ConnectionString = strConnectionString
            cnn.Open()
        End Sub
        Public Sub Close()
            If cnn.State = ConnectionState.Open Then
                cnn.Close()
            End If
        End Sub
        Public Shared Function GetModuleByID(ByVal ID As Integer) As SqlDataReader
            Dim dr_Module As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr_Module = db.ExecuteReader("NS_GetModuleByID")
            Return dr_Module
        End Function
        Public Shared Function UpdateModule(ByVal obj As Portal.BLL.NSProducts) As Integer
            Dim db As New DBAccess
            Dim ID As Integer = 0
            db.AddParameter("@ProductID", obj.ID)
            db.AddParameter("@Title", obj.Title)
            db.AddParameter("@Abbreviation", obj.Abbreviation)
            db.AddParameter("@Type", obj.Type)
            db.AddParameter("@Price", obj.Price)
            db.AddParameter("@PriceOption", obj.PriceOption)
            db.AddParameter("@ParentID", obj.ParentID)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, -1)
            db.ExecuteNonQuery("NS_Update_Product")
            ID = CInt(db.Parameters("@ReturnValue").Value)
            Return ID
        End Function
        Public Shared Function GetProductByID(ByVal ProductID As Integer) As SqlDataReader
            Dim ProductName As String = ""
            Dim dr_Product As SqlDataReader = Nothing
            Dim db As New DBAccess
            db.AddParameter("@ProductID", ProductID)
            dr_Product = db.ExecuteReader("NS_GetProductByID")
            Return dr_Product
        End Function
        Public Shared Function UpdateProduct(ByVal obj As Portal.BLL.NSProducts) As Integer
            Dim db As New DBAccess
            Dim ID As Integer = 0
            db.AddParameter("@ProductID", obj.ID)
            db.AddParameter("@Title", obj.Title)
            db.AddParameter("@Abbreviation", obj.Abbreviation)
            db.AddParameter("@Type", obj.Type)
            db.AddParameter("@Price", obj.Price)
            db.AddParameter("@PriceOption", obj.PriceOption)
            db.AddParameter("@ReturnValue", SqlDbType.Int, 4, ParameterDirection.Output, -1)
            db.ExecuteNonQuery("NS_Update_Product")
            ID = CInt(db.Parameters("@ReturnValue").Value)
            Return ID
        End Function

        Public Shared Function GetClientProductsByFranchiseID(ByVal FranchiseID As Integer, ByVal ClientID As Integer) As DataSet
            Dim accessObj As DBAccess = New DBAccess()
            Dim dsClientProduct As DataSet = Nothing
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            accessObj.AddParameter("@ClientID", ClientID)
            dsClientProduct = accessObj.ExecuteDataSet("Ns_Products_GetByFranchiseID")
            If (dsClientProduct.Tables.Count = 2) Then
                dsClientProduct.Relations.Add("ProductDetail", dsClientProduct.Tables(0).Columns("ID"), dsClientProduct.Tables(1).Columns("ProductID"))
            ElseIf (dsClientProduct.Tables.Count = 3) Then
                dsClientProduct.Relations.Add("ProductDetail", dsClientProduct.Tables(0).Columns("ID"), dsClientProduct.Tables(1).Columns("ProductID"))
                dsClientProduct.Relations.Add("SubProductDetail", dsClientProduct.Tables(1).Columns("ProductID"), dsClientProduct.Tables(2).Columns("ParentID"))
            End If
            Return dsClientProduct
        End Function

        Public Shared Sub InactiveProductsByFranchiseID(ByVal FranchiseID As Integer)
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            accessObj.ExecuteNonQuery("NS_Products_Inactive")
        End Sub


        Public Shared Sub ActiveProductsByFranchiseID(ByVal FranchiseID As Integer)
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            accessObj.ExecuteNonQuery("NS_Products_Active")
        End Sub

        Public Shared Function Check_Has_Product(ByVal FranchiseID As Integer, ByVal ProductID As Integer)
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            accessObj.AddParameter("@ID", ProductID)
            Dim returnval As Integer = CInt(accessObj.ExecuteScalar("NS_Products_Franchises_CheckProduct"))
            If returnval >= 1 Then
                Return True
            Else
                Return False
            End If
        End Function
        Public Shared Function ShouldCheckForSupport(ByVal ProductID As Integer) As Boolean
            Dim colNS_Products As List(Of Portal.BLL.NSProducts) = NS_ProductsGetByID(ProductID)
            Return colNS_Products(0).CheckForSupport
        End Function

#End Region
    End Class
End Namespace


