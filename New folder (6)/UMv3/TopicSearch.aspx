<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TopicSearch.aspx.vb" Inherits="UMv3_TopicSearch" %>

<form id="form1" runat="server">
<asp:HiddenField ID="hdnSearchQuery" runat="server" />
<asp:HiddenField ID="hdnType" runat="server" />
 <asp:Repeater ID="rptClientManual" runat="server" DataSourceID="odsClientManual">  
    <ItemTemplate>
         <div class="trList" >
             <div class="divRow" id='<%#Eval("ID")%>'><span class="Title" onmousemove="this.className='MouseOverClass';" onmouseout="this.className='Title';"><%#Eval("Topic")%></span></div>
         </div>
   </ItemTemplate>
    <FooterTemplate>
                  <div class="Liner" ></div>
        </FooterTemplate>
  </asp:Repeater>
   <asp:ObjectDataSource ID="odsClientManual" runat="server" 
                        SelectMethod="GetTopicsByGlobalSearch" TypeName="Portal.BLL.UM.Topic">
                        <SelectParameters>  
                        <asp:ControlParameter ControlID="hdnSearchQuery" Name="Search" Type="string" />  
                         <asp:ControlParameter ControlID="hdnType" Name="Type" Type="string" />                
                        </SelectParameters>
          </asp:ObjectDataSource>
</form>