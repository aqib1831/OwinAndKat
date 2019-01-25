Imports Microsoft.VisualBasic
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient

Public Class ActivityTopic
#Region " Private Members "
    Private _ID As Integer
    Private _Topic As String
#End Region

#Region " Public Properties "

    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal value As Integer)
            _ID = value
        End Set
    End Property
    Public Property Topic() As String
        Get
            Return _Topic
        End Get
        Set(ByVal value As String)
            _Topic = value
        End Set
    End Property
#End Region

#Region " Constructor "
    Public Sub New(ByVal ID As Integer, ByVal Topic As String)
        Me.ID = ID
        Me.Topic = Topic
    End Sub
    Public Sub New()
    End Sub
#End Region

#Region " Public Method "
    Public Shared Function GetTopics(ByVal Topic As String, ByVal sortExpression As String) As DataSet
        Dim col_Topics As New List(Of ActivityTopic)()
        Dim ds_Topics As DataSet
        Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
        Dim db As DBAccess = New DBAccess(objConnectionStringSettings.ConnectionString)
        If sortExpression = "" Then
            db.AddParameter("@sortExpression", DBNull.Value)
        Else
            db.AddParameter("@sortExpression", sortExpression)
        End If
        If Topic Is Nothing Then
            db.AddParameter("@Topic", DBNull.Value)
        Else
            db.AddParameter("@Topic", Topic)
        End If
        ds_Topics = db.ExecuteDataSet("Activities_GetTopics_ByTitle")
        Return ds_Topics
    End Function
    Public Function Add() As Integer
        Dim result As Integer = 0
        Dim db As New DBAccess
        Dim ID As Integer = 0
        Dim returnValue As Integer = 0
        db.AddParameter("@Topic", Me.Topic)
        db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, -1)
        db.ExecuteNonQuery("Activities_Add_Topic")
        ID = CInt(db.Parameters("@ID").Value)        
        Return ID
    End Function
    Public Function Update(ByVal ID As Integer, ByVal Topic As String) As Integer
        Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
        Dim result As Integer = 0
        Dim db As New DBAccess(objConnectionStringSettings.ConnectionString)
        db.AddParameter("@ID", ID)
        db.AddParameter("@Topic", Topic)
        result = db.ExecuteNonQuery("Activities_Update_Topic")
        Return result
    End Function
    Public Function Update() As Integer
        Dim objConnectionStringSettings As ConnectionStringSettings = ConfigurationManager.ConnectionStrings("PortalConnectionString")
        Dim ID As Integer = 0
        Dim db As New DBAccess(objConnectionStringSettings.ConnectionString)
        db.AddParameter("@ID", Me.ID)
        db.AddParameter("@Topic", Me.Topic)
        db.AddParameter("@returnValue", SqlDbType.Int, 4, ParameterDirection.Output, -1)
        db.ExecuteNonQuery("Activities_Update_Topic")
        ID = CInt(db.Parameters("@returnValue").Value)
        Return ID
    End Function
    Public Shared Function GetTopicByID(ByVal TopicID As Integer) As SqlDataReader
        Dim col_Topics As New List(Of ActivityTopic)()
        '   Dim ds_Topics As DataSet
        Dim dr_Topics As SqlDataReader
        Dim db As New DBAccess
        If TopicID = 0 Then
            db.AddParameter("@TopicID", DBNull.Value)
        Else
            db.AddParameter("@TopicID", TopicID)
        End If
        dr_Topics = db.ExecuteReader("Activities_GetTopic_ByID")
        Return dr_Topics
    End Function
    Public Shared Function com_Activities_Topic_GetTopicIDByUserID(ByVal UserID As Integer) As Integer
        Dim dr As SqlDataReader
        Dim db As New DBAccess
        Dim TopicID As Integer = 0
        db.AddParameter("@UserID", UserID)
        dr = db.ExecuteReader("com_Activities_Topic_GetByUserID")
        If dr.HasRows Then
            While dr.Read()
                TopicID = CType(dr("TopicID"), Integer)
            End While
        End If
        dr.Close()
        Return TopicID
    End Function
#End Region
End Class
