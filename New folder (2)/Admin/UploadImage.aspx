<%@ Page Language="VB" AutoEventWireup="false" CodeFile="UploadImage.aspx.vb" Inherits="Admin_UploadImage" %>
<%@ Register TagPrefix="radU" Namespace="Telerik.WebControls" Assembly="RadUpload.Net2" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <style type="text/css">
        div.fileinputs {
	        position: relative;}
        div.fakefile {
	        position: absolute;
	        top: 0px;
	        left: 0px;
	        z-index: 1;}
        input.file {
	        position: relative;
	        text-align: right;
	        -moz-opacity:0;
	        filter:alpha(opacity:0);
	        opacity: 0;
	        z-index: 2;
	        font-size:10px;
	        width:100%;}
    </style>
</head>
<body style="margin:0;height:1px;width:1px;font-family:Arial;overflow:hidden;">
    <form id="form1" runat="server">
    <radu:radprogressmanager id="Radprogressmanager1" runat="server" />
    <div align="center" id="progress" style="display:none; border:0px solid black; position:absolute;left:30%;top:20%;z-index:10000;">
      <radu:radprogressarea id="RadProgressArea1" runat="server" Skin="White" ProgressIndicators="TotalProgressPercent" style="filter:progid:DXImageTransform.Microsoft.Gradient(gradientType=0,startColorStr=#FAFEFF,endColorStr=#A5D7FF);"></radu:radprogressarea>   
    </div>
    <div id="divDisable" class="modalBackground" style="z-index:09;background-color:#FFFFFF;" ></div>
    <div style="border:solid 0px green;  height:100%;width:100%;">
        <table border="0" cellpadding="0" cellspacing="0" style="height:100%;width:100%;">
            <tr>
                <td colspan="2">
                    <%--<input type="file" id="fileImage2" runat="server" style="width:100%;background-color:white;font-size:10px;"/>--%>
                   <div class="fileinputs">
	                    <span style=""><input type="file" id="fileImage" runat="server" class="file" onchange="Assinge(this);" style="z-index:2;filter:progid:DXImageTransform.Microsoft.Alpha(opacity:0);" /></span>
	                    <div class="fakefile" style="white-space:nowrap;z-index:1;">
		                    <input type="text" id="fakeinputid" runat="server"  style="font-size:11px;width:80%;border:solid 1px #888FB9;" readonly="readonly" />&nbsp;<img src="../images/btn_browse.gif" style="vertical-align:top;cursor:hand;" onclick="BrowseClick();"/>
	                    </div>
                    </div>
                    <asp:RegularExpressionValidator 
                        ID="REV_fileImage" runat="server"
                        ValidationExpression="^.*(.jpg|.jpeg|.png|.gif|.tif|.tiff|.JPG|.JPEG|.PNG|.GIF|.TIF|.TIFF)$" 
                        Display="None" ControlToValidate="fileImage">
                    </asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RFV_fileProcessImage" runat="server" 
                       ControlToValidate="fileImage" Display="None">
                    </asp:RequiredFieldValidator>
                </td>    
            </tr>
             <tr>
                <td style="width:20%;padding-top:3px">
                    <asp:ImageButton ID="btnUpload" runat="server" ImageUrl="../images/btn_upload.gif" CausesValidation="false" ToolTip="Upload" style="vertical-align:middle;" OnClientClick="javascript:showWaitUpload();" />
                </td>
                <td style="width:80%;padding-left:3px;padding-top:3px">
                    <span style="font-size:10px;color:#686667;line-height:10px;">
                        Only JPG, GIF or PNG formats under 1 MB file size.
                    </span>
                </td>
            </tr>
         </table> 
    </div>
    <script type="text/javascript">
     window.onload=function start()
    {  
      SetSetting();
    }
    function showWaitUpload()
    {  
       if(Page_ClientValidate())
       {    
            divDisable.style.width = document.body.scrollWidth
            divDisable.style.height = document.body.scrollHeight
            var progress = document.getElementById('progress')
            progress.style.display = 'inline';
            document.form1.style.cursor = 'waiting'
       }
       else
       {
         parent.ShowAlertDivMultiple('<ul><li>Please Upload File in given Formats.<br />JPG, GIF or PNG under 1 MB.</li></ul>')
       }
       
    }
    function Assinge(me) {
        var fakeinputid = document.getElementById('fakeinputid');
			fakeinputid.value = me.value;
			fakeinputid.title = me.value;
		}
	function SetSetting(){
		    var fileImage = document.getElementById('<%=fileImage.ClientID%>');
		    var fakeinputid = document.getElementById('fakeinputid');
		    fakeinputid.style.width = fileImage.offsetWidth - 70;
		    document.getElementById('fakeinputid').value = '';
		}	
	function BrowseClick(){
	    document.getElementById('<%=fileImage.ClientID%>').click();}
    </script>
    </form>
</body>
</html>
