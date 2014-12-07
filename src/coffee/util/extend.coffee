app = app || {}

###*
 * object - オブジェクトを作る
 * Object object(BaseObj [, mixinObj1 [, mixinObj2...]])
###
unless app.extend
  app.extend = (o) ->
    f = ->
    i = undefined
    len = undefined
    n = undefined
    prop = undefined
    f:: = o
    n = new f
    i = 1
    len = arguments.length

    while i < len
      for prop of arguments[i]
        continue
      ++i
    n

###*
 * ダックタイピングによる型判別関数
 * プロパティの型だけ比較するタイプ
###
unless app.is
  app.is = (obj, proto) ->
    for p of proto
      return false  unless typeof proto[p] is typeof obj[p]
    true

