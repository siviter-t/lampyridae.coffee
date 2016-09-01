# @file canvas.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

class Lampyridae.Canvas
  ### Construct and manage a canvas element.
  #
  # @param id [String] Name of the #id selector for the canvas element
  # @param parent [String] Name of the element to attach the canvas to (defaults to body)
  ###
  constructor: (id, @parent = 'body') ->
    if arguments.length < 1
      throw new Error "Lampyridae: Canvas requires an \#id selector"
    
    @findOrMakeCanvas(id)
    @context = @element.getContext '2d'
    @size()
    window.addEventListener 'resize', => @size()
    @draw = new Lampyridae.Draw @
  
  findOrMakeCanvas: (id, parent = @parent) ->
    @element = document.getElementById id
    if @element? then @parent = @element.parentElement
    else
      @element = document.createElement 'canvas'
      if parent == 'body' then @parent = document.body
      else @parent = document.getElementById parent
      @id id
      @append()
    
  append: () ->
    @parent.appendChild @element
    console.log "Lampyridae: Appended \##{@element.id} to
                 #{@parent.nodeName.toLowerCase()}\##{@parent.id}"
  
  # Access/Set/Get methods # 
  
  ### Return or set the id selector of the canvas
  #
  # @param id [String] The id string to set (optional; if needed)
  # @return [String] The current id selector of the canvas
  ###
  id: (id) ->
    if id? then @element.id = id
    return @element.id
  
  ### Return or set the width of the canvas
  #
  # @param width [Number] The width to set (optional; if needed)
  # @return [Number] The current width of the canvas
  ###
  width: (width) -> 
    if width? then @element.setAttribute 'width', width
    return @element.clientWidth
  
  ### Return or set the height of the canvas
  #
  # @param height [Number] The width to set (optional; if needed)
  # @return [Number] The current height of the canvas
  ###
  height: (height) ->
    if height? then @element.setAttribute 'height', height
    return @element.clientHeight
  
  ### Set the overall size of the canvas. Defaults to its parent size
  #
  # @param width [Number] The width to set (optional)
  # @param height [Number] The width to set (optional)
  ###
  size: (width = @parent.clientWidth, height = @parent.clientHeight) ->
    @width width; @height height
  
  ### Returns the current area of the canvas
  #
  # @return [Number] The current area of the canvas
  ###
  area: () -> return @width() * @height()
  
  # Helper Methods #
  
  has2DContext: () ->
    if @context? then return @context.constructor == CanvasRenderingContext2D
    else return false
# end class Lampyridae.Canvas

module.exports = Lampyridae.Canvas