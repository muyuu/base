module.exports = (grunt) ->
  compile:
    options:
      sourcemap: true
      style: 'expanded'
    files:
      '<%= dist %><%= assets_dir %><%= css_dir %>style.css': '<%= src %><%= sass_dir %>style.sass'
  dist:
    options:
      sourcemap: false
      style: 'compressed'
    files:
      '<%= dist %><%= assets_dir %><%= css_dir %>style.css': '<%= src %><%= sass_dir %>style.sass'
