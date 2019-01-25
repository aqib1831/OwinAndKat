Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data.SqlClient
Imports System.Data
Namespace Portal.DAL
    Public Class DBModules
#Region " Public Method "
        Public Shared Function ModulesGetAll() As List(Of Portal.BLL.Modules)
            Dim colModules As New List(Of Portal.BLL.Modules)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            dr = db.ExecuteReader("Modules_GetAll")
            While dr.Read()
                colModules.Add(New Portal.BLL.Modules( _
                CType(dr("ID"), Integer), _
                CType(dr("Name"), String), _
                CType(dr("Code"), String), _
                CType(dr("Sequence"), Integer), _
                CType(dr("Caption"), String), _
                CType(dr("Image"), String), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("URL"), String) _
                ))
            End While
            dr.Close()
            Return colModules
        End Function
        Public Shared Function ModulesGetByIDs(ByVal IDs As String) As List(Of Portal.BLL.Modules)
            Dim colModules As New List(Of Portal.BLL.Modules)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@IDs", IDs)
            dr = db.ExecuteReader("Modules_GetByID")
            While dr.Read()
                colModules.Add(New Portal.BLL.Modules( _
                CType(dr("ID"), Integer), _
                CType(dr("Name"), String), _
                CType(dr("Code"), String), _
                CType(dr("Sequence"), Integer), _
                CType(dr("Caption"), String), _
                CType(dr("Image"), String), _
                CType(dr("Deleted"), Boolean), _
                CType(dr("URL"), String) _
                ))
            End While
            dr.Close()
            Return colModules
        End Function
        Public Shared Function ModulesGetByUserID(ByVal UserID As Integer) As List(Of Portal.BLL.Modules)
            Dim colModules As New List(Of Portal.BLL.Modules)()
            Dim dr As SqlDataReader
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            dr = db.ExecuteReader("Modules_GetByUserID")
            While dr.Read()
                colModules.Add(New Portal.BLL.Modules( _
                CType(dr("ID"), Integer), _
                CType(dr("Name"), String), _
                "", _
                0, _
                "", _
                "", _
                False, _
                "" _
                ))
            End While
            dr.Close()
            Return colModules
        End Function
        Public Shared Function SubModulesGetByUserID(ByVal UserID As Integer) As String
            Dim db As New DBAccess
            db.AddParameter("@UserID", UserID)
            Dim strUsersSubModulesCSV As String = db.ExecuteScalar("SubModules_GetCSVByUserID")
            Return strUsersSubModulesCSV
        End Function
        'Public Function Add(ByVal ModulesBll As Portal.BLL.Modules) As Integer
        '    Dim db As New DBAccess

        '    db.AddParameter("@ID", ModulesBll.ID)
        '    db.AddParameter("@Name", ModulesBll.Name)
        '    db.AddParameter("@Code", ModulesBll.Code)
        '    db.AddParameter("@Sequence", ModulesBll.Sequence)
        '    db.AddParameter("@Caption", ModulesBll.Caption)
        '    db.AddParameter("@Image", ModulesBll.Image)
        '    db.AddParameter("@Deleted", ModulesBll.Deleted)
        '    db.AddParameter("@URL", ModulesBll.URL)

        '    Dim Affected As Integer = db.ExecuteNonQuery(" ")
        '    Return Affected
        'End Function

#End Region

    End Class
End Namespace