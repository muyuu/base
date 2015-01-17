(($, w, app)->

  # ------------------------------------
  # globalNav
  # ------------------------------------
  me = app.globalNav = {}

  me =
    $hasChild: $ '.headNav__hasChild'
    childNav: '.headNav__childNav'
    showClass: 'headNav__childNav--show'

    onHover: (self)->
      console.log "hover"
      $(self).find(me.childNav).addClass me.showClass

    outHover: (self)->
      $(self).find(me.childNav).removeClass me.showClass


  # event
  me.$hasChild.hover ()->
    me.onHover @
  , ()->
    me.outHover @

  return

)(jQuery, window, app)