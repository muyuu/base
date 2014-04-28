module.exports = (grunt) ->
  compile:
    options:
      sourcemap: true
      style: 'expanded'
    files:
      'dist/assets/css/style.css': 'src/sass/style.sass'
  build:
    options:
      style: 'compressed'
    files:
      'dist/assets/css/style.css': 'src/sass/style.sass'
