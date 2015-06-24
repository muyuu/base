if typeof require is 'function'
  $ = require 'jquery'
  _ = require 'underscore'
else
  $ = window.$
  _ = window._


modal = {}

# alias
me = modal

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
me.set = ( param ) ->
  param = param || {}
  if param.root?
    $self = $ param.root
  else
    $self = $( me.defaultRootElement )

  me.instance.push new Const( param, $self )
  return


###*
 * constructor
 * @type {Function}
###
Const = me.Make = ( param, root ) ->
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
    padding: 20


  # set options from parameter
  _.each param, ( paramVal, paramKey ) ->
    _.each me.opt, ( optVal, optKey ) ->

# set instance's option param
      me.opt[optKey] = paramVal  if paramKey is optKey
      return

    return


  # -----------------------
  # setting dom jQuery elements
  # -----------------------
  me.setElement( root )

  # -----------------------
  # event
  # -----------------------
  me.$root.on "click", ->
    me.open( @ )
    false

  return


###*
 * cache jQuery object
 * @returns {boolean}
###
Const::setElement = ( root )->
  me = this
  opt = me.opt

  me.$root = $( root )
  false


###*
 * open body panel
 * @returns {boolean}
###
Const::open = ( link )->
  src = $( link ).attr( "href" )
  extension = src.split( '.' )[src.split( '.' ).length - 1]


  # make #js-m-modal-overlay
  $( "body" ).append '<div id="js-m-modal-overlay" class="m-modal-overlay">'

  # make #js-m-modal
  $( '#js-m-modal-overlay' ).append '<div id="js-m-modal" class="m-modal">'
  me.$overlay = $( '#js-m-modal-overlay' )

  # make #js-m-modal__body
  $( '#js-m-modal' ).append( '<div id="js-m-modal__body" class="m-modal__body">' );
  modalBody = $( '#js-m-modal__body' );

  # make content
  if extension is 'jpg' or extension is 'png' or extension is 'gif'
    modalBody.append "<img class='m-modal__content m-modal__content--img' id='js-m-modal__content'/>"
  else
    modalBody.append "<iframe class='m-modal__content m-modal__content--iframe' id='js-m-modal__content'></iframe>"

  content = $( "#js-m-modal__content" )


  # make btn
  modalBody.append( "<div class='m-modal__close js-m-modal__close'><i class='fa fa-times-circle'></i></div>" )


  setBody = ()->

    # body css
    bodyWidth = $( "#js-m-modal__content" ).outerWidth()
    bodyHeight = $( "#js-m-modal__content" ).outerHeight()

    if ( $( "#js-m-modal__content" ).outerHeight() + (me.opt.padding * 2) ) < $( window ).outerHeight()
      # 上下中央
      bodyPosTop = 0;
      bodyPosBottom = 0;
    else
      # 上から #{opt.padding}px
      bodyPosTop = me.opt.padding;
      bodyPosBottom = 'initial';


    modalBody.css
      width: bodyWidth
      height: bodyHeight
      top: bodyPosTop
      bottom: bodyPosBottom


  # set target href resource
  content.attr
    src: src

  $( 'body' ).addClass( 'js-noScroll' )


  me.$overlay.animate( {
    opacity: 1
  }, 400, "swing", setBody )


  # set close event
  me.$overlay.on "click", ( e )->
    if !$( e.target ).closest( '.m-modal__content' )[0] || $( e.target ).hasClass( 'js-m-modal__close' )
      me.$overlay.animate( {
          opacity: 0
        }, 400, "swing", ->
        me.$overlay.remove()
        $( 'body' ).removeClass( 'js-noScroll' )
      )
    return false



###*
 * close body panel
 * @returns {boolean}
###
me.close = ->
  overlay = $( '.overlayWrap' )
  overlay.animate
    opacity: 0
  , 400, "swing", ->
    overlay.remove()
  false


# exports
if typeof module isnt 'undefined' and module.exports
  module.exports = me
else
  if !window.modal
    window.modal = me
