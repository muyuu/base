(function($, _, w, app) {
  var Const, me;
  me = app.accordion = {};

  /**
   * default root element
   */
  me.defaultRootElement = '.accordion';

  /**
   * box each accordion element instances
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
    this.$head = null;
    this.$content = null;
    this.currentElement = null;
    this.currentIndex = 0;
    this.opt = {
      parent: me.defaultRootElement,
      head: ".accordion__head",
      body: ".accordion__body",
      ico: ".accordion__ico",
      openedClass: "js-isOpen",
      openedIconClass: "accordion__ico--close",
      closedIconClass: "accordion__ico--open",
      startCurrent: null,
      interlocking: false
    };
    this.setOption(param);
    this.setElement(root);
    this.init();
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
   * @returns {boolean}
   */
  Const.prototype.setElement = function(root) {
    this.$root = $(root);
    this.$head = this.$root.find(this.opt.head);
    this.$content = this.$root.find(this.opt.body);
    return false;
  };

  /**
   * open body panel
   * @returns {boolean}
   */
  Const.prototype.init = function() {
    var ins;
    ins = this;
    this.setCurrent();
    this.$content.hide();
    if (this.opt.startCurrent !== null) {
      this.$head.eq(this.opt.startCurrent).addClass(this.opt.openedClass);
      this.$content.eq(this.opt.startCurrent).addClass(this.opt.openedClass).show();
    }
    return this.$head.on("click", function() {
      ins.toggle(this);
      return false;
    });
  };

  /**
   * open body panel
   * @returns {boolean}
   */
  Const.prototype.open = function() {
    var ins;
    ins = this;
    ins.$head.eq(this.currentIndex).addClass(this.opt.openedClass);
    ins.$content.eq(this.currentIndex).addClass(this.opt.openedClass).slideDown();
    return false;
  };

  /**
   * close body panel
   * @returns {boolean}
   */
  Const.prototype.close = function() {
    var ins;
    ins = this;
    ins.$head.eq(this.currentIndex).removeClass(ins.opt.openedClass);
    ins.$content.eq(this.currentIndex).removeClass(ins.opt.openedClass).slideUp();
    return false;
  };
  Const.prototype.closeAll = function() {
    this.$head.removeClass(this.opt.openedClass);
    this.$content.removeClass(this.opt.openedClass).slideUp();
    return false;
  };

  /**
   * toggle accordion
   * @returns {boolean}
   */
  Const.prototype.toggle = function(clickElement) {
    if (clickElement == null) {
      clickElement = null;
    }
    this.setCurrent(clickElement);
    if (this.opt.interlocking) {
      this.closeAll();
    }
    if ($(clickElement).hasClass(this.opt.openedClass)) {
      this.close(clickElement);
    } else {
      this.open(clickElement);
    }
    return false;
  };

  /**
   * get current element index
   * @returns {number} current index
   */
  Const.prototype.setCurrent = function(clickElement) {
    if (clickElement == null) {
      clickElement = null;
    }
    if (clickElement) {
      return this.currentIndex = this.$head.index(clickElement);
    } else {
      return this.currentIndex = this.opt.startCurrent;
    }
  };
})(jQuery, _, window, app);
