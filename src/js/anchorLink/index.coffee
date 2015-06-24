( (definition)->

  root = (typeof self == 'object' and self.self == self && self) or (typeof global == 'object' and global.global == global and global)

  if typeof exports is "object"
    $ = require 'jquery'
    _ = require 'underscore'

    module.exports = definition(root, $, _)
  else
    $ = window.$
    _ = window._

    root.anchorLink = definition(root, root.$, root._)


)((root, $, _)->

  # alias
  me = {}

  # init
  me.set = ->

    notEle = "a[href=#], .js-noAnchor";
    $("a[href^=#]").not(notEle).on("click", me.moveAnchor);

  me.moveAnchor = ->
    href = $(this).attr("href")
    speed = 500
    easing = 'swing'
    target = $((if href is "#" or href is "" then "html" else href))
    animateParam =
      scrollTop: target.offset().top

    $("html, body").animate(animateParam, speed, easing);

    return false;


  return me
)
