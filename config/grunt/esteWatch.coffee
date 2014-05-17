module.exports = (grunt) ->
  options:
    dirs: ['<%= src %>**/', '<%= dist %>**/']
    livereload:
      enabled: true
      port: 35729
      extensions: ['jade','sass','scss','coffee']
  jade: (path) ->

    # パーシャルファイルに変更があった場合は
    # そのパーシャルファイルがあるフォルダ配下のファイルを対象とする

    lastSlashPos = path.lastIndexOf "/"
    fileName = path.substring lastSlashPos + 1, path.length

    # partial file
    if fileName.indexOf("_") is 0
      grunt.log.write src
      dirName = path.substring(0, lastSlashPos).replace "src/", ""
      if dirName is "src" # root dir
        dirName = "**"
      file = [dirName + "/*.jade", "!" + dirName + "/_*.jade"]
    else
      file = path.replace 'src/', ""

    grunt.log.write file

    grunt.config 'jade.options.pretty', true
    grunt.config 'jade.options.basedir', '<%= src %>'
    grunt.config 'jade.compile.files', [
      expand : true
      src    : file
      cwd    : '<%= src %>'
      dest   : '<%= dist %>'
      ext    : '.html'
    ]
    ['jade', 'notify:jade']

  coffee: (path) ->
    ['coffee:compileMulti', 'notify:coffee']

  js: (path) ->
    'jshint'

  sass: (path) ->
    ['sass:compile', 'notify:sass']
