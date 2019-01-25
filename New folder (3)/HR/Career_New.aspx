<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Career_New.aspx.vb" Inherits="HR_Career_New" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Career New</title>
    <link href="css/master.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" language="JavaScript" src="../scripts/jquery-1.7.2.js"></script>

    <script type="text/javascript" language="JavaScript" src="../scripts/custom.js"></script>

    <%-- <link href="style.css" type="text/css" rel="stylesheet" />
   <link href="RnDStyleSheet.css" rel="stylesheet" type="text/css" />
  <link href="../App_Themes/Default/Style.css" type="text/css" rel="stylesheet" />--%>
</head>
<body class="body" style="height: 100%; width: 100%; border: 0; margin: 0px; padding: 0px;">
    <form id="form1" runat="server">
    <asp:HiddenField ID="hdnJobID" runat="server" Value="0"/>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>   
    <table style="width: 100%; height: 100%; background-color: #EBEBEB;" border="0" cellspacing="0"
        cellpadding="0">
        <tr>
            <td>
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%;
                    border: solid 1px #8EBCD6;">
                    <tr>
                        <th valign="top" align="left" style="height: 30px; background-image: url('../images/bg_mainHdr_1.jpg');
                            background-repeat: repeat-x;">
                            <asp:Label ID="lblPageTitle" class="IdeaTitle" runat="server" Text="Add Career Opportunity"></asp:Label>
                        </th>
                    </tr>
                    <tr>
                        <td>
                            <div style="overflow-y: auto; height: 100%; width: 100%;">
                                <table id="contents-wrapper" border="0" cellpadding="0" cellspacing="0" style="width: 100%;
                                    height: 100%;">
                                    <tr>
                                        <td>
                                            <div class="contents">
                                                <fieldset>
                                                    <h3>
                                                        Job Title:<span class="required">*</span></h3>
                                                    <p>
                                                        <asp:TextBox name="jobTitle" runat="server" MaxLength="100" CssClass="textBox" ID="jobTitle" onkeyup="onKeyUpValidate(event,this);" /></p>
                                                </fieldset>
                                                <fieldset>
                                                    <h3>
                                                        Job Status:</h3>
                                                    <p>
                                                        <asp:CheckBox runat="server" CssClass="checkBox" ID="chkActive" />&nbsp;&nbsp;<label
                                                            class="label">Active</label></p>
                                                </fieldset>
                                                <fieldset>
                                                    <h3>
                                                        Job Location:<span class="required">*</span></h3>
                                                    <p>
                                                        <span class="location">
                                                            <asp:RadioButton ID="rbPk" runat="server" value="1" GroupName="Location" Checked="true" />&nbsp;&nbsp;<label
                                                                class="label">Netsolace, Islamabad, Pakistan</label>
                                                        </span><span class="location">
                                                            <asp:RadioButton ID="rbUs" runat="server" value="2" GroupName="Location" />&nbsp;&nbsp;<label
                                                                class="label">Netsolace, Wallingford, CT U.S.A</label>
                                                        </span>
                                                        <span class="location">
                                                            <asp:RadioButton ID="rbAtlanta" runat="server" value="4" GroupName="Location" />&nbsp;&nbsp;<label
                                                                class="label">Netsolace, Atlanta, GA U.S.A</label>
                                                        </span>
                                                        <span class="location">
                                                            <asp:RadioButton ID="rbDubail" runat="server" value="3" GroupName="Location" />&nbsp;&nbsp;<label
                                                                class="label">Netsolace, Dubai, UAE</label>
                                                        </span>
                                                    </p>
                                                </fieldset>
                                                <fieldset>
                                                    <h3>
                                                        Job Description:<span class="required">*</span></h3>
                                                    <p>
                                                        <asp:TextBox runat="server" name="description" onkeyup="onKeyUpValidate(event,this);" ID="txtDescription" MaxLength="2000" CssClass="textBox"
                                                            TextMode="MultiLine"></asp:TextBox></p>
                                                </fieldset>
                                                <fieldset>
                                                    <h3>
                                                        Duties and Responsibilities:<span class="required">*</span></h3>
                                                    <ul id="duties">
                                                        <%If Not String.IsNullOrEmpty(Request.QueryString("JobID")) And HasResponsibilities = True Then%>
                                                        <asp:Repeater ID="rptResponsibilities" runat="server">
                                                            <ItemTemplate>
                                                                <li class="dutiesMainItem">
                                                                    <input type="text" class="mainItem textBox" maxlength="500" itemtype="1" onkeyup="onKeyUpValidate(event,this);"
                                                                        value='<%#DataBinder.Eval(Container.DataItem,"Name")%>' />&nbsp;<input type="checkbox"                                                                              
                                                                            onclick="ChkBoxSelect(this);" title="Add Sublist" />&nbsp;<a
                                                                                href="javascript:void(0)" class="dbtn" onclick="addMainListItemDT(this);"><img
                                                                                    src="images/career/add-list-icon.png" alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a
                                                                                        href="javascript:void(0)" class="rbtn" onclick="removeList(this);"><img
                                                                                            src="images/career/remove-icon.png" alt="Remove List Item" title="Remove List Item" /></a>
                                                                <%If Not String.IsNullOrEmpty(Request.QueryString("JobID")) And HasSubResp Then%>
                                                                
                                                                    <asp:Repeater ID="rptSubResponsibilities" runat="server">
                                                                    <HeaderTemplate><ul class="sublists"></HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <li class="subDuties">
                                                                                <input type="text" class="subItem textBox" maxlength="500" onkeyup="onKeyUpValidate(event,this);" itemtype="1" value='<%#DataBinder.Eval(Container.DataItem,"Name")%>' />&nbsp;&nbsp;<a
                                                                                    href="javascript:void(0)" onclick="dBtnClick(this);"><img src="images/career/add-sublist-icon.png"
                                                                                        alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img
                                                                                            src="images/career/remove-icon.png" alt="Remove Sublist Item" class="subRbtn"
                                                                                            onclick="removeSubItem(this);" title="Remove Sublist Item" /></a></li>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate></ul></FooterTemplate>
                                                                    </asp:Repeater>
                                                                
                                                                </li>
                                                                <%End If%>                                                               
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <%
                                                        Else%>
                                                        <li class="dutiesMainItem">
                                                            <input type="text"class="mainItem textBox" maxlength="500" onkeyup="onKeyUpValidate(event,this);" itemtype="1" />&nbsp;<input
                                                                type="checkbox" onclick="ChkBoxSelect(this)" title="Add Sublist" />&nbsp;<a
                                                                    href="javascript:void(0)" class="dbtn" onclick="addMainListItemDT(this);"><img src="images/career/add-list-icon.png"
                                                                        alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a href="javascript:void(0)"
                                                                            class="rbtn" onclick="removeList(this)"><img src="images/career/remove-icon.png" alt="Remove List Item"
                                                                                title="Remove List Item" /></a></li>
                                                        <%End If%>
                                                    </ul>
                                                </fieldset>
                                                <fieldset>
                                                    <h3>
                                                        Qualifications:<span class="required">*</span></h3>
                                                    <ul id="qualification">
                                                        <%If Not String.IsNullOrEmpty(Request.QueryString("JobID")) And HasQualifications = True Then%>
                                                        <asp:Repeater ID="rptQualification" runat="server">
                                                            <ItemTemplate>
                                                                <li class="qualificationMainItem">
                                                                    <input onkeyup="onKeyUpValidate(event,this);" maxlength="500" type="text" class="mainItem textBox" itemtype="2"
                                                                        value='<%#DataBinder.Eval(Container.DataItem,"Name")%>' />&nbsp;<input type="checkbox" 
                                                                            onclick="ChkBoxSelect(this)"
                                                                            title="Add Sublist" />&nbsp;<a href="javascript:void(0)" class="dbtn" onclick="addMainListItemQF(this);"><img
                                                                                src="images/career/add-list-icon.png" alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a
                                                                                    href="javascript:void(0)" class="rbtn" onclick="removeList(this);"><img
                                                                                        src="images/career/remove-icon.png" alt="Remove List Item" title="Remove List Item" /></a>
                                                                <%If Not String.IsNullOrEmpty(Request.QueryString("JobID")) And HasSubQua Then%>
                                                              
                                                                    <asp:Repeater ID="rptSubQualification" runat="server">
                                                                    <HeaderTemplate><ul class="sublists"></HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <li class="subQualifications">
                                                                                <input type="text" maxlength="500" onkeyup="onKeyUpValidate(event,this);" class="subItem textBox" itemtype="2" value='<%#DataBinder.Eval(Container.DataItem,"Name")%>' />&nbsp;&nbsp;<a
                                                                                    href="javascript:void(0)" onclick="qBtnClick(this);"><img src="images/career/add-sublist-icon.png"
                                                                                        alt="Add Sublist Item" title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img
                                                                                            src="images/career/remove-icon.png" alt="Remove Sublist Item" class="subRbtn"
                                                                                            onclick="removeSubItem(this);" title="Remove Sublist Item" /></a></li>
                                                                        </ItemTemplate>
                                                                         <FooterTemplate></ul></FooterTemplate>
                                                                    </asp:Repeater>
                                                               
                                                                </li>
                                                                <%End If%>                                                              
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <%
                                                        Else%>
                                                        <li class="qualificationMainItem">
                                                            <input type="text" onkeyup="onKeyUpValidate(event,this);" maxlength="500" class="mainItem textBox" itemtype="2" />&nbsp;<input
                                                                type="checkbox" onclick="ChkBoxSelect(this)" title="Add Sublist" />&nbsp;<a
                                                                    href="javascript:void(0)" class="dbtn" onclick="addMainListItemQF(this);"><img src="images/career/add-list-icon.png"
                                                                        alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a href="javascript:void(0)"
                                                                            class="rbtn" onclick="removeList(this)"><img src="images/career/remove-icon.png" alt="Remove List Item"
                                                                                title="Remove List Item" /></a></li>
                                                        <%End If%>
                                                    </ul>
                                                </fieldset>
                                                <fieldset>
                                                    <h3>
                                                        Benefits:<span id="benReq" class="required">*</span></h3>
                                                    <ul id="benefits">
                                                        <%If Not String.IsNullOrEmpty(Request.QueryString("JobID")) And HasBenefits = True Then%>
                                                        <asp:Repeater ID="rptBenefits" runat="server">
                                                            <ItemTemplate>
                                                                <li class="benefitsMainItem">
                                                                    <input type="text" maxlength="500" onkeyup="onKeyUpValidate(event,this);" class="mainItem textBox" itemtype="3"
                                                                        value='<%#DataBinder.Eval(Container.DataItem,"Name")%>' />&nbsp;<input type="checkbox" 
                                                                            onclick="ChkBoxSelect(this)"
                                                                            title="Add Sublist" />&nbsp;<a href="javascript:void(0)" class="dbtn" onclick="addMainListItemBF(this);"><img
                                                                                src="images/career/add-list-icon.png" alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a
                                                                                    href="javascript:void(0)" class="rbtn" onclick="removeList(this);"><img
                                                                                        src="images/career/remove-icon.png" alt="Remove List Item" title="Remove List Item" /></a>
                                                                <%If Not String.IsNullOrEmpty(Request.QueryString("JobID")) And HasSubBen Then%>
                                                               
                                                                    <asp:Repeater ID="rptSubBenefits" runat="server">
                                                                     <HeaderTemplate><ul class="sublists"></HeaderTemplate>
                                                                        <ItemTemplate>
                                                                            <li class="subBenefits">
                                                                                <input itemtype="3" maxlength="500" onkeyup="onKeyUpValidate(event,this);" type="text" value='<%#DataBinder.Eval(Container.DataItem,"Name")%>' class="subItem textBox" />&nbsp;&nbsp;<a href="javascript:void(0)"
                                                                                    onclick="bBtnClick(this);"><img src="images/career/add-sublist-icon.png" alt="Add Sublist Item"
                                                                                        title="Add Sublist Item" /></a>&nbsp;&nbsp;<a href="#"><img src="images/career/remove-icon.png"
                                                                                            alt="Remove Sublist Item" class="subRbtn" onclick="removeSubItem(this);" title="Remove Sublist Item" /></a></li>
                                                                        </ItemTemplate>
                                                                        <FooterTemplate></ul></FooterTemplate>
                                                                    </asp:Repeater>
                                                              
                                                                </li>
                                                                <%End If%>                                                               
                                                            </ItemTemplate>
                                                        </asp:Repeater>
                                                        <%
                                                        Else%>
                                                        <li class="benefitsMainItem">
                                                            <input type="text" maxlength="500" onkeyup="onKeyUpValidate(event,this);" class="mainItem textBox" itemtype="3" />&nbsp;<input
                                                                type="checkbox" onclick="ChkBoxSelect(this)" title="Add Sublist" />&nbsp;<a
                                                                    href="javascript:void(0)" class="dbtn" onclick="addMainListItemBF(this);"><img src="images/career/add-list-icon.png"
                                                                        alt="Add List Item" title="Add List Item" /></a>&nbsp;&nbsp;<a href="javascript:void(0)"
                                                                            class="rbtn" onclick="removeList(this)"><img src="images/career/remove-icon.png" alt="Remove List Item"
                                                                                title="Remove List Item" /></a></li>
                                                        <%End If%>
                                                    </ul>
                                                </fieldset>
                                                <p class="submit-btn-container" style="margin: 25px 0 0 0">
                                                    <input type="button" value="Save" class="bSave" />
                                                    &nbsp;&nbsp;
                                                    <input type="button" value="Cancel" class="bCancel" />
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>