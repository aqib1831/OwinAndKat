<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MyPMReports.aspx.vb" Inherits="PM_MyPMReports" Theme="Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../App_Themes/Default/Style.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <link href="../style/Multiselectdropdown.css" rel="stylesheet" />
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <script language="javascript" type="text/javascript" src="../scripts/jquery-1.3.2.min.js"></script>
   

    <style type="text/css">
        #ticketGrid td:first-child {

            padding-left:25px;

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
            height: 200px;
            overflow-y: auto;
            overflow-x: hidden;
            border-style: solid;
            border-color: Gray;
            border-width: 1px;
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

        .fake-input {
            position: relative;
            width: 80px;
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
            
            
            /*.FloatingHeader   th{
                /*border-left:none;
                background-image:none;
            }*/
            .GridRowClickable   td,.FloatingHeader   th{
                padding-left:10px !important;
            }
        .FloatingHeader th {
            /* color: #52789C; */
            /* font-size: 11px; */
            /* font-weight: bold; */
            padding-left: 0.5em;
            background-image: none !important;
            
            cursor: default;
            border: 0px;
        }
         .FloatingHeader th:first-child{
             padding-left:8px !important;
         }
        .GridRowClickable td:first-child,.FloatingHeader   th{
                border-right:2px solid #AEC1D8 !important;
            }

        /*#ticketGrid td:first-child + td {
            padding-top:14px!important;

        }*/
        #ticketGrid td {
            padding-top:8px!important;
        }
        .disabledbutton {
    pointer-events: none;
    opacity: 0.4;
}
        .EmptyData td {
    overflow:hidden
}

        .overlay {
    background-color:#EFEFEF;
    position: fixed;
    width: 100%;
    height: 100%;
    z-index: 1000;
    top: 0px;
    left: 0px;
    opacity: .5; /* in FireFox */ 
    filter: alpha(opacity=50); /* in IE */
}
        .cssPager td
        {
            padding-left: 4px;     
            padding-right: 4px;   
            padding-top:0px!important;
            font-size: 11px;
        }
        
        .cssPager td:first-child + td {
            padding-top:0px!important;

        }
        /*.cssPager td
        {
            padding-left: 4px;     
            padding-right: 4px;    
        }*/
    </style>
</head>
<body style="margin: 0px; background-color: #E4F1F7;" onresize="AdjustHeight();">
    <%--   <asp:HiddenField ID="hdnlistOfCategoryIds" runat ="server" />--%>
    <form id="form1" runat="server">
         <asp:HiddenField ID="hdnlistofDeleted" runat="server" />
         <asp:HiddenField ID="Validation" runat="server" />
          <asp:HiddenField ID="RID" runat="server" />



        <div id="DivTicketDetail" runat="server" style="position: absolute;top:7%;left:30%; display: none;width:350px;z-index: 102;height:490px; background-color:#C2E0FC;border:1px solid #609BD3;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
              <tr>
                  <td style="height:20px; padding:5px; text-align:center;padding-left:50px;font-size:14px;">
                     <b>Share Report</b>
                  
               </td>
                  <td style="text-align:right; padding-right:5px;">
                      <img src="../images/closebox2.gif" onclick="HideDiv();" style="cursor: pointer;">
                  </td>

              </tr>
               <tr>
                   <td style="padding:5px;background-color:#ACD3F2;padding-left:15px;padding-right:15px;" colspan="2">
                    <div style="background-color:white;height:95%;">
                
   <asp:ScriptManager  runat="server"></asp:ScriptManager>
        <asp:UpdatePanel runat="server" >
            <ContentTemplate>
              <span id="PleaseSelect" style="display:none;color:red;position:absolute;top:110px;left:67px;font-size:13px" >*Please select atleast one User </span>
     <P style="font-size: 13px; text-align: center; padding: 10px;">Please select the user(s) you want to share the report with. You can type the person's name to search for them in the list.</P>
                   <asp:TextBox runat="server"  ID="TxtSearch" autocomplete="off"  onkeyup="doPostBack(this);" OnTextChanged="TxtSearch_TextChanged" AutoPostBack="true" style="margin-left:50px;margin-bottom:10px;" Width="220" Height="20" ></asp:TextBox> 
                         <asp:CustomValidator runat="server" ID="cvmodulelist"
                             ClientValidationFunction="ValidateModuleList"
                             ErrorMessage="Please Select Atleast one Module" ValidationGroup="maininsert" >
                         </asp:CustomValidator>
      <div style="border-top:1px solid #B1B1B1 ;padding-top:10px;margin-left: 40px;margin-right: 40px; "></div>
         <div style="height:250px; width:245px;margin:0 auto ;overflow-y:auto;" > 
             <asp:GridView ID="ticketGrid"  EmptyDataText="No data found!" runat="server" Width="100%"  AutoGenerateColumns="false" ShowHeader="False" BorderStyle="None" GridLines="None" PageSize="5" AllowPaging="True" OnPageIndexChanging="ticketGrid_OnPageIndexChanging"
                           Style="padding: 10px; background-color:#F2F2F2; ">
                 <PagerStyle CssClass="cssPager" />  
                             <emptydatatemplate> <asp:Label Text="No Data found."  Font-Size="16" Height="10" runat="server"></asp:Label></emptydatatemplate> 
                            <Columns>
                                <asp:TemplateField >
                                    <ItemTemplate>
                                         <asp:CheckBox  ID="checkTicket" runat="server"/>
                                    </ItemTemplate>
                                     </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:HiddenField id="UserID" runat="server" Value='<%# Eval("ID") %>' />
                                        <asp:Label ID="ticketName" ToolTip='<%#Eval("FullName")%>' runat="server" Font-Size="14" Text='<%#Eval("Name")%>'></asp:Label><br />
                                         <asp:Label ID="Label1" runat="server" Font-Size="8" ForeColor="Gray" Text='<%#Eval("PersonalEmail")%>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView></div>
       <%--                 <asp:SqlDataSource runat="server" ID="SqlDataSource1"
        ConnectionString="<%$ ConnectionStrings:PortalConnectionString  %>"
        SelectCommand="Select * From(SELECT ID,FullName,PersonalEmail FROM dbo.Users WHERE JobTitle like('%Project Manager%') )As tb1 WHERE tb1.ID <>" & <%=CType(HttpContext.Current.Session("AdminID"), Integer)  %> >--%>
 <%--   </asp:SqlDataSource>--%>
                           </ContentTemplate>
        </asp:UpdatePanel>
                        <asp:Button ID="btnSaveTicket" ValidationGroup="maininsert" runat="server" Text="Share" CssClass="Btn3D" style="text-align:center;padding-top:3px;margin-left:125px;margin-top:10px;margin-bottom:10px;" Width="80" Height="25" OnClick="btnSaveTicket_Click" OnClientClick ="return ValidShare()"/>
                    </div>
                       
                  </td>
              </tr>
           
            </table>
       </div>


          <div id="SucessShare" runat="server" style="position: absolute;top:20%;left:30%; display: none ;width:350px;z-index: 102;height: 400px; background-color:#C2E0FC;border:1px solid #609BD3;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
              <tr>
                  <td style="height:20px; padding:5px; text-align:center;padding-left:50px;font-size:14px;">
                     <b>Share Report</b>
                  
               </td>
                 

              </tr>
               <tr>
                   <td style="padding:5px;border:15px solid #ACD3F2; background-color:white ;padding-left:15px;padding-right:15px;text-align:center" colspan="2">
                    
            <h1> Shared Sucessfully!</h1>
        <asp:Button ID="Button1" runat="server" Text="Ok" Width="60" OnClick="Button1_Click1" />
                  </td>
              </tr>
          
            </table>
       </div>

    <div id="ErrorShare" runat="server" style="position: absolute;top:30%;left:30%; display: none ;width:350px;z-index: 102;height: 150px; background-color:#C2E0FC;border:1px solid #609BD3;">
        <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
          <%--  <tr>
                <td style="height:20px; padding:5px; text-align:center;padding-left:50px;font-size:14px;">
                    <b>Share Report</b>
                  
                </td>
                 

            </tr>--%>
            <tr>
                <td style="padding:5px;border:15px solid #ACD3F2; background-color:white ;padding-left:15px;padding-right:15px;text-align:center" colspan="2">
                    
                    <h1> Please select a report to share.</h1>
                    <asp:Button ID="Button2" runat="server" Text="Ok" Width="60" OnClick="Button1_Click1" />
                </td>
            </tr>
          
        </table>
    </div>







          <div id="DivTicketFlagRemove" runat="server" style="position: fixed; top: 50%;left: 50%;margin-top: -25px; margin-left: 0px; border:1px solid black; display: none;width:400px;z-index: 102;height: 150px; background-color:#A1CCEE;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
              <tr>
                  
                  <td style="height:30px; text-align:right; padding-right:5px;">
                    
                  </td>

              </tr>
               <tr>
                   <td style="height:70px; padding:5px;text-align:center;background-color:#D9EAFA;" >
                     <div style="width:75%;height:40px; background-color:white;text-align:center;border:1px solid #1F497D; z-index: 1;margin-left:45px;" >
                         <span style="position:relative ;top:8px;font-size:15px;"><b>Are you sure you want to delete ?</b></span>
                     </div>
                      
                  </td>
               </tr>

               <tr>
                   <td style="padding:0px;background-color:#D9EAFA;text-align:center;">
                      
                      <div  style="padding:2px;width:90%; text-align:center ;">
                         <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="Btn3D" Width="80px" OnClick="btnYes_Click"/>&nbsp;&nbsp;
                         <input type="button" class="Btn3D" value="No" id="btnNo" runat="server" onclick ="HideDivRemoveFlag();" />
                      
                      </div>
                  </td>
              </tr>
             
            </table>


       </div>

          <div id="del" runat="server" style="position: fixed; top: 50%;left: 50%;margin-top: -105px; margin-left: -200px; border:1px solid black; display: none;width:400px;z-index: 102;height: 150px; background-color:#A1CCEE;">
           <table cellspacing="0" cellpadding="0" border="0" style="height:100%;width:100%;">
              <tr>
                  
                  <td style="height:30px; text-align:right; padding-right:5px;">
                    
                  </td>

              </tr>
               <tr>
                   <td style="height:70px; padding:5px;text-align:center;background-color:#D9EAFA;" >
                     <div style="width:75%;height:40px; background-color:white;text-align:center;border:1px solid #1F497D; z-index: 1;box-shadow:inset 10px 10px 5px #888;margin-left:45px;" >
                         <span style="position:relative ;top:8px;font-size:15px;"><b>Deletion Sucessful</b></span>
                     </div>
                      
                  </td>
               </tr>

               <tr>
                   <td style="padding:0px;background-color:#D9EAFA;text-align:center;">
                      
                      <div  style="padding:2px;width:90%; text-align:center ;">
                        
                         <input type="button" class="Btn3D" value="Okay" id="Button3" runat="server" onclick ="HideDivRemoveFlag();" />
                      
                      </div>
                  </td>
              </tr>
             
            </table>


       </div>


        <div id="mydip" style="display:none"> lkajvlkajslkvcjaslkcjsa</div>

        <div>
        <%--    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="300" />
            <asp:UpdateProgress ID="Progress1" runat="server">
                <ProgressTemplate>
                    <div class="ProgressIndicatorDIV">
                        t
                    <br />
                        <asp:Image ID="Image2" runat="server" ImageUrl="../images/indicator.gif" ImageAlign="AbsMiddle" />
                        <span style="color: #4B92C1; font-size: 14px;"><b>&nbsp;&nbsp;Loading ...</b></span>
                        <br />
                        <br />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
            <table width="100%" style="height: 100%; margin: 0px; padding: 0px; background-color: #E4F1F7;" cellspacing="0" cellpadding="0" border="0">
                <tr class="UnderlinedRow" style="height: 40px;">
                    <td style="background-color: #A0CDEE; font-size: 12px; font-weight: bold; width: 30%; padding-left: 10px;">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always" RenderMode="Inline">
                            <ContentTemplate>
                                My Reports
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td style="background-color: #A0CDEE; padding: 5px; text-align: right;">
                        <asp:Button ID="btnReport" Text="Create New Report" runat="server" Font-Size="8" Style="margin-left: 10px; border: none;cursor:pointer; background-color: #D1ECFD; color: #6D8FB2" OnClick="btnReport_Click" />
                      <%--  <asp:Button ID="btnExport" Text="Export to Excel" runat="server" Font-Size="8" Style="margin-left: 10px; border: none;cursor:pointer; background-color: #D1ECFD; color: #6D8FB2" />--%>
                      <%--  <button onclick="showShareReport()" Style="margin-left: 10px; border: none;cursor:pointer; background-color: #D1ECFD; color: #6D8FB2; font-size:8px;">Share Report</button>--%>
                   <asp:Button ID="btnShare" Text="Share Report" runat="server" Font-Size="8" Style="margin-left: 10px; border: none;cursor:pointer; background-color: #D1ECFD; color: #6D8FB2" OnClick="btnShare_Click"   />
                   <asp:Button ID="btnDelete" Text="Delete Report" runat="server" Font-Size="8" Style="margin-left: 10px; border: none;cursor:pointer; background-color: #D1ECFD; color: #6D8FB2" OnClick="btnDelete_Click"/>
<%--                        <a style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2;Font-Size:8pt;padding:1px;padding-left:8px;padding-right:9px;cursor:pointer;" onclick="showShareReport();">Share Report</a> --%>
                     <%--   <a  style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2;Font-Size:8pt;padding:1px;padding-left:8px;padding-right:9px;cursor:pointer;" onclick="ShowDiv();">Delete Report</a> --%>
                        <%-- <input type="button" class="Btn3D" value="Delete Report" id="btnDelete" Style="margin-left: 10px; border: none; background-color: #D1ECFD!important; color: #6D8FB2;font-size:8pt;"  onclick ="ShowDiv();" />--%>
        <%--            <Button ID="btnDelete" value="Delete Report" Style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2;Font-Size:8pt;" onclick="" />   --%>                 </td>
                </tr>
                <tr>
                </tr>
                <tr>
                    <td colspan="2" style="background-color: #E4F1F7; margin: 0px; padding: 0px; vertical-align: top;">
                        <div style="overflow: auto; height: 100%; background-color: #E4F1F7; border: 1px solid #ACBDD5;" id="_gridViewPanel1" class="ScrollBarHomeTicket">
                            <asp:UpdatePanel ID="UpdatePanel2"
                                runat="server"
                                UpdateMode="Conditional"
                                RenderMode="Inline">
                                <ContentTemplate>
                                    <asp:GridView ID="gvwMyTickets" OnRowDataBound="gvwMyTickets_RowDataBound"  runat="server" OnRowCommand="gvwMyTickets_RowCommand"
                                        SkinID="GridViewWithPaging" EnableViewState="false" AllowSorting="True">
                                        <Columns>
                                            <asp:TemplateField HeaderStyle-Width="5%">
                                                <HeaderTemplate >
                                                    <asp:CheckBox
                                                        ID="chkSelectAll"
                                                        runat="server"
                                                        value="all"
                                                        onclick="CheckAll(this)"
                                                        />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    
                                                    <asp:CheckBox ID="chkReport" runat="server"/>
                                                    <asp:HiddenField id="reptID" runat="server" />
                                                </ItemTemplate>
                                                 <ItemStyle HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Report Name"  HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="28%">
                                                <ItemTemplate>
                                                     <asp:HiddenField ID="hdnID" runat="server"  value="" />
                                                    <%# Eval("ReportName")%>
                                                     
                                                </ItemTemplate>
                                                <ItemStyle Font-Bold="true" />
                                                <HeaderStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date Created"  HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="20%">
                                                <ItemTemplate>
                                                    <%# Eval("CreatedDate")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Last Run"  HeaderStyle-HorizontalAlign="Left" HeaderStyle-Width="28%">
                                                <ItemTemplate>
                                                    <%# Eval("CreatedDate")%>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField >
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbltest" runat="server" Text="Edit" CommandName="Action"
                                                        CommandArgument='<%# IIf(Eval("SharedID") = -1, Eval("ID"), Eval("SharedID")) %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>


                                        </Columns>
                                    </asp:GridView>
                                </ContentTemplate>

                            </asp:UpdatePanel>
                          <%--  <asp:ObjectDataSource runat="server" ID="GetMyReport" SelectMethod="GetMyReport" TypeName="Portal.BLL.PM.PM_Ticket_Features"></asp:ObjectDataSource>--%>
                        </div>

                    </td>

            </table>
           
        </div>
          
    </form>
    <script type="text/javascript" language="javascript">


        function doPostBack(o) {
         
           // alert(o.value);
             __doPostBack(o.id);
     }

      
        //$('#TxtSearch').keypress(function (e) {   
        //    if (e.which == 13) {
        //        e.preventDefault();
        //        //do something   
        //    }
        //       // e.preventDefault();
           
        //}

        $(document).ready(function () {
          
setFocusToTextBox();
    function ColoumnValid() {
        $('#PleaseSelect').css('display', 'inline');


    }

    $('body').click(function () {
        //alert()
        $('#btnShare').removeAttr('disabled');
        $('#btnDelete').removeAttr('disabled');
        //EnabledDeleteButton();
        //EnabledShareButton();
    });
});
function setFocusToTextBox() {
    var inputField = document.getElementById("TxtSearch");
    if (inputField != null && inputField.value.length != 0) {
        if (inputField.createTextRange) {
            var FieldRange = inputField.createTextRange();
            FieldRange.moveStart('character', inputField.value.length);
            FieldRange.collapse();
            FieldRange.select();
        } else if (inputField.selectionStart || inputField.selectionStart == '0') {
            var elemLen = inputField.value.length;
            inputField.selectionStart = elemLen;
            inputField.selectionEnd = elemLen;
            inputField.focus();
        }
    } else {
        inputField.focus();
    }
}
        AdjustHeight();
        function AdjustHeight() {
            var client_height = $(window).height() -50;
            $('#_gridViewPanel1').attr('style', 'height:' + client_height + 'px;overflow:auto;background-color:#E4F1F7;border:1px solid #ACBDD5;');
        }

        //function showdel() {

        //    $('')

        //}

        function CheckAll(oCheckbox) {
            var GridView2 = document.getElementById("<%=gvwMyTickets.ClientID %>");
             for (i = 1; i < GridView2.rows.length; i++) {
                 GridView2.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = oCheckbox.checked;
             }
         }


        function GenerateExcel() {

            var UserLogID = $("[id$=hdnUserlLogID]").val();
            var ClientId = $("[id$=ddlClients] option:selected").val();
            var cid = $("[id$=hdnlistOfCategoryIds]").val()


            var CategoryId = '0';
            if (cid != "") {
                CategoryId = cid;
            }
            var TId = $("[id$=hdnlistOfTypeIds]").val();
            var typeID = '0'
            if (TId != "") {
                typeID = TId;
            }

            var SID = $("[id$=hdnlistofStatusIds]").val();
            var status = '0'
            if (SID != "") {
                status = SID;
            }
            var filter = $("[id$=ddlFilter] option:selected").val();


            var StartDate = $("[id$=txtDateFrom]").val();
            var EndDate = $("[id$=txtDateTo]").val();
            var SortBy = $("[id$=hdnSortBy]").val();

            /** Getting Selected Text **/
            var ClientName = $("[id$=ddlClients] option:selected").text();
            var CName = $("#txtSelectedMLValues").val();
            var CategoryName = "";
            if (CName != "Select...") {
                CategoryName = CName;
            }


            var searchtxt = $("[id$=txtSearch]").val();
            var FilterName = $("[id$=ddlFilter] option:selected").text();
            var StName = $("#txtSelectedMLValues2").val();
            var StatusName = "";
            if (StName != "Select...") {
                StatusName = StName;
            }


            var d = new Date();
            var uniqueid = d.getMilliseconds()

            var url = "../ExcelGenerator.ashx?Action=ExportPMTicketsAndFeatures&ClientId=" + ClientId + "&CategoryId=" + CategoryId + "&TypeID=" + typeID + "&Status=" + status + "&StartDate=" + StartDate + "&EndDate=" + EndDate + "&ClientName=" + ClientName + "&CategoryName=" + CategoryName + "&SortBy=" + SortBy + "&UserLogID=" + UserLogID + "&searchtxt=" + searchtxt + "&filter=" + filter + "&FilterName=" + FilterName + "&StatusName=" + StatusName + "&nocache=" + uniqueid;
            window.open(url);

        }

        function ShowDiv() {
            var s = atleast_onecheckbox();
            
            if (s) {
                var divTicketDetails = getElement('DivTicketFlagRemove');
                if (divTicketDetails.style.display == 'none') {
                    CenterAlignDiv(document.getElementById('DivTicketFlagRemove'));
                    divTicketDetails.style.display = 'inline';
                  
                    $('#gvwMyTickets tr td').removeAttr("onclick")
                
                }
             var GridView2 = document.getElementById("<%=gvwMyTickets.ClientID %>");
             for (i = 0; i < GridView2.rows.length; i++) {
                 //GridView2.rows[i].cells[0].getElementsByTagName("INPUT")[0].disabled = true;
                 //GridView2.rows[i].cells[4].getElementsByTagName("a").disabled = true;
             }

            }
     
             <%-- var GridView2 = document.getElementById("<%=gvwMyTickets.ClientID %>");--%>
            //for (i = 1; i < GridView2.rows.length; i++) {
               
               
             //}
        }


   function HideDivRemoveFlag(){
             var divTicketDetails = getElement('DivTicketFlagRemove');
             divTicketDetails.style.display = 'none';
             var del = getElement('del');
             del.style.display = 'none';
             window.location = "MyPMReports.aspx"
 
   }
   function atleast_onecheckbox() {
       if ($("input[type=checkbox]:checked").length === 0) {
           return false;
       }
       else {
           return true;
       }
   }

  
   function showShareReport() {
       var s = atleast_onecheckbox();
       if (s) {
           var divTicketDetails = getElement('DivTicketDetail');
           if (divTicketDetails.style.display == 'none') {
               CenterAlignDiv(document.getElementById('DivTicketDetail'));
               divTicketDetails.style.display = 'inline';
           }
       }
   }
 
   function HideDiv() {
     
       $(<%= DivTicketDetail.ClientID %>).css('display', 'none');
       var GridView2 = document.getElementById("<%=gvwMyTickets.ClientID %>");
             for (i = 0; i < GridView2.rows.length; i++) {
                 GridView2.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked = false;
                 GridView2.rows[i].cells[0].getElementsByTagName("INPUT")[0].removeAttribute('disabled');
                 GridView2.rows[i].cells[0].getElementsByTagName("span")[0].removeAttribute('disabled');
             }

            window.location = "MyPMReports.aspx"
            
      
   }

  
        Sys.Application.add_init(appl_init);

        function appl_init() {
            var pgRegMgr = Sys.WebForms.PageRequestManager.getInstance();
            pgRegMgr.add_endRequest(EndHandler);
        }


        function EndHandler() {
            setFocusToTextBox();
        }

        function ValidShare() {
           
            var CheckMe = false
             var GridView2 = document.getElementById("<%=ticketGrid.ClientID %>");
             for (i = 0; i < GridView2.rows.length-1; i++) {
                 if (GridView2.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked) {
                     CheckMe = true

                 }
                

             }
             if (CheckMe == false) {
                 $('#PleaseSelect').css("display", "inline");
             }
            return CheckMe
        }


        function ValidateModuleList(source, args)
        {
        
  var chkListModules= document.getElementById ('<%= ticketGrid.ClientID %>');
  var chkListinputs = chkListModules.getElementsByTagName("input");
  for (var i = 0; i < chkListModules.length; i++)
  {
    if ((chkListModules.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked))
    {
        args.IsValid = true;
       
      return;
    }
  }
  $('#PleaseSelect').css("display", "inline");
  args.IsValid = false;
}


        function EnabledDeleteButton() {
            var s = atleast_onecheckbox();

            if (s) {
                $('<%=btnDelete.ClientID%>').removeAttr("disabled");
                return true;

            }
            return false;
        }
        function EnabledShareButton() {
            debugger;
            var s = atleast_onecheckbox();

            if (s) {
                $('<%=btnShare.ClientID%>').disabled = false;
                return true;

            }
            return false;
        }


    </script>

</body>
</html>
