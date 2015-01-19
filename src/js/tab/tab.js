(function($, _, w, app) {

  /**
   * tab module
   * this module is dependent on jQuery, Underscore.js
   * @prop {array} instance
   * @namespace
   */
  var Const, me;
  me = app.tab = app.tab || {};

  /**
   * default root element
   */
  me.defaultRootElement = '.tab';

  /**
   * box each tab element instances
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
    var ins;
    ins = this;
    this.$root = null;
    this.$item = null;
    this.$content = null;
    this.current = null;
    this.currentIndex = 0;
    this.hash = null;
    this.opt = {
      root: me.defaultRootElement,
      tab: ".tab__head",
      item: ".tab__item",
      body: ".tab__body",
      content: ".tab__content",
      currentClass: "is-current"
    };
    this.setOption(param);
    this.setElement(root);
    if (ins.hasHash()) {
      ins.setCurrent();
    }
    ins.changeTab();
    this.$item.on("click", function() {
      ins.setCurrent(this);
      ins.changeTab();
      return false;
    });
  };

  /**
   * set option
   * @returns {boolean}
   */
  Const.prototype.setOption = function(param) {
    var ins;
    ins = this;
    _.each(param, function(paramVal, paramKey) {
      return _.each(ins.opt, function(optVal, optKey) {
        if (paramKey === optKey) {
          ins.opt[optKey] = paramVal;
        }
      });
    });
    return false;
  };

  /**
   * cache jQuery object
   * @param {string} root tab root html class name
   * @returns {boolean}
   */
  Const.prototype.setElement = function(root) {
    this.$root = $(root);
    this.$item = this.$root.find(this.opt.item);
    this.$content = this.$root.find(this.opt.content);
    return false;
  };

  /**
   * check location hash
   * @return {string} hash
   */
  Const.prototype.hasHash = function() {
    var one, opt;
    one = this;
    opt = one.opt;
    if (w.location.hash !== "") {
      one.hash = w.location.hash.replace("#", "");
      return true;
    } else {
      return false;
    }
  };

  /**
   * cache current item
   * 引数が空だったらhashからカレントを指定する
   * @param {object} [ele] current item element
   *
   */
  Const.prototype.setCurrent = function(ele) {
    var one, opt;
    one = this;
    opt = one.opt;
    if (ele != null) {
      one.current = $(ele).find('a').attr('href').replace("#", "");
      one.currentIndex = $(ele).index();
    } else {
      if (one.$root.find("#" + one.hash).index() !== -1) {
        one.current = one.hash;
        one.currentIndex = one.$root.find("#" + one.hash).index();
      }
    }
    return false;
  };

  /**
   * change tab
   * @return {boolean} false
   */
  Const.prototype.changeTab = function() {
    var one, opt;
    one = this;
    opt = one.opt;
    one.changeHash();
    one.$item.removeClass(opt.currentClass).eq(one.currentIndex).addClass(opt.currentClass);
    one.$content.hide().removeClass(opt.currentClass).eq(one.currentIndex).show().addClass(opt.currentClass);
    return false;
  };

  /**
   * change hash
   */
  Const.prototype.changeHash = function() {
    var one, opt;
    one = this;
    opt = one.opt;
    return false;
  };
})(jQuery, _, window, app);
