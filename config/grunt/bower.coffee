module.exports = (grunt) ->
  install:
    options:
      targetDir: 'dist/assets/libs'
      layout: 'byComponent'
      install: true
      verbose: false
      cleanTargetDir: true
      cleanBowerDir: true
