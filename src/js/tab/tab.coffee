$ = require 'jquery'
_ = require 'underscore'

###*
* tab module
* this module is dependent on jQuery, Underscore.js
* @prop {string} rootElement default root element class or id
* @prop {array} instance
* @namespace
###
me =
  rootElement: '.tab'  # default root element
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
  constructor: (@param, @root) ->
    ins = this

    # -----------------------
    # properties
    # -----------------------
    # dom jquery object
    @$root = null
    @$item = null
    @$content = null

    # current element
    @current = null
    @currentIndex = 0

    # location hash
    @hash = null

    # -----------------------
    # options
    # -----------------------
    @opt =
      root: me.rootElement
      tab: ".tab__head"
      item: ".tab__item"
      body: ".tab__body"
      content: ".tab__content"
      currentClass: "is-current"

    # set options from parameter
    @setOption(@param)

    # setting dom jQuery elements
    @setElement(@root)

    # init
    @setHash()
    @setCurrent()
    @changeTab()

    # event
    @$item.on "click", "a", ->
      ins.setCurrent(@)
      ins.changeTab()
      return false



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
   * @param {string} root tab root html class name
   * @returns {boolean}
  ###
  setElement: (root)->

    @$root = $(root)
    @$item = @$root.find(@opt.item)
    @$content = @$root.find(@opt.content)

    false



  ###*
   * check location hash
   * @return {string} hash
  ###
  hasHash: ()->
    window.location.hash isnt ""

  ###*
   * set location hash
  ###
  setHash: ()->
    @hash = window.location.hash.replace("#", "") || null
    console.log @hash

  ###*
   * get location hash
   * @return {string} this.hash
  ###
  getHash: ()->
    @hash


  ###*
   * cache current item
   * 引数が空だったらhashからカレントを指定する
   * @param {object} [ele] current item element
   *
  ###
  setCurrent: (ele)->

    if ele?
      @current = $(ele).attr('href').replace("#", "")
      @currentIndex = $(ele).parents(@opt.item).index()

    else
      # hash を持つIDの要素があったらカレントを変更
      if @$root.find("#" + @hash).index() isnt -1
        @current = @hash
        @currentIndex = @$root.find("#" + @hash).index()

    false



  ###*
   * change tab
   * @return {boolean} false
  ###
  changeTab: ->

    # change hash
    @changeHash()

    # change me class
    @$item
      .removeClass(@opt.currentClass)
    .eq(@currentIndex)
      .addClass(@opt.currentClass)

    # toggle display content
    @$content
      .hide()
      .removeClass(@opt.currentClass)
    .eq(@currentIndex)
      .show()
      .addClass(@opt.currentClass)

    false


  ###*
   * change hash
  ###
  changeHash: ->
    #window.location.hash = @current
    false

module.exports = me
