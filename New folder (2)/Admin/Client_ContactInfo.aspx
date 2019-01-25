<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Client_ContactInfo.aspx.vb" Inherits="Admin_Client_ContactInfo" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Client Contact Info</title>
     <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
</head>
<body scroll="no" style="margin:0px ; border:0px; padding:5px;">
    <form id="form1" runat="server">
    <table width="100%" height="100%"  border="0" align="center" cellpadding="0" cellspacing="0" class="FranSmallWhileSubTable">
    <tr>
      <td colspan="2" valign="top">
      <div style="width:100%; height:100%; overflow-y:auto; margin:0; padding:0; border:0;" class="ScrollBarHomeTicket">
      <asp:Repeater
        id="rptContacts"        
        Runat="server" DataSourceID="odsClientContacts">        
        <HeaderTemplate>
            <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:0;">
        </HeaderTemplate>        
        <ItemTemplate>        
        <tr>
            <td valign="top" style="border:0px;" >
			 <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0" style="margin:0;">
             <tr>
                 <th align="left">
        		   <img id="imgid<%#Eval("ID")%>" runat="server" src="<%# IIf(Container.ItemIndex = 0, "../images/colapse.gif","../images/expand.gif") %>"  align="absmiddle" style="cursor:pointer;" onclick="ColapseExpand(this, document.getElementById('RowID<%#Eval("ID")%>'));">&nbsp;<%#Eval("FirstName")%> &nbsp;<%#Eval("LastName")%> 
                 </th>
                 <th align="right">                   
                  </th>
              </tr>
              </table>
             </td>
         </tr>
        <tr id="RowID<%#Eval("ID")%>" style="display:<%# IIf(Container.ItemIndex = 0, "inline","none") %>" runat="server" >
            <td style="border:none;">
            <table align="center" width="100%" border="0" cellspacing="0" cellpadding="0" id="tableOwner">  
            <tr>
                 <td style="border-top:0px; padding-top:3px; padding-bottom:3px;" >Job Title :</td>
                 <td style="border-top:0px"><strong><%#Eval("JobTitle")%>&nbsp;</strong></td>
                 <td style="border-top:0px">&nbsp;</td>
                 <td style="border-top:0px">&nbsp;</strong></td>
            </tr>  
             <tr>
                 <td style="width:25%; padding-top:3px; padding-bottom:3px;">First Name :</td>
                 <td style="width:25%; padding-top:3px; padding-bottom:3px;"><strong><%#Eval("FirstName")%>&nbsp;</strong></td>
                 <td style="width:25%; padding-top:3px; padding-bottom:3px;">Middle Name :</td>
                 <td style="width:25%; padding-top:3px; padding-bottom:3px;"><strong><%#Eval("MiddleName")%>&nbsp;</strong></td>
            </tr>                    
            <tr>
                 <td style="padding-top:3px; padding-bottom:3px;">Last Name :</td>
                 <td colspan="3"><strong><%#Eval("LastName")%>&nbsp;</strong></td>
            </tr>
            <tr>
                 <td style="padding-top:3px; padding-bottom:3px;">Address :</td>
                 <td colspan="3"><span title='<%#Eval("Address")%>'><strong><%#Functions.StringTruncate(Eval("Address"), 90)%></strong></span>&nbsp;</strong></td>
            </tr>
            <tr>
                 <td style="padding-top:3px; padding-bottom:3px;">City :</td>
                 <td style="padding-top:3px; padding-bottom:3px;"><strong><%#Eval("City")%>&nbsp;</strong></td>
                 <td>State :</td>
                 <td><strong><%#Eval("State")%>&nbsp;</strong></td>
            </tr>         
            <tr>
                 <td style="padding-top:3px; padding-bottom:3px;">Zip :</td>
                 <td><strong><%#Eval("Zip")%>&nbsp;</strong></td>
                 <td>Country :</td>
                 <td><strong><%#Eval("Country")%>&nbsp;</strong></td>
            </tr>    
            <tr>
                 <td style="padding-top:3px; padding-bottom:3px;">Email1 :</td>
                 <td><strong><a href='mailto:<%#Eval("Email1")%>'><%#Eval("Email1")%></a>&nbsp;</strong></td>                
                 <td>Email2 :</td>
                 <td><strong><a href='mailto:<%#Eval("Email2")%>'><%#Eval("Email2")%></a>&nbsp;</strong></td>                
            </tr>                    
            <tr>
                 <td style="padding-top:3px; padding-bottom:3px;">Home Phone :</td>
                 <td><strong><%#Eval("HomePhone")%>&nbsp;</strong></td>
                 <td>Work Phone :</td>
                 <td><strong><%#Eval("WorkPhone")%>&nbsp;</strong></td>
            </tr>            
            <tr>
                 <td style="padding-top:3px; padding-bottom:3px;">Cell Phone :</td>
                 <td><strong><%#Eval("CellPhone")%>&nbsp;</strong></td>
                <td style="padding-top:3px; padding-bottom:3px;">Fax :</td>
                 <td ><strong><%#Eval("Fax")%>&nbsp;</strong></td>
            </tr>            
            </table>                       
           </td>
          </tr>
        </ItemTemplate>
        <FooterTemplate> 
          </table>
     </FooterTemplate>
     </asp:Repeater>
         <asp:Literal ID="ltlNoRecordsFound" runat="server" Visible="false" Text="<center style='padding-top:4px'><font color='#000000' size='3' face='Arial, Helvetica, sans-serif'>No Record(s) Found!</font> &nbsp; </center> "></asp:Literal>
      <asp:ObjectDataSource ID="odsClientContacts" runat="server" SelectMethod="GetContactsByClientID"
              TypeName="Portal.BLL.Franchises">
              <SelectParameters>
                  <asp:ControlParameter ControlID="hdnClientID" DefaultValue="0" Name="ClientID"
                      PropertyName="Value" Type="Int32" />
              </SelectParameters>
          </asp:ObjectDataSource>
       </div> 
      </td>
	</tr>
</table>
   <asp:HiddenField ID="hdnClientID" Value="0" runat="server" />
    </form>
</body>
</html>
 <script language="javascript" type="text/javascript">
	function ColapseExpand(ImgObj, ContactObj)
	{
	    //To hide all contacts rows 
	    var rows = document.documentElement.getElementsByTagName('tr');		
		for(var i=0; i<= rows.length -1;i++)
		{		
		    if(rows[i].id.toLowerCase().match('rowid')!=null)
		    {
		        document.getElementById(rows[i].id).style.display='none';		        
		    }
		}
		
		//To change the image of all row to expand
		var images = document.documentElement.getElementsByTagName('img');
		for(var i=0; i<= images.length -1;i++)
		{		
		    if(images[i].id.toLowerCase().match('imgid')!=null)
		    {
		        document.getElementById(images[i].id).src='../images/expand.gif';		        
		    }
		}
		
		if(ContactObj.style.display == 'inline')
		{
			ContactObj.style.display = 'none';
			ImgObj.src = "../images/expand.gif";
		}	
		else
		{
			ContactObj.style.display = 'inline';
			ImgObj.src = "../images/colapse.gif";
		}						
	}    
    </script> 
