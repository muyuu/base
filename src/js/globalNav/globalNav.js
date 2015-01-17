(function($, w, app) {
  var me;
  me = app.globalNav = {};
  me = {
    $hasChild: $('.headNav__hasChild'),
    childNav: '.headNav__childNav',
    showClass: 'headNav__childNav--show',
    onHover: function(self) {
      console.log("hover");
      return $(self).find(me.childNav).addClass(me.showClass);
    },
    outHover: function(self) {
      return $(self).find(me.childNav).removeClass(me.showClass);
    }
  };
  me.$hasChild.hover(function() {
    return me.onHover(this);
  }, function() {
    return me.outHover(this);
  });
})(jQuery, window, app);
