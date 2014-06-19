module.exports = (grunt) ->
  dist:
    src: [
      '.tmp'
      '<%= dist_dir %><%= assets_dir %><%= css_dir %>style.css.map'
      '<%= dist_dir %><%= assets_dir %><%= js_dir %>**/*'
      '!<%= dist_dir %><%= assets_dir %><%= js_dir %>app.min.js'
    ]

