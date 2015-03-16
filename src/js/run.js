(function($, _, w, app) {
  $(function() {
    var ua;
    ua = app.ua.set();
    console.dir(ua);
    app.anchorLink.init();
    app.bangs.set({
      root: ".bang",
      item: ".bang__item"
    });
    app.tab.set();
    app.modal.set();
    app.accordion.set({
      root: ".accordion1",
      head: ".accordion1__head",
      body: ".accordion1__body",
      startCurrent: 1,
      interlocking: true
    });
    app.accordion.set({
      root: ".accordion2",
      head: ".accordion2__head",
      body: ".accordion2__body",
      startCurrent: 2,
      duration: 200,
      onClick: function() {
        return console.log('click');
      },
      onOpen: function() {
        return console.log('open');
      },
      onClose: function() {
        return console.log('close');
      }
    });
  });
})(jQuery, _, window, app);
