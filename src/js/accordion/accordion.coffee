(($, _, w, app) ->

  ###*
   * accordion module
   * this module is dependent on jQuery, Underscore.js
   * @prop {array} instance
   * @namespace
  ###
  me = app.accordion = app.accordion || {}


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
      me.instance.push new Factory(param, val)
    return


  ###*
   * constructor
   * @type {Function}
  ###
  Factory = me.Make

  Factory = (param, root) ->

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

      # callback
      onOpen: null
      onClose: null
      onClick: null
      onAnimateEnd: null

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
  Factory::setOption = (param)->
    self = @

    # set options from parameter
    _.each param, (paramVal, paramKey) ->
      _.each self.opt, (optVal, optKey) ->
        # set instance's option param
        self.opt[optKey] = paramVal  if paramKey is optKey
        return

    return false


  ###*
   * cache jQuery object
   * @returns {boolean}
  ###
  Factory::setElement = (root)->
    @$root = $(root)
    @$head = @$root.find(@opt.head)
    @$content = @$root.find(@opt.body)
    false


  ###*
   * open body panel
   * @returns {boolean}
  ###
  Factory::init = ->
    self = @

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
      self.toggle(@)
      false

  ###*
   * open body panel
   * @returns {boolean}
  ###
  Factory::open = ()->
    self = @
    @$head.eq(@currentIndex)
      .addClass @opt.openedClass

    @$content.eq(@currentIndex)
      .addClass(@opt.openedClass)
      .slideDown @opt.duration, ()->
        # callback
        if typeof self.opt.onOpen is 'function'
          self.opt.onOpen()
    false


  ###*
   * close body panel
   * @returns {boolean}
  ###
  Factory::close = ()->
    self = @
    @$head.eq(@currentIndex)
      .removeClass @opt.openedClass

    @$content.eq(@currentIndex)
      .removeClass(@opt.openedClass)
      .slideUp @opt.duration, ->
        # callback
        if typeof self.opt.onClose is 'function'
          self.opt.onClose()
    false



  Factory::closeAll = ()->
    self = @
    callbackFlg = false
    @$head.removeClass(@opt.openedClass)
    @$content.removeClass(@opt.openedClass)
      .slideUp @opt.duration, ->
        if !callbackFlg
          callbackFlg = true
          # callback
          if typeof self.opt.onClose is 'function'
            self.opt.onClose()
    false


  ###*
   * toggle accordion
   * @returns {boolean}
  ###
  Factory::toggle = (clickElement  = null)->

    @setCurrent(clickElement)

    # callback
    if typeof @opt.onClick is 'function'
      @opt.onClick()

    if $(clickElement).hasClass(@opt.openedClass)
      @close()
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
  Factory::setCurrent = (clickElement = null)->

    if clickElement
      @currentIndex = @$head.index(clickElement)
    else
      @currentIndex = @opt.startCurrent

  return
) jQuery, _, window, app