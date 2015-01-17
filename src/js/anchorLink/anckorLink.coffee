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
    target = $((href is "#" || href is "" ? "html" : href))
    animateParam =
      scrollTop: target.offset().top

    $("html, body").animate(animateParam, speed, easing);

    return false;

  return
) window, app, jQuery