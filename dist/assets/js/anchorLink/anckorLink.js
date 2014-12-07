(function($, w, app) {
  $("a[href^=#]").not("a[href=#], .noAnimateAnchor").click(function() {
    var href, position, speed, target;
    speed = 500;
    href = $(this).attr("href");
    target = $((href === "#" || href === "" ? "html" : href));
    position = target.offset().top;
    $("html, body").animate({
      scrollTop: position
    }, speed, "swing");
    return false;
  });
})(jQuery, window, app);
