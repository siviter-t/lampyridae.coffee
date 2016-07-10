# @file firefly.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###
$(document).ready ->
   canvas = new Lampyridae.Canvas 'world'
   
   Lampyridae.bugSpeedMax = 5
   
   numOfBugs = 25
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