(function() {
  (function() {
    $LAB.script("/assets/vendors/jquery/jquery.min.js").wait();
    $LAB.script("/assets/vendors/pocket/js/pocket.min.js").wait();
    return $LAB.script("/assets/js/app.js");
  });

}).call(this);
