# @file paraparticle.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'maths/para2d'

class Lampyridae.Paraparticle extends Lampyridae.Particle
  ### Construct a parametric equation obeying particle.
  #
  # @option var [Number] Independent variable
  # @option rate [Number] Rate of variable increment
  # @option para [Para2D] Parametric equations
  ###
  constructor: (canvas, options) ->
    @var = options.var ? 0
    @rate = options.rate ? 0.01
    @para = options.psys ? new Lampyridae.Para2D()
    super(canvas, options)
    @_P = new Lampyridae.Vec2D 0, 0
    @_P.copy @pos

  # Setters - TODO document/move to base #
  setVar: (v) -> @var = v
  setRate: (r) -> @rate = r
  setPos: (vec) -> @_P.copy(vec)

  ### Update the particle
  #
  # @param args [...] Optional parameters that define the parametric system
  ###
  update: (args...) ->
    @var += @rate * Lampyridae.timestep
    @pos.copy @para.eval(@var, args...)
    @pos.add @_P
    @draw()
#end class Lampyridae.Paraparticle

module.exports = Lampyridae.Paraparticle
