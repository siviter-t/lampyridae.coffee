# @file testCanvas.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

describe 'Canvas object unit test', ->
  describe 'Creating a Canvas using a premade <canvas> (default appending on <body>)', ->
    canvas = null
    
    before (done) ->
      createElementById('preworld', 'canvas')
      canvas = new Lampyridae.Canvas 'preworld'
      done()

    after (done) -> removeElementById 'preworld'; done()
    
    it 'After creating the object, <canvas> should still exist', ->
      should.exist document.getElementById('preworld')
    
    it 'and it should be a child of the body', ->
      document.getElementById('preworld').parentElement.should.equal document.body
    
    it 'The Canvas object should be attached to the <canvas> tag', ->
      canvas.element.should.equal document.getElementById('preworld')
    
    it 'and should have a drawable 2d context', -> canvas.has2DContext().should.equal true
  
  describe 'Creating a Canvas without a premade <canvas> (default appending on <body>)', ->
    canvas = null
    
    before (done) ->
      canvas = new Lampyridae.Canvas 'world'
      done()
    
    after (done) -> removeElementById 'world'; done()
    
    it 'After creating the object, <canvas> should exist', ->
      should.exist document.getElementById('world')
      
    it 'and it should be a child of the body', ->
      document.getElementById('world').parentElement.should.equal document.body
    
    it 'The Canvas object should be attached to the <canvas> tag', ->
      canvas.element.should.equal document.getElementById('world')
    
    it 'and should have a drawable 2d context', -> canvas.has2DContext().should.equal true
    
  describe 'Appending Canvas to an arbitrary element', ->
    canvas = null; parent = null
    
    before (done) ->
      parent = createElementById('parent')
      canvas = new Lampyridae.Canvas 'world', 'parent'
      done()
    
    after (done) -> removeElementById 'parent'; done()
    
    it 'First, the parent <div> should exist', ->
      should.exist document.getElementById('parent')
    
    it 'After creating the object, <canvas> should also exist', ->
      should.exist document.getElementById('world')
    
    it 'and it should be a child of the parent <div>', ->
      document.getElementById('world').parentElement.should.equal parent
    
    it 'The Canvas object should be attached to the <canvas> tag', ->
      canvas.element.should.equal document.getElementById('world')
    
    it 'and should have a drawable 2d context', -> canvas.has2DContext().should.equal true
    
    it '<canvas> should have its parent\'s width', ->
      canvas.width().should.equal canvas.parent.clientWidth
    
    it '<canvas> should have its parent\'s height', ->
      canvas.height().should.equal canvas.parent.clientHeight