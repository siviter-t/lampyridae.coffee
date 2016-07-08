# @file hslToRgb.coffee
# @Copyright (c) 2016 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

### Converts HSL colour to RGB.
# Code adapted from:
# @see https://github.com/bgrins/TinyColor
# @see http://serennu.com/colour/rgbtohsl.php
#
# @param h [Number] The hue [0, 360]
# @param s [Number] The saturation [0, 100]%
# @param l [Number] The lightness [0, 100]%
# @return [Array] The RGB representation [0, 255]
###
Lampyridae.hslToRgb = (h, s, l) ->
  h = parseFloat(h) / 360.0;
  s = parseFloat(s) / 100.0;
  l = parseFloat(l) / 100.0;
  
  if s == 0 then r = g = b = l
  else
    hue2rgb = (p, q, t) ->
      if t < 0 then t += 1
      if t > 1 then t -= 1
      if t < 0.5 then return q
      if t < 1 / 6 then return p + (q - p) * 6.0 * t
      if t < 2 / 3 then return p + (q - p) * (4 - 6.0 * t)
      return p
    
    q = if l < 0.5 then l * (1 + s) else l + s - (l * s)
    p = 2 * l - q
    r = hue2rgb(p, q, h + 1 / 3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1 / 3)
  
  return [255 * r, 255 * g, 255 * b]
# end function Lampyridae.hslToRgb