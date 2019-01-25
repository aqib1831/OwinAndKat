<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AdminAccess.aspx.vb" Inherits="admin_Legal_AdminAccess" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Research And Design</title>
    <link href="../../admin/RnD/RnDStyleSheet.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../../scripts/functions.js"></script>
</head>
<body style="padding: 0; margin: 0; overflow-y:auto;">
    <form id="form1" runat="server" defaultfocus="txtSearch">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:HiddenField ID="hdnSelectedAdmins" runat="server" />
            <asp:HiddenField ID="hdnUnSelectedAdmins" runat="server" />
            <asp:HiddenField ID="hdnflag" Value="True" runat="server" />
            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 100%; border:solid 1px #609BD3">
                <tr class="GalleryTitle" style="background-image: url('../../admin/RnD/images/bg_mainHdr_1.jpg');
                    height: 31px;">
                    <td>
                        &nbsp;<span class="IdeaTitle">Admin Assigments</span></td>
                    <td colspan="2" align="right">
                    </td>
                </tr>
                <tr style="height: 41px;">
                    <td valign="middle" colspan="3">
                        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" style="height: 100%;"
                                class="gvwSearch">
                                <tr>
                                    <td align="left" valign="middle">
                                        <table cellpadding="0" cellspacing="0" border="0" style="width: 100px;">
                                            <tr>
                                                <td>
                                                    &nbsp;Search:&nbsp;</td>
                                                <td>
                                                    <asp:TextBox ID="txtSearch" runat="server" Style="height: 20px;" CssClass="txtGray"
                                                        MaxLength="50"></asp:TextBox></td>
                                                <td>
                                                    &nbsp;<asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btnSimpleSmall"
                                                        Width="35px" OnClientClick="SetDefaultButton();" />&nbsp;&nbsp;
                                                        <asp:RequiredFieldValidator ID="val_Search" runat="server" ControlToValidate="txtSearch" ErrorMessage="">
                                                        </asp:RequiredFieldValidator>
                                               </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr style="background-color:#EFEFEF;">
                    <td style="padding-left:5px;"><a class="fileLink">Unselected</a></td>
                    <td>&nbsp;</td>                    
                    <td  style="padding-right:5px;" align="right"><a class="fileLink">Selected</a></td>
                </tr>
                <tr>
                    <td style="width: 47%; height: 100%; border-right: solid 1px #609BD3; background-color:#EFEFEF;" valign="top">                        
                            <asp:UpdatePanel ID="upAdminSelected" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:ListBox ID="AdminsUnSelected" runat="server" DataSourceID="odsAdmins" DataTextField="Name"
                                        DataValueField="ID" Height="100%" Width="100%"
                                        SelectionMode="Multiple" ondblclick="MoveSingleAdminToRight(this);return false;">
                                    </asp:ListBox>
                                    <asp:ObjectDataSource ID="odsAdmins" runat="server" TypeName="Admin" SelectMethod="GetAdminsExclusiveOfDepartmentIdsAndAdminIdsForLegal">
                                        <SelectParameters>
                                            <asp:ControlParameter Name="search" Type="string" DefaultValue="" ConvertEmptyStringToNull="true"
                                                ControlID="txtSearch" PropertyName="Text" />
                                            <asp:ControlParameter Name="adminIds" Type="string" DefaultValue="" ConvertEmptyStringToNull="true"
                                                ControlID="hdnSelectedAdmins" PropertyName="Value" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnAdminsSelectAll" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnAdminsSelect" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnAdminsUnselect" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="btnAdminsUnselectAll" EventName="Click" />
                                </Triggers>
                            </asp:UpdatePanel>                       
                    </td>
                    <td style="width: 6%; background-color: #EFEFEF;">
                        <table width="100%" height="150" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="center" valign="middle">
                                    <asp:Button ID="btnAdminsSelectAll" Style="width: 35px;" CssClass="btnSimple"
                                        runat="server" Text=">>" OnClientClick="MoveAllAdminsToRight();return false;" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <asp:Button ID="btnAdminsSelect" Style="width: 35px;" CssClass="btnSimple"
                                        runat="server" Text=">" OnClientClick="MoveSingleAdminToRight();return false;" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <asp:Button ID="btnAdminsUnselect" Style="width: 35px;" CssClass="btnSimple"
                                        runat="server" Text="<" OnClientClick="MoveSingleAdminToLeft();return false;" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" valign="middle">
                                    <asp:Button ID="btnAdminsUnselectAll" Style="width: 35px;" CssClass="btnSimple"
                                        runat="server" Text="<<" OnClientClick="MoveAllAdminsToLeft();return false;" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 47%; border-left: solid 1px #609BD3; height:100%; background-color:#EFEFEF;" valign="top">
                        <asp:UpdatePanel ID="upAdminsSelected" runat="server" UpdateMode="Conditional" RenderMode="Inline">
                            <ContentTemplate>
                                <asp:ListBox ID="AdminsSelected" runat="server" DataSourceID="odsLegalAdmins" DataTextField="Name"
                                    DataValueField="ID" Height="100%" Width="100%"
                                    SelectionMode="Multiple" ondblclick="MoveSingleAdminToLeft(); return false;"></asp:ListBox>
                                <asp:ObjectDataSource ID="odsLegalAdmins" runat="server" TypeName="Fransupport.BLL.Legal.AdminAccess"
                                    SelectMethod="GetAllLegalAdmins">
                                    <SelectParameters>
                                        <asp:Parameter Name="search" Type="string" DefaultValue="" ConvertEmptyStringToNull="true" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnSave" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center" style="background-color: #DCDCDC; height:35px; border-top: solid 1px #609BD3;">
                        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btnSimpleSmall" OnClientClick="return ConfirmationSave();" />
                        <input type="button" id="btnCancel" value="Cancel" class="btnSimpleSmall" onClick="return ConfirmationExit();" />
                    </td>
                </tr>
            </table>
        </div>

        <script type="text/javascript" language="javascript">
        function SetDefaultButton()
        {
            __defaultFired = false;
        }
        
        function MoveAllAdminsToRight()
        {
            var AdminsUnSelected = document.getElementById('<%= AdminsUnSelected.ClientID %>');
            var AdminsSelected = document.getElementById('<%=AdminsSelected.ClientID %>');
            for (var i = 0; i < AdminsUnSelected.options.length; i++)
            {
                addOption(AdminsSelected,AdminsUnSelected.options[i].text,AdminsUnSelected.options[i].value);               
                AdminsUnSelected.remove(i--);  
            }
           document.getElementById("<%=hdnflag.ClientID%>").value = "False";
           UpdatehdnSelectedids();
         }
         
       function MoveAllAdminsToLeft()
       {
            var objarray = new Array();
            var AdminsUnSelected = document.getElementById('<%=AdminsUnSelected.ClientID %>');
            var AdminsSelected = document.getElementById('<%=AdminsSelected.ClientID %>');            
            for (var i = 0; i < AdminsSelected.options.length; i++)
            {       
                addOption(AdminsUnSelected, AdminsSelected.options[i].text, AdminsSelected.options[i].value);
                AdminsSelected.remove(i--);
            }
            document.getElementById("<%=hdnflag.ClientID%>").value = "False";
            UpdatehdnSelectedids();
       }
       function MoveSingleAdminToLeft()
       {
            var objarray = new Array();
            var AdminsUnSelected = document.getElementById('<%=AdminsUnSelected.ClientID %>');
            var AdminsSelected = document.getElementById('<%=AdminsSelected.ClientID %>');                        
            for (var i = 0; i < AdminsSelected.options.length; i++)
            {                
                if (AdminsSelected.options[i].selected)
                {     
                    addOption(AdminsUnSelected, AdminsSelected.options[i].text, AdminsSelected.options[i].value);
                    AdminsSelected.remove(i--);
                }
            }
            document.getElementById("<%=hdnflag.ClientID%>").value = "False";
            SortList(AdminsUnSelected);
            UpdatehdnSelectedids();
        }
     
     function MoveSingleAdminToRight(ddlUnSelectedAdmins)
     {                        
        var AdminsUnSelected = document.getElementById('<%=AdminsUnSelected.ClientID %>');        
        var AdminsSelected = document.getElementById('<%=AdminsSelected.ClientID %>');        
        for (var i = 0; i < AdminsUnSelected.options.length; i++)
        {
            if (AdminsUnSelected.options[i].selected)
            {              
                addOption(AdminsSelected,AdminsUnSelected.options[i].text,AdminsUnSelected.options[i].value);
                AdminsUnSelected.remove(i--);
            }
        }
        SortList(AdminsSelected);
        document.getElementById("<%=hdnflag.ClientID%>").value = "False";
        UpdatehdnSelectedids();
    }
    
    function SortList(list)
     {   
            return false;
            var last = list.options.length - 2; 
            var isChanged = 1; 
            var TempText,TempVal;
            while ( last >= 0 && isChanged ) 
            { 
                isChanged = 0; 
                for ( var k = 0; k <= last; k++ ) 
                if ( list(k).text.toUpperCase() > list(k+1).text.toUpperCase() ) 
                { 
                    TempText = list(k).text;
                    TempVal = list(k).value;
                    list(k).text = list(k+1).text;
                    list(k).value = list(k+1).value;
                    list(k+1).text = TempText;
                    list(k+1).value = TempVal;
                    isChanged = 1; 
                } 
                last--; 
            } 
            return;
     }
     
     function UpdatehdnSelectedids()
     {
        var objarray = new Array();
        var AdminsSelected = document.getElementById('<%=AdminsSelected.ClientID %>');
        var hdnSelectedAdmins = document.getElementById('<%=hdnSelectedAdmins.ClientID %>');        
        hdnSelectedAdmins.value = '';
        for (var i = 0; i < AdminsSelected.options.length; i++)
        {	
            objarray = AdminsSelected.options[i].value.split('~@!');
            if(hdnSelectedAdmins.value == ""){
                hdnSelectedAdmins.value = objarray[0];
            }
            else{
                hdnSelectedAdmins.value += ", " + objarray[0];
            }
        }
     }
     
     function addOption(varList, varOptionText, varOptionValue){
		var newOption = document.createElement("OPTION");
		varList.options.add(newOption);
		newOption.innerText = varOptionText;
		newOption.value = varOptionValue;
	 }
	 
	 function ConfirmationExit(){
	    if(confirm("Would you like to close this page \n without saving ur changes ?") == true){
	       
	        window.location ="Legal_Settings_CaseType.aspx";
	    }
	    else
	        return false;	    
	 }
	 
	 function ConfirmationSave(){
	    if(confirm("Would you like to save the changes?") == true){
	        return true;
	    }
	    else
	        return false;	    
	 }
     </script>

    </form>
</body>
</html>
