# @file paraparticle.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'maths/para2d'

class Lampyridae.Paraparticle extends Lampyridae.Particle
  ### Construct a N-dimensional parametric equation.
  #
  # @param dimension [Integer] Number of coordinates or parametric equations
  ###
  constructor: (canvas, options) ->
    @var = options.var ? 0
    @rate = options.rate ? 0.01
    @para = options.psys ? new Lampyridae.Para2D()
    super(canvas, options)
    @_P = new Lampyridae.Vec2D 0, 0
    @_P.copy @pos

  setVar: (v) -> @var = v
  setRate: (r) -> @rate = r
  setPos: (vec) -> @_P.copy(vec)

  update: (params...) ->
    @var += @rate * Lampyridae.timestep
    @pos.copy @para.eval(@var, params...)
    @pos.add @_P
    @draw()

module.exports = Lampyridae.Paraparticle
