module.exports = (grunt) ->
  hint:
    files:
      src: [
        '<%= dist %><%= assets_dir %><%= js_dir %>**/*.js'
        '!<%= dist %><%= assets_dir %><%= js_dir %>extend.js'
      ]
    options:
      jshintrc: 'config/.jshintrc'
