Imports Microsoft.VisualBasic

Namespace Portal.BLL.HR
    Public Class TimeZones
        Implements IDisposable

        Private _TimeZoneID As Integer
        Private _TimeZoneName As String
        Private _GMTDiff As Integer
        Private _Deleted As Boolean

        Public Property TimeZoneID() As Integer
            Get
                Return _TimeZoneID
            End Get
            Set(ByVal value As Integer)
                _TimeZoneID = value
            End Set
        End Property

        Public Property GMTDiff() As Integer
            Get
                Return _GMTDiff
            End Get
            Set(ByVal value As Integer)
                _GMTDiff = value
            End Set
        End Property

        Public Property TimeZoneName() As String
            Get
                Return _TimeZoneName
            End Get
            Set(ByVal value As String)
                _TimeZoneName = value
            End Set
        End Property

        Public Property Deleted() As Boolean
            Get
                Return _Deleted
            End Get
            Set(ByVal value As Boolean)
                _Deleted = value
            End Set
        End Property

        Public Sub New()
            _TimeZoneID = 0
            _TimeZoneName = String.Empty
            _GMTDiff = 0
            _Deleted = False
        End Sub

        Public Shared Function TimeZoneGetByID(ByVal TimeZoneID As Integer) As Integer
            Return Portal.DAL.HR.DBTimeZones.TimeZoneGetByID(TimeZoneID)
        End Function


        Private disposedValue As Boolean = False        ' To detect redundant calls

        ' IDisposable
        Protected Overridable Sub Dispose(ByVal disposing As Boolean)
            If Not Me.disposedValue Then
                If disposing Then
                    ' TODO: free other state (managed objects).
                End If

                ' TODO: free your own state (unmanaged objects).
                ' TODO: set large fields to null.
            End If
            Me.disposedValue = True
        End Sub

#Region " IDisposable Support "
        ' This code added by Visual Basic to correctly implement the disposable pattern.
        Public Sub Dispose() Implements IDisposable.Dispose
            ' Do not change this code.  Put cleanup code in Dispose(ByVal disposing As Boolean) above.
            Dispose(True)
            GC.SuppressFinalize(Me)
        End Sub
#End Region

    End Class

End Namespace
