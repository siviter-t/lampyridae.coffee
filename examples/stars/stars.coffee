# @file stars.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###
require 'particle/firefly'

canvas = new Lampyridae.Canvas 'world'

Lampyridae.Firefly::hueMax = 70
Lampyridae.Firefly::hueMin = 0
Lampyridae.Firefly::lightness = '95%'
Lampyridae.Firefly::opacity = 0.75
Lampyridae.Firefly::radiusMax = 0.5
Lampyridae.Firefly::radiusMin = 0.05
Lampyridae.Firefly::speedMax = 0.4
Lampyridae.Firefly::speedMin = 0.1
Lampyridae.Firefly::turningAngle = 4 * Math.PI

total = 250
stars = []

createStars = () ->
  for i in [0...total]
    star = new Lampyridae.Firefly canvas, {bound: "none"}
    stars.push star

update = () -> stars[i].update() for i in [0...total]

createStars()
canvas.addUpdate canvas.draw.clear
canvas.addUpdate update
canvas.animate()