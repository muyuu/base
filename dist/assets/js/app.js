var app;

app = app || {};


/**
 * object - オブジェクトを作る
 * Object object(BaseObj [, mixinObj1 [, mixinObj2...]])
 */

if (!app.extend) {
  app.extend = function(o) {
    var f, i, len, n, prop;
    f = function() {};
    i = void 0;
    len = void 0;
    n = void 0;
    prop = void 0;
    f.prototype = o;
    n = new f;
    i = 1;
    len = arguments.length;
    while (i < len) {
      for (prop in arguments[i]) {
        continue;
      }
      ++i;
    }
    return n;
  };
}


/**
 * ダックタイピングによる型判別関数
 * プロパティの型だけ比較するタイプ
 */

if (!app.is) {
  app.is = function(obj, proto) {
    var p;
    for (p in proto) {
      if (typeof proto[p] !== typeof obj[p]) {
        return false;
      }
    }
    return true;
  };
}


/**
 * 配列か否かの判定メソッドのポリフィル
 * Array.isArray
 * @param none
 * @return boolean
 */
if (!Array.isArray) {
  Array.isArray = function(vArg) {
    return Object.prototype.toString.call(vArg) === "[object Array]";
  };
}


/**
 * 引数をprototyeとするオブジェクトの作成メソッドのポリフィル
 * Object.create
 * @param object
 * @return object new object
 */

if (!Object.create) {
  Object.create = function(o) {
    var F;
    F = function() {};
    if (arguments_.length > 1) {
      throw new Error("敬称元オブジェクトを引数に記述してください");
    }
    F.prototype = o;
    return new F();
  };
}


/**
 * bindのポリフィル
 * Function.prototype.bind
 * @param object
 * @return object
 */

if (!Function.prototype.bind) {
  Function.prototype.bind = function(oThis) {
    var aArgs, fBound, fNOP, fToBind;
    if (typeof this !== "function") {
      throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");
    }
    aArgs = Array.prototype.slice.call(arguments_, 1);
    fToBind = this;
    fNOP = function() {};
    fBound = function() {
      return fToBind.apply((this instanceof fNOP && oThis ? this : oThis), aArgs.concat(Array.prototype.slice.call(arguments_)));
    };
    fNOP.prototype = this.prototype;
    fBound.prototype = new fNOP();
    return fBound;
  };
}

var app;

app = app || {};

(function($, w, app) {})(jQuery, window, app);

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

(function(w, app, $) {
  var anchor;
  anchor = app.anchorLink = app.anchorLink || {};
  anchor.init = function() {
    var notEle;
    notEle = "a[href=#], .noAnimateAnchor";
    return $("a[href^=#]").not(notEle).on("click", anchor.moveAnchor);
  };
  anchor.moveAnchor = function() {
    var animateParam, easing, href, speed, target;
    href = $(this).attr("href");
    speed = 500;
    easing = 'swing';
    target = $((href === "#" || href === "" ? "html" : href));
    animateParam = {
      scrollTop: target.offset().top
    };
    $("html, body").animate(animateParam, speed, easing);
    return false;
  };
})(window, app, jQuery);

(function($, w, app) {
  var me;
  me = app.gotoTop = {};
  me = {
    ele: $(".goToTop"),
    disp: false,
    dispScrollTop: 100,
    animateTime: 400
  };
  if (me.ele[0]) {
    return $(window).scroll(function() {
      if ($(window).scrollTop() > me.dispScrollTop) {
        if (!me.disp) {
          me.ele.animate({
            opacity: 1
          }, me.animateTime);
          return me.disp = true;
        }
      } else {
        if (me.disp) {
          me.ele.animate({
            opacity: 0
          }, me.animateTime);
          return me.disp = false;
        }
      }
    });
  }
})(jQuery, window, app);

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
   * box each me element instances
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
      $self = $('.tab');
    }
    _.each($self, function(val, key) {
      return me.instance.push(new Const(param, val));
    });
  };

  /**
   * make tab instances
   * @constructor
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
      root: ".tab",
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
    var one, opt;
    one = this;
    opt = one.opt;
    one.$root = $(root);
    one.$item = one.$root.find(opt.item);
    one.$content = one.$root.find(opt.content);
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
