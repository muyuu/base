g = require "gulp"
$ = require('gulp-load-plugins')()
gulpFilter = require 'gulp-filter'
mainBowerFiles = require 'main-bower-files'
del = require 'del'

src = "src/"
dist = "dist/"
asset = "assets/"
spec = "spec/"
txt = "txt/"

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


jsFiles = [
  "#{s.js}util/extend.js"
  "#{s.js}util/polyfill.js"
  "#{s.js}util/validate.js"
  "#{s.js}init.js"
  "#{s.js}accordion/accordion.js"
  "#{s.js}anchorLink/anchorLink.js"
  "#{s.js}bangs/bangs.js"
  "#{s.js}tab/tab.js"
  "#{s.js}run.js"
]

# bower
g.task 'clear-libs', ->
  del.sync "#{d.lib}"

g.task "bower", ['clear-libs'], ->
  jsFilter = gulpFilter ["**/*.js", "**/*.map"]
  cssFilter = gulpFilter "**/*.css"
  fontsFilter = gulpFilter ["**/*.otf", "**/*.eot","**/*.svg","**/*.ttf","**/*.woff"]

  g.src(mainBowerFiles())
    .pipe(jsFilter)
    .pipe(g.dest("#{d.lib}js"))
    .pipe(jsFilter.restore())
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


# open
g.task "url", ->
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
  g.src "#{s.js}**/*.coffee"
  .pipe $.plumber()
  .pipe $.coffee
    bare: true
  .pipe g.dest("#{s.js}")


# concat
g.task "concat", ->
  g.src jsFiles
  .pipe $.concat 'app.js'
  .pipe g.dest "#{d.js}"
  .pipe $.connect.reload()


# watch
g.task "watch", ->
  g.watch "#{s.html}**/*.jade", ["html"]
  g.watch "#{s.css}**/*.sass", ["css"]
  g.watch "#{s.js}**/*.coffee", ["js"]
  g.watch "#{s.js}**/*.js", ["concat"]



# 開発時に使うタスク
g.task "default", ->
  g.start "connect", "url", "watch"

# 最初に使うタスク
g.task "lib", ->
  g.start "bower"

# デプロイ時に使うタスク
g.task "release", (callback)->
  # 各タスクを直列に実行
  $.runSequence('usemin', 'clean', callback)

# デプロイ用にまとめたファイルを確認するタスク
g.task "serve", ->
  g.start "connect"
