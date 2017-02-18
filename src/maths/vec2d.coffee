# @file vec2d.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'lampyridae'

class Lampyridae.Vec2D
  ### Construct a two-dimensional vector for the Lampyridae framework.
  # Lampyridae vectors are self-referencing and thus their methods can be compounded as
  # desired: e.g. vector.add(23, 2).unit().scale(2)
  # Basic operations can either take other instances of this class for arithmetic or two
  # numerical arguments representing the x and y coordinates of a vector respectively
  # For example: vector.add(vector2)  [or]  vector.add(3, 4)
  #
  # @param x [Number] x-coordinate
  # @param y [Number] y-coordinate
  ###
  constructor: (x, y) -> switch arguments.length
    when 1
      unless x instanceof Lampyridae.Vec2D
        throw new Error "Vec2D.constructor(1) requires a vector as an argument"
      @x = x.x ; @y = x.y ; return @
    when 2 then @x = x ? 0.0 ; @y = y ? 0.0 ; return @
    else throw new Error "Vec2D.constructor requires either 1 or 2 arguments"
  
  # Vector operations #
  
  ### Add another vector to this vector. ###
  add: (x, y) -> switch arguments.length
    when 1
      unless x instanceof Lampyridae.Vec2D
        throw new Error "Vec2D.add(1) requires a vector as an argument"
      @add x.x, x.y 
    when 2 then @x += x ; @y += y ; return @
    else throw new Error "Vec2D.add requires either 1 or 2 arguments"

  ### Return the angle (in radians) between the +x-axis and the vector coordinates. ###
  angle: () -> return Math.atan2 @y, @x

  ### Divide the vector components by a scalar parameter. ###
  ascale: (q) -> @x = @x / q ; @y = @y / q ; return @

  ### Copy the contents of another vector to this one. ###
  copy: (vec) -> @x = vec.x ; @y = vec.y ; return @

  ### Distance to another vector. ###
  distanceTo: (vec) -> return new Lampyridae.Vec2D(vec).subtract(@).length()

  ### Give the unit vector of the direction to another vector (new instance). ### 
  directionTo: (vec) -> return new Lampyridae.Vec2D(vec).subtract(@).unit()

  ### Divide another vector component-wise to this vector. ###
  divide: (x, y) -> switch arguments.length
    when 1
      unless x instanceof Lampyridae.Vec2D
        throw new Error "Vec2D.divide(1) requires a vector as an argument"
      @divide x.x, x.y 
    when 2 then @x = @x / x ; @y = @y / y ; return @
    else throw new Error "Vec2D.divide requires either 1 or 2 arguments"
  
  ### Return the dot product of the vector components. ###
  dot: () -> return @x * @x + @y * @y
 
  ### Return the length or magnitude of the vector. ### 
  length: () -> return Math.sqrt @dot()

  ### Multiply another vector component-wise to this vector. ###
  multiply: (x, y) -> switch arguments.length
    when 1
      unless x instanceof Lampyridae.Vec2D
        throw new Error "Vec2D.multiply(1) requires a vector as an argument"
      @multiply x.x, x.y 
    when 2 then @x = @x * x ; @y = @y * y ; return @
    else throw new Error "Vec2D.multiply requires either 1 or 2 arguments"

  ### Return a normal vector rotated 90 deg to the left; from x-axis anticlockwise. ###
  normalLeft: () -> @x = -@x ; return @

  ### Return a normal vector rotated 90 deg to the right; from x-axis clockwise. ###
  normalRight: () -> @y = -@y ; return @

  ### Return a vector rotated by the given angle in radians; from x-axis clockwise. ###
  rotate: (a) ->
    @x = @x*Math.cos(a) - @y*Math.sin(a) ; @y = @x*Math.sin(a) + @y*Math.cos(a) ; return @

  ### Multiply the vector components by a scalar parameter. ###
  scale: (q) -> @x = q * @x ; @y = q * @y ; return @

  ### Subtract another vector to this vector. ###
  subtract: (x, y) -> switch arguments.length
    when 1
      unless x instanceof Lampyridae.Vec2D
        throw new Error "Vec2D.subtract(1) requires a vector as an argument"
      @subtract x.x, x.y 
    when 2 then @x -= x ; @y -= y ; return @
    else throw new Error "Vec2D.subtract requires either 1 or 2 arguments"

  ### Turn the vector around. ###
  turnAround: () -> @x = -@x ; @y = -@y ; return @

  ### Return the unit vector. ###
  unit: () -> return @ascale @length()
# end class Lampyridae.Vec2D

module.exports = Lampyridae.Vec2D
