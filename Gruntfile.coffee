module.exports = (grunt) ->

  path = require('path')

  # measures the time each task
  require('time-grunt') grunt

  # Load grunt tasks automatically
  require('load-grunt-config')(grunt,
    configPath: path.join(process.cwd(), 'config/grunt')

    # 各種設定
    data:
      port: 3000
      dist: 'dist/'
      src: 'src/'
      coffee_dir: 'coffee/'
      sass_dir: 'sass/'
      jade_dir: 'jade/'
      assets_dir: 'assets/'
      img_dir: 'img/'
      css_dir: 'css/'
      js_dir: 'js/'
      vendor_dir: 'libs/'
      config_dir: 'config/'
      txt_dir: 'txt/'
  )


