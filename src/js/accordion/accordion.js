(function($, _, w, app) {

  /**
   * accordion module
   * this module is dependent on jQuery, Underscore.js
   * @prop {array} instance
   * @namespace
   */
  var Factory, me;
  me = app.accordion = app.accordion || {};

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
      return me.instance.push(new Factory(param, val));
    });
  };

  /**
   * constructor
   * @type {Function}
   */
  Factory = me.Make;
  Factory = function(param, root) {
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
      duration: 400,
      startCurrent: null,
      interlocking: false,
      onOpen: null,
      onClose: null,
      onClick: null,
      onAnimateEnd: null
    };
    this.setOption(param);
    this.setElement(root);
    this.init();
  };

  /**
   * set option
   * @returns {boolean}
   */
  Factory.prototype.setOption = function(param) {
    var self;
    self = this;
    _.each(param, function(paramVal, paramKey) {
      return _.each(self.opt, function(optVal, optKey) {
        if (paramKey === optKey) {
          self.opt[optKey] = paramVal;
        }
      });
    });
    return false;
  };

  /**
   * cache jQuery object
   * @returns {boolean}
   */
  Factory.prototype.setElement = function(root) {
    this.$root = $(root);
    this.$head = this.$root.find(this.opt.head);
    this.$content = this.$root.find(this.opt.body);
    return false;
  };

  /**
   * open body panel
   * @returns {boolean}
   */
  Factory.prototype.init = function() {
    var self;
    self = this;
    this.setCurrent();
    this.$content.hide();
    if (this.opt.startCurrent !== null) {
      this.$head.eq(this.opt.startCurrent).addClass(this.opt.openedClass);
      this.$content.eq(this.opt.startCurrent).addClass(this.opt.openedClass).show();
    }
    return this.$head.on("click", function() {
      self.toggle(this);
      return false;
    });
  };

  /**
   * open body panel
   * @returns {boolean}
   */
  Factory.prototype.open = function() {
    var self;
    self = this;
    this.$head.eq(this.currentIndex).addClass(this.opt.openedClass);
    this.$content.eq(this.currentIndex).addClass(this.opt.openedClass).slideDown(this.opt.duration, function() {
      if (typeof self.opt.onOpen === 'function') {
        return self.opt.onOpen();
      }
    });
    return false;
  };

  /**
   * close body panel
   * @returns {boolean}
   */
  Factory.prototype.close = function() {
    var self;
    self = this;
    this.$head.eq(this.currentIndex).removeClass(this.opt.openedClass);
    this.$content.eq(this.currentIndex).removeClass(this.opt.openedClass).slideUp(this.opt.duration, function() {
      if (typeof self.opt.onClose === 'function') {
        return self.opt.onClose();
      }
    });
    return false;
  };
  Factory.prototype.closeAll = function() {
    var callbackFlg, self;
    self = this;
    callbackFlg = false;
    this.$head.removeClass(this.opt.openedClass);
    this.$content.removeClass(this.opt.openedClass).slideUp(this.opt.duration, function() {
      if (!callbackFlg) {
        callbackFlg = true;
        if (typeof self.opt.onClose === 'function') {
          return self.opt.onClose();
        }
      }
    });
    return false;
  };

  /**
   * toggle accordion
   * @returns {boolean}
   */
  Factory.prototype.toggle = function(clickElement) {
    if (clickElement == null) {
      clickElement = null;
    }
    this.setCurrent(clickElement);
    if (typeof this.opt.onClick === 'function') {
      this.opt.onClick();
    }
    if ($(clickElement).hasClass(this.opt.openedClass)) {
      this.close();
    } else {
      if (this.opt.interlocking) {
        this.closeAll();
      }
      this.open(clickElement);
    }
    return false;
  };

  /**
   * get current element index
   * @returns {number} current index
   */
  Factory.prototype.setCurrent = function(clickElement) {
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
