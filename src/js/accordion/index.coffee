$ = require 'jquery'
_ = require 'underscore'

###*
 * accordion module
 * this module is dependent on jQuery, Underscore.js
 * @prop {array} instance
 * @namespace
###
me =
  rootElement: '.accordion' # default root element
  instance: [] # box each tab element instances


  ###*
   * make instance and push array
   * @param {object} param
  ###
  set: (param) ->
    param = param || {}
    if param.root?
      $self = $ param.root
    else
      $self = $(me.rootElement)

    _.each $self, (val, key) ->
      me.instance.push new Factory(param, val)
    return


###*
 * constructor
 * @type {Function}
###
class Factory
  constructor: (param, root) ->

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

      # animation
      duration: 400

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



  ###*
   * set option
   * @returns {boolean}
  ###
  setOption: (param)->
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
  setElement: (root)->
    @$root = $(root)
    @$head = @$root.find(@opt.head)
    @$content = @$root.find(@opt.body)
    false


  ###*
   * open body panel
   * @returns {boolean}
  ###
  init: ->
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
  open: ()->
    @$head.eq(@currentIndex)
      .addClass @opt.openedClass

    @$content.eq(@currentIndex)
      .addClass(@opt.openedClass)
      .slideDown(@opt.duration)
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
    false



  closeAll: ()->
    @$head.removeClass(@opt.openedClass)
    @$content.removeClass(@opt.openedClass)
      .slideUp(@opt.duration)
    false


  ###*
   * toggle accordion
   * @returns {boolean}
  ###
  toggle: (clickElement  = null)->

    @setCurrent(clickElement)

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
  setCurrent: (clickElement = null)->

    if clickElement
      @currentIndex = @$head.index(clickElement)
    else
      @currentIndex = @opt.startCurrent

module.exports = me
