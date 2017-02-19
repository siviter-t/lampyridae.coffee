# @file forces.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'maths/vec2d'

class Lampyridae.Forces
  ### A selection of predefined forces that can be added to Lampyridae.ForceParticle
  #
  # Note these are all written assuming that particles are contained within an array that
  # indexes each entity.
  ###

  ### Computational Parameters ###
  @G: 1.0  # Gravitational strength

  ### For cases where negligible or no force is experienced. ###
  @nullForce: () -> return new Lampyridae.Vec2D 0.0, 0.0
 
  ### Pairwise gravitational force of attraction of the ith particle to the jth
  #
  # The domain of interaction is limited to the radii of the particles (min distance apart)
  # and for maximum distance where the force F ~ 0.0005; i.e. when r = 44 * sqrt(G*mi*mj)
  # Note: the reverse force (i.e. jth to ith) could be added to the other jth particle.
  # Often however, this can be neglected if the ith particle is negligible in mass.
  #
  # @param parr [Array] The array that keeps track of a set of particles
  # @param i [Number] The index of the ith particle (where the force starts from)
  # @param j [Number] The index of the jth particle (where the force is directed to)
  ###
  @gravity: (parr, i, j) ->
    return parr[i].addForce () =>
      distance  = parr[i].pos.distanceTo ( parr[j].pos )
      massessq  = parr[i].mass * parr[j].mass
      limit     = 44 * Math.sqrt(@G * massessq)
      unless parr[i].r + parr[j].r < distance < limit then return @nullForce()
      direction = parr[i].pos.directionTo( parr[j].pos )
      strength  = @G * massessq / (distance * distance)
      return direction.scale(strength)
# end class Lampyridae.Forces

module.exports = Lampyridae.Forces
