module.exports = (grunt) ->
  compile:
    options:
      sourcemap: true
      style: 'expanded'
    files:
      '<%= dist_dir %><%= assets_dir %><%= css_dir %>style.css': '<%= src_dir %><%= sass_dir %>style.sass'
  dist:
    options:
      sourcemap: false
      style: 'compressed'
    files:
      '<%= dist_dir %><%= assets_dir %><%= css_dir %>style.css': '<%= src_dir %><%= sass_dir %>style.sass'
