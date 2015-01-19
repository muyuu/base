(($, _, w, app) ->

  ###*
   * tab module
   * this module is dependent on jQuery, Underscore.js
   * @prop {array} instance
   * @namespace
  ###
  me = app.tab = app.tab || {}


  ###*
   * default root element
  ###
  me.defaultRootElement = '.tab'


  ###*
   * box each tab element instances
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
      root: me.defaultRootElement
      tab: ".tab__head"
      item: ".tab__item"
      body: ".tab__body"
      content: ".tab__content"
      currentClass: "is-current"

    # set options from parameter
    @setOption(param)


    # -----------------------
    # setting dom jQuery elements
    # -----------------------
    @setElement(root)


    # -----------------------
    # init
    # -----------------------
    if ins.hasHash()
      ins.setCurrent()

    ins.changeTab()


    # -----------------------
    # event
    # -----------------------
    @$item.on "click", ->
      ins.setCurrent(@)
      ins.changeTab()
      return false

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
   * @param {string} root tab root html class name
   * @returns {boolean}
  ###
  Const::setElement = (root)->

    @$root = $(root)
    @$item = @$root.find(@opt.item)
    @$content = @$root.find(@opt.content)
    false



  ###*
   * check location hash
   * @return {string} hash
  ###
  Const::hasHash = ()->
    one = this
    opt = one.opt

    if w.location.hash isnt ""
      one.hash = w.location.hash.replace("#", "")
      return true
    else
      return false



  ###*
   * cache current item
   * 引数が空だったらhashからカレントを指定する
   * @param {object} [ele] current item element
   *
  ###
  Const::setCurrent = (ele)->
    one = this
    opt = one.opt

    if ele?
      one.current = $(ele).find('a').attr('href').replace("#", "")
      one.currentIndex = $(ele).index()

    else
      # hash を持つIDの要素があったらカレントを変更
      if one.$root.find("#" + one.hash).index() isnt -1
        one.current = one.hash
        one.currentIndex = one.$root.find("#" + one.hash).index()

    false



  ###*
   * change tab
   * @return {boolean} false
  ###
  Const::changeTab = ->
    one = this
    opt = one.opt


    # change hash
    one.changeHash()

    # change me class
    one.$item.removeClass(opt.currentClass)
    .eq(one.currentIndex).addClass(opt.currentClass)

    # toggle display content
    one.$content.hide().removeClass(opt.currentClass)
    .eq(one.currentIndex).show().addClass(opt.currentClass)

    false


  ###*
   * change hash
  ###
  Const::changeHash = ->
    one = this
    opt = one.opt

    # w.location.hash = one.current

    false

  return
) jQuery, _, window, app