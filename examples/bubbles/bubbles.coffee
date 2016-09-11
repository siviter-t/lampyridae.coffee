# @file bubbles.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###
require 'particle/firefly'

canvas = new Lampyridae.Canvas 'world'

Lampyridae.Firefly::hueMax = 225
Lampyridae.Firefly::hueMin = 180
Lampyridae.Firefly::lightness = '65%'
Lampyridae.Firefly::opacity = 0.15
Lampyridae.Firefly::radiusMax = 150
Lampyridae.Firefly::radiusMin = 15
Lampyridae.Firefly::speedMax = 15
Lampyridae.Firefly::speedMin = 5
Lampyridae.Firefly::turningAngle = 0.2 * Math.PI

total = 50
bubbles = []

createBubble = () ->
  for i in [0...total]
    bubble = new Lampyridae.Firefly canvas
    bubbles.push bubble
  
update = () -> bubbles[i].update() for i in [0...total]

createBubble()
canvas.addUpdate canvas.draw.clear
canvas.addUpdate update
canvas.animate()