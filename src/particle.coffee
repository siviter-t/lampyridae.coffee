# @file particle.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

class Lampyridae.Particle
   ### Construct and manage a generic circular particle
   #
   # @param canvas [Object] Instance of Lampyridae.Canvas to attach the particle to
   # @param x [Number] Position of the particle along the x-axis
   # @param y [Number] Position of the particle along the y-axis
   # @param theta [Number] Direction of the particle (radians anticlockwise from the x-axis)
   # @param v [Number] Speed of the particle
   # @param r [Number] Radius of the particle
   # @param rgb [String] RGB Colour code of the particle - e.g. "rgb(255, 255, 255)"
   ###
   constructor: (@canvas, @x, @y, @theta, @v, @radius, @rgb) -> return
   
   vx: () -> return @v * Math.cos(@theta)
   vy: () -> return @v * Math.sin(@theta)
   turn: (angle = 0.0) -> @theta += angle; return
   turnAround: () -> @turn Math.PI; return
   
   move: () ->
      @x += Lampyridae.timestep * @vx()
      @y += Lampyridae.timestep * @vy()
      return
      
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
      return

   update: () ->
      @move()
      @draw()
      return
   
   draw: () ->
      @canvas.context.beginPath()
      @canvas.context.arc @x, @y, @radius, 0.0, 2.0 * Math.PI, false
      @canvas.context.fillStyle = @rgb
      @canvas.context.fill()
      return
# end class Lampyridae.Bug