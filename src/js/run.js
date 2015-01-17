(function($, _, w, app) {
  $(function() {
    app.anchorLink.init();
    app.bangs.set();
    app.tab.set();
    app.accordion.set({
      startCurrent: 1,
      interlocking: true
    });
  });
})(jQuery, _, window, app);
