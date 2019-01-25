<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GroupManagement.aspx.vb"
    Inherits="LM_GroupManagement" %>

<!DocType HTML />
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Create new group</title>
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Style.css" />
    <link type="text/css" rel="stylesheet" href="../App_Themes/Default/Calendar/style.css" />
    <script type="text/javascript" language="javascript" src="../scripts/functions.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-en.js"></script>
    <script type="text/javascript" language="JavaScript" src="../scripts/calendar-fs.js"></script>
    <link rel="stylesheet" href="../jquery/styles/jqx.base.css" type="text/css" />
    <script type="text/javascript" src="../jquery/scripts/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="../jquery/styles/jqx.office.css" type="text/css" />
    <script type="text/javascript" src="../jquery/scripts/jqxcore.js"></script>
    <script type="text/javascript" src="../jquery/scripts/jqxdata.js"></script>
    <script type="text/javascript" src="../jquery/scripts/jqxbuttons.js"></script>
    <script type="text/javascript" src="../jquery/scripts/jqxscrollbar.js"></script>
    <script type="text/javascript" src="../jquery/scripts/jqxlistbox.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:HiddenField runat="server" ID="hdnUserID" />
    <input type="hidden" value="" id='GroupID'>
    <input type="hidden" value="" id='UpdateID'>
    <input type="hidden" value="" id='CountryID'>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <div  style="height: 470px; width: 620px;overflow-y:auto " class="GrayScrollBar">
    <table border="0" cellpadding="0" align="center" cellspacing="0" style="width: 100%;
        height: 100%; border: 0px;" class="tblAddFolder pad5px">
        <tr>
            <td style="width: 150px;">
                Title:<span class="RequiredField"> *</span>
            </td>
            <td>
                <asp:TextBox ID="txtTitle" runat="server" Width="200px" MaxLength="50"></asp:TextBox>
                &nbsp;
                <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ControlToValidate="txtTitle"
                    ValidationGroup="vgNewGroup" CssClass="RequiredField" Display="Dynamic" ErrorMessage="Required Title"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Nickname:
            </td>
            <td>
                <asp:TextBox ID="txtNickname" runat="server" Width="200px" MaxLength="50"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Threshold:
            </td>
            <td>
                <asp:DropDownList ID="ddlThreshold" CssClass="DarkBlackTextSmall" runat="server"
                    Width="205px" AutoPostBack="false">
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="6" Value="6" />
                    <asp:ListItem Text="7" Value="7" />
                    <asp:ListItem Text="8" Value="8" />
                    <asp:ListItem Text="9" Value="9" />
                    <asp:ListItem Text="10" Value="10" />
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                Mandatory:
            </td>
            <td style="padding-left: 1px;">
                <asp:CheckBox ID="chkIsMandatory" Style="font-size: 11px;" runat="server" Width="200px"
                    Text="" /></asp:checkBox>
            </td>
        </tr>
       
        <tr id="MandatoryUpdate">
            <td>
                Mandatory Date:
            </td>
            <td>
                <asp:TextBox ID="txtMandatorydate" runat="server" Width="175px" onfocus="img1.click();"
                    ReadOnly="true"></asp:TextBox>
                <img id="img1" align="absMiddle" border="0" onclick=" setActiveStyleSheet(this, 'winter'); return showCalendar('<%= txtMandatorydate.ClientID %>', '<%=System.Globalization.DateTimeFormatInfo.CurrentInfo.ShortDatePattern %>');"
                    onmouseover="style.cursor='hand';" src="../images/ico_calendar.jpg" />&nbsp;
                <asp:CustomValidator ID="rfvMandatorydate" runat="server" CssClass="RequiredField"
                    ClientValidationFunction="ValidateCheckBox" ErrorMessage="Required Mandatory Date"></asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td>
                Minor:
            </td>
            <td style="padding-left: 1px;">
                <asp:CheckBox ID="chkIsMinor" Style="font-size: 11px;" runat="server" Width="200px"
                              Text="" />
            </td>
        </tr>
        <tr id="BuildNumberUpdate">
            <td>
                Build Number:
            </td>
            <td>
                <asp:TextBox ID="txtBuildNumber" runat="server" Width="200px"
                            ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Status:
            </td>
            <td>
                <asp:DropDownList ID="ddlStatus" CssClass="DarkBlackTextSmall" runat="server" Width="205px"
                    AutoPostBack="false">
                    <asp:ListItem Text="Schedule" Value="1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="Not Schedule" Value="2"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="vertical-align: top; padding-top: 8px;">
                Select Store:
            </td>
            <td style="vertical-align: top; padding-top: 8px;">
                <%-- <div id="dvStore">--%>
                <table cellpadding="0" cellspacing="0" border="0" style="padding: 0px; margin: 0px;
                    float: left;">
                    <tr>
                        <td colspan="2" style="vertical-align: top; padding-top: 8px;">
                            Available Stores:
                        </td>
                        <td>
                        </td>
                        <td colspan="2" style="vertical-align: top; padding-top: 8px;">
                            Selected Stores:
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%--<input class='jqx-input' placeholder="Location" id='txtAssignedStores' type="text"
                                    style="height: 16px; float: left; width: 200px;" />--%>
                            <asp:TextBox ID="txtAvailableStores" Style="float: left;" placeholder="Location"
                                runat="server" Width="198px" MaxLength="50"></asp:TextBox>
                        </td>
                        <td>
                            <img src="../images/icn_search.jpg" />
                        </td>
                        <td>
                        </td>
                        <td>
                            <%--<input class='jqx-input' placeholder="Location" id='txtAssignedStores' type="text"
                                    style="height: 16px; float: left; width: 200px;" />--%>
                            <asp:TextBox ID="txtAssignedStores" Style="float: left;" placeholder="Location" runat="server"
                                Width="198px" MaxLength="50"></asp:TextBox>
                        </td>
                        <td>
                            <img src="../images/icn_search.jpg" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" rowspan="4">
                            <div id='jqxWAvailableStores'>
                            </div>
                        </td>
                        <td>
                            <input id="btnMoveRightAll" type="button" value=">>" style="width: 30px;" class="btnSilver" />
                        </td>
                        <td colspan="2" rowspan="4">
                            <div id='jqxWAssignedStores'>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btnMoveRightSelected" type="button" value=">" style="width: 30px" class="btnSilver" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btnMoveLeftSelected" type="button" value="<" style="width: 30px" class="btnSilver" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="btnMoveLeftAll" type="button" value="<<" style="width: 30px;" class="btnSilver" />
                        </td>
                    </tr>
                    <tr style="height: 70px; vertical-align: top;">
                        <td align="center" colspan="4" style="padding-bottom: 0px;">
                            <input id="btnSave" type="button" value="Save" class="btnSilver" validationgroup="vgNewGroup" />&nbsp;
                            <input id="btnCancel" type="button" value="Cancel" class="btnSilver" />
                        </td>
                    </tr>
                </table>
                <%-- </div>--%>
            </td>
        </tr>
    </table>
     </div>
    <script type="text/javascript">
        $(document).ready(function () {



            $('#GroupID').val(getParameterByName('GroupID'));
            if ($('#GroupID').val() == "") {
                $('#GroupID').val("0");
            }
            $('#UpdateID').val(getParameterByName('UpdateID'));
            $('#CountryID').val(getParameterByName('CountryID'));

            var arrLefttoRight = [];
            var arrRighttoLeft = [];
            var arrLefttoRight2 = [];
            var arrRighttoLeft2 = [];

            var sourceAssignedStore = {
                type: "GET",
                datatype: "json",
                datafields: [
                            { name: 'StoreID' },
                            { name: 'Number' },
                            { name: 'CityName' },
                            { name: 'StateName' },
                            { name: 'StateCode' },
                            { name: 'ZipCode' },
                            { name: 'StoreCompleteName' },
                            { name: 'GroupName' },
                            { name: 'Title' },
                            { name: 'Threshold' },
                            { name: 'StatusID' },
                            { name: 'UpdateMandatoryDate' },
                            { name: 'IsMandatory' },


                        ],
                url: 'GroupManagement.aspx/GetGroupStoresByGroupID',
                cache: false,
                root: 'StoreRecord',
                data: { countryID: $('#CountryID').val(),
                    groupID: $('#GroupID').val(),
                    updateID: $('#UpdateID').val()
                }
            };



            var dataAdapterAssignedStore = new $.jqx.dataAdapter(sourceAssignedStore, { contentType: 'application/json; charset=utf-8',
                downloadComplete: function (data, textStatus, jqXHR) {
                    if (data.d != undefined)
                        return data.d;
                }
            }
                );

            $("#jqxWAssignedStores").jqxListBox({ source: dataAdapterAssignedStore, displayMember: "StoreCompleteName", valueMember: "StoreID", width: 220, height: 175, theme: 'office', multipleextended: true });

            var sourceAvailableStore = {
                type: "GET",
                datatype: "json",
                datafields: [
                                        { name: 'StoreID' },
                                        { name: 'Number' },
                                        { name: 'CityName' },
                                        { name: 'StateName' },
                                        { name: 'StateCode' },
                                        { name: 'ZipCode' },
                                        { name: 'StoreCompleteName' }
                                    ],
                url: 'GroupManagement.aspx/GetAvailableStores',
                cache: false,
                root: 'StoreRecord',
                data: { countryID: $('#CountryID').val(),
                    updateID: $('#UpdateID').val()
                }
            };



            var dataAdapterAvailableStore = new $.jqx.dataAdapter(sourceAvailableStore, { contentType: 'application/json; charset=utf-8',
                downloadComplete: function (data, textStatus, jqXHR) {
                    if (data.d != undefined)
                        return data.d;
                }
            }
                );

            $("#jqxWAvailableStores").jqxListBox({ source: dataAdapterAvailableStore, displayMember: "StoreCompleteName", valueMember: "StoreID", width: 220, height: 175, theme: 'office', multipleextended: true });


            $("#jqxWAssignedStores").on('bindingComplete', function (event) {
                if ($('#txtTitle').val() == "") {
                    if (dataAdapterAssignedStore.records[0].StoreID == null) {
                        dataAdapterAssignedStore.records.splice(0, 1);
                        $("#jqxWAssignedStores").jqxListBox('removeAt', 0);

                    }
                    if (dataAdapterAssignedStore.records.length > 0) {
                        $('#txtTitle').val(dataAdapterAssignedStore.records[0].Title);
                        $('#txtNickname').val(dataAdapterAssignedStore.records[0].GroupName);
                        $('#ddlThreshold').val(dataAdapterAssignedStore.records[0].Threshold);
                        $('#txtMandatorydate').val(dataAdapterAssignedStore.records[0].UpdateMandatoryDate);
                        $('#ddlStatus').val(dataAdapterAssignedStore.records[0].StatusID);
                        if (dataAdapterAssignedStore.records[0].IsMandatory == false) {
                            $('#chkIsMandatory').prop('checked', false);
                        }
                        else if (dataAdapterAssignedStore.records[0].IsMandatory == true) {
                            $('#chkIsMandatory').prop('checked', true);
                        }
                    }
                }
                if ($('#chkIsMandatory').is(":checked")) {
                    $('#MandatoryUpdate').show();
                }
                else {
                    $('#MandatoryUpdate').hide();
                }

                if ($('#chkIsMinor').is(":checked")) {
                    $('#BuildNumberUpdate').show();
                }
                else {
                    $('#BuildNumberUpdate').hide();
                }
            });

            $('#btnMoveRightSelected').on('click', function () {
                arrLefttoRight = [];
                arrLefttoRight2 = [];
                //var items = $("#jqxWAvailableStores").jqxListBox('getItems');
                var items = $("#jqxWAvailableStores").jqxListBox('getSelectedItems');
                var selectedIndexes = $("#jqxWAvailableStores").jqxListBox('selectedIndexes');
                if (items == undefined || items == null || items.length == 0)
                    return false;

                //var itemsLength = items.length;
                //$("#jqxWAssignedStores").jqxListBox('beginUpdate');
                //$("#jqxWAvailableStores").jqxListBox('beginUpdate');
                for (var index = 0; index < items.length; index++) {
                    //if (index != -1 && dataAdapterAvailableStore.records.length > 0 && index != "indexOf" && items[index] != undefined) {
                    var item = items[index];

                    var objStore = $.grep(dataAdapterAvailableStore.records, function (e) { return e.StoreID == item.value; })[0];
                    if (objStore != undefined) {
                        item.StoreID = objStore.StoreID;
                        item.Number = objStore.Number;
                        item.StoreCompleteName = objStore.StoreCompleteName;
                        item.CityName = objStore.CityName;
                        item.StateCode = objStore.StateCode;
                        item.ZipCode = objStore.ZipCode;

                        //$("#jqxWAssignedStores").jqxListBox('addItem', item);//
                        dataAdapterAssignedStore.records.push(item);
                        arrLefttoRight.push(item.index);
                        arrLefttoRight2.push(objStore.StoreID);
                    }
                    //}

                };
                //dataAdapterAssignedStore.records.sort();
                dataAdapterAssignedStore.records.sortBy(function (e) { return e.Number });
                var i = arrLefttoRight.length;
                while (i--) {
                    //var objStore = $.grep(dataAdapterAvailableStore.records, function (e) { return e.uid == arrLefttoRight[i]; })[0];
                    //dataAdapterAvailableStore.records.splice(arrLefttoRight2[i], 1);
                    dataAdapterAvailableStore.records = $.grep(dataAdapterAvailableStore.records, function (e) {
                        return e.StoreID != arrLefttoRight2[i];
                    });
                    //$("#jqxWAvailableStores").jqxListBox('removeItem', objStore.StoreCompleteName);

                    $("#jqxWAvailableStores").jqxListBox('removeAt', arrLefttoRight[i]); //
                }



                $("#jqxWAssignedStores").jqxListBox('beginUpdate');
                var itms = $("#jqxWAssignedStores").jqxListBox('getItems');
                if (itms != undefined && itms != null > 0) {
                    $("#jqxWAssignedStores").jqxListBox('clear');
                }

                for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                    $("#jqxWAssignedStores").jqxListBox('addItem', dataAdapterAssignedStore.records[i]);
                }
                $("#jqxWAssignedStores").jqxListBox('endUpdate');





                $('#jqxWAvailableStores').jqxListBox('clearSelection');
                //$("#jqxWAssignedStores").jqxListBox('endUpdate');
                //$("#jqxWAvailableStores").jqxListBox('endUpdate');

            });

            $('#btnMoveLeftSelected').on('click', function () {
                arrRighttoLeft = [];
                arrRighttoLeft2 = [];
                var items = $("#jqxWAssignedStores").jqxListBox('getSelectedItems');
                var selectedIndexes = $("#jqxWAssignedStores").jqxListBox('selectedIndexes');
                if (items == undefined || items == null || items.length == 0)
                    return false;
                //$("#jqxWAssignedStores").jqxListBox('beginUpdate');
                //$("#jqxWAvailableStores").jqxListBox('beginUpdate');
                for (var index = 0; index < items.length; index++) {
                    //if (index != -1 && dataAdapterAssignedStore.records.length > 0 && index != "indexOf" && selectedIndexes[index] != -1) {
                    var item = items[index];
                    var objStore = $.grep(dataAdapterAssignedStore.records, function (e) { return e.StoreID == item.value; })[0];
                    if (objStore != undefined) {
                        item.StoreID = objStore.StoreID;
                        item.Number = objStore.Number;
                        item.StoreCompleteName = objStore.StoreCompleteName;
                        item.CityName = objStore.CityName;
                        item.StateCode = objStore.StateCode;
                        item.ZipCode = objStore.ZipCode;

                        //$("#jqxWAvailableStores").jqxListBox('addItem', item);
                        dataAdapterAvailableStore.records.push(item);
                        arrRighttoLeft.push(item.index);
                        arrRighttoLeft2.push(objStore.StoreID);
                    }

                    //}

                };
                dataAdapterAvailableStore.records.sortBy(function (e) { return e.Number });
                var i = arrRighttoLeft.length;
                while (i--) {
                    //dataAdapterAssignedStore.records.splice(arrRighttoLeft2[i], 1);
                    dataAdapterAssignedStore.records = $.grep(dataAdapterAssignedStore.records, function (e) {
                        return e.StoreID != arrRighttoLeft2[i];
                    });
                    // dataAdapterAssignedStore.records.splice(arrRighttoLeft2[i], 1);
                    $("#jqxWAssignedStores").jqxListBox('removeAt', arrRighttoLeft[i]);
                }

                $("#jqxWAvailableStores").jqxListBox('beginUpdate');
                var itms = $("#jqxWAvailableStores").jqxListBox('getItems');
                if (itms != undefined && itms != null > 0) {
                    $("#jqxWAvailableStores").jqxListBox('clear');
                }
                for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                    $("#jqxWAvailableStores").jqxListBox('addItem', dataAdapterAvailableStore.records[i]);
                }
                $("#jqxWAvailableStores").jqxListBox('endUpdate');


                $('#jqxWAssignedStores').jqxListBox('clearSelection');
                //$("#jqxWAssignedStores").jqxListBox('endUpdate');
                //$("#jqxWAvailableStores").jqxListBox('endUpdate');
            });

            $('#btnMoveRightAll').on('click', function () {
                arrLefttoRight = [];
                var items = $("#jqxWAvailableStores").jqxListBox('getItems');
                if (items == undefined || items == null || items.length == 0)
                    return false;

                //$("#jqxWAssignedStores").jqxListBox('beginUpdate');
                for (var index = 0; index < items.length; index++) {
                    var item = items[index];


                    var objStore = $.grep(dataAdapterAvailableStore.records, function (e) { return e.StoreID == item.value; })[0];
                    if (objStore != undefined) {
                        item.StoreID = objStore.StoreID;
                        item.Number = objStore.Number;
                        item.StoreCompleteName = objStore.StoreCompleteName;
                        item.CityName = objStore.CityName;
                        item.StateCode = objStore.StateCode;
                        item.ZipCode = objStore.ZipCode;
                        //$("#jqxWAssignedStores").jqxListBox('addItem', item);
                        dataAdapterAssignedStore.records.push(item);
                        arrLefttoRight.push(objStore.StoreID);
                    }


                };
                dataAdapterAssignedStore.records.sortBy(function (e) { return e.Number });
                var i = arrLefttoRight.length;
                while (i--) {
                    dataAdapterAvailableStore.records = $.grep(dataAdapterAvailableStore.records, function (e) {
                        return e.StoreID != arrLefttoRight[i];
                    });
                    //dataAdapterAvailableStore.records.splice(arrLefttoRight[i], 1);
                }

                $("#jqxWAssignedStores").jqxListBox('beginUpdate');
                var itms = $("#jqxWAssignedStores").jqxListBox('getItems');
                if (itms != undefined && itms != null > 0) {
                    $("#jqxWAssignedStores").jqxListBox('clear');
                }
                for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                    $("#jqxWAssignedStores").jqxListBox('addItem', dataAdapterAssignedStore.records[i]);
                }
                $("#jqxWAssignedStores").jqxListBox('endUpdate');

                itms = $("#jqxWAvailableStores").jqxListBox('getItems');
                if (itms != undefined && itms != null > 0) {
                    $("#jqxWAvailableStores").jqxListBox('clear');
                }

                //$("#jqxWAssignedStores").jqxListBox('refresh');
                //$("#jqxWAssignedStores").jqxListBox('endUpdate');

            });

            $('#btnMoveLeftAll').on('click', function () {
                arrRighttoLeft = [];
                var items = $("#jqxWAssignedStores").jqxListBox('getItems');
                if (items == undefined || items == null || items.length == 0)
                    return false;

                //$("#jqxWAvailableStores").jqxListBox('beginUpdate');
                for (var index = 0; index < items.length; index++) {
                    var item = items[index];

                    //                    var objStore = dataAdapterAssignedStore.records.filter(function (obj) {
                    //                        return obj.StoreID === item.value;
                    //                    })[0];
                    var objStore = $.grep(dataAdapterAssignedStore.records, function (e) { return e.StoreID == item.value; })[0];

                    if (objStore != undefined) {
                        item.StoreID = objStore.StoreID;
                        item.Number = objStore.Number;
                        item.StoreCompleteName = objStore.StoreCompleteName;
                        item.CityName = objStore.CityName;
                        item.StateCode = objStore.StateCode;
                        item.ZipCode = objStore.ZipCode;

                        //$("#jqxWAvailableStores").jqxListBox('addItem', item);
                        dataAdapterAvailableStore.records.push(item);
                        arrRighttoLeft.push(objStore.StoreID);
                    }
                };
                dataAdapterAvailableStore.records.sortBy(function (e) { return e.Number });
                var i = arrRighttoLeft.length;
                while (i--) {
                    //dataAdapterAssignedStore.records.splice(arrRighttoLeft[i], 1);
                    dataAdapterAssignedStore.records = $.grep(dataAdapterAssignedStore.records, function (e) {
                        return e.StoreID != arrRighttoLeft[i];
                    });
                }
                $("#jqxWAvailableStores").jqxListBox('beginUpdate');
                var itms = $("#jqxWAvailableStores").jqxListBox('getItems');
                if (itms != undefined && itms != null > 0) {
                    $("#jqxWAvailableStores").jqxListBox('clear');
                }

                for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                    $("#jqxWAvailableStores").jqxListBox('addItem', dataAdapterAvailableStore.records[i]);
                }
                $("#jqxWAvailableStores").jqxListBox('endUpdate');

                itms = $("#jqxWAssignedStores").jqxListBox('getItems');
                if (itms != undefined && itms != null > 0) {
                    $("#jqxWAssignedStores").jqxListBox('clear');
                }

                //$("#jqxWAvailableStores").jqxListBox('endUpdate');
                //$("#jqxWAvailableStores").jqxListBox('refresh');
                

            });

            if ($(this).is(":checked")) {
                $('#MandatoryUpdate').show();
            }
            else {
                $('#MandatoryUpdate').hide();
            }
            if ($(this).is(":checked")) {
                $('#BuildNumberUpdate').show();
            }
            else {
                $('#BuildNumberUpdate').hide();
            }
            $('#txtAvailableStores').on('keyup', function () {
                delay(function () {
                    var searchVal = $('#txtAvailableStores').val();
                    if (searchVal.length == 0) {
                        $("#jqxWAvailableStores").jqxListBox('beginUpdate');
                        var itms = $("#jqxWAvailableStores").jqxListBox('getItems');
                        if (itms != undefined && itms != null > 0) {
                            $("#jqxWAvailableStores").jqxListBox('clear');
                        }

                        for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                            $("#jqxWAvailableStores").jqxListBox('addItem', dataAdapterAvailableStore.records[i]);
                        }
                        $("#jqxWAvailableStores").jqxListBox('endUpdate');
                        return false;
                    }
                    if (searchVal.length < 2 & searchVal.length > 0) {
                        return false;
                    }

                    //var dataAdapterAvailableStore2 = new $.jqx.dataAdapter(sourceAvailableStore, { contentType: 'application/json; charset=utf-8' });
                    var itms = $("#jqxWAvailableStores").jqxListBox('getItems');
                    if (itms != undefined && itms != null > 0) {
                        $("#jqxWAvailableStores").jqxListBox('clear');
                    }

                    var regexOnlyAlphabets = new RegExp(/^[A-Za-z ]+$/);


                    if (isNumeric(searchVal)) {


                        if (searchVal.length == 5) {
                            for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                                if (dataAdapterAvailableStore.records[i].ZipCode == searchVal) {
                                    $("#jqxWAvailableStores").jqxListBox('addItem', { label: dataAdapterAvailableStore.records[i].StoreCompleteName, value: dataAdapterAvailableStore.records[i].StoreID });
                                }
                            }
                        }

                        if (searchVal.length < 5) {
                            for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                                if (dataAdapterAvailableStore.records[i].Number == searchVal) {
                                    $("#jqxWAvailableStores").jqxListBox('addItem', { label: dataAdapterAvailableStore.records[i].StoreCompleteName, value: dataAdapterAvailableStore.records[i].StoreID });
                                }
                            }
                        }
                    }
                    else if (regexOnlyAlphabets.test(searchVal)) {
                        if (searchVal.length == 2) {
                            for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                                if (dataAdapterAvailableStore.records[i].StateCode == searchVal) {
                                    $("#jqxWAvailableStores").jqxListBox('addItem', { label: dataAdapterAvailableStore.records[i].StoreCompleteName, value: dataAdapterAvailableStore.records[i].StoreID });
                                }
                            }

                        }
                        else if (searchVal.length > 2) {
                            if ($('#CountryID').val() == 1) {
                                for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                                    if (dataAdapterAvailableStore.records[i].CityName.substr(0, searchVal.length).toUpperCase() == searchVal.toUpperCase() ||
                                    dataAdapterAvailableStore.records[i].ZipCode.substr(0, searchVal.length).toUpperCase() == searchVal.toUpperCase()) {
                                        $("#jqxWAvailableStores").jqxListBox('addItem', { label: dataAdapterAvailableStore.records[i].StoreCompleteName, value: dataAdapterAvailableStore.records[i].StoreID });
                                    }
                                }
                            }
                            else if ($('#CountryID').val() == 2) {
                                for (var i = 0; i < dataAdapterAvailableStore.records.length; i++) {
                                    if (dataAdapterAvailableStore.records[i].CityName.substr(0, searchVal.length).toUpperCase() == searchVal.toUpperCase()) {
                                        $("#jqxWAvailableStores").jqxListBox('addItem', { label: dataAdapterAvailableStore.records[i].StoreCompleteName, value: dataAdapterAvailableStore.records[i].StoreID });
                                    }
                                }

                            }
                        }
                    }



                }, 0);
            });

            $('#txtAssignedStores').on('keyup', function () {
                delay(function () {
                    var searchVal = $('#txtAssignedStores').val();
                    if (searchVal.length == 0) {
                        $("#jqxWAssignedStores").jqxListBox('beginUpdate');
                        var itms = $("#jqxWAssignedStores").jqxListBox('getItems');
                        if (itms != undefined && itms != null > 0) {
                            $("#jqxWAssignedStores").jqxListBox('clear');
                        }

                        for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                            $("#jqxWAssignedStores").jqxListBox('addItem', dataAdapterAssignedStore.records[i]);
                        }
                        $("#jqxWAssignedStores").jqxListBox('endUpdate');
                        return false;
                    }
                    if (searchVal.length < 2 & searchVal.length > 0) {
                        return false;
                    }
                    var itms = $("#jqxWAssignedStores").jqxListBox('getItems');
                    if (itms != undefined && itms != null > 0) {
                        $("#jqxWAssignedStores").jqxListBox('clear');
                    }
                    var regexOnlyAlphabets = new RegExp(/^[A-Za-z ]+$/);


                    if (isNumeric(searchVal)) {


                        if (searchVal.length == 5) {
                            for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                                if (dataAdapterAssignedStore.records[i].ZipCode == searchVal) {
                                    $("#jqxWAssignedStores").jqxListBox('addItem', { label: dataAdapterAssignedStore.records[i].StoreCompleteName, value: dataAdapterAssignedStore.records[i].StoreID });
                                }
                            }
                        }

                        if (searchVal.length < 5) {
                            for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                                if (dataAdapterAssignedStore.records[i].Number == searchVal) {
                                    $("#jqxWAssignedStores").jqxListBox('addItem', { label: dataAdapterAssignedStore.records[i].StoreCompleteName, value: dataAdapterAssignedStore.records[i].StoreID });
                                }
                            }
                        }
                    }
                    else if (regexOnlyAlphabets.test(searchVal)) {
                        if (searchVal.length == 2) {
                            for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                                if (dataAdapterAssignedStore.records[i].StateCode == searchVal) {
                                    $("#jqxWAssignedStores").jqxListBox('addItem', { label: dataAdapterAssignedStore.records[i].StoreCompleteName, value: dataAdapterAssignedStore.records[i].StoreID });
                                }
                            }

                        }
                        else if (searchVal.length > 2) {
                            if ($('#CountryID').val() == 1) {
                                for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                                    if (dataAdapterAssignedStore.records[i].CityName.substr(0, searchVal.length).toUpperCase() == searchVal.toUpperCase() ||
                                    dataAdapterAssignedStore.records[i].ZipCode.substr(0, searchVal.length).toUpperCase() == searchVal.toUpperCase()) {
                                        $("#jqxWAssignedStores").jqxListBox('addItem', { label: dataAdapterAssignedStore.records[i].StoreCompleteName, value: dataAdapterAssignedStore.records[i].StoreID });
                                    }
                                }
                            }
                            else if ($('#CountryID').val() == 2) {
                                for (var i = 0; i < dataAdapterAssignedStore.records.length; i++) {
                                    if (dataAdapterAssignedStore.records[i].CityName.substr(0, searchVal.length).toUpperCase() == searchVal.toUpperCase()) {
                                        $("#jqxWAssignedStores").jqxListBox('addItem', { label: dataAdapterAssignedStore.records[i].StoreCompleteName, value: dataAdapterAssignedStore.records[i].StoreID });
                                    }
                                }

                            }
                        }
                    }



                }, 0);
            });



            function isNumeric(n) {
                return !isNaN(parseFloat(n)) && isFinite(n);
            }
            
            (function () {
                if (typeof Object.defineProperty === 'function') {
                    try { Object.defineProperty(Array.prototype, 'sortBy', { value: sb }); } catch (e) { }
                }
                if (!Array.prototype.sortBy) Array.prototype.sortBy = sb;

                function sb(f) {
                    for (var i = this.length; i; ) {
                        var o = this[--i];
                        this[i] = [].concat(f.call(o, o, i), o);
                    }
                    this.sort(function (a, b) {
                        for (var i = 0, len = a.length; i < len; ++i) {
                            if (a[i] != b[i]) return a[i] < b[i] ? -1 : 1;
                        }
                        return 0;
                    });
                    for (var i = this.length; i; ) {
                        this[--i] = this[i][this[i].length - 1];
                    }
                    return this;
                }
            })();

            $("#btnSave").click(function () {

                if (!Page_ClientValidate())
                    return false;
                var arrStoreID = [];
                var items = $("#jqxWAssignedStores").jqxListBox('getItems');
                if (items != undefined && items != null) {
                    var length = items.length;
                    for (var i = 0; i < length; i++) {
                        arrStoreID[i] = items[i].value;
                    }
                }
                else {
                    arrStoreID[0] = 0;
                }
                var Parameters = "{\"arrStoreID\":[" + arrStoreID + "],\"groupTitle\":\"" + $("#txtTitle").val() + "\",\"statusID\":\"" + $("#ddlStatus").val() + "\",\"name\":\"" + $("#txtNickname").val() + "\",\"threshold\":\"" + $("#ddlThreshold").val() + "\",\"updateMandatoryDate\":\"" + $("#txtMandatorydate").val() + "\",\"isMandatory\":" + $("#chkIsMandatory").is(':checked') + ",\"isMinor\":" + $("#chkIsMinor").is(':checked') + ",\"groupID\":\"" + $('#GroupID').val() + "\",\"updateID\":\"" + $('#UpdateID').val() + "\",\"countryID\":\"" + $('#CountryID').val() + "\",\"userID\":\"" + $('#hdnUserID').val() + "\",\"build_no\":\"" + $('#txtBuildNumber').val() + "\"}"

                $.ajax({
                    type: "POST",
                    url: "GroupManagement.aspx/AddUpdateGroupStores",
                    data: Parameters,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        parent.CloseNewGroupDiv();
                        parent.RebindRecords();
                    },
                    failure: function (response) {
                        //alert(response.d);
                    }
                });

            });

            $('#chkIsMandatory').change(function () {
                if ($(this).is(":checked")) {
                    $('#MandatoryUpdate').show();
                }
                else {
                    $('#MandatoryUpdate').hide();
                }

            });

            $('#chkIsMinor').change(function () {
                if ($(this).is(":checked")) {
                    $('#BuildNumberUpdate').show();
                }
                else {
                    $('#BuildNumberUpdate').hide();
                }

            });
            var delay = (function () {
                var timer = 0;
                return function (callback, ms) {
                    clearTimeout(timer);
                    timer = setTimeout(callback, ms);
                };
            })();


            function getParameterByName(name) {
                name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
                var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
                return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
            }

            $("#btnCancel").click(function () {
                parent.CloseNewGroupDiv();
                $('#txtTitle').val("");
                $('#txtNickname').val("");
                $('#ddlThreshold').val("1");
                $('#chkIsMandatory').prop('checked', false);
                $('#txtMandatorydate').val("1");

                $('#ddlStatus').val("1");
                $('#txtAvailableStores').val("");
                $('#txtAssignedStores').val("");
                $('#MandatoryUpdate').hide();
                $('#BuildNumberUpdate').hide();
                var items = $("#jqxWAvailableStores").jqxListBox('getItems');
                if (items != undefined && items != null > 0) {
                    if (dataAdapterAvailableStore.records[0].StoreCompleteName != null && dataAdapterAvailableStore.records[0].StoreCompleteName != undefined) {
                        $("#jqxWAvailableStores").jqxListBox('clear');
                    }

                }
                var items = $("#jqxWAssignedStores").jqxListBox('getItems');
                if (items != undefined && items != null > 0) {
                    if (dataAdapterAssignedStore.records[0].StoreCompleteName != null && dataAdapterAssignedStore.records[0].StoreCompleteName != undefined) {
                        $("#jqxWAssignedStores").jqxListBox('clear');
                    }

                }





            });
        });
        

    </script>
    <script language="javascript" type="text/javascript">
        function ValidateCheckBox(Source, args) {
            var chkMandatory = document.getElementById('<%= chkIsMandatory.ClientID %>');
            var txtMandDate = document.getElementById('<%= txtMandatoryDate.ClientID %>');
            if (chkMandatory.checked != false) {
                if (txtMandDate.value == "")
                    args.IsValid = false;
                else
                    args.IsValid = true;
            }
        } 
    </script>
    </form>
</body>
</html>