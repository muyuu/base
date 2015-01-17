(function($, w, app) {
  var me;
  me = app.gotoTop = {};
  me = {
    ele: $(".goToTop"),
    disp: false,
    dispScrollTop: 100,
    animateTime: 400
  };
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
