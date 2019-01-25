Imports System
Imports System.Collections.Generic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Web.Script.Serialization
Imports System.IO



Partial Class LM_GroupManagement
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            hdnUserID.Value = Session("AdminID").ToString()
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "Page_Load", String.Empty, String.Empty, String.Empty)
        End Try
    End Sub

    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=True)> _
    Public Shared Function GetGroupStoresByGroupID(ByVal countryID As Integer, ByVal groupID As Integer, ByVal updateID As Integer) As Object
        Try
        If (groupID <> 0) Then
            Dim ds As DataSet = Portal.BLL.UpdateManagement.GetGroupStoresByGroupID(countryID, groupID, updateID)
            Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim rows As New List(Of Dictionary(Of String, Object))
            Dim row As Dictionary(Of String, Object)

            For Each dr As DataRow In ds.Tables(0).Rows
                row = New Dictionary(Of String, Object)
                For Each col As DataColumn In ds.Tables(0).Columns
                    row.Add(col.ColumnName, dr(col))
                Next
                rows.Add(row)
            Next
            Dim json As String = serializer.Serialize(rows)
            Return New JavaScriptSerializer().Deserialize(Of Object)(json)
        End If
            Return Nothing
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "GetGroupStoresByGroupID", String.Empty, String.Empty, String.Empty)
        End Try
    End Function

    
    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json, UseHttpGet:=True)> _
    Public Shared Function GetAvailableStores(ByVal countryID As Integer, ByVal updateID As Integer) As Object
        Try
        Dim ds As DataSet = Portal.BLL.UpdateManagement.GetAvailableStores(countryID, updateID)
        If (ds Is Nothing) Then
            Return String.Empty
        End If

        Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))
        Dim row As Dictionary(Of String, Object)

        For Each dr As DataRow In ds.Tables(0).Rows
            row = New Dictionary(Of String, Object)
            For Each col As DataColumn In ds.Tables(0).Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Dim json As String = serializer.Serialize(rows)
            Return New JavaScriptSerializer().Deserialize(Of Object)(json)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "GetAvailableStores", String.Empty, String.Empty, String.Empty)
        End Try
    End Function

 
    <WebMethod()> _
    Public Shared Function AddUpdateGroupStores(ByVal arrStoreID() As Integer, ByVal groupTitle As String, ByVal statusID As Integer, _
                                                ByVal name As String, ByVal threshold As Integer, ByVal updateMandatoryDate As DateTime, _
                                                ByVal isMandatory As Boolean,ByVal isMinor As Boolean, ByVal groupID As Integer, ByVal updateID As Integer, _
                                                ByVal countryID As Integer, ByVal userID As Integer,ByVal build_no As String) As Boolean
        Try
        Dim rowsAffected As Integer = 0
        Dim dtGroup As New DataTable
        Dim dtStore As New DataTable

        Dim ds As New DataSet

        dtGroup.Columns.Add("GroupID", GetType(Integer))
        dtGroup.Columns.Add("Title", GetType(String))
        dtGroup.Columns.Add("Name", GetType(String))
        dtGroup.Columns.Add("StatusID", GetType(Integer))
        dtGroup.Columns.Add("Threshold", GetType(Integer))
        dtGroup.Columns.Add("UpdateMandatoryDate", GetType(DateTime))
        dtGroup.Columns.Add("UpdateID", GetType(Integer))
        dtGroup.Columns.Add("IsMandatory", GetType(Boolean))
        dtGroup.Columns.Add("build_no", GetType(String))
        dtGroup.Columns.Add("IsMinor", GetType(Boolean))
        dtGroup.Columns.Add("UserID", GetType(Integer))

        dtStore.Columns.Add("StoreID", GetType(Integer))
        dtStore.Columns.Add("GroupID", GetType(Integer))
        dtStore.Columns.Add("UpdateID", GetType(Integer))
        If updateMandatoryDate.Year < 2000 Then
            updateMandatoryDate = New DateTime(1973, 1, 1)
        End If

            dtGroup.Rows.Add(groupID, groupTitle, name, statusID, threshold, updateMandatoryDate, updateID, isMandatory, build_no, isMinor, userID)

        For Each storeID As Integer In arrStoreID
            If (storeID <> 0) Then
                dtStore.Rows.Add(storeID, groupID, updateID)
            End If
        Next

        ds.Tables.Add(dtGroup)
        ds.Tables.Add(dtStore)

        rowsAffected = Portal.BLL.UpdateManagement.AddUpdateGroupStore(countryID, ds)
        If rowsAffected > 0 Then
            Return True
        Else
            Return False
        End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, ex.StackTrace, ex.Source, "AddUpdateGroupStores", String.Empty, String.Empty, String.Empty)
        End Try
    End Function
End Class