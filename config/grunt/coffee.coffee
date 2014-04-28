module.exports = (grunt) ->
  compileJoined:
    options:
      sourceMap: true
      bare: true
    files:
      'dist/assets/js/app.js': 'src/coffee/**/*.coffee'

