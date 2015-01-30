$ = require 'jquery'
_ = require 'underscore'

anchorLink = {}

# alias
me = anchorLink

# init
me.set = ->

  notEle = "a[href=#], .noAnimateAnchor";
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

module.exports = me
