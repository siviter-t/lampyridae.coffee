# @file firefly.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###
require 'particle/firefly'

canvas = new Lampyridae.Canvas 'world'

Lampyridae.Firefly::speedMax = 5
Lampyridae.Firefly::enableGlow = true
Lampyridae.Firefly::glowFactor = 6

total = 25
fireflies = []

createFireflies = () ->
  for i in [0...total]
    firefly = new Lampyridae.Firefly canvas
    fireflies.push firefly

update = () -> fireflies[i].update() for i in [0...total]

createFireflies()
canvas.addUpdate canvas.draw.clear
canvas.addUpdate update
canvas.animate()