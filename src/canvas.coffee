# @file canvas.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

class Lampyridae.Canvas
   ### Construct and manage a canvas element.
   #
   # @param id [String] Name of the #id selector for the canvas element
   # @param parent [String] Name of the element to attach the canvas to (defaults to body)
   # @todo Add options + add selection of an exisiting canvas
   ###
   constructor: (@id, @parent = 'body') ->
      if arguments.length < 1
         throw new Error "Lampyridae: Canvas requires an \#id selector"
      
      @element = document.createElement 'canvas'
      @context = @element.getContext '2d'
      @setID()
      @append()
      @resizeToParent()
      $(window).resize => @resizeToParent()
      @draw = new Draw @
      
   width: () -> return $(@element).width()
   height: () -> return $(@element).height()
   area: () -> return $(@element).width() * $(@element).height() 
   
   setWidth: (width = $(@parent).innerWidth() ) -> 
      $(@element).width(width).attr('width', width)
      return width
      
   setHeight: (height = $(@parent).innerHeight() ) ->
      $(@element).height(height).attr('height', height)
      return height
      
   setID: (@id = @id) -> $(@element).attr('id', @id); return @id
      
   append: (@parent = @parent) ->
      $(@parent).append @element
      console.log "Lampyridae: Appended \##{@id} to #{@parent}"
   
   resizeToParent: () ->
      @setWidth()
      @setHeight()
# end class Lampyridae.Canvas