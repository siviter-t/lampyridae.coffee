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
  constructor: (@id, @parent = 'body') ->
    if arguments.length < 1
      throw new Error "Lampyridae: Canvas requires an \#id selector"
    
    @findOrMakeCanvas()
    @context = @element.getContext '2d'
    @resizeToParent()
    $(window).resize => @resizeToParent()
    @draw = new Lampyridae.Draw @
  
  findOrMakeCanvas: (id = @id, parent = @parent) ->
    @element = document.getElementById id
    if @element? then @parent = @element.parentElement
    else
      @element = document.createElement 'canvas'
      if parent == 'body' then @parent = document.body
      else @parent = document.getElementById parent
      @setId()
      @append()
    
  append: () ->
    @parent.appendChild @element
    console.log "Lampyridae: Appended \##{@id} to
                 #{@parent.nodeName.toLowerCase()}\##{@parent.id}"
  
  id: () -> return @id
  width: () -> return $(@element).width()
  height: () -> return $(@element).height()
  area: () -> return $(@element).width() * $(@element).height() 
  
  setId: (id = @id) -> @id = id; @element.id = id; return id
  
  setWidth: (width = $(@parent).innerWidth() ) -> 
    $(@element).width(width).attr('width', width)
    return width
    
  setHeight: (height = $(@parent).innerHeight() ) ->
    $(@element).height(height).attr('height', height)
    return height
    
  resizeToParent: () ->
    @setWidth()
    @setHeight()
  
  # Helper methods
  has2DContext: () ->
    if @context? then return @context.constructor == CanvasRenderingContext2D
    else return false
  
# end class Lampyridae.Canvas

module.exports = Lampyridae.Canvas