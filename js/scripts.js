
$(function() {
	/* Fancybox */
	$(".fancybox").fancybox({
		parent: "form:first",
	});

    /* SIDR Off-Canvas Menu */
	$(".ly-nav-mobile-trigger").sidr({
            name: 'nav-main-offcanvas',
            source: "#nav-mobile",
            displace: false,
            renaming: false,
            body: "form",
            onOpen: function() {
            	$("body").addClass("ly-disablescroll");
            	$("form").click(function () { $.sidr('close', 'nav-main-offcanvas'); });
            },
            onClose: function () { $("body").removeClass("ly-disablescroll"); }
        });
	
	/* Close sidr on link click */
	$("a").click(function () { $.sidr('close', 'nav-main-offcanvas'); });
	/* Add lang-nav to mobile-nav */
	$(".ly-language").clone().appendTo(".sidr-inner");

    /* More responsiveness by using touchstart */
	$('.ly-nav-mobile-trigger').on("touchstart", function (e) {
	    e.preventDefault();
	    $.sidr('open', 'nav-main-offcanvas');
	});

	$('a.ly-close').click(function () {
	    $.sidr("close", "nav-main-offcanvas");
	});

	$(window).resize(function () {
	    $.sidr("close", "nav-main-offcanvas");
	});
	$(document).on("touchmove", "form.sidr-open", function (e) {
	    e.preventDefault();
	});
	$(document).on("click", "form.sidr-open", function (e) {
	    e.preventDefault();
	    $.sidr("close", "nav-main-offcanvas");
	});


    /* Prevent "Overscroll" on iOS devices */
	var touchStartEvent;
	$(".sidr").on({
	    touchstart: function (e) {
	        touchStartEvent = e;
	    },
	    touchmove: function (e) {
	        var touchStart = touchStartEvent.originalEvent || touchStartEvent.originalEvent.touches[0];
	        var touchMove = e.originalEvent || e.originalEvent.touches[0];

	        // Cancel event if menu is already on top or bottom
	        if ((touchMove.pageY > touchStart.pageY && this.scrollTop == 0) ||
                (touchMove.pageY < touchStart.pageY && this.scrollTop + this.offsetHeight >= this.scrollHeight))
	            e.preventDefault();
	    }
	});
	
    //taphover - a solution to the lack of hover on touch devices.
    //more info: http://www.hnldesign.nl/work/code/mouseover-hover-on-touch-devices-using-jquery/
	$('a.taphover').on('touchstart', function (e) {
	    'use strict'; //satisfy the code inspectors
	    var link = $(this); //preselect the link
	    if (link.hasClass('hover')) {
	        return true;
	    } else {
	        link.addClass('hover');
	        $('a.taphover').not(this).removeClass('hover');
	        e.preventDefault();
	        return false; //extra, and to make sure the function has consistent return points
	    }
	});

	/* Open all PDF links in a new window */
	$("a[href$='.pdf']").attr('target', '_blank');

    /* Fade In scroll top button */
	$(window).scroll(function () {
	    if ($(window).scrollTop() > 40) {
	        $(".ly-scroll-button.scroll-top").stop().animate({ 'opacity': '1' }, 100);
	    } else {
	        $(".ly-scroll-button.scroll-top").stop().animate({ 'opacity': '0' }, 100);
	    }
	});

	
	/* Set nav height = ly-nav (because of fixed navigation positioning) */
	var updateNavHeight = function() {
		$("#nav").height($(".ly-nav").outerHeight());
	};
	updateNavHeight();
	$(window).resize(updateNavHeight);

	$(".co-hash-link").onePageNav({
		offset: function() { return $(".ly-nav").height(); }
	});
	
	/* Open Footerlinks in A Fancybox with blank skin */
	/*
	if(!$('body').hasClass('role-admin')){
		$('footer a').each(function(){
			$('footer a').addClass('fancybox').attr({
				'data-fancybox-type': 'iframe'
			});
		});
	}
	*/


    /* Code for active underline */
    var lastId,
        topMenu = $(".ly-nav-main"),
        topMenuHeight = topMenu.outerHeight() + 15,
        menuItems = topMenu.find("a"),

        scrollItems = menuItems.map(function () {
            var item = $($(this).attr("href"));
            if (item.length) { return item; }
        });

    menuItems.click(function (e) {
        var href = $(this).attr("href"),
            offsetTop = href === "#" ? 0 : $(href).offset().top - topMenuHeight + 1;

        $('html, body').stop().animate({
            scrollTop: offsetTop
        }, 300);

        e.preventDefault();
    });

    $(window).scroll(function () {
        var fromTop = $(this).scrollTop() + topMenuHeight;

        var cur = scrollItems.map(function () {
            if ($(this).offset().top - 100 < fromTop)
                return this;
        });

        cur = cur[cur.length - 1];
        var id = cur && cur.length ? cur[0].id : "";

        if (lastId !== id) {
            lastId = id;
            menuItems
                .parent().removeClass("co-menu-active")
                .end().filter("[href='#" + id + "']").parent().addClass("co-menu-active");
        }
    });
});


