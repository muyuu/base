g = require "gulp"
$ = require('gulp-load-plugins')()

# main bower files
del = require 'del'
mainBowerFiles = require 'main-bower-files'

# browserify
browserify = require 'browserify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'


src = "./src/"
dist = "./dist/"
asset = "assets/"
spec = "./spec/"

s =
  root: src
  html: src + "html/"
  css: src + "css/"
  js: src + "js/"

d =
  root: dist
  html: dist
  css: dist + asset + "css/"
  js: dist + asset + "js/"
  lib: dist + asset + "libs/"
  img: dist + asset + "img/"

t =
  root: spec
  coffee: spec + "coffee/"
  fixture: spec + "fixtures/"


# bower
g.task 'clear-libs', ->
  del.sync "#{d.lib}"

g.task "bower", ['clear-libs'], ->
  cssFilter = $.filter "**/*.css"
  fontsFilter = $.filter ["**/*.otf", "**/*.eot","**/*.svg","**/*.ttf","**/*.woff"]

  g.src(mainBowerFiles())
  .pipe(cssFilter)
  .pipe(g.dest("#{d.lib}css"))
  .pipe(cssFilter.restore())
  .pipe(fontsFilter)
  .pipe(g.dest("#{d.lib}fonts"))


# local server
g.task "connect", ->
  $.connect.server
    root: "#{d.html}"
    port: 3000
    livereload: true

  options =
    url: "http://localhost:3000"
    app: "Google Chrome"

  g.src "#{d.html}index.html"
    .pipe($.open "", options)


# html
g.task "html", ->
  g.src ["#{s.html}**/*.jade", "!#{s.html}**/_*.jade"]
    .pipe $.changed "#{d.html}", { hasChanged: $.changed.compareSha1Digest }
    .pipe $.plumber()
    .pipe $.jade
      pretty: true
      basedir: "#{s.html}"
    .pipe g.dest "#{d.html}"
    .pipe $.connect.reload()


# css
g.task "css", ->
  g.src "#{s.css}style.sass"
    .pipe $.plumber()
    .pipe $['rubySass']
      sourcemap: true
      style: "compressed"
    .pipe g.dest("#{d.css}")
    .pipe $.connect.reload()


# js
g.task "js", ->
  browserify
    entries: ["#{s.js}main.coffee"]
    extensions: ['.coffee']
  .bundle()
  .pipe source "app.js"
  .pipe buffer()
    .pipe $.sourcemaps.init loadMaps: true
    .pipe $.uglify()
    .pipe $.sourcemaps.write( './' )
  .pipe g.dest "#{d.js}"


# watch
g.task "watch", ->
  g.watch "#{s.html}**/*.jade", ["html"]
  g.watch "#{s.css}**/*.sass", ["css"]
  g.watch "#{s.js}**/*.coffee", ["js"]


# default task
g.task "default", ->
  g.start "connect", "watch"

