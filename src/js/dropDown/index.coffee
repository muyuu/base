$ = require 'jquery'
_ = require 'underscore'

###*
* drop down module
* this module is dependent on jQuery, Underscore.js
* @prop {string} rootElement default root element class or id
* @prop {array} instance
* @namespace
###
me =
  rootElement: '.dropDown'  # default root element
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
  ins = @

  constructor: (@param, @root) ->
    ins = this

    # -----------------------
    # properties
    # -----------------------
    # dom jquery object
    @$root = null
    @$select = null
    @$selectEle = null
    @$list = null
    @$item = null

    # state
    @isOpen = false

    # options
    @opt =
      root: me.rootElement
      select: ".dropDown__select"
      overlaySelect: ".dropDown__overlaySelect"
      list: ".dropDown__list"
      item: ".dropDown__item"
      animation: true

    # set options from parameter
    @setOption(@param)

    # setting dom jQuery elements
    @setElement(@root)


    # init
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
   * @param {string} root tab root html class name
   * @returns {boolean}
  ###
  setElement: (root)->

    @$root = $(root)
    @$select = @$root.find(@opt.select)
    @$selectEle = @$select.find('select')
    @$list = @$root.find(@opt.list)
    false


  init: ()->
    # make overlay select
    @setOverlaySelect()

    # event
    @$select.on "click", @togglePullDown

    @$item.on "click", "a", @selectItem

    return false



  setOverlaySelect: ()->
    # get select value, text
    @makeOverlaySelect()
    @makeDropDown()
    @setSelectData()
    @addCss()
    return


  makeOverlaySelect: ()->
    overlaySelectString = @opt.overlaySelect.replace('.', '')
    template = '<div class="' + overlaySelectString + '">'
    template += '<div class="' + overlaySelectString + 'Inner">'
    template += '<span class="' + overlaySelectString + 'Text"></span>'
    template += '</div></div>'
    @$select.append template


  setSelectData: ()->
    selectedText = @$selectEle.find("option:selected").text()
    selectedVal = @$selectEle.find("option:selected").val()

    if selectedText
      @$root.find(@opt.overlaySelect + "Text")
        .text(selectedText)
        .attr
          "data-val": selectedVal


  makeDropDown: ()->
    opt = @opt
    put = ""
    _makeDropDown = (val)->
      put += '<li class="' + opt.item.replace('.', '') + '">'
      put += '<a href="#" data-val="' + $(val).val() + '">' + $(val).text() + '</a>'
      put += '</li>'

    _.each @$select.find('option'), _makeDropDown
    @$list.html(put)

    #set item element
    @$item = @$root.find(@opt.item)



  addCss: ()->
    @$root.addClass "dropDown--is-active"


  togglePullDown: ()->
    ins.isOpen = !ins.isOpen

    addedClass = "dropDown--is-open"
    addedClass += " dropDown--is-transition" if ins.opt.animation
    ins.$root.toggleClass addedClass


  closePullDown: ()->
    console.log "body click"
    addedClass = "dropDown--is-open"
    addedClass += " dropDown--is-transition" if ins.opt.animation
    ins.$root.removeClass addedClass


  selectItem: ()->
    val = $(@).data('val')
    text = $(@).text()

    ins.$selectEle.val val
    ins.$root.find('.dropDown__overlaySelectText').text text

    ins.togglePullDown()

    false


module.exports = me
