module.exports = (grunt) ->
  # プロパティ名はテストケース名
  sample:
    # このテストケースでテストするファイルの指定
    src: '<%= dist_dir %><%= assets_dir %><%= js_dir %>*.js'
    options:
      # テストケース
      specs: 'spec/*Spec.js'
      # ヘルパー
      helpers: 'spec/*Helper.js'
