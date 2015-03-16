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
 * 引数をprototypeとするオブジェクトの作成メソッドのポリフィル
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

(function($, _, w, app) {

  /**
   * ua module
   * this module is dependent on jQuery, Underscore.js
   * @prop {object} instance
   * @namespace app.ua
   */
  var Const, me, pcStr, spStr, tabletStr;
  me = app.ua = app.ua || {};

  /**
   * box each tab element instances
   * @type {object}
   */
  me.instance = {};

  /**
   * make instance and push array
   * @param param
   */
  me.set = function() {
    return me.instance = new Const();
  };
  pcStr = "pc";
  spStr = "sp";
  tabletStr = "tablet";

  /**
   * constructor
   * @type {Function}
   */
  Const = me.Make = function() {
    var getUa, ua;
    me = this;
    getUa = function() {
      var device, name, os, type, ua, ver;
      ua = window.navigator.userAgent.toLowerCase();
      ver = window.navigator.appVersion.toLowerCase();
      os = window.navigator.platform.toLowerCase();
      if (ua.indexOf("ipad") !== -1 || ua.indexOf("ipod") !== -1 || ua.indexOf("iphone") !== -1) {
        os = "ios";
        if (ua.indexOf("4_") !== -1) {
          ver = 4;
        } else if (ua.indexOf("5_") !== -1) {
          ver = 5;
        } else if (ua.indexOf("6_") !== -1) {
          ver = 6;
        } else if (ua.indexOf("7_") !== -1) {
          ver = 7;
        } else if (ua.indexOf("8_") !== -1) {
          ver = 8;
        }
        name = "safari";
        device = "ipad";
        type = tabletStr;
        if (ua.indexOf("ipod") !== -1 || ua.indexOf("iphone") !== -1) {
          type = spStr;
          device = "ipod";
          if (ua.indexOf("iphone") !== -1) {
            device = "iphone";
          }
        }
      } else if (ua.indexOf("android") !== -1) {
        os = "android";
        name = "androidbrowser";
        device = "androidtablet";
        type = tabletStr;
        if (ua.indexOf("mobile") !== -1) {
          device = "android";
          type = spStr;
        }
      } else if (ua.indexOf("windows phone") !== -1) {
        os = "windowsmobile";
        name = "ie";
        device = "windowsphone";
        type = spStr;
        ver = 6;
        if (ua.indexOf("OS 7") !== -1) {
          ver = 7;
        }
      } else {
        type = "pc";
        device = "pc";
        os = "unix";
        if (os.indexOf("win") !== -1) {
          os = "windows";
        }
        if (ua.match(/mac|ppc/)) {
          os = "macos";
        }
        if (ua.indexOf("msie") !== -1 || ua.indexOf("trident") !== -1) {
          name = "ie";
          if (ver.indexOf("msie 6.") !== -1) {
            ver = 6;
          } else if (ver.indexOf("msie 7.") !== -1) {
            ver = 7;
          } else if (ver.indexOf("msie 8.") !== -1) {
            ver = 8;
          } else if (ver.indexOf("msie 9.") !== -1) {
            ver = 9;
          } else if (ver.indexOf("msie 10.") !== -1) {
            ver = 10;
          } else {
            if (ua.indexOf("trident") !== -1) {
              ver = 11;
            }
          }
        } else if (ua.indexOf("chrome") !== -1) {
          name = "chrome";
        } else if (ua.indexOf("safari") !== -1) {
          name = "safari";
        } else if (ua.indexOf("gecko") !== -1) {
          name = "firefox";
        } else {
          if (ua.indexOf("opera") !== -1) {
            name = "opera";
          }
        }
      }
      return {
        device: device,
        type: type,
        os: os,
        name: name,
        version: ver
      };
    };
    ua = getUa();

    /**
    * device name
    * 端末名 （PCはPC ipad とか iphone とか android とか）
    * @property device
    * @type str
    * @default undefined
     */
    this.device = ua.device;

    /**
    * os name
    * OS名 （ windows macos unix ios android ）
    * @property os
    * @type str
    * @default undefined
     */
    this.os = ua.os;

    /**
    * device type ( "pc" or "tablet" or "sp" )
    * デバイスの種類 （ PC か tablet か sp ）
    * @property deviceType
    * @type str
    * @default undefined
     */
    this.deviceType = ua.type;

    /**
    * browser name
    * ブラウザ名
    * @property browser
    * @type str
    * @default undefined
     */
    this.browser = ua.name;

    /**
    * browser version ( support ie or ios )
    * ブラウザのバージョン （IEとiOSしかサポートしてない）
    * @property device
    * @type str
    * @default undefined
     */
    this.browserVer = ua.ver;
    return this;
  };

  /**
   * judge equal this deviceType from parameter
   * @param {string} type
   */
  Const.prototype.isDeviceType = function(type) {
    return this.deviceType === type;
  };

  /**
   * @method isBrowser
   * @param {object} browser parameter
   * @return {boolean}
   */
  Const.prototype.isBrowser = (function(_this) {
    return function(obj) {
      obj.name = obj.name || "ie";
      obj.ver = obj.ver || void 0;
      if (_this.browser === obj.name) {
        if (obj.ver === void 0) {
          if (_this.browserVer === obj.version) {
            return true;
          } else {
            return false;
          }
        } else {
          return true;
        }
      } else {
        return false;
      }
    };
  })(this);
  Const.prototype.moreBrowserVer = (function(_this) {
    return function(obj) {
      obj.name = obj.name || "ie";
      obj.ver = obj.ver || 6;
      if (_this.browser === obj.name) {
        if (obj.and === "more") {
          if (_this.browserVer >= obj.version) {
            return true;
          }
        } else if (obj.and === "less") {
          if (_this.browserVer <= obj.version) {
            return true;
          }
        }
      }
    };
  })(this);

  /**
  * ブラウザが指定バージョンより上のバージョンか否かの判別メソッド
  * 主にIEで使用。パラメータのプロパティに name を入れれば他ブラウザに対応
  * @method andMore
  * @param {object} obj @.name = str browser name @.ver = num version
  * @return boolean 指定バージョンより上のバージョンなら真
   */
  Const.prototype.andMore = function(obj) {
    obj.and = obj.and || "more";
    return this.moreBrowserVer(obj);
  };

  /**
  * ブラウザが指定バージョンより下のバージョンか否かの判別メソッド
  * 主にIEで使用。パラメータのプロパティに name を入れれば他ブラウザに対応
  * @method andLess
  * @param obj @.name = str browser name @.ver = num version
  * @return boolean 指定バージョンより下のバージョンなら真
   */
  Const.prototype.andLess = function(obj) {
    obj.and = obj.and || "less";
    return this.moreBrowserVer(obj);
  };

  /**
  * デバイスの種類がpcか否かの判別メソッド
  * @method isPc
  * @param null
  * @return boolean デバイスタイプがpcなら真
   */
  Const.prototype.isPc = function() {
    return this.isDeviceType(pcStr);
  };

  /**
  * デバイスの種類がtabletか否かの判別メソッド
  * @method tablet
  * @param null
  * @return {boolean} デバイスタイプがtabletなら真
   */
  Const.prototype.isTablet = function() {
    return this.isDeviceType(tabletStr);
  };

  /**
  * デバイスの種類がspか否かの判別メソッド
  * @method isSp
  * @param null
  * @return {boolean} デバイスタイプがspなら真
   */
  Const.prototype.isSp = function() {
    return this.isDeviceType(spStr);
  };

  /**
  * IE6より上のバージョンか否かの判別メソッド
  * @method andMoreIe6
  * @param null
  * @return boolean IE6以上のブラウザなら真
   */
  Const.prototype.andMoreIe6 = function() {
    return this.andMore({
      ver: 6
    });
  };

  /**
  * IE7より上のバージョンか否かの判別メソッド
  * @method andMoreIe7
  * @param null
  * @return boolean IE7以上のブラウザなら真
   */
  Const.prototype.andMoreIe7 = function() {
    return this.andMore({
      ver: 7
    });
  };

  /**
  * IE8より上のバージョンか否かの判別メソッド
  * @method andMoreIe8
  * @param null
  * @return boolean IE8以上のブラウザなら真
   */
  Const.prototype.andMoreIe8 = function() {
    return this.andMore({
      ver: 8
    });
  };

  /**
  * IE9より上のバージョンか否かの判別メソッド
  * @method andMoreIe9
  * @param null
  * @return boolean IE9以上のブラウザなら真
   */
  Const.prototype.andMoreIe9 = function() {
    return this.andMore({
      ver: 9
    });
  };

  /**
  * IEか否かの判別メソッド
  * @method isIe
  * @param null
  * @return boolean IE6なら真
   */
  Const.prototype.isIe = function() {
    return this.isBrowser({
      name: "ie"
    });
  };

  /**
  * IE6か否かの判別メソッド
  * @method isIe6
  * @param null
  * @return boolean IE6なら真
   */
  Const.prototype.isIe6 = function() {
    return this.isBrowser({
      name: "ie",
      ver: 6
    });
  };

  /**
  * IE7か否かの判別メソッド
  * @method isIe7
  * @param null
  * @return boolean IE7なら真
   */
  Const.prototype.isIe7 = function() {
    return this.isBrowser({
      name: "ie",
      ver: 7
    });
  };

  /**
  * IE8か否かの判別メソッド
  * @method isIe8
  * @param null
  * @return boolean IE8なら真
   */
  Const.prototype.isIe8 = function() {
    return this.isBrowser({
      name: "ie",
      ver: 8
    });
  };

  /**
  * IE9か否かの判別メソッド
  * @method isIe9
  * @param null
  * @return boolean IE9なら真
   */
  Const.prototype.isIe9 = (function(_this) {
    return function() {
      return _this.isBrowser({
        name: "ie",
        ver: 9
      });
    };
  })(this);

  /**
  * IE10か否かの判別メソッド
  * @method isIe10
  * @param null
  * @return boolean IE10なら真
   */
  Const.prototype.isIe10 = function() {
    return this.isBrowser({
      name: "ie",
      ver: 10
    });
  };

  /**
  * IE11か否かの判別メソッド
  * @method isIe11
  * @param null
  * @return boolean IE11なら真
   */
  Const.prototype.isIe11 = function() {
    return this.isBrowser({
      name: "ie",
      ver: 11
    });
  };

  /**
  * firefoxか否かの判別メソッド
  * @method isFirefox
  * @param null
  * @return boolean firefoxなら真
   */
  this.isFirefox = function() {
    return this.isBrowser({
      name: "firefox"
    });
  };

  /**
  * chromeか否かの判別メソッド
  * @method isChrome
  * @param null
  * @return boolean chromeなら真
   */
  Const.prototype.isChrome = function() {
    return this.isBrowser({
      name: "chrome"
    });
  };

  /**
  * safariか否かの判別メソッド
  * @method isSafari
  * @param null
  * @return boolean safariなら真
   */
  Const.prototype.isSafari = function() {
    return this.isBrowser({
      name: "safari"
    });
  };

  /**
  * operaか否かの判別メソッド
  * @method isOpera
  * @param null
  * @return {boolean} operaなら真
   */
  Const.prototype.isOpera = function() {
    return this.isBrowser({
      name: "opera"
    });
  };
})(jQuery, _, window, app);

var app;

app = app || {};

(function($, w, app) {})(jQuery, window, app);

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

(function(w, app, $) {
  var me;
  me = app.anchorLink = app.anchorLink || {};
  me.init = function() {
    var notEle;
    notEle = "a[href=#], .noAnimateAnchor";
    return $("a[href^=#]").not(notEle).on("click", me.moveAnchor);
  };
  me.moveAnchor = function() {
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
  Const.prototype.setOption = function(param) {
    var opt;
    opt = this.opt;
    _.each(param, function(paramVal, paramKey) {
      _.each(opt, function(optVal, optKey) {
        if (paramKey === optKey) {
          opt[optKey] = paramVal;
        }
      });
    });
  };

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
    console.log(ins.$item);
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
