<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TopicsList.aspx.vb" Inherits="UMv3_TopicsList" %>
 <form id="form1" runat="server">
 <asp:HiddenField ID="hdnCategoryID" runat="server" />
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
                        SelectMethod="GetTopicsByCategoryID" TypeName="Portal.BLL.UM.Topic">
                        <SelectParameters>  
                        <asp:ControlParameter ControlID="hdnCategoryID" Name="CategoryID" Type="int32" />                 
                        </SelectParameters>
          </asp:ObjectDataSource>
</form>