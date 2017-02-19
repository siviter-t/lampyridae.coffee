# @file gravity.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee with forces! (Gravity in this case)
###

# Only the Canvas and base Particle classes are included by default
require 'particle/forceParticle'

# By default, if there is no existing canvas with the id 'world', this will
# attach '<canvas id="world"></canvas>' under the body element.
canvas = new Lampyridae.Canvas 'world'

# For keeping track of the particles
particles = [] 

# Overall options
xMid = canvas.width() / 2
yMid = canvas.height() / 2
options = { bound: "none", vx:2.5, vy:0.0, colour: "#AB621D" }
Lampyridae.ForceParticle::enableGlow = true

# ~ Planets ~ #

options.x = xMid; # Above and below centre

options.radius = 3.0; options.y = yMid - 80; options.vx = 3.2; options.vy = 0.0
particles.push(new Lampyridae.ForceParticle canvas, options) # Above
options.radius = 5.0; options.y = yMid + 100; options.vx = -2.8; options.vy = 0.0
options.colour = "#A82310"
particles.push(new Lampyridae.ForceParticle canvas, options) # Below
options.radius = 12; options.y = yMid + 280; options.vx = -1.7; options.vy = 0.0
options.colour = "#A82310"
particles.push(new Lampyridae.ForceParticle canvas, options) # Below

options.y = yMid # Right and left of centre

options.radius = 7.0; options.x = xMid + 120; options.vx = 0; options.vy = 2.6
options.colour = "rgb(30, 60, 100)"
particles.push(new Lampyridae.ForceParticle canvas, options) # right
options.radius = 10.0; options.x = xMid + 160; options.vx = 0; options.vy = -2.3
options.colour = "rgb(157, 85, 60)"
particles.push(new Lampyridae.ForceParticle canvas, options) # right

# ~ Star/Centre/Big object ~ #

options.radius = 40; options.x = xMid; options.y = yMid; options.vx = 0; options.vy = 0
options.mass = 800; options.colour = 0; options.stroke = 2; options.glow = 4
options.strokeColour = "rgb(255, 242, 204)"; options.glowColour = "rgb(255, 242, 204)"
particles.push(new Lampyridae.ForceParticle canvas, options)

# Add gravitational forces between each particle and the centre
total = particles.length
for i in [0..total - 2] then Lampyridae.Forces.gravity(particles, i, total - 1)

# An iterative update - remember to add it to the canvas!  
updateAll = () -> particles[j].update() for j in [0..total - 1]

###
# Lights, camera, action!
###
canvas.addUpdate canvas.draw.clear     # If you want the screen to clear between frames
canvas.addUpdate updateAll             # Update all every frame
canvas.animate()                       # Animate the canvas screen
