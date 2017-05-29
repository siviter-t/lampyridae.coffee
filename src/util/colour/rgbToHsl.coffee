# @file rgbToHsl.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

### Converts RGB colour to HSL.
# Code adapted from:
# @see https://github.com/bgrins/TinyColor
#
# @param r [Number] Red [0, 255]
# @param g [Number] Green [0, 255]
# @param b [Number] Blue [0, 255]
# @return [Array] The HSL representation [0..360, 0..100, 0..100]
###
Lampyridae.rgbToHsl = (r, g, b) ->
  if arguments.length == 1 then b = r[2] ; g = r[1] ; r = r[0]

  r = parseFloat(r) / 255.0
  g = parseFloat(g) / 255.0
  b = parseFloat(b) / 255.0

  max = Math.max(r, g, b)
  min = Math.min(r, g, b)
  h = s = l = (max + min) / 2.0
  if max == min then h = s = 0
  else
    d = max - min
    s = if l > 0.5 then d / (2 - max - min) else d / (max + min)
    switch max
      when r then h = (g - b) / d + (if g < b then 6 else 0)
      when g then h = (b - r) / d + 2
      when b then h = (r - g) / d + 4
    h /= 6

  return [Math.round(360 * h), Math.round(100 * s), Math.round(100 * l)]
#end function Lampyridae.rgbToHsl

module.exports = Lampyridae.rgbToHsl
