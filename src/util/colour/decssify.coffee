# @file decssify.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

### Unwraps CSS colour code strings into an array.
# Note: Each element will be parsed into a float.
#
# @param str [String] CSS string
# @return [Array] Numerical array
###
Lampyridae.decssify = (str) ->
  str = str.replace(/[^\d,]/g, '').split ','
  for element,idx in str then str[idx] = parseFloat(element)
  return str
#end function Lampyridae.decssify

module.exports = Lampyridae.decssify
