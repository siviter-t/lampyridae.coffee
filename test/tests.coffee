describe 'Lampyridae Tests', ->
  it 'A DOM should exist', ->
    expect(document).to.not.equal null
    return
  
  it 'and it should have a body tag', ->
    expect(document.body).to.not.equal null
    return

$(document).ready ->
  describe 'Canvas Tests', ->
    
    existingCanvas = $('#world')
    
    it 'A premade canvas tag should already exist', ->
      expect(existingCanvas).to.not.equal null
      return
    
    it 'and it should be a child of the body', ->
      expect(existingCanvas.parent()[0]).to.equal document.body
      return