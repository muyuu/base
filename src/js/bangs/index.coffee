( (definition)->

  root = (typeof self == 'object' and self.self == self && self) or (typeof global == 'object' and global.global == global and global)

  if typeof exports is "object"
    $ = require 'jquery'
    _ = require 'underscore'

    module.exports = definition(root, $, _)
  else
    $ = window.$
    _ = window._

    root.bangs = definition(root, root.$, root._)


)((root, $, _)->

  ###*
  * adjust height module
  * this module is dependent on jQuery, Underscore.js
  * @prop {string} rootElement default root element class or id
  * @prop {array} instance
  ###
  me =
    rootElement: '.bangs' # default root element
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
        $self = $ me.rootElement

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
      @$item = null

      # max height
      @maxHeight = 0

      # -----------------------
      # options
      # -----------------------
      @opt =
        root: me.rootElement
        item: ".bangs__item"

      # set options from parameter
      @setOption(param)

      # setting dom jQuery elements
      @.setElement(root)

      # init
      @init()



    ###*
     * set option
     * @returns {boolean}
    ###
    setOption: (param)->
      opt = @opt

      # set options from parameter
      _.each param, (paramVal, paramKey) ->
        _.each opt, (optVal, optKey) ->
          # set instance's option param
          opt[optKey] = paramVal if paramKey is optKey
      return


    ###*
     * cache jQuery object
     * @returns {boolean}
    ###
    setElement: (root)->

      @$root = $(root)
      @$item = @$root.find(@opt.item)
      false


    ###*
     * init
     * set event
    ###
    init: ()->
      ins = @

      # set event
      $(window).on "load resize", ->
        ins.reset()
        ins.adjust()
        return

      false


    ###*
     * reset height
    ###
    reset: ()->

      @maxHeight = 0
      @$item.css height: ""


    adjust: ()->
      ins = @

      _.each ins.$item, (val, key)->
        height = $(val).height()
        ins.maxHeight = height if ins.maxHeight < height
        return false

      ins.$item.css height: ins.maxHeight
      return false


  return me
)
