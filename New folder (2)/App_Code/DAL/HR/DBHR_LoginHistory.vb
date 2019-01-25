Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data

Namespace Portal.DAL.HR
    Public Class DBHR_LoginHistory
#Region " Public Method "
        Public Shared Function LoginHistoryGetAll() As List(Of Portal.BLL.HR.HR_LoginHistory)
            Dim colLoginHistory As New List(Of Portal.BLL.HR.HR_LoginHistory)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            dr = db.ExecuteReader("LoginHistory_GetAll")
            While dr.Read()
                colLoginHistory.Add(New Portal.BLL.HR.HR_LoginHistory( _
                CType(dr("ID"), Integer), _
                CType(dr("UserID"), Integer), _
                CType(dr("IP"), String), _
                CType(dr("LogInTime"), DateTime), _
                CType(dr("LogOutTime"), DateTime) _
                ))
            End While
            dr.Close()
            Return colLoginHistory
        End Function
        Public Shared Function LoginHistoryGetByID(ByVal ID As Integer) As List(Of Portal.BLL.HR.HR_LoginHistory)
            Dim colLoginHistory As New List(Of Portal.BLL.HR.HR_LoginHistory)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@ID", ID)
            dr = db.ExecuteReader("LoginHistory_GetByID")
            While dr.Read()
                colLoginHistory.Add(New Portal.BLL.HR.HR_LoginHistory( _
                CType(dr("ID"), Integer), _
                CType(dr("UserID"), Integer), _
                CType(dr("IP"), String), _
                CType(dr("LogInTime"), DateTime), _
                CType(dr("LogOutTime"), DateTime) _
                ))
            End While
            dr.Close()
            Return colLoginHistory
        End Function
        Public Function LoginHistoryAdd(ByVal LoginHistoryBll As Portal.BLL.HR.HR_LoginHistory) As Integer
            Dim db As New DBAccess


            db.AddParameter("@UserID", LoginHistoryBll.UserID)
            db.AddParameter("@IP", LoginHistoryBll.IP)
            db.AddParameter("@LogInTime", LoginHistoryBll.LogInTime)

            db.AddParameter("@ReturnID", SqlDbType.Int, 4, Data.ParameterDirection.ReturnValue, 0)

            db.ExecuteNonQuery("HR_LoginHistory_Add")
            Dim ReturnID As Integer = CInt(CType(db.Parameters("@ReturnID"), System.Data.SqlClient.SqlParameter).Value)
            Return ReturnID
        End Function
        Public Function LoginHistoryUpdate(ByVal LoginHistoryBll As Portal.BLL.HR.HR_LoginHistory) As Integer
            Dim db As New DBAccess

            db.AddParameter("@ID", LoginHistoryBll.ID)
            db.AddParameter("@LogOutTime", LoginHistoryBll.LogOutTime)

            Dim Affected As Integer = db.ExecuteNonQuery("HR_LoginHistory_Update")
            Return Affected
        End Function
#End Region

    End Class
End Namespace