module.exports = (grunt) ->

  # Load grunt tasks automatically
  require('load-grunt-tasks') grunt

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    # Bower
    bower:
      install:
        options:
          targetDir: 'public/assets/libs'
          layout: 'byComponent'
          install: true
          verbose: false
          cleanTargetDir: true
          cleanBowerDir: true

    # local Server
    connect:
      server:
        options:
          base: 'public'
          port: 3000
          livereload: true
          open: true

    # estwatch
    esteWatch:
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
        grunt.log.write file
        grunt.config 'jade.options.pretty', true
        grunt.config 'jade.compile.files', [
          expand : true
          src    : file
          cwd    : 'src/'
          dest   : 'public/'
          ext    : '.html'
        ]
        'jade'
      coffee: (path) ->
        # fileName = path.replace "src/coffee/", ""
        # grunt.config 'coffee.compile.options',
        #   bare: true
        #   sourceMap: false
        #   # sourceMapDir: ''
        # grunt.config 'coffee.compile.files', [
        #   expand: true
        #   src: fileName
        #   cwd: 'src/coffee/'
        #   dest: 'public/assets/js/'
        #   ext: '.js'
        # ]
        'coffee:compileJoined'
      js: (path) ->
        'jshint'
      sass: (path) ->
        'sass:compile'
      # scss: (path) ->
      #   'sass:compile'

    # sass
    sass:
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

    # coffee
    coffee:
      compileJoined:
        options:
          bare: true
        files:
          'public/assets/js/app.js': 'src/coffee/**/*.coffee'

    # jshint
    jshint:
      allFiles: [ 'public/assets/js/app.js' ]
      options:
        jshintrc: '.jshintrc'

    # comp
    uglify:
      generated:
        options:
          mangle: false

    useminPrepare:
      html: 'index.html'
      options:
        dest: './'

    # Performs rewrites based on rev and the useminPrepare configuration
    usemin:
      html: "index.html"
      options:
        dirs: ['./']

    clean:
      tmpfiles: '.tmp'


  # Bower Setup
  grunt.registerTask "init", ["bower:install"]
  # start local server
  grunt.registerTask "default", ["connect", "esteWatch"]
  # start watch
  grunt.registerTask "watch", ["esteWatch"]
  # build task
  grunt.registerTask "buildcheck", ["useminPrepare"]
  grunt.registerTask "build", [
    "useminPrepare"
    "concat"
    "uglify"
    "usemin"
    "sass:build"
    "clean"
  ]
