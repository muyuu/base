module.exports = (grunt) ->
  compileMulti:
    options:
      bare: true
    expand: true
    flatten: false
    src: ['*.coffee']
    cwd: '<%= src %><%= coffee_dir %>'
    dest: '<%= dist %><%= assets_dir %><%= js_dir %>'
    ext: (ext)->
      ext.replace /coffee$/, 'js'
  compileJoined:
    options:
      sourceMap: true
      bare: true
    files:
      '<%= dist %><%= assets_dir %><%= js_dir %>app.js': '<%= src %><%= coffee_dir %>**/*.coffee'

