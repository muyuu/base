(($, _, w, app) ->
  me = app.modal = {}

  ###*
   * default root element
  ###
  me.defaultRootElement = '.js-modal'

  ###*
   * box each modal element instances
   * @type {Array}
  ###
  me.instance = []


  ###*
   * make instance and push array
   * @param param
  ###
  me.set = (param) ->
    param = param || {}
    if param.root?
      $self = $ param.root
    else
      $self = $(me.defaultRootElement)

    me.instance.push new Const(param, $self)
    return


  ###*
   * constructor
   * @type {Function}
  ###
  Const = me.Make = (param, root) ->
    me = this

    # -----------------------
    # properties
    # -----------------------
    # dom jquery object
    me.$root = null
    me.$overlay = null


    # -----------------------
    # options
    # -----------------------
    me.opt =
      root: me.defaultRootElement


    # set options from parameter
    _.each param, (paramVal, paramKey) ->
      _.each me.opt, (optVal, optKey) ->

        # set instance's option param
        me.opt[optKey] = paramVal  if paramKey is optKey
        return

      return


    # -----------------------
    # setting dom jQuery elements
    # -----------------------
    me.setElement(root)

    # -----------------------
    # event
    # -----------------------
    me.$root.on "click", ->
      me.open(@)
      false

    return


  ###*
   * cache jQuery object
   * @returns {boolean}
  ###
  Const::setElement = (root)->
    me = this
    opt = me.opt

    me.$root = $(root)
    false


  ###*
   * open body panel
   * @returns {boolean}
  ###
  Const::open = (link)->

    src = $(link).attr("href")

    $("body").append "<div class='overlayWrap'></div>"
    overlayWrap = $(".overlayWrap")
    overlayWrap.append("<div class='overlay'></div>").css height: $(document).height()
    overlay = overlayWrap.find(".overlay")
    overlay.append "<iframe class='overlay__body' id='overlay__modal'></iframe>"
    overlayBody = overlay.find(".overlay__body")
    overlayBody.attr src: src

    me.$overlay = overlayWrap

    me.$overlay.on "click", ->
      overlayWrap.animate
        opacity: 0
      , 400, "swing", ->
        overlayWrap.remove()
      return false

    overlayWrap.animate
      opacity: 1
    , 400, "swing"
    false


  ###*
   * close body panel
   * @returns {boolean}
  ###
  me.close = ->
    overlay = $('.overlayWrap')
    overlay.animate
      opacity: 0
    , 400, "swing", ->
      overlay.remove()
    false


  return
) jQuery, _, window, app