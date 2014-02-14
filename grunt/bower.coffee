module.exports = (grunt) ->
  install:
    options:
      targetDir: 'public/assets/libs'
      layout: 'byComponent'
      install: true
      verbose: false
      cleanTargetDir: true
      cleanBowerDir: true
