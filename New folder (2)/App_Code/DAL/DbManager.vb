Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient

Public NotInheritable Class DbManager
#Region "Members"
    Private command As SqlCommand
    Private _selectCommand As SqlCommand
    Private commandAdapter As SqlDataAdapter
    Private commandParameter As SqlParameter
    Private commandTransaction As SqlTransaction
    Private connnectionString As String = String.Empty
    Private dsResults As DataSet
    Private commandBuilder As SqlCommandBuilder
#End Region

#Region "Properties"

    Public ReadOnly Property Parameters() As SqlParameterCollection
        Get
            Return Me.command.Parameters
        End Get
    End Property

    Public Property SelectCommand() As SqlCommand
        Get
            Return Me._selectCommand
        End Get
        Set(ByVal value As SqlCommand)
            Me._selectCommand = value
        End Set
    End Property

#End Region

#Region "Constructors"

    Public Sub New()
        Me.command = New Sqlcommand()
        Me.command.CommandType = CommandType.StoredProcedure

        Me.SelectCommand = New SqlCommand()
        Me.SelectCommand.CommandType = CommandType.StoredProcedure
    End Sub
    Public Sub New(ByVal otherConnectionString As String)
        Me.connnectionString = otherConnectionString
        Me.command = New SqlCommand()
        Me.command.CommandType = CommandType.StoredProcedure
    End Sub
#End Region

#Region "Public Functions"

    Public Function ExecuteScalar(ByVal commandText As String) As Object
        Dim returnValue As Object = Nothing
        Me.command.commandText = commandText
        Try
            OpenConnection()
            returnValue = Me.command.ExecuteScalar()
        Catch ex As Exception
            Throw ex
        Finally
            CloseConnection()
        End Try
        Return returnValue
    End Function

    Public Function ExecuteNonQuery(ByVal commandText As String) As Integer
        Dim returnValue As Integer
        Me.command.commandText = commandText
        Try
            OpenConnection()
            returnValue = Me.command.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            CloseConnection()
        End Try
        Return returnValue
    End Function

    Public Function ExecuteReader(ByVal commandText As String) As SqlDataReader
        Me.command.commandText = commandText
        Try
            OpenConnection()
            Return Me.command.ExecuteReader(commandBehavior.Default Or commandBehavior.CloseConnection)
        Catch ex As Exception
            CloseConnection()
            Throw ex
        End Try
    End Function

    Public Function ExecuteSingleRowReader(ByVal commandText As String) As SqlDataReader
        Me.command.commandText = commandText
        Try
            OpenConnection()
            Return Me.command.ExecuteReader(commandBehavior.SingleRow Or commandBehavior.CloseConnection)
        Catch ex As Exception
            CloseConnection()
            Throw ex
        End Try
    End Function

    Public Function ExecuteDataTable(ByVal commandText As String) As DataTable
        Dim dtResults As New DataTable()
        Me.commandAdapter = New SqlDataAdapter()
        Me.command.commandText = commandText
        Me.commandAdapter.Selectcommand = Me.command
        Try
            OpenConnection()
            Me.commandAdapter.Fill(dtResults)
        Catch ex As Exception
            Throw ex
        Finally
            CloseConnection()
        End Try
        Return dtResults
    End Function

    Public Function ExecuteDataSet(ByVal commandText As String) As DataSet
        Me.dsResults = New DataSet()
        Me.commandAdapter = New SqlDataAdapter()
        Me.command.commandText = commandText
        Me.commandAdapter.Selectcommand = Me.command
        Try
            OpenConnection()
            Me.commandAdapter.Fill(dsResults)
        Catch ex As Exception
            Throw ex
        Finally
            CloseConnection()
        End Try
        Return dsResults
    End Function

    Public Function InsertDataTable(ByVal commandText As String, ByVal dtRecords As DataTable) As Integer        
        Me.commandAdapter = New SqlDataAdapter()
        Me.command.CommandText = commandText
        Me.commandAdapter.InsertCommand = Me.command
        Try
            OpenConnection()
            Me.commandAdapter.Update(dtRecords)
        Catch ex As Exception
            Throw ex
        Finally
            CloseConnection()
        End Try
    End Function

    Public Function UpdateDataTable(ByVal dtRecords As DataTable) As Integer
        Try
            OpenConnection()

            'Intializing the select command
            Me.SelectCommand.Connection = Me.command.Connection
            Me.SelectCommand.Transaction = Me.command.Transaction
            Me.commandAdapter = New SqlDataAdapter(Me.SelectCommand)

            'Intializing the command builder object for update
            Me.commandBuilder = New SqlCommandBuilder(Me.commandAdapter)            
            Me.commandAdapter.Update(dtRecords)
        Catch ex As Exception
            Throw ex
        Finally
            CloseConnection()
        End Try
    End Function


    Public Function UpdateDataTable(ByVal commandText As String, ByVal dtRecords As DataTable) As Integer
        Dim affectedRows As Integer
        Me.command.CommandText = commandText
        Me.commandAdapter = New SqlDataAdapter()        
        Me.commandAdapter.UpdateCommand = Me.command
        Me.commandAdapter.InsertCommand = Me.command
        Try
            OpenConnection()
            affectedRows = Me.commandAdapter.Update(dtRecords)
        Catch ex As Exception
            Throw ex
        Finally
            CloseConnection()
        End Try
        Return affectedRows
    End Function

    Public Function UpdateDataTable(ByVal dt As DataTable, ByVal insertCmdText As String, ByVal updateCmdText As String, Optional ByVal cmdType As CommandType = Data.CommandType.StoredProcedure) As Integer
        Dim rowsAffected As Integer
        Me.commandAdapter = New SqlDataAdapter(Me.command)
        Me.commandAdapter.UpdateBatchSize = 20

        If Not String.IsNullOrEmpty(insertCmdText) Then
            Me.command.CommandText = insertCmdText
            Me.command.CommandType = cmdType
            Me.commandAdapter.InsertCommand = Me.command
            If Me.commandAdapter.UpdateBatchSize <> 1 Then Me.commandAdapter.InsertCommand.UpdatedRowSource = UpdateRowSource.None
        End If
        If Not String.IsNullOrEmpty(updateCmdText) Then
            Me.command.CommandText = updateCmdText
            Me.command.CommandType = cmdType
            Me.commandAdapter.UpdateCommand = Me.command
            If Me.commandAdapter.UpdateBatchSize <> 1 Then Me.commandAdapter.UpdateCommand.UpdatedRowSource = UpdateRowSource.None
        End If

        If String.IsNullOrEmpty(updateCmdText) And String.IsNullOrEmpty(insertCmdText) Then
            Me.commandBuilder = New SqlClient.SqlCommandBuilder(Me.commandAdapter)
            Me.commandAdapter.UpdateCommand = commandBuilder.GetUpdateCommand
            Me.commandAdapter.InsertCommand = commandBuilder.GetInsertCommand
        End If

        OpenConnection()
        rowsAffected = Me.commandAdapter.Update(dt)

        CloseConnection()
        Return rowsAffected
    End Function

    Public Sub AddParameter(ByVal parameterName As String, ByVal parameterValue As Object)
        Me.command.Parameters.AddWithValue(parameterName, parameterValue)
    End Sub

    Public Sub AddParameter(ByVal parameterName As String, ByVal parameterValue As Object, ByVal parameterType As SqlDbType, ByVal size As Integer)
        Me.command.Parameters.Add(parameterName, parameterType, size).Value = parameterValue
    End Sub

    Public Sub AddParameter(ByVal parameterName As String, ByVal parameterValue As Object, ByVal parameterType As SqlDbType, ByVal size As Integer, ByVal sourceColumn As String)
        Me.command.Parameters.Add(parameterName, parameterType, size, sourceColumn).Value = parameterValue
    End Sub

    Public Sub AddParameter(ByVal parameterName As String, ByVal parameterValue As Object, ByVal parameterType As SqlDbType, ByVal size As Integer, ByVal parameterDirection As ParameterDirection)
        Dim param As New SqlParameter(parameterName, parameterType, size)
        param.Direction = parameterDirection
        param.Value = parameterValue
        Me.command.Parameters.Add(param)
    End Sub

    Public Sub AddParameter(ByVal parameterName As String, ByVal parameterType As SqlDbType, ByVal size As Integer, ByVal sourceColumn As String)        
        Me.command.Parameters.Add(New SqlParameter(parameterName, parameterType, size, sourceColumn))
    End Sub

    Public Sub BeginTransaction()
        Try
            OpenConnection()
            Me.command.Transaction = Me.command.Connection.BeginTransaction()
        Catch ex As Exception
            RollBackTransaction()
            Throw ex
        End Try
    End Sub

    Public Sub RollBackTransaction()
        Try
            Me.command.Transaction.Rollback()
        Catch ex As Exception            
            Throw ex
        Finally
            Me.CloseConnection()
        End Try
    End Sub

    Public Sub CommitTransaction()
        Me.command.Transaction.Commit()
        Me.CloseConnection()
    End Sub

    Public Sub OpenConnection()
        If (Me.command.Connection Is Nothing) Then
            Me.command.Connection = Me.EstablishConnection()
        End If
        If Me.command.Connection.State = ConnectionState.Closed Then
            Me.command.Connection.Open()
        End If
    End Sub

    Public Sub CloseConnection()
        If Me.command.Connection.State <> ConnectionState.Closed Then
            If (Me.command.Transaction Is Nothing) Then
                Me.command.Connection.Close()
            End If
        End If
    End Sub

    Public Sub Dispose()
        GC.SuppressFinalize(Me)
        If Me.command.Connection.State <> ConnectionState.Closed Then
            Me.command.Connection.Close()
        End If
        Me.Command = Nothing
        Me.commandAdapter = Nothing
    End Sub

#End Region

#Region "Private Functions"

    Private Function EstablishConnection() As SqlConnection
        Dim connBMS As New SqlConnection
        If (String.IsNullOrEmpty(Me.connnectionString)) Then
            connBMS.ConnectionString = ConfigurationManager.ConnectionStrings("PortalConnectionString").ConnectionString
        Else
            connBMS.ConnectionString = ConfigurationManager.ConnectionStrings(connnectionString).ConnectionString
        End If
        Return connBMS
    End Function


#End Region

End Class
