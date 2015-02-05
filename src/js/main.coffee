# require from bower
$ = require 'jquery'
_ = require 'underscore'

# require my modules
ua = require './util/ua'
anchorLink = require './anchorLink'
goToTop = require './goToTop'
accordion = require './accordion'
tab = require './tab'
dropDown = require './dropDown'
bangs = require './bangs'
modal = require './modal'

anchorLink.set()
goToTop.set()

accordion.set()
#  startCurrent: 1
#  interlocking: true

tab.set()

bangs.set
  root: ".bang"
  item: ".bang__item"

modal.set()
# public method
window.modalClose = modal.close

# drop down
dropDown.set()
