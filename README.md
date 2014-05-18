anti base
=========

It's poilerplate for Web frotend product.

## grunt plugin
- grunt
- grunt-bower-task
- grunt-contrib-clean
- grunt-contrib-coffee
- grunt-contrib-concat
- grunt-contrib-connect
- grunt-contrib-jade
- grunt-contrib-jshint
- grunt-contrib-sass
- grunt-contrib-uglify
- grunt-este-watch
- grunt-notify
- grunt-usemin
- load-grunt-config
- time-grunt

## Using bower package
- jQuery

## Usage
- bower install and setting.
````
grunt init
````

- start localserver and file watch
````
grunt
````

start watch and localserver.

## Direcotory Summary
````
Project_root
  config
    grunt
      alias.yaml
      connect.coffee
      ~
    .jshintrc
  dist
    dir
      index.html
    assets
      js
        app.js
      css
        sryle.css
      img
      lib // bower installed library
    index.html
  src
    dir
      index.jade
    coffee
      **.coffee
    sass
      style.sass
    index.jade
  txt
    index.json
    dir
      index.json
````

## grunt task
grunt task setting file is in 'config/grunt'. 


## jade
jade is in src directory. and direcotory stracture is same as html.

## CoffeeScript
CoffeeScript file is src/coffee

## text file
text data of each files set up 'txt' directory.

