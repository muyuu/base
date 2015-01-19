((w, app, $)->

  me = app.anchorLink = app.anchorLink || {};

  # init
  me.init = ->

    notEle = "a[href=#], .noAnimateAnchor";
    $("a[href^=#]").not(notEle).on("click", me.moveAnchor);

  me.moveAnchor = ->
    href = $(this).attr("href")
    speed = 500
    easing = 'swing'
    target = $((if href is "#" or href is "" then "html" else href))
    animateParam =
      scrollTop: target.offset().top

    $("html, body").animate(animateParam, speed, easing);

    return false;

  return
) window, app, jQuery