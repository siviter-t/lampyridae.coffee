# @file firefly.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'util/hslToRgb'
require 'util/rand'

class Lampyridae.Firefly extends Lampyridae.Particle
  ### Construct and manage a Lampyridae firefly 'particle'.
  #
  # @param canvas [Object] Instance of Lampyridae.Canvas to attach the firefly to
  #
  # @option x [Number] Position of the firefly along the x-axis
  # @option y [Number] Position of the firefly along the y-axis
  # @option theta [Number] Direction of the firefly (radians anticlockwise from the x-axis)
  # @option speed [Number] Speed of the firefly
  # @option radius [Number] Radius of the firefly
  # @option alpha [Number] Opacity of the firefly
  # @option colour [Array] RGB Colour code array of the firefly - e.g. "[r, g, b]"
  # @option bound [String] Type of bounding [none|hard|periodic]
  ###
  constructor: (canvas, options) ->
    options ?= {}
    options.x ?= Lampyridae.rand 0, canvas.width() 
    options.y ?= Lampyridae.rand 0, canvas.height()
    options.speed ?= Lampyridae.rand @speedMin, @speedMax
    options.theta ?= Lampyridae.rand 0.0, Lampyridae.PIx2
    options.radius ?= Lampyridae.rand @radiusMin, @radiusMax
    options.alpha ?= @opacity
    options.bound ?= @bound
    unless options.colour?
      c = Lampyridae.hslToRgb Lampyridae.rand(@hueMin, @hueMax), @saturation, @lightness
      options.colour = "rgb(#{c[0]}, #{c[1]}, #{c[2]})"
    super(canvas, options)
  
  ### Firefly class prototype parameters.
  # Can be set by the user to whatever they wish; e.g. Lampyridae.Bug::radiusMax = 50, etc.
  ###
  speedMin: 1
  speedMax: 7
  radiusMax: 3.0
  radiusMin: 0.5
  turningAngle: 0.1 * Math.PI
  hueMax: 102.72 # Light green colour
  hueMin: 65.28 # Yellowy colour
  saturation: '100%'
  lightness: '50%'
  opacity: 0.8
  bound: "hard"
  
  randomTurn: () -> @turn @turningAngle * (2.0 * Math.random() - 1.0)
  
  fly: () ->
    unless @applyBounds() then @randomTurn()
    @move()
  
  update: () ->
    @fly()
    @draw()
  
  draw: () ->
    @canvas.draw.begin()
    @canvas.draw.setGlobalAlpha @alpha
    if Lampyridae.enableSimpleGlow
      @canvas.draw.glow 2.0 * @r, @colour
    @canvas.draw.circle @x, @y, @r
    @canvas.draw.fill @colour
    @canvas.draw.end()
# end class Lampyridae.Firefly

module.exports = Lampyridae.Firefly