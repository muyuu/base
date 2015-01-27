# require from bower
$ = require 'jquery'
_ = require 'underscore'

# require my modules
ua = require './util/ua'
anchorLink = require './anchorLink/anchorLink'
gotoTop = require './goToTop/gotoTop'
accordion = require './accordion/accordion'
tab = require './tab/tab'
bangs = require './bangs/bangs'
modal = require './modal/modal'


anchorLink.set()
gotoTop.set()

accordion.set
  startCurrent: 1
  interlocking: true

tab.set()

bangs.set
  root: ".bang"
  item: ".bang__item"

modal.set()
# public method
window.modalClose = modal.close
