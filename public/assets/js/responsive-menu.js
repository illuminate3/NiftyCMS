/********************©James Ilaki************/

jQuery(document).ready(function($) {

	toggleClasses( $(window).width() );

	$(window).resize(function(event) {
		width = $(window).width();
		toggleClasses( width );
	});

	var classMore = 'glyphicon-chevron-down';
	var classLess = 'glyphicon-chevron-up';
	var bothClasses = classMore + ' ' + classLess;
	
	$('.navTrigger').click(function(event) {
		
		if ( $('.niftyNav').hasClass('mob-utility') ) {
			$('ul.secondary-nav').slideUp(500, function() {
				$(this).parent().find('.glyphicon').removeClass(classLess).addClass(classMore);
			}); 
		}

	});		

	$('li.niftyNavLi > a').click(function(event) {
	 	
	 	if ( $('.niftyNav').hasClass('mob-utility') ) {
	 		event.preventDefault(); 

		 	$primaryNav = $(this).parent();

		 	$primaryNav.find('ul.secondary-nav').slideToggle(300, function() {
		 		$primaryNav.find('.glyphicon').toggleClass(bothClasses); 
		 	});
		 	$primaryNav.toggleClass('open');

		 	$primaryNav.siblings().find('ul.secondary-nav').slideUp(300, function() {
		 		$primaryNav.siblings().find('.glyphicon').removeClass(classLess).addClass(classMore);
		 	});
		 	$primaryNav.siblings().removeClass('open');
		}
	});

	function toggleClasses( width ) {
		if ( width < 992 ) 
			$('.niftyNav').addClass('mob-utility');
		else {
			$('.niftyNav').removeClass('mob-utility');
			$('ul.secondary-nav').hide();
		}
	}

});

