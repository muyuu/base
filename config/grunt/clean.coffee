module.exports = (grunt) ->
  dist:
    src: [
      '.tmp'
      '<%= dist %><%= assets_dir %><%= css_dir %>style.css.map'
      '<%= dist %><%= assets_dir %><%= js_dir %>**/*'
      '!<%= dist %><%= assets_dir %><%= js_dir %>app.min.js'
    ]

