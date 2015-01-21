(($, _, w, app) ->
  $(->
    # use ua module
    ua = app.ua.set()
    console.dir(ua)

    # use anchor link
    app.anchorLink.init()

    # use bangs
    app.bangs.set()

    # use tab
    app.tab.set()

    # use modal
    app.modal.set()

    # use accordion
    app.accordion.set
      startCurrent: 1
      interlocking: true
    return
  )
  return
) jQuery, _, window, app