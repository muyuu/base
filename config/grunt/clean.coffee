module.exports = (grunt) ->
  tmpfiles: [
    '.tmp'
    '<%= dist %><%= assets_dir %><%= css_dir %>style.css.map'
  ]

