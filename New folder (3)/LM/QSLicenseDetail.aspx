<%@ Page Language="VB" AutoEventWireup="false" CodeFile="QSLicenseDetail.aspx.vb" Theme="Default" Inherits="LM_QsLicenseDetail" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Qs License Detail</title>   
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .tblDetails
            {
	            font-size:12px;
	            font-family:Sans-Serif, Verdana, Arial, Helvetica;
	            padding:5px;	
	            background-color:#EFEFEF;
            }
            .tblTerminals
            {
                font-size:10px;
                font-weight:bold;
	            font-family:Sans-Serif, Verdana, Arial, Helvetica;	            	
	           
            }
    </style>
</head>
<body style="margin:0; padding:0; height:100%;">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
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
    <asp:HiddenField ID="hdnLicienceID" runat="server" />
    <asp:HiddenField runat="server" ID="hdnClientID" Value="0"  />
    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#F2F2F2;height:100%;" class="tblDetails">
    <tr style="height:30px; background-image:url(../images/bg_mainHdr_1.jpg);">
        <th colspan="3" align="left" class="IdeaTitle">Qs License Details</th>
        <th colspan="2" align="right" style="padding:0px;">        
            <div id="divltrlActive" runat="server" style=" width:150px; height:27px;" align="center">
                <table>
                <tr>
                    <td valign="middle" style="border-bottom:0;">
                    <b><asp:Label ID="ltrlActive" runat="server" style="color:White;" ></asp:Label>&nbsp;</b>
                    </td>
                </tr>
                </table>
            </div>
        </th>
    </tr> 
    <tr>
        <td style="width:15%;border-bottom:solid 1px #609BD3;">Store #:</td>
        <td style="width:33%;border-bottom:solid 1px #609BD3;">
           <b><asp:Literal ID="ltrlStoreNick" runat="server"></asp:Literal>-<asp:Literal ID="ltrlStoreNo" runat="server"></asp:Literal>&nbsp;(<asp:Literal ID="ltrlClientName" runat="server"></asp:Literal>)</b></td>
        <td style="width:4%;border-bottom:solid 1px #609BD3;">&nbsp;</td>
        <td style="width:15%;border-bottom:solid 1px #609BD3;">System IP:</td>
        <td style="width:33%;padding:0;padding-right:10px;border-bottom:solid 1px #609BD3;">
             <table cellpadding="0" cellspacing="0" border="0" class="tblDetail" style="width:100%;padding:0px;" >
                <tr>
                    <td style="border-bottom:0"><b><asp:Literal ID="ltrlSystemIP" runat="server"></asp:Literal>&nbsp;</b></td>
                    <td style="border-bottom:0;padding:0;" align="right">
                       <asp:Button ID="btnEdit" runat="server" Text="Edit" CssClass="btnSilver" /></td>
                </tr>
             </table>
        </td>
   </tr>
   <tr>
        <td style="border-bottom:solid 1px #609BD3;">Invoice #:</td>
        <td style="border-bottom:solid 1px #609BD3;"><b><asp:Literal ID="ltrlInvoiceNo" runat="server"></asp:Literal>&nbsp;</b></td>        
        <td style="border-bottom:solid 1px #609BD3;">&nbsp;</td>        
        <td style="border-bottom:solid 1px #609BD3;">Static IP:</td>
        <td style="border-bottom:solid 1px #609BD3;"><b><asp:Literal ID="ltrlStaticIP" runat="server"></asp:Literal>&nbsp;</b></td>        
    </tr>
    <tr>
        <td style="border-bottom:solid 1px #609BD3;">Issued by:</td>
        <td style="border-bottom:solid 1px #609BD3;"><b><asp:Literal ID="ltrlIssuedBy" runat="server"></asp:Literal>&nbsp;</b></td>
        <td style="border-bottom:solid 1px #609BD3;">&nbsp;</td>
        <td style="border-bottom:solid 1px #609BD3;">Last Updated:</td>
        <td style="border-bottom:solid 1px #609BD3;"><b><asp:Literal ID="ltrlUpdatedOn" runat="server"></asp:Literal>&nbsp;</b></td>
        
    </tr>
    <tr>
        <td style="border-bottom:solid 1px #609BD3;"># of Terminals:</td>
        <td style="border-bottom:solid 1px #609BD3;"><asp:UpdatePanel ID="upnlTerminals" runat="server" UpdateMode="Conditional"><ContentTemplate><b><asp:Literal ID="ltrlTerminals" runat="server"></asp:Literal>&nbsp;</b></ContentTemplate></asp:UpdatePanel></td>
        <td style="border-bottom:solid 1px #609BD3;">&nbsp;</td>
        <td style="border-bottom:solid 1px #609BD3;"># of Live Terminals:</td>
        <td style="border-bottom:solid 1px #609BD3;"><b><asp:Literal ID="ltrlLiveTerminals" runat="server"></asp:Literal>&nbsp;</b></td>        
    </tr>
   <tr>
        <td style="border-bottom:0;" valign="top" colspan="5">Notes :</td>        
    </tr>
    <tr>
        <td valign="top" colspan="5" style="border-bottom:0;">
            <div style="height:40px; width:100%; overflow:auto;" class="GrayScrollBar">
                <asp:Literal ID="ltrlNotes" runat="server"></asp:Literal>
            </div>            
        </td>        
    </tr>
    <tr style="height:100%;">
        <td valign="top" colspan="5">
        <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">    
        <asp:UpdatePanel ID="upKeys" runat="server" UpdateMode="Conditional">        
        <ContentTemplate>    
            <asp:GridView ID="gvwQsLicienseTerminal" runat="server" AutoGenerateColumns="False" Width="100%"  SkinID="gvwSilverWithNoPaging"
                  Height="100%" ShowFooter="true" EnableViewState="true" DataSourceID="odQSLicensesManagement">
                <Columns>
                     <asp:TemplateField HeaderText="Terminal">
                        <ItemTemplate>
                             <div align="left" class="tblTerminals"><%#Eval("TerminalName")%></div>
                        </ItemTemplate>                   
                        <HeaderStyle Width="5%" />
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Activation Key">
                        <ItemTemplate>
                            <span title='<%# Eval("GUID_Activation") %>' class="tblTerminals"><%#Eval("GUID_Activation")%></span>                          
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="18%" />
                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Installation Key">
                        <ItemTemplate>
                            <span title='<%# Eval("GUID_Installation") %>' class="tblTerminals"><%#Eval("GUID_Installation")%></span>                            
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="18%" />
                        
                    </asp:TemplateField>  
                    <asp:TemplateField HeaderText="MAC Address">
                        <ItemTemplate>
                        <div title='<%# Functions.DecryptString128Bit(Functions.IfNull(Eval("SystemID"),""), ConfigurationManager.AppSettings("128BitDecryptionKey")) %>' class="tblTerminals StringTruncate"><%# Functions.DecryptString128Bit(Functions.IfNull(Eval("SystemID"),""), ConfigurationManager.AppSettings("128BitDecryptionKey")) %></div>
                        </ItemTemplate>
                        <HeaderStyle Width="12%" />
                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Computer Name">
                        <ItemTemplate>
                        <div title='<%# Eval("SystemName") %>' class="tblTerminals StringTruncate"><%# Eval("SystemName")%></div>
                        </ItemTemplate>
                        <HeaderStyle Width="10%" />
                        
                    </asp:TemplateField>                              
                    <asp:TemplateField HeaderText="Activation">
                        <ItemTemplate>
                        <span title='<%#String.Format("{0:MMM dd, yyyy}", Eval("ActivatedOn")) %>'>
                            <%#Functions.StringTruncate(Functions.IfNull(String.Format("{0:MMM dd, yyyy}", Eval("ActivatedOn")), ""), 6)%>
                            </span>
                        </ItemTemplate>
                        <HeaderStyle Width="7%" />
                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Installation">
                        <ItemTemplate>
                        <span title='<%#String.Format("{0:MMM dd, yyyy}", Eval("InstalledOn")) %>'>
                            <%#Functions.StringTruncate(Functions.IfNull(String.Format("{0:MMM dd, yyyy}", Eval("InstalledOn")), ""), 6)%>
                            </span>
                        </ItemTemplate>
                        <HeaderStyle Width="7%" />
                        
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Sync">
                        <ItemTemplate>
                        <span title='<%#String.Format("{0:MMM dd, yyyy}", Eval("LastTimeSync")) %>'>
                            <div align="right"><%#Functions.StringTruncate(Functions.IfNull(String.Format("{0:MMM dd, yyyy}", Eval("LastTimeSync")), ""), 6)%></div>
                        </span>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        
                        <HeaderStyle Width="7%" />
                    </asp:TemplateField>
                                 
                    <asp:TemplateField HeaderText="Version">
                        <ItemTemplate>
                           <div align="left" title='<%#Eval("CurrentVersion") %>'> <%#Functions.StringTruncate(Functions.IfNull(Eval("CurrentVersion"), ""), 6)%>&nbsp;</div>
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="8%" />
                        
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                           <asp:ImageButton ID="btnRegenerate" runat="server" ToolTip="Regenerate Key" ImageUrl="~/images/Regenerate.gif" OnClientClick='return RegenerateConfirmation();' CommandName="Regenerate" CommandArgument='<%#Eval("ID")%>' />
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="2%" />
                         
                    </asp:TemplateField>
                  <asp:TemplateField>
                        <ItemTemplate>
                           <asp:ImageButton ID="btnInactive" runat="server" ToolTip="Mark Inactive" ImageUrl="~/images/icn_Active.png" CommandName="Active" CommandArgument='<%#Eval("ID")%>'  Visible="false" OnClientClick='return InActiveConfirmation();' /><asp:ImageButton ID="imgbtnActive" runat="server" ImageUrl="~/images/icn_InActive.png" ToolTip="Mark Active" CommandName="InActive" CommandArgument='<%#Eval("ID")%>' OnClientClick='return ActiveConfirmation();' Visible="false" />
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="2%" />
                         
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                           <asp:ImageButton ID="btnDelete" runat="server" ToolTip="Delete License" ImageUrl="~/images/icn_InActive.png" CommandName="DeleteLicense" CommandArgument='<%#Eval("ID")%>'  Visible="true" OnClientClick='return DeleteLicense();' />
                        </ItemTemplate>
                        <FooterTemplate>
                            &nbsp;
                        </FooterTemplate>
                        <HeaderStyle Width="2%" />
                         
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                     <table class="NoRecord">
                        <tr>                            
                            <td>
                                <img align="absmiddle" src="../../images/ico_alert.gif" />&nbsp;&nbsp;No Submissions Found !
                            </td>
                        </tr>
                     </table>                
                </EmptyDataTemplate>            
                <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom" />
                <PagerTemplate>
                    <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>                        
                           <td style="border:0; width:85%;">Showing Licenses <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                           <td style="border:0;" align="right" nowrap="nowrap">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                    </table>
                </PagerTemplate>                       
            </asp:GridView>     
        </ContentTemplate>
        </asp:UpdatePanel>        
        </div>
        <asp:ObjectDataSource ID="odQSLicensesManagement" runat="server" TypeName="Portal.BLL.QsLicenseManagment" 
     SelectMethod="GetAllQsLicensesTerminalByLicienceID">
    <SelectParameters>
        <asp:ControlParameter ControlID="hdnLicienceID" Name="LicenseID"  />
    </SelectParameters>
</asp:ObjectDataSource>
        </td>
    </tr>
    <tr>
        <td style="border-bottom:0;" valign="top" colspan="5"></td>        
    </tr>
    <tr style="height:100%;">
        <td style="border-bottom:0;" valign="top" colspan="5">
            
        </td>        
    </tr>
    <tr style="height:30px; background-color:#dcdcdc;">
        <td colspan="6" style="border-top:solid 1px #609BD3; padding-right:10px; height: 34px;" align="right">
            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btnSilver" />
        </td>
    </tr>
    </table>
    </div>
    <script language="javascript" type="text/javascript">
        function InActiveConfirmation()
        {
            var confrm=confirm('Are you sure you want to inactive this terminal');
            if(confrm)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        function DeleteLicense() {
            var confrm = confirm('Are you sure you want to Delete this license');
            if (confrm) {
                return true;
            }
            else {
                return false;
            }
        }

        function ActiveConfirmation()
        {
            var confrm=confirm('Are you sure you want to active this terminal');
            if(confrm)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
         function RegenerateConfirmation()
        {
            var confrm=confirm('Are you sure you want to regenerate this key');
            if(confrm)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        
    </script>
    </form>
</body>
</html>