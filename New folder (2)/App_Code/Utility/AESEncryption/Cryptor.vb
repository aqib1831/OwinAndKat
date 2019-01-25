Imports Microsoft.VisualBasic
Imports System.IO
Imports System.Security.Cryptography
Imports System.Text
Imports System.Collections.Generic


Namespace Portal.Utility.AESEncryption
    Public Enum Schema As Short
        V0
        V1
        V2
        V3
    End Enum
    Public Enum AesMode As Short
        CTR
        CBC
    End Enum
    Public Enum Pbkdf2Prf As Short
        SHA1
    End Enum
    Public Enum HmacAlgorithm As Short
        SHA1
        SHA256
    End Enum
    Public Enum Algorithm As Short
        AES
    End Enum
    Public Enum Options As Short
        V0
        V1
    End Enum
    Public Structure PayloadComponents
        Public schema As Byte()
        Public options As Byte()
        Public salt As Byte()
        Public hmacSalt As Byte()
        Public iv As Byte()
        Public headerLength As Integer
        Public hmac As Byte()
        Public ciphertext As Byte()
    End Structure
    Public MustInherit Class Cryptor
        Protected aesMode As AesMode
        Protected options As Options
        Protected hmac_includesHeader As Boolean
        Protected hmac_includesPadding As Boolean
        Protected hmac_algorithm As HmacAlgorithm

        Protected Const algorithm As Algorithm = algorithm.AES
        Protected Const saltLength As Short = 8
        Protected Const ivLength As Short = 16
        Protected Const pbkdf2_prf As Pbkdf2Prf = Pbkdf2Prf.SHA1
        Protected Const pbkdf2_iterations As Integer = 10000
        Protected Const pbkdf2_keyLength As Short = 32
        Protected Const hmac_length As Short = 32

        ''' <summary>
        '''Gets or sets the Encoding
        ''' </summary>
        Public Property TextEncoding() As Encoding
            Get
                Return m_TextEncoding
            End Get
            Set(ByVal value As Encoding)
                m_TextEncoding = value
            End Set
        End Property
        Private m_TextEncoding As Encoding

        Public Sub New()
            ' set default encoding for UTF8
            TextEncoding = Encoding.UTF8
        End Sub

        Protected Sub configureSettings(ByVal schemaVersion As Schema)
            Select Case schemaVersion
                Case Schema.V0
                    aesMode = aesMode.CTR
                    options = options.V0
                    hmac_includesHeader = False
                    hmac_includesPadding = True
                    hmac_algorithm = HmacAlgorithm.SHA1
                    Exit Select

                Case Schema.V1
                    aesMode = aesMode.CBC
                    options = options.V1
                    hmac_includesHeader = False
                    hmac_includesPadding = False
                    hmac_algorithm = HmacAlgorithm.SHA256
                    Exit Select

                Case Schema.V2, Schema.V3
                    aesMode = aesMode.CBC
                    options = options.V1
                    hmac_includesHeader = True
                    hmac_includesPadding = False
                    hmac_algorithm = HmacAlgorithm.SHA256
                    Exit Select
            End Select
        End Sub

        Protected Function generateHmac(ByVal components As PayloadComponents, ByVal password As String) As Byte()
            Dim hmacMessage As New List(Of Byte)()
            If Me.hmac_includesHeader Then
                hmacMessage.AddRange(Me.assembleHeader(components))
            End If
            hmacMessage.AddRange(components.ciphertext)

            Dim key As Byte() = Me.generateKey(components.hmacSalt, password)

            Dim hmacAlgo As HMAC = Nothing
            Select Case Me.hmac_algorithm
                Case HmacAlgorithm.SHA1
                    hmacAlgo = New HMACSHA1(key)
                    Exit Select

                Case HmacAlgorithm.SHA256
                    hmacAlgo = New HMACSHA256(key)
                    Exit Select
            End Select
            Dim hmac As New List(Of Byte)()
            hmac.AddRange(hmacAlgo.ComputeHash(hmacMessage.ToArray()))

            If Me.hmac_includesPadding Then
                For i As Integer = hmac.Count To Cryptor.hmac_length - 1
                    hmac.Add(&H0)
                Next
            End If

            Return hmac.ToArray()
        End Function

        Protected Function assembleHeader(ByVal components As PayloadComponents) As Byte()
            Dim headerBytes As New List(Of Byte)()
            headerBytes.AddRange(components.schema)
            headerBytes.AddRange(components.options)
            headerBytes.AddRange(components.salt)
            headerBytes.AddRange(components.hmacSalt)
            headerBytes.AddRange(components.iv)

            Return headerBytes.ToArray()
        End Function

        Protected Function generateKey(ByVal salt As Byte(), ByVal password As String) As Byte()
            Dim pbkdf2 = New Rfc2898DeriveBytes(password, salt, Cryptor.pbkdf2_iterations)
            Return pbkdf2.GetBytes(Cryptor.pbkdf2_keyLength)
        End Function

        Protected Function encryptAesCtrLittleEndianNoPadding(ByVal plaintextBytes As Byte(), ByVal key As Byte(), ByVal iv As Byte()) As Byte()
            Dim counter As Byte() = Me.computeAesCtrLittleEndianCounter(plaintextBytes.Length, iv)
            Dim encrypted As Byte() = Me.encryptAesEcbNoPadding(counter, key)
            Return Me.bitwiseXOR(plaintextBytes, encrypted)
        End Function

        Private Function computeAesCtrLittleEndianCounter(ByVal payloadLength As Integer, ByVal iv As Byte()) As Byte()
            Dim incrementedIv As Byte() = New Byte(iv.Length - 1) {}
            iv.CopyTo(incrementedIv, 0)

            Dim blockCount As Integer = CInt(Math.Truncate(Math.Ceiling(CDec(payloadLength) / CDec(iv.Length))))

            Dim counter As New List(Of Byte)()

            For i As Integer = 0 To blockCount - 1
                counter.AddRange(incrementedIv)

                ' Yes, the next line only ever increments the first character
                ' of the counter string, ignoring overflow conditions.  This
                ' matches CommonCrypto's behavior!
                incrementedIv(0) += 1
            Next

            Return counter.ToArray()
        End Function

        Private Function encryptAesEcbNoPadding(ByVal plaintext As Byte(), ByVal key As Byte()) As Byte()
            Dim encrypted As Byte()

            Dim aes__1 As New System.Security.Cryptography.RijndaelManaged()
            aes__1.Mode = CipherMode.ECB
            aes__1.Padding = PaddingMode.None
            Dim encryptor As ICryptoTransform = aes__1.CreateEncryptor(key, Nothing)

            Using ms As New MemoryStream()
                Using cs1 As CryptoStream = New CryptoStream(ms, encryptor, CryptoStreamMode.Write)
                    cs1.Write(plaintext, 0, plaintext.Length)
                End Using
                encrypted = ms.ToArray()
            End Using
            Return encrypted
        End Function

        Private Function bitwiseXOR(ByVal first() As Byte, ByVal second() As Byte) As Byte()
            Dim output() As Byte = New Byte((first.Length) - 1) {}
            Dim klen As System.UInt64 = CType(second.Length, System.UInt64)
            Dim vlen As System.UInt64 = CType(first.Length, System.UInt64)
            Dim k As System.UInt64 = 0
            Dim v As System.UInt64 = 0

            Do While (v < vlen)
                output(v) = CType((first(v) Or second(k)), Byte)
                'The operator should be an XOR ^ instead of an OR, but not available in CodeDOM
                k = ((k < klen) _
                            + 1)
                'TODO: Warning!!!, inline IF is not supported ?
                v = (v + 1)
            Loop
            Return output
        End Function

        Protected Function hex_encode(ByVal input As Byte()) As String
            Dim hex As String = ""
            For Each c As Byte In input
                hex += String.Format("{0:x2}", c)
            Next
            Return hex
        End Function
    End Class

End Namespace
