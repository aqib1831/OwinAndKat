<%
Function getStatus(intStatus)
   Select Case intStatus
	 		  Case 1
						getStatus = "Coming Soon"
	 		  Case 2
						getStatus = "Operating"
	 		  Case 3
						getStatus = "Corporate"
	 		  Case 4
						getStatus = "Terminated"
	 		  Case 5
						getStatus = "Suspended"
	 		  Case 6
						getStatus = "Transferred"
	 		  Case 7
						getStatus = "Master"
	 End Select
End Function

Function getSubStatus(intSubStatus)
   Select Case intSubStatus
	 		  Case 1
						getSubStatus = "Pending Lease"
	 		  Case 2
						getSubStatus = "Lease Signed"
	 		  Case 3
						getSubStatus = "Under Construction"
	 		  Case 4
						getSubStatus = "Pre Opening"
	 		  Case 5
						getSubStatus = "Grand Opening"
	 End Select
End Function

Function FixLongForComparison(strValue,lngInitValue)
	If strValue = "" Then
		FixLongForComparison = CLng(lngInitValue)
	Else
		FixLongForComparison = CLng(strValue)
	End If
End Function


Function getCCPaymentGateWay(intGateway)
   Select Case intGateway
	 		  Case 1
						getCCPaymentGateWay = "MPS"
	 		  Case 2
						getCCPaymentGateWay = "FD"
	 End Select
End Function

Function CreateNewFolder(strFolderPath)
	
	Dim objFSO							' As Scripting.FileSystemObject
	Dim objFolder						' As Folder Object
	
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	If objFSO.FolderExists(strFolderPath) = False Then
			Set objFolder = objFSO.CreateFolder(strFolderPath)
			Set objFolder = Nothing
	End If	
	
	Set objFSO = Nothing

End Function

Function RenameFolder(strFolderOldName, strFolderNewName)
	
	Dim objFSO							' As Scripting.FileSystemObject
	Dim objFolder						' As Folder Object
	
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

	If objFSO.FolderExists(strFolderOldName) = true Then
		objFSO.MoveFolder strFolderOldName, strFolderNewName
	Else
			Set objFolder = objFSO.CreateFolder(strFolderNewName)
			Set objFolder = Nothing
	End If	

	Set objFSO = Nothing

End Function

Function CutFile(strSourcePath, strDestinationPath)

	Dim objFSO				' As Scripting.FileSystemObject

	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

	If objFSO.FileExists(strSourcePath) Then
		'Response.Write("strSourcePath = " & strSourcePath)
		'Response.Write("<br>strDestinationPath = " & strDestinationPath)
		'Response.End()
		
		'objFSO.MoveFile strSourcePath, strDestinationPath		' Move file to destination folder 
		objFSO.CopyFile strSourcePath, strDestinationPath		' Move file to destination folder 
	End If

	Set objFSO=nothing

End Function

Function RemoveBetweenTags(strInput, strStartingTag, strEndingTag)
  Dim lngStartingTagPos
  Dim lngEndingTagPos
  lngStartingTagPos = InStr(1 , strInput, strStartingTag, vbTextCompare)
  lngEndingTagPos = InStrRev(strInput, strEndingTag, Len(strInput) , vbTextCompare)
  If lngStartingTagPos > 0 And lngEndingTagPos > 0 And lngStartingTagPos <= lngEndingTagPos Then
    RemoveBetweenTags = Mid(strInput, 1, lngStartingTagPos-1) & Mid(strInput, lngEndingTagPos + Len(strEndingTag))
  Else
    RemoveBetweenTags = strInput
  End If
End Function

Function DeleteMKTFolders(reqStoreCity,reqStoreNumber)
		Dim strFolderPath
		Dim objFSO
		Set objFSO= Server.CreateObject("Scripting.FileSystemObject")
		
		strFolderPath = cstMKTCurrentWorkFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If objFSO.FolderExists(strFolderPath) then
			 Call RenameFolder(strFolderPath, strFolderPath & "_Deleted")
		End If

		strFolderPath = cstMKTNewAdFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If objFSO.FolderExists(strFolderPath) then
			Call RenameFolder(strFolderPath, strFolderPath & "_Deleted")
		End If

		strFolderPath = cstMKTCreateAdFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If objFSO.FolderExists(strFolderPath) then
			Call RenameFolder(strFolderPath, strFolderPath & "_Deleted")
		End If

		strFolderPath = cstMKTEditedAdFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If objFSO.FolderExists(strFolderPath) then
			Call RenameFolder(strFolderPath, strFolderPath & "_Deleted")
		End If
		
		Set objFSO = Nothing
End Function

Function CreateMKTFolders(reqStoreCity,reqStoreNumber)
		Dim strFolderPath
		Dim objFSO
		Set objFSO= Server.CreateObject("Scripting.FileSystemObject")
		
		strFolderPath = cstMKTCurrentWorkFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If NOT objFSO.FolderExists(strFolderPath) then
			Call CreateNewFolder(strFolderPath)
		End If

		strFolderPath = cstMKTNewAdFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If Not objFSO.FolderExists(strFolderPath) then
			Call CreateNewFolder(strFolderPath)
		End If

		strFolderPath = cstMKTCreateAdFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If Not objFSO.FolderExists(strFolderPath) then
			Call CreateNewFolder(strFolderPath)
		End If

		strFolderPath = cstMKTEditedAdFoldersPath & MakeValidFolderName(reqStoreCity &"_"& reqStoreNumber)
		strFolderPath = Server.MapPath(strFolderPath)
		
		If Not objFSO.FolderExists(strFolderPath) then
			Call CreateNewFolder(strFolderPath)
		End If
		
		Set objFSO = Nothing
End Function

'******************************************************************
'FUNCTION TO get the Numeric part of string
'******************************************************************
Function ExtractNumbers(str)

  Dim I
  Dim strNumbers
  Dim strChar
  strNumbers = ""
  For I = 1 To Len(str)
    strChar = Mid(str, I, 1)
    If (strChar >= "0" And strChar <= "9") Then
      strNumbers = strNumbers & strChar
    End If
  Next
  ExtractNumbers = strNumbers

End Function


Function FormatNumberString(num)

	Dim postFix
	If IsNumeric(num) Then
		num = CInt(num)
		Select Case (num MOD 10)
			Case 1
				If num = 11 Then
					postFix = "th"
				Else
					postFix = "st"
				End If
			Case 2
				If num = 12 Then
					postFix = "th"
				Else
					postFix = "nd"
				End If
			Case 3
				If num = 13 Then
					postFix = "th"
				Else
					postFix = "rd"
				End If
			Case Else
				postFix = "th"
		End Select
		FormatNumberString = num & postFix
	Else
		FormatNumberString = ""
	End If

End Function


Function EncryptSSN(SSN)
  Dim strSSN
  On Error Resume Next
  Dim i
  For i = 0 To Len(SSN)
      strSSN = strSSN & (Asc(Mid(SSN, i, 1)) * 44.44) & "GdGaYcWoBxIqV"
  Next
  EncryptSSN = strSSN
End Function

Function DecryptSSN(text)
    On Error Resume Next
    Dim i
    Dim Decrypt
    For i = 0 To Len(text)
        Decrypt = Decrypt & Chr((Split(text, "GdGaYcWoBxIqV")(i) / 44.44))
    Next
    DecryptSSN = Decrypt
End Function

Function GetCreditCardType(ccNumber)

	If Trim(ccNumber) = "" Then
		GetCreditCardType = "Unknown"
		Exit Function
	End If
	
	Dim Left4Digits
	Left4Digits = CInt(Left(ccNumber, 4))
	
	If (Left4Digits >= 3000 And Left4Digits <= 3059) Or (Left4Digits >= 3600 And Left4Digits <= 3699) Or (Left4Digits >= 3800 And Left4Digits <= 3889) Then
		GetCreditCardType = "Diners Club"
	ElseIf (Left4Digits >= 3400 And Left4Digits <= 3499) Or (Left4Digits >= 3700 And Left4Digits <= 3799) Then
		GetCreditCardType = "American Express"
	ElseIf (Left4Digits >= 3528 And Left4Digits <= 3589) Then
		GetCreditCardType = "JCB"
	ElseIf (Left4Digits >= 5100 And Left4Digits <= 5599) Then
		GetCreditCardType = "Master Card"
	ElseIf (Left4Digits >= 4000 And Left4Digits <= 4999) Then
		GetCreditCardType = "Visa"
	ElseIf (Left4Digits = 6011) Then
    GetCreditCardType = "Discover Card"
	End If
	
End Function

Function GetCCNameByDbId(Id)

	If Trim(Id) = "" Then
		GetCCNameByDbId = "Unknown"
		Exit Function
	ElseIf IsNumeric(Id) = False Then
		GetCCNameByDbId = "Unknown"
		Exit Function
	End If
	
	Select Case CInt(Id)
		Case 13	
			GetCCNameByDbId = "American Express"
		Case 14
			GetCCNameByDbId = "Visa"
		Case 15
			GetCCNameByDbId = "Master Card"
		Case 16
			GetCCNameByDbId = "Diners Club"
		Case 17
			GetCCNameByDbId = "JCB"
		Case 18
			GetCCNameByDbId = "Discover Card"
	End Select

End Function


Function RTFSafeForFCK(strText)
 'returns safe code for preloading in the RTE
 Dim tmpString

 tmpString = trim(strText)
 If Not IsNull(tmpString) Then
  tmpString = replace(tmpString, "<script", "")
  tmpString = replace(tmpString, "</script>", "")

  'convert all types of single quotes
  tmpString = replace(tmpString, chr(145), chr(39))
  tmpString = replace(tmpString, chr(146), chr(39))
  tmpString = replace(tmpString, "'", "&#39;")

  'convert all types of double quotes
  tmpString = replace(tmpString, chr(147), chr(34))
  tmpString = replace(tmpString, chr(148), chr(34))
  tmpString = replace(tmpString, """", "\""")

  'replace carriage returns & line feeds
  tmpString = replace(tmpString, chr(10), " ")
  tmpString = replace(tmpString, chr(13), " ")
 Else
  tmpString = ""
 End If
 RTFSafeForFCK = tmpString
End Function

Function getInitiativeStatusText(intStatus, InitiativeType)
	If InitiativeType = "2" Then			' 1=Regional Initiatives,2=Shared Advertizing tool
			If intStatus = 0 Then
				getInitiativeStatusText = "In progress"
			elseif 	intStatus = 1 Then
				getInitiativeStatusText = "Completed"
			elseif 	intStatus = 2 Then
				getInitiativeStatusText = "Completed"
			elseif 	intStatus = 3 Then
				getInitiativeStatusText = "Canceled"
			End if 
	Else
			If intStatus = 0 Then
				getInitiativeStatusText = "Voting in progress"
			elseif 	intStatus = 1 Then
				getInitiativeStatusText = "Approved"
			elseif 	intStatus = 2 Then
				getInitiativeStatusText = "Rejected"
			elseif 	intStatus = 3 Then
				getInitiativeStatusText = "Canceled"
			elseif 	intStatus = 4 Then
				getInitiativeStatusText = "Pending"
			elseif 	intStatus = 6 Then
				getInitiativeStatusText = "Rejected By Admin"
		End if 
	End If
End Function

Function SendProductUnavailableEmail(con, ProdID, sPath)

	Dim objMail
	Dim objFSO
	Dim objFile
	Dim strData
	Dim strSql
	Dim rsResult
	
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set objMail = Server.CreateObject("CDO.Message")
	
	Set objFile = objFSO.OpenTextFile(sPath, 1)
	strData = objFile.ReadAll()
	objFile.Close
	
	strSql = " SELECT TOP 1 " & _
				"	scm_Products.Name  " & _
				"	, scm_Products.Code " & _
				"	, scm_Products.[Description] " & _
				"	, scm_Orders.SupplierName " & _
				"	, CAST(vFranchises.StoreNumber AS nVarchar(50)) + ' - ' + vFranchises.StoreName AS OrderBy " & _
				"	, scm_Orders.[Date] " & _
				"	, scm_OrderItems.Quantity " & _
				" FROM scm_OrderItems " & _
				" INNER JOIN scm_Products ON scm_OrderItems.ProductID = scm_Products.[ID] " & _
				" INNER JOIN scm_Orders ON scm_OrderItems.OrderID = scm_Orders.[ID] " & _
				" INNER JOIN vFranchises ON scm_Orders.FranchiseID = vFranchises.[ID] " & _
				" WHERE scm_OrderItems.ProductID = " & ProdID & _
				" Order By scm_Orders.[Date] DESC "
				
	Set rsResult = con.Execute(strSql)

	strData = Replace(strData,"<*CODE*>",rsResult("Code"))
	strData = Replace(strData,"<*Name*>",rsResult("Name"))
	strData = Replace(strData,"<*Supplier*>",rsResult("SupplierName"))
	strData = Replace(strData,"<*Description*>",rsResult("Description"))
	strData = Replace(strData,"<*OrderStore*>",rsResult("OrderBy"))
	strData = Replace(strData,"<*LastOrderedOn*>",rsResult("Date"))
	strData = Replace(strData,"<*Qty*>",rsResult("Quantity"))


	objMail.From = "ncompass - SCM Alert <eai@ediblearrangements.com>"
	objMail.To = "kshahzad@broadpeakit.com"
	objMail.Subject = "ncompass - SCM Alert"
	objMail.HTMLBody = strData
	objMail.Send()

	rsResult.Close
	
	Set objFile = Nothing
	Set objFSO = Nothing
	Set rsResult = Nothing
	Set objMail = Nothing
	
End Function

%>