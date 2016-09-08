# @file firefly.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'util/hslToRgb'
require 'util/rand'

class Lampyridae.Firefly extends Lampyridae.Particle
   ### Construct and manage a Lampyridae firefly 'particle'.
   #
   # @param canvas [Object] Instance of Lampyridae.Canvas to attach the bug to
   # @param x [Number] Position of the bug along the x-axis
   # @param y [Number] Position of the bug along the y-axis
   # @param t [Number] Direction of the bug (radians anticlockwise from the x-axis)
   # @param v [Number] Speed of the bug
   # @param r [Number] Radius of the bug
   # @param c [Array] RGB Colour code array of the bug - e.g. "[r, g, b]"
   ###
   constructor: (canvas, x, y, t, v, r, c, a) ->
      unless arguments.length > 0
         throw new Error "Lampyridae: Firefly requires a valid Canvas instance to be attached to"
      x ?= Lampyridae.rand 0, canvas.width() 
      y ?= Lampyridae.rand 0, canvas.height()
      v ?= Lampyridae.rand @speedMin, @speedMax
      t ?= Lampyridae.rand 0.0, Lampyridae.PIx2
      r ?= Lampyridae.rand @radiusMin, @radiusMax
      h = Lampyridae.rand @hueMin, @hueMax
      c ?= Lampyridae.hslToRgb h, @saturation, @lightness
      c = "rgb(#{c[0]}, #{c[1]}, #{c[2]})"
      a ?= @opacity
      super(canvas, x, y, t, v, r, {colour: c, alpha: a})
   
   ### Firefly class prototype parameters.
   # Can be set by the user to whatever they wish; e.g. Lampyridae.Bug::radiusMax = 50, etc.
   ###
   speedMin: 1
   speedMax: 7
   radiusMax: 3.0
   radiusMin: 0.5
   turningAngle: 0.1 * Math.PI
   hueMax: 102.72 # Light green colour
   hueMin: 65.28 # Yellowy colour
   saturation: '100%'
   lightness: '50%'
   opacity: 0.8
   
   randomTurn: () -> @turn @turningAngle * (2.0 * Math.random() - 1.0)
   
   # Todo: Add option for periodic or hard-wall boundaries
   fly: () ->
      @applyHardBounds()
   
   update: () ->
      @fly()
      @draw()
      
   draw: () ->
      @canvas.draw.begin()
      @canvas.draw.setGlobalAlpha @alpha
      if Lampyridae.enableSimpleGlow
         @canvas.draw.glow 2.0 * @r, @colour
      @canvas.draw.circle @x, @y, @r
      @canvas.draw.fill @colour
      @canvas.draw.end()
# end class Lampyridae.Firefly

module.exports = Lampyridae.Firefly