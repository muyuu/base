$ = require 'jquery'
_ = require 'underscore'

bangs = {}

# alias
me = bangs


###*
 * default root element
###
me.defaultRootElement = '.bangs'


###*
 * box each bangs height element instances
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
  @.$root = null
  @.$item = null

  # max height
  @.maxHeight = 0


  # -----------------------
  # options
  # -----------------------
  @.opt =
    root: me.defaultRootElement
    item: ".bangs__item"

  @setOption(param)



  # -----------------------
  # setting dom jQuery elements
  # -----------------------
  @.setElement(root)

  # -----------------------
  # init
  # -----------------------
  @.init()

  return


###*
 * set option
 * @returns {boolean}
###
Const::setOption = (param)->
  opt = @opt

  # set options from parameter
  _.each param, (paramVal, paramKey) ->
    _.each opt, (optVal, optKey) ->
      # set instance's option param
      opt[optKey] = paramVal if paramKey is optKey
      return
    return
  return


###*
 * cache jQuery object
 * @returns {boolean}
###
Const::setElement = (root)->

  @.$root = $(root)
  @.$item = @.$root.find(@.opt.item)
  return false


###*
 * init
 * set event
###
Const::init = ()->
  ins = @

  # set event
  $(window).on "load resize", ->
    ins.reset()
    ins.adjust()
    return

  return false


###*
 * reset height
###
Const::reset = ()->

  @.maxHeight = 0
  @.$item.css height: ""


Const::adjust = ()->
  ins = @

  _.each ins.$item, (val, key)->
    height = $(val).height()
    ins.maxHeight = height if ins.maxHeight < height
    return false

  ins.$item.css height: ins.maxHeight
  return false


module.exports = me
