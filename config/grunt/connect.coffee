module.exports = (grunt, path) ->
  server:
    options:
      base: '<%= dist %>'
      port: '<%= port %>'
      livereload: true
      # open: true

