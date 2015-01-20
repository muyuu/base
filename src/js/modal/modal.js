(function($, _, w, app) {
  var Const, me;
  me = app.modal = {};

  /**
   * default root element
   */
  me.defaultRootElement = '.js-modal';

  /**
   * box each modal element instances
   * @type {Array}
   */
  me.instance = [];

  /**
   * make instance and push array
   * @param param
   */
  me.set = function(param) {
    var $self;
    param = param || {};
    if (param.root != null) {
      $self = $(param.root);
    } else {
      $self = $(me.defaultRootElement);
    }
    me.instance.push(new Const(param, $self));
  };

  /**
   * constructor
   * @type {Function}
   */
  Const = me.Make = function(param, root) {
    me = this;
    me.$root = null;
    me.$overlay = null;
    me.opt = {
      root: me.defaultRootElement
    };
    _.each(param, function(paramVal, paramKey) {
      _.each(me.opt, function(optVal, optKey) {
        if (paramKey === optKey) {
          me.opt[optKey] = paramVal;
        }
      });
    });
    me.setElement(root);
    me.$root.on("click", function() {
      me.open(this);
      return false;
    });
  };

  /**
   * cache jQuery object
   * @returns {boolean}
   */
  Const.prototype.setElement = function(root) {
    var opt;
    me = this;
    opt = me.opt;
    me.$root = $(root);
    return false;
  };

  /**
   * open body panel
   * @returns {boolean}
   */
  Const.prototype.open = function(link) {
    var overlay, overlayBody, overlayWrap, src;
    src = $(link).attr("href");
    $("body").append("<div class='overlayWrap'></div>");
    overlayWrap = $(".overlayWrap");
    overlayWrap.append("<div class='overlay'></div>").css({
      height: $(document).height()
    });
    overlay = overlayWrap.find(".overlay");
    overlay.append("<iframe class='overlay__body' id='overlay__modal'></iframe>");
    overlayBody = overlay.find(".overlay__body");
    overlayBody.attr({
      src: src
    });
    me.$overlay = overlayWrap;
    me.$overlay.on("click", function() {
      overlayWrap.animate({
        opacity: 0
      }, 400, "swing", function() {
        return overlayWrap.remove();
      });
      return false;
    });
    overlayWrap.animate({
      opacity: 1
    }, 400, "swing");
    return false;
  };

  /**
   * close body panel
   * @returns {boolean}
   */
  me.close = function() {
    var overlay;
    overlay = $('.overlayWrap');
    overlay.animate({
      opacity: 0
    }, 400, "swing", function() {
      return overlay.remove();
    });
    return false;
  };
})(jQuery, _, window, app);
