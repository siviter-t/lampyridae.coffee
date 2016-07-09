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
   # @param a [Number] Opacity of the particle
   ###
   constructor: (@canvas, @x, @y, @theta, @v, @radius, @rgb, @a) -> return
   
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
   
   draw: (r = @radius, a = Lampyridae.PI2) ->
      # Move simple glow effect elsewhere with option (callback?)
      @canvas.context.globalAlpha = 0.5;
      @canvas.context.shadowBlur = 80
      @canvas.context.shadowColor = @rgb
      @canvas.context.beginPath()
      
      @drawCircle()
      @canvas.context.closePath()
      return
   
   ## Draw a circle onto the Canvas instance
   #
   # @param x [Number] Position along x-axis to draw around. Default: @x
   # @param y [Number] Position along y-axis to draw around. Default: @y
   # @param r [Number] Radius of the arc. Default: @radius
   # @param t [Number] Final angle of arc. Default: 2 * PI (i.e. a circle)
   # @param c [String] Colour code to fill the circle with
   ##
   drawCircle: (x = @x, y = @y, r = @radius, t = Lampyridae.PI2, c = @rgb) ->
      @canvas.context.arc x, y, r, 0.0, t, false
      @canvas.context.fillStyle = c
      @canvas.context.fill()
# end class Lampyridae.Bug