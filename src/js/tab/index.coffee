( (definition)->

  root = (typeof self == 'object' and self.self == self && self) or (typeof global == 'object' and global.global == global and global)

  if typeof exports is "object"
    $ = require 'jquery'
    _ = require 'underscore'

    module.exports = definition(root, $, _)
  else
    $ = window.$
    _ = window._

    root.tab = definition(root, root.$, root._)


)((root, $, _)->

  ###*
  * tab module
  * this module is dependent on jQuery, Underscore.js
  * @prop {string} rootElement default root element class or id
  * @prop {array} instance
  * @namespace
  ###
  me =
    rootElement: '.js-tab'  # default root element
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

      _.each $self, (val) ->
        me.instance.push new Factory(param, val)
      return false



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
        tab: ".js-tab__head"
        item: ".js-tab__item"
        body: ".js-tab__body"
        content: ".js-tab__content"
        currentClass: "is-current"
        animation: true

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
          return false

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
     * @return {boolean} has hash flg
    ###
    hasHash: ()->
      !!window.location.hash isnt ""

    ###*
     * set location hash
    ###
    setHash: ()->
      @hash = window.location.hash.replace("#", "") || null


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
     * make classes at be have item & body
     * @return {string} addedClass
    ###
    addedClass: ->
      addedClass = @opt.currentClass
      addedClass += " is-transition" if @opt.animation

    ###*
     * change tab
     * @return {boolean} false
    ###
    changeTab: ->

      # change hash
      @changeHash()

      # change me class
      @$item
        .removeClass @addedClass()
      .eq(@currentIndex)
        .addClass @addedClass()


      # toggle display content
      @$content
        .removeClass @addedClass()
      .eq(@currentIndex)
        .addClass @addedClass()

      false


    ###*
     * change hash
    ###
    changeHash: ->
      #window.location.hash = @current
      false


  return me
)
