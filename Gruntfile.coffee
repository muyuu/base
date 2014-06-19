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
      vendor_dir: 'libs/'
      config_dir: 'conf/'
      txt_dir: 'txt/'
      spec_dir: 'spec/'
      dist_dir: 'dist/'
      src_dir: 'src/'
      coffee_dir: 'coffee/'
      sass_dir: 'sass/'
      jade_dir: 'jade/'
      assets_dir: 'assets/'
      img_dir: 'img/'
      css_dir: 'css/'
      js_dir: 'js/'
  )


