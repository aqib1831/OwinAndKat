<%


' *****************************************************************************
' *****************************************************************************
' * EBAXML ASP Library v2.0
' *****************************************************************************
' *****************************************************************************

	dim EBA_Converter
	dim EBA_updategramRecords
	dim EBA_GetHandlerArray()
	dim EBA_GetHandlerFields
	EBA_GetHandlerFields = 0
	dim EBA_GetHandlerFieldNames(1000)


' *****************************************************************************
' * function EBAGetHandler_HTMLEncode(YourString)
' *****************************************************************************
Function EBAGetHandler_HTMLEncode(YourString)
  If Not IsNull(YourString) then
    EBAGetHandler_HTMLEncode=YourString'Server.HTMLEncode(YourString)
  else 
    EBAGetHandler_HTMLEncode=""
  end if
End function


' *****************************************************************************
' * function EBAGetHandler_PreceedingZero(YourNumber)
' *****************************************************************************
function EBAGetHandler_PreceedingZero(YourNumber)
	dim ResultString
	ResultString = ""

	if round(cdbl(YourNumber)) > 9 then
		ResultString = cstr(YourNumber)
	else
		ResultString = "0" & cstr(YourNumber)
	end if

	EBAGetHandler_PreceedingZero = ResultString
end function



' *****************************************************************************
' * function EBAGetHandler_ConvertDate(AspDateVar)
' *****************************************************************************
function EBAGetHandler_ConvertDate(AspDateVar)
	dim ResultString
	ResultString = ""

	if day(AspDateVar) > 0 then
	else
		AspDateVar = ""
		AspDateVar = Now()
	end if


	ResultString = year(AspDateVar) & "-" & EBAGetHandler_PreceedingZero(month(AspDateVar)) & "-" & EBAGetHandler_PreceedingZero(day(AspDateVar)) & " " & EBAGetHandler_PreceedingZero(hour(AspDateVar)) & ":" & EBAGetHandler_PreceedingZero(minute(AspDateVar)) & ":" & EBAGetHandler_PreceedingZero(second(AspDateVar))

	EBAGetHandler_ConvertDate = ResultString
end function





' *****************************************************************************
' * function EBAGetHandler_DefineRecordFieldValue(ColumnName, FieldValue)
' *****************************************************************************
function EBAGetHandler_DefineRecordFieldValue(ColumnName, FieldValue)
	dim iLoop

	dim ColumnNumber
	
	for iLoop = 0 to EBA_GetHandlerFields
		if strcomp(lcase(ColumnName),lcase(EBA_GetHandlerFieldNames(iLoop))) = 0 then
			ColumnNumber = iLoop
		end if
	next
	

	EBA_GetHandlerArray(ColumnNumber) = EBAGetHandler_HTMLEncode(FieldValue)
	
end function




' *****************************************************************************
' * function EBAGetHandler_CreateNewRecord(IndexFieldValue)
' *****************************************************************************
function EBAGetHandler_CreateNewRecord(IndexFieldValue)
	
	ReDim EBA_GetHandlerArray(EBA_GetHandlerFields+1)
	
	dim CreateRecordLoop
	for CreateRecordLoop = 0 to EBA_GetHandlerFields-1
		EBA_GetHandlerArray(CreateRecordLoop) = ""
	next
	
	EBA_GetHandlerArray(0) = IndexFieldValue
	
end function




' *****************************************************************************
' * function EBAGetHandler_SaveRecord()
' *****************************************************************************
function EBAGetHandler_SaveRecord()
	
	EBA_Converter.AddRecord(EBA_GetHandlerArray)
	
end function



' *****************************************************************************
' * function EBASaveHandler_ReturnColumnCount()
' *****************************************************************************
function EBASaveHandler_ReturnColumnCount()

	dim ResultColumnCount

	ResultColumnCount = 0
	
	dim EBALoop
	
	ResultColumnCount = ubound(EBA_updategramRecords(0).Values)+1
	
	for EBALoop = 0 to ubound(EBA_updategramRecords)-1
		
		' The user inserted or updated.
		if (EBA_updategramRecords(EBALoop).EBAType="insert") or (EBA_updategramRecords(EBALoop).EBAType="update") then
			
			if (ubound(EBA_updategramRecords(EBALoop).Values)+1) > ResultColumnCount then
				ResultColumnCount = ubound(EBA_updategramRecords(EBALoop).Values)+1		
			end if
		end if
	next
	
	
	
	EBASaveHandler_ReturnColumnCount = ResultColumnCount

end function




' *****************************************************************************
' * function EBASaveHandler_ReturnInsertCount()
' *****************************************************************************
function EBASaveHandler_ReturnInsertCount()

	dim ReturnInsertCountResponse
	ReturnInsertCountResponse = 0
	
	dim ReturnInsertCountLoop
	ReturnInsertCountLoop = 0
	
	for ReturnInsertCountLoop = 0 to ubound(EBA_updategramRecords)-1
		
		' The user inserted or updated.
		if (EBA_updategramRecords(ReturnInsertCountLoop).EBAType="insert") then
			ReturnInsertCountResponse = ReturnInsertCountResponse + 1
		end if
	next
	
	EBASaveHandler_ReturnInsertCount = ReturnInsertCountResponse

end function




' *****************************************************************************
' * function EBASaveHandler_ReturnUpdateCount()
' *****************************************************************************
function EBASaveHandler_ReturnUpdateCount()

	dim ReturnupdateCountResponse
	ReturnupdateCountResponse = 0
	
	dim ReturnupdateCountLoop
	ReturnupdateCountLoop = 0
	
	for ReturnupdateCountLoop = 0 to ubound(EBA_updategramRecords)-1
		
		' The user updateed or updated.
		if (EBA_updategramRecords(ReturnupdateCountLoop).EBAType="update") then
			ReturnupdateCountResponse = ReturnupdateCountResponse + 1
		end if
	next
	
	EBASaveHandler_ReturnUpdateCount = ReturnupdateCountResponse

end function




' *****************************************************************************
' * function EBASaveHandler_ReturnDeleteCount()
' *****************************************************************************
function EBASaveHandler_ReturnDeleteCount()

	dim ReturndeleteCountResponse
	ReturndeleteCountResponse = 0
	
	dim ReturndeleteCountLoop
	ReturndeleteCountLoop = 0
	
	for ReturndeleteCountLoop = 0 to ubound(EBA_updategramRecords)-1
		
		' The user deleteed or updated.
		if (EBA_updategramRecords(ReturndeleteCountLoop).EBAType="delete") then
			ReturndeleteCountResponse = ReturndeleteCountResponse + 1
		end if
	next
	
	EBASaveHandler_ReturnDeleteCount = ReturndeleteCountResponse

end function





' *****************************************************************************
' * function EBAGetHandler_DefineField(FieldName)
' *****************************************************************************
function EBAGetHandler_DefineField(FieldName)

	EBA_Converter.AddField(FieldName)
	EBA_GetHandlerFieldNames(EBA_GetHandlerFields) = FieldName
	EBA_GetHandlerFields = EBA_GetHandlerFields + 1
	
end function






' *****************************************************************************
' * function EBAGetHandler_ProcessRecords()
' *****************************************************************************
function EBAGetHandler_ProcessRecords()

	Response.ContentType="text/xml"
	Response.Expires=0
	Response.Buffer = true
	Response.Clear()
	
	dim iLoop
	
	for iLoop = 0 to 999
		EBA_GetHandlerFieldNames(iLoop) = ""
	next
	
	' Get the updategram and convert it.
	Set EBA_Converter = new EBAXMLConverter
	EBA_Converter.Initialize()

	EBA_Converter.KeyFieldName = "key"
	

	EBAGetHandler_DefineField("key")

end function





' *****************************************************************************
' * function EBASaveHandler_ProcessRecords()
' *****************************************************************************
function EBASaveHandler_ProcessRecords()

	' Get the updategram and convert it.
	Set EBA_Converter = new EBAXMLConverter
	EBA_Converter.Initialize()
	EBA_Converter.SetEBAXMLFromUrl(Request)

	
	' Get the updategram records and process them.
	EBA_updategramRecords = EBA_Converter.GetRecords()


end function







' *****************************************************************************
' * function EBASaveHandler_CompleteSave()
' *****************************************************************************
function EBASaveHandler_CompleteSave()

	Response.ContentType="text/xml"
	Response.Expires=0
	Response.Buffer = true
	Response.Clear()

	dim ReturnCompleteSaveLoop
	ReturnCompleteSaveLoop = 0

	Response.Write("<root>")

	for ReturnCompleteSaveLoop = 0 to ubound(EBA_updategramRecords)-1
		Response.Write(EBA_updategramRecords(ReturnCompleteSaveLoop).xml)
	next
	
	Response.Write("</root>")

end function






' *****************************************************************************
' * function EBAGetHandler_CompleteGet()
' *****************************************************************************
function EBAGetHandler_CompleteGet()

	EBA_Converter.WriteEBAXML()

end function









' *****************************************************************************
' * function EBASaveHandler_ReturnInsertField(RecordNumber, DataColumn)
' *****************************************************************************
function EBASaveHandler_ReturnInsertField(RecordNumber, DataColumn)

	dim ReturnInsertResponse
	ReturnInsertResponse = ""
	
	dim ReturnInsertCountLoop
	ReturnInsertCountLoop = 0
	
	dim CurrentInsertRecord
	CurrentInsertRecord = 0
	
	dim values
	
	for ReturnInsertCountLoop = 0 to ubound(EBA_updategramRecords)-1
		
		' The user inserted or updated.
		if (EBA_updategramRecords(ReturnInsertCountLoop).EBAType="insert") then
			
			
			if cdbl(CurrentInsertRecord) = cdbl(RecordNumber) then
				
				if cint(DataColumn) = 0 then
					ReturnInsertResponse = EBA_updategramRecords(ReturnInsertCountLoop).Key
				else
					values = EBA_updategramRecords(ReturnInsertCountLoop).Values
					ReturnInsertResponse = values(cint(DataColumn)-1)
				end if
				

			end if
			
			CurrentInsertRecord = CurrentInsertRecord + 1
		end if
	next
	
	EBASaveHandler_ReturnInsertField = ReturnInsertResponse

end function









' *****************************************************************************
' * function EBASaveHandler_ReturnUpdateField(RecordNumber, DataColumn)
' *****************************************************************************
function EBASaveHandler_ReturnUpdateField(RecordNumber, DataColumn)

	dim ReturnUpdateResponse
	ReturnUpdateResponse = ""
	
	dim ReturnUpdateCountLoop
	ReturnUpdateCountLoop = 0
	
	dim CurrentUpdateRecord
	CurrentUpdateRecord = 0
	
	dim values
	
	for ReturnUpdateCountLoop = 0 to ubound(EBA_updategramRecords)-1
		
		' The user updateed or updated.
		if (EBA_updategramRecords(ReturnUpdateCountLoop).EBAType="update") then
			
			
			if cdbl(CurrentUpdateRecord) = cdbl(RecordNumber) then
				
				if cint(DataColumn) = 0 then
					ReturnUpdateResponse = EBA_updategramRecords(ReturnUpdateCountLoop).Key
				else
					values = EBA_updategramRecords(ReturnUpdateCountLoop).Values
					ReturnUpdateResponse = values(cint(DataColumn)-1)
				end if
				

			end if
			
			CurrentUpdateRecord = CurrentUpdateRecord + 1
		end if
	next
	
	EBASaveHandler_ReturnUpdateField = ReturnUpdateResponse

end function







' *****************************************************************************
' * function EBASaveHandler_ReturnDeleteField(RecordNumber)
' *****************************************************************************
function EBASaveHandler_ReturnDeleteField(RecordNumber)

	dim ReturnDeleteResponse
	ReturnDeleteResponse = ""
	
	dim ReturnDeleteCountLoop
	ReturnDeleteCountLoop = 0
	
	dim CurrentDeleteRecord
	CurrentDeleteRecord = 0
	
	dim values
	
	for ReturnDeleteCountLoop = 0 to ubound(EBA_updategramRecords)-1
		
		' The user deleteed or deleted.
		if (EBA_updategramRecords(ReturnDeleteCountLoop).EBAType="delete") then
			
			
			if cdbl(CurrentDeleteRecord) = cdbl(RecordNumber) then
				
				ReturnDeleteResponse = EBA_updategramRecords(ReturnDeleteCountLoop).Key

			end if
			
			CurrentDeleteRecord = CurrentDeleteRecord + 1
		end if
	next
	
	EBASaveHandler_ReturnDeleteField = ReturnDeleteResponse

end function










' *****************************************************************************
' *****************************************************************************
' * EBAXMLRecord
' *****************************************************************************
' <class name='EBAXMLRecord'>
' <summary>
' A class that stores a record from an EBAXML document. The class stores records
' that are ob variable size.
' </summary>
Class EBAXMLRecord
	private m_Key
	private m_Values
	private m_EBAType
	private m_XML
	
	' <property name="Key" type="string" access="public" readwrite="readwrite">
	' <summary>
	' The record key.
	' </summary>
	' </property>
	Public Property Get Key()
   	 	Key = m_Key
	End Property
	
	Public Property Let Key(p_Key)
	    m_Key = p_Key
	End Property
	
	' <property name="Values" type="array" access="public" readwrite="readwrite">
	' <summary>
	' An array of the values in the record. Does not include the key value.
	' This array can be any length.
	' </summary>
	' </property>
	Public Property Get Values()
   	 	Values = m_Values
	End Property
	
	Public Property Let Values(p_Values)
	    m_Values = p_Values
	End Property
	
	' <property name="EBAType" type="string" access="public" readwrite="readwrite">
	' <summary>
	' The kind of record in the EBA Compressed XML: insert, update, delete, or e.
	' </summary>
	' </property>
	Public Property Get EBAType()
   	 	EBAType = m_EBAType
	End Property
	
	Public Property Let EBAType(p_EBAType)
	    m_EBAType = p_EBAType
	End Property
	
	' <property name="XML" type="string" access="public" readwrite="readwrite">
	' <summary>
	' The XML representation of the row.
	' </summary>
	' </property>
	Public Property Get XML()
   	 	XML = m_XML
	End Property
	
	Public Property Let XML(p_XML)
	    m_XML = p_XML
	End Property
	
End Class
'</class>

' *****************************************************************************
' *****************************************************************************
' * EBAXMLConverter
' *****************************************************************************
' <class name='EBAXMLConverter'>
' <summary>
' A class that converts data into EBA Compressed XML and back. Note: you can only
' go in one direction at a time. That is, you can only use this to convert blocks
' of records/xml at a time. You cannot convert XML, add more records, and convert
' it back.
' </summary>
Class EBAXMLConverter

	Private m_Xml
	Private m_FieldNames()
	Private m_NumFields
	Private m_KeyFieldName
	Private m_RecordsXml
	Private m_Records() 

	' *****************************************************************************
	' * Function Initialize
	' *****************************************************************************
	' <function name="Initialize" access="public">
	' <summary>Initializes the object. Call this before anything else.</summary>
	' <remarks></remarks>
	' </function>
	Public Function Initialize()
		m_NumFields=0
	End Function
	
	' *****************************************************************************
	' * Function AddField
	' *****************************************************************************
	' <function name="AddField" access="public">
	' <summary>Specifies the name of the next column in the data you are converting.
	' </summary>
	' <param name="FieldName" type="string" >The name of the field.</param>
	' <remarks></remarks>
	' </function>
	Public Function AddField(FieldName)
		Dim NewIndex 
		m_NumFields = m_NumFields + 1
		Redim Preserve m_FieldNames(m_NumFields)
		m_FieldNames(m_NumFields-1) = FieldName	
	End Function
	
	' *****************************************************************************
	' * Function ClearFields
	' *****************************************************************************
	' <function name="ClearFields" access="public">
	' <summary>Clears all the field names.</summary>
	' <remarks></remarks>
	' </function>
	Public Function ClearFields()
		m_NumFields=0
		Redim m_FieldNames(m_NumFields)
	End Function
	
	' *****************************************************************************
	' * Function EncodeXMLString
	' *****************************************************************************
	' <function name="EncodeXMLString" access="private">
	' <summary>Encodes a string translating any illegal XML characters.</summary>
	' <param name="str" type="string" >The string to encode. Remains unchanged.</param>
	' <returns type="string">The encoded string</returns>
	' </function>
	Private Function EncodeXMLString(str)
		'Encode the following 
		'quote (") &quot; 
		'ampersand (&) &amp; 
		'less than (<) &lt; 
		'greater than (>) &gt; 
		Dim newStr
		newStr = str
		if not (isnull(str) or str="") then
			newStr = Replace(newStr,"&", "&amp;") ' Make sure to replace this first.
			newStr = Replace(newStr, """", "&quot;")
			newStr = Replace(newStr, "<", "&lt;")
			newStr = Replace(newStr, ">", "&gt;")
			newStr = Replace(newStr, chr(10), "&#10;")
			newStr = Replace(newStr, chr(13), "&#13;")
			newStr = Replace(newStr, chr(9), "&#9;")
			newStr = Replace(newStr, chr(32), "&#32;")
		end if 
		EncodeXMLString = newStr
	End Function
	
	' <property name="KeyFieldName" type="string" access="public" readwrite="readwrite">
	' <summary>The name of the field that is the key field.
	' </summary>
	' <remarks>
	' </remarks>
	' </property>
	Public Property Get KeyFieldName()
   	 	KeyFieldName = m_KeyFieldName
	End Property
	
	Public Property Let KeyFieldName(p_KeyFieldName)
	    m_KeyFieldName = p_KeyFieldName
	End Property 
		
	' *****************************************************************************
	' * Function AddRecord
	' *****************************************************************************
	' <function name="AddRecord" access="public">
	' <summary>Adds a record to be converted.</summary>
	' <param name="Values" type="array" >An array of values. The number of values in the 
	' array must be equal to the number of fields you have added.</param>
	' <remarks></remarks>
	' </function>
	Public Function AddRecord(Values)
		AddRecordWithType "e",Values
	End Function
	
	
	' *****************************************************************************
	' * Function GetColumnIndexLetter
	' *****************************************************************************
	' <function name="GetColumnIndexLetter" access="public">
	' <summary>
	' Returns a column letter for a column index. EG 0=a 1=b 26=aa etc
	' </summary>
	' <param name="ColumnIndex" type="int" >The column index</param>
	' <remarks></remarks>
	' <example>
	' <code>
	' </code>
	' </example>
	' <returns type="string"></returns>
	' </function>
	Private Function GetColumnIndexLetter(ColumnIndex)
		Dim ColumnIndexLetter
		if (ColumnIndex > 25) then
			' After z comes aa then ab and so on until zz, which is the limit.
			ColumnIndexLetter= chr((ColumnIndex \ 26) + 96) & chr((ColumnIndex mod 26) + 97)
		else
			ColumnIndexLetter= chr(ColumnIndex+97)
		end if
		GetColumnIndexLetter=ColumnIndexLetter
	End Function
	
	' *****************************************************************************
	' * Function AddRecordWithName
	' *****************************************************************************
	' <function name="AddRecordWithType" access="public">
	' <summary>Adds a record to the XML. The type of the record is the XML tag name, e.g. update, insert, e</summary>
	' <param name="EBARecordType" type="string" >The type of the record.</param>
	' <param name="Values" type="string" >An array of values. The number of values in the 
	' array must be equal to the number of fields you have added.</param>
	' <remarks></remarks>
	' </function>
	Public Function AddRecordWithType(EBARecordType, Values)
		Dim keyFieldIndex, i, s, columnIndex, j, ColumnIndexLetter, attributeName
		
		' Find the index of the key field.
		keyFieldIndex=0
		for i = 0 to m_NumFields-1
			if (m_FieldNames(i) = m_KeyFieldName) then  keyFieldIndex=i
		next
		
		' Build the record xml.
		s = s & "<" & EBARecordType & " "
		columnIndex=0
		' Loop through the fields and fill in the values.
		for j = 0 to m_NumFields-1
			if (j = keyFieldIndex) then
				s = s & "xk=""" & Values(j) & """ "
			else
				attributeName = GetColumnIndexLetter(columnIndex)
				s = s & attributeName & "=""" & EncodeXMLString(Values(j)) & """ "
				columnIndex = columnIndex + 1
			end if
		next
		s = s & " />"
		m_RecordsXml = m_RecordsXml & s
	End Function
	
	' *****************************************************************************
	' * Function GetRecord
	' *****************************************************************************
	' <function name="GetRecord" access="public">
	' <summary></summary>
	' <param name="Index" type="int" >The index of the record you want</param>
	' <remarks></remarks>
	' <returns type="EBAXMLRecord">The record.</returns>
	' </function>
	Public Function GetRecord(Index)
		if (Index > ubound(m_Records)) then
			Err.Raise 65536, "EBAXMLConverter.GetRecord", "Invalid Record Index"
		else
			GetRecord = m_Records(Index)
		end if
	End Function
	
	' *****************************************************************************
	' * Function GetRecords
	' *****************************************************************************
	' <function name="GetRecords" access="public">
	' <summary>Records all the records</summary>
	' <returns type="array">An array of EBAXMLRecord objects</returns>
	' </function>
	Public Function GetRecords()
		GetRecords = m_Records
	End Function
	
	' *****************************************************************************
	' * Function GetEBAXML
	' *****************************************************************************
	' <function name="GetEBAXML" access="public">
	' <summary>Returns EBA compressed XML based on the fields and records you've added.
	' </summary>
	' <returns type="string">EBA Compressed XML</returns>
	' </function>
	Public Function GetEBAXML()
		Dim s, pipe, i
		s = "<?xml version='1.0' encoding='UTF-8'?>"
		s = "<root fields="""
		pipe = ""
		
		' Find the index of the key field.
		Dim keyFieldIndex
		keyFieldIndex=0
		for i = 0 to m_NumFields-1
			if (m_FieldNames(i) = m_KeyFieldName) then  keyFieldIndex=i
		next
		
		' Write out the fields and keys attributes
		' During this, find out the index of the key field.
		Dim fields 
		fields = ""
		for i = 0 to m_NumFields-1
			if (keyFieldIndex <> i) then
				fields = fields & pipe & m_FieldNames(i) 
				pipe = "|"
			end if
		next
		fields = EncodeXMLString(fields)
		s = s & fields & """ keys=""" & fields & """>"
		
		s = s & m_RecordsXml
		
		s = s & "</root>"
		m_Xml = s
		GetEBAXML = m_Xml
	End Function
	
	' *****************************************************************************
	' * Function SetEBAXML
	' *****************************************************************************
	' <function name="SetEBAXML" access="public">
	' <summary>Set the Compressed EBA XML you want to convert. Use GetRecord and GetRecords
	' to retrieve the data.
	' </summary>
	' <param name="XMLString" type="string" >Valid compressed EBA XML</param>
	' </function>
	Public Function SetEBAXML(XMLString)
		Dim xmlDoc, records, i, ColumnIndex, value
		m_Xml=XMLString
		set xmlDoc = Server.CreateObject("Microsoft.XMLDOM")
    	xmlDoc.async = false
    	xmlDoc.loadXML (XMLString)
    	set records = xmlDoc.documentElement.childNodes
    	Redim m_Records(records.length) 
    	Dim values()
		for i = 0 to records.length-1
			Set m_Records(i) = new EBAXMLRecord
			m_Records(i).EBAType = records(i).tagName
			m_Records(i).Key = records(i).getAttribute("xk")
			m_Records(i).XML = records(i).xml
			dim done
			done = false
			columnIndex=0
			do 
				value = records(i).getAttribute(GetColumnIndexLetter(columnIndex))
				if (isNull(value)) then
					done = true
				else
					value = Replace(value, "&quot;", """")
					Redim Preserve values(columnIndex)
					values(columnIndex) = value
					columnIndex = columnIndex + 1
				end if
			Loop until done
			m_Records(i).Values = values
		next
	End Function
	
	' *****************************************************************************
	' * Function SetEBAXMLFromURL
	' *****************************************************************************
	' <function name="SetEBAXMLFromURL" access="public">
	' <summary>Set the Compressed EBA XML you want to convert from an URL. Use GetRecord and GetRecords
	' to retrieve the data.
	' </summary>
	' <param name="XMLSource" type="string" >A string containing a URL that specifies the location of the XML file.</param>
	' </function>
	Public Function SetEBAXMLFromURL(XMLSource)
		Dim xmlDoc
		Set xmlDoc = Server.CreateObject("Microsoft.XMLDOM")
	    xmlDoc.async = false
	    xmlDoc.load (XMLSource)
	    SetEBAXML(xmlDoc.xml)
	End Function
	
	' *****************************************************************************
	' * Function WriteEBAXML
	' *****************************************************************************
	' <function name="WriteEBAXML" access="public">
	' <summary>Writes out EBA compressed XML to the page.</summary>
	' <remarks></remarks>
	' </function>
	Public Function WriteEBAXML()
		Response.Expires=0
		Response.Buffer = true
		Response.Clear()
	    Response.ContentType="text/xml"
	    Dim doc
		set doc = Server.CreateObject("Msxml2.DOMDocument.3.0")
		doc.async = false
		doc.loadXML(GetEBAXML())
	
		' ASP cant process some symbols found in other languages so use the XML object to
		' write the output.
		doc.Save(Response)
	End Function

End Class
'</class>

' *****************************************************************************
' *****************************************************************************
' * EBAADOConverter
' *****************************************************************************
' <class name='EBAADOConverter'>
' <summary>
' A class that converts ADO data into EBA Compressed XML. To convert EBA XML
' into a Script structure use EBAXMLConverter.
' </summary>
Class EBAADOConverter

	Private m_KeyFieldName
	
	' <property name="KeyFieldName" type="string" access="public" readwrite="readwrite">
	' <summary>
	' Specifies which field is the key field.
	' </summary>
	' </property>
	Public Property Get KeyFieldName()
   	 	KeyFieldName = m_KeyFieldName
	End Property
	
	Public Property Let KeyFieldName(p_KeyFieldName)
	    m_KeyFieldName = p_KeyFieldName
	End Property 
	
	
	' *****************************************************************************
	' * Function FillRecordSet
	' *****************************************************************************
	' <function name="FillRecordSet" access="public">
	' <summary>Fills an ADO recordset with data.</summary>
	' <param name="SQLQuery" type="string" >A SQL Query.</param>
	' <param name="ConnectionString" type="string" >The string used to connect to the
	' datasource. See the MSDN for details on ADO Connection strings</param>
	' <returns type="RecordSet">The ADO recordset with data.</returns>
	' </function>
	Public Function FillRecordSet(SQLQuery, ConnectionString)
		dim conn, rs
	   	set conn=server.createobject("adodb.connection")
	   	conn.open connectionString
	   	set rs=conn.execute(sqlQuery)
	   	set FillRecordSet=rs
	End Function

	' *****************************************************************************
	' * Function GetEBAXML
	' *****************************************************************************
	' <function name="GetEBAXML" access="public">
	' <summary>Returns a record set as EBA XML. Note: never use Response.Write(GetEBAXML()). 
	' Use WriteEBAXML instead.</summary>
	' <param name="RecordSet" type="ADORecordSet" >The recordset you want to convert.</param>
	' <returns type="string">EBA XML</returns>
	' </function>
	Public Function GetEBAXML(RecordSet)	
		Dim converter, i
		Set converter = new EBAXMLConverter
		
		converter.Initialize()
		
		converter.KeyFieldName = m_KeyFieldName
		for i = 0 to RecordSet.fields.count-1
			converter.AddField(RecordSet.fields(i).name)
		next
		
		' Loop through all the records and create the compressed xml entries.
		do while not recordSet.eof
			converter.AddRecord(RecordSet)
			RecordSet.movenext
		loop
		
		GetEBAXML = converter.GetEBAXML()
	End Function
	
	' *****************************************************************************
	' * Function WriteEBAXML
	' *****************************************************************************
	' <function name="WriteEBAXML" access="public">
	' <summary>Writes out EBA XML given a recordset.</summary>
	' <param name="RecordSet" type="ADORecordSet" >The RecordSet</param>
	' </function>
	Public Function WriteEBAXML(RecordSet)
		Response.Expires=0
		Response.Buffer = true
		Response.Clear()
	    Response.ContentType="text/xml"
		
	    Dim doc
		set doc = Server.CreateObject("Msxml2.DOMDocument.3.0")
		doc.async = false
		doc.loadXML(GetEBAXML(RecordSet))
	
		' ASP cant process some symbols found in other languages so use the XML object to
		' write the output.
		doc.Save(Response)
	End Function
End Class
'</class>
%>
