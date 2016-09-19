# @file firefly.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###

# Only the Canvas and base Particle classes are included by default
require 'particle/firefly'

# By default, if there is no existing canvas with the id 'world', this will
# attach '<canvas id="world"></canvas>' under the body element.
canvas = new Lampyridae.Canvas 'world'

Lampyridae.Firefly::speedMax = 5       # You can change proto parameters!
Lampyridae.Firefly::enableGlow = true  # Glow is not enabled by default
Lampyridae.Firefly::glowFactor = 4     # Default is 4; rerun if changed

total = 25                             # Number of fireflies to spawn
fireflies = []                         # For keeping track of the fireflies

# Reusable firefly creator - remember to tweak the total if reused.
do createFireflies = () ->
  for i in [0...total]
    firefly = new Lampyridae.Firefly canvas
    fireflies.push firefly

# An iterative update over the fireflies - remember to add it to the canvas!  
updateFireflies = () -> fireflies[i].update() for i in [0...total]

###
# Lights, camera, action!
###

canvas.addUpdate canvas.draw.clear     # If you want the screen to clear between frames
canvas.addUpdate updateFireflies       # Update all the fireflies every frame
canvas.animate()                       # Animate the canvas screen