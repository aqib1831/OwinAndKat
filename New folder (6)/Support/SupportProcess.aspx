<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportProcess.aspx.vb" Inherits="Support_SupportProcess" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Process Billing</title>
    <script language="javascript" type="text/javascript" src="../scripts/functions.js"></script>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />  
    <style type="text/css">
    .HeaderRow td
    {
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        font-weight:bold;
        border-bottom:solid 5px #649AD2;
        border-top:solid 2px #649AD2;
    }
    .ItemRow td
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
        padding-right:1px;
        border-right:solid 1px #B7CFE2;
    }
   .ItemRowImg td
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
    }
    .ItemRowImgAlter td
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
        padding-right:1px;
    }
    .ReportName
    {
        FONT-WEIGHT: bold;
        FONT-SIZE: 14pt;
        FONT-FAMILY: Arial
    }
    .CompanyName
    {
        FONT-WEIGHT: bold;
        FONT-SIZE: 12pt;
        FONT-FAMILY: Arial
    }
    .GeneratedOn
    {
        FONT-WEIGHT: bold;
        FONT-SIZE: 9pt;
        FONT-FAMILY: Arial;
    }
    .TableHeading
    {
	    border-top:solid 1px #B7CFE2;
	    border-bottom:solid 1px #B7CFE2;
	    text-decoration:none;
	    text-align:left;
	    color:#000000;
	    padding:2 2 2 4px;
	    font-weight:lighter;
	    background-color:#ffffff;
	    font-size:11px;
	    border-right:solid 1px #B7CFE2;
    }
    .BoldRight
    {
        font-weight:bold;
        text-align:right;
    }
    </style> 
</head>
<body style="font-family:Arial;" >
   <form id="form1" runat="server">
    <asp:UpdateProgress ID="uProgIdeaNotes" runat="server">
        <ProgressTemplate>        
        <div class="ProgressIndicatorDivGray">                            
            <br />
            <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
            <br /><br />
        </div>
     </ProgressTemplate>
    </asp:UpdateProgress>
   <div>
   <asp:Label ID="hdnReportID" runat="server" Text="" style="display:none;" ></asp:Label>
   <asp:Label ID="hdnReportDate" runat="server" Text="" style="display:none;" ></asp:Label>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border ="0">                            
                    <tr>
                        <td style="border:0px;height:25;border-bottom:solid 1px #71AF89;" valign="top">
                        <table style="padding:5px; font-size:13px;filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#ffffff,endColorStr=#F7BB0F); margin: 0px; border: 0px; height:100%;" cellpadding="0" cellspacing="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <b>Process Billing<asp:Label ID="lbltitle" runat="server" ></asp:Label> 
                                    <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
                                        <ContentTemplate>
                                           <span style="font-weight:bold;font-size:11pt;;">-</span> <asp:Literal ID="ltrlRecordCount" runat="server" Text="0" ></asp:Literal>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                    </b>
                                </td>
                                <td align="right" >
                                </td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                      <tr  style="height:41px;">
                        <td valign="middle" colspan="2">
                            <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
    	                    <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" class="gvwSearchSilver">
        	                    <tr>
        	                        <td style="padding-left:3px;">
                                        &nbsp;
                                    </td>
                                    <td >
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="2" >
                                                 <span style="font-size:10px;">Clients:</span><br />	        
                                                    <asp:DropDownList ID="ddlClient" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true"
                                                        DataSourceID="sdsClients" DataTextField="Name" DataValueField="ID"> 
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="sdsClients" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="Clients_GetByBillingReport" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  ></asp:SqlDataSource>
					                            </td>
					                        </tr>
					                    </table>   
                                    </td>
                                    <td style="padding-right:5px;padding-left:5px;">
                                        <div class="straightline"></div>
                                    </td>
                                    <td >
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="2" >
                                                 <span style="font-size:10px;">Country:</span><br />
                                                 <asp:UpdatePanel ID="updatepanelCountry" runat="server" UpdateMode="Conditional">
                                                  <ContentTemplate>
                                                    <asp:DropDownList ID="ddlCountry" CssClass="DarkBlackTextSmall" runat="server" Width="150px" AutoPostBack="true"
                                                        DataSourceID="sdsCountries" DataTextField="Name" DataValueField="ID" EnableViewState="true"> 
                                                    </asp:DropDownList>
                                                    <asp:SqlDataSource ID="sdsCountries" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="Countries_GetByClientIDForBillingReport" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                                                     <SelectParameters>
                                                        <asp:ControlParameter Name="ClientID" ControlID="ddlClient" DefaultValue="0" Type="Int32" />
                                                     </SelectParameters>       
                                                    </asp:SqlDataSource>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                    </asp:UpdatePanel>
					                            </td>
					                        </tr>
					                    </table>   
                                    </td>
                                     <td style="padding-right:5px;padding-left:5px;">
                                        <div class="straightline"></div>
                                    </td>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="2" >
                                                 <span style="font-size:10px;">Report For:</span><br />
                                                 <asp:DropDownList ID="ddlReport" 
                                                      CssClass="DarkBlackTextSmall" runat="server" Width="100px" AutoPostBack="true" 
                                                      DataSourceID="SDS_Report" DataTextField="StartDate" DataValueField="ID" DataTextFormatString="{0:MMM yyyy}"  >
                                                 </asp:DropDownList>
                                                 <asp:SqlDataSource ID="SDS_Report" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                      SelectCommand="NS_BillingReport_ForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                                                 </asp:SqlDataSource>
					                            </td>
                                            </tr>
                                        </table>                    	                    
                                    </td>
                                    <td style="padding-right:5px;padding-left:5px;">
                                        <div class="straightline"></div>
                                    </td>
                                    <td>
                                        <table cellpadding="0" cellspacing="0" border="0">
                                            <tr>
                                                <td colspan="2" >
                                                 <span style="font-size:10px;">Products:</span><br />		
                                                 <asp:DropDownList ID="ddlProducts" 
                                                        CssClass="DarkBlackTextSmall" runat="server" Width="180px" AutoPostBack="true" 
                                                        DataSourceID="SDS_Products" DataTextField="TitleAbbreviation" DataValueField="ID" >
                                                 </asp:DropDownList>
                                                 <asp:SqlDataSource ID="SDS_Products" runat="server" ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                                                        SelectCommand="NS_Products_GetForList" SelectCommandType="StoredProcedure" DataSourceMode="DataReader"  >
                                                    <SelectParameters>
                                                        <asp:Parameter Name="Type" DefaultValue="4"  Type="Int32" />
                                                        <asp:Parameter Name="ParentID" DefaultValue="0" Type="Int32" />
                                                    </SelectParameters>
                                                  </asp:SqlDataSource>                         
					                            </td>
                                            </tr>
                                        </table>                    	                    
                                    </td>
                                    <td style="width:40%;">
                                        &nbsp;
                                    </td>            
                                    <td align="right">
                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                                            <tr>
                                                <td style="padding-right:10px;">
                                                  <span style="font-size:10px;">Search:</span><br />
                                                  <asp:TextBox ID="txtSearch" runat="server" style="height:20px;" MaxLength="20"></asp:TextBox>&nbsp;
                                                  <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btnSilver" Width="37px" CausesValidation="false"    />
                                                </td>
                                            </tr>
                                        </table>                	
                                    </td>
                                </tr>
                            </table>
                            </asp:Panel>
                        </td>
                      </tr>
                    <tr>
                        <td style="border:0;" valign="top">
                        <div id="divscroll" style="height:100%; width:100%;overflow-y:auto;">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >         
                          <ContentTemplate>
                           <table id="tbl"  style="width:100%;padding:5px;margin: 0px;	height:100%;" cellpadding="0" cellspacing="0" border="0" width="100%" >
                                <tr id="trHeader" style="height:18px;position:relative;top:expression(eval(this.parentElement.parentElement.parentElement.parentElement.scrollTop));">
                                    <td align="left" style="width:03%;" class="TableHeading"><asp:CheckBox ID="chkSelectAll" runat="server" onclick="CheckAll();" /></td>
                                    <td align="left" style="width:04%;font-weight:lighter;" class="TableHeading">St #</td>
                                    <td align="left" style="width:13%;font-weight:lighter;" class="TableHeading">Store Name</td>
                                    <td align="left" style="width:15%;font-weight:lighter;" class="TableHeading">Products</td>
                                    <td align="left" style="width:09%;font-weight:lighter;" class="TableHeading">From</td>
                                    <td align="left" style="width:09%;font-weight:lighter;" class="TableHeading">To</td>
                                    <td align="left" style="width:10%;font-weight:lighter;" class="TableHeading">Amount</td>
                                    <td align="left" style="width:05%;font-weight:lighter;" class="TableHeading"># NSF</td>
                                    <td align="left" style="width:05%;font-weight:lighter;" class="TableHeading">Fee</td>
                                    <td align="left" style="width:10%;font-weight:lighter;" class="TableHeading">Total</td>
                                </tr>
                                <asp:Repeater ID="rptProducts" runat="server" >
                                    <HeaderTemplate>
                                         <tr style="height:0px;">
                                         <td colspan="10"></td>
                                        </tr>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr style="height:20px;" class="ItemRow">
                                            <td ><asp:CheckBox ID="chkSelected" runat="server" /><asp:Label ID="lblID" runat="server" Text='<%#Eval("ID")%>' Visible="false" ></asp:Label></td>
                                            <td class="BoldRight"><%#Eval("StoreNumber")%>&nbsp;</td>
                                            <td ><%#Eval("StoreNick")%>&nbsp;</td>
                                            <td ><%#Eval("Title")%>&nbsp;</td>
                                            <td ><%#CDate(Eval("BillingFrom")).ToString("MMM dd, yyyy")%>&nbsp;</td>
                                            <td ><%#CDate(Eval("BillingTo")).ToString("MMM dd, yyyy")%>&nbsp;</td>
                                            <td style="background-color:#F0FEE4;text-align:right;"><%#FormatNumber(Eval("BillingAmount"), 2)%>&nbsp;</td>
                                            <td style="background-color:#FFF3EB;text-align:right;">0</td>
                                            <td style="background-color:#FFF3EB;text-align:right;">0</td>
                                            <td class="BoldRight"><%#FormatNumber(Eval("BillingAmount"), 2)%>&nbsp;</td>
                                        </tr>
                                    </ItemTemplate>
                                    <AlternatingItemTemplate> 
                                        <tr style="height:20px;background-color:#F9FAFC;" class="ItemRow">
                                            <td ><asp:CheckBox ID="chkSelected" runat="server" /><asp:Label ID="lblID" runat="server" Text='<%#Eval("ID")%>' Visible="false" ></asp:Label></td>
                                            <td class="BoldRight"><%#Eval("StoreNumber")%>&nbsp;</td>
                                            <td ><%#Eval("StoreNick")%>&nbsp;</td>
                                            <td ><%#Eval("Title")%>&nbsp;</td>
                                            <td ><%#CDate(Eval("BillingFrom")).ToString("MMM dd, yyyy")%>&nbsp;</td>
                                            <td ><%#CDate(Eval("BillingTo")).ToString("MMM dd, yyyy")%>&nbsp;</td>
                                            <td style="background-color:#F0FEE4;text-align:right;"><%#FormatNumber(Eval("BillingAmount"), 2)%>&nbsp;</td>
                                            <td style="background-color:#FFF3EB;text-align:right;">0</td>
                                            <td style="background-color:#FFF3EB;text-align:right;">0</td>
                                            <td class="BoldRight"><%#FormatNumber(Eval("BillingAmount"), 2)%>&nbsp;</td>
                                        </tr>
                                     </AlternatingItemTemplate>
                                    <FooterTemplate>
                                        <tr id="trFooter" runat="server" style="height:100%;" class="ItemRowImg">
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                         <tr id="trNoRecord2" runat="server" style="height:100%;display:none;text-align:center;" class="ItemRowImg">
                                         <td colspan="10">
                                             <table cellpadding="0" cellspacing="0" border="0" style="width:100%;  height:100px; width:300px;border:solid 1px black;" class="MessageUsers">
                                              <tr style="height:100%;">
                                                <td align="right" style="width:10%;vertical-align:middle;">
                                                    <img align="absmiddle" src="../images/ico_alert.gif" />
                                                </td>
                                                <td align="left" style="vertical-align:middle;height:100%;width:90%;padding-left:10px;">
                                                   No Records Founded!
                                                </td>
                                                </tr>
                                              </table>
                                           </td>
                                        </tr>    
                                    </FooterTemplate>
                                </asp:Repeater>
                                <tr id="trNoRecord" runat="server" style="height:100%;text-align:center;" class="ItemRowImg">
                                     <td colspan="10">
                                        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;  height:100px; width:300px;border:solid 1px black;" class="MessageUsers">
                                          <tr style="height:100%;">
                                            <td align="right" style="width:10%;vertical-align:middle;">
                                                <img align="absmiddle" src="../images/ico_alert.gif" />
                                            </td>
                                            <td align="center" style="vertical-align:middle;height:100%;width:90%;">
                                                Please Select Client, Country and Report.
                                            </td>
                                            </tr>
                                          </table>
                                       </td>
                                  </tr>  
                               </table>
                              </ContentTemplate>
                            <Triggers>
                                 <asp:AsyncPostBackTrigger ControlID="ddlClient" EventName="SelectedIndexChanged" />
                                 <asp:AsyncPostBackTrigger ControlID="ddlCountry" EventName="SelectedIndexChanged" />
                                 <asp:AsyncPostBackTrigger ControlID="ddlReport" EventName="SelectedIndexChanged" />
                                 <asp:AsyncPostBackTrigger ControlID="ddlProducts" EventName="SelectedIndexChanged" />
                                 <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />  
                            </Triggers>
                         </asp:UpdatePanel>  
                        </div>        
                        </td>
                    </tr>
                    <tr id="trfooter2" style="height:25px;background-color:#F8F8F8; display:none;" class="ItemRowImg">
                        <td>
                        <table border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%;">
                            <tr>
                                <td style="width:04%;">&nbsp;</td>
                                <td style="width:13%;">&nbsp;</td>
                                <td style="width:15%;">&nbsp;</td>
                                <td style="width:09%;">&nbsp;</td>
                                <td style="width:09%;font-weight:bold;">Total</td>
                                <td class="BoldRight" style="width:10%;"><asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></td>
                                <td class="BoldRight" style="width:05%;">-</td>
                                <td class="BoldRight" style="width:05%;">0</td>
                                <td class="BoldRight" style="width:10%;"><asp:Label ID="lblGrandTotal" runat="server" Text="0"></asp:Label></td>
                                <td style="width:02%;">&nbsp;</td>
                            </tr>
                        </table>
                        </td>
                    </tr>
                    <tr id="trfooter3" style="height:30px;background-color:#E9E9E9;display:none;" class="ItemRow" >
                           <td style="text-align:center;border-top: solid 1px black;">&nbsp;
                                <asp:Button ID="btnProcess" runat="server" Text="Process" CssClass="btnSilver" Width="50px" />&nbsp;
                                <input id="tempprocessbutton" name="tempprocessbutton" type="button" class="btnSilver" style="width:50px;display:none;" disabled="disabled" value="Process" onclick="return false;" />
                                <asp:Button ID="btnCancle" runat="server" Text="Cancel" CssClass="btnSilver" OnClientClick="UnselectChecks(); return false;" Width="50px" />
                                <asp:CustomValidator 
                                        ID="val_chkSelect"
                                        ClientValidationFunction="CheckNumberOfChk"
                                        ErrorMessage=""
                                        runat="server"
                                        Display="Dynamic" >                                                                    
                                  </asp:CustomValidator>
                           </td>
                    </tr>
                  </table>
                
        </div>
   <script language="javascript" type="text/javascript">
        function ShowWhyInActive()
        {
            document.getElementById('divInfo').style.display='inline';
        } 
        function HideWhyInActive()
        {
            document.getElementById('divInfo').style.display='none';
        }
        function CheckAll()
        {
            var value = document.getElementById('<%=chkSelectAll.ClientID%>').checked;
            var allcheckboxes = tbl.getElementsByTagName("INPUT") 
            //alert(allcheckboxes.length);
            for(i=0;i<allcheckboxes.length;i++)
            {
                if (allcheckboxes[i].type == "checkbox")
                {
                    allcheckboxes[i].checked = value;
                }
            }
        }
        function UnselectChecks()
        {
            document.getElementById('<%=chkSelectAll.ClientID%>').checked = false;
            var allcheckboxes = tbl.getElementsByTagName("INPUT") 
            for(i=0;i<allcheckboxes.length;i++)
            {
                if (allcheckboxes[i].type == "checkbox")
                {
                    allcheckboxes[i].checked = false;
                }
            }
        }
        function CheckNumberOfChk(oSrc, args){
            var count = 0;
            var allcheckboxes = tbl.getElementsByTagName("INPUT");
            for(i=0;i<allcheckboxes.length;i++)
            {
                if (allcheckboxes[i].type == "checkbox")
                {
                    if(allcheckboxes[i].checked == true)
                        count = count + 1
                }
            }
            if (count > 0)
            {               
                args.IsValid = true;
                document.getElementById('<%=btnProcess.ClientID%>').style.display = 'none';
                document.getElementById('tempprocessbutton').style.display = 'inline';
            }
            else 
            {
                args.IsValid = false
                alert('Please Select Atleast One Store.');
            }
        }
        function trdisplay(Total,GrandTotal)
        {
            document.getElementById('trfooter3').style.display = 'inline';
            document.getElementById('trfooter2').style.display = 'inline';
            document.getElementById('lblTotal').innerHTML = Total;
            document.getElementById('lblGrandTotal').innerHTML = GrandTotal;
        }
        function trhide()
        {
            document.getElementById('trfooter3').style.display = 'none';
            document.getElementById('trfooter2').style.display = 'none';
        }
   </script>
   </form>
</body>
</html>
