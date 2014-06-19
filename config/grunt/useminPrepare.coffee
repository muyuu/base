module.exports = (grunt) ->
  html: '<%= dist_dir %>**/*.html'
  options:
    dest: './<%= dist_dir %>'
