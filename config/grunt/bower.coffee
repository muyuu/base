module.exports = (grunt) ->
  install:
    options:
      targetDir: '<%= dist %><%= assets_dir %><%= vendor_dir %>'
      layout: 'byComponent'
      install: true
      verbose: false
      cleanTargetDir: true
      cleanBowerDir: true
