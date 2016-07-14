# @file bug.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'lampyridae'
require 'particle/particle'
require 'util/hslToRgb'
require 'util/rand'

class Lampyridae.Bug extends Lampyridae.Particle
   ### Construct and manage a Lampyridae bug 'particle'.
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
         throw new Error "Lampyridae: Bug requires a valid Canvas instance to be attached to"
      x ?= Lampyridae.rand 0, canvas.width() 
      y ?= Lampyridae.rand 0, canvas.height()
      v ?= Lampyridae.rand Lampyridae.bugSpeedMin, Lampyridae.bugSpeedMax
      t ?= Lampyridae.rand 0.0, Lampyridae.PI2
      r ?= Lampyridae.rand Lampyridae.bugRadiusMin, Lampyridae.bugRadiusMax
      h = Lampyridae.rand Lampyridae.bugHueMin, Lampyridae.bugHueMax
      c ?= Lampyridae.hslToRgb h, Lampyridae.bugSaturation, Lampyridae.bugLightness
      c = "rgb(#{c[0]}, #{c[1]}, #{c[2]})"
      a ?= Lampyridae.bugOpacity
      super(canvas, x, y, t, v, r, {colour: c, alpha: a})
   
   randomTurn: () -> @turn Lampyridae.bugTurningAngle * (2.0 * Math.random() - 1.0)
   
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
# end class Lampyridae.Bug

module.exports = Lampyridae.Bug