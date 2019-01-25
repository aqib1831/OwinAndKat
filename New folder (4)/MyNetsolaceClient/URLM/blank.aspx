
<% 
'*******************************************************************************************************
'*		Page Description:  This page is blank page and is used for holding pages for Dialogs
'*		Input Parameter:   Form variables														       
'*		Developer Name:    Rana Khuram
'*		Date:			   			 12/19/2005																   
'*		Change History														                           
'*			Developer:														                           
'*			Date:															                           
'*			Change:															                           
'*******************************************************************************************************


Response.Expires=0

%>


<head>
<title><%= Request.QueryString("PageTitle") %></title>
</head>

<body topmargin="0" leftmargin="0" Scroll="No">
    <iframe src="<%=Request("Page")%>.asp?<%=Request.QueryString%>&<%=Request.Form%>" width="100%" height="100%" Frameborder="0" id="FrameBlank" Name="FrameBlank"></iframe>
</body>