Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Data
Imports System.Web.HttpUtility
Imports System.Text
Imports System.IO
Imports System.IO.Compression
Imports System.Web.Script.Serialization
Imports System.Collections.Generic
Imports EnvDTE

<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class DigitalCatalog
    Inherits System.Web.Services.WebService
    Private Const EncKey = 17
    Private Const SaltChar = 143
#Region "WebMethods"
    <WebMethod()> _
    Public Function VerifyGUID(ByVal GUID As String) As String
        Try
            'GUID = ConvertFromBase64String(GUID)
            If (AuthenticateUser(GUID) > 0) Then
                Return "True"
            Else
                Return "False"
            End If
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, String.Empty, "DigitalCatalog", "VerifyGUID", String.Empty, String.Empty, String.Empty)
            Return ex.Message
        End Try

    End Function

    <WebMethod()> _
    Public Function GetAppSettings(ByVal CountryID As Integer) As String
        Try
            Return GetDCAppSettings(CountryID)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, String.Empty, "DigitalCatalog", "GetAppSettings", String.Empty, String.Empty, String.Empty)
            Return ex.Message
        End Try

    End Function
    <WebMethod()> _
    Public Function VerifyUser(ByVal GUID As String, ByVal SID As String) As String
        Try
            'SID = ConvertFromBase64String(SID)
            'GUID = ConvertFromBase64String(GUID)
            Return VerifyUser_P(GUID, SID)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, String.Empty, "DigitalCatalog", "VerifyUser", String.Empty, String.Empty, String.Empty)
            Return ex.Message
        End Try

    End Function
    <WebMethod()> _
    Public Function VerifySystemID(ByVal GUID As String, ByVal SID As String) As String
        Try
            'SID = ConvertFromBase64String(SID)
            'GUID = ConvertFromBase64String(GUID)
            Return VerifySystemID_P(GUID, SID)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, String.Empty, "DigitalCatalog", "VerifySystemID", String.Empty, String.Empty, String.Empty)
            Return ex.Message
        End Try

    End Function
    <WebMethod()> _
    Public Function SaveUserLog(ByVal GUID As String, ByVal SID As String, ByVal CurrentVersion As String, ByVal RegistrationDate As String, ByVal LastTimeSync As String) As String

        Try
            'ErrorLogger.AddError("Called", String.Empty, "DigitalCatalog", "SaveUserLog", String.Empty, String.Empty, String.Empty)
            'SID = ConvertFromBase64String(SID)
            'GUID = ConvertFromBase64String(GUID)
            Return SaveUserLog_P(GUID, SID, String.Empty, CurrentVersion, RegistrationDate, LastTimeSync, Nothing)
        Catch ex As Exception
            ErrorLogger.AddError(ex.Message, String.Empty, "DigitalCatalog", "SaveUserLog", String.Empty, String.Empty, String.Empty)
            Return ex.Message
        End Try

    End Function


    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="UserName"></param>
    ''' <param name="Password"></param>
    ''' <returns></returns>
    <WebMethod()> _
    Public Function ValidateUserNamePassword(ByVal UserName As String, ByVal Password As String ) As String  
        Dim proxy_FSDeliveryAppService As New FsDeliveryAppService.DeliveryAppService()
        Dim ds As DataSet = Nothing
        Dim data As Byte() = Nothing
        Dim RetVal As String = "False"
        data = proxy_FSDeliveryAppService.AuthenticateUser(DigitalFlipbookApp.EncryptString128Bit(UserName, DigitalFlipbookApp.EncryptionKey), DigitalFlipbookApp.EncryptString128Bit(Password, DigitalFlipbookApp.EncryptionKey))
        ds = DigitalFlipbookApp.DecompressData(data)
        Dim objReturn As StoreResponse =new StoreResponse()

        Dim ObjectStores As New List(Of Store)
        If (ds IsNOT Nothing AND ds.Tables.Count > 0 ) Then
            If ds.Tables(0).Rows.Count > 0

           
            For Each dRow As DataRow In ds.Tables(0).Rows
                    Dim store  As Store = new Store()

                        store.ID=dRow("ID")
                        store.StoreNumber = dRow("StoreNumber")
                        store.FULLStoreName = dRow("FULLStoreName")
                        store.CountryID=dRow("CountryID")
                    'store = New With
                    '    {
                    '    .Id=dRow("ID"),
                    '    .StoreNumber = dRow("StoreNumber"),
                    '    .StoreFullName = dRow("FULLStoreName"),
                    '    .CountryId=dRow("CountryID")
                    '   }
             
                ObjectStores.Add(store)
             
            Next
               ' objReturn =new Object()
        
                objReturn .Status=true 
                objReturn.ErorMessage=""
                objReturn.data=ObjectStores

               'objReturn=
               '     New With{
               '    .Status="True",
               '    .ErorMessage="",
               '    .data=ObjectStores
               ' }
         
                End If
            Else 
                objReturn .Status=false 
                objReturn.ErorMessage="Invalid Username/Password"
                'objReturn= New With{ 
                '               .Status="False",
                '               .ErorMessage="Invalid User/Password"
                '    }
              
        End If
        Dim jSerializer As New JavaScriptSerializer
        jSerializer.MaxJsonLength = Int32.MaxValue
        RetVal = jSerializer.Serialize(objReturn)
        Return RetVal
    End Function

    <WebMethod()> _
    Public Function GetLicenseKeyForStoreID(ByVal UserName As String, ByVal Password As String,ByVal MACAddress As String,ByVal StoreNumber As String) As String
           Dim LicenseKey As String = String.Empty
           Dim objReturn As Object =new StoreLicense()
        Try
            Dim proxy_FSDeliveryAppService As New FsDeliveryAppService.DeliveryAppService()
            'Dim proxy_FSDeliveryAppService As New FsDeliveryAppService.DeliveryAppServiceClient()
            Dim Authenticated As Boolean = true
            Dim NeedAuthenticated As Boolean = true
            Dim ds As DataSet
            If (NeedAuthenticated) Then
                Dim data As Byte()
                data = proxy_FSDeliveryAppService.AuthenticateUser(DigitalFlipbookApp.EncryptString128Bit(Username, DigitalFlipbookApp.EncryptionKey), DigitalFlipbookApp.EncryptString128Bit(Password, DigitalFlipbookApp.EncryptionKey))
                ds = DigitalFlipbookApp.DecompressData(data)

                'If (ds Is Nothing OrElse ds.Tables.Count = 0 OrElse ds.Tables(0).Rows.Count = 0) Then
                '    ds = ValidateStoreUsernamePassword(Username, Password)
                'End If

              If (ds IsNOT Nothing AND ds.Tables.Count > 0 ) Then
               If ds.Tables(0).Rows.Count > 0
                    For Each dRow As DataRow In ds.Tables(0).Rows
                       ' If (dRow("StoreNumber") = StoreNumber) Then
                            'CountryID = dRow("CountryID")
                            Authenticated = True
                            Exit For
                        'End If
                    Next
                End If
                
             
            Else
                objReturn .Status=false 
                objReturn.ErorMessage="Invalid Username/Password"
                'objReturn= New With{
                '    .Status="False",
                '    .ErorMessage="Invalid User/Password"
                '    }
                       Dim jj As New JavaScriptSerializer
                      jj.MaxJsonLength = Int32.MaxValue
                       Dim RetVal1 = jj.Serialize(objReturn)
                      Return RetVal1
            End If
       End If
            If (Authenticated) Then

                'Dim proxy_PortalService As New PortalService.SMSSoapClient()

                Dim StoreID As Integer
                'LicenseKey = New DeliveryApp().GetLicenseKeyBySystemIDStoreIDAndTerminalType(MACAddress, StoreNumber, StoreID, CountryID)
                LicenseKey=Portal.BLL.LicenseManagementDC.GetLicenseKeyBySystemIDStoreID(CType(StoreNumber,Integer),MACAddress,1)

                If (String.IsNullOrEmpty(LicenseKey) = False) Then
                    objReturn .Status=true 
                    objReturn.ErorMessage=""
                    objReturn.LicenseKey=LicenseKey
                       'objReturn= New With{
                       '          .Status="True",
                       '          .ErorMessage="",
                       '          .data= New With{
                       '          .LicenseKey=LicenseKey
                       '          }
                       '          }
                   'Return objReturn

                Else
                    Dim LicenseCount As Integer = 0
                    LicenseCount = Portal.BLL.LicenseManagementDC.GetStoreLicensesCount(StoreNumber,1)
                    If LicenseCount > 0 Then
                        Return 0
                        Exit Function
                    End If
                   Portal.BLL.LicenseManagementDC.AddDCLicenseTerminals(MACAddress,1,StoreNumber,"0000",98)
                   LicenseKey=Portal.BLL.LicenseManagementDC.GetLicenseKeyBySystemIDStoreID(CType(StoreNumber,Integer),MACAddress,1)
                    If Not String.IsNullOrEmpty(LicenseKey)
                        objReturn .Status=true 
                        objReturn.ErorMessage=""
                        objReturn.LicenseKey=LicenseKey
                        'objReturn= New With{
                        '    .Status="True",
                        '    .ErorMessage="",
                        '    .data= New With{
                        '                   .LicenseKey=LicenseKey
                        '                   }
                        '    }
                    Else 
                        objReturn .Status=false 
                        objReturn.ErorMessage="Invalid Username/Password"
                        'objReturn= New With{
                        '    .Status="False",
                        '    .ErorMessage="Invalid User/Password"
                        '    }
                        'Return objReturn
                    End If

                End If
                Else 
                    objReturn .Status=false 
                    objReturn.ErorMessage="Invalid Username/Password"
                    'objReturn= New With{
                    '    .Status="False",
                    '    .ErorMessage="Invalid User/Password"
                    '    }
                   ' Return objReturn
            End If
        Dim jSerializer As New JavaScriptSerializer
        jSerializer.MaxJsonLength = Int32.MaxValue
        Dim RetVal = jSerializer.Serialize(objReturn)
        Return RetVal
            'Return objReturn
        Catch ex As Exception
            'ErrorLog.Add(ex, "LicenseKey: " + LicenseKey.ToString() + ", Result: " + Result.ToString())
            'objReturn= New With{
            '    .Status="False",
            '    .ErorMessage="Invalid User/Password"
            '    }
            'Return objReturn
            Return DigitalFlipbookApp.JsonString("Error", "Error", "Error Processing Request.")
            Return "sdf"
        End Try
    End Function 
         
    '<WebMethod()> _
    'Public Function SaveUserLogWithSystemName(ByVal GUID As String, ByVal SystemID As String, ByVal CurrentVersion As String, ByVal RegistrationDate As String, ByVal LastTimeSync As String, ByVal SystemName As String) As String
    '    Try
    '        'SystemID = ConvertFromBase64String(SystemID)
    '        'GUID = ConvertFromBase64String(GUID)
    '        Return SaveUserLog_P(GUID, Encryption(SystemID), String.Empty, CurrentVersion, CDate(RegistrationDate), CDate(LastTimeSync), SystemName)
    '    Catch ex As Exception
    '        ErrorLogger.AddError(ex.Message, String.Empty, "DigitalCatalog", "SaveUserLogWithSystemName", String.Empty, String.Empty, String.Empty)
    '        Return ex.Message
    '    End Try
    'End Function
#End Region
#Region "Private Methods"
    Private Function ConvertFromBase64String(ByVal inStr As String) As String
        Dim DMessage As Byte() = Convert.FromBase64String(inStr)
        Return Encoding.UTF8.GetString(DMessage)
    End Function
    Private Function ConvertToBase64String(ByVal inStr As String) As String
        Dim byt As Byte() = System.Text.Encoding.UTF8.GetBytes(inStr)
        Return Convert.ToBase64String(byt)
    End Function
    Private Function AuthenticateUser(ByVal GUID As String) As Integer
        Dim returnVal As Integer = 0
        Dim db As New DBAccess()
        db.AddParameter("@GUID", GUID)
        db.AddParameter("@ClientID", Portal.BLL.Enumeration.ClientID.EA)
        db.AddParameter("@ReturnVal", SqlDbType.Int, 4, ParameterDirection.Output, 0)
        db.ExecuteScalar("DC_AuthenticateUser")
        returnVal = CInt(db.Parameters("@ReturnVal").Value)
        Return returnVal
    End Function
    Private Function VerifyUser_P(ByVal GUID As String, ByVal SystemID As String) As String
        Dim db As New DBAccess()
        Dim intID As Integer = 0
        Dim ReturnID As Integer = 0
        Dim Actual_SystemId As String = String.Empty
        Dim DB_SystemId As String = String.Empty

        Actual_SystemId = SystemID
        DB_SystemId = GetSystemID(GUID)
        If Actual_SystemId = DB_SystemId Then
            db.AddParameter("@GUID", GUID)
            db.AddParameter("@ReturnID", SqlDbType.Int, 4, Data.ParameterDirection.ReturnValue, 0)
            intID = CType(db.ExecuteNonQuery("DC_VerifyUser"), Integer)
            ReturnID = CInt(CType(db.Parameters("@ReturnID"), System.Data.SqlClient.SqlParameter).Value)

            If ReturnID = 1 Then
                Return "True"
            ElseIf ReturnID = 2 Then
                Return "UnRegister"
            ElseIf ReturnID = 3 Then
                Return "Inactive"
            ElseIf ReturnID = 4 Then
                Return "False"
            Else
                Return "False"
            End If
        Else
            Return "False"
        End If

    End Function
    Private Function VerifySystemID_P(ByVal GUID As String, ByVal SystemID As String) As String
        Dim db As New DBAccess()
        Dim intID As Integer = 0
        Dim ReturnID As Integer = 0
        Dim Actual_Guid As String = String.Empty
        db.AddParameter("@GUID", GUID)
        db.AddParameter("@SystemID", SystemID)
        Actual_Guid = db.ExecuteScalar("DC_VerifySystemID")

        If String.IsNullOrEmpty(Actual_Guid) = True Or GUID = Actual_Guid Then
            Return "True"
        Else
            Return "False"
        End If
    End Function
    Private Function SaveUserLog_P(ByVal GUID As String, ByVal SystemID As String, ByVal SystemIP As String, ByVal CurrentVersion As String, ByVal RegistrationDate As String, ByVal LastTimeSync As String, ByVal SystemName As String) As String

        Dim db As New DBAccess()
        Dim intID As Integer = 0
        Dim ReturnID As Integer = 0
        Dim RetVal As String = "Nothing"
        db.AddParameter("@GUID", GUID)
        db.AddParameter("@SystemID", SystemID)
        If String.IsNullOrEmpty(SystemIP) Then
            db.AddParameter("@SystemIP", DBNull.Value)
        Else
            db.AddParameter("@SystemIP", SystemIP)
        End If
        db.AddParameter("@CurrentVersion", CurrentVersion)
        db.AddParameter("@RegistrationDate", Date.Now())
        db.AddParameter("@LastTimeSync", Date.Now())
        If (String.IsNullOrEmpty(SystemName) = False) Then
            db.AddParameter("@SystemName", SystemName)
        Else
            db.AddParameter("@SystemName", DBNull.Value)
        End If

        db.AddParameter("@ReturnID", SqlDbType.Int, 4, Data.ParameterDirection.ReturnValue, 0)

        intID = CType(db.ExecuteNonQuery("DC_SaveUserLog"), Integer)

        ReturnID = CInt(CType(db.Parameters("@ReturnID"), System.Data.SqlClient.SqlParameter).Value)

        If ReturnID = 1 Then
            RetVal = "Registered"
        End If

        If intID > 0 Then
            RetVal = "True"
        Else
            RetVal = "False"
        End If
        Return RetVal

    End Function
    Private Function Encryption(ByVal DataString As String) As String
GenerateAgain:
        Dim intCount As Integer
        Dim strEncString As String = ""
        Dim EKey As Integer
        EKey = GetRandomNumber(150, 1) + EncKey
        If Trim(DataString) <> "" Then
            For intCount = 1 To Len(DataString)
                If (Asc(Mid(DataString, intCount, 1)) + EKey > 255) Then
                    GoTo GenerateAgain
                End If
                strEncString = strEncString & Chr(Asc(Mid(DataString, intCount, 1)) + EKey)
            Next
            strEncString = Chr(EKey) & strEncString & Chr(SaltChar)
        End If
        Encryption = strEncString
    End Function
    Private Function GetRandomNumber(ByVal MaxValue As Integer, ByVal MinValue As Integer) As Object
        On Error GoTo ErrHandler

        Dim RndNum As Object
        Dim Ans(256) As String
        Dim Answer As String
        Dim Search As Integer
        Dim HowMany As Integer
        Dim i As Integer
        Randomize()
        Answer = ""
        For HowMany = 1 To 10
5:          RndNum = Int(Rnd() * MaxValue) + MinValue
            For Search = 1 To HowMany
                If RndNum = Ans(Search) Then GoTo 5
            Next Search
            Ans(HowMany) = RndNum
        Next HowMany
        For i = 1 To 10
            Answer = Answer & Ans(i)
            If i <> 256 Then Answer = Answer & ", "
        Next i
        GetRandomNumber = Ans(1)
        Exit Function

ErrHandler:
    End Function
    Private Function GetSystemID(ByVal GUID As String) As String
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@GUID", GUID)
        Return (db.ExecuteScalar("DC_GetSystemID"))
    End Function

    Private Function GetDCAppSettings(ByVal CountryID As String) As String
        Dim db As DBAccess = New DBAccess()
        db.AddParameter("@CountryID", CountryID)
        Return (DataTableToJSON(db.ExecuteDataTable("Get_DC_App_Settings")))
    End Function
    Private Function Decryption(ByVal EncryptedString As String) As String
        Dim intCount As Integer
        Dim strDecString As String = ""
        Dim EKey As Integer
        If Trim(EncryptedString) <> "" Then
            EKey = Asc(Strings.Left(EncryptedString, 1))

            If Strings.Right(EncryptedString, 1) <> Chr(SaltChar) Then Return Nothing
            For intCount = 2 To Len(EncryptedString) - 1
                strDecString = strDecString & Chr(Asc(Mid(EncryptedString, intCount, 1)) - EKey)
            Next
        End If
        Decryption = strDecString
    End Function
    Private Function GetClientIP() As String
        Dim strClientIP As String()
        strClientIP = Context.Request.ServerVariables.GetValues("REMOTE_ADDR")
        Return strClientIP(0)
    End Function

    Private Function DataTableToJSONSerialize(ByVal dt As DataTable) As String
	Dim retVal As String = "False"
        Dim jsonResponse As New JavaScriptSerializer
        Try
            retVal = jsonResponse.Serialize(dt)
        Catch ex As Exception
        End Try
        Return retVal
    End Function
    Public Shared Function DataTableToJSON(table As DataTable) As String
        Dim list As New List(Of Dictionary(Of String, Object))()

        For Each row As DataRow In table.Rows
            Dim dict As New Dictionary(Of String, Object)()

            For Each col As DataColumn In table.Columns
                dict(col.ColumnName) = row(col)
            Next
            list.Add(dict)
        Next
        Dim serializer As New JavaScriptSerializer()
        Return serializer.Serialize(list)
    End Function
#End Region
End Class

 