module.exports = (grunt) ->

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-jade')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-yuidoc')

  GRUNT_CHANGED_PATH = '.grunt-changed-file'
  if grunt.file.exists GRUNT_CHANGED_PATH
    changed = grunt.file.read GRUNT_CHANGED_PATH
    grunt.file.delete GRUNT_CHANGED_PATH
    changed_only = (file)-> file is changed
  else
    changed_only = -> true

  data = {}

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    bower:
      install:
        options:
          cleanTargetDir: true
          cleanBowerDir: true
          install: true
          copy: true

    # local Server
    connect:
      server:
        options:
          port: 9000

    # watch
    watch:
      jade:
        files: '**/*.jade'
        tasks: 'jade'
      html:
        files: '**/*.html'
        options:
          livereload: true
          nospawn: true
      sass:
        files: '**/*.s*ss'
        tasks: 'sass'
      css:
        files: 'assets/css*.css'
        options:
          livereload: true
          nospawn: true
      coffee:
        files: 'assets/**/*.coffee'
        tasks: 'coffee'
      js:
        files: 'assets/js/*.js'
        options:
          livereload: true
          nospawn: true

    # jade
    jade:
      files:
        options: pretty: true
        expand : true
        cwd    : 'src/' # 対象フォルダ
        src    : ['**/*.jade', '!**/_*.jade']
        dest   : '' # コンパイルフォルダ
        ext    : '.html'
        filter : changed_only

    # sass
    sass:
      options:
        sourcemap: true
        style: 'expanded'
      compile:
        files: 'assets/css/style.css':'src/sass/style.sass'
      filter : changed_only

    # coffee
    coffee:
      files:
        expand : true
        cwd    : 'src/coffee/' # 対象フォルダ
        src    : '*.coffee' # 対象ファイル
        dest   : 'js/' # コンパイルフォルダ
        ext    : '.js' # コンパイル後の拡張子
        filter : changed_only

    # 圧縮
    uglify:
      build:
        files:
          "assets/js/*.min.js": ["assets/js/*.js"]

    # ドキュメント生成
    yuidoc:
      compile:
        name: "<%= pkg.name %>"
        description: "<%= pkg.description %>"
        version: "<%= pkg.version %>"
        url: "<%= pkg.homepage %>"
        options:
          paths: "assets/js/"
          outdir: "docs/"

  grunt.event.on 'watch', (action, changed)->
    if action is 'changed'
      if not /(layout)/.test changed
        grunt.file.write GRUNT_CHANGED_PATH, changed


  grunt.registerTask "default", ["connect", "watch", 'configureProxies','connect:livereload']

  # "default" でデフォルトのタスクを設定
  grunt.registerTask "release", ["uglify:build", "coffee:build", "yuidoc"]
