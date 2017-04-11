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
  # @option ax [Number] Acceleration of the particle along the x-axis
  # @option ay [Number] Acceleration of the particle along the y-axis
  # @option mass [Number] Acceleration of the particle along the y-axis
  # @option radius [Number] Radius of the particle
  # @option bound [String] Type of bounding [none|hard|periodic]
  # @option alpha [Number] Opacity of the particle
  # @option glow [Number] Factor of the radius to emit a glow effect
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
   
    # General properties # 
    @r = options.radius ? 1.0
    @bounded = false ; @periodic = false
    @changeBounds(options.bound ? 'none')

    # Mechanical properties #
    @pos = new Lampyridae.Vec2D options.x ? 0.0, options.y ? 0.0
    @vel = new Lampyridae.Vec2D options.vx ? 0.0, options.vy ? 0.0
    @acc = new Lampyridae.Vec2D options.ax ? 0.0, options.ay ? 0.0
    @mass = options.mass ? @r
    @F = new Lampyridae.Vec2D 0.0, 0.0     # Net force
    @_forceStack = []                      # Stack of forces to apply
    
    # Drawing properties #
    @glow = options.glow ? 0.0
    @alpha = options.alpha ? 1.0
    @colour = options.colour ? "rgb(255, 255, 255)"
    @stroke = options.stroke ? 0
    @strokeColour = options.strokeColour ? @colour
    @glowColour = options.glowColour ? @colour

    # Temporary calculation variables #
    @_v = new Lampyridae.Vec2D 0.0, 0.0
    @_a = new Lampyridae.Vec2D 0.0, 0.0
    @_F = new Lampyridae.Vec2D 0.0, 0.0
  
  # Detection and boundary methods #
  
  ### Check and act if there are bounds applied. ###
  applyBounds: () ->
    if @periodic then return @applyPeriodicBounds()
    if @bounded then return @applyHardBounds()
    return false

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

  ### Change the current bounds of the particle. ###
  changeBounds: (b = 'none') ->
    switch b
      when "hard" then @bounded = true ; @periodic = false
      when "periodic" then @bounded = false ; @periodic = true
      when "none" then @bounded = false ; @periodic = false
      else console.warn "Bound #{b} is not valid. Defaulting to 'none'"

  # Mechanical methods #
  
  ### Adds a function to the force stack.
  # @f [Function] Function to call for force calculation
  ###
  addForce: (f) =>
    if toString.call(f) isnt '[object Function]'
      throw new Error "Particle.addForce requires a function as an argument"
    @_forceStack.push f

  ### Iterates through the force stack and calculates the applied force. ###
  calcForce: () => @F.add i() for i in @_forceStack ; return @F

  ### Move the particle -- with force sensitivity -- in the defined time step. ###
  move: () ->
    @acc.add @_F.copy(@calcForce()).scale(Lampyridae.timestep).ascale(@mass)
    @vel.add @_a.copy(@acc).scale(Lampyridae.timestep)
    @pos.add @_v.copy(@vel).scale(Lampyridae.timestep)
    @acc.scale(0) ; @F.scale(0)            # Reset force and acceleration
  
  ### Move the particle using just its velocity in the defined time step. ###
  move_noa: () -> @pos.add @_v.copy(@vel).scale(Lampyridae.timestep)

  ### Removes the top function from the force stack.
  # @return [Bool] True if the top function has been removed; false if there's nothing left
  ###
  popForce: () =>
    if @_forceStack.length > 0
      @_forceStack.pop()
      return true
    return false
 
  ### Removes the first instance of the function from the top of the force stack.
  # @f [Function] Function to stop calling on force updates
  # @return [Bool] True if it has been found and removed; false otherwise
  # @note Iterates backwards through the stack!
  ###
  removeForce: (f) =>
    if toString.call(f) isnt '[object Function]'
      throw new Error "ForceParticle.removeForce requires a function"
    for i in [@_forceStack.length - 1..0] by -1
      if @_forceStack[i] == f
        @_forceStack.splice(i, 1)
        return true
    return false

  ### Turn the particle's velocity!
  # @param angle [Number] Number of radians to turn anticlockwise from the x-axis
  ###
  turn: (angle = 0.0) -> @vel.rotate(angle)

  ### Rudimentary particle update method.
  # Will move the particle using its mechanical properties; selecting between
  # @move [force sensitive] and @move_noa [force insensitive]
  # Overload this method in descendant classes to impose new movement
  # behaviour.
  ###
  update: () ->
    @applyBounds()
    if @_forceStack.length > 0 then @move()
    else @move_noa()
    @draw()
 
  # Drawing methods #
  
  ### Draw the particle to the screen.
  # Most properties can be toggled when instance members reach certain thresholds.
  # For example, the glow effect is enabled when glow
  ###
  draw: () ->
    @canvas.draw.begin()
    @draw_alpha() ; @draw_glow()
    @draw_particle() ; @draw_fill() ; @draw_stroke()
    @canvas.draw.end()

  draw_alpha: () -> if @alpha < 1.0 then @canvas.draw.setGlobalAlpha @alpha
  draw_glow: () -> if @glow > 0.0 then @canvas.draw.glow @glow * @r, @glowColour
  draw_fill: () -> unless @colour == 0 then @canvas.draw.fill @colour
  draw_particle: () -> @canvas.draw.circle @pos.x, @pos.y, @r
  draw_stroke: () -> if @stroke > 0 then @canvas.draw.stroke @stroke, @strokeColour
# end class Lampyridae.Particle

module.exports = Lampyridae.Particle
