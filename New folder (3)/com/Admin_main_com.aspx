<%@ Page Language="VB" MasterPageFile="~/main.master"  ValidateRequest="false" AutoEventWireup="false" CodeFile="Admin_main_com.aspx.vb" Inherits="PM_main_pm" title="Netsolace Portal - Communication" Theme="Default"  %>
<%@ Register Src="~/com/Admin_leftpanel_com.ascx" TagName="LeftPanel" TagPrefix="ucComLeftPanel" %>
<%@ MasterType VirtualPath="~/main.master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Content" Runat="Server" >
<iframe id="divBlackDisable" marginheight="0" marginwidth="0" scrolling="no" frameborder="0" style="display:none;z-index:09;top:0;left:0px; width:0;height:0;position:absolute;filter:progid:DXImageTransform.Microsoft.alpha(opacity=50);opacity:0.5;"src="../BlankPage.htm"></iframe>
<table border="0" cellpadding="0" cellspacing="0"  width="100%" style="height:100%;background-color:#E4F1F7;padding:4px;">
  <tr>              
    <td style="width:230px;height:100%; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="background-color:#D8EAFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="height:31px;background-color:#A0CDEE;font-size:15px;font-weight:bold;padding:5px;width:90%;border-bottom:1px solid #609BD3;">
              <span class="DarkBluelabel"> Help Desk </span></td>                 
        </tr>
        <tr>
          <td>
             <ucComLeftPanel:LeftPanel ID="ComLeftPanel" runat="server"  />
          </td>
        </tr>
      </table>
    </td> 
    <td align="center" style="padding-left:0; vertical-align:top;">
      <table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin :0px; background-color:#BADCFC;height:100%;border:1px solid #609BD3;">
        <tr>
          <td style="width:100%; height:100%;"> <!--comments by saqib Second column -->
             <iframe name="Iframe" runat="server" id="Iframe" src="Admin_Inbox.aspx?FranchiseID=0" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
         </td>
       </tr>       
      </table>
    </td>
  </tr>
</table>
<div id="DivIFrame" runat="server"  style="display:none;border:solid 1px #000000; position:absolute; width:600px;  height:60%;top:20%; left:20%; z-index:50;"    >
  <table style="height:100%;" cellpadding="0" border="0" cellspacing="0"   >
   <tr valign="top">                
     <td colspan="2" style="height:100%; padding:0px; font-size:12px; background-color:White;border-top:solid 2px #000000;" >   
        <div id="divInnerIframe" style="overflow:auto; height:400px; width:600px; border:0px;" >   
            <iframe name="IfSMSUpdate" runat="server" id="IfSMSUpdate" src="blank.aspx" style="margin: 0px;width:100%;height:100%;border:0px" scrolling="no" frameborder="0"></iframe>
        </div>
     </td>
   </tr>            
  </table>
</div>
<div id="divNewLicense" style="display:none;position:absolute; height:390px; width:360px;z-index:50;" onclick="event.cancelBubble=true;">
     <table id="tbldivnewLicence" border="0" cellpadding="0" cellspacing="0" style="height:100%;" class="tblAddFolderRed pad5px">
        <tr>
            <th colspan="2" align="left" style="height:25px;" >
                <label id="lblAlbumHeading">Support Sign Up</label>
            </th>                
        </tr>
        <tr>
            <td align="center">
                <iframe id="ifNewLicense" width="100%" height="100%" frameborder="0" src="../BlankPage.htm" marginheight="0" marginwidth="0" scrolling="no"></iframe>
            </td>
        </tr>
      </table>      
</div>
<script type="text/javascript" language="javascript" >
 function showsmsUpdate(ID,ProductID)
  {

            var x1 = document.body.offsetWidth;
            var y1 = document.body.offsetHeight - 110;
            var DivFram = getElement('<%= DivIFrame.ClientID %>');
            var divInnerIframe = getElement('divInnerIframe');            
            if ('<%=Portal.BLL.Enumeration.NSProductIDs.SMS_X %>' == ProductID)
            {
                IfSMSUpdate.location='../LM/SMSXEditLicenseDetail.aspx?ID='+ID+'&Type=HelpDesk';
                divInnerIframe.style.width = parseInt(x1 * 0.98); //x1 - 60;//'900px';
                DivFram.style.width = parseInt(x1 * 0.98);        //x1 - 60;//'900px';
                divInnerIframe.style.height = parseInt(y1 * 0.97);//y1 - 23;//'430px';
                DivFram.style.height = parseInt(y1 * 0.97);       //y1 - 23;//'430px';
                DivFram.style.left = (x1 - parseInt(DivFram.style.width)) / 2;  //'7%';
                DivFram.style.top = ((y1 - parseInt(DivFram.style.height)) / 2) - 10; //'3%';
              
            }
              else if ('<%=Portal.BLL.Enumeration.NSProductIDs.SMS %>' == ProductID)
            {
                IfSMSUpdate.location='../LM/SMSEditLicenseDetail.aspx?ID='+ID+'&Type=HelpDesk';
            divInnerIframe.style.width = parseInt(x1 * 0.90); //x1 - 60;//'900px';
            DivFram.style.width = parseInt(x1 * 0.90);        //x1 - 60;//'900px';
            divInnerIframe.style.height = parseInt(y1 * 0.97);//y1 - 23;//'430px';
            DivFram.style.height = parseInt(y1 * 0.97);       //y1 - 23;//'430px';
            DivFram.style.left = (x1 - parseInt(DivFram.style.width)) / 2;  //'7%';
            DivFram.style.top = ((y1 - parseInt(DivFram.style.height)) / 2) - 10; //'3%';
               
            }
             else if ('<%=Portal.BLL.Enumeration.NSProductIDs.DMenu %>' == ProductID)
            {
                IfSMSUpdate.location='../LM/DMenuEditLicenseDetail_VitalInfo.aspx?ID='+ID+'&Type=HelpDesk';
                divInnerIframe.style.width = 400;
                DivFram.style.width = 400;
                divInnerIframe.style.height = 200;
                DivFram.style.height = 200;
                DivFram.style.left = (x1 - parseInt(DivFram.style.width)) / 2;  //'7%';
                DivFram.style.top = ((y1 - parseInt(DivFram.style.height)) / 2) - 10; //'3%';
            }
              else if ('<%=Portal.BLL.Enumeration.NSProductIDs.nxstep %>' == ProductID)
            {
                IfSMSUpdate.location='../LM/nxstepEditLicenseDetail_VitalInfo.aspx?ID='+ID+'&Type=HelpDesk';
                divInnerIframe.style.width = 400;
                DivFram.style.width = 400;
                divInnerIframe.style.height = 200;
                DivFram.style.height = 200;
                DivFram.style.left = (x1 - parseInt(DivFram.style.width)) / 2;  //'7%';
                DivFram.style.top = ((y1 - parseInt(DivFram.style.height)) / 2) - 10; //'3%';
            } 
            
            document.getElementById('divBlackDisable').style.width = '100%';
            document.getElementById('divBlackDisable').style.height = '100%';
            document.getElementById('divBlackDisable').style.display = 'inline';
            DivFram.style.display= "inline"
   }
   function hidesms(flag)
   {    
        var DivFram = getElement('<%= DivIFrame.ClientID %>');        
        document.getElementById('divBlackDisable').style.width = '0';
        document.getElementById('divBlackDisable').style.height = '0';
        document.getElementById('divBlackDisable').style.display = 'none';
        IfSMSUpdate.location='../com/Blank.aspx';        
        DivFram.style.display= 'none';
        if (flag == 1){
        window.frames.Iframe.rebinddata();
        }        
  }
   function showSupport(id,franid,clientid,proid,onsupport)
  {          
            var x1 = document.body.offsetWidth;
            var y1 = document.body.offsetHeight - 110;
            
            if (id == 0 && onsupport == 'False')
            {signup(franid,proid,clientid,id);}
            else if (id > 0 && onsupport == 'False')
            {TurnOn(franid,proid,clientid,id);}
            else if (id > 0 && onsupport == 'True')
            {EditMode(franid,proid,clientid,id);}
            
            divNewLicense.style.display='inline';
            tbldivnewLicence.className="tblAddFolder pad5px";
            divNewLicense.style.left=(x1 - parseInt(divNewLicense.style.width)) / 2; 
            divNewLicense.style.top=((y1 - parseInt(divNewLicense.style.height)) / 2) - 10;
           
            document.getElementById('divBlackDisable').style.width = '100%';
            document.getElementById('divBlackDisable').style.height = '100%';
            document.getElementById('divBlackDisable').style.display = 'inline';
   }
   function CloseNewLicenseDiv()
   {    
        var DivFram = getElement('<%= DivIFrame.ClientID %>');        
        document.getElementById('divBlackDisable').style.width = '0';
        document.getElementById('divBlackDisable').style.height = '0';
        document.getElementById('divBlackDisable').style.display = 'none';
        ifNewLicense.location='../com/Blank.aspx';        
        divNewLicense.style.display= 'none';
        
   }
    function EditMode(franid,prodid,clientid,id)        
        {   
            ifNewLicense.location='../Support/NewLicense.aspx?ID='+id+'&FranchiseID='+franid+'&ClientID='+clientid+'&ProductID='+prodid+'&Mode=edit';
            document.getElementById('lblAlbumHeading').innerHTML = 'Edit Support';
        }
    function signup(franid,prodid,clientid,id)        
        {   
            ifNewLicense.location='../Support/NewLicense.aspx?ID='+id+'&FranchiseID='+franid+'&ClientID='+clientid+'&ProductID='+prodid+'&Mode=signup';
            document.getElementById('lblAlbumHeading').innerHTML = 'Support Sign Up'; 
        }
     function TurnOn(franid,prodid,clientid,id)        
        {   
            document.getElementById('lblAlbumHeading').innerHTML = 'Turn On Support';
            ifNewLicense.location='../Support/NewLicense.aspx?ID='+id+'&FranchiseID='+franid+'&ClientID='+clientid+'&ProductID='+prodid+'&Mode=TurnOn';
        }
  function SettingMode(mode)        
        {   
            if(mode == '' || mode == 'signup')
            {
                document.getElementById('lblAlbumHeading').innerHTML = 'Support Sign Up'; 
            }
            else if(mode == 'edit')
            {   
                document.getElementById('lblAlbumHeading').innerHTML = 'Edit Support';
            }
            else if(mode == 'turnon')
            {
                document.getElementById('lblAlbumHeading').innerHTML = 'Turn On Support';
            }
        }
      function RebindRecords()
      {     
        CloseNewLicenseDiv();
        window.frames.Iframe.Reset2();
        window.frames.Iframe.rebinddata();
      }  
  </script> 
</asp:Content>