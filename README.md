static site boilerplate
=========

It's boilerplate for Web frontend product.

## feature
- module base JavaScript files.
- modular css BEM base


## Supported modules
- accordion
- smooth scroll when click anchor link
- tab
- adjust block height(named bangs)
- toggle hide show goToTop link
- modal (iframe only)

## using package
- gulp
- bower
- Jade
- Sass
- CoffeeScript

## Using bower package
- jQuery
- Undersocre.js
- FontAwesome

## Usage
- bower install and setting.
````
bower install
````

- set bower library to assets directory
````
gulp bower
````

- start local server and file watch
````
gulp
````

start watch and local server.

## Directory Structure
````
Project_root
  dist
    dir
      index.html
    assets
      js
        app.js
      css
        style.css
      img
      libs // bower installed library
    index.html
  src
    js
      module/
        module.coffee
      init.coffee
      run.coffee
    css
      base/*.sass
      common/*.sass
      layout/*.sass
      module/**/*.sass
      state/*.sass
      util/*.sass
      style.sass
    html
      dir
        index.jade
      index.jade
  txt
    index.json
    dir
      index.json
````


## jade
jade is in src/html directory. and directory structure is same as html.

## CoffeeScript
CoffeeScript file is src/coffee

