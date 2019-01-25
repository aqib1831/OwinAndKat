Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient


Public Class Firm
#Region "Protected Variable"
#Region "Firm Variables"
    Protected _ID As Integer
    Protected _Name As String
    Protected _Title As String
    Protected _Address As String
    Protected _Phone As String
    Protected _Country As Integer
    Protected _State As Integer
    Protected _City As String
    Protected _ZipCode As String
    Protected _Fax As String
    Protected _Type As Integer
    Protected _Website As String
    Protected _retVal As Integer
#End Region

#Region "Contacts Variable"
    Protected _ContactID As Integer
    Protected _ContactName As String
    Protected _ContactTitle As String
    Protected _ContactDepartment As String = ""
    Protected _ContactPhone As String
    Protected _ContactFax As String = ""
    Protected _ContactEmail As String = ""
    Protected _IsPrimary As Boolean
#End Region

#End Region

#Region "Public Properties"
#Region "Firm"

    Public Property ID() As Integer
        Get
            Return _ID
        End Get
        Set(ByVal value As Integer)
            _ID = value
        End Set
    End Property

    Public Property Name() As String
        Get
            Return _Name
        End Get
        Set(ByVal value As String)
            _Name = value
        End Set
    End Property

    Public Property Title() As String
        Get
            Return _Title
        End Get
        Set(ByVal value As String)
            _Title = value
        End Set
    End Property

    Public Property Address() As String
        Get
            Return _Address
        End Get
        Set(ByVal value As String)
            _Address = value
        End Set
    End Property

    Public Property Phone() As String
        Get
            Return _Phone
        End Get
        Set(ByVal value As String)
            _Phone = value
        End Set
    End Property

    Public Property Country() As Integer
        Get
            Return _Country
        End Get
        Set(ByVal value As Integer)
            _Country = value
        End Set
    End Property

    Public Property State() As Integer
        Get
            Return _State
        End Get
        Set(ByVal value As Integer)
            _State = value
        End Set
    End Property

    Public Property City() As String
        Get
            Return _City
        End Get
        Set(ByVal value As String)
            _City = value
        End Set
    End Property

    Public Property ZipCode() As String
        Get
            Return _ZipCode
        End Get
        Set(ByVal value As String)
            _ZipCode = value
        End Set
    End Property

    Public Property Fax() As String
        Get
            Return _Fax
        End Get
        Set(ByVal value As String)
            _Fax = value
        End Set
    End Property

    Public Property Type() As Integer
        Get
            Return _Type
        End Get
        Set(ByVal value As Integer)
            _Type = value
        End Set
    End Property

    Public Property Website() As String
        Get
            Return _Website
        End Get
        Set(ByVal value As String)
            _Website = value
        End Set
    End Property
    Public Property RetValue() As Integer
        Get
            Return _retVal
        End Get
        Set(ByVal value As Integer)
            _retVal = value
        End Set
    End Property
#End Region

#Region "Contact"
    Public Property ContactID() As Integer
        Get
            Return _ContactID
        End Get
        Set(ByVal value As Integer)
            _ContactID = value
        End Set
    End Property

    Public Property ContactName() As String
        Get
            Return _ContactName
        End Get
        Set(ByVal value As String)
            _ContactName = value
        End Set
    End Property

    Public Property ContactTitle() As String
        Get
            Return _ContactTitle
        End Get
        Set(ByVal value As String)
            _ContactTitle = value
        End Set
    End Property

    Public Property Department() As String
        Get
            Return _ContactDepartment
        End Get
        Set(ByVal value As String)
            _ContactDepartment = value
        End Set
    End Property

    Public Property ContactPhone() As String
        Get
            Return _ContactPhone
        End Get
        Set(ByVal value As String)
            _ContactPhone = value
        End Set
    End Property

    Public Property ContactFax() As String
        Get
            Return _ContactFax
        End Get
        Set(ByVal value As String)
            _ContactFax = value
        End Set
    End Property

    Public Property ContactEmail() As String
        Get
            Return _ContactEmail
        End Get
        Set(ByVal value As String)
            _ContactEmail = value
        End Set
    End Property

    Public Property IsPrimary() As Boolean
        Get
            Return _IsPrimary
        End Get
        Set(ByVal value As Boolean)
            _IsPrimary = value
        End Set
    End Property

#End Region

#End Region

#Region "Sub/Functions"
    Public Function AddNewFirm() As Integer

        Dim db As DBAccess = New DBAccess
        db.AddParameter("@Value", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.AddParameter("@Name", _Name)
        'db.AddParameter("@Title", _Title)
        db.AddParameter("@Address", _Address)
        db.AddParameter("@Phone", _Phone)
        db.AddParameter("@State", _State)
        db.AddParameter("@Country", _Country)
        db.AddParameter("@City", _City)
        db.AddParameter("@Zip", _ZipCode)
        db.AddParameter("@Fax", _Fax)
        db.AddParameter("@Type", _Type)
        db.AddParameter("@Website", _Website)
        db.ExecuteNonQuery("Legal_Firm_Add")
        Me.ID = CInt(CType(db.Parameters("@Value"), System.Data.SqlClient.SqlParameter).Value)
        Return Me.ID
    End Function

    Public Function GetAllFirms(ByVal SortExpression As String, Optional ByVal Search As String = "") As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", DBNull.Value)
        If Search = "" Then
            db.AddParameter("@Search", DBNull.Value)
        Else
            db.AddParameter("@Search", Search)
        End If
        db.AddParameter("@SortExpression", SortExpression)
        Return CType(db.ExecuteReader("Legal_GetAllFirms"), SqlDataReader)

    End Function
    Public Function DeleteFirm(ByVal ID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@FirmID", ID)
        Return db.ExecuteNonQuery("Legal_DeleteFirm")
    End Function

    Public Function GetSingleFirm(ByVal FirmID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@FirmID", FirmID)
        Return CType(db.ExecuteReader("Legal_GetSingleFirm"), SqlDataReader)
    End Function
    Public Function UpdateFirm() As Integer

        Dim db As DBAccess = New DBAccess
        db.AddParameter("@ID", _ID)
        db.AddParameter("@Name", _Name)
        db.AddParameter("@Type", _Type)
        db.AddParameter("@Address", _Address)
        db.AddParameter("@Phone", _Phone)
        db.AddParameter("@State", _State)
        db.AddParameter("@Country", _Country)
        db.AddParameter("@City", _City)
        db.AddParameter("@Zip", _ZipCode)
        db.AddParameter("@Fax", _Fax)
        db.AddParameter("@WebSite", _Website)
        db.AddParameter("@retVal", SqlDbType.Int, 4, ParameterDirection.Output, Me.RetValue)
        db.ExecuteNonQuery("Legal_UpdateFirm")
        ID = (CInt(CType(db.Parameters("@retVal"), System.Data.SqlClient.SqlParameter).Value))
    End Function

    Public Function UpdateFirm(ByVal ID As Integer, ByVal Name As String, ByVal Address As String, _
                                ByVal City As String, ByVal State As Integer, ByVal Country As Integer, _
                                ByVal StateID As Integer, ByVal Type As Integer, _
                                ByVal TypeID As Integer, ByVal Phone As String, Optional ByVal Fax As String = "", _
                                Optional ByVal Zip As String = "", Optional ByVal Website As String = "" _
                                 , Optional ByVal retVal As Integer = 0) As Integer
        Dim db As DBAccess = New DBAccess
        db.AddParameter("@ID", ID)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Address", Address)
        db.AddParameter("@City", City)
        db.AddParameter("@State", State)
        db.AddParameter("@Country", Country)
        db.AddParameter("@Type", TypeID)
        db.AddParameter("@Phone", Phone)
        db.AddParameter("@Fax", Fax)
        db.AddParameter("@Zip", Zip)
        db.AddParameter("@WebSite", Website)
        db.AddParameter("@retVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateFirm")
        Return (CInt(CType(db.Parameters("@retVal"), System.Data.SqlClient.SqlParameter).Value))
    End Function
    Public Function AddFirmContact() As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, _ContactName)
        db.AddParameter("@Name", _ContactName)
        db.AddParameter("@Title", _ContactTitle)
        db.AddParameter("@Department", _ContactDepartment)
        db.AddParameter("@Phone", _ContactPhone)
        db.AddParameter("@Fax", _ContactFax)
        db.AddParameter("@Email", _ContactEmail)
        db.AddParameter("@FirmID", _ID)
        db.AddParameter("@IsPrimary", _IsPrimary)

        db.ExecuteNonQuery("Legal_AddFirmContact")
        Return (CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value))
    End Function
    Public Function AddFirmContact(ByVal Name As String, ByVal Department As String, ByVal Title As String, ByVal Phone As String, ByVal Fax As String, ByVal Email As String, ByVal FirmID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, _ContactName)
        db.AddParameter("@Name", Name)
        db.AddParameter("@Title", Title)
        db.AddParameter("@Department", Department)
        db.AddParameter("@Phone", Phone)
        db.AddParameter("@Fax", Fax)
        db.AddParameter("@Email", Email)
        db.AddParameter("@FirmID", FirmID)
        db.AddParameter("@IsPrimary", 0)
        Return db.ExecuteNonQuery("Legal_AddFirmContact")
    End Function
    Public Function UpdateFirmContact(ByVal ID As Integer, ByVal Name As String, ByVal Department As String, ByVal Title As String, ByVal Phone As String, ByVal Fax As String, ByVal Email As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@Title", Title)
        db.AddParameter("@Department", Department)
        db.AddParameter("@Phone", Phone)
        db.AddParameter("@Fax", Fax)
        db.AddParameter("@Email", Email)
        db.AddParameter("@FirmContactID", ID)
        Return db.ExecuteNonQuery("Legal_UpdateFirmContact")
    End Function
    Public Function DeleteContact(ByVal ContactID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@ContactID", ContactID)
        Return db.ExecuteNonQuery("Legal_DeleteContact")
    End Function
    Public Function GetContactsByFirmID(ByVal FirmID As Integer) As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@FirmID", FirmID)
        Return CType(db.ExecuteReader("Legal_GetContactsByFirmID"), SqlDataReader)
    End Function

    Public Function GetAllFirmTypes() As SqlDataReader
        Dim db As DBAccess = New DBAccess()
        Return db.ExecuteReader("Legal_GetAllFirmTypes")
    End Function
    Public Shared Function AddFirmType(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        Return db.ExecuteNonQuery("Legal_AddFirmType")
    End Function
    Public Function UpdateFirmType(ByVal Name As String, ByVal ID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@ID", ID)
        db.AddParameter("@Validate", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_UpdateFirmType")
        Return CInt(CType(db.Parameters("@Validate"), System.Data.SqlClient.SqlParameter).Value)
    End Function
    Public Function DeleteFirmType(ByVal ID As Integer) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("ID", ID)
        db.ExecuteNonQuery("Legal_DeleteFirmType")

    End Function

    Public Shared Function TrimValue(ByVal Obj As Object) As String
        If Not Obj Is DBNull.Value Then
            If Obj.ToString().Length > 20 Then
                Return Obj.ToString().Substring(0, 20) & "..."
            Else
                Return Obj.ToString()
            End If
            Return "&nbsp;"
        End If
        Return "&nbsp;"
    End Function
    Public Shared Function GetFirmIDByName(ByVal Name As String) As Integer
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@Name", Name)
        db.AddParameter("@ID", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteNonQuery("Legal_FetFirmIDByName")
        Return CInt(CType(db.Parameters("@ID"), System.Data.SqlClient.SqlParameter).Value)
    End Function
#End Region

#Region "Vendor Management"
    Public Shared Function GetVitalInfoByID(ByVal VendorID As Integer) As SqlDataReader
        Dim dr_vitalInfo As SqlDataReader = Nothing
        Dim db As New DBAccess
        db.AddParameter("@VendorID", VendorID)
        dr_vitalInfo = db.ExecuteReader("Vendor_Legal_GetVitalInfo")
        Return dr_vitalInfo
    End Function
#End Region
End Class
