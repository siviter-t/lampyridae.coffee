# @file parameteric.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

class Lampyridae.Parametric
  ### Construct a N-dimensional parametric equation.
  #
  # @param dimension [Integer] Number of coordinates or parametric equations
  ###
  constructor: (dimension) ->
    @coord = [] ; @value = []
    @coord.push(@null) while @coord.length isnt dimension
    @value.push(0) while @value.length isnt dimension

  ### Set one of the coordinates to a parametric equation.
  # @param idx [Integer] Array index
  # @param equation [Function] Parametric equation
  ###
  setCoord: (idx, equation) =>
    if 0 <= idx <= @coord.length  
      if toString.call(equation) isnt '[object Function]'
        throw new Error "Parametric.setCoord requires a function as an equation"
      @coord[idx] = equation
    else throw new Error "Parametric.setCoord requires a valid index [i.e., 0..dimension]"

  ### Return an array of evaluated coordinates
  # @param args [...] Series of arguments to evaluate the coordinates
  ###
  eval: (args...) ->
    for idx in [0...@coord.length]
      @value[idx] = @coord[idx](args...)
    return @value 

  # Inbuilt parametric equations #
  
  ### Null parametric equation
  # @returns [Number] zero
  ###
  null: () => return 0
# end class Lampyridae.Parametric

module.exports = Lampyridae.Parametric
