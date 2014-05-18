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
    dirName = path.substring(0, lastSlashPos + 1).replace "<%= src %>", ""


    if fileName.indexOf("_") is 0
      if dirName is "" # root dir
        dirName = ""
      file = [dirName + "**/*.jade", "!" + dirName + "**/_*.jade"]
    else
      file = path.replace 'src/', ""

    grunt.config 'jade.options.data', (dest, src)->
      txt = dest.replace("dist/", "txt/").replace("html", "json")
      grunt.file.readJSON txt

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
