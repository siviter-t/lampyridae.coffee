# @file hypocycloid.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

###
# Example usage of lampyridae.coffee
###

require 'particle/paraparticle'
require 'util/colour/rgbToHsl'
require 'util/colour/hslToRgb'
require 'util/colour/decssify'
require 'util/colour/cssify'
 
# By default, if there is no existing canvas with the id 'world', this will
# attach '<canvas id="world"></canvas>' under the body element.
canvas = new Lampyridae.Canvas 'world'

# Settings control
class Settings
  # General
  particles: []
  max_number: 2 
  max_radius: () => Math.floor canvas.height() / 2
  Total: 2
  Curve: 3 # The hypocycloid parameter n
  Rate: 0.01
  Radius: 200
  
  # Drawing
  ParticleColour: "rgb(200, 200, 255)"
  CircleColour: "rgb(200, 200, 255)"
  CycleColour: false
  CycleRate: 1
  Alpha: 0.7
  Glow: 0
  DrawCircle: true

  # Interactions
  ClearScreen: () => canvas.draw.clear()
  SaveAsPNG: () => download canvas.getUriPNG(), 'hypocycloid-image-ts.png', 'image/png'

  # Controllers
  resetHypop: () =>
    @particles[1].setVar 0
    @particles[1].setPos new Lampyridae.Vec2D canvas.width() / 2,
                                              canvas.height() / 2 - @Radius
  changeCurve: () => @resetHypop
  changeRate: (value) => @particles[1].setRate value

  changeRadii: (value) =>
    @particles[0].r = value
    @resetHypop()
 
  changeParticleColour: (value) => @particles[1].colour = value
  changeCircleColour: (value) => @particles[0].strokeColour = value
  changeAlpha: (value) => @particles[1].alpha = value
  changeGlow: (value) => @particles[1].glow = value

###
# Initial setup
###

settings = new Settings()
settings.Radius = Math.floor 3 * settings.max_radius() / 4

# Background circle
circle = new Lampyridae.Particle canvas, {
  x: canvas.width() / 2, y: canvas.height() / 2, radius: settings.Radius,
  colour: 0, stroke: 1, strokeColour: settings.CircleColour }
settings.particles.push circle 

# Particle following the hypocycloidal path
hypox = (t, a, n) => return a * ( (n - 1)*Math.cos(t) - Math.cos(t * (n - 1)) ) / n
hypoy = (t, a, n) => return a * ( (n - 1)*Math.sin(t) + Math.sin(t * (n - 1)) ) / n + a
hypoeqs = new Lampyridae.Para2D(hypox, hypoy) 
particle = new Lampyridae.Paraparticle canvas, {
  x: canvas.width() / 2, y: canvas.height() / 2 - settings.Radius, radius: 1,
  psys: hypoeqs, colour: settings.ParticleColour, alpha: settings.Alpha }
settings.particles.push particle

# Update schedule
ctc = true      # Autocolour cycle 1st time counter
pcc = undefined ; hslp = [0, 0, 0] # For auto colour change / any rate
ccc = undefined ; hslc = [0, 0, 0] # ^ But for circle 
update = () ->
  if settings.DrawCircle then settings.particles[0].update() 
  if settings.CycleColour
    if ctc
      hslp = Lampyridae.rgbToHsl Lampyridae.decssify(settings.ParticleColour)
      hslc = Lampyridae.rgbToHsl Lampyridae.decssify(settings.CircleColour)
      ctc = false 
    hslp[0] = (hslp[0] + settings.CycleRate) % 360
    hslc[0] = (hslc[0] + settings.CycleRate) % 360
    settings.ParticleColour = Lampyridae.cssify 'rgb', Lampyridae.hslToRgb(hslp)
    settings.CircleColour = Lampyridae.cssify 'rgb', Lampyridae.hslToRgb(hslc)
    settings.changeParticleColour(settings.ParticleColour)
    settings.changeCircleColour(settings.CircleColour)
    pcc.updateDisplay() ; ccc.updateDisplay() 
  else ctc = true
  settings.particles[1].update settings.Radius, settings.Curve

###
# Lights, camera, action!
###

canvas.addUpdate update                       # Update particles every frame
canvas.animate()                              # Animate the canvas screen

###
# dat.gui
###

# Default presets
presets = 
  'preset': 'Deltoid'
  'remembered':
    'Tusi Couple': '0':
      'Curve': 2, 'Rate': 0.01, 'Radius': 360
      'ParticleColour': 'rgb(200, 200, 255)', 'CircleColour': 'rgb(200, 200, 255)'
      'CycleColour': false, 'CycleRate': 1, 'Alpha': 0.6, 'Glow': 0, 'DrawCircle': true
    'Deltoid': '0':
      'Curve': 3, 'Rate': 0.01, 'Radius': 360
      'ParticleColour': 'rgb(200, 200, 255)', 'CircleColour': 'rgb(200, 200, 255)'
      'CycleColour': false, 'CycleRate': 1, 'Alpha': 0.6, 'Glow': 0, 'DrawCircle': true
    'Astroid': '0':
      'Curve': 4, 'Rate': 0.01, 'Radius': 360
      'ParticleColour': 'rgb(200, 200, 255)', 'CircleColour': 'rgb(200, 200, 255)'
      'CycleColour': false, 'CycleRate': 1, 'Alpha': 0.6, 'Glow': 0, 'DrawCircle': true
    'Pi': '0':
      'Curve': 3.14159265359, 'Rate': 0.01, 'Radius': 360
      'ParticleColour': 'rgb(255,0,0)', 'CircleColour': 'rgb(255,0,0)'
      'CycleColour': true, 'CycleRate': 3.14, 'Alpha': 0.4, 'Glow': 1, 'DrawCircle': true
    'Euler\'s number': '0':
      'Curve': 2.71828182846, 'Rate': 0.04, 'Radius': 360
      'ParticleColour': 'rgb(198,218,164)', 'CircleColour': 'rgb(198,218,164)'
      'CycleColour': true, 'CycleRate': 2.72, 'Alpha': 0.4, 'Glow': 1, 'DrawCircle': true
    'Heart': '0':
      'Curve': 0.5, 'Rate': 0.02, 'Radius': 120
      'ParticleColour': 'rgb(255,40,100)', 'CircleColour': 'rgb(255, 40, 100)'
      'CycleColour': false, 'CycleRate': 1, 'Alpha': 0.8, 'Glow': 0, 'DrawCircle': false
    '3-Leaf Clover': '0':
      'Curve': 0.75, 'Rate': 0.02, 'Radius': 200
      'ParticleColour': 'rgb(10, 250, 5)', 'CircleColour': 'rgb(10, 250, 5)'
      'CycleColour': false, 'CycleRate': 1, 'Alpha': 0.8, 'Glow': 0, 'DrawCircle': false
  'closed': false
  'folders':
    'General':
      'preset': 'Default', 'closed': false, 'folders': {}
    'Drawing Style':
      'preset': 'Default', 'closed': true, 'folders': {}

do addGuiControls = () ->
  gui = new dat.GUI { load: presets, preset: 'Deltoid' }
  gui.remember settings
  fG = gui.addFolder 'General'
  fG.add(settings, 'Curve').step(0.01)
  fG.add(settings, 'Rate').min(0).max(3).step(0.001).onChange(settings.changeRate)
  fG.add(settings, 'Radius').min(10).max(settings.max_radius()).onChange(settings.changeRadii)
  fG.open()
  fD = gui.addFolder 'Drawing Style'
  pcc = fD.addColor(settings, 'ParticleColour').onChange(settings.changeParticleColour)
  ccc = fD.addColor(settings, 'CircleColour').onChange(settings.changeCircleColour)
  fD.add(settings, 'CycleColour')
  fD.add(settings, 'CycleRate').min(0.1).max(7).step(0.01)
  fD.add(settings, 'Alpha').min(0).max(1).step(0.01).onChange(settings.changeAlpha)
  fD.add(settings, 'Glow').min(0).max(15).step(1).onChange(settings.changeGlow)
  fD.add(settings, 'DrawCircle')
  gui.add(settings, 'ClearScreen')
  gui.add(settings, 'SaveAsPNG')
