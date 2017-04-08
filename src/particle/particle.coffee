# @file particle.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'maths/vec2d'

class Lampyridae.Particle
  ### Construct and manage a generic circular particle.
  #
  # @param canvas [Object] Instance of Lampyridae.Canvas to attach the particle to
  #
  # @option x [Number] Position of the particle along the x-axis
  # @option y [Number] Position of the particle along the y-axis
  # @option vx [Number] Velocity of the particle along the x-axis
  # @option vy [Number] Velocity of the particle along the y-axis
  # @option radius [Number] Radius of the particle
  # @option bound [String] Type of bounding [none|hard|periodic]
  # @option alpha [Number] Opacity of the particle (requires enableAlpha)
  # @option glow [Number] Factor of the radius to emit a glow effect (requires enableGlow)
  # @option colour [String] Colour code to fill particle: e.g. "rgb(70, 70, 70)" or "0" = none
  # @option stroke [Number] Width of the stroke [default: 0]
  # @option strokeColour [String] Colour of the stroke [default: @colour]
  ###
  constructor: (@canvas, options) ->
    unless arguments.length > 0
      throw new Error "Particle requires a valid Canvas instance to be attached to"
    
    options ?= {}
    if toString.call(options) isnt '[object Object]'
      throw new Error "Particle requires a valid options object"
   
    # Mechanical properties #
    @pos = new Lampyridae.Vec2D options.x ? 0.0, options.y ? 0.0
    @vel = new Lampyridae.Vec2D options.vx ? 0.0, options.vy ? 0.0
    @acc = new Lampyridae.Vec2D 0, 0
    @r = options.radius ? 1.0
    @bounded = false
    @periodic = false
    @changeBounds(options.bound ? 'none')
    
    # Drawing properties #
    @glow = options.glow ? 0.0
    @alpha = options.alpha ? 1.0
    @colour = options.colour ? "rgb(255, 255, 255)"
    @stroke = options.stroke ? 0
    @strokeColour = options.strokeColour ? @colour
    @glowColour = options.glowColour ? @colour

    # Temporary calculation variables #
    @_v = new Lampyridae.Vec2D 0.0, 0.0
    
  ### Particle class prototype parameters.
  # Can be set by the user; e.g. Lampyridae.Particle::enableGlow = true, etc.
  ###
  enableAlpha: false
  enableGlow: false
  
  # Movement methods #
  
  ### Turn the particle's velocity!
  #
  # @param angle [Number] Number of radians to turn anticlockwise from the x-axis
  ###
  turn: (angle = 0.0) -> @vel.rotate(angle)

  # Detection and boundary methods #
  
  ### Is the particle outside the canvas in the x-axis? ###
  isOutsideCanvasX: () ->
    unless 0.0 + @r <= @pos.x <= @canvas.width() - @r then return true
    return false
  
  ### Is the particle outside the canvas in the y-axis? ###
  isOutsideCanvasY: () ->
    unless 0.0 + @r <= @pos.y <= @canvas.height() - @r then return true
    return false
  
  ### Is the particle outside the canvas window? ###
  isOutsideCanvas: () -> return @isOutsideCanvasX() or @isOutsideCanvasY()
  
  ### Act as if the boundary of the canvas is 'hard-walled'. ###
  applyHardBounds: () ->
    result = false
    if @isOutsideCanvasX() then @vel.normalLeft() ; @acc.normalLeft() ; result = true
    if @isOutsideCanvasY() then @vel.normalRight() ; @acc.normalRight() ; result = true
    return result

  ### Act as if the boundary of the canvas is 'periodic'. ###
  applyPeriodicBounds: () ->
    result = false
    if @isOutsideCanvasX() then @pos.x = -@pos.x + @canvas.width() ; result = true
    if @isOutsideCanvasY() then @pos.y = -@pos.y + @canvas.height() ; result = true
    return result
  
  ### Check and act if there are bounds applied. ###
  applyBounds: () ->
    if @periodic then return @applyPeriodicBounds()
    if @bounded then return @applyHardBounds()
    return false

  ### Change the current bounds of the particle. ###
  changeBounds: (b = 'none') ->
    switch b
      when "hard" then @bounded = true; @periodic = false
      when "periodic" then @bounded = false; @periodic = true
      when "none" then @bounded = false; @periodic = false
      else console.warn "Bound #{b} is not valid. Defaulting to 'none'"

  ### Move the particle using its velocity in the defined time step. ###
  move: () -> @pos.add @_v.copy(@vel).scale(Lampyridae.timestep)

  ### Simple particle update method. ###
  update: () ->
    @applyBounds()
    @move()
    @draw()
  
  ### Draw the particle to the screen.
  # Alpha and glow can be toggled by proto members
  # Fill and stroke can be toggled by instance members
  ###
  draw: () ->
    @canvas.draw.begin()
    if @enableAlpha then @canvas.draw.setGlobalAlpha @alpha
    if @enableGlow then @canvas.draw.glow @glow * @r, @glowColour
    @canvas.draw.circle @pos.x, @pos.y, @r
    unless @colour == 0 then @canvas.draw.fill @colour
    if @stroke > 0 then @canvas.draw.stroke @stroke, @strokeColour
    @canvas.draw.end()
# end class Lampyridae.Particle

module.exports = Lampyridae.Particle
