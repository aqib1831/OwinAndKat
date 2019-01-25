<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Career.aspx.vb" Inherits="HR_Career" Theme="Default" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Career</title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />   
        <script type="text/javascript" language="JavaScript" src="../scripts/jquery-1.7.2.js"></script>
    <script language="javascript" src="../scripts/careerlist.js" type="text/javascript"></script> 
</head>
<body style="margin:0; border:0; height:100%; width:100%;" scroll="no">
<form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:HiddenField ID="hdnAdminId" runat="server" Value="0" />
    <asp:UpdateProgress ID="uProgIdeaNotes" runat="server">
        <ProgressTemplate>
        <table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
          <tr>
            <td valign="middle">
                <div class="ProgressIndicatorDivGray">                            
                <br />
                  <img src="../images/indicator.gif" align="absmiddle" /><b>&nbsp;&nbsp;Loading ...</b>
                <br /><br />                                
                </div>    
            </td>
          </tr>
        </table>
        </ProgressTemplate>
    </asp:UpdateProgress>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;">
  <tr class="GalleryTitle" style="background-image:url('../images/bg_mainHdr_1.jpg');height:31px;">
    <td>&nbsp;<span class="IdeaTitle">Careers - </span> 
    <asp:UpdatePanel ID="upIdeaCount" runat="server" RenderMode="Inline">
        <ContentTemplate>
            <asp:Literal ID="ltrlRecordCount" runat="server" Text="0"></asp:Literal></span>
        </ContentTemplate>
    </asp:UpdatePanel></td>
  </tr>
  <tr  style="height:41px;">
    <td valign="middle">
        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
    	<table width="100%" border="0" cellspacing="0" cellpadding="0" style="height:100%;" >
        	<tr style="background-color:#ebebeb">
            	<td style="width:20%;padding-left:5px;">
            	    <input type="button" value="New Career" class="btnSimple"  style="height:22px;" onClick="window.location = 'Career_New.aspx'" />
               </td>        
                <td  style="width:10%;">
                </td>
                <td style="width:60%;" align="right" valign="middle">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                        <tr>
                            <td  style="font-family:Sans-Serif, arial, verdana, Helvetica; font-size:11px">Country:&nbsp;</td>
                            <td>
                                <asp:DropDownList ID="ddlCountry" runat="server" Width="120px" AutoPostBack="true" CssClass="comboAlbums">                               
                                <asp:ListItem Text="Netsolace Pak" Value="1" Selected="True"  ></asp:ListItem>
                                <asp:ListItem Text="Netsolace USA" Value="2"></asp:ListItem>                                
                                <asp:ListItem Text="Netsolace UAE" Value="3"></asp:ListItem>                               
                                <asp:ListItem Text="Netsolace Atlanta" Value="4"></asp:ListItem>
					        </asp:DropDownList>
                            </td>                            
                        </tr>
                    </table>                	
                </td>
                <td>&nbsp;</td>
                <td align="right">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                        <tr>
                            <td  style="font-family:Sans-Serif, arial, verdana, Helvetica; font-size:11px">Status:&nbsp;</td>
                            <td>
                            <asp:DropDownList ID="ddlStatus" runat="server" Width="120px" AutoPostBack="true" CssClass="comboAlbums">
                                <asp:ListItem Text="Show All" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Active" Value="0" Selected="True"  ></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="1"></asp:ListItem>                                
					        </asp:DropDownList>
					        </td>
                        </tr>
                    </table>    
                </td>
                <td>&nbsp;</td>
                <td align="right" valign="middle">
                    <table cellpadding="0" cellspacing="0" border="0" style="width:100px;">
                        <tr>
                            <td  style="font-family:Sans-Serif, arial, verdana, Helvetica; font-size:11px">Search:&nbsp;</td>
                            <td><asp:TextBox ID="txtSearch" runat="server" Height="20px" CssClass="txtGray" MaxLength="70"></asp:TextBox>&nbsp;</td>
                            <td><asp:ImageButton ID="btnSearch" runat="server" AlternateText="search" ImageUrl="../images/btn_go.gif" ImageAlign="AbsMiddle" OnClientClick="SetDefaultButton();" />&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                    </table>                	
                </td>
            </tr>
        </table>
        </asp:Panel>
    </td>
  </tr>
  <tr style="height:100%;">
    <td valign="top">
    <div id="divScroll" style="height:100%; width:100%; overflow-y:auto;" class="GrayScrollBar">    
    <asp:UpdatePanel ID="upIdeas" runat="server" UpdateMode="Conditional">        
    <ContentTemplate>    
        <asp:GridView ID="gvwIdeas" SkinID="gvwSilver" runat="server" AutoGenerateColumns="False" Width="100%"  HeaderStyle-CssClass="gvwSilverHeader"
            DataSourceID="odsIdeas" AllowPaging="true" AllowSorting="true" Height="100%" ShowFooter="true" EnableViewState="true">
            <Columns>
                <asp:TemplateField HeaderText="Seq" HeaderStyle-Width="10%">
                    <ItemTemplate>
                        <span id="jobId" style="display:none;"><%#Eval("ID")%></span><span id="spnSeqNo"><%#Eval("Sequence")%></span><span id="spnSeqDown" class="seqDownInActive" onclick="onSeqDownClick(this);"></span><span id="spnSeqUp" class="seqUpInActive" onclick="onSeqUpClick(this);"></span>
                    </ItemTemplate>
                    <ItemStyle Width="2%" VerticalAlign="Top" />
                </asp:TemplateField>          
                <asp:TemplateField HeaderText="Job Title" HeaderStyle-Width="60%" SortExpression="JobTitle">
                    <ItemTemplate>
                      <span title='<%#Eval("JobTitle")%>' ><%#Functions.StringTruncate(Eval("JobTitle"), 50)%></span>
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                </asp:TemplateField>
                
                  <asp:TemplateField HeaderText="Location" HeaderStyle-Width="15%" SortExpression="Location">
                   <ItemTemplate>
                      <span title='<%#Eval("LocationNick")%>' style="font-weight:normal;"><%#Eval("LocationNick")%></span>
                   </ItemTemplate>
                   <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>                
                </asp:TemplateField>
              
                
                <asp:TemplateField HeaderText="Status" HeaderStyle-Width="10%" SortExpression="InActive" >
                    <ItemTemplate>
                      <span style="font-weight:normal;"><%#IIf(Eval("InActive"), "Inactive", "Active")%></span> 
                    </ItemTemplate>
                    <FooterTemplate>
                        &nbsp;
                    </FooterTemplate>
                </asp:TemplateField>              
                
                <asp:TemplateField HeaderText="Del" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left" HeaderStyle-Width="5%" >
                    <ItemStyle Width="5%" VerticalAlign="Top" />
                        <ItemTemplate>
                          <div style="padding-left:5px;">                         
                            <asp:ImageButton ImageUrl="~/HR/Images/career/cross.png" runat="server" ID="btnDelete" CommandArgument='<%# Eval("ID") %>' CommandName="DeleteMy" OnClientClick="Javascript:return confirm('Are you sure you want to delete this Job?')" />
                          </div> 
                        </ItemTemplate>
                </asp:TemplateField> 
            </Columns>
            <EmptyDataTemplate>                
                 <table class="NoRecord">
                    <tr>                            
                        <td>
                            <img align="absmiddle" src="../images/ico_alert.gif" />&nbsp;&nbsp;No records found !
                        </td>
                    </tr>
                 </table>                
            </EmptyDataTemplate>            
            <PagerSettings Mode="NextPreviousFirstLast" Visible="true" Position="Bottom"  />
            <PagerTemplate>
                <table id="tblPager" width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>                        
                       <td style="border:0; width:85%;">Showing Careers <asp:Literal ID="ltrlStartCount" runat="server" Text="0"></asp:Literal> to <asp:Literal ID="ltrlEndCount" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlTotalCount" runat="server" Text="0"></asp:Literal></td> 
                       <td nowrap style="border:0;" align="right">Page&nbsp;<asp:Literal ID="ltrlStartPage" runat="server" Text="0"></asp:Literal> of <asp:Literal ID="ltrlLastPage" runat="server" Text="0"></asp:Literal>&nbsp;&nbsp;&nbsp;<asp:LinkButton ID="lnkBtnFirst" runat="server" CommandName="page" CommandArgument="first"><asp:Image ID="imgFirst" runat="server" ImageUrl="../images/First_blk.jpg" ToolTip="First" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnPrevious" runat="server" CommandName="page" CommandArgument="prev"><asp:Image ID="imgPrevious" runat="server" ImageUrl="../images/back_blk.jpg" ToolTip="Previous" /></asp:LinkButton> &nbsp;<asp:LinkButton ID="lnkBtnNext" runat="server" CommandName="page" CommandArgument="next"><asp:Image ID="imgNext" runat="server" ImageUrl="../images/Next_blk.jpg"  ToolTip="Next" /></asp:LinkButton>&nbsp;<asp:LinkButton ID="lnkBtnLast" runat="server" CommandName="page" CommandArgument="last"><asp:Image ID="imgLast" runat="server" ImageUrl="../images/Last_blk.jpg" ToolTip="Last" /></asp:LinkButton>&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
            </PagerTemplate>                       
        </asp:GridView>     
    </ContentTemplate>
    <Triggers>
       
        <asp:AsyncPostBackTrigger ControlID="ddlStatus" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
    </Triggers>
    </asp:UpdatePanel>        
    </div>
    </td>
  </tr>  
  <tr id="trPager">
    <td id="tdPager">     
    </td>
  </tr>  
</table>
<asp:ObjectDataSource ID="odsIdeas" runat="server" SelectMethod="JobsGetAllByLocation" SelectCountMethod="JobsGetAllByLocationCount"
    TypeName="Portal.BLL.HR.Jobs" SortParameterName="sortExpression" EnablePaging="True">
  <SelectParameters>
    <asp:ControlParameter Name="txtsearch" ControlID="txtSearch" Type="String" PropertyName="Text" />
    <asp:ControlParameter Name="StatusID" DefaultValue="0" ControlID="ddlStatus" Type="Int32" PropertyName="SelectedValue" />
    <asp:ControlParameter Name="countryId" DefaultValue="1" ControlID="ddlCountry" Type="Int32" PropertyName="SelectedValue" />
  </SelectParameters>
</asp:ObjectDataSource>

    <script src="../scripts/functions.js" language="javascript" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function pageLoaded(sender, args) {
            var updatedPanels = args.get_panelsUpdated();
            if (typeof (postbackElement) === "undefined") {
                return;
            }
            for (i = 0; i < updatedPanels.length; i++) {
                if (updatedPanels[i].id == '<%= upIdeas.ClientID %>') {
                    AdjustPagerRow();
                    document.getElementById('<%= txtsearch.ClientID %>').value = '';
                }
            }
        }

    </script>
    </form>
</body>
</html>