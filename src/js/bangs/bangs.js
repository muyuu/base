(function($, _, w, app) {
  var Const, me;
  me = app.bangs = {};

  /**
   * default root element
   */
  me.defaultRootElement = '.bangs';

  /**
   * box each bangs height element instances
   * @type {Array}
   */
  me.instance = [];

  /**
   * make instance and push array
   * @param {object} param
   */
  me.set = function(param) {
    var $self;
    param = param || {};
    if (param.root != null) {
      $self = $(param.root);
    } else {
      $self = $(me.defaultRootElement);
    }
    _.each($self, function(val, key) {
      return me.instance.push(new Const(param, val));
    });
  };

  /**
   * constructor
   * @type {Function}
   */
  Const = me.Make;
  Const = function(param, root) {
    this.$root = null;
    this.$item = null;
    this.maxHeight = 0;
    this.opt = {
      root: me.defaultRootElement,
      item: ".bangs__item"
    };
    this.setOption(param);
    this.setElement(root);
    this.init();
  };

  /**
   * set option
   * @returns {boolean}
   */
  Const.prototype.setOption = (function(_this) {
    return function(param) {
      _.each(param, function(paramVal, paramKey) {
        return _.each(this.opt, function(optVal, optKey) {
          if (paramKey === optKey) {
            this.opt[optKey] = paramVal;
          }
        });
      });
      return false;
    };
  })(this);

  /**
   * cache jQuery object
   * @returns {boolean}
   */
  Const.prototype.setElement = function(root) {
    this.$root = $(root);
    this.$item = this.$root.find(this.opt.item);
    return false;
  };

  /**
   * init
   * set event
   */
  Const.prototype.init = function() {
    var ins;
    ins = this;
    $(w).on("load resize", function() {
      ins.reset();
      ins.adjust();
    });
    return false;
  };

  /**
   * reset height
   */
  Const.prototype.reset = function() {
    this.maxHeight = 0;
    return this.$item.css({
      height: ""
    });
  };
  Const.prototype.adjust = function() {
    var ins;
    ins = this;
    _.each(ins.$item, function(val, key) {
      var height;
      height = $(val).height();
      if (ins.maxHeight < height) {
        ins.maxHeight = height;
      }
      return false;
    });
    ins.$item.css({
      height: ins.maxHeight
    });
    return false;
  };
})(jQuery, _, window, app);
