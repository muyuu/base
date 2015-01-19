(function(w, app, $) {
  var me;
  me = app.anchorLink = app.anchorLink || {};
  me.init = function() {
    var notEle;
    notEle = "a[href=#], .noAnimateAnchor";
    return $("a[href^=#]").not(notEle).on("click", me.moveAnchor);
  };
  me.moveAnchor = function() {
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
