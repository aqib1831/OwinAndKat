Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL.QS
    Public Class DBQS_Users
#Region " Public Method "
        Public Shared Function QS_UsersGetAll(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer, ByVal sortBy As String, ByVal startRowIndex As Integer, ByVal maximumRows As Integer) As List(Of Portal.BLL.QS.QS_Users)
            Dim colQS_Users As New List(Of Portal.BLL.QS.QS_Users)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@searchtxt", search)
            db.AddParameter("@sortExpression", sortBy)
            db.AddParameter("@startRowIndex", startRowIndex)
            db.AddParameter("@maximumRows", maximumRows)
            dr = db.ExecuteReader("QS_Users_GetAll")
            While dr.Read()
                colQS_Users.Add(New Portal.BLL.QS.QS_Users( _
                CType(dr("ID"), Integer), _
                CType(dr("ClientID"), Integer), _
                CType(dr("FranchiseID"), Integer), _
                CType(dr("KEY"), String), _
                CType(dr("IP"), String), _
                CType(dr("GeneratedOn"), Date), _
                CType(dr("ConsumedOn"), Date), _
                CType(dr("Consumed"), Boolean), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("IsStaticIP"), Boolean), _
                CType(dr("Version"), String), _
                CType(dr("Notes"), String), _
                CType(dr("UpdatedOn"), Date), _
                CType(dr("UpdatedBy"), Integer), _
                CType(dr("LastTimeSync"), Date), _
                CType(dr("StoreNumber"), Integer), _
                CType(dr("StoreNick"), String), _
                CType(dr("ClientCode"), String) _
                ))
            End While
            dr.Close()
            Return colQS_Users
        End Function
        Public Shared Function QS_UsersGetAllCount(ByVal search As String, ByVal ClientID As Integer, ByVal Inactive As Integer, ByVal StoreID As Integer) As Integer
            Dim colQS_Users As New List(Of Portal.BLL.QS.QS_Users)()
            Dim db As New DBAccess
            db.AddParameter("@ClientID", ClientID)
            db.AddParameter("@Inactive", Inactive)
            db.AddParameter("@StoreID", StoreID)
            db.AddParameter("@searchtxt", search)
            Return db.ExecuteScalar("QS_Users_GetAllCount")
        End Function
        Public Shared Function QS_UsersGetByID(ByVal ID As Integer) As Portal.BLL.QS.QS_Users
            Dim colQS_Users As New Portal.BLL.QS.QS_Users
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("QS_Users_GetByID")
            If (dr.HasRows) Then
                While dr.Read()
                    colQS_Users.ID = CType(dr("ID"), Integer)
                    colQS_Users.ClientID = CType(dr("ClientID"), Integer)
                    colQS_Users.FranchiseID = CType(dr("FranchiseID"), Integer)
                    colQS_Users.KEY = CType(dr("KEY"), String)
                    colQS_Users.IP = CType(dr("IP"), String)
                    colQS_Users.GeneratedOn = CType(dr("GeneratedOn"), Date)
                    colQS_Users.ConsumedOn = CType(dr("ConsumedOn"), Date)
                    colQS_Users.Consumed = CType(dr("Consumed"), Boolean)
                    colQS_Users.Deleted = CType(dr("Deleted"), Boolean)
                    colQS_Users.IsStaticIP = CType(dr("IsStaticIP"), Boolean)
                    colQS_Users.Version = CType(dr("Version"), String)
                    colQS_Users.Notes = CType(dr("Notes"), String)
                    colQS_Users.UpdatedOn = CType(dr("UpdatedOn"), Date)
                    colQS_Users.UpdatedBy = CType(dr("UpdatedBy"), Integer)
                    colQS_Users.LastTimeSync = CType(dr("LastTimeSync"), Date)
                    colQS_Users.StoreNumber = CType(dr("StoreNumber"), Integer)
                    colQS_Users.StoreNick = CType(dr("StoreNick"), String)
                    colQS_Users.ClientCode = CType(dr("ClientName"), String)
                    colQS_Users.UpdatedByName = CType(dr("UpdatedByName"), String)
                End While
            End If
            dr.Close()
            Return colQS_Users
        End Function
        'Public Function Add(ByVal QS_UsersBll As Portal.BLL.QS.QS_Users) As Integer
        '    Dim db As New DBAccess

        '    db.AddParameter("@ID", QS_UsersBll.ID)
        '    db.AddParameter("@ClientID", QS_UsersBll.ClientID)
        '    db.AddParameter("@FranchiseID", QS_UsersBll.FranchiseID)
        '    db.AddParameter("@KEY", QS_UsersBll.KEY)
        '    db.AddParameter("@IP", QS_UsersBll.IP)
        '    db.AddParameter("@GeneratedOn", QS_UsersBll.GeneratedOn)
        '    db.AddParameter("@ConsumedOn", QS_UsersBll.ConsumedOn)
        '    db.AddParameter("@Consumed", QS_UsersBll.Consumed)
        '    db.AddParameter("@Deleted", QS_UsersBll.Deleted)
        '    db.AddParameter("@IsStaticIP", QS_UsersBll.IsStaticIP)
        '    db.AddParameter("@Version", QS_UsersBll.Version)
        '    db.AddParameter("@Notes", QS_UsersBll.Notes)
        '    db.AddParameter("@UpdatedOn", QS_UsersBll.UpdatedOn)
        '    db.AddParameter("@UpdatedBy", QS_UsersBll.UpdatedBy)
        '    db.AddParameter("@LastTimeSync", QS_UsersBll.LastTimeSync)

        '    Dim Affected As Integer = db.ExecuteNonQuery(" ")
        '    Return Affected
        'End Function

        Public Function Update(ByVal ID As Integer, ByVal IP As String, ByVal IsStaticIP As Boolean, ByVal Notes As String, ByVal UpdatedOn As Date, ByVal UpdatedBy As Integer) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", ID)
            'db.AddParameter("@ClientID", ClientID)
            'db.AddParameter("@FranchiseID", FranchiseID)
            'db.AddParameter("@KEY", KEY)
            db.AddParameter("@IP", IP)
            'db.AddParameter("@GeneratedOn", GeneratedOn)
            'db.AddParameter("@ConsumedOn", ConsumedOn)
            'db.AddParameter("@Consumed", Consumed)
            'db.AddParameter("@Deleted", Deleted)
            db.AddParameter("@IsStaticIP", IsStaticIP)
            'db.AddParameter("@Version", Version)
            db.AddParameter("@Notes", Notes)
            db.AddParameter("@UpdatedOn", UpdatedOn)
            db.AddParameter("@UpdatedBy", UpdatedBy)
            'db.AddParameter("@LastTimeSync", LastTimeSync)

            Dim Affected As Integer = db.ExecuteNonQuery("QS_Users_Update")
            Return Affected
        End Function

#End Region

    End Class
End Namespace