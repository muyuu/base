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
