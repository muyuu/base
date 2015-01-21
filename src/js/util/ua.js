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
