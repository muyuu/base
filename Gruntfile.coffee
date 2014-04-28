module.exports = (grunt) ->
  path = require('path')

  # measures the time each task
  require('time-grunt') grunt

  # Load grunt tasks automatically
  require('load-grunt-config') grunt,
    configPath: path.join(process.cwd(), 'config/grunt')
