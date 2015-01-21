(function($, _, w, app) {
  $(function() {
    var ua;
    ua = app.ua.set();
    console.dir(ua);
    app.anchorLink.init();
    app.bangs.set();
    app.tab.set();
    app.modal.set();
    app.accordion.set({
      startCurrent: 1,
      interlocking: true
    });
  });
})(jQuery, _, window, app);
