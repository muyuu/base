
/*
 * Array.forEach - JavaScript | MDN
 * https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Array/forEach
 * Production steps of ECMA-262, Edition 5, 15.4.4.18
 * Reference: http://es5.github.com/#x15.4.4.18
 */
if (!Array.prototype.forEach) {
  Array.prototype.forEach = function(callback, thisArg) {
    var O, T, k, kValue, len;
    T = void 0;
    k = void 0;
    if (typeof this === "undefined" || this === null) {
      throw new TypeError(" this is null or not defined");
    }
    O = Object(this);
    len = O.length >>> 0;
    if ({}.toString.call(callback) !== "[object Function]") {
      throw new TypeError(callback + " is not a function");
    }
    if (thisArg) {
      T = thisArg;
    }
    k = 0;
    while (k < len) {
      kValue = void 0;
      if (k in O) {
        kValue = O[k];
        callback.call(T, kValue, k, O);
      }
      k++;
    }
  };
}
