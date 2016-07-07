# @file bug.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

# TODO: Extend from a generic particle class
class Lampyridae.Bug
   ### Construct and manage a Lampyridae bug 'particle'
   #
   # @param id [String] Name of the #id selector for the canvas element
   # @param parent [String] Name of the element to attatch the canvas to (defaults to body)
   # @todo Add options + add selection of an exisiting canvas
   ###
   constructor: (@x, @y, @theta, @v, @canvas) ->
      @radius = (Lampyridae.bugRadiusMax - Lampyridae.bugRadiusMin) * Math.random() + Lampyridae.bugRadiusMin
      return
   
   vx: () -> return @v * Math.cos(@theta)
   vy: () -> return @v * Math.sin(@theta)
   
   move: () ->
      @x += Lampyridae.timestep * @vx()
      @y += Lampyridae.timestep * @vy()
      return
   
   turn: (angle = 0.0) -> @theta += angle; return
   turnAround: () -> @turn Math.PI; return
   randomTurn: () -> @turn Lampyridae.bugTurningAngle * (2.0 * Math.random() - 1.0); return
   
   isOutsideCanvas: () ->
      unless 0.0 <= @x <= @canvas.width() 
         return true
      else unless 0.0 <= @y <= @canvas.height()
         return true
      return false
   
   # Move with regards to the 'hard-walled' boundary of the canvas
   hardBoundedFlight: () ->
      unless @isOutsideCanvas() then @randomTurn()
      else
         @turnAround()
         @move until @isOutsideCanvas()
      @move()
      return

   # Todo: Add option for periodic or hard-wall boundaries
   fly: () ->
      @hardBoundedFlight()
      return
   
   update: () ->
      @fly()
      @draw()
      return
    
   draw: () ->
      @canvas.context.beginPath()
      @canvas.context.arc @x, @y, @radius, 0.0, 2.0 * Math.PI, false
      @canvas.context.fillStyle = Lampyridae.bugDefaultColour
      @canvas.context.fill()
      return
# end class Lampyridae.Bug