module.exports = (grunt) ->
  server:
    url: 'http://localhost:<%= connect.server.options.port %>'
    app: 'Google Chrome'
