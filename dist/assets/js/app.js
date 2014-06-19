var app;

app = app || {};

(function(app) {
  console.log("app.js");
  return app.add = function(a, b) {
    return a + b;
  };
})(app);
