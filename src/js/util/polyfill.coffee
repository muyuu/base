###*
 * 配列か否かの判定メソッドのポリフィル
 * Array.isArray
 * @param none
 * @return boolean
###
unless Array.isArray
  Array.isArray = (vArg) ->
    Object::toString.call(vArg) is "[object Array]"


###*
 * 引数をprototyeとするオブジェクトの作成メソッドのポリフィル
 * Object.create
 * @param object
 * @return object new object
###
unless Object.create
  Object.create = (o) ->
    F = ->
    if arguments_.length > 1
      throw new Error("敬称元オブジェクトを引数に記述してください")
    F:: = o
    new F()


###*
 * bindのポリフィル
 * Function.prototype.bind
 * @param object
 * @return object
###
unless Function::bind
  Function::bind = (oThis) ->

    # closest thing possible to the ECMAScript 5
    # internal IsCallable function
    if typeof this isnt "function"
      throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable")

    aArgs = Array::slice.call(arguments_, 1)
    fToBind = this
    fNOP = ->

    fBound = ->
      fToBind.apply (if this instanceof fNOP and oThis then this else oThis), aArgs.concat(Array::slice.call(arguments_))

    fNOP:: = @::
    fBound:: = new fNOP()
    fBound

