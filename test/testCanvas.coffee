# @file testCanvas.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

describe 'Creating a Canvas object without a premade <canvas>', ->

  before (done) ->
    canvas = new Lampyridae.Canvas 'world'
    done()
  
  it 'After creating the object, <canvas> should exist', ->
    should.exist $('#world')[0]
  it 'and it should be a child of the body', ->
    $('#world').parent()[0].should.equal document.body