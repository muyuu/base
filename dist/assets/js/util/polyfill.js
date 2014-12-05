
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
