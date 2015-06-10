if typeof require is 'function'
  $ = require 'jquery'
  _ = require 'underscore'
else
  $ = window.$
  _ = window._



###*
 * accordion module
 * this module is dependent on jQuery, Underscore.js
 * @prop {array} instance
 * @namespace
###
me =
  rootElement: '.js-acd' # default root element
  instance: [] # box each tab element instances


  ###*
   * make instance and push array
   * @param {object} param
  ###
  set: (opt) ->
    opt = opt || {}
    if opt.root?
      $self = $ opt.root
    else
      opt.root = me.rootElement
      $self = $(me.rootElement)

    me.instance = _.map $self, (v, k) ->
      new Factory(opt, v)



###*
 * constructor
 * @type {Function}
###
class Factory
  constructor: (opt, root) ->
    ins = @

    # -----------------------
    # options
    # -----------------------
    @opt =
      # elements
      root: opt.root
      head: opt.head || ".js-acd__head"
      body: opt.body || ".js-acd__body"
      ico:  opt.ico || ".js-acd__ico"

      # class
      openedClass: opt.opendClass || "js-isOpen"
      openedIconClass: opt.opendIconClass || "js-acd__ico--close"
      closedIconClass: opt.closedIconClass || "js-acd__ico--open"

      # animation
      duration: if _.isUndefined(opt.duration) then 400 else opt.duration

      # variation
      startCurrent: if _.isUndefined(opt.startCurrent) then null else opt.startCurrent
      interlocking: opt.interlocking || false

      # callback
      onOpen: opt.onOpen || null
      onClose: opt.onClose || null
      onClick: opt.onClick || null
      onAnimateEnd: opt.onAnimateEnd || null


    # -----------------------
    # jQuery element
    # -----------------------
    # dom jquery object
    @$root = $ root
    @$head = @$root.find(@opt.head)
    @$content = @$root.find(@opt.body)


    # current
    @currentIndex = if _.isNull(@opt.startCurrent) then 0 else @opt.startCurrent

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
  open: ()->
    @$head.eq(@currentIndex)
      .addClass @opt.openedClass

    @$content.eq(@currentIndex)
      .addClass(@opt.openedClass)
      .slideDown(@opt.duration)

    if _.isFunction(@opt.onOpen)
      @opt.onOpen()
    false


  ###*
   * close body panel
   * @returns {boolean}
  ###
  close: ()->
    @$head.eq(@currentIndex)
      .removeClass @opt.openedClass

    @$content.eq(@currentIndex)
      .removeClass(@opt.openedClass)
      .slideUp(@opt.duration)

    if _.isFunction(@opt.onClose)
      @opt.onClose()
    false



  closeAll: ()->
    @$head.removeClass(@opt.openedClass)
    @$content.removeClass(@opt.openedClass)
      .slideUp(@opt.duration)

    if _.isFunction(@opt.onClose)
      @opt.onClose()
    false


  ###*
   * toggle accordion
   * @returns {boolean}
  ###
  toggle: (clickElement  = null)->

    @setCurrent(clickElement)

    if _.isFunction(@opt.onClick)
      @opt.onClick()


    if $(clickElement).hasClass(@opt.openedClass)
      # interlocking
      if @opt.interlocking
        @closeAll()
      else
        @close()
    else
      # interlocking
      if @opt.interlocking
        @closeAll()
      @open()

    false


  ###*
   * get current element index
   * @returns {number} current index
  ###
  setCurrent: (clickElement)->
    @currentIndex = @$head.index(clickElement)


# exports
if typeof module isnt 'undefined' and module.exports
  module.exports = me
else
  if !window.acd
    window.acd = me
