(function($, _, w, app) {
  $(function() {
    app.bangs.set();
    app.tab.set();
    app.accordion.set({
      startCurrent: 1,
      interlocking: true
    });
  });
})(jQuery, _, window, app);
