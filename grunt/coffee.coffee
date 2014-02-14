module.exports = (grunt) ->
  compileJoined:
    options:
      sourceMap: true
      bare: true
    files:
      'public/assets/js/app.js': 'src/coffee/**/*.coffee'

