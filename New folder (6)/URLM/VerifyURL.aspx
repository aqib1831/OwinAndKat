<%@ Page Language="VB" AutoEventWireup="false" CodeFile="VerifyURL.aspx.vb" Inherits="URLM_VerifyURL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verify URL</title>
    
    <script src="../scripts/jquery-1.11.2.min.js"></script>

    <script type="text/javascript">

        var hdnurlIdarray;
        var hdnUrlarry;

        var i = 0;
        function CallCheckApiExpiry() {
            
            $('#btnStarUpdate').attr('disabled', 'disabled');
            $('#result').css('display', 'block');

            hdnurlIdarray = $('#hdnurlIdarray').val().split(",");
            hdnUrlarry = $("#hdnUrlarry").val().split(",");

            
            if (i < (hdnUrlarry.length - 1)) {
                if (learnRegExp(hdnUrlarry[i]) == true) {
                    CheckApiExpiry(hdnurlIdarray[i], hdnUrlarry[i] ,i);
                 
                }

                setTimeout(function () {
                    CallCheckApiExpiry();
                    i++;
                }, 30000); // 120000: Dely is 70 Second.
            }

            
            if (i == (hdnUrlarry.length - 1))
            {
                
                $('#btnStarUpdate').removeAttr('disabled');
                $('#hdnurlIdarray').val('');
                $("#hdnUrlarry").val('');
                hdnUrlarry = '';
                hdnurlIdarray = '';
            }

        }
        function CheckApiExpiry(urlID, url ,IterationID) {
	    
            $('#dvUrlExpirayDate').html('');
            $('#dvUrlName').html('');
            $('#dvUrlID').html('');
            $('#dvUrlStatus').html('');
            
		
            try {

		
                var r = "whois";	// check availability
	        var apikey = "e6ef867be03e0cad92a3c716497bf52f";	// your API key
                // var apikey = "demokey";	// your API key
                // API call
		var i = 0;
		$('#dvUrlStatus').html("Call # "+ i);
		i = i + 1; 		
                $.getJSON('http://api.whoapi.com/?domain=' + url + '&r=' + r + '&apikey=' + apikey + '&nocache= '+ GetGUID(),
                function (dataObj) {
                    if (dataObj.status == 0) {
                        // show the result
                        var datetime= dataObj.date_expires
                        var date1 = datetime.split(' ')[0];
                        $('#dvUrlID').html(urlID);
                        $('#dvUrlName').html(url);
                        $('#dvUrlExpirayDate').html(date1);
                        UpdateExpirayDate(date1, urlID, url);

                    }
                    else {
                        // show error
                        if (IterationID != 0)
                        {
                            $('#rejectedItems').html($('#rejectedItems').html() + " <br />" + url + ":" + dataObj.status_desc)
                            $('#rejectedItems').css('display', 'inline-block');
                            //$('#result').html(dataObj.status_desc);
                        }
                        

                    }
                });
            }
            catch (ex) {
                alert(ex);
                // UpdateError(urlID, ex);
            }


        }

        function UpdateExpirayDate(expDate, urlID, url) {

            $.post("UpdateExpiryHandler.ashx?expDate=" + expDate + "&URLID=" + urlID + "&URL=" + url + "&nocache=" + GetGUID(),
        {
        },
        function (StrReturnHtml) {
            if (StrReturnHtml == "Success") {
                $('#dvUrlStatus').html("Update " + StrReturnHtml + "")
                $('#verifiedURL').html($('#verifiedURL').html() + " <br />" + url + ": &nbsp;&nbsp;&nbsp;&nbsp;" + expDate)
                $('#verifiedURL').css('display', 'inline-block');
            }
        });
        }

        function UpdateError(urlID, ErrorMessage) {

            $('#hdnErrorOnUpdate').val(ErrorMessage);
            $('#hdnUrlID').val(urlID);
            $('#btnUpdate').click();

        }
        function learnRegExp(s) {
            var regexp = /(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
            //return regexp.test(s);
	    return true;
        }

        function GetGUID() {
            var guid = '';
            var d = new Date();
            var uniqueid = d.getMilliseconds();
            guid = "uniqueid=" + uniqueid;
            return guid;
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="hdnExpirayDate" runat="server" />
        <asp:HiddenField ID="hdnUrlID" runat="server" />
        <asp:HiddenField ID="hdnUrl" runat="server" />
        <asp:HiddenField ID="hdnErrorOnUpdate" runat="server" />
        <asp:HiddenField ID="hdnurlIdarray" runat="server" />
        <asp:HiddenField ID="hdnUrlarry" runat="server" />

        <div style="text-align: center; margin: 50px 0px 0px 0px;">
            <div style="font-size: 24px;">Verify URL through WHOAPI</div>

            <br />
            <div id="result" style="font-size: 16px; display: none;">[Please wait for it to finish before launching it again.]</div>
            <br />
            <br />
            <br />
            <asp:Button ID="btnStarUpdate"
                runat="server"
                Text="Start Update"
                CssClass="Btn3D"
                Width="120px" />&nbsp;&nbsp;
        </div>
        <div id="urlDetail" style="text-align: center; font-size: 16px; margin-top: 20px;">

            <div style="color: blue;">URL ID:</div>
            <div id="dvUrlID"></div>
            <br />
            <div style="color: blue;">URL NAME:</div>
            <div id="dvUrlName"></div>
            <br />
            <div style="color: blue;">URL EXPIRY DATE:</div>
            <div id="dvUrlExpirayDate"></div>
            <br />
            <div style="color: blue;">URL STATUS:</div>
            <div id="dvUrlStatus"></div>
            <br />
            <br />
            <br />
            <br />
            <div style="float: left; margin-left: 130px;">
                <div style="color: blue; margin-bottom: 10px;">Rejected URL</div>
                <div id="rejectedItems" style="color: red; display: none; text-align: center; border: 1px solid red; width: 600px; height: auto; padding-bottom: 10px; margin-left: 0px;"></div>
            </div>

            <div style="float: right; margin-right: 430px;">
                <div style="color: blue; margin-bottom: 10px;">Verified URL</div>
                <div id="verifiedURL" style="color: green; display: none; text-align: center; border: 1px solid green; width: 600px; height: auto; padding-bottom: 10px;"></div>
            </div>
            <div style="margin-bottom: 50px;"></div>

        </div>
    </form>
</body>
</html>