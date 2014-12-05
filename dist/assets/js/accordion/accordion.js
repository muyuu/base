(function($, w, app) {
  var me;
  me = app.accordion = {};
  me = {
    parent: $('.accordion'),
    head: $('.accordion__head'),
    body: '.accordion__body',
    ico: '.accordion__ico',
    openedClass: 'js-isOpen',
    openedIconClass: 'accordion__ico--close',
    closedIconClass: 'accordion__ico--open',
    toggle: function(self) {
      var addedClass, target;
      target = $(self).next();
      addedClass = target.attr('class');
      if (addedClass.indexOf(me.openedClass) === -1) {
        return me.open(target, self);
      } else {
        return me.close(target, self);
      }
    },
    open: function(self, head) {
      $(head).find(me.ico).removeClass(me.closedIconClass).addClass(me.openedIconClass);
      $(head).addClass(me.openedClass);
      return $(self).addClass(me.openedClass).slideDown();
    },
    close: function(self, head) {
      $(head).find(me.ico).removeClass(me.openedIconClass).addClass(me.closedIconClass);
      $(head).removeClass(me.openedClass);
      return $(self).removeClass(me.openedClass).slideUp();
    }
  };
  me.head.on('click', function() {
    return me.toggle(this);
  });
})(jQuery, window, app);
