Partial Class HR_HRNewLeftPanel
    Inherits System.Web.UI.UserControl
#Region " Private Members "

    Private _Selected As Integer = 0

#End Region

#Region " Public Properties "

    Public Property Selected() As Integer
        Get
            Return _Selected
        End Get
        Set(ByVal value As Integer)
            _Selected = value
        End Set
    End Property
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        hdnUserID.Value = Session("AdminID")
        hdnMainModuleID.Value = Portal.BLL.Enumeration.Modules.HumanResourceManagment
    End Sub

    Private Function CheckModuleAccess() As Boolean
        Dim returnVal As Boolean = False
        Dim strcsv As String = Session("UsersModulesID")
        If strcsv <> Nothing AndAlso strcsv <> String.Empty Then
            Dim srtArray As String() = strcsv.Split(",")
            If srtArray.Length > 0 Then
                For i As Integer = 0 To srtArray.Length - 1
                    If srtArray(i) = Portal.BLL.Enumeration.Modules.Administration Then
                        returnVal = True
                    End If
                Next
            End If
        End If
        Return returnVal
    End Function
    Private Function CheckSubModuleAccess() As Boolean
        Dim returnVal As Boolean = False
        Dim strcsv As String = Session("UsersSubModulesID")
        If strcsv <> Nothing AndAlso strcsv <> String.Empty Then
            Dim srtArray As String() = strcsv.Split(",")
            If srtArray.Length > 0 Then
                For i As Integer = 0 To srtArray.Length - 1
                    If srtArray(i) = Portal.BLL.Enumeration.SubModules.TimeHistory Then
                        returnVal = True
                    End If
                Next
            End If
        End If
        Return returnVal
    End Function
End Class
