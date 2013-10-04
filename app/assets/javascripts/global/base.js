jQuery(document).ready(function(){
	"use strict";

	jQuery(function(jQuery){
		jQuery.supersized({
			// Functionality
			slide_interval			:	5000,		// Length between transitions
			transition				:	1,			// 0-None, 1-Fade, 2-Slide Top, 3-Slide Right, 4-Slide Bottom, 5-Slide Left, 6-Carousel Right, 7-Carousel Left
			transition_speed		:	1700,		// Speed of transition

			// Components							
			slide_links				:	'false',	// Individual links for each slide (Options: false, 'num', 'name', 'blank')
			slides					:
				[			// Slideshow Images

					{image : '/assets/temp/bg1.jpg', title : '<h1><span>Vota por los lugares más entretenidos en este momento</span></h1>'},
					{image : '/assets/temp/bg2.jpg', title : '<h1>Averigua dónde está el lugar más prendido en tiempo real</h1>'},
					{image : '/assets/temp/bg3.jpg', title : '<h1><span>Disfruta tu ciudad con otros Krowdlers</span></h1>'}

				]
		});
	});

	/* Mobile Menu */
	jQuery(document).ready(function () {
		jQuery('nav.site-navigation').meanmenu();

	 $("#menu-button").click(function(e) {
	 	  e.preventDefault(); 
	      $(".meanmenu-reveal").click();
	    });

	 $("#search-button").click(function(e) {
	 	  e.preventDefault(); 
	      $("#search-bar").fadeIn();
	
	    });

	});

	/* Toggle for Search form */
	jQuery(".share-item-icon-search a").click(function () {

		jQuery("#header-searchform").submit();
	});

	/* Toggle for comment form */
	jQuery("#butt").click(function () {
		jQuery("#new_post").submit();
	});



	/* Toggle for comment form */
	jQuery("#butt").click(function () {
		jQuery("#edit-form form").submit();
	});


	/* FitVids */
	jQuery(".fitvid, iframe").fitVids();


	// Can also be used with $(document).ready()
	jQuery(window).load(function() {
		jQuery('#slider-status').flexslider({
			animation: "fade",
			controlNav: false,
		});
	});

	/* Setting the equal height width  */
	jQuery('.entry-content-list .list-block-item').equalHeights(100,400);
	jQuery('.WPlookevents .list-block-item').equalHeights(100,400);
	jQuery('.WPlooklatestposts .list-block-item').equalHeights(100,400);

	/* Gallery Flex SLider */

	jQuery(window).load(function() {
		// The slider being synced must be initialized first
		jQuery('#carousel').flexslider({
			animation: "slide",
			controlNav: false,
			animationLoop: false,
			slideshow: false,
			itemWidth: 160,
			itemMargin: 5,
			asNavFor: '#slider',
			start: function(slider) {
				jQuery( '.flexslider' ).removeClass('loading');
			}
		});

		jQuery('#slider').flexslider({
			animation: "slide",
			controlNav: false,
			animationLoop: false,
			slideshow: false,
			sync: "#carousel"
		});
	});

		/* Tabs */
	jQuery('.panes div').hide();
	jQuery(".tabs a:first").addClass("selected");
	jQuery(".tabs_table").each(function(){
			jQuery(this).find('.panes div:first').show();
			jQuery(this).find('a:first').addClass("selected");
	});
	jQuery('.tabs a').click(function(){
			var which = jQuery(this).attr("rel");
			jQuery(this).parents(".tabs_table").find(".selected").removeClass("selected");
			jQuery(this).addClass("selected");
			jQuery(this).parents(".tabs_table").find(".panes").find("div").hide();
			jQuery(this).parents(".tabs_table").find(".panes").find("#"+which).fadeIn(800);
	});

	/* Toggle */
	jQuery(".toggle-content .expand-button").click(function() {
		jQuery(this).toggleClass('close').parent('div').find('.expand').slideToggle(250);
	});

	/* Toggle */
	jQuery(".toggle-event .expand-button").click(function() {
		jQuery(this).toggleClass('close').parent('div').find('.expand').slideToggle(250);
	});

});