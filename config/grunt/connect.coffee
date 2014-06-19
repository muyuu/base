module.exports = (grunt, path) ->
  server:
    options:
      base: '<%= dist_dir %>'
      port: '<%= port %>'
      livereload: true
      # open: true

