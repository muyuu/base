g = require "gulp"
$ = require( 'gulp-load-plugins' )()
minifyCss = require 'gulp-minify-css'

# main bower files
del = require 'del'
mainBowerFiles = require 'main-bower-files'

# browserify
browserify = require 'browserify'
buffer = require 'vinyl-buffer'
rename = require 'gulp-rename'
watchify = require 'gulp-watchify'
coffeeify = require 'coffeeify'

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
    fontsFilter = $.filter ["**/*.otf", "**/*.eot", "**/*.svg", "**/*.ttf", "**/*.woff", "**/*.woff2"]

    g.src( mainBowerFiles() )
    .pipe( cssFilter )
    .pipe( g.dest( "#{d.lib}css" ) )
    .pipe( cssFilter.restore() )
    .pipe( fontsFilter )
    .pipe( g.dest( "#{d.lib}fonts" ) )


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
    .pipe( $.open "", options )


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
    .pipe $.sourcemaps.init()
    .pipe $.plumber()
    .pipe $.sass
        outputStyle: 'expanded'
    .pipe $.autoprefixer( [
        'last 3 versions'
        'Explorer >= 8'
    ] )
#    .pipe $.csscomb()
#    .pipe minifyCss
#        compatibility: 'ie8'
    .pipe $.sourcemaps.write()
    .pipe g.dest( "#{d.css}" )


# js
g.task 'watchify', watchify ( watchify )->
    g.src "#{s.js}main.coffee"
    .pipe $.plumber()
    .pipe watchify
        watch: on
        extensions: ['.coffee']
        transform: ['coffeeify']
        debug: true
    .pipe rename
        basename: "app"
        extname: ".js"
    .pipe buffer()
    .pipe $.sourcemaps.init
        loadMaps: true
    .pipe $.uglify()
    .pipe $.sourcemaps.write()
    .pipe g.dest "#{d.js}"


# watch
g.task "watch", ->
    g.watch "#{s.html}**/*.jade", ["html"]
    g.watch "#{s.css}**/*.sass", ["css"]


# default task
g.task "default", ['watchify'], ->
    g.start ["connect", "watch"]

