$ = require 'jquery'
_ = require 'underscore'

gotoTop = {}

# alias
me = gotoTop

me =
  ele: $(".goToTop")
  disp:  false
  dispScrollTop: 100
  animateTime: 400

#  position
#  over the footer, right for window
#    footerHeight: $('.pageFooter').outerHeight(true)
#    copyrightHeight: $('.copyright').outerHeight(true)
#    posOffset: 10

#  me.ele.css
#    "bottom": me.footerHeight + me.copyrightHeight + me.posOffset

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

module.exports = me
