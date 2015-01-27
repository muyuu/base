$ = require 'jquery'
_ = require 'underscore'

###*
 * accordion module
 * this module is dependent on jQuery, Underscore.js
 * @prop {array} instance
 * @namespace
###
accordion = {}

# alias
me = accordion

###*
 * default root element
###
me.defaultRootElement = '.accordion'


###*
 * box each accordion element instances
 * @type {Array}
###
me.instance = []


###*
 * make instance and push array
 * @param {object} param
###
me.set = (param) ->
  param = param || {}
  if param.root?
    $self = $ param.root
  else
    $self = $(me.defaultRootElement)

  _.each $self, (val, key) ->
    me.instance.push new Const(param, val)
  return


###*
 * constructor
 * @type {Function}
###
Const = me.Make

Const = (param, root) ->

  # -----------------------
  # properties
  # -----------------------
  # dom jquery object
  @$root = null
  @$head = null
  @$content = null

  # current element
  @currentElement = null
  @currentIndex = 0

  # -----------------------
  # options
  # -----------------------
  @opt =
    # elements
    parent: me.defaultRootElement
    head: ".accordion__head"
    body: ".accordion__body"
    ico: ".accordion__ico"

    # class
    openedClass: "js-isOpen"
    openedIconClass: "accordion__ico--close"
    closedIconClass: "accordion__ico--open"

    # variation
    startCurrent: null
    interlocking: false

  # set options from parameter
  @setOption(param)


  # -----------------------
  # setting dom jQuery elements
  # -----------------------
  @setElement(root)


  # -----------------------
  # init
  # -----------------------
  @init()

  return



###*
 * set option
 * @returns {boolean}
###
Const::setOption = (param)->
  ins = @

  # set options from parameter
  _.each param, (paramVal, paramKey) ->

    _.each ins.opt, (optVal, optKey) ->

      # set instance's option param
      ins.opt[optKey] = paramVal  if paramKey is optKey
      return

  return false


###*
 * cache jQuery object
 * @returns {boolean}
###
Const::setElement = (root)->
  @$root = $(root)
  @$head = @$root.find(@opt.head)
  @$content = @$root.find(@opt.body)
  false


###*
 * open body panel
 * @returns {boolean}
###
Const::init = ->
  ins = @

  @setCurrent()

  @$content.hide()

  # param startCurrent
  if @opt.startCurrent isnt null

    @$head.eq(@opt.startCurrent)
      .addClass(@opt.openedClass)

    @$content.eq(@opt.startCurrent)
      .addClass(@opt.openedClass)
      .show()

  # -----------------------
  # event
  # -----------------------
  @$head.on "click", ->
    ins.toggle(@)
    false

###*
 * open body panel
 * @returns {boolean}
###
Const::open = ()->
  ins = @

  ins.$head.eq(@currentIndex)
    .addClass @opt.openedClass

  ins.$content.eq(@currentIndex)
    .addClass(@opt.openedClass)
    .slideDown()
  false


###*
 * close body panel
 * @returns {boolean}
###
Const::close = ()->
  ins = @

  ins.$head.eq(@currentIndex)
    .removeClass ins.opt.openedClass

  ins.$content.eq(@currentIndex)
    .removeClass(ins.opt.openedClass)
    .slideUp()
  false



Const::closeAll = ()->
  @$head.removeClass(@opt.openedClass)
  @$content.removeClass(@opt.openedClass)
    .slideUp()
  false


###*
 * toggle accordion
 * @returns {boolean}
###
Const::toggle = (clickElement  = null)->

  @setCurrent(clickElement)

  if $(clickElement).hasClass(@opt.openedClass)
    # interlocking
    if @opt.interlocking
      @closeAll()
  else
    # interlocking
    if @opt.interlocking
      @closeAll()
    @open(clickElement)

  false


###*
 * get current element index
 * @returns {number} current index
###
Const::setCurrent = (clickElement = null)->

  if clickElement
    @currentIndex = @$head.index(clickElement)
  else
    @currentIndex = @opt.startCurrent

module.exports = me
