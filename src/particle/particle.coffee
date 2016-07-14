# @file particle.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'lampyridae'

class Lampyridae.Particle
   ### Construct and manage a generic circular particle.
   #
   # @param canvas [Object] Instance of Lampyridae.Canvas to attach the particle to
   # @param x [Number] Position of the particle along the x-axis
   # @param y [Number] Position of the particle along the y-axis
   # @param t [Number] Direction of the particle (radians anticlockwise from the x-axis)
   # @param v [Number] Speed of the particle
   # @param r [Number] Radius of the particle
   # @option colour [String] Colour code of the particle - e.g. "rgb(255, 255, 255)"
   # @option alpha [Number] Opacity of the particle
   ###
   constructor: (@canvas, @x, @y, @t, @v, @r, options) -> 
      @colour = options.colour ? "rgb(255, 255, 255)"
      @alpha = options.alpha ? 1.0
   
   vx: () -> return @v * Math.cos(@t)
   vy: () -> return @v * Math.sin(@t)
   turn: (angle = 0.0) -> @t += angle
   turnAround: () -> @turn Math.PI
   
   move: () ->
      @x += Lampyridae.timestep * @vx()
      @y += Lampyridae.timestep * @vy()
      
   isOutsideCanvas: () ->
      unless 0.0 <= @x <= @canvas.width() 
         return true
      else unless 0.0 <= @y <= @canvas.height()
         return true
      return false
   
   # Move with regards to the 'hard-walled' boundary of the canvas
   applyHardBounds: () ->
      unless @isOutsideCanvas() then @randomTurn()
      else
         @turnAround()
         @move until @isOutsideCanvas()
      @move()

   update: () ->
      @move()
      @draw()
   
   draw: () ->
      @canvas.draw.begin()
      @canvas.draw.circle @x, @y, @r
      @canvas.draw.fill @colour
      @canvas.draw.end()
# end class Lampyridae.Particle

module.exports = Lampyridae.Particle