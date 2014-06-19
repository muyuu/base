app = app || {}

( (app)->
  console.log "app.js"

  app.add = (a, b)->
    a + b

)(app)
