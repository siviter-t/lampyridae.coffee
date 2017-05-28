# @file canvas.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'core/draw'

class Lampyridae.Canvas
  ### Construct and manage a Canvas object.
  #
  # @param id [String] Name of the #id selector for the canvas element
  # @param parent [String] Name of the element to attach the canvas to (defaults to body)
  ###
  constructor: (id, @parent = 'body') ->
    if arguments.length < 1
      throw new Error "Canvas requires an \#id selector"
    
    # Control variables
    @_updateStack = [] # Stores a stack of functions to call every update
    @_stopAnim = false
    @_pauseAnim = false
    
    @findOrMakeCanvas(id)
    @context = @element.getContext '2d'
    @size()
    window.addEventListener 'resize', => @size()
    @draw = new Lampyridae.Draw @
  
  ### Checks whether the given id selector exists; creating or registering accordingly.
  # If it does, it registers the current parent element for this object.
  # If it does not, it creates one under the given parent element.
  #
  # @param id [String] Name of the #id selector for the canvas element
  # @param parent [String] Name of the element to attach the canvas to (defaults to body)
  ###
  findOrMakeCanvas: (id, parent = @parent) ->
    @element = document.getElementById id
    if @element? then @parent = @element.parentElement
    else
      @element = document.createElement 'canvas'
      if parent == 'body' then @parent = document.body
      else @parent = document.getElementById parent
      @id id
      @appendCanvas()
  
  ### Appends a generated <canvas> tag to the DOM - if required. ###
  appendCanvas: () ->
    @parent.appendChild @element
    Lampyridae.Log.out "Appended \##{@element.id} to
                       #{@parent.nodeName.toLowerCase()}\##{@parent.id}"
  
  # Access/Set/Get methods # 
  
  ### Return or set the id selector of the canvas.
  #
  # @param id [String] The id string to set (optional; if needed)
  # @return [String] The current id selector of the canvas
  ###
  id: (id) ->
    if id? then @element.id = id
    return @element.id
  
  ### Return or set the width of the canvas.
  #
  # @param width [Number] The width to set (optional; if needed)
  # @return [Number] The current width of the canvas
  ###
  width: (width) -> 
    if width? then @element.setAttribute 'width', width
    return @element.clientWidth
  
  ### Return or set the height of the canvas.
  #
  # @param height [Number] The width to set (optional; if needed)
  # @return [Number] The current height of the canvas
  ###
  height: (height) ->
    if height? then @element.setAttribute 'height', height
    return @element.clientHeight
  
  ### Set the overall size of the canvas.
  # Defaults to its current parent element's size.
  #
  # @param width [Number] The width to set (optional)
  # @param height [Number] The width to set (optional)
  ###
  size: (width = @parent.clientWidth, height = @parent.clientHeight) ->
    @width width; @height height
  
  ### Returns the current area of the canvas.
  #
  # @return [Number] The current area of the canvas
  ###
  area: () -> return @width() * @height()
  
  # Animation and update methods #
  
  ### Adds a function to the update stack.
  #
  # @f [Function] Function to call on Canvas.update
  ###
  addUpdate: (f) =>
    if toString.call(f) isnt '[object Function]'
      throw new Error "Canvas.addUpdate requires a function"
    @_updateStack.push f
  
  ### Removes the top function from the update stack.
  #
  # @return [Bool] True if the top function has been removed; false if there's nothing left
  ###
  popUpdate: () =>
    if @_updateStack.length > 0
      @_updateStack.pop()
      return true
    return false
  
  ### Removes the first instance of the function from the top of the update stack.
  # 
  # @f [Function] Function to stop calling on Canvas.update
  # @return [Bool] True if it has been found and removed; false otherwise
  # @note Iterates backwards through the update stack!
  ###
  removeUpdate: (f) =>
    if toString.call(f) isnt '[object Function]'
      throw new Error "Canvas.addUpdate requires a function"
    for i in [@_updateStack.length - 1..0] by -1
      if @_updateStack[i] == f
        @_updateStack.splice(i, 1)
        return true
    return false
    
  ### Iterates through the update stack and calls the update functions. ###
  update: () => i() for i in @_updateStack
  
  ### Animates the canvas!
  # Uses the functions in the update stack to add magic to the canvas.
  #
  # @note is controlled by the pause and stopAnimation()
  ###
  animate: () =>
    unless @_stopAnim
      unless @_pauseAnim then @update()
      requestAnimationFrame @animate
    else
      @_stopAnim = false; @_pauseAnim = false
  
  ### Toggles the paused state of the canvas animation. ###
  pause: () => @_pauseAnim = !@_pauseAnim
  
  ### Stops the animation outright. ### 
  stop: () => @_stopAnim = true
 
  ### Get PNG data URI for this canvas. ###
  getUriPNG: () => @element.toDataURL 'image/png'

  # Helper Methods #
  
  ### Schedule a functon to call after a specified time
  #
  # @param time [Number] Time to wait in milliseconds
  # @param f [Function] Function to call after time has expired
  ###
  schedule: (time, f) -> setTimeout f, time
  
  ### Has the Canvas object acquired the 2d context (CanvasRenderingContext2D) api?
  #
  # @return [Bool] True if it does, false if it does not
  ###
  has2DContext: () ->
    if @context? then return @context.constructor == CanvasRenderingContext2D
    else return false
# end class Lampyridae.Canvas

module.exports = Lampyridae.Canvas
