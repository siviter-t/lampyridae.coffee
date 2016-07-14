# @file stars.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###
require 'particle/bug'

$(document).ready ->
   canvas = new Lampyridae.Canvas 'world'
   
   Lampyridae.bugHueMax = 70
   Lampyridae.bugHueMin = 0
   Lampyridae.bugLightness = '95%'
   Lampyridae.bugOpacity = 0.75
   Lampyridae.bugRadiusMax = 0.5
   Lampyridae.bugRadiusMin = 0.05
   Lampyridae.bugSpeedMax = 0.4
   Lampyridae.bugSpeedMin = 0.1
   Lampyridae.bugTurningAngle = 4 * Math.PI
   
   numOfBugs = 250
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