(function($, w, app) {
  var me;
  me = app.gotoTop = {};
  me = {
    ele: $(".gotoTop"),
    disp: false,
    dispScrollTop: 100,
    animateTime: 400,
    footerHeight: $('.pageFooter').outerHeight(true),
    copyrightHeight: $('.copyright').outerHeight(true),
    posOffset: 10
  };
  me.ele.css({
    "bottom": me.footerHeight + me.copyrightHeight + me.posOffset
  });
  if (me.ele[0]) {
    return $(window).scroll(function() {
      if ($(window).scrollTop() > me.dispScrollTop) {
        if (!me.disp) {
          me.ele.animate({
            opacity: 1
          }, me.animateTime);
          return me.disp = true;
        }
      } else {
        if (me.disp) {
          me.ele.animate({
            opacity: 0
          }, me.animateTime);
          return me.disp = false;
        }
      }
    });
  }
})(jQuery, window, app);
