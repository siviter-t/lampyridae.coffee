(function() {
  'use strict';

  var globals = typeof window === 'undefined' ? global : window;
  if (typeof globals.require === 'function') return;

  var modules = {};
  var cache = {};
  var aliases = {};
  var has = ({}).hasOwnProperty;

  var expRe = /^\.\.?(\/|$)/;
  var expand = function(root, name) {
    var results = [], part;
    var parts = (expRe.test(name) ? root + '/' + name : name).split('/');
    for (var i = 0, length = parts.length; i < length; i++) {
      part = parts[i];
      if (part === '..') {
        results.pop();
      } else if (part !== '.' && part !== '') {
        results.push(part);
      }
    }
    return results.join('/');
  };

  var dirname = function(path) {
    return path.split('/').slice(0, -1).join('/');
  };

  var localRequire = function(path) {
    return function expanded(name) {
      var absolute = expand(dirname(path), name);
      return globals.require(absolute, path);
    };
  };

  var initModule = function(name, definition) {
    var hot = null;
    hot = hmr && hmr.createHot(name);
    var module = {id: name, exports: {}, hot: hot};
    cache[name] = module;
    definition(module.exports, localRequire(name), module);
    return module.exports;
  };

  var expandAlias = function(name) {
    return aliases[name] ? expandAlias(aliases[name]) : name;
  };

  var _resolve = function(name, dep) {
    return expandAlias(expand(dirname(name), dep));
  };

  var require = function(name, loaderPath) {
    if (loaderPath == null) loaderPath = '/';
    var path = expandAlias(name);

    if (has.call(cache, path)) return cache[path].exports;
    if (has.call(modules, path)) return initModule(path, modules[path]);

    throw new Error("Cannot find module '" + name + "' from '" + loaderPath + "'");
  };

  require.alias = function(from, to) {
    aliases[to] = from;
  };

  var extRe = /\.[^.\/]+$/;
  var indexRe = /\/index(\.[^\/]+)?$/;
  var addExtensions = function(bundle) {
    if (extRe.test(bundle)) {
      var alias = bundle.replace(extRe, '');
      if (!has.call(aliases, alias) || aliases[alias].replace(extRe, '') === alias + '/index') {
        aliases[alias] = bundle;
      }
    }

    if (indexRe.test(bundle)) {
      var iAlias = bundle.replace(indexRe, '');
      if (!has.call(aliases, iAlias)) {
        aliases[iAlias] = bundle;
      }
    }
  };

  require.register = require.define = function(bundle, fn) {
    if (typeof bundle === 'object') {
      for (var key in bundle) {
        if (has.call(bundle, key)) {
          require.register(key, bundle[key]);
        }
      }
    } else {
      modules[bundle] = fn;
      delete cache[bundle];
      addExtensions(bundle);
    }
  };

  require.list = function() {
    var list = [];
    for (var item in modules) {
      if (has.call(modules, item)) {
        list.push(item);
      }
    }
    return list;
  };

  var hmr = globals._hmr && new globals._hmr(_resolve, require, modules, cache);
  require._cache = cache;
  require.hmr = hmr && hmr.wrap;
  require.brunch = true;
  globals.require = require;
})();

(function() {
var global = window;
var __makeRelativeRequire = function(require, mappings, pref) {
  var none = {};
  var tryReq = function(name, pref) {
    var val;
    try {
      val = require(pref + '/node_modules/' + name);
      return val;
    } catch (e) {
      if (e.toString().indexOf('Cannot find module') === -1) {
        throw e;
      }

      if (pref.indexOf('node_modules') !== -1) {
        var s = pref.split('/');
        var i = s.lastIndexOf('node_modules');
        var newPref = s.slice(0, i).join('/');
        return tryReq(name, newPref);
      }
    }
    return none;
  };
  return function(name) {
    if (name in mappings) name = mappings[name];
    if (!name) return;
    if (name[0] !== '.' && pref) {
      var val = tryReq(name, pref);
      if (val !== none) return val;
    }
    return require(name);
  }
};
require.register("config.coffee", function(exports, require, module) {

/* Global application settings */

(function() {
  Lampyridae.enableSimpleGlow = true;

  Lampyridae.timestep = 1;


  /* Common variables */

  Lampyridae.PI2 = 2.0 * Math.PI;


  /* 'Lightning' Bug specific variables */

  Lampyridae.bugHueMax = 102.72;

  Lampyridae.bugHueMin = 65.28;

  Lampyridae.bugSaturation = '100%';

  Lampyridae.bugLightness = '50%';

  Lampyridae.bugOpacity = 0.8;

  Lampyridae.bugRadiusMax = 3.0;

  Lampyridae.bugRadiusMin = 0.5;

  Lampyridae.bugSpeedMin = 1;

  Lampyridae.bugSpeedMax = 7;

  Lampyridae.bugTurningAngle = 0.1 * Math.PI;

}).call(this);
});

;require.register("core/canvas.coffee", function(exports, require, module) {
(function() {
  Lampyridae.Canvas = (function() {

    /* Construct and manage a canvas element.
     *
     * @param id [String] Name of the #id selector for the canvas element
     * @param parent [String] Name of the element to attach the canvas to (defaults to body)
     * @todo Add options + add selection of an exisiting canvas
     */
    function Canvas(id, parent) {
      this.id = id;
      this.parent = parent != null ? parent : 'body';
      if (arguments.length < 1) {
        throw new Error("Lampyridae: Canvas requires an \#id selector");
      }
      this.element = document.createElement('canvas');
      this.context = this.element.getContext('2d');
      this.setID();
      this.append();
      this.resizeToParent();
      $(window).resize((function(_this) {
        return function() {
          return _this.resizeToParent();
        };
      })(this));
      this.draw = new Lampyridae.Draw(this);
    }

    Canvas.prototype.width = function() {
      return $(this.element).width();
    };

    Canvas.prototype.height = function() {
      return $(this.element).height();
    };

    Canvas.prototype.area = function() {
      return $(this.element).width() * $(this.element).height();
    };

    Canvas.prototype.setWidth = function(width) {
      if (width == null) {
        width = $(this.parent).innerWidth();
      }
      $(this.element).width(width).attr('width', width);
      return width;
    };

    Canvas.prototype.setHeight = function(height) {
      if (height == null) {
        height = $(this.parent).innerHeight();
      }
      $(this.element).height(height).attr('height', height);
      return height;
    };

    Canvas.prototype.setID = function(id) {
      this.id = id != null ? id : this.id;
      $(this.element).attr('id', this.id);
      return this.id;
    };

    Canvas.prototype.append = function(parent) {
      this.parent = parent != null ? parent : this.parent;
      $(this.parent).append(this.element);
      return console.log("Lampyridae: Appended \#" + this.id + " to " + this.parent);
    };

    Canvas.prototype.resizeToParent = function() {
      this.setWidth();
      return this.setHeight();
    };

    return Canvas;

  })();

  module.exports = Lampyridae.Canvas;

}).call(this);
});

;require.register("core/draw.coffee", function(exports, require, module) {
(function() {
  Lampyridae.Draw = (function() {

    /* Construct and manage a Canvas 2D drawing object.
     *
     * @param canvas [Lampyridae.Canvas] Instance of the Canvas
     */
    function Draw(canvas) {
      this.canvas = canvas;
      if (arguments.length < 1) {
        throw new Error("Lampyridae: Draw requires an instance of Canvas");
      }
      this.ctx = this.canvas.context;
      console.log("Lampyridae: Initialised 2D drawing object for \#" + this.canvas.id + " ");
    }


    /* Clear a given area of the Canvas.
     * Defaults to the full available Canvas area if no arguments are given.
     *
     * @param x [Number] Starting position along x-axis.
     * @param y [Number] Starting position along y-axis.
     * @param w [Number] Final position along x-axis. 
     * @param h [Number] Final position along y-axis.
     */

    Draw.prototype.clear = function(x, y, w, h) {
      return this.ctx.clearRect(x, y, w, h);
    };

    Draw.prototype.clear = function() {
      return this.ctx.clearRect(0, 0, this.canvas.width(), this.canvas.height());
    };


    /* Reset the global alpha to opaque. */

    Draw.prototype.resetGlobalAlpha = function() {
      return this.ctx.globalAlpha = 1.0;
    };


    /* Set the global alpha to the given argument.
     * If an invalid argument is given this method will instead reset the alpha.
     *
     * @param a [Number] Alpha value between [0, 1]
     */

    Draw.prototype.setGlobalAlpha = function(a) {
      if ((0.0 <= a && a < 1.0)) {
        return this.ctx.globalAlpha = a;
      } else {
        return this.resetGlobalAlpha();
      }
    };


    /* Drawing path encapsulated begin and close
     *
     * @param callback [Function] Drawing method(s) to encapsulated
     */

    Draw.prototype.beginClose = function(callback) {
      this.ctx.beginPath();
      if (typeof callback === "function") {
        callback();
      }
      return this.ctx.closePath();
    };

    Draw.prototype.begin = function() {
      return this.ctx.beginPath();
    };

    Draw.prototype.end = function() {
      return this.ctx.closePath();
    };


    /* Define a stroke on the Canvas instance.
     *
     * @param width [Number] Width of the stroke
     * @param colour [String] Colour of the stroke
     */

    Draw.prototype.stroke = function(width, colour) {
      this.ctx.strokeStyle = colour;
      this.ctx.lineWidth = width;
      return this.ctx.stroke();
    };


    /* Fill a drawing on the Canvas instance.
     *
     * @param colour [String] Colour of the fill
     */

    Draw.prototype.fill = function(colour) {
      this.ctx.fillStyle = colour;
      return this.ctx.fill();
    };


    /* Add a lovely glow effect or shadow blur to a drawing.
     *
     * @param radius [Number] Radius of the glow
     * @param colour [String] Colour of the glow
     * @param x [Number] Distance to offset the shadow along the x-axis. Default: 0
     * @param y [Number] Distance to offset the shadow along the y-axis. Default: 0
     */

    Draw.prototype.glow = function(radius, colour, x, y) {
      if (x == null) {
        x = 0;
      }
      if (y == null) {
        y = 0;
      }
      this.canvas.context.shadowOffsetX = x;
      this.canvas.context.shadowOffsetY = y;
      this.canvas.context.shadowColor = colour;
      return this.canvas.context.shadowBlur = radius;
    };


    /* Draw an arc onto the Canvas instance.
     *
     * @param x [Number] Position along x-axis to draw around
     * @param y [Number] Position along y-axis to draw around
     * @param radius [Number] Radius of the arc
     * @param end [Number] Final angle of arc in radians
     * @param start [Number] Starting angle of arc in radians from the x-axis. Default: 0
     * @param clockwise [Boolean] true = clockwise, false = anticlockwise. Default: false
     */

    Draw.prototype.arc = function(x, y, radius, end, start, clockwise) {
      if (start == null) {
        start = 0;
      }
      if (clockwise == null) {
        clockwise = false;
      }
      return this.ctx.arc(x, y, radius, start, end, !clockwise);
    };


    /* Draw a circle onto the Canvas instance.
     *
     * @param x [Number] Position along x-axis to draw around
     * @param y [Number] Position along y-axis to draw around
     * @param radius [Number] Radius of the circle
     */

    Draw.prototype.circle = function(x, y, radius) {
      return this.arc(x, y, radius, Lampyridae.PI2);
    };

    return Draw;

  })();

  module.exports = Lampyridae.Draw;

}).call(this);
});

;require.register("lampyridae.coffee", function(exports, require, module) {

/* @file lampyridae.js
 * @Copyright (c) 2016 Taylor Siviter
 * This source code is licensed under the MIT License.
 * For full information, see the LICENSE file in the project root.
 */

(function() {
  (function() {
    var err;
    if (window.Lampyridae == null) {
      return window.Lampyridae = {};
    } else {
      err = new Error('Lampyridae namespace could not be assigned. Is there a conflict?');
      err.name = 'FatalError';
      throw err;
    }
  })();


  /* Config */

  require('config');


  /* Core classes */

  require('core/canvas');

  require('core/draw');

}).call(this);
});

;require.register("particle/bug.coffee", function(exports, require, module) {
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  require('lampyridae');

  require('particle/particle');

  require('util/hslToRgb');

  require('util/rand');

  Lampyridae.Bug = (function(superClass) {
    extend(Bug, superClass);


    /* Construct and manage a Lampyridae bug 'particle'.
     *
     * @param canvas [Object] Instance of Lampyridae.Canvas to attach the bug to
     * @param x [Number] Position of the bug along the x-axis
     * @param y [Number] Position of the bug along the y-axis
     * @param t [Number] Direction of the bug (radians anticlockwise from the x-axis)
     * @param v [Number] Speed of the bug
     * @param r [Number] Radius of the bug
     * @param c [Array] RGB Colour code array of the bug - e.g. "[r, g, b]"
     */

    function Bug(canvas, x, y, t, v, r, c, a) {
      var h;
      if (!(arguments.length > 0)) {
        throw new Error("Lampyridae: Bug requires a valid Canvas instance to be attached to");
      }
      if (x == null) {
        x = Lampyridae.rand(0, canvas.width());
      }
      if (y == null) {
        y = Lampyridae.rand(0, canvas.height());
      }
      if (v == null) {
        v = Lampyridae.rand(Lampyridae.bugSpeedMin, Lampyridae.bugSpeedMax);
      }
      if (t == null) {
        t = Lampyridae.rand(0.0, Lampyridae.PI2);
      }
      if (r == null) {
        r = Lampyridae.rand(Lampyridae.bugRadiusMin, Lampyridae.bugRadiusMax);
      }
      h = Lampyridae.rand(Lampyridae.bugHueMin, Lampyridae.bugHueMax);
      if (c == null) {
        c = Lampyridae.hslToRgb(h, Lampyridae.bugSaturation, Lampyridae.bugLightness);
      }
      c = "rgb(" + c[0] + ", " + c[1] + ", " + c[2] + ")";
      if (a == null) {
        a = Lampyridae.bugOpacity;
      }
      Bug.__super__.constructor.call(this, canvas, x, y, t, v, r, {
        colour: c,
        alpha: a
      });
    }

    Bug.prototype.randomTurn = function() {
      return this.turn(Lampyridae.bugTurningAngle * (2.0 * Math.random() - 1.0));
    };

    Bug.prototype.fly = function() {
      return this.applyHardBounds();
    };

    Bug.prototype.update = function() {
      this.fly();
      return this.draw();
    };

    Bug.prototype.draw = function() {
      this.canvas.draw.begin();
      this.canvas.draw.setGlobalAlpha(this.alpha);
      if (Lampyridae.enableSimpleGlow) {
        this.canvas.draw.glow(2.0 * this.r, this.colour);
      }
      this.canvas.draw.circle(this.x, this.y, this.r);
      this.canvas.draw.fill(this.colour);
      return this.canvas.draw.end();
    };

    return Bug;

  })(Lampyridae.Particle);

  module.exports = Lampyridae.Bug;

}).call(this);
});

;require.register("particle/particle.coffee", function(exports, require, module) {
(function() {
  require('lampyridae');

  Lampyridae.Particle = (function() {

    /* Construct and manage a generic circular particle.
     *
     * @param canvas [Object] Instance of Lampyridae.Canvas to attach the particle to
     * @param x [Number] Position of the particle along the x-axis
     * @param y [Number] Position of the particle along the y-axis
     * @param t [Number] Direction of the particle (radians anticlockwise from the x-axis)
     * @param v [Number] Speed of the particle
     * @param r [Number] Radius of the particle
     * @option colour [String] Colour code of the particle - e.g. "rgb(255, 255, 255)"
     * @option alpha [Number] Opacity of the particle
     */
    function Particle(canvas, x, y, t, v, r, options) {
      var ref, ref1;
      this.canvas = canvas;
      this.x = x;
      this.y = y;
      this.t = t;
      this.v = v;
      this.r = r;
      this.colour = (ref = options.colour) != null ? ref : "rgb(255, 255, 255)";
      this.alpha = (ref1 = options.alpha) != null ? ref1 : 1.0;
    }

    Particle.prototype.vx = function() {
      return this.v * Math.cos(this.t);
    };

    Particle.prototype.vy = function() {
      return this.v * Math.sin(this.t);
    };

    Particle.prototype.turn = function(angle) {
      if (angle == null) {
        angle = 0.0;
      }
      return this.t += angle;
    };

    Particle.prototype.turnAround = function() {
      return this.turn(Math.PI);
    };

    Particle.prototype.move = function() {
      this.x += Lampyridae.timestep * this.vx();
      return this.y += Lampyridae.timestep * this.vy();
    };

    Particle.prototype.isOutsideCanvas = function() {
      var ref, ref1;
      if (!((0.0 <= (ref = this.x) && ref <= this.canvas.width()))) {
        return true;
      } else if (!((0.0 <= (ref1 = this.y) && ref1 <= this.canvas.height()))) {
        return true;
      }
      return false;
    };

    Particle.prototype.applyHardBounds = function() {
      if (!this.isOutsideCanvas()) {
        this.randomTurn();
      } else {
        this.turnAround();
        while (!this.isOutsideCanvas()) {
          this.move;
        }
      }
      return this.move();
    };

    Particle.prototype.update = function() {
      this.move();
      return this.draw();
    };

    Particle.prototype.draw = function() {
      this.canvas.draw.begin();
      this.canvas.draw.circle(this.x, this.y, this.r);
      this.canvas.draw.fill(this.colour);
      return this.canvas.draw.end();
    };

    return Particle;

  })();

  module.exports = Lampyridae.Particle;

}).call(this);
});

;require.register("util/hslToRgb.coffee", function(exports, require, module) {
(function() {
  require('lampyridae');


  /* Converts HSL colour to RGB.
   * Code adapted from:
   * @see https://github.com/bgrins/TinyColor
   * @see http://serennu.com/colour/rgbtohsl.php
   *
   * @param h [Number] The hue [0, 360]
   * @param s [Number] The saturation [0, 100]%
   * @param l [Number] The lightness [0, 100]%
   * @return [Array] The RGB representation [0, 255]
   */

  Lampyridae.hslToRgb = function(h, s, l) {
    var b, g, hue2rgb, p, q, r;
    h = parseFloat(h) / 360.0;
    s = parseFloat(s) / 100.0;
    l = parseFloat(l) / 100.0;
    if (s === 0) {
      r = g = b = l;
    } else {
      hue2rgb = function(p, q, t) {
        if (t < 0) {
          t += 1;
        }
        if (t > 1) {
          t -= 1;
        }
        if (t < 0.5) {
          return q;
        }
        if (t < 1 / 6) {
          return p + (q - p) * 6.0 * t;
        }
        if (t < 2 / 3) {
          return p + (q - p) * (4 - 6.0 * t);
        }
        return p;
      };
      q = l < 0.5 ? l * (1 + s) : l + s - (l * s);
      p = 2 * l - q;
      r = hue2rgb(p, q, h + 1 / 3);
      g = hue2rgb(p, q, h);
      b = hue2rgb(p, q, h - 1 / 3);
    }
    return [Math.round(255 * r), Math.round(255 * g), Math.round(255 * b)];
  };

  module.exports = Lampyridae.hslToRgb;

}).call(this);
});

;require.register("util/rand.coffee", function(exports, require, module) {
(function() {
  require('lampyridae');


  /* Generates a random float from the given interval [l, u) where u > l.
   *
   * @param l [Number] The lower bound of the interval
   * @param u [Number] The upper bound of the interval
   * @return [Number] Random number from the interval [l, u)
   */

  Lampyridae.rand = function(l, u) {
    if (arguments.length === 0) {
      return Math.random();
    }
    return (u - l) * Math.random() + l;
  };

  module.exports = Lampyridae.rand;

}).call(this);
});

;require.register("___globals___", function(exports, require, module) {
  
});})();require('___globals___');

require('lampyridae');
//# sourceMappingURL=lampyridae.js.map