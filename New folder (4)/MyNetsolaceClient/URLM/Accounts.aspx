<%@ Page Language="VB" AutoEventWireup="false" EnableTheming="true" Theme="Default"  CodeFile="Accounts.aspx.vb" Inherits="URLM_Accounts" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title> 
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script type="text/javascript" src="../scripts/jquery.js"></script>
    <meta http-equiv="Page-Exit" content="progid:DXImageTransform.Microsoft.Fade(duration=.2)" />  
<script type="text/javascript">
    function AdjustButtons(IsSafari)      
    {
        
        if(IsSafari==0)
        {
           $(".spnImageContainer img").attr("align","absmiddle");
           $(".spnImageContainer").attr("style","");
        }
        else
        {
            $(".spnImageContainer").attr("style","vertical-align:middle;");
            $(".spnImageContainer img").attr("align","none");
            $(".spnImageContainer img").css("padding-bottom","1px");
        }
    }
        
    </script>
</head>
<body style="margin:0;background-color:#E4F1F7; height:100%; width:100%">
    <form id="form1" runat="server">
    <div id="divDisable" class="modalBackground"  ></div>    
        <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" ></asp:ScriptManager>
        <div id="DivNew" runat="server"   style=" display:none;border:solid 1px #000000; position:absolute;width:50%;height:250px;top:20%; left:25%;"    >
          <table style="height:100%; width:100%;" cellpadding="0" border="0" cellspacing="0"   >
           <tr>    
              <td align="left" style="border-bottom:solid 1px #000000;padding-top:4px; padding-left:1em;vertical-align:middle; background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%;">
                  <label id="Label1" title="Notes"    style="color:White;height:100%; overflow:auto; font-weight:bold;"  >New Account</label>
              </td>
              <td  style="border-bottom:solid 1px #000000;background-image:url(../images/bg_CellNormal_black.jpg);background-repeat:repeat-x; width:100%; height:28px; cursor:pointer;">
                  <img src="../images/win_btn_close_black.jpg" style="float:right;" alt="Close Window" onclick="DivOptionHide();" />
              </td>               
           </tr>
           <tr valign="top">                
             <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:#BDE4B8; padding-top:10px;" >
                <table border="0" cellpadding="0" cellspacing="0" width="100%" > 
                  <tr>
                     <td style="width:5%;" ></td>                   
                      <td style="width:15%; vertical-align:top; padding-right:5px; padding-top:0px;" align="right" class="SimpleBold" >
                       Title:
                      </td>
                      <td style="width:85%; vertical-align:top; padding-top:0px;">
                        <asp:TextBox ID="txtTitle" ValidationGroup="newCategory"  MaxLength="400" Width="220px" runat="server" SkinID="GreenSmallTextbox"></asp:TextBox>&nbsp;&nbsp;                                                                                                                          
                          <asp:RequiredFieldValidator runat="server" ID="rfvCategory" 
                            ControlToValidate="txtTitle"
                            ErrorMessage="<br/>Enter Title" 
                            Display="Dynamic"        
                            SkinID="RequiredFieldValidation"                                 
                            ValidationGroup="newCategory" >
                        </asp:RequiredFieldValidator> 
                      </td> 
                   </tr>
                  <tr>
                      <td></td>
                      <td style="vertical-align:top; padding-right:5px; padding-top:0px;" align="right" class="SimpleBold">
                            Description:
                      </td>
                      <td>
                        <asp:TextBox ID="txtDescription" ValidationGroup="newCategory"  MaxLength="400" Width="220px" Height="80px" TextMode="MultiLine" runat="server" SkinID="GreenSmallTextbox"></asp:TextBox>&nbsp;&nbsp;                                                                                                                          
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1"
                            ControlToValidate="txtDescription"
                            ErrorMessage="<br/>Enter Description" 
                            Display="Dynamic"        
                            SkinID="RequiredFieldValidation"                                 
                            ValidationGroup="newCategory" >
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="rgvtxtDescription" 
                            runat="server" 
                            ControlToValidate="txtDescription"
                            Display="Dynamic"
                            CssClass="ErrorMessage"
                            ErrorMessage="<br/>Only 4000 character allowed."
                            ValidationGroup="newCategory" 
                            ValidationExpression ="^[\s\S]{0,4000}$">
                         </asp:RegularExpressionValidator>                            
                      </td>
                   </tr>
                    <tr>
                      <td ></td>                   
                      <td style="width:15%; vertical-align:top; padding-right:5px; padding-top:0px;" align="right" class="SimpleBold" >
                       Pwd Hint:
                      </td>
                      <td style="width:85%; vertical-align:top; padding-top:0px;">
                        <asp:TextBox ID="txtPwdHint" ValidationGroup="newCategory"  MaxLength="100" Width="220px" runat="server" SkinID="GreenSmallTextbox"></asp:TextBox>&nbsp;&nbsp;                                                                                                                                                                            
                      </td> 
                   </tr>  
                  <tr>
                      <td colspan="3" align="center" style="padding-top:10px;">
                        <asp:Button ID="BtnSave" ValidationGroup="newCategory"  runat="server"  CssClass="btn3D"  Height="20px" Width="75px" Text="Add" /> &nbsp;
                        <asp:Button ID="BtnCancel"  runat="server" OnClientClick="return DivOptionHide();"  CssClass="btn3D"  Height="20px" Width="75px" Text="Cancel" />                                
                      </td> 
                    </tr>
                </table>               
             </td>
           </tr>            
          </table>
        </div>
          <asp:UpdateProgress ID="Progress1" runat="server">
            <ProgressTemplate>
                <div class="ProgressIndicatorDIV" >
                    <br />
                    <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" /> <span style="color:#4B92C1;font-size:14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                    <br /><br />
                </div>
            </ProgressTemplate>
    </asp:UpdateProgress>
          <table width="100%" style="height:100%;width:100% " cellspacing="0" border="0"  >
             <tr class="UnderlinedRow">
                 <td  style="height:31px;background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:5px;width:50%;">
                    <asp:HiddenField ID="hdnID" runat="server" Value="0" />      
                                 <asp:HiddenField ID="hdnTitle" runat="server" Value="" /> 
                                 <asp:HiddenField ID="hdnDescription" runat="server" Value="" />
                                 <asp:HiddenField ID="hdnPwdHint" runat="server" Value="" />
                                <asp:UpdatePanel ID="UpdatePanel1"
                                       runat="server" 
                                       UpdateMode="Conditional"
                                       RenderMode="Inline" >
                                       <ContentTemplate>
                                             Account&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;<asp:Label runat="server" ID="lblCount" />
                                                            &nbsp;<span class="NonBold">(<asp:Label runat="server" ID="lblFilter" Text="all" />)</span>&nbsp;&nbsp;<asp:Label runat="server" ID="lblError" Text="Account with this title already added." Visible="false" CssClass="ErrorMessage" ></asp:Label> 
                                       </ContentTemplate>
                                    <Triggers >
                                        <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"></asp:AsyncPostBackTrigger>
                                        <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click"></asp:AsyncPostBackTrigger>
                                        <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click"></asp:AsyncPostBackTrigger>
                                    </Triggers>
                                </asp:UpdatePanel>     
                </td>
                 <td style="background-color:#A0CDEE;font-size:12px;font-weight:bold;padding:3px;color:#437494;text-align:right;">
                    &nbsp;&nbsp;&nbsp;&nbsp;
                     <asp:LinkButton ID="lnkResetFilters" runat="server" CssClass="HomeButton">
                          <div style="width:110px;"  class="LeadDetailButton" onclick="javascript:resetFilters();">
                              Reset Filters 
                              <span class="spnImageContainer" style="vertical-align:middle;"><img  src="../images/blt_resetFilters.gif" width="10" style="border:0px;" height="10" alt="" /></span>
                          </div>
                     </asp:LinkButton>                    
                     <img  align="absmiddle" src="../images/pixel_skyBlue.jpg" alt="" width="1" height="20" />                    
                 </td>                        
             </tr>              
             <tr>
                <td colspan="2" style="height:40px;background-color:#BADCFC;font-size:11px;">  
                        <table border="0" cellpadding="0" cellspacing="0" width="100%" >                        
                          <tr  id="tr_Search" runat="server">
                             <td colspan="2" style=" height:40px; width:100%; background-color:#BADCFC;" >
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr class="UnderlinedRow">
                                    <td style="padding-left:3px;width:130px;padding-bottom:3px;text-align:center;padding-top:11px;">
                                       <asp:LinkButton ID="lnkAddNew"  OnClientClick="showNewAccount();  return false;" runat="server" CssClass="HomeButton">
                                    <div style="width:125px;" class="LeadDetailButton" >New Account <span class="spnImageContainer" style="vertical-align:middle;"><img alt="" src="../images/blt_resetFilters.gif" align="absmiddle" width="10" height="10" /></span></div>
                                   </asp:LinkButton> &nbsp;
                                    </td>
                                    <td style="width:10px;text-align:center;padding-bottom:3px;">
                                        <img alt="" src="../images/pixel_darkBlue.jpg" runat="server" id="img_Value" width="1" height="30" align="absmiddle" />
                                    </td>    
                                    <td style="padding-bottom:3px;" >
                                        <span class="GreyTextSmall">Search </span> <br />
                                        <asp:Panel runat="server" ID="Panel1" DefaultButton="btnSearch" >
                                        <asp:TextBox ID="txtSearch" runat="server" MaxLength="50" onfocus="javascript:this.value='';this.focus();" Width="220px"  CssClass="GreyTextBox" />
                                        <asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/images/btn_go.gif" ImageAlign="AbsMiddle" />
                                        </asp:Panel>
                                    </td>
                               </tr>
                               </table>
                             </td>                                                                        
                          </tr>                                              
                        </table>
               </td>
             </tr>
             <tr>
               <td  colspan="2" style="height:97%;">
                 <div style="overflow:auto;height:100%;background-color:#E4F1F7;border:1px solid #ACBDD5;" id="_gridViewPanel1" class="ScrollBarHomeTicket">
                     <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" >
                         <ContentTemplate>
                            <asp:GridView id="gvAccounts"
                                   runat="server"
                                   SkinID="GridViewNormal"             
                                   DataSourceID="sdsAccounts"
                                   EnableTheming="True"
                                   AutoGenerateColumns="False">
                                   <EmptyDataTemplate>         
                                       <div id="divInfo" style="position: absolute; width:200px; height:18%; left:38%; top:38%;" class="MessageDiv"> 
                                             <table width="100%" border="0" cellpadding="0" cellspacing="0" style="height:50px">
                                               <tr>
                                                    <td style="width:5%;" >&nbsp;</td>
                                                    <td align="right" valign="middle" style="width:25%;">
                                                        <div style="text-align:right;">
                                                            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/icn_info.gif" />&nbsp;&nbsp; 
                                                        </div>
                                                    </td>
                                                    <td nowrap="nowrap" align="left" valign="middle" id="divMessage" style="width:75%;">&nbsp;No How Heard Found!</td>
                                                </tr>
                                             </table>
                                        </div>  
                                  </EmptyDataTemplate>
                                   <Columns>
                                       <asp:TemplateField >
                                           <ItemStyle Width="2%" CssClass="NoSideBorder" />
                                            <ItemTemplate  >
                                               <img src="../images/arrows.gif" alt="" id="imgarrow" />
                                            </ItemTemplate>
                                        </asp:TemplateField>                                             
                                       <asp:TemplateField HeaderText="Title" SortExpression="DataText">
                                            <EditItemTemplate >
                                                  <asp:TextBox ID="txtTitle" SkinID="GreenSmallTextbox" runat="server" MaxLength="400"  Text='<%# Bind("DataText") %>'></asp:TextBox>                                                                                  
                                                      <asp:CustomValidator
                                                            ID="val_server_duplicate_Category_check_Grid"
                                                            OnServerValidate="val_server_duplicate_Category_Check_Grid_ServerValidate"
                                                            ErrorMessage="<br/>"                                                       
                                                            Display="Dynamic"
                                                            EnableClientScript="false"
                                                            runat="server" >
                                                      </asp:CustomValidator>
                                                      <asp:RequiredFieldValidator runat="server" ID="rfvTitle" 
                                                            ControlToValidate="txtTitle"
                                                            ErrorMessage="&nbsp;Enter Title" 
                                                            Display="Dynamic"        
                                                            SkinID="RequiredFieldValidation" >
                                                        </asp:RequiredFieldValidator>
                                                     <br />   
                                            </EditItemTemplate>
                                            <ItemStyle Font-Bold="True" Width="20%" VerticalAlign="Top" CssClass="NoSideBorder"   />
                                            <ItemTemplate>
                                                 <asp:Label ID="lblTitle" runat="server" Text='<%# Server.HtmlEncode(Functions.IfNull(Container.DataItem("DataText"), "")) %>'></asp:Label>
                                            </ItemTemplate>                  
                                        </asp:TemplateField>
                                       <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                            <EditItemTemplate>
                                                  <asp:TextBox ID="txtDescription" SkinID="GreenSmallTextbox" TextMode="MultiLine" Height="30px" Width="70%" runat="server" Text='<%# Bind("Description") %>'></asp:TextBox>
                                                   <asp:RequiredFieldValidator runat="server" ID="rfvDescription" 
                                                        ControlToValidate="txtDescription"
                                                        ErrorMessage="&nbsp;Enter Description" 
                                                        Display="Dynamic"        
                                                        SkinID="RequiredFieldValidation" >
                                                    </asp:RequiredFieldValidator>
                                                     <asp:RegularExpressionValidator ID="rgvtxtDescription" 
                                                        runat="server" 
                                                        ControlToValidate="txtDescription"
                                                        Display="Dynamic"
                                                        CssClass="ErrorMessage"
                                                        ErrorMessage="<br/>Only 4000 character allowed."                                                        
                                                        ValidationExpression ="^[\s\S]{0,4000}$">
                                                     </asp:RegularExpressionValidator>                                  
                                            </EditItemTemplate>
                                            <ItemStyle  Width="40%" CssClass="NoSideBorder"  />
                                            <ItemTemplate>
                                                 <asp:Label ID="lblDescription" runat="server" Text='<%# Functions.StringTruncate(Server.HtmlEncode(Functions.IfNull(Container.DataItem("Description"), "")) ,50)%>'></asp:Label>
                                            </ItemTemplate>                  
                                        </asp:TemplateField>
                                       <asp:TemplateField HeaderText="Password Hint" SortExpression="PasswordHint">
                                            <EditItemTemplate>
                                                  <asp:TextBox ID="txtPasswordHint" SkinID="GreenSmallTextbox" MaxLength="100"  Width="90%" runat="server" Text='<%# Bind("PasswordHint") %>'></asp:TextBox>                                                  
                                                  <br /><br />
                                            </EditItemTemplate>
                                            <ItemStyle  Width="20%" CssClass="NoSideBorder"  />
                                            <ItemTemplate>
                                                 <asp:Label ID="lblPasswordHint" runat="server" Text='<%# Functions.StringTruncate(Server.HtmlEncode(Functions.IfNull(Container.DataItem("PasswordHint"), "")) , 25)%>'></asp:Label>
                                            </ItemTemplate>                  
                                        </asp:TemplateField>
                                       <asp:TemplateField >
                                            <ItemStyle Width="7%" CssClass="NoSideBorder"  />
                                               <ItemTemplate  >
                                                 <asp:LinkButton  Text="Delete" ID="btnDelete"  CommandArgument='<%#Eval("ID") %>' OnClientClick="javascript:return confirm('Are you sure you want to delete');"   CommandName="Delete" runat="server" />
                                               </ItemTemplate>
                                        </asp:TemplateField>                                           
                                       <asp:CommandField ShowEditButton="True"  >
                                            <ItemStyle Width="10%" CssClass="NoSideBorder"  />
                                        </asp:CommandField>
                                       <asp:TemplateField HeaderText="ID" Visible="False">                                           
                                            <ItemTemplate>
                                                <asp:Label ID="lblID" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                            </asp:GridView> 
                         </ContentTemplate>
                              <Triggers >                                  
                                  <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />                              
                                  <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />  
                                  <asp:AsyncPostBackTrigger ControlID="lnkResetFilters" EventName="Click" />
                              </Triggers>
                     </asp:UpdatePanel> 
                     <asp:SqlDataSource 
                           ID="sdsAccounts" 
                           runat="server" 
                           ConnectionString="<%$ ConnectionStrings:PortalConnectionString %>"                             
                           DeleteCommand="URLM_Accounts_Delete" DeleteCommandType="StoredProcedure"
                           UpdateCommand="URLM_Accounts_Update" UpdateCommandType="StoredProcedure"
                           InsertCommand="URLM_Accounts_Add" InsertCommandType="StoredProcedure"
                           SelectCommand="URLM_AccountsGetAllForList" SelectCommandType="StoredProcedure">
                           <SelectParameters >  
                                <asp:ControlParameter ControlID="txtSearch" Name="reqKeyword" Type="String" PropertyName="Text" ConvertEmptyStringToNull="false" />                          
                                <asp:Parameter Name="RecCount" Type="Int32" Direction="Output" />
                           </SelectParameters>
                           <DeleteParameters>
                                <asp:ControlParameter ControlID="hdnID" Name="ID" PropertyName="Value" Type="Int32" />
                           </DeleteParameters>
                           <UpdateParameters>
                                <asp:ControlParameter ControlID="hdnID" Name="ID" PropertyName="Value" Type="Int32" />                             
                           </UpdateParameters>
                           <InsertParameters>
                                <asp:ControlParameter ControlID="hdnTitle" Name="Title" PropertyName="Value" Type="String" />
                                <asp:ControlParameter ControlID="hdnDescription" Name="Description" PropertyName="Value" Type="String" />
                                <asp:ControlParameter ControlID="hdnPwdHint" Name="PasswordHint" PropertyName="Value" Type="String" />
                                <asp:Parameter Name="ReturnValue" Type="int32" DefaultValue="0" Direction="Output" />
                           </InsertParameters>
                     </asp:SqlDataSource>        
                 </div>
               </td>
             </tr>
             <tr style="background-color:#BADCFC">
                <td align="left" colspan="2" id="CustomPagerRow" style="height:22px;">&nbsp;</td>
             </tr>
            </table>   
    </form>
<script type="text/javascript" language="javascript">
  function resetFilters()
        {         
            var item;     
          
            if (item = document.getElementById('<%= txtSearch.ClientID %>')){
          
                item.value = '';
            }
                    
            return true;
        }
       //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
  function AdjustPagerRow()
       {
            var objTag = null;
            var objCustomRow = null;
            try{
            objCustomRow = getElement("CustomPagerRow");
            objTag = getElementByClassName('FloatingPager');
            objCustomRow.innerHTML = '&nbsp;';
            if (objTag != null && objCustomRow != null)
                {
                objTag.style.display = 'none';
                objCustomRow.innerHTML = "<table cellpadding=0 cellspacing=0  align='left' height='18' ><tr class='cpyFloatingPager'>"+objTag.innerHTML+"</tr></table>";
                }
            }catch(ex){
                alert("Javascript Error:\n"+ex.description);
            }
        }    
        AdjustPagerRow();
        
        var postbackElement;
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(beginRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(pageLoaded);
        
  function beginRequest(sender, args) 
        {
            postbackElement = args.get_postBackElement();
        }    
  function pageLoaded(sender, args) 
        {
            var updatedPanels = args.get_panelsUpdated();
            if (typeof(postbackElement) === "undefined") {
                return;
            } 
            for (i=0; i < updatedPanels.length; i++){
                if (updatedPanels[i].id == '<%= UpdatePanel2.ClientID %>') {
                    AdjustPagerRow();
                    $get('<%= txtSearch.ClientID %>').value='';               
                }
            }
        }
    //These Mothods are used to Enable pagging on a TD and Also Empty txtSearch
   function showNewAccount()
        {   
            var DivOption = getElement('<%= DivNew.ClientID %>')     
            divDisable.style.width = document.body.scrollWidth
            divDisable.style.height = document.body.scrollHeight
            DivOption.style.display= "inline"
        }
        
   function DivOptionHide()
        {
            var DivOption = getElement('<%= DivNew.ClientID %>')         
            divDisable.style.width = 0;
            divDisable.style.height = 0;
            DivOption.style.display= "none";         
            return false;
        }
    
</script>
</body>
</html>