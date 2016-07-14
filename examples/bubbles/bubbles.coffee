# @file bubbles.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###
require 'particle/bug'

$(document).ready ->
   canvas = new Lampyridae.Canvas 'world'
   
   Lampyridae.bugHueMax = 225
   Lampyridae.bugHueMin = 180
   Lampyridae.bugLightness = '65%'
   Lampyridae.bugOpacity = 0.15
   Lampyridae.bugRadiusMax = 150
   Lampyridae.bugRadiusMin = 15
   Lampyridae.bugSpeedMax = 15
   Lampyridae.bugSpeedMin = 5
   Lampyridae.bugTurningAngle = 0.2 * Math.PI
   
   numOfBugs = 75
   bugs = []
   
   createBugs = () ->
      for i in [0...numOfBugs]
         bug = new Lampyridae.Bug canvas
         bugs.push bug
      return
      
   animate = () ->
      canvas.draw.clear()
      update()
      requestAnimationFrame animate
      return
   
   update = () ->
      bugs[i].update() for i in [0...numOfBugs]
      return
   
   createBugs()
   animate()
   
   return