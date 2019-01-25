Imports Microsoft.VisualBasic
Imports System.IO
Imports System.Collections.Generic
Imports System.Security.Cryptography

Namespace Portal.Utility.AESEncryption
    Public Class Encryptor
        Inherits Cryptor
        Private defaultSchemaVersion As Schema = Schema.V2

        Public Function Encrypt(ByVal plaintext As String, ByVal password As String) As String
            Return Me.Encrypt(plaintext, password, Me.defaultSchemaVersion)
        End Function

        Public Function Encrypt(ByVal plaintext As String, ByVal password As String, ByVal schemaVersion As Schema) As String
            Me.configureSettings(schemaVersion)

            Dim plaintextBytes As Byte() = TextEncoding.GetBytes(plaintext)

            Dim components As New PayloadComponents()
            components.schema = New Byte() {CByte(schemaVersion)}
            components.options = New Byte() {CByte(Me.options)}
            components.salt = Me.generateRandomBytes(Cryptor.saltLength)
            components.hmacSalt = Me.generateRandomBytes(Cryptor.saltLength)
            components.iv = Me.generateRandomBytes(Cryptor.ivLength)

            Dim key As Byte() = Me.generateKey(components.salt, password)

            Select Case Me.aesMode
                Case aesMode.CTR
                    components.ciphertext = Me.encryptAesCtrLittleEndianNoPadding(plaintextBytes, key, components.iv)
                    Exit Select

                Case aesMode.CBC
                    components.ciphertext = Me.encryptAesCbcPkcs7(plaintextBytes, key, components.iv)
                    Exit Select
            End Select

            components.hmac = Me.generateHmac(components, password)

            Dim binaryBytes As New List(Of Byte)()
            binaryBytes.AddRange(Me.assembleHeader(components))
            binaryBytes.AddRange(components.ciphertext)
            binaryBytes.AddRange(components.hmac)

            Return Convert.ToBase64String(binaryBytes.ToArray())
        End Function

        Private Function encryptAesCbcPkcs7(ByVal plaintext As Byte(), ByVal key As Byte(), ByVal iv As Byte()) As Byte()
            Dim aes__1 As New System.Security.Cryptography.RijndaelManaged()
            aes__1.Mode = CipherMode.CBC
            aes__1.Padding = PaddingMode.PKCS7
            Dim encryptor As ICryptoTransform = aes__1.CreateEncryptor(key, iv)

            Dim encrypted As Byte()

            Using ms As New MemoryStream()
                Using cs1 As New CryptoStream(ms, encryptor, CryptoStreamMode.Write)
                    cs1.Write(plaintext, 0, plaintext.Length)
                End Using

                encrypted = ms.ToArray()
            End Using

            Return encrypted
        End Function

        Private Function generateRandomBytes(ByVal length As Integer) As Byte()
            Dim randomBytes As Byte() = New Byte(length - 1) {}
            Dim rng = New RNGCryptoServiceProvider()
            rng.GetBytes(randomBytes)

            Return randomBytes
        End Function

    End Class
End Namespace

