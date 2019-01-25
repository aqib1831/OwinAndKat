<%@ Page Language="VB" AutoEventWireup="false" CodeFile="EditReport.aspx.vb" Inherits="PM_EditReport" %>

<!doctype html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Edit Report</title>
    <style>
                   /*div
     {
         margin:5px;
     }*/ 
                   body{
                       font-family:Arial !important;

                   }

        .overlay {
            height: 88%;
            width: 0;
            position: fixed;
            z-index: 99999;
            right: 0;
            top: 45px;
            background-color: #E1F8DB;
            transition: 0.5s;
            border:2px solid #A6D3A5;
            display:none;
            border-bottom:none;
        }
        .overlayInner {
            height:146%;
            border:5px solid #BDEEBD;
            border-bottom:none ;
        }

        .overlay-content {
            position: relative;
            top: 25%;
            width: 30%;
            text-align: center;
            margin-top: 30px;
        }

        .overlay a {
            padding: 8px;
            text-decoration: none;
            font-size: 36px;
            color: red;
            display: block;
            transition: 0.3s;
            float:right;
        }

        .overlay .closebtn {
            position: absolute;
            right: 45px;
            font-size: 45px;
        }

        @media (max-height: 786px) {
            .overlay a {
                font-size: 36px;
            }

            .overlay .closebtn {
                font-size: 40px;
                right: 10px;
            }
        }

        #myNav .container {
            margin-top: 80px;
        }

        #myNav2 .container {
            margin-top: 80px;
        }

        .DivClose {
            display: none;
            position: absolute;
            width: 250px;
            height: 200px;
            border-style: solid;
            border-color: Gray;
            border-width: 1px;
            background-color: white;
        }

        .DivClose1 {
            display: none;
            position: absolute;
            width: 250px;
            height: 180px;
            border-style: solid;
            border-color: Gray;
            border-width: 1px;
            background-color: white;
        }

        .LabelClose {
            vertical-align: text-top;
            position: absolute;
            bottom: 15px;
            font-family: Verdana;
            left: 30px;
        }

        .DivCheckBoxList {
            display: none;
            background-color: White;
            width: 250px;
            position: absolute;
            height: 100px;
            overflow-y: auto;
            overflow-x: hidden;
            border-style: solid;
            border-color: Gray;
            border-width: 1px;
            z-index: 10;
        }

        .DivCheckBoxList1 {
            display: none;
            background-color: White;
            width: 250px;
            position: absolute;
            height: 180px;
            overflow-y: auto;
            overflow-x: hidden;
            border-style: solid;
            border-color: Gray;
            border-width: 1px;
        }

        .CheckBoxList {
            position: relative;
            width: 250px;
            height: 10px;
            overflow: scroll;
            font-size: small;
        }

        tr.border_bottom td {
            border-bottom: 1pt solid #768371;
        }

        .fake-input {
            position: relative;
            width: 120px;
        }

            .fake-input input {
                border: none: background:#fff;
                display: block;
                width: 100%;
                box-sizing: border-box;
            }

            .fake-input img {
                position: absolute;
                top: 4px;
                right: 2px;
            }

        .DropDownLook {
            position: relative;
        }
        /*#rbtLstRating_1,#rbtLstRating_0{
            font-size:25pt;
        }*/
           .w{
        
          margin-left:-150px;
        }
        .rbtLstRating td {
           height: 40px;
           vertical-align:top;
        }
    </style>
    
  <%--<link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../App_Themes/Default/Calendar/style.css" rel="stylesheet" type="text/css" />
    <link href="../style/jquery-ui-1.9.2.custom.min.css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
</head>
<body style="margin: 0px; height: 100%;">

    <form id="form1" runat="server">

          <div id="DivTicketFlagRemove" style="position: absolute; display: none;width:400px;z-index: 102;height: 50px; background-color:#A1CCEE;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;border:1px solid #4E85AC;">
              <tr>
                  
                  <td style="height:30px; text-align:right; padding-right:5px;">
                    
                  </td>

              </tr>
               <tr>
                   <td style="height:70px; padding:5px;text-align:center;background-color:#D9EAFA;" >
                     <div style="width:75%;height:40px; background-color:white;text-align:center;border:1px solid #1F497D; z-index: 1;box-shadow:inset 10px 10px 5px #888;margin-left:45px;" >
                         <span style="position:relative ;top:8px;font-size:15px;"><b>Are you sure you want to Cancel?</b></span>
                     </div>
                      
                  </td>
               </tr>

               <tr>
                   <td style="padding:0px;background-color:#D9EAFA;text-align:center;">
                      
                      <div  style="padding:2px;width:90%; text-align:center ;">
                         <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="Btn3D" Width="80px" />&nbsp;&nbsp;
                         <input type="button" class="Btn3D"  style="width:80px;" value="No" id="btnNo" runat="server" onclick ="HideDivRemoveFlag();" />
                      
                      </div>
                  </td>
              </tr>


             
            </table>
       </div>
      
         <asp:HiddenField ID="hdnlistOfClientsIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfTypeIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfCategoryIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfSubCategoryIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfPriortyIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfStatusIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfTeamIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfRelaseseIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfSurveyIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfProductOwnerIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfProjectManagers" runat="server" />
         <asp:HiddenField ID="hdnlistOfDesignLeadIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfDevLeadIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfQALeadIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfreportedByIds" runat="server" />
         <asp:HiddenField ID="hdnlistOfAssignToIds" runat="server" />
          <div id="myNav" class="overlay popup-us" style="overflow-x:hidden;">
           <div class="overlayInner" >
           
        <a href="javascript:void(0)" id="closebtn" style="top: 0px">×</a>
         <div id="err" style="color:red;display:none;"> Please select atleast one column</div>

               <div>
        <div>
        <div style="width:400px; float:left;" class="innerdivclass">
        <fieldset>
          <%--  <asp:CheckBoxList ID="SelectAll" onclick="checkAll(this)"  runat="server" style="border-bottom:1px solid black">
                <asp:ListItem Text="Select All" Value="0" ></asp:ListItem>
            </asp:CheckBoxList> --%>
            <asp:CheckBox ID="SelectAll" runat="server" Text="Select All" onclick="checkAll(this);" />

            <div>
            <asp:CheckBoxList ID="chklstStates" runat="server">
                <asp:ListItem Text="Ref.#" Value="1"></asp:ListItem>
                <asp:ListItem Text="Ticket Subject" Value="14"></asp:ListItem>
                <asp:ListItem Text="Client" Value="2"></asp:ListItem>
                <asp:ListItem Text="Type" Value="3"></asp:ListItem>
                <asp:ListItem Text="Category" Value="4"></asp:ListItem>
                <asp:ListItem Text="Sub-Category" Value="5"></asp:ListItem>
                <asp:ListItem Text="Priorty" Value="6"></asp:ListItem>
                <asp:ListItem Text="Status" Value="7"></asp:ListItem>
                <asp:ListItem Text="Team" Value="8"></asp:ListItem>
                <asp:ListItem Text="Total Time(HH:MM)" Value="9"></asp:ListItem>
            </asp:CheckBoxList>
            </div>
           <div>
               <h4 style="padding-left:22px">Resources</h4>
                <asp:CheckBoxList ID="CheckBoxResources" runat="server">
                <asp:ListItem Text="Product Owner" Value="15"></asp:ListItem>
                <asp:ListItem Text="Project Manager" Value="16"></asp:ListItem>
                <asp:ListItem Text="Assigned To" Value="17"></asp:ListItem>
                <asp:ListItem Text="Reported By" Value="18"></asp:ListItem>
                <asp:ListItem Text="Development Lead" Value="19"></asp:ListItem>
                <asp:ListItem Text="Design Lead" Value="20"></asp:ListItem>
                <asp:ListItem Text="QA Lead" Value="21"></asp:ListItem>
            </asp:CheckBoxList>
           </div>
            <div>
                <h4 style="padding-left:22px">Timeline</h4>
                 <asp:CheckBoxList ID="CheckBoxtimeline" runat="server">
                <asp:ListItem Text="Creation Date" Value="10"></asp:ListItem>
                <asp:ListItem Text="Latest Activity" Value="11"></asp:ListItem>
                <asp:ListItem Text="SOW Sign Date" Value="12"></asp:ListItem>
                <asp:ListItem Text="Due Date" Value="13"></asp:ListItem>
                <asp:ListItem Text="Confirmed/UnConfirmed" Value="14"></asp:ListItem>
            </asp:CheckBoxList>
            </div>
        </fieldset>
        </div>
        </div>
          </div>
    </div></div>
        <table style="width: 100%; height: 100%; background-color: #E1F8DB">
            <tr style="height: 5%; background-color: #C4E8C7; border: 1px solid #9DB7D0; vertical-align: top;">
                <td colspan="4" style="height: 40px; border: 1px solid #9DB7D0; vertical-align: middle; padding-left: 10px;">Edit Report
                </td>
            </tr>
            <tr>
                <td colspan="4" style="height: 90%">
                    <div id="mydiv">
                        <table style="width: 100%; border-collapse: collapse">

                            <tr class="border_bottom" style="height: 45px;">
                                <td colspan="2" style="padding-left: 40px; font-size: 12px;">Report Name:
                                    <asp:TextBox ID="txtReportName" MaxLength="30" runat="server"></asp:TextBox>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" id="reqName"  ValidationGroup="vgSurvey"  controltovalidate="txtReportName" errormessage="Please enter Report Name!" />
                                <asp:RegularExpressionValidator CssClass="w" SetFocusOnError="true" ID="RegularExpressionValidator1" runat="server" ValidationGroup="vgSurvey"  ControlToValidate="txtReportName" ValidationExpression="[a-zA-Z0-9'#\s()\-]*$" ErrorMessage="Special characters not allowed." />
                                </td>
                                <td colspan="2" style="text-align: right; padding-right: 30px;">
                                    <asp:ImageButton ImageUrl="../images/icn_reports21.png" ID="btnOpen" runat="server" /></td>
                             
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; font-size: 12px; padding-top: 10px;">Subject:<br />
                                    <asp:TextBox ID="txtSubject" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; font-size: 12px; padding-top: 10px;">Client:<span style="padding-left: 100px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="divCustomCheckBoxList" >
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtSelectedMLValues" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="divCheckBoxList" class="DivCheckBoxList" style="width: 150px; height: 150px;">
                                                            <asp:CheckBoxList ID="lstMultipleValues" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px; padding-top: 10px;">Type:<span style="padding-left: 104px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div>
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtTypeList" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="divTypeCheckList" class="DivCheckBoxList" style="width: 150px; height: 150px;">
                                                            <asp:CheckBoxList ID="TypeList" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px; padding-top: 10px;">Category:<span style="padding-left: 82px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div1"> 

                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtCategory" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div4" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div5" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlCategory" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px; padding-top: 10px;">Sub-Category:<span style="padding-left: 55px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div6">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtSubCategory" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div7" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div8" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlSubCategory" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; font-size: 12px;">Priority:<span style="padding-left: 93px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div9">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtPriority" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div10" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div11" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlPriority" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Status:<span style="padding-left: 96px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div12" runat="server">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtStatus" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div13" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div14" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlStatus" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Team:<span style="padding-left: 100px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div15">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtTeam" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div16" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div17" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlTeams" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Release:<span style="padding-left:85px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div18">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtRelease" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>

                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div19" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div20" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlReleases" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; font-size: 12px;">Completed Survey:<span style="padding-left: 32px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div21">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtSurvey" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>

                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div22" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div23" class="DivCheckBoxList" style="width: 150px;height:45px;">
                                                            <asp:CheckBoxList ID="ddlSurvey" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"  style="text-align: right; font-size:15px; padding-bottom: 10px;"><b>Resources:</b></td>
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; font-size: 12px;">Product Owner:<span style="padding-left: 51px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div24">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtProductOwner" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>

                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div25" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div26" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlProductOwner" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Project Manager:<span style="padding-left: 42px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div27">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtProjectManager" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>

                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div28" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div29" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlManager" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Design Lead:<span style="padding-left: 62px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div30">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtDesignLead" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div31" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div32" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlDesignLead" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Development Lead:<span style="padding-left: 28px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div33">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtDevLead" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>

                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div34" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div35" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlDevelopmentLead" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; font-size: 12px;">QA Lead:<span style="padding-left: 82px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div36">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtQALead" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div37" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div38" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlQALead" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Reported By:
                <span style="padding-left: 61px;">
                   <img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div39">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtReportedBy" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div40" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div41" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlReportedBy" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Assigned To:<span style="padding-left: 63px;"><img src="../images/icn_add1.png"  Class="Div" /></span>
                                    <div id="div42">
                                        <table>
                                            <tr>
                                                <td align="left" class="DropDownLook">
                                                    <div class="fake-input">
                                                        <input id="txtAssignedTo" type="text" readonly value="Select..."
                                                            style="width: 150px;" runat="server" />
                                                    </div>
                                                    <div style="width: 50%;">
                                                        <div runat="server" id="div43" class="DivClose" style="width: 150px;">
                                                        </div>
                                                        <div runat="server" id="div44" class="DivCheckBoxList" style="width: 150px;">
                                                            <asp:CheckBoxList ID="ddlAssignTo" runat="server"
                                                                Width="150px" CssClass="CheckBoxList" Font-Size="8">
                                                            </asp:CheckBoxList>
                                                        </div>
                                                    </div>

                                                </td>
                                                <td align="left" class="DropDownLook"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" class="DropDownLook">
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: right; padding-bottom: 10px; font-size:15px;"><b>Timeline:</b></td>
                            </tr>
                            <tr>
                                <td style="padding-left: 40px; font-size: 12px;">Creation Date:<br />
                                    <div style="width: 10%; float: left;">

                                           <%--  <asp:RadioButton  ID="YesRadioButton" runat="server" GroupName="Same" Text="Yes" onClick="Radio()" />
        <asp:RadioButton ID="NoRadioButton" runat="server" GroupName="Same" Text="No" onClick="Radio()" />--%>
                                    <asp:RadioButtonList  ID="rbtLstRating" runat="server" CssClass="rbtLstRating">

                                    <asp:ListItem Text="" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="" Value="1"></asp:ListItem>

                                </asp:RadioButtonList>
              </div>
                                    <div style="width: 90%; float: right;">
                                       
                                    </div>
                                    <div>
                                         Last
                                        <asp:TextBox ID="txtCreationdays" Enabled="false" onkeydown = " return isNumber(event);" runat="server" Width="40" MaxLength="3"></asp:TextBox>
                                        Days
                                    </div>
                                    <div style="margin-top:9px;">
                                        Between
                                        <div >
                                         <input id="txtCreationDateFrom"  runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" disabled="disabled" onfocus="imgDDCalander1.click();" style="width: 100px; height: 15px; line-height: 15px;" />
                                          <img id="imgDDCalander1" style="padding-top: 0px;" align="absMiddle" border="0" 
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                    </div>
                                          <div style="padding-left:27px;margin-top:10px;" >
                                         <input id="txtCreationDateto" disabled="disabled"  runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgCreationDateto.click();" style="width: 100px; height: 15px; line-height: 15px;" />
                                          <img  id="imgCreationDateto" style="padding-top: 0px;" align="absMiddle" border="0" 
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                         </div>
                                        </div>
                                </td>
                                <td style="font-size: 12px;">Latest Activity:<br />
                  <div style="width: 10%; float: left;">
                      <asp:RadioButtonList ID="RadioLastestActivity" runat="server" CssClass="rbtLstRating">

                          <asp:ListItem Text="" Value="0"></asp:ListItem>
                          <asp:ListItem Text="" Value="1"></asp:ListItem>

                      </asp:RadioButtonList>
                  </div>
                                    <div style="width: 90%; float: right;">
                                       
                                    </div>
                                    <div>
                                         Last
                                        <asp:TextBox ID="txtLatestDays" Enabled="false" onkeydown = " return isNumber(event);"  runat="server" Width="40" MaxLength="3"></asp:TextBox>
                                        Days
                                    </div>
                                    <div  style="margin-top:9px;">
                                        Between
                                        <div >
                                         <input id="txtLastestActivity" disabled="disabled" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgDDCalanderLastestActivity.click();" style="width: 100px; height: 15px; line-height: 15px;"  />
                                          <img id="imgDDCalanderLastestActivity" style="padding-top: 0px;" align="absMiddle" border="0" 
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                    </div>
                                        <div style="padding-left:26px;margin-top:10px;" >
                                         <input id="txtLastestActivityTo" disabled="disabled" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgLastestActivityTo.click();" style="width: 100px; height: 15px; line-height: 15px;" />
                                          <img id="imgLastestActivityTo" style="padding-top: 0px;" align="absMiddle" border="0" 
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                         </div>
                                        </div>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">SOW Sign Date:<br />
                  <div style="width: 10%; float: left;">
                      <asp:RadioButtonList ID="RadioSOWSignDate" runat="server" CssClass="rbtLstRating">

                          <asp:ListItem Text="" Value="0"></asp:ListItem>
                          <asp:ListItem Text="" Value="1"></asp:ListItem>

                      </asp:RadioButtonList>
                  </div>
                                    <div style="width: 90%; float: right;">
                                       
                                    </div>
                                    <div>
                                         Last
                                        <asp:TextBox Enabled="false" ID="txtSowSignDays"  onkeydown = " return isNumber(event);"  runat="server" Width="40" MaxLength="3"></asp:TextBox>
                                        Days
                                    </div>
                                    <div  style="margin-top:9px;">
                                        Between
                                        <div >
                                         <input id="txtSOWSignDate" disabled="disabled" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgDDCalanderSOWSignDate.click();" style="width: 100px; height: 15px; line-height: 15px;" />
                                          <img id="imgDDCalanderSOWSignDate" style="padding-top: 0px;" align="absMiddle" border="0" 
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                    </div>
                                        <div style="padding-left:20px;margin-top:10px;" >
                                         <input id="txtSOWSignDateTo" disabled="disabled" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgSOWSignDateTo.click();" style="width: 100px; height: 15px; line-height: 15px;" />
                                          <img id="imgSOWSignDateTo" style="padding-top: 0px;" align="absMiddle" border="0" 
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                         </div>
                                    </div>
                                </td>
                                <td style="font-size: 12px;">Due Date:<br />
                  <div style="width: 10%; float: left;">
                      <asp:RadioButtonList ID="RadioDueDate" runat="server" CssClass="rbtLstRating">

                          <asp:ListItem Text="" Value="0"></asp:ListItem>
                          <asp:ListItem Text="" Value="1"></asp:ListItem>

                      </asp:RadioButtonList>
                  </div>
                                    <div style="width: 90%; float: right;">
                                        
                                    </div>
                                    <div>
                                       Last
                                        <asp:TextBox Enabled="false" ID="txtDueDays"  onkeydown = " return isNumber(event);"   runat="server" Width="40" MaxLength="3"></asp:TextBox>
                                        Days
                                    </div>
                                    <div  style="margin-top:9px;">
                                        Between
                                         <div >
                                         <input disabled="disabled" id="txtDueDate" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgDDCalanderDueDate.click();" style="width: 100px; height: 15px; line-height: 15px;" />
                                          <img id="imgDDCalanderDueDate" style="padding-top: 0px;" align="absMiddle" border="0"
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                    </div>
                                         <div style="padding-left:20px;margin-top:10px;" >
                                         <input disabled="disabled" id="txtDueDateTo" runat="server" readonly="readonly" maxlength="10" skinid="GreenSmallTextbox" onfocus="imgDueDateTo.click();" style="width: 100px; height: 15px; line-height: 15px;" />
                                          <img id="imgDueDateTo" style="padding-top: 0px;" align="absMiddle" border="0" 
                                                        onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" style="margin-left: 2px" />
                                         </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <%--<tr>
                                <td style="padding-left: 40px; font-size: 10pt;">Between</td>
                                <td style="font-size: 10pt;">Between</td>
                                <td style="font-size: 10pt;">Between</td>
                                <td style="font-size: 10pt;">and the</td>
                            </tr>--%>
                           <%-- <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>--%>
                          <%--  <tr>
                                <td colspan="4" style="text-align: right; font-size: 10pt;">Between </td>
                            </tr>--%>
                            <tr>
                                <td colspan="4" style="text-align: center; padding-top:20px;">
<%--                                    <asp:Button ID="btnRun" runat="server" Text="Run"  />--%>
                                     <asp:Button ID="btnRunSave" runat="server" ValidationGroup="vgSurvey" Text="Run & Save" OnClick="btnRunSave_Click" />
                                    <asp:Button ID="Button2" runat="server" Text="Cancel" OnClick="Button2_Click" />
                                   <%-- <input type="button" value="Cancel" onclick="ShowDiv();" />--%>
                                </td>
                              
                            </tr>

                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="4" style="background-color: #C4E8C7; height: 20px; vertical-align: bottom"></td>
            </tr>
        </table>
        <script src="../jquery/scripts/jquery-1.11.1.min.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">

            $(document).ready(function () {

                $('#RadioDueDate input').change(function () {
                    if ($(this).val() == 0) {
                        $("#txtDueDays").removeAttr("disabled");
                        $("#txtDueDate").attr("disabled", "disabled");
                        $("#txtDueDateTo").attr("disabled", "disabled");
                        $("#imgDDCalanderDueDate").removeAttr("onclick");
                        $("#imgDueDateTo").removeAttr("onclick");
                        
                       


                    }
                    else {
                        $("#txtDueDays").attr("disabled", "disabled");
                        $("#txtDueDate").removeAttr("disabled");
                        $("#txtDueDateTo").removeAttr("disabled");
                        $("#imgDDCalanderDueDate").attr("onclick","setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtDueDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');")
                        $("#imgDueDateTo").attr("onclick", "setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtDueDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');")
                    }
                });

                $('#RadioSOWSignDate input').change(function () {
                if ($(this).val() == 0) {
                    $("#txtSowSignDays").removeAttr("disabled");
                    $("#txtSOWSignDate").attr("disabled", "disabled");
                    $("#txtSOWSignDateTo").attr("disabled", "disabled");
                    $("#imgDDCalanderSOWSignDate").removeAttr("onclick");
                    $("#imgSOWSignDateTo").removeAttr("onclick");

                }
                else {
                    $("#txtSowSignDays").attr("disabled", "disabled");
                    $("#txtSOWSignDate").removeAttr("disabled");
                    $("#txtSOWSignDateTo").removeAttr("disabled");
                    $("#imgDDCalanderSOWSignDate").attr("onclick", "setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtSOWSignDate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');");
                    $("#imgSOWSignDateTo").attr("onclick", " setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtSOWSignDateTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');");
                }
            });


            $('#RadioLastestActivity input').change(function () {
                if ($(this).val() == 0) {
                    $("#txtLatestDays").removeAttr("disabled");
                    $("#txtLastestActivity").attr("disabled", "disabled");
                    $("#txtLastestActivityTo").attr("disabled", "disabled");
                    $("#imgDDCalanderLastestActivity").removeAttr("onclick");
                    $("#imgLastestActivityTo").removeAttr("onclick");


                }
                else {
                    $("#txtLatestDays").attr("disabled", "disabled");
                    $("#txtLastestActivity").removeAttr("disabled");
                    $("#txtLastestActivityTo").removeAttr("disabled");
                    $("#imgDDCalanderLastestActivity").attr("onclick","setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtLastestActivity.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');");
                    $("#imgLastestActivityTo").attr("onclick","setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtLastestActivityTo.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');");
                }
            });
             
            });
                    

            $(document).ready(function () {
                $('#rbtLstRating input').change(function () {
                    if ($(this).val() == 0) {
                        $("#txtCreationdays").removeAttr("disabled");
                        $("#txtCreationDateFrom").attr("disabled", "disabled");
                        $("#txtCreationDateto").attr("disabled", "disabled");
                        $("#imgDDCalander1").removeAttr("onclick");
                        $("#imgCreationDateto").removeAttr("onclick");


                    }
                    else {
                        $("#txtCreationdays").attr("disabled", "disabled");
                        $("#txtCreationDateFrom").removeAttr("disabled");
                        $("#txtCreationDateto").removeAttr("disabled");
                        $("#imgDDCalander1").attr("onclick","setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtCreationDateFrom.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');");
                        $("#imgCreationDateto").attr("onclick","setActiveStyleSheet(this, 'winter'); showCalendar('<%= txtCreationDateto.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');");
                    }
                });


            });

            function isNumber(evt) {
                evt = (evt) ? evt : window.event;
                var charCode = (evt.which) ? evt.which : evt.keyCode;
                if (charCode > 31 && !((charCode >= 48 && charCode <= 57) || (charCode >= 96 && charCode <= 105))) {
                    return false;
                }
                return true;
            }
           <%-- $('#SelectAll').click(function () {
        
                var checkboxCollection = document.getElementById('<%=SelectAll.ClientID %>').getElementsByTagName('input');
                   
                if (checkboxCollection[0].type.toString().toLowerCase() == "checkbox") {
                    var checkboxes = document.getElementById('<%=chklstStates.ClientID %>').getElementsByTagName('input');
                    for (var i = 0; i < checkboxes.length; i++) {
                        if (checkboxes[i].type.toString().toLowerCase() == "checkbox") {
                            checkboxes[i].checked = true;
                        }
                    }
                }
                else {
                      var checkboxes = document.getElementById('<%=chklstStates.ClientID %>').getElementsByTagName('input');
                    for (var i = 0; i < checkboxes.length; i++) {
                        if (checkboxes[i].type.toString().toLowerCase() == "checkbox") {
                            checkboxes[i].checked = false;
                        }
                    }
                }
            });--%>
            <%-- function checkAll(obj1) {
                debugger;
                var x =false;
                var checkboxCollection = document.getElementById('<%=SelectAll.ClientID %>').getElementsByTagName('input');
                if (checkboxCollection[0].checke==true) {
                    x = true;
                }
                var checkboxes = document.getElementById('<%=chklstStates.ClientID %>').getElementsByTagName('input');
                for (var i = 0; i < checkboxes.length; i++) {
                    if (checkboxes[i].type.toString().toLowerCase() == "checkbox") {
                        checkboxes[i].checked = x;
                    }
                    else {
                        checkboxes[i].checked = x;
                    }
                }
            }--%>

            function ColoumnValid()
            {
                $('#err').css('display', 'inline-block');
                $('#err').css('padding-top', '19px');
                $('#err').css('padding-left', '5px');
                
                $("#myNav").css("display", "inline");
                document.getElementById("myNav").style.width = "30%";
            }

          function checkAll(obj1) {
        var checkboxCollection = document.getElementById('<%=chklstStates.ClientID %>').getElementsByTagName('input');

        for (var i = 0; i < checkboxCollection.length; i++) {
            if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                checkboxCollection[i].checked = obj1.checked;
            }
        }

               var checkboxCollection1 = document.getElementById('<%=CheckBoxResources.ClientID %>').getElementsByTagName('input');

        for (var i = 0; i < checkboxCollection1.length; i++) {
            if (checkboxCollection1[i].type.toString().toLowerCase() == "checkbox") {
                checkboxCollection1[i].checked = obj1.checked;
            }
        }

                var checkboxCollection2 = document.getElementById('<%=CheckBoxtimeline.ClientID %>').getElementsByTagName('input');

        for (var i = 0; i < checkboxCollection2.length; i++) {
            if (checkboxCollection2[i].type.toString().toLowerCase() == "checkbox") {
                checkboxCollection2[i].checked = obj1.checked;
            }
        }
    }

            $(function () {
                var height = $(window).height() - 70;
                $('#mydiv').attr('style', 'height:' + height + 'px;overflow:auto;width:100%;');

                $(document).on('click', '#btnOpen', function (e) {
                    $("#myNav").css("display", "inline");
                    e.preventDefault();
                    document.getElementById("myNav").style.width = "30%";

                });

                $(document).on('click', '#closebtn', function (e) {
                    $("#myNav").css("display", "none");
                    e.preventDefault();
                    document.getElementById("myNav").style.width = "0%";

                });

            })

            //function OpenPanel() {
            //    alert(111)
            //    e.preventDefault();
            //    document.getElementById("myNav").style.width = "30%";
            //}
            //This function shows the checkboxlist
            function ShowMList(element) {
                var dropdwn = element.parent().parent().find(".DivCheckBoxList");
                $(dropdwn).show()
                //var divRef = document.getElementById("divCheckBoxList");
                //divRef.style.display = "block";
                //var divRefC = document.getElementById("divCheckBoxListClose");
                //divRefC.style.display = "block";
            }
            //This function hides the checkboxlist
            function HideMList() {
              
              $('.DivCheckBoxList').hide();
                //document.getElementById("divCheckBoxList").style.display = "none";
                //document.getElementById("divCheckBoxListClose").style.display = "none";
            }
            $('.Div').click(function (e) {
                HideMList();
                
                ShowMList($(this).parent().next().find('input'));
               
            })
            $('.fake-input input').click(function (e) {
                HideMList();
                ShowMList($(this));
                
            });

            $('body').click(function () {
                HideMList();
                $("#myNav").css("display", "none");
                document.getElementById("myNav").style.width = "0%";
              
              
               
            });
            $('.DivCheckBoxList,.fake-input input,.Div,.innerdivclass').click(function (e) {
                e.stopPropagation();
            });

            function FindSelectedItems(sender, textBoxID) {
                var cblstTable = document.getElementById(sender.id);
                var checkBoxPrefix = sender.id + "_";
                var noOfOptions = cblstTable.rows.length;
                var selectedText = "";
                var defaultText = "Select...";
                var selectedval = "";
                for (i = 0; i < noOfOptions ; ++i) {
                    if (document.getElementById(checkBoxPrefix + i).checked) {
                        if (selectedText == "") {
                            selectedText = document.getElementById
                                               (checkBoxPrefix + i).parentNode.innerText;

                            // var selectedval = $("#"+checkBoxPrefix + i).closest('span').attr('data-value')
                            selectedval = $("#" + checkBoxPrefix + i).parent().parent().find("span").attr("data-value")

                        }
                        else {
                            selectedText = selectedText + "," +
                             document.getElementById(checkBoxPrefix + i).parentNode.innerText;
                            selectedval = selectedval + "," + $("#" + checkBoxPrefix + i).parent().parent().find("span").attr("data-value")

                        }



                    }
                }
                //alert( $('#hdnlistOfCategoryIds').val());
                if (textBoxID.id == "txtSelectedMLValues") {
                    $('#hdnlistOfClientsIds').val(selectedval)
                }
                else if (textBoxID.id == "txtTypeList") {
                    $('#hdnlistOfTypeIds').val(selectedval)
                   
                }

                else if (textBoxID.id == "txtCategory") {
                    $('#hdnlistOfCategoryIds').val(selectedval)
                   
                }
                else if (textBoxID.id == "txtSubCategory") {
                    $('#hdnlistOfSubCategoryIds').val(selectedval)

                }
                else if (textBoxID.id == "txtPriority") {
                    $('#hdnlistOfPriortyIds').val(selectedval)
                   
                }
                else if (textBoxID.id == "txtStatus") {
                    $('#hdnlistOfStatusIds').val(selectedval)
                }
                else if (textBoxID.id == "txtTeam") {
                    $('#hdnlistOfTeamIds').val(selectedval)
                 
                }
                else if (textBoxID.id == "txtRelease") {
                    $('#hdnlistOfRelaseseIds').val(selectedval)
                }
                else if (textBoxID.id == "txtSurvey") {
                    $('#hdnlistOfSurveyIds').val(selectedval)

                }
                else if (textBoxID.id == "txtProductOwner") {
                    $('#hdnlistOfProductOwnerIds').val(selectedval)
                  
                }
                else if (textBoxID.id == "txtProjectManager") {
                    $('#hdnlistOfProjectManagers').val(selectedval)
                  
                }
                else if (textBoxID.id == "txtDesignLead") {
                    $('#hdnlistOfDesignLeadIds').val(selectedval)
                 
                }
                else if (textBoxID.id == "txtDevLead") {
                    $('#hdnlistOfDevLeadIds').val(selectedval)
                   
                }
                else if (textBoxID.id == "txtQALead") {
                    $('#hdnlistOfQALeadIds').val(selectedval)
                   
                }
                else if (textBoxID.id == "txtReportedBy") {
                    $('#hdnlistOfreportedByIds').val(selectedval)
                   
                }
                else if (textBoxID.id == "txtAssignedTo") {
                    $('#hdnlistOfAssignToIds').val(selectedval)
                   
                }
                if (selectedText == "") {
                    document.getElementById(textBoxID.id).value = defaultText;
                }
                else {
                    document.getElementById(textBoxID.id).value = selectedText;
                    document.getElementById(textBoxID.id).title = selectedText;
                }
            }


            function ShowDiv() {
                
                    var divTicketDetails = getElement('DivTicketFlagRemove');
                    if (divTicketDetails.style.display == 'none') {
                        CenterAlignDiv(document.getElementById('DivTicketFlagRemove'));
                        divTicketDetails.style.display = 'inline';
                    }
               

            }
            function HideDivRemoveFlag() {
                var divTicketDetails = getElement('DivTicketFlagRemove');
                divTicketDetails.style.display = 'none';

            }
        </script>
    </form>
</body>
</html>


