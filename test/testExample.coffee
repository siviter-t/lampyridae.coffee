# @file testAll.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'particle/bug'

describe 'Testing an example', ->
  canvas = null
  
  before (done) ->
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
    done()
  
  it 'A <canvas> tag should exist', ->
    should.exist document.getElementById('world')
    
  it 'A Canvas object should be attached to the <canvas> tag', ->
    canvas.element.should.equal document.getElementById('world')
  
  it 'and should have a drawable 2d context', -> canvas.has2DContext().should.equal true