// Generated by CoffeeScript 1.10.0

/*
 * Example usage of lampyridae.coffee
 */

(function() {
  var canvas, createFireflies, fireflies, total, updateFireflies;

  require('particle/firefly');

  canvas = new Lampyridae.Canvas('world');

  Lampyridae.Firefly.prototype.speedMax = 5;

  Lampyridae.Firefly.prototype.enableGlow = true;

  Lampyridae.Firefly.prototype.glowFactor = 4;

  total = 25;

  fireflies = [];

  (createFireflies = function() {
    var firefly, i, j, ref, results;
    results = [];
    for (i = j = 0, ref = total; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      firefly = new Lampyridae.Firefly(canvas);
      results.push(fireflies.push(firefly));
    }
    return results;
  })();

  updateFireflies = function() {
    var i, j, ref, results;
    results = [];
    for (i = j = 0, ref = total; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      results.push(fireflies[i].update());
    }
    return results;
  };


  /*
   * Lights, camera, action!
   */

  canvas.addUpdate(canvas.draw.clear);

  canvas.addUpdate(updateFireflies);

  canvas.animate();

}).call(this);
