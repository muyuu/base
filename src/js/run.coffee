(($, _, w, app) ->
  $(->
    # use ua module
    ua = app.ua.set()
    console.dir(ua)

    # use anchor link
    app.anchorLink.init()

    # use bangs
    app.bangs.set
      root: ".bang"
      item: ".bang__item"

    # use tab
    app.tab.set()

    # use modal
    app.modal.set()

    # use accordion
    app.accordion.set
      root: ".accordion1"
      head: ".accordion1__head"
      body: ".accordion1__body"
      startCurrent: 1
      interlocking: true

    app.accordion.set
      root: ".accordion2"
      head: ".accordion2__head"
      body: ".accordion2__body"
      startCurrent: 2
      duration: 200
      onClick: ()->
        console.log 'click'
      onOpen: ()->
        console.log 'open'
      onClose: ()->
        console.log 'close'

    return
  )
  return
) jQuery, _, window, app