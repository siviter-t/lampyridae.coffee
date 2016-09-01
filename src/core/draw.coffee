# @file draw.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

class Lampyridae.Draw
   ### Construct and manage a Canvas 2D drawing object.
   #
   # @param canvas [Lampyridae.Canvas] Instance of the Canvas
   ###
   constructor: (@canvas) ->
      if arguments.length < 1
         throw new Error "Lampyridae: Draw requires an instance of Canvas"
      
      @ctx = @canvas.context
      console.log "Lampyridae: Initialised 2D drawing object for \##{@canvas.id()} "
   
   # Utility methods #
   
   ### Clear a given area of the Canvas.
   # Defaults to the full available Canvas area if no arguments are given.
   #
   # @param x [Number] Starting position along x-axis.
   # @param y [Number] Starting position along y-axis.
   # @param w [Number] Final position along x-axis. 
   # @param h [Number] Final position along y-axis.
   ###
   clear: (x, y, w, h) -> @ctx.clearRect x, y, w, h
   clear: () -> @ctx.clearRect 0, 0, @canvas.width(), @canvas.height()
   
   ### Reset the global alpha to opaque. ###
   resetGlobalAlpha: () -> @ctx.globalAlpha = 1.0
   
   ### Set the global alpha to the given argument.
   # If an invalid argument is given this method will instead reset the alpha.
   #
   # @param a [Number] Alpha value between [0, 1]
   ###
   setGlobalAlpha: (a) ->
      if 0.0 <= a < 1.0 then @ctx.globalAlpha = a
      else @resetGlobalAlpha()
   
   # Drawing utility methods #
   
   ### Drawing path encapsulated begin and close
   #
   # @param callback [Function] Drawing method(s) to encapsulated
   ###
   beginClose: (callback) ->
      @ctx.beginPath()
      callback?()
      @ctx.closePath()
   begin: () -> @ctx.beginPath()
   end: () -> @ctx.closePath()
   
   ### Define a stroke on the Canvas instance.
   #
   # @param width [Number] Width of the stroke
   # @param colour [String] Colour of the stroke
   ###
   stroke: (width, colour) ->
      @ctx.strokeStyle = colour
      @ctx.lineWidth = width
      @ctx.stroke()
   
   ### Fill a drawing on the Canvas instance.
   #
   # @param colour [String] Colour of the fill
   ###
   fill: (colour) ->
      @ctx.fillStyle = colour
      @ctx.fill()
   
   ### Add a lovely glow effect or shadow blur to a drawing.
   #
   # @param radius [Number] Radius of the glow
   # @param colour [String] Colour of the glow
   # @param x [Number] Distance to offset the shadow along the x-axis. Default: 0
   # @param y [Number] Distance to offset the shadow along the y-axis. Default: 0
   ###
   glow: (radius, colour, x = 0, y = 0) ->
      @canvas.context.shadowOffsetX = x
      @canvas.context.shadowOffsetY = y
      @canvas.context.shadowColor = colour
      @canvas.context.shadowBlur = radius
   # Drawing methods #
   
   ### Draw an arc onto the Canvas instance.
   #
   # @param x [Number] Position along x-axis to draw around
   # @param y [Number] Position along y-axis to draw around
   # @param radius [Number] Radius of the arc
   # @param end [Number] Final angle of arc in radians
   # @param start [Number] Starting angle of arc in radians from the x-axis. Default: 0
   # @param clockwise [Boolean] true = clockwise, false = anticlockwise. Default: false
   ###
   arc: (x, y, radius, end, start = 0, clockwise = false) ->
      @ctx.arc x, y, radius, start, end, !clockwise
   
   ### Draw a circle onto the Canvas instance.
   #
   # @param x [Number] Position along x-axis to draw around
   # @param y [Number] Position along y-axis to draw around
   # @param radius [Number] Radius of the circle
   ###
   circle: (x, y, radius) -> @arc x, y, radius, Lampyridae.PI2
   
# end class Lampyridae.Canvas.Draw

module.exports = Lampyridae.Draw