# @file testAll.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'particle/firefly'

describe 'Testing an example', ->
  canvas = null
  
  before (done) ->
    canvas = new Lampyridae.Canvas 'world'
    
    Lampyridae.Firefly::speedMax = 10
    # Lampyridae.Firefly::enableGlow = true
    # Lampyridae.Firefly::glowFactor = 10
    
    numOfBugs = 5
    bugs = []
    
    createBugs = () ->
      for i in [0...numOfBugs]
         bug = new Lampyridae.Firefly canvas, {bound: "periodic"}
         bugs.push bug
      return
      
    update = () ->
      bugs[i].update() for i in [0...numOfBugs]
      return
    
    time = 10000
    randBlendOn = true
    randBlend = () =>
      idx = Math.round(Lampyridae.rand(0, (Lampyridae.Draw::blendTypes.length) - 1))
      t = Lampyridae.Draw::blendTypes[idx]
      canvas.draw.setGlobalBlending t
      # Lampyridae.Log.out "Blending = #{t}"
      if randBlendOn then canvas.schedule time, -> randBlend()
    
    createBugs()
    canvas.addUpdate canvas.draw.clear
    canvas.addUpdate update
    canvas.animate()
    # canvas.schedule 5000, -> canvas.pause()
    # canvas.schedule 6000, -> Lampyridae.Firefly::opacity = 0.01
    # canvas.schedule 6000, -> Lampyridae.Firefly::hueMin = 240
    # canvas.schedule 6000, -> Lampyridae.Firefly::hueMax = 360
    # canvas.schedule 6000, -> Lampyridae.Firefly::radiusMax = 50
    # canvas.schedule 6500, -> createBugs()
    # canvas.schedule 6500, -> numOfBugs = 50
    # canvas.schedule 7000, -> canvas.pause()
    # canvas.schedule 8000, => randBlend()
    # canvas.schedule 8000, -> canvas.draw.setGlobalBlending "destination-out"
    # canvas.schedule 10000, -> canvas.removeUpdate canvas.draw.clear
    done()
  
  it 'A <canvas> tag should exist', -> should.exist document.getElementById('world')
  
  it 'A Canvas object should be attached to the <canvas> tag', ->
    canvas.element.should.equal document.getElementById('world')
  
  it 'and should have a drawable 2d context', -> canvas.has2DContext().should.equal true
