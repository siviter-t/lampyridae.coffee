# @file firefly.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

require 'maths/rand'
require 'util/hslToRgb'

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
    options.vx = options.speed * Math.cos(options.theta)
    options.vy = options.speed * Math.sin(options.theta)
    options.radius ?= Lampyridae.rand @radiusMin, @radiusMax
    options.alpha ?= @opacity
    options.bound ?= @bound
    unless options.colour?
      c = Lampyridae.hslToRgb Lampyridae.rand(@hueMin, @hueMax), @saturation, @lightness
      options.colour = "rgb(#{c[0]}, #{c[1]}, #{c[2]})"
    super(canvas, options)
  
  ### Firefly class prototype parameters.
  # Can be set by the user; e.g. Lampyridae.Firefly::radiusMax = 50, etc.
  ###
  speedMin: 1.0
  speedMax: 1.5
  radiusMax: 3.0
  radiusMin: 0.8
  turningAngle: 0.1 * Math.PI
  hueMax: 123.55 # Green
  hueMin: 64.86 # Yellowy
  saturation: '100%'
  lightness: '50%'
  opacity: 0.8
  bound: "hard"
  enableAlpha: true
  
  ### Random turn; set turning angle to limit possibilities. ###
  randomTurn: () -> @turn @turningAngle * (2.0 * Math.random() - 1.0)
  
  ### Random walk with respect to the bounds of the canvas and draw the Firefly. ###
  update: () ->
    unless @applyBounds() then @randomTurn()
    @move()
    @draw()
# end class Lampyridae.Firefly

module.exports = Lampyridae.Firefly
