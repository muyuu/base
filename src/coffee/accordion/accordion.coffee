(($, w, app)->

  # ------------------------------------
  # accordion
  # ------------------------------------
  me = app.accordion = {}

  me =
    parent: $ '.accordion'
    head: $ '.accordion__head'
    body: '.accordion__body'
    ico: '.accordion__ico'
    openedClass: 'js-isOpen'
    openedIconClass: 'accordion__ico--close'
    closedIconClass: 'accordion__ico--open'

    toggle: (self)->
      target = $(self).next()
      addedClass = target.attr('class')

      if addedClass.indexOf(me.openedClass) is -1
        me.open(target, self)
      else
        me.close(target, self)

    open: (self, head)->
      # icon
      $(head).find(me.ico)
        .removeClass(me.closedIconClass)
        .addClass(me.openedIconClass)

      # element
      $(head).addClass me.openedClass
      $(self).addClass me.openedClass
        .slideDown()

    close: (self, head)->
      # icon
      $(head).find(me.ico)
        .removeClass(me.openedIconClass)
        .addClass(me.closedIconClass)

      # element
      $(head).removeClass me.openedClass
      $(self).removeClass me.openedClass
        .slideUp()

  # event
  me.head.on 'click', ()->
    me.toggle(@)

  return

)(jQuery, window, app)