# @file firefly.coffee
# @Copyright (c) 2017 Taylor Siviter
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

# You can change proto parameters!
# These represent the default values when the fireflies are instantiated
Lampyridae.Firefly::speed = [1, 5]

# Example settings
class Settings
  fireflies: []                        # For keeping track of the fireflies
  max_number: 200 
  Total: 20
  Bounds: Lampyridae.Firefly::bound
  Glow: Lampyridae.Firefly::glow
  Opacity: Lampyridae.Firefly::opacity

  # Value controllers
  changeAlpha: (value) -> updateProperty('alpha', value)
  changeBound: (value) ->
    settings.fireflies[i].changeBounds(value) for i in [0...settings.max_number]
  changeGlow: (value) -> updateProperty('glow', value)

settings = new Settings()

# Reusable firefly creator - remember to tweak the total if reused.
createFireflies = () ->
  for i in [0...settings.max_number]
    firefly = new Lampyridae.Firefly canvas
    settings.fireflies.push firefly

# Updating member properties using strings
updateProperty = (property, value) ->
  for i in [0...settings.max_number]
    settings.fireflies[i][property] = value

# Adding values to member properties using strings
addProperty = (property, value) ->
  for i in [0...settings.max_number]
    settings.fireflies[i][property] = settings.fireflies[i][property] + value

# An iterative update over the fireflies - remember to add it to the canvas!  
updateFireflies = () -> settings.fireflies[i].update() for i in [0...settings.Total]

###
# Lights, camera, action!
###

createFireflies()
canvas.addUpdate canvas.draw.clear     # If you want the screen to clear between frames
canvas.addUpdate updateFireflies       # Update all the fireflies every frame
canvas.animate()                       # Animate the canvas screen

###
# dat.gui
###

do addGuiControls = () ->
  gui = new dat.GUI
  fG = gui.addFolder 'General'
  fG.add(settings, 'Total').min(0).max(settings.max_number).step(1)
  fG.add(settings, 'Bounds', ['none', 'hard', 'periodic']).onChange(settings.changeBound)
  fG.open()
  fD = gui.addFolder 'Drawing Style'
  fD.add(settings, 'Glow').min(0).max(50).step(1).onChange(settings.changeGlow)
  fD.add(settings, 'Opacity').min(0).max(1).step(0.05).onChange(settings.changeAlpha)
