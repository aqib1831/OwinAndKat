Imports Microsoft.VisualBasic

Public Class Legal_Enumerations
    Public Enum LegalIPType
        TradeMark = 1
        Patent = 2
        CopyRight = 3
    End Enum
    Public Enum NoteType
        Call1 = 1
        Application = 2
        Letter = 3
        Fax = 4
        Meeting = 5
        Bill = 7
        Other = 6
    End Enum
    Public Enum LegalIPStatus
        Pending = 1
        Applied = 2
        Approved = 3
        Opposed = 4
    End Enum
    Public Enum ActivityState
        NotStarted = 1
        InProgress = 2
        Complete = 3
        WaitingFor = 4
    End Enum
    Public Enum CaseType
        Litigation = 1
        Arbitration = 2
        GeneralProceeding = 3
    End Enum
    Public Enum TimeSight
        Insight = True
        Outsight = False
    End Enum
    Public Enum Months
        Jan = 1
        Feb = 2
        Mar = 3
        Apr = 4
        May = 5
        Jun = 6
        Jul = 7
        Aug = 8
        Sep = 9
        Oct = 10
        Nov = 11
        Dec = 12
    End Enum
End Class
