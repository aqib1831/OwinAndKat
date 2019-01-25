// JScript File
// Global status  Variables
var topicDepth='Root'; 
var forwardButtonStep=0;
var isNewTopic=false;
var TopicName='';
var isNewSearch=false;
var depth;
var depthLists;
var pointerIndex=0;
var MainQuery='';

$(document).ready(function() {
 var version = getInternetExplorerVersion();


   if(screen.height > 768)
   {
	if(version == 7)
	   $(".PageContent").css("height", "600px" );
	else
	   {
	     $(".PageContent").css("height", "600px" );
	     $(".dvcontentpages").css("min-height", "650px" );
	   }
   }
   else
   {
	if(version == 7)
           $(".PageContent").css("height", "540px" );
	else
	{
		   $(".PageContent").css("height", "530px" );
		   $(".dvcontentpages").css("min-height", "580px" );
	}
   }
   var divHeigt=$("div#tblModuleList div.Liner").height()-$("div#tblModuleList span.Title").length * 32;
   $("div#tblModuleList div.Liner").css("height",divHeigt);
/* --------------------------------------- Starting Load All Topics of category ------------------------- */
   $('.ModuleRow').click(function () { 
        //set topic title
        $(".OpenTopic").text($(this).text()).show();
        TopicName=$(this).text();
        $.get("TopicsList.aspx?CategoryID=" + this.id, function(response) {
                    $("div#tblTopicsList").empty();
                    forwardButtonStep=0;
                    isNewTopic=true;
                    isNewSearch=false;
					$("div#tblTopicsList").html(response).show().fadeIn('slow');
					$("div#tblModuleList").hide();
					var divHeigt=$("div#tblTopicsList div.Liner").height()-$("div.tblTopicsList span.Title").length * 32;
                    $("div#tblTopicsList div.Liner").css("height",divHeigt);
                    topicDepth="Topics";
                    $.ClearAll();
                     /* Starting Load Detail of Topic */
					$(".divRow").click(function() {
						$.get("TopicDetail.aspx",{ TopicID: this.id },  function(response) {
						     isNewSearch=false;
						    $("div#tblTopicsList").hide();
						    $("div#tblTopicDetail").empty();
						    $("div#tblTopicDetail").html(response).show().fadeIn('slow');
						     topicDepth="Detail";
					         forwardButtonStep=0; 
					         $.ClearAll();  
						});  
					});
					 /* Ending Load Detail of Topic */
         });
    });
   /* Ending Load All Topics of category */
    
/* -------------------------------------- Starting Home Button Click Action  ------------------------------*/  
  $('.Menu-icon-Home').click(function () { 
	  if(topicDepth == 'Topics') 
	  { 
	        $("div#tblTopicsList").hide();
	        $("div#tblModuleList").show().fadeIn('slow');
	        forwardButtonStep=0;
	  }
	  if(topicDepth == 'Detail')
	  {
	        $("div#tblTopicDetail").hide();
	        $("div#tblModuleList").show().fadeIn('slow');
	        forwardButtonStep=0;
	  }
	  $(".OpenTopic").hide();
	  topicDepth="Root";
	   $.ClearAll();
    });
   /* Ending Home Button Click Action */   
    
   
    /* Back Button */  
  $('.Menu-icon-Back').click(function () { 
        if(topicDepth == 'Topics')
        {
            $("div#tblTopicsList").hide();
	        $("div#tblModuleList").show().fadeIn('slow');
	        topicDepth="Root";
	        isNewTopic=false;
	        forwardButtonStep=forwardButtonStep+1;
	        $(".OpenTopic").hide();
	         $.ClearAll();
        }
        if(topicDepth == 'Detail')
        {
            $("div#tblTopicDetail").hide();
            $("div#tblTopicsList").show().fadeIn('slow');
            topicDepth="Topics";
            forwardButtonStep=forwardButtonStep+1;
            if(isNewSearch)
            {
                $(".OpenTopic").text($("div.tblTopicsList span.Title").length+" Search Results Found").show();
                $.restoreSearchBar();
            }
            else
            {
              $.ClearAll();
            }
        }
    }); 
   
   /* Next Button */  
  $('.Menu-icon-Next').click(function () { 

            if(topicDepth == 'Topics' && forwardButtonStep != 0 )
            {
               $("div#tblTopicDetail").show().fadeIn('slow');
	           $("div#tblTopicsList").hide();
	           forwardButtonStep=forwardButtonStep-1;
	           topicDepth="Detail"; 
	           $(".OpenTopic").show();
	           if(isNewSearch)
                {
                   // $(".OpenTopic").text($("div.tblTopicsList span.Title:first").text()).show();
                    $('#txtSearchPost').trigger('keyup');  
                }
                else
                {
                    $.ClearAll();
                }
            }
            if(topicDepth == 'Root' && forwardButtonStep != 0)
            {
               $("div#tblTopicsList").show().fadeIn('slow');
	           $("div#tblModuleList").hide();
	           forwardButtonStep=forwardButtonStep-1;
	           topicDepth="Topics"; 
	           $(".OpenTopic").show();
	            if(isNewSearch)
                {
                    $('#txtSearchPost').val(MainQuery);
                    $('#txtSearchPost').trigger('keyup');  
                }
                else
                {
                    $.ClearAll();
                }
            }
    });
    
     /*Print Button */  
   $('.Menu-icon-Print').click(function () { 
      $.simplePrint($("div#dvcontentpages").html());
   });
   
  $.simplePrint = function(html)
   {
       $("#myId").remove();
     $(document.body).append('<IFRAME id="myId" onload="printIframe(this.id)" ></IFRAME>');
    // Applies styles to hide the item set
    $("#myId").attr({style: 'border:0;position:absolute;width:0px;height:0px;left:0px;top:0px;'});
    var d= frames[0].document;
        d.open();
        d.write(
            '<html><head><link rel=\"stylesheet\" type=\"text/css\"  href=\"css/Print.css\"><\/head><body>'+html+'<\/body><\/html>'
        );
        d.close();
   }
   
    
 
    /* Topic Title Clicked */
    $('.OpenTopic').click(function () { 
        if(topicDepth == 'Detail')
        {
            $("div#tblTopicDetail").hide();
            $("div#tblTopicsList").show().fadeIn('slow');
            topicDepth="Topics";
            forwardButtonStep=forwardButtonStep+1;
            if(isNewSearch)
            {
                $(this).text($("div.tblTopicsList span.Title").length+" Search Results Found").show();
                $.restoreSearchBar();
            }
            else
            {
              $.ClearAll();
            }
        }
    });
    
});

/* -------------- Search Box Logic ---------------------*/

       $(function() {
       $('#txtSearchPost').keyup(function(e){
           var regex;
           if(topicDepth == 'Root'){depth="div.tblModuleList span.Title span:"; depthLists="div.tblModuleList";  }
           if(topicDepth == 'Topics'){depth="div.tblTopicsList span.Title span:"; depthLists="div.tblTopicsList";}
           if(topicDepth == 'Detail'){depth="div.tblTopicDetail .highlight:"; depthLists="div.tblTopicDetail";}
           
           if(topicDepth == 'Detail')
           {
                $.LocalSearch($(this).val());
           }
           else
           {
                $.GlobalSearch($(this).val().replace(/&[^;]+;/g, ''));
           }
         })
         //end of Event 
         
         
        //Clearing Search box on focus
        $('#txtSearchPost').focus(function() {
            if($(this).val() == 'Search....')
               $(this).val(''); 
        })
        
        //Preventing Enter PostBack
        $('#txtSearchPost').keypress(function(e) {
            if(e.keyCode == 13)
            {
                return false;
            }
        })
        
        /* Local Page Search Function */
         $.LocalSearch = function(query)
         {
             $(depthLists).highlightRegex();
           try { regex = new RegExp(query, 'ig') }
           catch (e) {  }

           if (typeof regex !== 'undefined') {
             $(this).removeClass('error');
             if (query != '' && query != 'Search....')
               $(depthLists).highlightRegex(regex);
             if(matchCount > 0)
             {
                pointerIndex=0;
                $('.post-search').css("width", "295px" );
                $('.clearSearch').text("1 of " + matchCount);
                $('.clearSearch').css("color", "#B2B2B2" );
                $('.clearSearch').css("backgroundColor", "transparent" );
                $('.clearSearch').show();
                $('.arrowSearch').show();
                $(depth+"eq(0)").css( "background-Color", "orange" );
             }
             else
             {
                if(query == '' || query == 'Search....' )
                {
                  $.restoreSearchBar();
                }
                else
                {
                  $('.post-search').css("width", "265px" );
                  $('.clearSearch').css("background-Color", "red" );
                  $('.clearSearch').css("color", "black" );
                  $('.clearSearch').text("0 of " + matchCount); 
                  $('.arrowSearch').hide();
                  $('.clearSearch').show();
                } 
             }
           }
         } 
         /* end of Local Search Function */
         
         /* Global Search Function */
         $.GlobalSearch = function(query)
         {
            if(query.length > 2)
            {
               MainQuery=query;
               $('.clearSearch').hide(); 
               $('.post-search').css("width", "200px" );
               $.get("TopicSearch.aspx?query=" + query+"&Type="+$('#hdnType').val(), function(response) {
                    forwardButtonStep=0;
                    isNewTopic=false;
					$("div#tblTopicsList").html(response).show().fadeIn('slow');
					$("div#tblModuleList").hide();
					var divHeigt=$("div#tblTopicsList div.Liner").height()-$("div#tblTopicsList span.Title").length * 32;
                    $("div#tblTopicsList div.Liner").css("height",divHeigt);
					$(".OpenTopic").text($("div.tblTopicsList span.Title").length+" Search Results Found").show();
                    topicDepth="Topics"; 
                    isNewSearch=true;
                     /* Starting Load Detail of Topic */
					$(".divRow").click(function() {
						$.get("TopicDetail.aspx",{ TopicID: this.id },  function(response) {
						    $("div#tblTopicsList").hide();
						    $("div#tblTopicDetail").empty();
						    $("div#tblTopicDetail").html(response).show().fadeIn('slow');
						     topicDepth="Detail";
					         forwardButtonStep=0; 
					         $('#txtSearchPost').trigger('keyup');  
						});  
					});
					 /* Ending Load Detail of Topic */
               }); //End og get 
            } //end of if
            else
            {  
              if(query.length != 0)
              {
               $("div#tblTopicsList").empty().hide();
                $("div#tblModuleList").show();
               $(".OpenTopic").hide();
                $('.post-search').css("width", "305px" );
                $('.clearSearch').css("background-Color", "red" );
                $('.clearSearch').css("color", "black" );
                $('.clearSearch').text("Atleast 3 characters"); 
                $('.arrowSearch').hide();
                $('.clearSearch').show();
                topicDepth="Topics";
              }
              else
              {
                 $(".OpenTopic").hide();
                 $("div#tblModuleList").show();
                 $("div#tblTopicsList").hide()
                 $('.clearSearch').hide(); 
                 $('.post-search').css("width", "200px" );
                 topicDepth="Root";
              }
            }
         }
        
        
        //Next Button
        $('#moveNext').click(function () { 
            if(matchCount > 0 && pointerIndex < matchCount-1)
            {
                $(depth+"eq("+pointerIndex+")").css( "background-Color", "yellow" );
                pointerIndex=pointerIndex+1;
                $(depth+"eq("+pointerIndex+")").css( "background-Color", "orange" );
                $('#divContent').scrollTo(depth+"eq("+pointerIndex+")", 300, { easing:'swing', queue:true, axis:'y' } );
                $('.clearSearch').text(pointerIndex+1+" of " + matchCount); 
            }
            else
            {
                 $(depth+"eq("+pointerIndex+")").css( "background-Color", "yellow" );
                 pointerIndex=0;
                 $(depth+"eq("+pointerIndex+")").css( "background-Color", "orange" );
                 $('#divContent').scrollTo(depth+"eq("+pointerIndex+")", 300, { easing:'swing', queue:true, axis:'y' } );
                 $('.clearSearch').text(pointerIndex+1+" of " + matchCount); 
            }
        });
        
        //Back Button
        $('#moveBack').click(function () { 
            if(matchCount > 0 && pointerIndex >0)
            {
                $(depth+"eq("+pointerIndex+")").css( "background-Color", "yellow" );
                pointerIndex=pointerIndex-1;
                $(depth+"eq("+pointerIndex+")").css( "background-Color", "orange" );
                $('#divContent').scrollTo(depth+"eq("+pointerIndex+")", 300, { easing:'swing', queue:true, axis:'y' } );
                $('.clearSearch').text(pointerIndex+1+" of " + matchCount); 
            }
            else
            {
                 $(depth+"eq("+pointerIndex+")").css( "background-Color", "yellow" );
                 pointerIndex=matchCount-1;
                 $(depth+"eq("+pointerIndex+")").css( "background-Color", "orange" );
                 $('#divContent').scrollTo(depth+"eq("+pointerIndex+")", 300, { easing:'swing', queue:true, axis:'y' } );
                 $('.clearSearch').text(pointerIndex+1+" of " + matchCount); 
            }
        });
        
/* -------------  UI Functionsclear All  ----------------------  */
          $.ClearAll = function()
           {
              $('.clearSearch').hide(); 
              $('.post-search').css("width", "235px" );
              $('#txtSearchPost').val('Search....');
              pointerIndex=0;
              $(depthLists).highlightRegex();
           }
           
            $.restoreSearchBar = function()
           {
                 $('.clearSearch').hide(); 
                 $('.arrowSearch').hide();
                 $('.post-search').css("width", "200px" );
           }
           

 	$('#txtSearchPost').blur(function() {
               if($(this).val() == '')
                 $(this).val('Search....'); 
            
            });
        
/* ------------------------ END ------------------------------- */
        
      /* $(window).resize(function() {
            var width= $(window).width();
            if(width == 1024)
            {
               // $('..pagetop').css("width", "982px" )
            }
        });*/
        
        //end of Document Ready
       });
       
       function getInternetExplorerVersion()
// Returns the version of Internet Explorer or a -1
// (indicating the use of another browser).
{
    var rv = -1; // Return value assumes failure.
    if (navigator.appName == 'Microsoft Internet Explorer') {
        var ua = navigator.userAgent;
        var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
        if (re.exec(ua) != null)
            rv = parseFloat(RegExp.$1);
    }
    return rv;
}

function printIframe(id)
{
    var iframe = document.frames ? document.frames[id] : document.getElementById(id);
    var ifWin = iframe.contentWindow || iframe;
    ifWin.focus();
    ifWin.print();
    return false;
}