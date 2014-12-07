(($, w, app)->

  # ------------------------------------
  # anchor link
  # ------------------------------------
  $("a[href^=#]").not("a[href=#], .noAnimateAnchor").click ->
    speed = 500
    href = $(@).attr("href")
    target = $((if href is "#" or href is "" then "html" else href))
    position = target.offset().top
    $("html, body").animate
      scrollTop: position
    , speed, "swing"
    false

  return
)(jQuery, window, app)