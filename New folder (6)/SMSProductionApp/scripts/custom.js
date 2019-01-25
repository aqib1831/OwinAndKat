/*********************************/
	
$(function(){
	
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


/*********************************/
