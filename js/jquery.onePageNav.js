
(function($) {
	$.fn.onePageNav = function(settings) {

		settings = $.extend({}, {
			offset: 0 // offset value in pixels, or function that evaluates the offset
		}, settings);

		var links = $(this);
		var w = $(window);
		links.each(function () {
			this._spTarget = $($(this).attr('href'));
		});

		$(links).on('click', function (e) {
			if(this._spTarget.size() > 0) {
				e.preventDefault();
				var offsetTop = this._spTarget.offset().top - (typeof(settings.offset) === "function" ? settings.offset() : settings.offset);
				$("html, body").stop().animate({ scrollTop: offsetTop }, 1000);
			}
		});

		var calculatePosition = function () {
			$(links).each(function () {
				if(this._spTarget.size() > 0) {
					this._spPosition = this._spTarget.offset().top;
				}
			});
		};

		calculatePosition();
		w.resize(calculatePosition);

		var ticking = false;

		var update = function () {
			ticking = false;

			// Find the nearest target
			var nearestTargets = links.filter(function() {
				return (this._spPosition < (w.scrollTop() + w.height() / 2));
			});
			var nearest = nearestTargets[nearestTargets.length - 1];

			// Remove old active-classes
			links.removeClass("active");

			if (nearest != null)
				links.filter("a[href='" + $(nearest).attr("href") + "']").addClass("active");
		};

		
		w.scroll(function () {
			if(!ticking)
				requestAnimationFrame(update);
			ticking = true;
		});

		return this;
	};
})(jQuery);