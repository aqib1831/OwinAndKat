/*********************************/
var iosURL = "itms-services://?action=download-manifest&amp;url=https://qa.netsolace.com/Portal/fruitexpert_live/FruitExpert.plist",
	androidURL = "";
	

$(function(){
	if( navigator.userAgent.match(/Android/) ) {
		$('.download-button').attr('data-name','android');
		if(androidURL != "#" && androidURL != "" && androidURL != "undefined" ) {
			$('.download-button').text('Download Android App');
			$('.download-button').attr('href',androidURL);
		} else {
			$('.download-button').hide();
		}
	} else {
		$('.download-button').attr('data-name','ios');
		if(iosURL != "#" && iosURL != "" && iosURL != "undefined" ) {
			$('.download-button').text('Download iOS App');
			$('.download-button').attr('href',iosURL);
		} else {
			$('.download-button').hide();
		}
		
	}
	
	var contentHeight = $('.content').outerHeight(),
		winHeight = $(window).outerHeight(),
		footerHeight = $('.footer').outerHeight(),
		difference = parseInt(winHeight - contentHeight);
	
	$('.content').stop().animate({
		'padding-top' : (difference / 2),
		'opacity'	: '1.0'
	}, 700);
	
	$('.footer').fadeIn(1200);
});

$(window).bind('resize', function () {
   	var contentHeight = $('.content').outerHeight(),
		winHeight = $(window).outerHeight(),
		footerHeight = $('.footer').outerHeight(),
		difference = parseInt( (winHeight - contentHeight - footerHeight) / 2 );
	
	$('.content').stop().animate({
		'padding-top' : difference,
		'opacity'	: '1.0'
	}, 700);
});

/*function DownloadApp(elm) {	
	if ($(elm).data('name') == 'android'){
		window.location.href = androidURL;
	} else {
		window.location.href = iosURL;
	}
}*/

/*********************************/
