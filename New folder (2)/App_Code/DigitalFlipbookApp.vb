Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Security.Cryptography
Imports System.IO
Imports System.IO.Compression
Imports System.Text
Public Class DigitalFlipbookApp

    Private Shared _EncryptionKey As String ="Net$olacE1O4"
    'Public Shared IOSKeyString As String = ConfigurationManager.AppSettings("IOSKeyString")

    Public Shared ReadOnly Property EncryptionKey() As String
        Get
            Return _EncryptionKey
        End Get
    End Property

    'Public Const EncryptionKeyForDBPassword As String = "$oftwarE1O4"
    Public Shared Function EncryptString128Bit(ByVal vstrTextToBeEncrypted As String, _
                                        ByVal vstrEncryptionKey As String) As String
        Try
            If (String.IsNullOrEmpty(vstrTextToBeEncrypted)) Then
                Return vstrTextToBeEncrypted
            End If
            Dim bytValue() As Byte
            Dim bytKey() As Byte
            Dim bytEncoded() As Byte = Nothing
            Dim bytIV() As Byte = {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62}
            Dim intLength As Integer
            Dim intRemaining As Integer
            Dim objMemoryStream As New MemoryStream()
            Dim objCryptoStream As CryptoStream
            Dim objRijndaelManaged As RijndaelManaged

            '   **********************************************************************
            '   ******  Strip any null character from string to be encrypted    ******
            '   **********************************************************************

            vstrTextToBeEncrypted = StripNullCharacters(vstrTextToBeEncrypted)

            '   **********************************************************************
            '   ******  Value must be within ASCII range (i.e., no DBCS chars)  ******
            '   **********************************************************************

            bytValue = Encoding.ASCII.GetBytes(vstrTextToBeEncrypted.ToCharArray)

            intLength = Len(vstrEncryptionKey)

            '   ********************************************************************
            '   ******   Encryption Key must be 256 bits long (32 bytes)      ******
            '   ******   If it is longer than 32 bytes it will be truncated.  ******
            '   ******   If it is shorter than 32 bytes it will be padded     ******
            '   ******   with upper-case Xs.                                  ****** 
            '   ********************************************************************

            If intLength >= 32 Then
                vstrEncryptionKey = Strings.Left(vstrEncryptionKey, 32)
            Else
                intLength = Len(vstrEncryptionKey)
                intRemaining = 32 - intLength
                vstrEncryptionKey = vstrEncryptionKey & Strings.StrDup(intRemaining, "X")
            End If

            bytKey = Encoding.ASCII.GetBytes(vstrEncryptionKey.ToCharArray)

            objRijndaelManaged = New RijndaelManaged()

            '   ***********************************************************************
            '   ******  Create the encryptor and write value to it after it is   ******
            '   ******  converted into a byte array                              ******
            '   ***********************************************************************

            Try

                objCryptoStream = New CryptoStream(objMemoryStream, _
                  objRijndaelManaged.CreateEncryptor(bytKey, bytIV), _
                  CryptoStreamMode.Write)
                objCryptoStream.Write(bytValue, 0, bytValue.Length)

                objCryptoStream.FlushFinalBlock()

                bytEncoded = objMemoryStream.ToArray
                objMemoryStream.Close()
                objCryptoStream.Close()
            Catch
            End Try

            '   ***********************************************************************
            '   ******   Return encryptes value (converted from  byte Array to   ******
            '   ******   a base64 string).  Base64 is MIME encoding)             ******
            '   ***********************************************************************

            Return Convert.ToBase64String(bytEncoded)
        Catch ex As Exception
           ' ErrorLog.Add(ex)
            Return vstrTextToBeEncrypted
        End Try
    End Function
    Public Shared Function DecryptString128Bit(ByVal vstrStringToBeDecrypted As String, _
                                        ByVal vstrDecryptionKey As String) As String
        Try
            Dim bytDataToBeDecrypted() As Byte
            Dim bytTemp() As Byte
            Dim bytIV() As Byte = {121, 241, 10, 1, 132, 74, 11, 39, 255, 91, 45, 78, 14, 211, 22, 62}
            Dim objRijndaelManaged As New RijndaelManaged()
            Dim objMemoryStream As MemoryStream
            Dim objCryptoStream As CryptoStream
            Dim bytDecryptionKey() As Byte

            Dim intLength As Integer
            Dim intRemaining As Integer
            'Dim intCtr As Integer
            Dim strReturnString As String = String.Empty
            'Dim achrCharacterArray() As Char
            'Dim intIndex As Integer

            '   *****************************************************************
            '   ******   Convert base64 encrypted value to byte array      ******
            '   *****************************************************************

            bytDataToBeDecrypted = Convert.FromBase64String(vstrStringToBeDecrypted)

            '   ********************************************************************
            '   ******   Encryption Key must be 256 bits long (32 bytes)      ******
            '   ******   If it is longer than 32 bytes it will be truncated.  ******
            '   ******   If it is shorter than 32 bytes it will be padded     ******
            '   ******   with upper-case Xs.                                  ****** 
            '   ********************************************************************

            intLength = Len(vstrDecryptionKey)

            If intLength >= 32 Then
                vstrDecryptionKey = Strings.Left(vstrDecryptionKey, 32)
            Else
                intLength = Len(vstrDecryptionKey)
                intRemaining = 32 - intLength
                vstrDecryptionKey = vstrDecryptionKey & Strings.StrDup(intRemaining, "X")
            End If

            bytDecryptionKey = Encoding.ASCII.GetBytes(vstrDecryptionKey.ToCharArray)

            ReDim bytTemp(bytDataToBeDecrypted.Length)

            objMemoryStream = New MemoryStream(bytDataToBeDecrypted)

            '   ***********************************************************************
            '   ******  Create the decryptor and write value to it after it is   ******
            '   ******  converted into a byte array                              ******
            '   ***********************************************************************

            Try

                objCryptoStream = New CryptoStream(objMemoryStream, _
                   objRijndaelManaged.CreateDecryptor(bytDecryptionKey, bytIV), _
                   CryptoStreamMode.Read)

                objCryptoStream.Read(bytTemp, 0, bytTemp.Length)

                objCryptoStream.FlushFinalBlock()
                objMemoryStream.Close()
                objCryptoStream.Close()

            Catch
            End Try

            '   *****************************************
            '   ******   Return decypted value     ******
            '   *****************************************

            Dim strRes As String = StripNullCharacters(Encoding.ASCII.GetString(bytTemp))
            If (String.IsNullOrEmpty(strRes)) Then
                strRes = vstrStringToBeDecrypted
            End If
            Return strRes
        Catch ex As Exception
            'ErrorLog.Add(ex)
            Return vstrStringToBeDecrypted
        End Try
    End Function


    Public Shared Function StripNullCharacters(ByVal vstrStringWithNulls As String) As String
        Dim intPosition As Integer
        Dim strStringWithOutNulls As String

        intPosition = 1
        strStringWithOutNulls = vstrStringWithNulls

        Do While intPosition > 0
            intPosition = InStr(intPosition, vstrStringWithNulls, vbNullChar)

            If intPosition > 0 Then
                strStringWithOutNulls = Left$(strStringWithOutNulls, intPosition - 1) & _
                                  Right$(strStringWithOutNulls, Len(strStringWithOutNulls) - intPosition)
            End If

            If intPosition > strStringWithOutNulls.Length Then
                Exit Do
            End If
        Loop

        Return strStringWithOutNulls
    End Function

    Public Shared Function EncryptStringToBytes(ByVal plainText As String) As Byte()
        ' Check arguments.

        If plainText Is Nothing OrElse plainText.Length <= 0 Then
            Throw New ArgumentNullException("plainText")
        End If
        ' Declare the RijndaelManaged object
        ' used to encrypt the data.
        Dim aesAlg As RijndaelManaged = Nothing

        ' Declare the stream used to encrypt to an in memory
        ' array of bytes.
        Dim msEncrypt As MemoryStream = Nothing

        Try
            ' Create a RijndaelManaged object
            ' with the specified key and IV.
            aesAlg = New RijndaelManaged()

            aesAlg.Key = Convert.FromBase64String("5sWmiwFl16ZDCI5fSyULb6Qx9WWV/olRWIiN2YV+vEg=")
            aesAlg.IV = Convert.FromBase64String("db4mi1dMwQi56+iPf75+7Q==")

            ' Create a decrytor to perform the stream transform.
            Dim encryptor As ICryptoTransform = aesAlg.CreateEncryptor(aesAlg.Key, aesAlg.IV)

            ' Create the streams used for encryption.
            msEncrypt = New MemoryStream()
            Using csEncrypt As New CryptoStream(msEncrypt, encryptor, CryptoStreamMode.Write)
                Using swEncrypt As New StreamWriter(csEncrypt)

                    'Write all data to the stream.
                    swEncrypt.Write(plainText)
                End Using
            End Using

        Finally
            ' Clear the RijndaelManaged object.
            If Not (aesAlg Is Nothing) Then
                aesAlg.Clear()
            End If
        End Try
        ' Return the encrypted bytes from the memory stream.
        Return msEncrypt.ToArray()
    End Function

    ''''''''''''''''''''''''''''''''''''''''''''''''''
    Public Shared Function DecryptStringFromBytes(ByVal cipherText() As Byte) As String
        ' Check arguments.
        If cipherText Is Nothing OrElse cipherText.Length <= 0 Then
            Throw New ArgumentNullException("cipherText")
        End If

        ' Declare the RijndaelManaged object
        ' used to decrypt the data.
        Dim aesAlg As RijndaelManaged = Nothing



        ' Declare the string used to hold
        ' the decrypted text.
        Dim plaintext As String = Nothing

        Try
            ' Create a RijndaelManaged object
            ' with the specified key and IV.
            aesAlg = New RijndaelManaged()

            aesAlg.Key = Convert.FromBase64String("5sWmiwFl16ZDCI5fSyULb6Qx9WWV/olRWIiN2YV+vEg=")
            aesAlg.IV = Convert.FromBase64String("db4mi1dMwQi56+iPf75+7Q==")

            ' Create a decrytor to perform the stream transform.
            Dim decryptor As ICryptoTransform = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV)

            ' Create the streams used for decryption.
            Using msDecrypt As New MemoryStream(cipherText)
                Using csDecrypt As New CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read)
                    Using srDecrypt As New StreamReader(csDecrypt)

                        ' Read the decrypted bytes from the decrypting stream
                        ' and place them in a string.
                        plaintext = srDecrypt.ReadToEnd()
                    End Using
                End Using
            End Using

        Finally

            ' Clear the RijndaelManaged object.
            If Not (aesAlg Is Nothing) Then
                aesAlg.Clear()
            End If
        End Try
        Return plaintext
    End Function

    Public Shared Function EncryptToBase64(ByVal key As String) As String
        Return Convert.ToBase64String(System.Text.Encoding.UTF8.GetBytes(key))
    End Function

    Public Shared Function DecryptFromBase64(ByVal base64 As String) As String
        Return System.Text.Encoding.UTF8.GetString(Convert.FromBase64String(base64))
    End Function

    Public Shared Function IOS_EncryptString(ByVal plainSourceStringToEncrypt As String, ByVal passPhrase As String) As String
        Try
           ' Dim obj As New AESCryptor.Encryptor()
            'Return obj.Encrypt(plainSourceStringToEncrypt, passPhrase)
        Catch ex As Exception
           ' ErrorLog.Add(ex)
            Return String.Empty
        End Try
    End Function

    Public Shared Function IOS_DecryptString(ByVal base64StringToDecrypt As String, ByVal passphrase As String) As String
        Try
            If (String.IsNullOrEmpty(base64StringToDecrypt) = False) Then
                'Dim rgx As Regex = New Regex("[^a-zA-Z0-9+=\/]")
                'base64StringToDecrypt = rgx.Replace(base64StringToDecrypt, "")
                'base64StringToDecrypt = Regex.Replace(base64StringToDecrypt, "\p{Z}", "")

                'ActivityLog.AddServiceActivity("Delivery App Log", Enumerations.ServiceType.DeliveryApp, 0, True, "Test", base64StringToDecrypt)

               ' Dim obj As New AESCryptor.Decryptor()
                'Return obj.Decrypt(base64StringToDecrypt, passphrase)
            Else
                Return base64StringToDecrypt
            End If

        Catch ex As Exception
          '  ErrorLog.Add(ex)
            Return String.Empty
        End Try
    End Function
    Public Shared Function DecompressData(data As Byte()) As DataSet
        Try
            Dim memStream As New MemoryStream(data)

            Dim unzipStream As New GZipStream(memStream, CompressionMode.Decompress)
            Dim objDataSet As New DataSet()
            objDataSet.ReadXml(unzipStream, XmlReadMode.ReadSchema)
            unzipStream.Close()
            memStream.Close()
            Return objDataSet
        Catch ex As Exception
            Return Nothing
        End Try
    End Function

    Public Shared Function JsonString(ByVal ErrorName1 As String, ByVal ErrorName2 As String, ByVal ErrorMessage As String) As String
        Return "[{""" + ErrorName1 + """: [{""" + ErrorName2 + """: """ + ErrorMessage + """}]}]"
    End Function

End Class
