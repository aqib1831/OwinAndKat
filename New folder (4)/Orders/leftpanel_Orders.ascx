<%@ Control Language="VB" AutoEventWireup="false" CodeFile="leftpanel_Orders.ascx.vb" Inherits="contacts_leftpanel_Orders"  %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 0px #EEEDE5; height:100%;"  bgcolor="#D8EAFC">

     <tr onclick="javascript:RedirectPage(1);" runat="server" visible="true"  id="tr_One" class="Calendar_Normal">
            <td align="center" style="width: 10px"  >
                  <div width="17" runat="server" id="img_One" height="31"  align="center" />
            </td>
            <td colspan="2"  align="left" title="Click to View Orders" >
                &nbsp;<a href="#">Orders</a>
           </td>
     </tr>
        
     <asp:Repeater ID="rptOrderStatus" runat="server" DataSourceID="sds_OrdersStatus">
     <ItemTemplate>
        <tr>
        <td align="center" style="width: 10px;height: 20px; text-align: center; border-bottom: 2px inset #E5F1FB;">&nbsp;</td>                                           
        <td valign="middle" id="td_<%#Container.DataItem("ID")%>" title='<%#Container.DataItem("Status") %>'
            style="text-align: left; font-size: 13px; border-bottom: 2px inset #E5F1FB; cursor: pointer; height: 25px; width:100%"                         
            onclick="IfPM.location='Orders.aspx?StatusID=<%#Eval("ID")%>';">                        
            -&nbsp;<%#Functions.StringTruncate(Container.DataItem("Status"), 40)%>&nbsp;(<span style="font-size:12px;"><%#Eval("StatusCount")%></span>)                                                
        </td>        
        </tr>                    
     </ItemTemplate>          
     </asp:Repeater> 
     <asp:SqlDataSource 
                ID="sds_OrdersStatus" 
                runat="server" 
                ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
                SelectCommand="SCM_OrderStatus_GetAllWithCount" 
                SelectCommandType="StoredProcedure" 
                DataSourceMode="DataReader">                                                                        
            </asp:SqlDataSource>  
     
</table>
<script type="text/javascript" language="javascript" >
   
   function RedirectPage(Page)   
    {

                ChangeTrBackGround(Page);
                if (Page==1)
                {
                   
                    IfPM.location='Orders.aspx';
                }               
    }


   function ChangeTrBackGround(type)
        {
               document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Normal";
               
            if (type==1)
                {
                document.getElementById('<%= tr_One.ClientID %>').className="Calendar_Selected";              
                }                
      }

</script>