<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MyReportDetail.aspx.vb" Inherits="PM_MyReportDetail" %>

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

        .HeaderFreez {
            position: relative;
            top: expression(this.offsetParent.scrollTop);
            z-index: 10;
        }

        .FloatingHeader th {
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
        #gvwMyTickets tr td{

            border-color:#B4BFC8;
            border-left  :none ;
            border-right:none;
            padding:5px;
            font-size:12px;
            
            background-color:white
        }
        table tr th{
        text-align:left;
          background-color: #B9DCFC;
          color:#7A9BC4!important;
          font-size:13px;
          padding:5px;
          
          
        }
        
          /*#ticketGrid td:first-child + td {
            padding-top:14px!important;

        }*/
         #ticketGrid td {
             padding-top:8px!important;
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
    </style>
</head>
<body style="margin: 0px; background-color: #E4F1F7;" onresize="AdjustHeight();">

    <form id="form1" runat="server">
        <asp:HiddenField ID="iddd" runat ="server" />
        <asp:HiddenField ID="UserId" runat ="server" />
        <div id="loader" runat="server" style="display:none ; position: absolute; top: 50%; left: 41%; background-color: lightblue;">
            <img src="../images/actionbar_loader.gif" /> 

        </div>
         <div id="DivTicketDetail" runat="server" style="position: absolute;top:0%;left:30%; display: none;width:350px;z-index: 102;height:508px; background-color:#C2E0FC;border:1px solid #609BD3;">
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
         <div style="height:270px; width:245px;margin:0 auto ;overflow-y:auto;" > 
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
                        <asp:Button ID="btnSaveTicket" runat="server" Text="Share" CssClass="Btn3D" style="text-align:center;padding-top:3px;margin-left:125px;margin-top:0px;margin-bottom:10px;" Width="80" Height="25" OnClick="btnSaveTicket_Click"  OnClientClick ="return ValidShare()"   />
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
        <asp:Button ID="Button1" runat="server" Text="Ok" Width="60" OnClick="Button1_Click" />
                  </td>
              </tr>
          
            </table>
       </div>

       <div id="DivTicketFlagRemove" runat="server" style="position: absolute; top:50%;left:35%; display:none;width:207px;z-index: 99;height: 61px; background-color:#A1CCEE;">
           <img src="../images/Delete.PNG" />
       </div>
        <div>
            <table width="98%" style="height: 100%; margin: 0px; padding: 0px; background-color: #E4F1F7;" cellspacing="0" cellpadding="0" border="0">
                <tr class="UnderlinedRow" style="height: 40px;">
                    <td style="background-color: #A0CDEE; font-size: 12px; font-weight: bold; width: 30%; padding-left: 10px;">
                     
                        <asp:Label ID="ReportName" runat="server" Text="Label"></asp:Label>
                         
               
                    </td>
                    <td style="background-color: #A0CDEE; padding: 5px; text-align: right;">
                        <asp:Button ID="btnReport" Text="Edit" runat="server" Font-Size="8" Style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2" OnClick="btnReport_Click"/>
                        <%--<asp:Button ID="btnExport" Text="Export to Excel" runat="server" Font-Size="8" Style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2" onclick="GenerateExcel();" />--%>
                        <asp:Button ID="btnShareReport" OnClick="btnShareReport_Click" Text="Share Report" runat="server" Font-Size="8" Style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2" />
                         <input runat ="server"  id="btnExport" type="button"  value="Export to Excel" Style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2;Font-Size:8pt;" onclick="GenerateExcel();" />
                        <%-- <input type="button" class="Btn3D" value="Delete Report" id="btnDelete" Style="margin-left: 10px; border: none; background-color: #D1ECFD!important; color: #6D8FB2;font-size:8pt;"  onclick ="ShowDiv();" />--%>
                     <%--<Button ID="btnDelete" value="Delete Report" Style="margin-left: 10px; border: none; background-color: #D1ECFD; color: #6D8FB2;Font-Size:8pt;" onclick="ShowDiv();" />--%>
                    </td>
                </tr>
                <tr>
                    <td style="width:50%;height:30px;background-color:#C1E0FC;padding-left:20px;font-size:12px;color:#758A9A">
<%-- Last Run On:00/00/00--%>
                    </td>
                    <td style="width:50%;height:30px;background-color:#C1E0FC;text-align:right;padding-right:20px;font-size:12px;color:#758A9A;">
                        Total Record:<asp:Label ID="lblTotalRecord" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="myc" style="background-color: #E4F1F7; margin: 0px; padding: 0px; vertical-align: top; height:395px;">
                        <div style=" overflow:auto;overflow-y:hidden;height: 470px; max-width:1120px; background-color: #E4F1F7; border: 1px solid #ACBDD5;" id="_gridViewPanel1" class="ScrollBarHomeTicket">
                         
                             
                                    <asp:GridView    ID="gvwMyTickets" runat="server"  Font-Size="12" style="max-height:395px;min-width:1100px;">

                                    </asp:GridView>
                               
                                             </ContentTemplate>
                       
                              </asp:UpdatePanel>
                        </div>
                    </td>
            </table>
        </div>
    </form>
    <script type="text/javascript" language="javascript">
        $( document ).ready(function() {
            setFocusToTextBox();
          
        });

        function doPostBack(o){
            __doPostBack(o.id);
        }
        Sys.Application.add_init(appl_init);
 
        function appl_init() {
            var pgRegMgr = Sys.WebForms.PageRequestManager.getInstance();
            pgRegMgr.add_endRequest(EndHandler);
        }
 
       
        function EndHandler() {           
            setFocusToTextBox();
        }
        function setFocusToTextBox(){
            var inputField = document.getElementById("TxtSearch");
            if (inputField != null && inputField.value.length != 0){
                if (inputField.createTextRange){
                    var FieldRange = inputField.createTextRange();
                    FieldRange.moveStart('character',inputField.value.length);
                    FieldRange.collapse();
                    FieldRange.select();
                }else if (inputField.selectionStart || inputField.selectionStart == '0') {
                    var elemLen = inputField.value.length;
                    inputField.selectionStart = elemLen;
                    inputField.selectionEnd = elemLen;
                    inputField.focus();
                }
            }else{
                inputField.focus();
            }
        }
        function GenerateExcel() {

            var userId=$('#UserId').val();

            var url = "../ExcelGenerator.ashx?Action=ShareReport&ID=" +<%=iddd.Value%> +"&UserId=" + userId;
            window.open(url);

        }




          var GridId = "<%=gvwMyTickets.ClientID %>";
    var ScrollHeight = 396;
    window.onload = function () {
        setTimeout(tablefixhead,10)
    }

    function tablefixhead() {
        var grid = document.getElementById(GridId);
        if (grid!=null){
            var gridWidth = grid.offsetWidth;
            var gridHeight = grid.offsetHeight;
            var headerCellWidths = new Array();
            for (var i = 0; i < grid.getElementsByTagName("TH").length; i++) {
                headerCellWidths[i] = grid.getElementsByTagName("TH")[i].offsetWidth;
            }
            grid.parentNode.appendChild(document.createElement("div"));
            var parentDiv = grid.parentNode;
 
            var table = document.createElement("table");
            for (i = 0; i < grid.attributes.length; i++) {
                if (grid.attributes[i].specified && grid.attributes[i].name != "id") {
                    table.setAttribute(grid.attributes[i].name, grid.attributes[i].value);
                }
            }
            table.style.cssText = grid.style.cssText;
            table.style.width = gridWidth + "px";
            table.appendChild(document.createElement("tbody"));
            table.getElementsByTagName("tbody")[0].appendChild(grid.getElementsByTagName("TR")[0]);
            var cells = table.getElementsByTagName("TH");
 
            var gridRow = grid.getElementsByTagName("TR")[0];
            for (var i = 0; i < cells.length; i++) {
                var width;
                if (headerCellWidths[i] > gridRow.getElementsByTagName("TD")[i].offsetWidth) {
                    width = headerCellWidths[i];
                }
                else {
                    width = gridRow.getElementsByTagName("TD")[i].offsetWidth;
                }
                cells[i].style.width = parseInt(width - 10) + "px";
                gridRow.getElementsByTagName("TD")[i].style.width = parseInt(width - 10) + "px";
            }
            parentDiv.removeChild(grid);
 
            var dummyHeader = document.createElement("div");
            dummyHeader.appendChild(table);
            parentDiv.appendChild(dummyHeader);
            var scrollableDiv = document.createElement("div");
            if (parseInt(gridHeight) > ScrollHeight) {
                gridWidth = parseInt(gridWidth) + 17;
            }
            scrollableDiv.style.cssText = "overflow:auto;height:" + ScrollHeight + "px;width:" + gridWidth + "px";
            scrollableDiv.appendChild(grid);
            parentDiv.appendChild(scrollableDiv);
        }
    }

        AdjustHeight();
        function AdjustHeight() {
            var client_height = $(window).height()-70;
            $('.myc').attr('style', 'height:' + client_height + 'px');
        }
        //$(document).ready(function () {
        //    var x = Number($('#iddd').val())
        //    if (x == 0) {
        //        var divTicketDetails = getElement('DivTicketFlagRemove');
        //        if (divTicketDetails.style.display == 'none') {
        //            CenterAlignDiv(document.getElementById('DivTicketFlagRemove'));
        //            divTicketDetails.style.display = 'inline';
        //        }
        //    }
        //    else {
        //        divTicketDetails.style.display = 'none';
        //    }
        //});
       function HideDiv() {
           $(<%= DivTicketDetail.ClientID %>).css('display', 'none');
           $('#TxtSearch').val(""); 

       }
     
     function ValidShare()
            
        {
            var CheckMe = false
             var GridView2 = document.getElementById("<%=ticketGrid.ClientID %>");
             for (i = 0; i < GridView2.rows.length; i++) {
                 if (GridView2.rows[i].cells[0].getElementsByTagName("INPUT")[0].checked) {
                     CheckMe = true

                 }
                

             }
             if (CheckMe == false) {
                 $('#PleaseSelect').css("display", "inline");
             }
            return CheckMe
        }
    </script>

</body>
</html>
