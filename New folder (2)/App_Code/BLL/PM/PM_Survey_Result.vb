Imports Microsoft.VisualBasic

Namespace Portal.BLL.PM
    Public Class PM_Survey_Result

        Private _Ticket_Feature_Id As Integer
        Private _ClientContactid As Integer
        Private _Answer1 As Boolean
        Private _Answer2 As Boolean
        Private _Answer3 As Boolean
        Private _Answer4 As Boolean
        Private _Answer5 As Short
        Private _Answer6 As String
        Private _Comments As String
        Private _Signature As String

        Public Property Ticket_Feature_id() As Integer
            Get
                Return _Ticket_Feature_Id
            End Get
            Set(ByVal value As Integer)
                _Ticket_Feature_Id = value
            End Set
        End Property

        Public Property ClientContactid() As Integer
            Get
                Return _ClientContactid
            End Get
            Set(ByVal value As Integer)
                _ClientContactid = value
            End Set
        End Property

        Public Property Answer1() As Boolean
            Get
                Return _Answer1
            End Get
            Set(ByVal value As Boolean)
                _Answer1 = value
            End Set
        End Property

        Public Property Answer2() As Boolean
            Get
                Return _Answer2
            End Get
            Set(ByVal value As Boolean)
                _Answer2 = value
            End Set
        End Property

        Public Property Answer3() As Boolean
            Get
                Return _Answer3
            End Get
            Set(ByVal value As Boolean)
                _Answer3 = value
            End Set
        End Property

        Public Property Answer4() As Boolean
            Get
                Return _Answer4
            End Get
            Set(ByVal value As Boolean)
                _Answer4 = value
            End Set
        End Property

        Public Property Answer5() As Short
            Get
                Return _Answer5
            End Get
            Set(ByVal value As Short)
                _Answer5 = value
            End Set
        End Property

        Public Property Answer6() As String
            Get
                Return _Answer6
            End Get
            Set(ByVal value As String)
                _Answer6 = value
            End Set
        End Property


        Public Property Comments() As String
            Get
                Return _Comments
            End Get
            Set(ByVal value As String)
                _Comments = value
            End Set
        End Property

        Public Property Signature() As String
            Get
                Return _Signature
            End Get
            Set(ByVal value As String)
                _Signature = value
            End Set
        End Property

    End Class
End Namespace

