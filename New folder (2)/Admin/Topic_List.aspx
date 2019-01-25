<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Topic_List.aspx.vb" Inherits="com_Topic_List" Theme="Default" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Activities Topics </title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js" ></script>
</head>
<body style="margin:0px; overflow:auto;">
    <form id="form1" runat="server">
    <div id="divDisable" class="modalBackground" ></div>
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <asp:UpdateProgress ID="Progress1" runat="server">
        <ProgressTemplate>
            <div class="ProgressIndicatorDIV" style="width:150px;bottom:10px;" >
                <br />
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                <br /><br />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div>
    <table cellpadding="0" cellspacing="0" border="0" style="width:100%;height:100%;">
            <tr class="HeaderRow">
                <td style="height:31px;width:50%;padding-left:0.5em;">
                    <asp:UpdatePanel ID="UPHeaderCount"
                        runat="server"
                        UpdateMode="Always"
                        RenderMode="Inline">
                        <ContentTemplate>
                            <strong>Activity Topics</strong>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td style="text-align:right;">
                    <div style="width:110px;" class="FlatButton" onclick="ShowTopic();return false;">Add Topic <img alt="" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
                      &nbsp;
                    <img alt="" align="absmiddle" src="../../images/pixel_skyBlue.jpg" width="1" height="20" />
                    &nbsp;
                    <asp:LinkButton ID="lnkResetFilters" runat="server">
                        <div style="width:110px;" class="FlatButton" onclick="javascript:resetFilters();">Reset Filters <img alt="" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></div>
                    </asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="height:40px;background-color:#BADCFC;">
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr class="FiltersRow">
                            <td style="padding-left:5px;">
                                <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" >
                                  <span class="GreyTextSmall">Search</span><br />
                                    <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" Width="200px" onfocus="this.value='';" CssClass="GreyTextBox" />
                                    <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                </asp:Panel>
                            </td>
                            <td style="width:10px;text-align:center;">
                                <img alt="" src="../../../images/pixel_darkBlue.jpg" width="1" height="30" align="absmiddle" />
                            </td>
                          </tr>
                    </table>
                </td>
            </tr>
            <tr style=" height:85%; width:100%;">
                <td colspan="2" style="width: 100%; background-color: #E4F1F7;">
                    <div style="overflow:auto; height:100%; width:100%; background-color:#E4F1F7;border:1px solid #ACBDD5;"  id="Div1" class="ScrollBarHomeTicket">
                        <asp:UpdatePanel ID="UPMain" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView id="gvTopic" DataKeyNames="ID"
                                    runat="server" DataSourceID="odsTopic" SkinID="GridViewNormal"   
                                    AutoGenerateColumns="False" OnRowCommand="gvTopic_RowCommand">
                                      <EmptyDataTemplate>         
                                        <div id="divInfo" style="position: absolute; width:200px; height:18%; left:32%; top:38%;" class="MessageDiv"> 
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:50px">
                                                <tr>
                                                    <td style="width:5%;" >&nbsp;</td>
                                                    <td align="right" valign="middle" style="width:25%;">
                                                        <div style="text-align:right;">
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />&nbsp;&nbsp; 
                                                        </div>
                                                    </td>
                                                    <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width:75%;">&nbsp;No Record Found!</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <img src="../images/arrows.gif" />
                                            </ItemTemplate>
                                            <ItemStyle Width="2%" />
                                        </asp:TemplateField>
                                          <asp:TemplateField  HeaderText="Topic" SortExpression="ID" Visible="False"   >
                                            <ItemTemplate>
                                                <asp:Label ID="lblID" runat="server" Text='<%#Eval("ID") %>'></asp:Label>
                                                </ItemTemplate>
                                            <ItemStyle Width="10%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField  HeaderText="Topic" SortExpression="Topic" >
                                            <ItemTemplate>
                                                <asp:Label ID="lblTopic" runat="server" ToolTip='<%#Container.DataItem("Topic") %>' Text='<%#Functions.StringTruncate(Container.DataItem("Topic"),85) %>'></asp:Label>
                                                </ItemTemplate>
                                            <ItemStyle Width="78%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action" >
                                        <ItemTemplate >
                                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit" CommandArgument='<%#Eval("ID") %>'  >Edit</asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="10%" />
                                        </asp:TemplateField>
                                        </Columns>
                                 </asp:GridView> 
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                               </Triggers>
                        </asp:UpdatePanel> 
                        <asp:ObjectDataSource ID="odsTopic" runat="server" EnablePaging="false"   SortParameterName="sortExpression" SelectMethod="GetTopics" 
                         TypeName="ActivityTopic"  UpdateMethod="Update">
                          <SelectParameters>
                                <asp:ControlParameter ControlID="txtsearch" DefaultValue="" Name="Topic" PropertyName="Text" Type="String" />
                                <asp:Parameter Name="sortExpression" Type="String" /> 
                               </SelectParameters>
                               <UpdateParameters>
                               <asp:Parameter Name="ID" Type="Int32"   />
                               <asp:Parameter Name="Topic" Type="String"   />
                               </UpdateParameters> 
                        </asp:ObjectDataSource>
                        <asp:Button ID="btnRefresh" runat="server" style="visibility:hidden;display:none;" />
                        </div>
               </td>
             </tr>
             <tr style="height:20px;background-color:#BADCFC;">
                <td colspan="2"></td>
            </tr>
        </table>
    </div>
     <asp:UpdatePanel ID="UpdateDiv" runat="server" UpdateMode="Always">
   <ContentTemplate>
     <asp:HiddenField ID="hdID" runat="server" />
   <asp:HiddenField ID="hdTopic" runat="server" />
    <asp:HiddenField ID="hdnCheck" runat="server" Value="0" />
         <div id="DivTopic" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:300px;  height:110px;top:15%; left:25%; z-index:1; background-color:#DEF7D6;">
        <table style="height:100%; background-color:#DEF7D6; " cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label1" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Add Topic</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseTopicDiv();" />
              </td>               
           </tr>
           <tr valign="top">                
            <td colspan="2" style="width:100%; height:100%; padding:0px; font-size:12px; background-color:#def7d6;" >   
            <table style="width:100%; background-color:#DEF7D6;" cellpadding="0" border="0" cellspacing="0">
            <tr>
            <td style="height:5px;" colspan="3" ></td>
            </tr>
            <tr>
             <td style="width:20%; padding-right: 3px;" valign="top" align="right" >
            <span class="SimpleExSmall">Topic:</span>
             </td>
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; " valign="top" >   
                 <asp:TextBox ID="txtTopic" runat="server" Width="200px" ValidationGroup="Add" MaxLength="100"></asp:TextBox>&nbsp;
             </td>
             </tr>
             <tr>
            <td style="height:20px;" colspan="3" align="center" >
                 <asp:RequiredFieldValidator ID="Val_txtTopic" runat="server" ControlToValidate="txtTopic" ValidationGroup="Add" ErrorMessage="Please enter topic" CssClass="Requiredfield" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtTopic"
                    CssClass="Requiredfield" Display="Dynamic" ErrorMessage="Please enter valid text"
                    ValidationGroup="Add" ValidationExpression="^[^<>]*$"></asp:RegularExpressionValidator>
                     <asp:Label ID="lblMessageAdd" runat="server" CssClass="Requiredfield" Text="Topic already exists" Visible="False"></asp:Label>
                    </td>
            </tr>
            <tr>
             <td valign="middle" align="right" >
                 </td>
                 <td align="left" valign="middle">
                     &nbsp;<asp:Button ID="btnSave" runat="server" Text="Save" CssClass="Btn3D" Width="70px" ValidationGroup="Add" />
                 <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="Btn3D" OnClientClick="CloseTopicDiv();return false;" Width="70px"  CausesValidation="false"  /></td>
             <td align="left" valign="middle">
                </td>
                </tr>
             </table>
             </td> 
           </tr>            
          </table>
    </div>
         <div id="DivTopic1" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:300px;  height:110px;top:13%; left:25%; z-index:1; background-color:#DEF7D6;">
        <table style="height:100%; background-color:#DEF7D6; " cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label2" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >Edit Topic</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="CloseTopicDiv1();" />
              </td>               
           </tr>
           <tr valign="top">                
            <td colspan="2" style="width:100%; height:100%; padding:0px; font-size:12px; background-color:#def7d6;" >   
            <table style="width:100%; background-color:#DEF7D6;" cellpadding="0" border="0" cellspacing="0">
            <tr>
            <td style="height:5px;" colspan="3" ></td>
            </tr>
            <tr>
             <td style="width:20%; padding-right: 3px;" valign="top" align="right" >
            <span class="SimpleExSmall">Topic:</span>
             </td>
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; " valign="top" >   
                 <asp:TextBox ID="txtTopicUpdate" runat="server" Width="200px" ValidationGroup="Update" MaxLength="100"></asp:TextBox>&nbsp;
             </td>
             </tr>
             <tr>
            <td style="height:20px;" colspan="3" align="center" >
                 <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTopicUpdate" ValidationGroup="Update" ErrorMessage="Please enter topic" CssClass="Requiredfield" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="txtTopicUpdate"
                    CssClass="Requiredfield" Display="Dynamic" ErrorMessage="Please enter valid text"
                    ValidationGroup="Update" ValidationExpression="^[^<>]*$"></asp:RegularExpressionValidator>
                        <asp:Label ID="lblMessage" runat="server" CssClass="Requiredfield" Text="Topic already exists" Visible="False"></asp:Label></td>
            </tr>
            <tr>
             <td valign="middle" align="right" >
                 </td>
                 <td align="left" valign="middle">
                     &nbsp;<asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="Btn3D" Width="70px" ValidationGroup="Update" />
                 <asp:Button ID="btnCancelUpdate" runat="server" Text="Cancel" CssClass="Btn3D" OnClientClick="CloseTopicDiv1();return false;" Width="70px"  CausesValidation="false"  /></td>
             <td align="left" valign="middle">
                </td>
                </tr>
                <tr>
                    <td align="center" colspan="2" valign="middle">
                        </td>
                    <td align="left" valign="middle">
                    </td>
                </tr>
             </table>
             </td> 
           </tr>            
          </table>
    </div>
    </ContentTemplate>
    </asp:UpdatePanel>
    </form>
</body>
</html>
<script language="javascript" type="text/javascript"  >
function ShowTopicDiv()
{
    var element = document.getElementById("DivTopic");
    if (element.style.display == "none")
    {
        element.style.display = "inline"; 
    }
    return false;
}
function ShowTopic()
{
    var element = document.getElementById("DivTopic");
    var msg = document.getElementById('<%=lblMessageAdd.ClientID %>');
    var txt = document.getElementById('<%=txtTopic.ClientID %>');
    txt.value="";
    if (msg!=null)
    {
        msg.innerHTML = "";
    }
    if (element.style.display == "none")
    {
        element.style.display = "inline"; 
    }
    return false;
}
function ShowTopicDiv1()
{
    var element = document.getElementById("DivTopic1");
    var txttopic = document.getElementById("txttopic1");
    if (element.style.display == "none")
    {
        element.style.display = "inline"; 
    }
    return false;
}
function ShowTopicDivEdit()
{
    var element = document.getElementById("DivTopic1");
    if (element.style.display == "none")
    {
        element.style.display = "inline"; 
    }
    return false;
}
function CloseTopicDiv()
{
    var element = document.getElementById("DivTopic");
    if (element.style.display == "inline")
    {
        element.style.display = "none"; 
    }
    return false;
}
function CloseTopicDiv1()
{
    var element = document.getElementById("DivTopic1");
    if (element.style.display == "inline")
    {
        element.style.display = "none"; 
    }
    return false;
}
function resetFilters()
{
    var element  = document.getElementById("txtsearch");
    element.value='';
    return false; 
}
</script>
