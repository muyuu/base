(($, _, w, app) ->

  ###*
   * ua module
   * this module is dependent on jQuery, Underscore.js
   * @prop {object} instance
   * @namespace app.ua
  ###
  me = app.ua = app.ua || {}

  ###*
   * box each tab element instances
   * @type {object}
  ###
  me.instance = {}


  ###*
   * make instance and push array
   * @param param
  ###
  me.set = () ->
    me.instance = new Const()


  # variable
  pcStr = "pc"
  spStr = "sp"
  tabletStr = "tablet"

  ###*
   * constructor
   * @type {Function}
  ###
  Const = me.Make = () ->
    me = @


    # ---------------------------------------------------------
    # UserAgent Judge function
    # This function made thinking on the basic of "IE proliferate".
    # return { name: name, version: ver, type: type, os: os }
    # ---------------------------------------------------------
    getUa = ->
      ua = window.navigator.userAgent.toLowerCase()
      ver = window.navigator.appVersion.toLowerCase()
      os = window.navigator.platform.toLowerCase()

      # iOS
      if ua.indexOf("ipad") isnt -1 or ua.indexOf("ipod") isnt -1 or ua.indexOf("iphone") isnt -1
        os = "ios"

        # version
        unless ua.indexOf("4_") is -1
          ver = 4
        else unless ua.indexOf("5_") is -1
          ver = 5
        else unless ua.indexOf("6_") is -1
          ver = 6
        else  unless ua.indexOf("7_") is -1
          ver = 7
        else  unless ua.indexOf("8_") is -1
          ver = 8

        # browser name
        name = "safari"

        # device name
        device = "ipad"

        # device type
        type = tabletStr

        # iPod or iPhone
        if ua.indexOf("ipod") isnt -1 or ua.indexOf("iphone") isnt -1
          type = spStr
          device = "ipod"

          # iphone
          device = "iphone" unless ua.indexOf("iphone") is -1

      # Android
      else unless ua.indexOf("android") is -1
        os = "android"
        name = "androidbrowser"
        device = "androidtablet"
        type = tabletStr

        # mobile device
        unless ua.indexOf("mobile") is -1
          device = "android"
          type = spStr

      # Windows Phone
      else unless ua.indexOf("windows phone") is -1
        os = "windowsmobile"
        name = "ie"
        device = "windowsphone"
        type = spStr

        # version
        ver = 6
        ver = 7  unless ua.indexOf("OS 7") is -1

      # PC browser
      else
        type = "pc"
        device = "pc"

        # os
        os = "unix"
        os = "windows" if os.indexOf("win") isnt -1
        os = "macos"   if ua.match( /mac|ppc/ )

        # browser
        if ua.indexOf("msie") isnt -1 or ua.indexOf("trident") isnt -1
          name = "ie"
          unless ver.indexOf("msie 6.") is -1
            ver = 6
          else unless ver.indexOf("msie 7.") is -1
            ver = 7
          else unless ver.indexOf("msie 8.") is -1
            ver = 8
          else unless ver.indexOf("msie 9.") is -1
            ver = 9
          else unless ver.indexOf("msie 10.") is -1
            ver = 10
          else ver = 11  unless ua.indexOf("trident") is -1
        else unless ua.indexOf("chrome") is -1
          name = "chrome"
        else unless ua.indexOf("safari") is -1
          name = "safari"
        else unless ua.indexOf("gecko") is -1
          name = "firefox"
        else name = "opera"  unless ua.indexOf("opera") is -1

      device: device
      type: type
      os: os
      name: name
      version: ver

    ua = getUa()

    ###*
    * device name
    * 端末名 （PCはPC ipad とか iphone とか android とか）
    * @property device
    * @type str
    * @default undefined
    ###
    @device = ua.device

    ###*
    * os name
    * OS名 （ windows macos unix ios android ）
    * @property os
    * @type str
    * @default undefined
    ###
    @os = ua.os

    ###*
    * device type ( "pc" or "tablet" or "sp" )
    * デバイスの種類 （ PC か tablet か sp ）
    * @property deviceType
    * @type str
    * @default undefined
    ###
    @deviceType = ua.type

    ###*
    * browser name
    * ブラウザ名
    * @property browser
    * @type str
    * @default undefined
    ###
    @browser = ua.name

    ###*
    * browser version ( support ie or ios )
    * ブラウザのバージョン （IEとiOSしかサポートしてない）
    * @property device
    * @type str
    * @default undefined
    ###
    @browserVer = ua.ver







    return @

  ###*
   * judge equal this deviceType from parameter
   * @param {string} type
  ###
  Const::isDeviceType = ( type )->
    @deviceType is type

  # ---------------------------------------------------------
  # ブラウザ判別関数
  # ---------------------------------------------------------
  ###*
   * @method isBrowser
   * @param {object} browser parameter
   * @return {boolean}
  ###
  Const::isBrowser = ( obj )=>
    obj.name = obj.name or "ie"
    obj.ver = obj.ver or undefined
    if @browser is obj.name
      if obj.ver is undefined
        if @browserVer is obj.version
          return true
        else
          return false
      else
        return true
    else
      return false

  # ---------------------------------------------------------
  # 〜より上のバージョンのブラウザ（主にIE）
  # ---------------------------------------------------------
  Const::moreBrowserVer = ( obj ) =>
    obj.name = obj.name or "ie"
    obj.ver = obj.ver or 6
    if @.browser is obj.name
      if obj.and is "more"
        return true if @browserVer >= obj.version
      else if obj.and is "less"
        return true if @browserVer <= obj.version

  ###*
  * ブラウザが指定バージョンより上のバージョンか否かの判別メソッド
  * 主にIEで使用。パラメータのプロパティに name を入れれば他ブラウザに対応
  * @method andMore
  * @param {object} obj @.name = str browser name @.ver = num version
  * @return boolean 指定バージョンより上のバージョンなら真
  ###
  Const::andMore = ( obj ) ->
    obj.and = obj.and or "more"
    @moreBrowserVer( obj )

  ###*
  * ブラウザが指定バージョンより下のバージョンか否かの判別メソッド
  * 主にIEで使用。パラメータのプロパティに name を入れれば他ブラウザに対応
  * @method andLess
  * @param obj @.name = str browser name @.ver = num version
  * @return boolean 指定バージョンより下のバージョンなら真
  ###
  Const::andLess = ( obj ) ->
    obj.and = obj.and or "less"
    @moreBrowserVer( obj )


  # ---------------------------------------------------------
  # デバイス種別判定
  # ---------------------------------------------------------
  ###*
  * デバイスの種類がpcか否かの判別メソッド
  * @method isPc
  * @param null
  * @return boolean デバイスタイプがpcなら真
  ###
  Const::isPc = ->
    @isDeviceType( pcStr )

  ###*
  * デバイスの種類がtabletか否かの判別メソッド
  * @method tablet
  * @param null
  * @return {boolean} デバイスタイプがtabletなら真
  ###
  Const::isTablet = ->
    @isDeviceType( tabletStr )

  ###*
  * デバイスの種類がspか否かの判別メソッド
  * @method isSp
  * @param null
  * @return {boolean} デバイスタイプがspなら真
  ###
  Const::isSp = ->
    @isDeviceType( spStr )


  # ---------------------------------------------------------
  # ブラウザ個別判別
  # ---------------------------------------------------------
  ###*
  * IE6より上のバージョンか否かの判別メソッド
  * @method andMoreIe6
  * @param null
  * @return boolean IE6以上のブラウザなら真
  ###
  Const::andMoreIe6 = ->
    @andMore({ver:6})

  ###*
  * IE7より上のバージョンか否かの判別メソッド
  * @method andMoreIe7
  * @param null
  * @return boolean IE7以上のブラウザなら真
  ###
  Const::andMoreIe7 = ->
    @andMore({ver:7})

  ###*
  * IE8より上のバージョンか否かの判別メソッド
  * @method andMoreIe8
  * @param null
  * @return boolean IE8以上のブラウザなら真
  ###
  Const::andMoreIe8 = ->
    @andMore({ver:8})

  ###*
  * IE9より上のバージョンか否かの判別メソッド
  * @method andMoreIe9
  * @param null
  * @return boolean IE9以上のブラウザなら真
  ###
  Const::andMoreIe9 = ->
    @andMore({ver:9})

  ###*
  * IEか否かの判別メソッド
  * @method isIe
  * @param null
  * @return boolean IE6なら真
  ###
  Const::isIe = ->
    @isBrowser
      name:"ie"

  ###*
  * IE6か否かの判別メソッド
  * @method isIe6
  * @param null
  * @return boolean IE6なら真
  ###
  Const::isIe6 = ->
    @isBrowser
      name:"ie"
      ver:6

  ###*
  * IE7か否かの判別メソッド
  * @method isIe7
  * @param null
  * @return boolean IE7なら真
  ###
  Const::isIe7 = ->
    @isBrowser
      name:"ie"
      ver:7

  ###*
  * IE8か否かの判別メソッド
  * @method isIe8
  * @param null
  * @return boolean IE8なら真
  ###
  Const::isIe8 = ->
    @isBrowser
      name:"ie"
      ver:8

  ###*
  * IE9か否かの判別メソッド
  * @method isIe9
  * @param null
  * @return boolean IE9なら真
  ###
  Const::isIe9 = =>
    @isBrowser
      name:"ie"
      ver:9

  ###*
  * IE10か否かの判別メソッド
  * @method isIe10
  * @param null
  * @return boolean IE10なら真
  ###
  Const::isIe10 = ->
    @isBrowser
      name:"ie"
      ver:10

  ###*
  * IE11か否かの判別メソッド
  * @method isIe11
  * @param null
  * @return boolean IE11なら真
  ###
  Const::isIe11 = ->
    @isBrowser
      name:"ie"
      ver:11

  ###*
  * firefoxか否かの判別メソッド
  * @method isFirefox
  * @param null
  * @return boolean firefoxなら真
  ###
  @isFirefox = ->
    @isBrowser
      name:"firefox"

  ###*
  * chromeか否かの判別メソッド
  * @method isChrome
  * @param null
  * @return boolean chromeなら真
  ###
  Const::isChrome = ->
    @isBrowser
      name: "chrome"

  ###*
  * safariか否かの判別メソッド
  * @method isSafari
  * @param null
  * @return boolean safariなら真
  ###
  Const::isSafari = ->
    @isBrowser
      name: "safari"

  ###*
  * operaか否かの判別メソッド
  * @method isOpera
  * @param null
  * @return {boolean} operaなら真
  ###
  Const::isOpera = ->
    @isBrowser
      name: "opera"

  return
) jQuery, _, window, app
