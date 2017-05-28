# @file para2d.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'maths/vec2d'
require 'maths/parametric'

class Lampyridae.Para2D
  ### Construct a two-dimensional parametric equation.
  # This is a helper class that automatically packages results as vectors
  # @param x [Function] Parametric equation for the 1st or x-coordinate
  # @param y [Function] Parametric equation for the 2nd or y-coordinate
  ###
  constructor: (x, y) ->
    @psys = new Lampyridae.Parametric(2)
    if x? then @psys.setCoord(0, x)
    if y? then @psys.setCoord(1, y)

  ### Return a Lampyridae Vector of the 2D-coordinates
  # @param args [...] Series of arguments to evaluate the coordinates
  ###
  eval: (args...) ->
    xy = @psys.eval(args...)
    return new Lampyridae.Vec2D xy[0], xy[1] 
# end class Lampyridae.Para2D

module.exports = Lampyridae.Para2D
