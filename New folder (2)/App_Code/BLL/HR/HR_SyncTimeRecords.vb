Imports Microsoft.VisualBasic

Public Class HR_SyncTimeRecords
    Implements IDisposable

    Public Function SyncronizeTimeRecordsOnline(ByVal objHRUserTimeHistory As Portal.BLL.HR.HR_UserTimeHistory) As Integer
        Dim ReturnVal As Integer = False
        Try
            Dim ObjUserTimeRecord As New Portal.DAL.HR.DBHR_UserTimeHistory()
            If objHRUserTimeHistory.ID > 0 Then
                ReturnVal = ObjUserTimeRecord.Update(objHRUserTimeHistory)
                'Portal.DAL.HR.DBHR_UserTimeHistory.CalculateAnnualLeaves(objHRUserTimeHistory.ID, objHRUserTimeHistory.UserID)
            Else
                ReturnVal = ObjUserTimeRecord.Add(objHRUserTimeHistory)
                'Portal.DAL.HR.DBHR_UserTimeHistory.CalculateAnnualLeaves(ReturnVal, objHRUserTimeHistory.UserID)
            End If

        Catch ex As Exception

        End Try
        Return ReturnVal
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
