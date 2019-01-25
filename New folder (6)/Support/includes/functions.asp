<%
Function getActivityPrefix(actType)

	If actType = cstActivityTypeHelpDesk Then
		getActivityPrefix = "H"
	ElseIf actType = cstActivityTypeMessage Then
		getActivityPrefix = "M"
	ElseIf actType = cstActivityTypeCall Then 
		getActivityPrefix = "C"
	ElseIf actType = cstActivityTypeEmail Then
		getActivityPrefix = "E"
	ElseIf actType = cstActivityTypeFax Then
		getActivityPrefix = "F"
	ElseIf actType = cstActivityTypeMeeting Then
		getActivityPrefix = "T"
	ElseIf actType = cstActivityTypeLetter Then
		getActivityPrefix = "L"
	ElseIf actType = cstActivityTypeOther Then
		getActivityPrefix = "O"
	ElseIf actType = cstActivityTypeNewStoreStage Then
		getActivityPrefix = "N"
	ElseIf actType = cstActivityTypeMKTCalendar Then
		getActivityPrefix = "MC"
	ElseIf actType = cstActivityTypeEdibleIdea Then
		getActivityPrefix = "EI"				
	ElseIf actType = cstActivityTypeDiscussionBoard Then
		getActivityPrefix = "D"
	ElseIf actType = cstActivityTypeProfileUpdate Then
		getActivityPrefix = "PU"
	ElseIf actType = cstActivityTypeProfileStoreUpdate Then
		getActivityPrefix = "S"
	ElseIf actType = cstActivityTypeNSMCoordinatorChange Then
		getActivityPrefix = "NC"
	ElseIf actType = cstActivityTypeFinance Then
		getActivityPrefix = "FN"
	ElseIf actType = cstActivityTypeRequestAdditionalArea Then
		getActivityPrefix = "RA"
	ElseIf actType = cstActivityTypeQAR Then
		getActivityPrefix = "Q"
	End If

End Function

Function getActivityCaption(actType)

	If actType = cstActivityTypeHelpDesk Then
		getActivityCaption = "Help Desk"
	ElseIf actType = cstActivityTypeMessage Then
		getActivityCaption = "Message"
	ElseIf actType = cstActivityTypeCall Then 
		getActivityCaption = "Call"
	ElseIf actType = cstActivityTypeEmail Then
		getActivityCaption = "Email"
	ElseIf actType = cstActivityTypeFax Then
		getActivityCaption = "Fax"
	ElseIf actType = cstActivityTypeMeeting Then
		getActivityCaption = "Meeting"
	ElseIf actType = cstActivityTypeLetter Then
		getActivityCaption = "Letter"
	ElseIf actType = cstActivityTypeOther Then
		getActivityCaption = "Other"
	ElseIf actType = cstActivityTypeNewStoreStage Then
		getActivityCaption = "New Store Stage"
	ElseIf actType = cstActivityTypeMKTCalendar Then
		getActivityCaption = "MKT Calendar"
	ElseIf actType = cstActivityTypeEdibleIdea Then
		getActivityCaption = "Edible Idea"		
	ElseIf actType = cstActivityTypeDiscussionBoard Then
		getActivityCaption = "Discussion Board"
	ElseIf actType = cstActivityTypeProfileUpdate Then
		getActivityCaption = "Profile Update"
	ElseIf actType = cstActivityTypeProfileStoreUpdate Then
		getActivityCaption = "Store"
	ElseIf actType = cstActivityTypeNSMCoordinatorChange Then
		getActivityCaption = "NSM Coordinator"
	ElseIf actType = cstActivityTypeFinance Then
		getActivityCaption = "Finance"
	ElseIf actType = cstActivityTypeRequestAdditionalArea Then
		getActivityCaption = "Additional Area"
	ElseIf actType = cstActivityTypeQAR Then
		getActivityCaption = "QAR"
	Else
		getActivityCaption = "Unknown"
	End If

End Function

Function getImageByActivityType(actType)

	If actType = cstActivityTypeHelpDesk Then
		getImageByActivityType = "ico_helpdesktickets.gif"
	ElseIf actType = cstActivityTypeMessage Then
		getImageByActivityType = "ico_newmessage.gif"
	ElseIf actType = cstActivityTypeCall Then 
		getImageByActivityType = "Call.gif"
	ElseIf actType = cstActivityTypeEmail Then
		getImageByActivityType = "Email.gif"
	ElseIf actType = cstActivityTypeFax Then
		getImageByActivityType = "fax.gif"
	ElseIf actType = cstActivityTypeMeeting Then
		getImageByActivityType = "Meeting.gif"
	ElseIf actType = cstActivityTypeLetter Then
		getImageByActivityType = "Letter.gif"
	ElseIf actType = cstActivityTypeOther Then
		getImageByActivityType = "Other.gif"
	ElseIf actType = cstActivityTypeNewStoreStage Then
		getImageByActivityType = "store.gif"
	ElseIf actType = cstActivityTypeMKTCalendar Then
		getImageByActivityType = "store.gif"
	ElseIf actType = cstActivityTypeEdibleIdea Then
		getImageByActivityType = "ico_edibleidea.gif"
	ElseIf actType = cstActivityTypeDiscussionBoard Then
		getImageByActivityType = "ico_discussion.gif"
	ElseIf actType = cstActivityTypeProfileUpdate Then
		getImageByActivityType = "ico_profileupdate.gif"
	ElseIf actType = cstActivityTypeNSMCoordinatorChange Then
		getImageByActivityType = "store.gif"
	ElseIf actType = cstActivityTypeRequestAdditionalArea Then
		getImageByActivityType = "ico_additionaldeliveryarea.gif"
	ElseIf actType = cstActivityTypeQAR Then
		getImageByActivityType = "ico_qar.gif"		
	Else
		getImageByActivityType = "other.gif"
	End If

End Function

Function getCategoryCaption(catType)

	If catType = 1 Then 
		getCategoryCaption = "Suggestion"
	ElseIf catType = 2 Then 	
		getCategoryCaption = "Bug"
	ElseIf catType = 3 Then 	
		getCategoryCaption = "Query"
	ElseIf catType = 4 Then 	
		getCategoryCaption = "Other"
	End If

End Function

Function getSubTypeCaption(actSubType)

	If actSubType = 1 Then  
		getSubTypeCaption = "General"
	ElseIf actSubType = 2 Then 
		getSubTypeCaption = "Notice"
	ElseIf actSubType = 3 Then 
		getSubTypeCaption = "Complaint"
	ElseIf actSubType = 4 Then 
		getSubTypeCaption = "Compliment"
	ElseIf actSubType = 5 Then 
		getSubTypeCaption = "Violation"
	ElseIf actSubType = 6 Then 
		getSubTypeCaption = "Weekly Call"
	ElseIf actSubType = 7 Then 
		getSubTypeCaption = "Left Message"
	ElseIf actSubType = 8 Then 
		getSubTypeCaption = "Sales Report"
	End if

End Function

Function RenderFruitationCategories(conDb, strID, intSelectedIndex, strOnChangeHandler, strFirstItemCaption)
	
	Dim rstCategories								' As ADODB.Recordset
	Dim returnHTML									' As String
	
	returnHTML = ""
	Set rstCategories = Server.CreateObject("ADODB.Recordset")
	rstCategories.Open "FruitationGetCategories", conDb, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
	If Not rstCategories.EOF Then
	
		returnHTML = returnHTML &	"<select id='" & strID & "' name=" & strID & " onChange='javascript:try{" & strOnChangeHandler & "}catch(ex){}'><option value='0' "
		
		If intSelectedIndex = 0 Then 
			returnHTML = returnHTML &	" selected "
		End If
		returnHTML = returnHTML &	" >" & strFirstItemCaption & "</option>"
		
		While Not rstCategories.EOF
			
			returnHTML = returnHTML &	"<option value='" & rstCategories("ID").Value & "' " 
			
			If intSelectedIndex = CInt(rstCategories("ID").Value) Then 
				returnHTML = returnHTML &	" selected "
			End If
			
			returnHTML = returnHTML &	">" & rstCategories("Name").Value & "</option>"
			
			rstCategories.MoveNext
		Wend
		returnHTML = returnHTML &	"</select>"
		
	End If
	rstCategories.Close
	Set rstCategories = Nothing

	RenderFruitationCategories = returnHTML

End Function

Function getSubStatusCaption(intSubStatus)
   Select Case intSubStatus
	 		  Case 1
						getSubStatusCaption = "PL"
	 		  Case 2
						getSubStatusCaption = "LS"
	 		  Case 3
						getSubStatusCaption = "UC"
	 		  Case 4
						getSubStatusCaption = "PO"
	 		  Case 5
						getSubStatusCaption = "GO"
	 End Select
End Function

%>