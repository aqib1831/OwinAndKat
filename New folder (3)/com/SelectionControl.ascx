						  			  						  				   <%@ Control Language="VB" AutoEventWireup="false" CodeFile="SelectionControl.ascx.vb" Inherits="com_SelectionControl" %>

<asp:Panel ID="SelectionCtrlMainPanel"  runat="server">
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td align="center" style=" text-align:left;">
    <table id="selectionCtrlTbl" border="0" cellpadding="0" cellspacing="0" >
        <tr id="selectionCtrlTblTr">
            <td id="leftLbTd">
            <asp:Panel ID="leftHeader" CssClass="selectionCtrlHeaderStyle" runat="server">Store(s)</asp:Panel>
                <div id="selectionLeftDiv"  runat ="server" class="selectionCtrlScrlDiv">
                <table id ="selectionLftTbl" runat="server" style="overflow-x:hidden;" cellpadding="0" cellspacing="0">
                </table>
                </div>
            </td>
            <td id="middleTd">
                <input id="forwardBtn" type="button" value=">" onclick="shiftSelectedItemsToRight()" /><br />
                <%--<input id="forwardAllBtn" type="button" value=">>" onclick="shiftAllItemsToRight()" /><br />--%>
                <input id="backwardBtn" type="button" value="<" onclick="shiftSelectedItemsToLeft()"/><br />
                <%--<input id="backwardAllBtn" type="button" value="<<" onclick="shiftAllItemsToLeft()"/>--%>
            </td>
            <td id="rightLbTd">
            <asp:Panel ID="rightHeader" CssClass="selectionCtrlHeaderStyle" runat="server">Selected Store(s)</asp:Panel>
                <div id="selectionRightDiv" runat ="server" class="selectionCtrlScrlDiv">
                 <table id ="selectionRtTbl" cellpadding="0" cellspacing="0">
                 <tr id="0All">
                    <td>All Stores</td>
                 </tr>
                </table>
                </div>
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="SelectedValuesField" runat="server"  />
    <asp:HiddenField ID="SelectedNamesField" runat="server"  />
</td>
</tr>
    </table>
</asp:Panel>



<!--CSS-->
<style type="text/css">
    .selectedStore
    {
        background-color:#A0CDEE;
    }
    #selectionCtrlTbl
    {
    	width:100%;
    	height:100%;
    	
    }
    #selectionCtrlTblTr table td
    {
        height:20px;
    }
    #selectionCtrlTbl td table
    {
    	width:100%;

    }
     #selectionCtrlTbl #middleTd
     {
     	text-align : center;
     }
     #selectionRightDiv div div
     {
         
     }
    #selectionCtrlTbl #middleTd input
    {
    	width:25px;
    	padding:0px;
    	font-weight:bold;
    }
    #selectionCtrlTbl #middleTd
    {
    	width:27px;
    }
    .selectionCtrlScrlDiv
    {
        border:1px solid #B2C3D3;
        height:205px;
        background-image:url('../images/selCtrlSlice.png');
    	background-repeat:repeat;   
    }
    #selectionCtrlTbl td div
    {
    	overflow-y:auto;
    	overflow-x:hidden;
    }
    #selectionCtrlTbl #leftLbTd,#rightLbTd
    {
        border: 1px solid #A0CDEE;
    	width:50%;
    	padding:0px;
    }
    #selectionCtrlTbl td
    {
        font-size:12px;
        border-bottom:1px solid #ECECEC;
    }
    #selectionCtrlTbl td table
    {
        background-color:White;
    }

    
     #selectionCtrlTbl td table tr td
     {
        vertical-align:middle;
        font-size:11px;
        height:19px;
        cursor:default;
        border-bottom: 1px solid #ECECEC;
        padding-left:4px;
        color:Black;
     }
    
    #selectionCtrlTbl td table tr:hover
    {
    	background-color:#DEEEFD;

    }
    .selectionCtrlHeaderStyle
    {
        height:15px;
        background-color:#DEEEFD;
        padding-left:5px;
        padding-top:2px;
        width:180px;
    }

</style>

<script type="text/javascript">
    var selectionSelectedIndicesLeft = [];
    var selectionSelectedIndicesRight = [];
    function testCtrl() {
        var valText = document.getElementById("<%=SelectedValuesField.ClientID %>").value;
        document.getElementById("Text1").value = valText;
        var valText = document.getElementById("<%=SelectedNamesField.ClientID %>").value;
        document.getElementById("Text2").value = valText;

    }
    function onSelectionRowSelectionLeft(row) {
        if ($(row).attr("class") == "selectedStore") {
            $(row).removeClass("selectedStore"); 
        }
        else {
            $(row).addClass("selectedStore"); 
        }
    }

    function onSelectionRowSelectionRight(row) {
        if ($(row).attr("class") == "selectedStore") {
            $(row).removeClass("selectedStore");
        }
        else {
            $(row).addClass("selectedStore");
        }
    }

    function findArrayIndexByValue(arr, value) {
        for (var i = 0; i < arr.length; i++) {
            if (arr[i] == value) {
                return i;
            }
        }
        return -1; //not found
    }

    function shiftSelectedItemsToRight() {

      
        $("[id$=selectionLftTbl] tr.selectedStore").each(function() {
            $(this).removeClass("selectedStore");
            $("[id$=selectionRtTbl]").append(this);
            $("#0All").css("display", "none");
       });
      
      
    }

    function shiftSelectedItemsToLeft() {
       
        $("[id$=selectionRtTbl] tr.selectedStore").each(function() {
            $(this).removeClass("selectedStore");
            $("[id$=selectionLftTbl]").append(this);

        });
        
        if ($("[id$=selectionRtTbl] tr").length == 1) {
            $("#0All").css("display", "block");
        }
    }

    function shiftAllItemsToRight() {
        try {
      
            $("[id$=selectionLftTbl] tr").each(function(i) {
            if ((i == 150) || (i == 300) || (i == 450) || (i == 600) || (i == 750) || (i == 900) || (i == 1050) || (i == 1200) || (i == 1350 || (i == 1500)))
                setTimeout("", 100);
                $(this).removeClass("selectedStore");
                $("[id$=selectionRtTbl]").append(this);
            });
            $("[id$=selectionLftTbl]").empty();
            
        }
        catch(e){
        }
    }

    function shiftAllItemsToLeft() {
        try {
     
            $("[id$=selectionRtTbl] tr").each(function(i) {
                $(this).removeClass("selectedStore");
                if ((i == 150) || (i == 300) || (i == 450) || (i == 600) || (i == 750) || (i == 900) || (i == 1050) || (i == 1200) || (i == 1350 || (i == 1500)))
                    setTimeout("", 100);
                $("[id$=selectionLftTbl]").append(this);

            });
            $("[id$=selectionRtTbl]").empty();
        }
        catch (ex) {
        }
    }
 

</script>

