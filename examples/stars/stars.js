// Generated by CoffeeScript 1.10.0

/*
 * Example usage of lampyridae.coffee
 */

(function() {
  var canvas, createStars, stars, total, update;

  require('particle/firefly');

  canvas = new Lampyridae.Canvas('world');

  Lampyridae.Firefly.prototype.hueMax = 70;

  Lampyridae.Firefly.prototype.hueMin = 0;

  Lampyridae.Firefly.prototype.lightness = '95%';

  Lampyridae.Firefly.prototype.opacity = 0.75;

  Lampyridae.Firefly.prototype.radiusMax = 0.5;

  Lampyridae.Firefly.prototype.radiusMin = 0.05;

  Lampyridae.Firefly.prototype.speedMax = 0.4;

  Lampyridae.Firefly.prototype.speedMin = 0.1;

  Lampyridae.Firefly.prototype.turningAngle = 4 * Math.PI;

  total = 250;

  stars = [];

  createStars = function() {
    var i, j, ref, results, star;
    results = [];
    for (i = j = 0, ref = total; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      star = new Lampyridae.Firefly(canvas, {
        bound: "none"
      });
      results.push(stars.push(star));
    }
    return results;
  };

  update = function() {
    var i, j, ref, results;
    results = [];
    for (i = j = 0, ref = total; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
      results.push(stars[i].update());
    }
    return results;
  };

  createStars();

  canvas.addUpdate(canvas.draw.clear);

  canvas.addUpdate(update);

  canvas.animate();

}).call(this);
