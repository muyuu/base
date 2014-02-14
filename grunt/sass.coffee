module.exports = (grunt) ->
  compile:
    options:
      sourcemap: true
      style: 'expanded'
    files:
      'public/assets/css/style.css': 'src/sass/style.sass'
  build:
    options:
      style: 'compressed'
    files:
      'public/assets/css/style.css': 'src/sass/style.sass'
