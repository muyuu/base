(($, _, w, app) ->
  $(->
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