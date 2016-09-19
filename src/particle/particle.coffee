# @file particle.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

class Lampyridae.Particle
  ### Construct and manage a generic circular particle.
  #
  # @param canvas [Object] Instance of Lampyridae.Canvas to attach the particle to
  #
  # @option x [Number] Position of the particle along the x-axis
  # @option y [Number] Position of the particle along the y-axis
  # @option theta [Number] Direction of the particle (radians anticlockwise from the x-axis)
  # @option speed [Number] Speed of the particle
  # @option radius [Number] Radius of the particle
  # @option alpha [Number] Opacity of the particle 
  # @option bound [String] Type of bounding [none|hard|periodic]
  # @option colour [String] Colour code of the particle - e.g. "rgb(255, 255, 255)"
  ###
  constructor: (@canvas, options) ->
    unless arguments.length > 0
      throw new Error "Lampyridae: Particle requires a valid Canvas instance to be attached to"
    
    options ?= {}
    if toString.call(options) isnt '[object Object]'
      throw new Error "Lampyridae: Particle requires a valid object of options"
    
    @x = options.x ? 0.0
    @y = options.y ? 0.0
    @t = options.theta ? 0.0
    @v = options.speed ? 0.0
    @r = options.radius ? 1.0
    @colour = options.colour ? "rgb(255, 255, 255)"
    @alpha = options.alpha ? 1.0
    @bounded = false
    @periodic = false
    if options.bound?
      switch options.bound
        when "hard" then @bounded = true
        when "periodic" then @bounded = true; @periodic = true
        when "none"
        else console.warn "Lampyridae: #{options.bound} is not valid bound. Defaulting to 'none'"
  
  ### Particle class prototype parameters.
  # Can be set by the user; e.g. Lampyridae.Particle::enableGlow = true, etc.
  ###
  enableAlpha: false
  enableGlow: false
  glowFactor: 4.0
  
  # Movement methods #
  
  ### Velocity component in the x-direction. ###
  vx: () -> return @v * Math.cos(@t)

  ### Velocity component in the y-direction. ###
  vy: () -> return @v * Math.sin(@t)
  
  ### Turn the particle.
  #
  # @param angle [Number] Number of radians to turn anticlockwise from the x-axis
  ###
  turn: (angle = 0.0) -> @t += angle
  
  ### Turn the particle around. ###
  turnAround: () -> @turn Math.PI
  
  ### Move the particle using its velocity and this applications defined time step. ###
  move: () ->
    @x += Lampyridae.timestep * @vx()
    @y += Lampyridae.timestep * @vy()
  
  # Detection and boundary methods #
  
  ### Is the particle outside the canvas in the x-axis?
  #
  # @return [Bool] True if it outside; false otherwise
  ###
  isOutsideCanvasX: () ->
    unless 0.0 <= @x <= @canvas.width() then return true
    return false
  
  ### Is the particle outside the canvas in the y-axis?
  #
  # @return [Bool] True if it outside; false otherwise
  ###
  isOutsideCanvasY: () ->
    unless 0.0 <= @y <= @canvas.height() then return true
    return false
  
  ### Is the particle outside the canvas window?
  #
  # @return [Bool] True if it outside; false otherwise
  ###
  isOutsideCanvas: () -> return @isOutsideCanvasX() or @isOutsideCanvasY()
  
  ### Act as if the boundary of the canvas is 'hard-walled'.
  #
  # @return [Bool] True if action has been made; false otherwise
  ###
  applyHardBounds: () ->
    if @isOutsideCanvas()
      @turnAround()
      @move until @isOutsideCanvas()
      return true
    return false

  ### Act as if the boundary of the canvas is 'periodic'.
  #
  # @return [Bool] True if action has been made; false otherwise
  ###
  applyPeriodicBounds: () ->
    result = false
    if @isOutsideCanvasX()
      @x = -@x + @canvas.width()
      result = true
    if @isOutsideCanvasY()
      @y = -@y + @canvas.height()
      result = true
    return result
  
  ### Check and act if there are bounds applied.
  #
  # @return [Bool] True if action has been made; false otherwise
  ###
  applyBounds: () ->
    if @periodic then return @applyPeriodicBounds()
    if @bounded then return @applyHardBounds()
    return false
  
  ### Simple particle update method. ###
  update: () ->
    @applyBounds()
    @move()
    @draw()
  
  ### Draw the particle to the screen. ###
  draw: () ->
    @canvas.draw.begin()
    if @enableAlpha then @canvas.draw.setGlobalAlpha @alpha
    if @enableGlow then @canvas.draw.glow @glowFactor * @r, @colour
    @canvas.draw.circle @x, @y, @r
    @canvas.draw.fill @colour
    @canvas.draw.end()
# end class Lampyridae.Particle

module.exports = Lampyridae.Particle