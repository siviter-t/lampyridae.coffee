# @file cssify.coffee
# @Copyright (c) 2017 Taylor Siviter
# This source code is licensed under the MIT License.
# For full information, see the LICENSE file in the project root.

### Wraps numerical arrays into CSS colour coded strings
# Note: Each element will be parsed into a float.
#
# @param prefix [String] Code predix - e.g., 'rgb', 'rgba', or 'hsl'
# @param arr [Array] Numerical array
# @return [String] CSS colour string
###
Lampyridae.cssify = (prefix, arr) ->
  return prefix + '(' + arr.toString() + ')'
#end function Lampyridae.cssify

module.exports = Lampyridae.cssify
