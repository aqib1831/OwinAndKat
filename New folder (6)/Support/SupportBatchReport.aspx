<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SupportBatchReport.aspx.vb" Inherits="Support_SupportBatchReport"  %>
<asp:Repeater ID="rptReport" runat="server" DataSourceID="sdsBatch" EnableViewState="false">
<ItemTemplate><%#Eval("StoreNumber")%>,<%#FormatNumber(Eval("TotalAmount"), 2)%>,Support
</ItemTemplate>
</asp:Repeater>
<asp:SqlDataSource ID="sdsBatch" runat="server" 
    ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"
    SelectCommand="NS_Billing_BankBatchItem_GetByBankBatchID" 
    SelectCommandType="StoredProcedure" 
    DataSourceMode="DataReader">
<SelectParameters>
    <asp:QueryStringParameter QueryStringField="ID" Name="BankBatchID" Type="Int32" />
</SelectParameters>
</asp:SqlDataSource>