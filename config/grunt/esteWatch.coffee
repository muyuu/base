module.exports = (grunt) ->
  options:
    dirs: [
      '<%= src_dir %>**/'
      '<%= dist_dir %><%= assets_dir %><%= js_dir %>**/'
      '<%= spec_dir %>**/'
    ]

    livereload:
      enabled: true
      port: 35729
      extensions: ['jade','sass','scss','coffee']


  jade: (path) ->

    # パーシャルファイルに変更があった場合は
    # そのパーシャルファイルがあるフォルダ配下のファイルを対象とする
    lastSlashPos = path.lastIndexOf "/"
    fileName = path.substring lastSlashPos + 1, path.length
    dirName = path.substring(0, lastSlashPos + 1).replace( "src/", "")

    if fileName.indexOf("_") is 0
      if dirName is "" # root dir
        dirName = ""
      file = [dirName + "**/*.jade", "!" + dirName + "**/_*.jade"]
    else
      file = path.replace( "src/", "")

    # jadeと同じ感じのディレクトリ構成でtxtファイルを置いて何となくまとめる
    grunt.config 'jade.options.data', (dest, src)->
      txt = dest.replace("dist/", "txt/").replace("html", "json")
      grunt.file.readJSON txt

    grunt.config 'jade.compile.files', [
      expand : true
      src    : file
      cwd    : '<%= src_dir %>'
      dest   : '<%= dist_dir %>'
      ext    : '.html'
    ]
    ['jade', 'notify:jade']

  coffee: (path) ->
    # specとsrcどちらのファイルかによってcwd dest を変える
    srcFlg = path.indexOf 'src/'

    if srcFlg is 0
      fileName = path.replace "src/coffee/", ""
      cwdStr = 'src/'
      destStr = 'dist/assets/js/'

    else
      fileName = path.replace "spec/coffee/", ""
      cwdStr = 'spec/'
      destStr = 'spec/'

    cwdStr = cwdStr + 'coffee/'

    # option
    grunt.config 'coffee.compile.options',
      bare: true
      sourceMap: false

    grunt.config 'coffee.compile.files', [
      expand : true
      src    : fileName
      cwd    : cwdStr
      dest   : destStr
      ext    : '.js'
    ]
    ['coffee']

  js: (path) ->
    ['jasmine']

  sass: (path) ->
    ['sass:compile', 'notify:sass']
