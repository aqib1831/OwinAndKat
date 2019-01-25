Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.Client
    Public Class DBFranchises
#Region " Public Method "
        Public Shared Function FranchisesGetAll(ByVal ClientID As Integer, ByVal StatusID As Integer, ByVal StateID As Integer, ByVal sortExpression As String, ByVal maximumRows As Integer, ByVal startRowIndex As Integer, ByVal txtsearch As String) As List(Of Portal.BLL.Franchises)
            Dim colFranchises As New List(Of Portal.BLL.Franchises)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@StatusID", StatusID)
            db.AddParameter("@StateID", StateID)
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@sortExpression", sortExpression)
            db.AddParameter("@maximumRows", maximumRows)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@searchtxt", txtsearch)
            dr = db.ExecuteReader("Franchises_GetAll")
            While dr.Read()
                colFranchises.Add(New Portal.BLL.Franchises( _
                CType(dr("ID"), Integer), _
                CType(dr("ClientID"), Integer), _
                CType(dr("StoreNick"), String), _
                CType(dr("StoreNumber"), Integer), _
                CType(dr("CorporateName"), String), _
                CType(dr("Status"), Integer), _
                CType(dr("Address"), String), _
                CType(dr("City"), String), _
                CType(dr("ZIP"), String), _
                CType(dr("State"), String), _
                CType(dr("Country"), String), _
                CType(dr("Phone"), String), _
                CType(dr("Fax"), String), _
                CType(dr("OwnerName"), String), _
                CType(dr("StateCode"), String), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("ContactDeleted"), Boolean), _
                CType(dr("StateID"), Integer), _
                CType(dr("CorporateEmail"), String), _
                CType(dr("StoreName"), String), _
                CType(dr("CountryID"), Integer), _
                CType(dr("FranchisePrimaryContactID"), Integer), _
                CType(dr("PrimaryContactID"), Integer), _
                CType(dr("TimeZone"), String), _
                CType(dr("TimeZoneID"), Integer), _
                CType(dr("CCPaymentGateway"), Integer), _
                CType(dr("ContactID"), Integer), _
                CType(dr("LicenseCount"), Integer) _
                ))
            End While
            dr.Close()
            Return colFranchises
        End Function

        Public Shared Function GetQsContactByStoreNumberandClientID(ByVal ClientID As Integer, ByVal StoreNumber As Integer) As SqlDataReader
            Dim dr As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@StoreNumber", StoreNumber)
            db.AddParameter("@ClientID", ClientID)
            dr = db.ExecuteReader("Contacts_GetByStoreNumberandClientID")
            Return dr
        End Function
		
        Public Function UpdateTestStoreStatus(ByVal Status As Boolean, ByVal StoreNumber As Integer, ByVal ClientID As Integer) As Integer
            Dim objDbAccess As New DBAccess
            objDbAccess.AddParameter("@Status", Status)
            objDbAccess.AddParameter("@StoreNumber", StoreNumber)
            objDbAccess.AddParameter("@ClientID", ClientID)
            objDbAccess.ExecuteNonQuery("Franchises_TestStoreStatus_Update")
        End Function
		
		Public Function UpdateFranchiseStatus(ByVal FranchiseID As Integer, ByVal Status As Integer) As Integer
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@FranchiseID", FranchiseID)
            accessObj.AddParameter("@Status", Status)
            Return accessObj.ExecuteNonQuery("Franchise_Status_Update")
        End Function

#End Region

#Region "New Functions From EAI DB Franchises"

        Public Shared Function FranchiseGetByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As List(Of Portal.BLL.Franchises)
            Dim colFranchises As New List(Of Portal.BLL.Franchises)()
            Dim dr As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", FranchiseID)
            dr = db.ExecuteReader("Franchises_DetailsGetByID")
            While dr.Read()
                colFranchises.Add(New Portal.BLL.Franchises( _
                CType(Functions.IfNull(dr("StoreNumber"), 0), Integer), _
                CType(Functions.IfNull(dr("GrandOpening"), DateTime.Now), Date), _
                CType(Functions.IfNull(dr("Status"), 0), Integer), _
                CType(Functions.IfNull(dr("ReqOpeningDate"), DateTime.Now), Date), _
                CType(Functions.IfNull(dr("DateSigned"), DateTime.Now), Date), _
                CType(Functions.IfNull(dr("OwnerName"), ""), String), _
                CType(Functions.IfNull(dr("Address"), ""), String), _
                CType(Functions.IfNull(dr("City"), ""), String), _
                CType(Functions.IfNull(dr("StateCode"), ""), String), _
                CType(Functions.IfNull(dr("ZIP"), ""), String), _
                CType(Functions.IfNull(dr("Phone"), ""), String), _
                CType(Functions.IfNull(dr("Fax"), ""), String), _
                CType(Functions.IfNull(dr("CorporateEmail"), ""), String), _
                CType(Functions.IfNull(dr("CorporateName"), ""), String), _
                CType(Functions.IfNull(dr("StoreNick"), ""), String), _
                CType(Functions.IfNull(dr("CCPaymentGateway"), 1), Integer), _
                CType(dr("TimeZone"), String), _
                CType(dr("IsCorporate"), Boolean), _
                CType(dr("IsTestStore"), Boolean), _
                CType(Functions.IfNull(dr("ClientID"), 0), Integer), _
                CType(Functions.IfNull(dr("ClientName"), ""), String), _
                CType(Functions.IfNull(dr("Notes"), ""), String), _
                CType(Functions.IfNull(dr("StateName"), ""), String), _
                CType(Functions.IfNull(dr("CountryName"), ""), String), _
                CType(Functions.IfNull(dr("FranchiseCoordinator"), ""), String), _
                CType(Functions.IfNull(dr("IsSuspended"), False), Boolean), _
                CType(Functions.IfNull(dr("IsAbandon"), False), Boolean), _
                CType(Functions.IfNull(dr("FranchiseID"), False), Integer), _
                CType(dr("CountryID"), Integer), _
                CType(Functions.IfNull(dr("SubStatus"), 0), Integer) _
                ))
            End While
            dr.Close()
            Return colFranchises
        End Function

        Public Shared Function FranchisesContactByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As SqlDataReader
            Dim dr As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@ID", FranchiseID)
            dr = db.ExecuteReader("Franchises_FranchiseContacts_GetByFranchiseID")
            Return dr
        End Function

        Public Shared Function FranchisesOwnersGetByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As List(Of Portal.BLL.Franchises)
            Dim colFranchises As New List(Of Portal.BLL.Franchises)()
            Dim dr As SqlDataReader
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@FranchiseID", FranchiseID)
            dr = db.ExecuteReader("Franchises_GetOwnersByFranchiseID")

            While dr.Read()
                colFranchises.Add(New Portal.BLL.Franchises( _
                CType(Functions.IfNull(dr("Primary"), 0), Boolean), _
                CType(Functions.IfNull(dr("ID"), 0), Integer), _
                CType(Functions.IfNull(dr("FirstName") & " " & dr("LastName"), ""), String) _
                ))
            End While
            dr.Close()
            Return colFranchises
        End Function
        Public Shared Function OwnersOtherFranchisesGetByID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As DataSet
            Dim Ds As DataSet
            Dim db As DBAccess = New DBAccess()
            db.AddParameter("@FranchiseID", FranchiseID)

            Ds = db.ExecuteDataSet("Franchises_GetContactsByFranchiseID")

            Ds.Tables(0).TableName = "Owners"
            Ds.Tables(1).TableName = "Franchises"
            Ds.Relations.Add("Owner_Franchises", Ds.Tables("Owners").Columns("ID"), Ds.Tables("Franchises").Columns("ID"), False)
            Return Ds
        End Function
        Public Shared Function GetStoreNickByFranchiseID(ByVal ClientID As Integer, ByVal FranchiseID As Integer) As String
            Dim db As DBAccess = New DBAccess()

            db.AddParameter("@FranchiseID", FranchiseID)
            Return db.ExecuteScalar("Franchises_GetStoreNick_ByFranchiseID")

        End Function

 	Public Function Update_NS_Products_TechnicalInfo(ByVal FranchiseID As Integer, ByVal HouseCharge As Boolean, ByVal HouseChargeAmount As String) As Integer
            Dim accessObj As DBAccess = New DBAccess()
            accessObj.AddParameter("@ProductFranchiseID", FranchiseID)
            accessObj.AddParameter("@HouseCharge", HouseCharge)
            accessObj.AddParameter("@HouseChargeAmount", HouseChargeAmount)
            Return accessObj.ExecuteNonQuery("[NS_Products_TechnicalInfo_FranchiseSynch]")
        End Function

#End Region

    End Class
End Namespace