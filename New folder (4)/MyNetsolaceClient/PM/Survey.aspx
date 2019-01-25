<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Survey.aspx.vb" Inherits="MyNetsolaceClient_PM_Survey"
    Theme="Default" EnableEventValidation="true" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 90%;" class="tblSurvey">
                <thead>
                    <tr>
                        <td align="left">Post Project Evaluation Survey | Ticket Ref # <%=Request.QueryString("ID")%>
                        </td>
                        <td align="right">&nbsp;
                        </td>
                    </tr>
                </thead>
                <tr>
                    <td colspan="2" valign="top" style="border-bottom: 1px solid #d0dbcd;">
                        <table cellpadding="0" cellspacing="0" border="0" style="width: 100%;" class="tblSurveySubHeading">
                            <tr>
                                <td class="LightGreenText" style="width: 70px;">Initiated By:
                                </td>
                                <td class="LightGreenText">
                                    <b>
                                        <asp:Label ID="lblCustomerName" runat="server"></asp:Label></b>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="LightGreenText">Subject:
                                </td>
                                <td class="LightGreenText">
                                    <b>
                                        <asp:Label ID="lblSubject" runat="server"></asp:Label></b>
                                </td>
                                <td class="LightGreenText" style="width: 110px;">Completion Date:
                                </td>
                                <td class="LightGreenText">
                                    <b>
                                        <asp:Label ID="lblCompletionDate" runat="server"></asp:Label></b>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="width: 100%; height: 100%;">
                        <div style="width: 100%; height: 100%; overflow-y: '<%= iif(Request.QueryString("ScrollHeight") < 600,"scroll","hidden")%>';" class="DivScroll">
                            <table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 87%;" class="tblSurveyQuestions">
                                <tr>
                                    <td valign="top" colspan="4">Your input is very valuable to us as we strive continually to improve our service.
                                    </td>
                                </tr>
                                <tr>
                                    <td valign="top" style="padding-bottom: 15px;">
                                        <span style="display: inline-block">
                                            <span style="float: left;">
                                                <b>1.</b>

                                            </span>
                                            <span style="display: inline-block; font: bold;" >
                                                <span id="Q1" runat="server"></span>
                                                  <span class="RequiredField">*</span>
                                                <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="reqName" ControlToValidate="TextBox1" ValidationGroup="vgSurvey" ErrorMessage="Required!" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ValidationGroup="vgSurvey"
                                                    Display="Dynamic" ControlToValidate="TextBox1" ErrorMessage="Please enter between 1 to 10."
                                                    ValidationExpression="^([1-9]|10)$"></asp:RegularExpressionValidator>
                                            </span>
                                          
                                        </span>
                                        <%-- <b> <span id="Q1" runat="server"></span><span class="RequiredField">*</span></b>--%>

                                        <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" CssClass="RequiredField"
                                     ControlToValidate="TextBox1" Display="Dynamic" ValidationExpression="^[^<>]*$"
                                     ErrorMessage="Please enter valid text." ValidationGroup="vgSurvey"></asp:RegularExpressionValidator>--%>
                                        <%--<asp:CustomValidator ID="cstmvalQ1" runat="server" Display="Dynamic" ErrorMessage="<b>Please enter between 1 to 10.</b>"  ValidationGroup="vgSurvey"></asp:CustomValidator>--%>
                            
                                    </td>
                                    <td></td>
                                    <td valign="top">
                                        <asp:TextBox ID="TextBox1" required="required" runat="server"></asp:TextBox>

                                    </td>




                                    <%--<td valign="top"><asp:RadioButton ID="rdoQ1Yes" runat="server" Text="Yes" GroupName="Q1" /></td>
                            <td valign="top"><asp:RadioButton ID="rdoQ1No" runat="server" Text="No" GroupName="Q1" /></td>--%>
                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>2. <span id="Q2" runat="server"></span><span class="RequiredField">*</span></b>
                                        <asp:RequiredFieldValidator runat="server" ID="RFV123" ValidationGroup="vgSurvey" ControlToValidate="rdoQ2Yes" ErrorMessage="Required!" />
                                        <%--  <asp:CustomValidator ID="cstmvalQ2" runat="server" Display="Dynamic" ErrorMessage="<b>Please choose one option.</b>" ClientValidationFunction="ValidateQ2" ValidationGroup="vgSurvey"></asp:CustomValidator>--%>
                                    </td>

                                    <td valign="top" colspan="2">
                                        <asp:RadioButtonList ID="rdoQ2Yes" Style="margin-top: -7px" runat="server" RepeatDirection="Horizontal" Font-Size="9">
                                            <asp:ListItem Value="Yes">Yes</asp:ListItem>
                                            <asp:ListItem Value="No">No</asp:ListItem>
                                        </asp:RadioButtonList>

                                    </td>
                                    <%--<td valign="top"><asp:RadioButton ID="rdoQ2Yes" runat="server" Text="Yes" GroupName="Q2" />&nbsp;<asp:RadioButton ID="rdoQ2No" runat="server" Text="No" GroupName="Q2" /></td>--%>
                                </tr>
                                <tr>
                                    <td valign="top" style="padding-bottom: 15px;">
                                       <%-- <b>3. <span id="Q3" runat="server"></span><span class="RequiredField">*</span></b>
                                        <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="ReqQ3" ControlToValidate="TextBox2" ValidationGroup="vgSurvey" ErrorMessage="Required!" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="vgSurvey"
                                            Display="Dynamic" ControlToValidate="TextBox2" ErrorMessage="Please enter between 1 to 10."
                                            ValidationExpression="^([1-9]|10)$"></asp:RegularExpressionValidator>
                                        <%--  <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="RequiredField"
                                     ControlToValidate="TextBox2" Display="Dynamic" ValidationExpression="^[^<>]*$"
                                     ErrorMessage="Please enter valid text." ValidationGroup="vgSurvey"></asp:RegularExpressionValidator>--%>
                                         <span style="display: inline-block">
                                            <span style="float: left;">
                                                <b>3.</b>

                                            </span>
                                            <span style="display: inline-block; font: bold;" >
                                                <span id="Q3" runat="server"></span>
                                                  <span class="RequiredField">*</span>
                                                  <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="ReqQ3" ControlToValidate="TextBox2" ValidationGroup="vgSurvey" ErrorMessage="Required!" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="vgSurvey"
                                            Display="Dynamic" ControlToValidate="TextBox2" ErrorMessage="Please enter between 1 to 10."
                                            ValidationExpression="^([1-9]|10)$"></asp:RegularExpressionValidator>
                                            </span>
                                          
                                        </span>
                            
                                    </td>
                                    <td></td>
                                    <td valign="top">
                                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>

                                    </td>

                                </tr>
                                <tr>
                                    <td valign="top">
                                        <b>4. <span id="Q4" runat="server"></span><%--<span class="RequiredField">*</span></b>--%>
                                            <%--   <asp:RequiredFieldValidator runat="server" id="RequiredFieldValidator2" controltovalidate="txtQ4"  ValidationGroup="vgSurvey" errormessage="Required!" />--%>
                                            <asp:RegularExpressionValidator ID="revAddress" runat="server" ValidationGroup="vgSurvey"
                                                Display="Dynamic" ControlToValidate="txtQ4" ErrorMessage="Max 500 characters Allowed."
                                                ValidationExpression="^[\s\S]{0,500}$"></asp:RegularExpressionValidator>
                                            <%--     <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" CssClass="RequiredField"
                                     ControlToValidate="txtQ4" Display="Dynamic" ValidationExpression="^[^<>]*$"
                                     ErrorMessage="Please enter valid text." ValidationGroup="vgSurvey"></asp:RegularExpressionValidator>--%>

                                
                                    </td>
                                    <td></td>
                                    <tr>
                                        <td colspan="4" valign="top" style="height: 20px;">
                                            <asp:TextBox ID="txtQ4" runat="server" Wrap="true" TextMode="MultiLine"  Style="width: 100%; height: 50px; font-size: 12px;"></asp:TextBox>


                                        </td>
                                    </tr>
                                </tr>
                                <%--  <tr>
                            <td valign="top" style="height:20px;">
                                <b>5. Was the training and users guide satisfactory? <span class="RequiredField">*</span></b>
                                <asp:CustomValidator ID="cstmvalQ5" runat="server" Display="Dynamic" ErrorMessage="<b>Please choose one option.</b>" ClientValidationFunction="ValidateQ5" ValidationGroup="vgSurvey"></asp:CustomValidator>
                            </td>
                            <td valign="top"><asp:RadioButton ID="rdoQ5NA" runat="server" Text="N/A" GroupName="Q5" /></td>
                            <td valign="top"><asp:RadioButton ID="rdoQ5Yes" runat="server" Text="Yes" GroupName="Q5" /></td>
                            <td valign="top"><asp:RadioButton ID="rdoQ5No" runat="server" Text="No" GroupName="Q5" /></td>
                        </tr>
                        <tr>
                            <td colspan="4" valign="top" style="height:20px;">
                                <b>What could we have done better?</b>
                                <asp:RegularExpressionValidator ID="revAddress" runat="server" ValidationGroup="vgSurvey"
                                    Display="Dynamic" ControlToValidate="txtQ6" ErrorMessage="Max 300 characters Allowed."
                                    ValidationExpression="^[\s\S]{0,300}$"></asp:RegularExpressionValidator>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" CssClass="RequiredField"
                                     ControlToValidate="txtQ6" Display="Dynamic" ValidationExpression="^[^<>]*$"
                                     ErrorMessage="Please enter valid text." ValidationGroup="vgSurvey"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" valign="top" style="height:20px;">
                                <asp:TextBox ID="txtQ6" runat="server" TextMode="MultiLine" Style="width: 98%;height: 50px;font-size:12px;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" valign="top" style="height:20px;">
                                <b>Your Comments:</b>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="vgSurvey"
                                    Display="Dynamic" ControlToValidate="txtComments" ErrorMessage="Max 300 characters Allowed."
                                    ValidationExpression="^[\s\S]{0,300}$"></asp:RegularExpressionValidator>
                                <asp:RegularExpressionValidator ID="revCommentsHtml" runat="server" CssClass="RequiredField"
                                     ControlToValidate="txtComments" Display="Dynamic" ValidationExpression="^[^<>]*$"
                                     ErrorMessage="Please enter valid text." ValidationGroup="vgSurvey"></asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" valign="top" style="height:20px;">
                                <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" Style="width: 98%;height: 50px;font-size:12px;"></asp:TextBox>
                            </td>
                        </tr>--%>
                                <tr>
                                    <td colspan="4" valign="top" style="height: 20px;">Thank you for the opportunity to work with you and for your thoughtful response to this evaluation.
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4" valign="top" style="height: 20px;">Signature:<span class="RequiredField">*</span>&nbsp;&nbsp;<asp:TextBox ID="txtSignature" runat="server" MaxLength="25" Style="width: 200px;"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSignature" runat="server" ErrorMessage="Please enter signature" Display="Dynamic" ControlToValidate="txtSignature" ValidationGroup="vgSurvey" CssClass="RequiredField"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" CssClass="RequiredField"
                                            ControlToValidate="txtSignature" Display="Dynamic" ValidationExpression="^[^<>]*$"
                                            ErrorMessage="Please enter valid text." ValidationGroup="vgSurvey"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tfoot>
                    <tr>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnSave" runat="server" CssClass="btnSimple" Text="Submit" ValidationGroup="vgSurvey" />
                        </td>
                    </tr>
                </tfoot>
            </table>
        </div>

    </form>
</body>
</html>
