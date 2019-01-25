Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports Microsoft.VisualBasic

Public Class DBAccess
   

#Region "Local Variables"
    Private cmd As IDbCommand = New SqlCommand()
    Private strConnectionString As String = ""
    Private handleErrors As Boolean = False
    Private strLastError As String = ""
    Private rdrResult As SqlDataReader
    Private rdrHasRows As Boolean = False

#End Region

#Region "Constructors"

    Public Sub New()
        Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
        strConnectionString = objConnectionStringSettings.ConnectionString
        Dim cnn As New SqlConnection()
        cnn.ConnectionString = strConnectionString
        cmd.Connection = cnn
        cmd.CommandType = CommandType.StoredProcedure
    End Sub

    Public Sub New(ByVal ConnectionStringFransupport As String)
        strConnectionString = ConnectionStringFransupport
        Dim cnn As New SqlConnection()
        cnn.ConnectionString = strConnectionString
        cmd.Connection = cnn
        cmd.CommandType = CommandType.StoredProcedure
    End Sub

    Public Sub New(ByVal cmdType As CommandType)
        Me.New()
        cmd.CommandType = cmdType
    End Sub
#End Region

#Region "Public Properties"


    Public Property CommandText() As String
        Get
            Return cmd.CommandText
        End Get
        Set(ByVal value As String)
            cmd.CommandText = value
            cmd.Parameters.Clear()
        End Set
    End Property

    Public ReadOnly Property Parameters() As IDataParameterCollection
        Get
            Return cmd.Parameters
        End Get
    End Property

    Public Property ConnectionString() As String
        Get
            Return strConnectionString
        End Get
        Set(ByVal value As String)
            strConnectionString = value
        End Set
    End Property

    Public Property HandleExceptions() As Boolean
        Get
            Return handleErrors
        End Get
        Set(ByVal value As Boolean)
            handleErrors = value
        End Set
    End Property

    Public ReadOnly Property LastError() As String
        Get
            Return strLastError
        End Get
    End Property

#End Region

#Region "Public Functions"

#Region "ExecuteReader"

    Public Function ExecuteReader() As IDataReader
        Dim reader As IDataReader = Nothing
        Try
            Me.Open()
            reader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Catch ex As Exception
            If handleErrors Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return reader
    End Function
#End Region

#Region "ExecuteReader"
    Public Function ExecuteReader(ByVal commandtext As String) As IDataReader
        Dim reader As IDataReader = Nothing
        Try
            cmd.CommandText = commandtext
            reader = Me.ExecuteReader()
        Catch ex As Exception
            If (handleErrors) Then
                strLastError = ex.Message
            Else
                Throw
            End If

        End Try
        Return reader
    End Function
#End Region

#Region "ExecuteSingleRecordReader"

    Public Function ExecuteDynamicQuery(ByVal commandtext As String) As Integer
        Dim i As Integer = -1
        Try
            cmd.CommandType = CommandType.Text
            cmd.CommandText = commandtext
            i = Me.ExecuteNonQuery()
        Catch ex As Exception
            If handleErrors Then
                strLastError = ex.Message
            Else
                Throw ex
            End If
        End Try
        Return i
    End Function

    Public Function ExecuteSingleRecordReader(ByVal commandtext As String) As Boolean
        Try
            cmd.CommandText = commandtext
            If rdrResult IsNot Nothing AndAlso rdrResult.IsClosed = False Then
                rdrResult.Close()
            End If
            rdrResult = Me.ExecuteReader()
        Catch ex As Exception
            If (handleErrors) Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        rdrHasRows = rdrResult.Read
        Return rdrHasRows
    End Function
#End Region

#Region "ExecuteScalar"

    Public Function ExecuteScalar() As Object
        Dim obj As Object = Nothing
        Try
            Me.Open()
            obj = cmd.ExecuteScalar()
            Me.Close()
        Catch ex As Exception
            If handleErrors Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return obj
    End Function

#End Region

#Region "ExecuteScalar"

    Public Function ExecuteScalar(ByVal commandtext As String) As Object
        Dim obj As Object = Nothing
        Try
            cmd.CommandText = commandtext
            obj = Me.ExecuteScalar()
        Catch ex As Exception
            If (handleErrors) Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return obj
    End Function
#End Region

#Region "ExecuteNonQuery"

    Public Function ExecuteNonQuery() As Integer
        Dim i As Integer = -1
        Try
            Me.Open()
            i = cmd.ExecuteNonQuery()
            Me.Close()
        Catch ex As Exception
            If handleErrors Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return i
    End Function
#End Region

#Region "ExecuteNonQuery"

    Public Function ExecuteNonQuery(ByVal commandtext As String) As Integer
        Dim i As Integer = -1
        Try
            cmd.CommandText = commandtext
            i = Me.ExecuteNonQuery()
        Catch ex As Exception
            If handleErrors Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return i
    End Function

#End Region

#Region "ExecuteDataSet"


    Public Function ExecuteDataSet() As DataSet
        Dim da As SqlDataAdapter = Nothing
        Dim ds As DataSet = Nothing
        Try
            da = New SqlDataAdapter()
            da.SelectCommand = CType(cmd, SqlCommand)
            ds = New DataSet()
            da.Fill(ds)
        Catch ex As Exception
            If (handleErrors) Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return ds
    End Function

#End Region

#Region "ExecuteDataSet"

    Public Function ExecuteDataSet(ByVal commandtext As String) As DataSet
        Dim ds As DataSet = Nothing
        Try
            cmd.CommandText = commandtext
            ds = Me.ExecuteDataSet()
        Catch ex As Exception
            If handleErrors Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return ds
    End Function
#End Region

#Region "ExecuteDataTable"

    Public Function ExecuteDataTable() As DataTable
        Dim da As SqlDataAdapter = Nothing
        Dim dt As DataTable = Nothing
        Try
            da = New SqlDataAdapter()
            da.SelectCommand = CType(cmd, SqlCommand)
            dt = New DataTable()
            da.Fill(dt)
        Catch ex As Exception
            If (handleErrors) Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return dt
    End Function

#End Region

#Region "ExecuteDataTable"

    Public Function ExecuteDataTable(ByVal commandtext As String) As DataTable
        Dim dt As DataTable = Nothing
        Try
            cmd.CommandText = commandtext
            dt = Me.ExecuteDataTable()
        Catch ex As Exception
            If handleErrors Then
                strLastError = ex.Message
            Else
                Throw
            End If
        End Try
        Return dt
    End Function
#End Region

#End Region

#Region "Public Subs"

#Region "AddParameter"

    Public Sub AddParameter(ByVal paramname As String, ByVal paramdirection As ParameterDirection)
        Dim param As SqlParameter = New SqlParameter
        param.ParameterName = paramname
        param.Direction = paramdirection
        cmd.Parameters.Add(param)
    End Sub
#End Region

#Region "AddParameter"

    Public Sub AddParameter(ByVal paramname As String, ByVal paramvalue As Object)
        Dim param As SqlParameter = New SqlParameter(paramname, paramvalue)
        cmd.Parameters.Add(param)
    End Sub
#End Region

#Region "AddParameter"

    Public Sub AddParameter(ByVal param As IDataParameter)
        cmd.Parameters.Add(param)
    End Sub

#End Region

#Region "AddParameter"
    Public Sub AddParameter(ByVal paramId As String, _
                                ByVal sqlType As SqlDbType, _
                                ByVal paramSize As Integer, _
                                ByVal paramDirection As ParameterDirection, _
                                ByVal paramvalue As Object)

        If paramId = String.Empty Then
            Throw New ArgumentOutOfRangeException("paramId")
        End If

        Dim newSqlParam As SqlParameter = New SqlParameter()
        newSqlParam.ParameterName = paramId
        newSqlParam.SqlDbType = sqlType
        newSqlParam.Direction = paramDirection

        If paramSize > 0 Then
            newSqlParam.Size = paramSize
        End If

        If Not paramvalue Is Nothing Then
            newSqlParam.Value = paramvalue
        End If

        cmd.Parameters.Add(newSqlParam)

    End Sub
#End Region

#Region "GetOrdinal"
    Public Function GetOrdinal(ByVal ordinalName As String) As Object
        If rdrHasRows Then
            Return rdrResult(ordinalName)
        Else
            Return DBNull.Value
        End If
    End Function
    Public Function GetOrdinal(ByVal ordinalName As String, ByVal ReplaceNullWithEmptyString As Boolean) As Object
        Dim rValue As Object = IIf(ReplaceNullWithEmptyString, String.Empty, DBNull.Value)
        If rdrHasRows Then
            Return IIf(rdrResult(ordinalName) Is DBNull.Value, rValue, rdrResult(ordinalName))
        Else
            Return rValue
        End If
    End Function
#End Region

#Region "Open"

    Private Sub Open()
        cmd.Connection.Open()
    End Sub

#End Region

#Region "Close"
    Private Sub Close()
        cmd.Connection.Close()
    End Sub
#End Region

#Region "Dispose"

    Public Sub Dispose()
        cmd.Dispose()
        If rdrResult IsNot Nothing Then
            If rdrResult.IsClosed = False Then
                rdrResult.Close()
            End If
        End If
    End Sub

#End Region


#End Region

End Class