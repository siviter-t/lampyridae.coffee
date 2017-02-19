# @file forceParticle.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'maths/forces'

class Lampyridae.ForceParticle extends Lampyridae.Particle
  ### Construct and manage a Lampyridae particle that can experience force.
  #
  # @param canvas [Object] Instance of Lampyridae.Canvas to attach to
  #
  # Options inherited from Lampyridae.Particle with the additional:
  #
  # @option ax [Number] Acceleration of the particle along the x-axis
  # @option ay [Number] Acceleration of the particle along the y-axis
  # @option mass [Number] Acceleration of the particle along the y-axis
  # @option bound [String] Type of bounding [none|hard|periodic]
  ###
  constructor: (canvas, options) ->
    options ?= {}
    super(canvas, options)
    
    # New properties #
    @acc = new Lampyridae.Vec2D options.ax ? 0.0, options.ay ? 0.0
    @mass = options.mass ? @r
    @F = new Lampyridae.Vec2D 0.0, 0.0     # Net force
    @_forceStack = []                      # Stack of forces to apply

    # Temporary calculation variables #
    @_a = new Lampyridae.Vec2D 0.0, 0.0
    @_F = new Lampyridae.Vec2D 0.0, 0.0
 
  ### Adds a function to the force stack.
  #
  # @f [Function] Function to call for force calculation
  ###
  addForce: (f) =>
    if toString.call(f) isnt '[object Function]'
      throw new Error "ForceParticle.addForce requires a function"
    @_forceStack.push f

  ### Removes the top function from the force stack.
  #
  # @return [Bool] True if the top function has been removed; false if there's nothing left
  ###
  popForce: () =>
    if @_forceStack.length > 0
      @_forceStack.pop()
      return true
    return false

  ### Removes the first instance of the function from the top of the force stack.
  # 
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
    
  ### Iterates through the force stack and calculates the applied force. ###
  calcForce: () => @F.add i() for i in @_forceStack ; return @F
  
  ### Move the particle using its velocity and acceleration in the defined time step. ###
  move: () ->
    @acc.add @_F.copy(@calcForce()).scale(Lampyridae.timestep).ascale(@mass)
    @vel.add @_a.copy(@acc).scale(Lampyridae.timestep)
    @pos.add @_v.copy(@vel).scale(Lampyridae.timestep)
    # Reset force and acceleration
    @acc.scale(0) ; @F.scale(0)
# end class Lampyridae.ForceParticle

module.exports = Lampyridae.ForceParticle
