<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LicensesReportDC.aspx.vb" Inherits="LM_LicensesReportDC"  %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>DC Licenses Report</title>
    <style type="text/css">
    .HeaderRow
    {
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        font-weight:bold;
    }
    .ItemRow
    {
        border-bottom:solid 1px #E1E1E1;
        font-size:9pt;
        font-family:Arial, Helvetica, Sans-Serif;
        padding-left:3px;
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
        BORDER-TOP: #000000 1px solid;
        FONT-WEIGHT: bold;
        FONT-SIZE: 9pt;
        BORDER-BOTTOM: #000000 1px solid;
        FONT-FAMILY: Arial
    }
    </style>
    <script type="text/javascript" language="javascript">
       function bodyOnLoad(){
	    try{
		    window.focus();
		    factory.printing.header = ""
		    factory.printing.topMargin = 0.3;
		    factory.printing.bottomMargin = 0.3;
		    factory.printing.footer = "";		
	    }
	    catch(err){
	    }
    }
    </script>
</head>
<body onload="bodyOnLoad();window.print();">
      <object id="factory" viewastext style="display: none;" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"
        codebase="../ScriptX/smsx.cab#Version=6,3,435,20">
    </object>  
    <form id="form1" runat="server">
   <div>
        <table style="height:100%;width:100%;" cellpadding ="0" cellspacing="0" border ="0">
            <tr>
                <td  align="center">
                    <table style="height:100%;width:670px;" cellpadding ="0" cellspacing="0" border ="0">                            
                    <tr>
                        <td align="center" style="height:50px;">
                            <div style="width:100%; text-align:center; " class="CompanyName"><%=ConfigurationManager.AppSettings("CompanyName")%></div>
                            <div style="width:100%; text-align:center;" class="ReportName">DC Licenses</div>
                             <div id="divClientOrState" runat="server"  style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn"><asp:Label ID="lblShowClientOrState" runat="server" Text=""></asp:Label></div>
                            <div style="width:100%; text-align:center; padding-top:3px;" class="GeneratedOn" >Generated on <%=DateTime.Now.ToString()%></div><br />
                        </td>
                    </tr>
                    <tr>
                            <td style="background-color:#FFFFFF;border:0;" valign="top" id="td1" >
                                <div style="width:100%;height:100%;" id="dv1">                                        
                                <asp:Repeater ID="rptReport" runat="server" DataSourceID="odsSBSLicenses">
                                <HeaderTemplate>
                                    <table style="margin: 0px; border: 0px;" cellpadding="4" cellspacing="4" border="0" width="100%">
                                        <tr  class="HeaderRow" >
                                            <td  align="left" style="width:6%;" valign="middle"  class="TableHeading"  >
                                                St#
                                            </td>
                                            <td  align="left"  style="width: 35%;" class="TableHeading" >
                                                StoreNick
                                            </td>
                                            <td  align="left"  style="width: 10%;display:none;" class="TableHeading" id="tdStates" runat="server">
                                                State
                                            </td>
                                            <td align="left" style="width: 6%;" class="TableHeading" id="tdClient" runat="server">
                                                Client
                                            </td>
                                            <td align="left" style="width: 14%;" class="TableHeading" >
                                                System IP
                                            </td>     
                                            <td align="left" style="width: 8%;" class="TableHeading" >
                                               Version
                                            </td>  
                                            <td align="left" style="width: 8%;" class="TableHeading" >
                                               Training
                                            </td>   
                                            <td align="left" style="width: 8%;" class="TableHeading" >
                                               Status
                                            </td>      
                                            <td align="left" style="width: 15%;" class="TableHeading" >
                                               Registered on
                                            </td>      
                                        </tr>
                                       </table> 
                                </HeaderTemplate> 
                                <ItemTemplate>
                                        <table style="margin: 0px; border: 0px;" cellpadding="0" cellspacing="0" border="0" width="100%">
                                         <tr>
                                            <td style="width: 6%;padding:3px; height:25px;" align="left" class="ItemRow" >
                                                <%#Eval("StoreNumber")%>
                                                  &nbsp;
                                            </td>
                                            <td style="padding-left:3px; width:34%;" align="left"  class="ItemRow" >
                                                <%#Eval("StoreNick")%>
                                                &nbsp;
                                            </td>
                                            <td style="padding-left:3px; width:10%;display:none;" align="left"  class="ItemRow" id="tdStates" runat="server" >
                                                <%#Eval("State")%>
                                                &nbsp;
                                            </td>
                                            <td style="width: 7%;" align="left" class="ItemRow" id="tdClientCode" runat="server">
                                                 <%#Eval("ClientCode")%>
                                                 &nbsp;
                                            </td>
                                            <td align="left" style="width: 14%;" class="ItemRow">
                                                <%#Eval("SystemIP")%>
                                                &nbsp;
                                            </td>
                                            <td align="left" style="width: 8%; " class="ItemRow">
                                                <%#Eval("CurrentVersion")%>
                                                &nbsp;
                                            </td>
                                            <td align="left" style="width: 8%;" class="ItemRow">
                                                <%#IIf(Eval("Is_TrainingActive") = True, "Active", "Inactive")%>  
                                                &nbsp;
                                            </td>
                                            <td align="left" style="width: 8%;" class="ItemRow">
                                                  <%#IIf(Eval("Inactive") = True, "Inactive", "Active")%>
                                                  &nbsp;
                                            </td>
                                            <td align="left" style="width: 15%;padding-left:6" class="ItemRow">
                                                   <%#String.Format("{0:MMM dd, yyyy}", Eval("RegistrationDate"))%>
                                                   &nbsp;
                                            </td>
                                        </tr> 
                                        </table>
                                </ItemTemplate> 
                                <FooterTemplate>
                                    <table id="tblFooter" runat="server"  style="margin: 0px; border: 0px;" cellpadding="4" cellspacing="4" border="0" width="100%">
                                         <tr style="padding-left:3px; height:35px;">
                                            <td colspan="9" align="left" class="TableHeading">
                                                Total Licenses:&nbsp;&nbsp;<asp:Label ID="lblTotalLicenses" runat="server" Text=""></asp:Label>
                                            </td>     
                                        </tr>
                                        <tr style="padding-left:3px; height:35px;">
                                            <td colspan="9" align="left" class="TableHeading" style="border-top:0px; border-bottom:0px; ">
                                                <i>Printed online on : <%=String.Format("{0:MMMM dd, yyyy}", DateTime.Now())%></i>
                                            </td>     
                                        </tr>
                                    </table>
                                    <table id="tblNoRecord" runat="server"  style="margin: 0px; border: 0px;" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                            <td style="font-weight: bold; font-size: 9pt; font-family: Arial; height:35px;" colspan="8" align="center">
                                                    ! No Record Found
                                            </td>
                                         </tr>
                                    </table>
                                </FooterTemplate> 
                                </asp:Repeater>
                               <asp:ObjectDataSource ID="odsSBSLicenses" runat="server" TypeName="Portal.BLL.LicenseManagementDC" 
                                SelectMethod="GetAllNextStepLicensesForReporting">
                                <SelectParameters>
                                    <asp:QueryStringParameter QueryStringField="Search"  Name="search" DefaultValue=""  /> 
                                    <asp:QueryStringParameter QueryStringField="ClientID"  Name="clientId" Type="Int32" DefaultValue="0"   /> 
                                    <asp:QueryStringParameter QueryStringField="Filter"  Name="inActive" DefaultValue="0"  /> 
                                    <asp:QueryStringParameter QueryStringField="StateID"  Name="stateId" DefaultValue="0"  /> 
                                    <asp:QueryStringParameter QueryStringField="SortBy"  Name="SortBy" DefaultValue=""  /> 
                                </SelectParameters>
                            </asp:ObjectDataSource>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>          
        </table>
        </div>
    </form>
</body>
</html>
