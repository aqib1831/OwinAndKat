Imports System.Data
Imports System.Data.SqlClient
Partial Class UpdateSupportPackages
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("AdminID") = 98 Then
            UpdatePackages()
        End If


    End Sub

    Private Sub UpdatePackages()
        Dim db As New DBAccess
        Dim dt As DataTable

        dt = db.ExecuteDataTable("GetFranchisesForSupportPackages")
        If dt.Rows.Count > 0 Then
            For Each dr As DataRow In dt.Rows
                Add(dr(0), dr(1))
            Next
        End If
        db.Dispose()
    End Sub
    Private Sub Add(ByVal franchiseID As Integer, ByVal StoreNumber As Integer)
        Dim Price As Double = 0.0
        Dim ProductID As Integer = 0

        Dim db As New DBAccess
        Dim dr As SqlDataReader
        db.AddParameter("@FranchiseID", franchiseID)
        dr = db.ExecuteReader("GetProductPriceForSupportPackage")
        While dr.Read
            Price = dr(0)
            ProductID = dr(1)
            Dim objProductFranchises As New Portal.BLL.NS.NS_Products_Franchises
            With objProductFranchises
                .ProductID = ProductID
                .FranchiseID = franchiseID
                .onSupport = True
                .SupportStartDate = "03/01/2011"
                .SupportEnddate = "12/31/2030"
                .UpdatedBy = 98
                .UpdatedOn = DateTime.Now
                .Inactive = False
                .Notes = "New Package"
                .Price = Price
                .NoOfLicenses = Integer.MinValue
                Dim result As Integer = 0
                UpdateSupport(franchiseID)
                result = Portal.BLL.NS.NS_Products_Franchises.NS_Products_FranchisesAdd(.ProductID, .FranchiseID, .onSupport, .SupportStartDate, .SupportEnddate, .UpdatedBy, .UpdatedOn, .Inactive, .Notes, .Price, .NoOfLicenses)
                If result > 0 Then
                    Response.Write(StoreNumber & " store has been updated with  " & dr(2) & " package. <br>")
                End If

            End With
        End While
        dr.Close()

    End Sub


    Private Sub UpdateSupport(ByVal franchiseID As Integer)
        Dim db As New DBAccess
        db.AddParameter("@FranchiseID", franchiseID)
        db.ExecuteNonQuery("InactiveSupport")
        db.Dispose()
    End Sub
End Class
