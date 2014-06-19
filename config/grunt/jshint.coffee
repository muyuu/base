module.exports = (grunt) ->
  hint:
    files:
      src: [
        '<%= dist_dir %><%= assets_dir %><%= js_dir %>**/*.js'
        '!<%= dist_dir %><%= assets_dir %><%= js_dir %>extend.js'
      ]
    options:
      jshintrc: 'config/.jshintrc'
