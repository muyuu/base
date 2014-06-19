module.exports = (grunt) ->
  html: '<%= dist_dir %>**/*.html'
  options:
    dirs: ['./<%= dist_dir %>']

