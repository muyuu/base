(function(w, app, $) {
  var anchor;
  anchor = app.anchorLink = app.anchorLink || {};
  anchor.init = function() {
    var notEle;
    notEle = "a[href=#], .noAnimateAnchor";
    return $("a[href^=#]").not(notEle).on("click", anchor.moveAnchor);
  };
  anchor.moveAnchor = function() {
    var animateParam, easing, href, speed, target;
    href = $(this).attr("href");
    speed = 500;
    easing = 'swing';
    target = $((href === "#" || href === "" ? "html" : href));
    animateParam = {
      scrollTop: target.offset().top
    };
    $("html, body").animate(animateParam, speed, easing);
    return false;
  };
})(window, app, jQuery);
