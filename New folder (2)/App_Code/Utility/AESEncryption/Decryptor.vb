Imports Microsoft.VisualBasic
Imports System.IO
Imports System.Text
Imports System.Security.Cryptography
Imports System.Collections.Generic

Namespace Portal.Utility.AESEncryption
    Public Class Decryptor
        Inherits Cryptor
        Public Function Decrypt(ByVal encryptedBase64 As String, ByVal password As String) As String
            Dim components As PayloadComponents = Me.unpackEncryptedBase64Data(encryptedBase64)

            If Not Me.hmacIsValid(components, password) Then
                Return ""
            End If

            Dim key As Byte() = Me.generateKey(components.salt, password)

            Dim plaintextBytes As Byte() = New Byte(-1) {}

            Select Case Me.aesMode
                Case aesMode.CTR
                    ' Yes, we are "encrypting" here.  CTR uses the same code in both directions.
                    plaintextBytes = Me.encryptAesCtrLittleEndianNoPadding(components.ciphertext, key, components.iv)
                    Exit Select

                Case aesMode.CBC
                    plaintextBytes = Me.decryptAesCbcPkcs7(components.ciphertext, key, components.iv)
                    Exit Select
            End Select

            Return Encoding.UTF8.GetString(plaintextBytes)
        End Function

        Private Function decryptAesCbcPkcs7(ByVal encrypted As Byte(), ByVal key As Byte(), ByVal iv As Byte()) As Byte()
            Dim aes__1 As New System.Security.Cryptography.RijndaelManaged()
            aes__1.Mode = CipherMode.CBC
            aes__1.Padding = PaddingMode.PKCS7
            Dim decryptor As ICryptoTransform = aes__1.CreateDecryptor(key, iv)

            Dim plaintext As String
            Using msDecrypt As New MemoryStream(encrypted)
                Using csDecrypt As New CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read)
                    Using srDecrypt As New StreamReader(csDecrypt)
                        plaintext = srDecrypt.ReadToEnd()
                    End Using
                End Using
            End Using

            Return TextEncoding.GetBytes(plaintext)
        End Function

        Private Function unpackEncryptedBase64Data(ByVal encryptedBase64 As String) As PayloadComponents
            Dim binaryBytes As New List(Of Byte)()
            binaryBytes.AddRange(Convert.FromBase64String(encryptedBase64))

            Dim components As PayloadComponents
            Dim offset As Integer = 0

            components.schema = binaryBytes.GetRange(0, 1).ToArray()
            offset += 1

            Me.configureSettings(CType(binaryBytes(0), Schema))

            components.options = binaryBytes.GetRange(1, 1).ToArray()
            offset += 1

            components.salt = binaryBytes.GetRange(offset, Cryptor.saltLength).ToArray()
            offset += components.salt.Length

            components.hmacSalt = binaryBytes.GetRange(offset, Cryptor.saltLength).ToArray()
            offset += components.hmacSalt.Length

            components.iv = binaryBytes.GetRange(offset, Cryptor.ivLength).ToArray()
            offset += components.iv.Length

            components.headerLength = offset

            components.ciphertext = binaryBytes.GetRange(offset, binaryBytes.Count - Cryptor.hmac_length - components.headerLength).ToArray()
            offset += components.ciphertext.Length

            components.hmac = binaryBytes.GetRange(offset, Cryptor.hmac_length).ToArray()

            Return components

        End Function

        Private Function hmacIsValid(ByVal components As PayloadComponents, ByVal password As String) As Boolean
            Dim generatedHmac As Byte() = Me.generateHmac(components, password)

            If generatedHmac.Length <> components.hmac.Length Then
                Return False
            End If

            For i As Integer = 0 To components.hmac.Length - 1
                If generatedHmac(i) <> components.hmac(i) Then
                    Return False
                End If
            Next
            Return True
        End Function


    End Class

End Namespace

