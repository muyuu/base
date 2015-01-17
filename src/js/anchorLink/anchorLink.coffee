((w, app, $)->

  anchor = app.anchorLink = app.anchorLink || {};

  # init
  anchor.init = ->

    notEle = "a[href=#], .noAnimateAnchor";
    $("a[href^=#]").not(notEle).on("click", anchor.moveAnchor);

  anchor.moveAnchor = ->
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