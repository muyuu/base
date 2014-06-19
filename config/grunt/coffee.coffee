module.exports = (grunt) ->
  compileMulti:
    options:
      bare: true
    expand: true
    flatten: false
    cwd: '<%= src_dir %><%= coffee_dir %>'
    src: ['*.coffee']
    dest: '<%= dist_dir %><%= assets_dir %><%= js_dir %>'
    ext: '.js'
  compileJoined:
    options:
      sourceMap: true
      bare: true
    files:
      '<%= dist_dir %><%= assets_dir %><%= js_dir %>app.js': '<%= src_dir %><%= coffee_dir %>**/*.coffee'

