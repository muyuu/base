module.exports = (grunt) ->
      options:
        dirs: ["src/**/"]
        livereload:
          enabled: true
          port: 35729
          extensions: ['jade','sass','scss','coffee']
      jade: (path) ->
        # パーシャルファイルに変更があった場合は
        # そのパーシャルファイルがあるフォルダ配下のファイルを対象とする
        lastSlashPos = path.lastIndexOf "/"
        fileName = path.substring lastSlashPos + 1, path.length
        if fileName.indexOf("_") is 0
          dirName = path.substring(0, lastSlashPos).replace "src/", ""
          if dirName is "src" # root dir
            dirName = "**"
          file = [dirName + "/*.jade", "!" + dirName + "/_*.jade"]
        else
          file = path.replace "src/", ""
        # grunt.log.write file
        grunt.config 'jade.options.pretty', true
        grunt.config 'jade.compile.files', [
          expand : true
          src    : file
          cwd    : 'src/'
          dest   : 'public/'
          ext    : '.html'
        ]
        ['jade', 'notify:jade']
      coffee: (path) ->
        filename = path.replace "src/coffee/", ""
        grunt.config 'coffee.compile.options',
          bare: true
          # sourceMap: true
        grunt.config 'coffee.compile.files', [
          expand : true
          src    : filename
          cwd    : 'src/coffee/' # 対象フォルダ
          dest   : 'public/assets/js/' # コンパイルフォルダ
          ext    : '.js'
        ]
        ['coffee:compile', 'notify:coffee']
      js: (path) ->
        'jshint'
      sass: (path) ->
        grunt.config 'sass.options.sourcemap', true
        grunt.config 'sass.options.style', 'expanded'
        grunt.config 'sass.compile.files', [
          'public/assets/css/style.css': 'src/sass/style.sass'
        ]
        ['sass:compile', 'notify:sass']
