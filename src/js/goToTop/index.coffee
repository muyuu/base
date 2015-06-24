( (definition)->

  root = (typeof self == 'object' and self.self == self && self) or (typeof global == 'object' and global.global == global and global)

  if typeof exports is "object"
    $ = require 'jquery'
    _ = require 'underscore'

    module.exports = definition(root, $, _)
  else
    $ = window.$
    _ = window._

    root.goToTop = definition(root, root.$, root._)


)((root, $, _)->

  me =
    ele: $(".goToTop")
    disp:  false
    dispScrollTop: 100
    animateTime: 400

  me.set = ->
    if me.ele[0]
      $(window).scroll ->
        if $(window).scrollTop() > me.dispScrollTop
          unless me.disp
            me.ele.animate
              opacity: 1
            , me.animateTime
            me.disp = true
        else
          if me.disp
            me.ele.animate
              opacity: 0
            , me.animateTime
            me.disp = false




  return me
)
