(($, _, w, app) ->
  $(->
    app.bangs.set()

    app.tab.set()

    app.accordion.set
      startCurrent: 1
      interlocking: true
    return
  )
  return
) jQuery, _, window, app